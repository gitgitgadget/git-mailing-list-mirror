From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: format-patch to diff-tree change breaks binary patches
Date: Wed, 07 May 2014 10:27:14 -0700
Message-ID: <xmqqtx91bitp.fsf@gitster.dls.corp.google.com>
References: <20140507054854.GA3571@olive>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cdleonard@gmail.com, pw@padd.com
To: Tolga Ceylan <tolga.ceylan@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 19:27:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi5cq-0008EI-RV
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 19:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbaEGR1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 13:27:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60207 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbaEGR1T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 13:27:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 01A4A1447E;
	Wed,  7 May 2014 13:27:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C8n9rA5ZT6fWxDO2/jljwXi4CwE=; b=vl4+xX
	tqI1f2pMLS4tgEepWXkF2z4NKVBFI+uifkk/cxpk1s4F+uGV5jNXOZyXItMyFkPE
	Q++kxCLgadaMsMRtxcv28UOVAXFMy4LH/Ibyf86HKMUEC7ZRqYiQGWsJHfbVQaA5
	90/Llxt1Z+zUp7ZEwZZGvOF1+zNFe3V/UtJEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BY+5QLKnefc82tqndheEvdcNETbw1Xus
	zxJKLc7sZyOnbFtPdH9pvFriqtVeOcG/BVjdDuaprf9zJ6u70DtxHMsRiowFpt8V
	XGuhxYOORUZ3imbDKP85f9jZIe4uCLEJBohGQiCfNgmwnON5JngDpUS+Mqu3Olv+
	viiUjdvWk/U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E68DB1447D;
	Wed,  7 May 2014 13:27:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 14E0014476;
	Wed,  7 May 2014 13:27:16 -0400 (EDT)
In-Reply-To: <20140507054854.GA3571@olive> (Tolga Ceylan's message of "Tue, 6
	May 2014 22:48:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D57E26A4-D60C-11E3-9591-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248333>

Tolga Ceylan <tolga.ceylan@gmail.com> writes:

> When applying binary patches a full index is required. format-patch
> already handles this, but diff-tree needs '--full-index' argument
> to always output full index. When git-p4 runs git-apply to test
> the patch, git-apply rejects the patch due to abbreviated blob
> object names. This is the error message git-apply emits in this
> case:
>
> error: cannot apply binary patch to '<filename>' without full index line
> error: <filename>: patch does not apply
>
> Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
> Acked-by: Pete Wyckoff <pw@padd.com>
> ---

Because the original breakage was already in 1.9, not a regression
between 1.9 and master, as the matter of principle our default is to
defer until 2.0 final to avoid risking unintended additional
breakages elsewhere.  But this fix is an obviously correct and
trivial single liner that were eyeballed by more than one person,
and that affects only three calls to os.system(), and its
correctness can be seen even without knowing p4 at all by somebody
like me ;-)

So let's queue it for 2.0.

Thanks.

>  git-p4.py |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index cdfa2df..4ee6739 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1311,7 +1311,7 @@ class P4Submit(Command, P4UserMap):
>              else:
>                  die("unknown modifier %s for %s" % (modifier, path))
>  
> -        diffcmd = "git diff-tree -p \"%s\"" % (id)
> +        diffcmd = "git diff-tree --full-index -p \"%s\"" % (id)
>          patchcmd = diffcmd + " | git apply "
>          tryPatchCmd = patchcmd + "--check -"
>          applyPatchCmd = patchcmd + "--check --apply -"
