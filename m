From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Fri, 11 Jan 2013 11:27:44 -0800
Message-ID: <7vmwwfbjv3.fsf@alter.siamese.dyndns.org>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
 <7va9sfd6lk.fsf@alter.siamese.dyndns.org>
 <20130111185818.GA30398@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Fri Jan 11 20:28:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtkGy-0004tN-WC
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 20:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230Ab3AKT1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 14:27:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55988 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679Ab3AKT1r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 14:27:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26885AC6B;
	Fri, 11 Jan 2013 14:27:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9Di/x+4RI163v4jaYloaYOgOyng=; b=RPRmqW
	7DLG4AOcRtXpMZcRsvsf75kAL91C5ib2zL6zv6b71K+w/PFAo1rly0Icsd7Pc4pM
	uXpA8wNVEaLQyZBaXi60yU4v38q5Yu4SuYFKJbSzSLtK/ZZJvg+OV+O3RKqq4oSi
	OHus1CiZ0zLFpNuM8P3eWUgyi0o8vhkK5PynU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uWMugPZP3SYYaD0st2Fh2kXrw1nqGk1Z
	zIy57PwekmfDsFrWFvMHpSBIh3wWAF3EsUMFilAzbA85mtOItjbj6CGyv1zuvSYs
	+H40h1pWcwQwuf5a8zxz3PPnO7yMDvnEgxL/J4YXd9Z1icwll0VlA3IECgdfWDlM
	XVFlJUljjYY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AA72AC68;
	Fri, 11 Jan 2013 14:27:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77E8EAC65; Fri, 11 Jan 2013
 14:27:46 -0500 (EST)
In-Reply-To: <20130111185818.GA30398@thyrsus.com> (Eric S. Raymond's message
 of "Fri, 11 Jan 2013 13:58:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA7375BC-5C24-11E2-B491-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213237>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Junio C Hamano <gitster@pobox.com>:
> ...
> The other is a design-level problem - these options were a bad idea to
> begin with.  In earlier list mail I said
>
>     An example of the batchiness mistake close to home is the -m and -M
>     options in the old version of cvsimport.  It takes human judgment
>     looking at the whole commit DAG in gitspace to decide what merge
>     points would best express the (as you say, sometimes ambiguous) CVS
>     history - what's needed is a scalpel and sutures in a surgeon's hand,
>     not a regexp hammer.
>
> One specific problem with the regexp hammer is false-positive matches
> leading to unintended merges.

Yeah, it is OK to _discourage_ its use, but to me it looks like that
the above is a fairly subjective policy decision, not something I
should let you impose on the users of the old cvsimport, which you
do not seem to even treat as your users.

>> Having the code to die when it sees options the rewritten version
>> does not yet support before it calls the fallback makes the fallback
>> much less effective, no?
>
> Only to the extent that -o/-m/-M are really important, which I doubt.
> But that might be fixable, and I'll put it on the to-do list.
>
>> Not very impressed (yet).  The advertised "fix major bugs" sounds
>> more like "trade major bugs with different ones with a couple of
>> feature removals" at this point.
>
> If you think that, you have failed to understand just how broken and
> dangerous the old combination is.  None of the details you've called
> out are "major" by any stretch of the imagination compared to it
> silently botching the translation of repositories.

The "major" in my sentence was from your description (the bugs you
fixed), and not about the new ones you still have in this draft.  I
did not mean to say that you are trading fixes to "major" bugs with
different "major" bugs.

Insecure quoting of parameters is much easier to fix; it does need
to be addressed, though.

It is just that looking at the state of the patch as submitted left
me with a feeling that this topic needs a lot more time to mature
than I previously was led to believe by your earlier messages, which
made me someaht sad.
