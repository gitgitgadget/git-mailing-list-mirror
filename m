From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] make rebase abort to original branch, not rebased branch
Date: Sat, 12 Mar 2011 23:46:41 -0800
Message-ID: <7v8vwjihsu.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.1103122253560.15442@debian>
 <7vmxkzijpt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 08:46:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pyg0u-00042U-KG
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 08:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783Ab1CMHqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 03:46:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab1CMHqu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 03:46:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3EDCE2476;
	Sun, 13 Mar 2011 03:48:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L5djyPT5zG442iRZbI8S9OQqjAE=; b=qutR7H
	mM04/WWBF3xGSVZo/V/16bsO6afazZnW57zdtTdT5TV57gd7mBwz9k9ZYjGaBnA+
	wmBrxBeKVFd/ELb/IzRiorNVD4JGp31fkdruHMi1YT006cWRspYoGnrwg6gws9EH
	jjWuMU/Ky1uiQgPZyF6RyykPw1cK+Ck/5xufg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p3yovyJGF93cjosCLeQNHI03zk+fsiWe
	PU6beKbCepXBwBajSCIxkRlsTOc9NWuPrFPcakWxY81OUf5HFCiZxODU/+VmobCe
	Nmyd4TLGiCRen4cXuP7CNkeTT6on7Rqjm+UrMD7TeBX8yuSvFZiMYDDfXisRFJ0U
	jJC3/M4pjpI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1CB762475;
	Sun, 13 Mar 2011 03:48:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1E8E22474; Sun, 13 Mar 2011
 03:48:14 -0400 (EDT)
In-Reply-To: <7vmxkzijpt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 12 Mar 2011 23:05:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42882D9C-4D46-11E0-83A4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168964>

Junio C Hamano <gitster@pobox.com> writes:

>> Are there valid cases where the current behavior is bettter?
> ...
> I don't particularly like the "when aborted it returns to the original
> location" behaviour even for a single argument "git rebase A" case (I do
> deeply care about the tip of the branch that you attempted to rebase _is_
> set back to the original state, but I don't care deeply on which branch
> you would end up on myself), but because "git rebase A B" is a shorthand
> for "git checkout B; git rebase A" (at least that is how I view it
> myself), I would imagine that it would be more surprising to switch back
> to the branch you were on which may not have anything to do with A nor B.
>
> At least going back to B conceptually makes more sense in one use case I
> have, which was the original reason I invented rebase with the "checkout B
> and rebase it ono A" shorthand in the first place (see 59e6b23), back when
> I was an active contributor throwing patches at Linus (note that back then
> I didn't have "abort then go back" in the code--and that is why I don't
> care too deeply about this "which branch should I be after aborting?"
> myself).
> ...

Having said all that, my opinion would be very different if the definition
of "git rebase A B" were different.  I can imagine that some people may be
tempted to (mis)understand the form of the command as a way to "rebase B
on top of A, even though I am doing something unrelated to B (my work may
or may not be related to A), because I need to help somebody who wants to
have an access to an updated B _now_, and I'll continue what I am doing
(which is not related to B) after I am done rebasing".

Actually, I would not say that such a workflow is unreasonable.

And for people who want such a workflow out of "rebase A B", it would be a
bug that the command does not to come back to your original branch when it
finishes rebasing B on top of A, and it would equally be a bug when it
stops with a conflict and you tell it to abort. In _both_ cases, you would
want to come back to the branch you started from.

But "git rebase A B" after successful completion does not come back to
your original branch (it stays on B), because the current semantics of the
command is not about supporting such a workflow.
