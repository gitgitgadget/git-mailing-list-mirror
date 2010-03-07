From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/7] revert: add --ff option to allow fast forward
 when cherry-picking
Date: Sun, 07 Mar 2010 01:05:04 -0800
Message-ID: <7vy6i4zem7.fsf@alter.siamese.dyndns.org>
References: <20100306203250.2960.30309.chriscool@tuxfamily.org>
 <20100306203447.2960.42019.chriscool@tuxfamily.org>
 <7v6358dbv8.fsf@alter.siamese.dyndns.org> <4B936500.9020005@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Mar 07 10:06:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoCR4-0008KR-3G
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 10:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab0CGJFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 04:05:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab0CGJF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 04:05:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4E939F8E1;
	Sun,  7 Mar 2010 04:05:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=OUkPk4IS6LHLNrMx608wQ13UExg=; b=UaEVj9DJpNzUWrP7DR2vkVO
	SLpeXDtqntZqioiqUSib+KGDus+Q6aK7jehQ9S4zVsoH548wiiJyjQSnenAaZcko
	+2pknRVVCPxREIyFSOeH0iTJUGFJcRNMpsb7TX402Ws9fbUrcTDUi+P2uuUeFSrX
	aihRguTKwjnNEl0W5nkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=lYASX0BaWnYAIKNPWlh0w8TMnFKRDK9EwEOJ/ATwKWJBAgrpZ
	RJu4LmzDLbQQA52mMsAmFp1BU/mENrSKmhL9Kv3gequtt4sWMF93A455xeyDmfRH
	wZIaU1Xu0h9TOWoKPgr2PCiLq8onGK7PKuT6onxjTA1Aq3h1KuE2FTfU4c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D5EF9F8DE;
	Sun,  7 Mar 2010 04:05:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D8429F8DD; Sun,  7 Mar
 2010 04:05:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B5526EE-29C8-11DF-B3E9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141674>

Paolo Bonzini <bonzini@gnu.org> writes:

> On 03/07/2010 04:55 AM, Junio C Hamano wrote:
>> What was the real motive/use case of "cherry-pick --ff"?
>
> Avoiding pointless separation of histories.  It's true that nowadays
> git-patch-id will make a good job of reconciling them, but they do
> look ugly in gitk.

Sorry, but that is a not-very-useful XY answer.

Why were _you_ using "cherry-pick" on a commit that is an immediate child
of the current commit?  What were you trying to achieve by blindly using
cherry-pick even in such a case?

I am sort-of guessing that "blindly" is coming from a script that doesn't
bother to check if the commit you are cherry-picking is a direct child,
and I do not think it is such a bad thing to allow scripts to blindly call
cherry-pick that way and at the same time avoid making cherry-picked
commits that are unnecessary.  So in that sense I am not opposed to having
an option to allow "--ff".

But if that is the real motivation, then making --ff default is a wrong
thing to do, as existing scripts knew and trusted cherry-pick will _not_
fast-forward, and the ones that do want fast-forward have already checked
just like "rebase -i" does.  Changing the default like Chriscool suggested
would not help anybody.

That is what I wanted to find out.
