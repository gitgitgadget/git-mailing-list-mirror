From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jk/tag-contains: stalled
Date: Thu, 05 Aug 2010 11:47:09 -0700
Message-ID: <7vy6ckdhhu.fsf@alter.siamese.dyndns.org>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
 <20100805001629.GC2901@thunk.org> <7vsk2tdnv5.fsf@alter.siamese.dyndns.org>
 <7vhbj9dm6h.fsf@alter.siamese.dyndns.org> <20100805173635.GA15760@sigill>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Ts'o <tytso@mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 05 20:47:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh5TT-0006Db-SB
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 20:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293Ab0HESrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 14:47:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab0HESrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 14:47:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71FDACBAC4;
	Thu,  5 Aug 2010 14:47:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KFQH2R6vj8JDvRWNuCQQiS31vXQ=; b=S/woNH
	C2WYDFgPvJsv1ARGIlQjY/mGblsq4oKKMiTMq8ALwAExpymwhyOUXmNIWmP4lj+K
	vOiuiY/4HG4GYlX/nDIdkLQ0rF7iQh5126BQVL8n0ha2ClhYxLp4Tcv3wZK9SO8v
	XDGGKZwdExPut/vGyWeTrS9dhEbetTn9v6cX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t3PKk0FHNvW49ycK4Om1PqZ82jiBRy5P
	6Dz/67LeYtstnzBUVANsHNeswvMStdeACH4jPHba5T+eGhk9v4APbQuco64zDe5s
	he8dwoxtNmZ+eizfG33ZCvZHMWteNaRENtkLhn+mEf+eDBHiVS73VbyrpaQqmj6/
	FCIes9qL9T8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B99ECBAC3;
	Thu,  5 Aug 2010 14:47:15 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D7E4CBAC2; Thu,  5 Aug
 2010 14:47:11 -0400 (EDT)
In-Reply-To: <20100805173635.GA15760@sigill> (Jeff King's message of "Thu\, 5
 Aug 2010 13\:36\:36 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DDA5CED8-A0C1-11DF-8D63-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152701>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 05, 2010 at 10:05:58AM -0700, Junio C Hamano wrote:
>
>> >>> * jk/tag-contains (2010-07-05) 4 commits
>> >>>  - Why is "git tag --contains" so slow?
>> >>>  - default core.clockskew variable to one day
>> >>>  - limit "contains" traversals based on commit timestamp
>> >>>  - tag: speed up --contains calculation
>> [...]
>> > I agree in principle; the log messages need to be cleaned up first
>> > at the least, though.
>> 
>> To reduce the risk of double-work, I need to clarify.
>> 
>> I meant to say that I can find enough material, especially what Peff
>> wrote, in the discussion that followed in the thread to do the clean-up
>> myself.  No need to resend by anybody unless there are material
>> differences from what have been discussed so far that need to be
>> incorporated in the final series.
>
> The only bad log message should be the final one, which should be
> dropped anyway. I would recommend just merging the first two for now,
> and Ted can tweak his core.clockskew manually.

After re-reviewing the one that is queued, the use of TMP_MARK smelled
somewhat bad to me.  It is named TMP_ exactly because it is meant to be
used in a closed callpath---you can use it but you are supposed to clean
it before you return the control to the caller, so that the caller can
rely on TMP_MARK absent from any objects.

Use of UNINTERESTING is similarly not kosher if this were to be used in
larger context outside of "do 'tags --contains' and exit".  You noted
these two points in your original RFC patch.

Besides, "contains()" is too generic a name to live in commit.h.

My gut feeling is that it is probably Ok if contains() and its recursive
helper are moved to builtin/tag.c and are made static, to make it clear
that this should not be reused outside the current context as a generic
"contains" function.  It would probably help to have a comment at the end
of list_tags() to say that TMP_MARK _ought_ to be cleaned before leaving
the function but we don't do that because we know it is the last function
in the callchain before we exit.

By the way, I wonder why pop_most_recent_commit() with a commit_list,
which is the usual revision traversal ingredient for doing something like
this, was not used in the patch, though.  Is it because depth-first was
necessary?
