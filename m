From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/3] replace: add --graft option
Date: Fri, 23 May 2014 13:05:40 -0700
Message-ID: <xmqqlhtsi7l7.fsf@gitster.dls.corp.google.com>
References: <20140522211836.27162.80311.chriscool@tuxfamily.org>
	<20140522213307.27162.14455.chriscool@tuxfamily.org>
	<20140523195153.GB19088@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 23 22:05:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnviw-00013j-Q3
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 22:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbaEWUFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 16:05:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60570 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbaEWUFq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 16:05:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAB1519290;
	Fri, 23 May 2014 16:05:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P4MxHEvDCt6hIE+9Y+fMMPy9I54=; b=wFo5xP
	sG5Vsc9UbtS25Hg8lsUK7iHcHVnZ8LQWvl5KKUcElxmdGB55WtFy9eETOp2HVUH1
	27+tYSPKb0wwGiPlnENaa+pS7Ml/LEwyIi+UeslE32yM6+tBGQOzbCZp+KXQDxdw
	7ZuYZMJY7cNwKkyTADYy+zSrABbvBQCb6hsRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pOwlOw08Ic4Vi6YcC5lnQisk9iGdsofh
	2JAt3FyIN4OypuySfYlFcOBW4IK1j9lw9assGM1PWwmZ8N2RWZ/o17eIfyRA+iis
	tWR+/t07BL9Nzzh+Cwc27EYx8ZvxK15fIihon3yLVyXd7WiksJgglE08h6QQS4Mj
	nzP+7HPt3jM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D13A91928F;
	Fri, 23 May 2014 16:05:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 807221928A;
	Fri, 23 May 2014 16:05:42 -0400 (EDT)
In-Reply-To: <20140523195153.GB19088@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 23 May 2014 15:51:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9E610C94-E2B5-11E3-8755-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250023>

Jeff King <peff@peff.net> writes:

> On Thu, May 22, 2014 at 11:33:04PM +0200, Christian Couder wrote:
>
>> The usage string for this option is:
>> 
>> git replace [-f] --graft <commit> [<parent>...]
>> 
>> First we create a new commit that is the same as <commit>
>> except that its parents are [<parents>...]
>> 
>> Then we create a replace ref that replace <commit> with
>> the commit we just created.
>> 
>> With this new option, it should be straightforward to
>> convert grafts to replace refs, with something like:
>> 
>> cat .git/info/grafts | while read line
>> do git replace --graft $line; done
>
> I think this script at the end should end up in the documentation or a
> contrib script (probably the former, as it is short enough that somebody
> might just cut-and-paste).
>
> The graft file ignores comments and blank lines, so maybe "grep '^[^#]'"
> would be in order.
>
> And maybe it's just me, but I think spacing it like:
>
>   grep '^[^#]' .git/info/grafts |
>   while read line; do
> 	git replace --graft $line
>   done
>
> is more readable (I think some would even argue for putting the "do" on
> a separate line).

Yes, I would ;-)

I just read read_graft_line(); it allows an empty line (both
length-0 before the terminating LF or CRLF, and a line with
isspace() only) and ignore them, so "grep '^[^#]'" is not
sufficient.

>> +	/* make sure the commit is not corrupt */
>> +	if (parse_commit_buffer(commit, buf.buf, buf.len))
>> +		die(_("Could not parse commit: '%s'"), old_ref);
>
> I guess the checks here are sufficient to make...
>
>> +	/* find existing parents */
>> +	parent_start = buf.buf;
>> +	parent_start += 46; /* "tree " + "hex sha1" + "\n" */
>> +	parent_end = parent_start;
>> +
>> +	while (starts_with(parent_end, "parent "))
>> +		parent_end += 48; /* "parent " + "hex sha1" + "\n" */
>
> ...this number-based parsing safe, though it would miss removing a stray
> parent line elsewhere in the commit. It still feels rather magical to
> me, as we are depending on unspoken format guarantees defined inside
> parse_commit_buffer.

Do you mean "we have a carved-in-stone rule that all 'parent ' lines
must come immediately after a single 'tree ' line, and that is
implemented in parse_commit_buffer().  The above code follows the
exact same rule.  It would be nice to have some mechanism to tell
somebody who wants to update the former that s/he must update this
new code at the same time"?

I think a commit object that violates the rule is simply broken, and
it is OK to add a mode to tell parse-commit-buffer to tolerate such
a broken object, if only so that filter-branch or some other tools
can be used to correct a history that contains it.

Perhaps a more future-proof way to write Christian's code may be:

    - find "tree ";

    - splice the new parents in immediately after that "tree " line;

    - starting from the end of these new parents, scan up to the end
      of the header line-by-line, and splice out any line that
      begins with "parent ".

which may not be too bad.
