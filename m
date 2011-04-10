From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase --continue automatic --skip?
Date: Sat, 09 Apr 2011 18:33:43 -0700
Message-ID: <7vr59ayjns.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=Vc6kB5fvZrqMwDD+yHFb5qENQ8g@mail.gmail.com>
 <20110409000351.GA7445@sigill.intra.peff.net>
 <20110409130309.GC30820@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, skillzero@gmail.com,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 10 03:34:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8jXU-0004oo-1h
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 03:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794Ab1DJBeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 21:34:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38767 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab1DJBeB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 21:34:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED07642D3;
	Sat,  9 Apr 2011 21:35:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ggQ7/mtqpBTgLBxhyBx8HAhmPrE=; b=rcsne9
	7GL3BNnIcN1v+GI7UbTfLC7rHsmCCGkqs5hZtzWb9RufZWZMaKrBKVhzMTfHGjnR
	/Zon7cqb2oYUN1E3D4F7PrNQYYNSYSFIDxfz6b7bWTSJP4ofMg+AiPPUh0MDN62B
	JHlSaqceQR6yfKcKeLvJd6IzsLFYic02bj6pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xX19nzaS6MxjRpvvS4cSIHW/LkjXy8RJ
	pZzomfE7B5uckK8z/mJ5prO7Kh0AxG+8M/13zcGhBBCl1uObm2bkN6vBmyU06mOc
	M8foHMZ1PFPD/6A52l22aRMsuTT7y7lYYqV5At09p82fWvLaXvqII30SO3REZyZA
	PLfjtC/4H3Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B53F42D2;
	Sat,  9 Apr 2011 21:35:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0E7F642D1; Sat,  9 Apr 2011
 21:35:41 -0400 (EDT)
In-Reply-To: <20110409130309.GC30820@m62s10.vlinux.de> (Peter Baumann's
 message of "Sat, 9 Apr 2011 15:03:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCC3D74E-6312-11E0-8C2A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171231>

Peter Baumann <waste.manager@gmx.de> writes:

> This was mentioned before on the list (sorry, don't have a reference, 
> but it was a long time ago). AFAIR the reason it wasn't implemented yet is that
> you will lose the commit message, which might contain precious information.

I don't recall ever seeing that justification; and I don't agree with it
either.  As far as the resulting history is concerned, that commit does
not even exist and there is no precious information.

This is a tangent, but I suspect that in the very old days, after a "git
rebase" stopped due to a conflict to have you adjust the change by
resolving conflicts, "git rebase --continue" may have offered you an
opportunity to edit the commit log message so that you can record what was
made unnecessary (or made additionally necessary) compared to the original
patch due to rebasing.  I don't offhand know when we lost that feature (it
is possible we never had anything like that and I am misremembering
things).

We may probably want to add it at least as an optional feature.  After
"git rebase" stops due to a conflict, and your resolution ends up to be
not an empty change, "git rebase --continue" seems to simply reuse the
original description these days.  It might be a good default, but in cases
where the conflict resolution made the change very different from the
original, the old log message may not describe why the change was needed
and how the change solved that issue properly in the context of the new
history.

"git commit -a -c .git/rebase-apply/original-commit" followed by "git
rebase --skip" is a workaround that is too ugly to be called "workable"
for it.  Perhaps "git rebase --edit --continue" or something?
