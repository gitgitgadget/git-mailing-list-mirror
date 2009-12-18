From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Let format-patch and rebase ignore trivial merges.
Date: Fri, 18 Dec 2009 10:23:08 -0800
Message-ID: <7vy6l0xhtf.fsf@alter.siamese.dyndns.org>
References: <20091216164553.GA22471@pcpool00.mathematik.uni-freiburg.de>
 <4B29106C.1040501@viscovery.net> <7vaaxhfcfe.fsf@alter.siamese.dyndns.org>
 <20091218151102.GB7211@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Fri Dec 18 19:23:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLhU8-0000rj-IX
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 19:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbZLRSXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 13:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbZLRSXV
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 13:23:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932490AbZLRSXU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 13:23:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DAD5589A3A;
	Fri, 18 Dec 2009 13:23:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mRwIqgEM9RfRdKOaWPVw7MU2zMU=; b=ni5xcd
	eg2weXuJgz+GjFLtaUCulng1FOy9PCDvD2yRq8mTg0FU5/EidGF1axxr4fuMIMhx
	NtWQa6JxhBfPynoMsrDDiKKznBWiRl26GmvCQJr17N6btr7Vb+A9njbkFYPHr9qt
	0GJcBX7RxGXDZOiiFzCgETbsDbUvtTwqrB1tE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ya6Uyp/LefhlOhIoCw325in2AByjhTVy
	x/uwxQkbJF5s6fRnre4Kn8Vk88YRtVIPRviDhIVwRUJnvvHqY9f0dHf8w9Wmdac8
	u2sWjEujE8D1nue8Aw2vTdJj8F5eeHo5InhQt6SvWh06dr/km0XygMYIrJz1Fool
	NgjFuJO568o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A4E7789A34;
	Fri, 18 Dec 2009 13:23:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D465989A2E; Fri, 18 Dec
 2009 13:23:09 -0500 (EST)
In-Reply-To: <20091218151102.GB7211@pcpool00.mathematik.uni-freiburg.de>
 (Bernhard R. Link's message of "Fri\, 18 Dec 2009 16\:11\:02 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6763BF10-EC02-11DE-A5B6-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135425>

"Bernhard R. Link" <brlink@debian.org> writes:

[offtopic: weren't you already asked not to try redirecting away direct
responses to you by using M-F-T and wasting time of people who do want to
respond directly to you?  Please don't.]

> As git rebase and git format-patch linearize commits,
> having the same change in different branches causes in the
> best case duplicate patches in the produced series and in the
> worst case conflicts. If there are trivial merges involved
> (i.e. merges that do not change the tree), then this patch
> will cause git to only look at one branch, thereby avoiding
> duplicates and reducing the chance of conflicts.

The patch text itself from the cursory review looks Ok (I haven't thought
things through yet, let alone applying it, though).

One issue in the proposed commit log message above is that "trivial merge"
is an established technical term that means something very different from
"resulting tree of the merge matches exactly one of the parents' tree",
and it needs to be reworded.  In this case it is easy [*1*].  Drop
everything after "If there are ...", and add something like this as a
separate paragraph:

    Avoid outputting duplicate patches by ignoring all other parents when
    the merge result matches exactly one of the parents.

The code comment also needs to be adjusted.

Thanks.

[Footnote]

*1* It is a good habit to acquire to question yourself if you can omit "X"
altogether and just say "Y" after writing "X (i.e. Y)".
