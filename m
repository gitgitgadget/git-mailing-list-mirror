From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Sat, 27 Feb 2010 13:51:56 -0800
Message-ID: <7vr5o6s5xf.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de>
 <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Sat Feb 27 22:52:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlUa7-0002jw-Bg
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 22:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936301Ab0B0VwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 16:52:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936298Ab0B0VwH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 16:52:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DF429DE47;
	Sat, 27 Feb 2010 16:52:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xg0Wmg/VqiZLiPyytpbGiyAebhw=; b=OIRQbs
	o50NgVyfolmg3QFW8ntmgp5jfnh+HRuW+AORE1Wll71wLyB1pswVADHu+GSWR74G
	4d6S5sEr52wI5K5s6erngZyknutt4oNo+3jJcGY5B1zfFtKoWf6DTDs3q3ZLKyvY
	wtwg3kxqg0s/kLjY5QreGcpK6Rd13pSLFT0Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q8pZL3wMUwOkK0RKpe0slJnKPTrCKDe4
	PoBAnNKX7r5g6pYiBXRhIDP8FgSd9Zqre0XG3+ElFQoXOawUw/9XFDjFdHCGGuBY
	Q+Vhc1rF151ecNWtChkikDoXj+P8TY4Q2LtNfpDqSCnjGhAFoxhhXxiBE/b2kUaJ
	Cwjwp7k5dHk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 052AA9DE45;
	Sat, 27 Feb 2010 16:52:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40B459DE43; Sat, 27 Feb
 2010 16:51:58 -0500 (EST)
In-Reply-To: <4B898F97.90706@web.de> (Markus Elfring's message of "Sat\, 27
 Feb 2010 22\:33\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 559645F8-23EA-11DF-BB24-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141232>

Markus Elfring <Markus.Elfring@web.de> writes:

>> If you are starting from "if your work tree is dirty, you MUST stash
>> before checking out another branch", the suggestion is understandable.
>> But the thing is, that starting point is not quite correct.
> ...
> When will it not be needed to reset the work tree to the last corresponding commit?

A response to a month old message is a blast from the past ;-).

The answer is "almost always" for me.  IOW, if checkout stashed away my
local changes, it would be very inconvenient.

It is important to understand that a local change does not belong to your
current branch (it does not belong to _any_ branch).  It belongs to you,
and you can take it around while switching between branches.  And that is
a big time-saving feature.

This lets you work like this:

 - You are reading a mailing list message that asks for help, and you know
   the solution---you can give the help real quick.

 - You hack in whatever branch that happen to be checked out.  The change
   is perfect, it works.

 - The branch you happen to have checked out was 'next', but the solution
   is a bugfix, and should go to 'maint'.

Now, at this point, you want to checkout 'maint' without losing your local
change.  The paths you touched with your quick fix are often not different
between the two branches, and "checkout maint" will checkout the branch
while keeping your local changes intact.  All that is left for you to do
is to run another round of test to make sure that your fix didn't depend
on anything not in 'maint' and commit the change with appropriate log
message, and then you can go back to whatever you were doing with
"checkout next".

When the change involves paths that were touched between 'maint' and
'next', of course you won't be able to switch without merging the local
change to the difference between 'next' and 'maint'.  There are a few
workflows to deal with such a case, and the easiest is "checkout -m", if
you are confident that you can resolve it.

In a case where "checkout -m" would result in a conflict too big to
resolve, the original fix you made would not be applicable to 'maint'
(iow, you should have solved it differently starting from 'maint'), and
you may end up doing "reset --hard" and start from scratch, but that is a
rare worst case.

I said it is rare, because you would notice, while doing the "quick fix"
based on 'next' codebase, that the code you are touching have changed
since 'maint' and won't be applicable to its final destination (by that
time you know you are "fixing"), and you won't waste too much time
continuing to work in a checkout of 'next'.
