From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC v2 08/19] rebase -i: Root commits are replayed with an unnecessary option
Date: Tue, 08 Jul 2014 15:32:23 -0700
Message-ID: <xmqqzjgj7a88.fsf@gitster.dls.corp.google.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<606af9e165c447b59076046a4d84aecf8b4cd2b0.1404323078.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 00:32:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4dwB-0001kA-C5
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 00:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbaGHWcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 18:32:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61483 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773AbaGHWca (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 18:32:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5EA1D27F9C;
	Tue,  8 Jul 2014 18:32:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BFVKrKWn94YeCYdD1skpJq7U1FY=; b=i/FKPU
	qSEPluF+6l3dg+UgAlcYbvp/whLrYeQlfet8Ez2Avr+jnvKI77+yEhmjRVvjvA0G
	DzMQf6gbzcNxNl59DnWvcUhZi+zfq+ZPIEmGEVr7xEDvi95bEmGuOgFaqolbcE9z
	5KdtYZ0X1hzjJsP/PoyMUXI4iFM4A02LuGuz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YgJC+IYM/xB0jf/lQMZEYbHAkcsEgwPs
	/spLGcZSdIGEiTan8b7jrMSiUrSKSulx0M/pdTzMzIxDR3Azurf9MdaLnCtYNqvp
	UK2A3G2xniT2sUZ2gEwyNY1dvRGBH2XDdGkR6/Ov6FW017WD++uvvvy7cebncZrq
	dsuMm273EFA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5479E27F9B;
	Tue,  8 Jul 2014 18:32:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C225627F92;
	Tue,  8 Jul 2014 18:32:09 -0400 (EDT)
In-Reply-To: <606af9e165c447b59076046a4d84aecf8b4cd2b0.1404323078.git.bafain@gmail.com>
	(Fabian Ruch's message of "Wed, 2 Jul 2014 19:48:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B300B858-06EF-11E4-8D91-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253056>

Fabian Ruch <bafain@gmail.com> writes:

> The command line used to recreate root commits specifies the
> effectless option `-C`. It is used to reuse commit message and
> authorship from the named commit but the commit being amended here,
> which is the sentinel commit, already carries the authorship and log
> message of the processed commit. Note that the committer email and
> commit date fields do not match the root commit either way. Remove
> the option. However, `-C` (other than `-c`) does not invoke the
> editor and the `--amend` option invokes it by default. Disable editor
> invocation again by specifying `--no-edit`.

I'd say this is a no-value change, in the sense that it can be
written either way for the same effect and if the original were
written with "--amend --no-edit" then there would be no reason to
change it to "-C $1" because such a change would also be equally a
no-value change.

What exactly are we gaining?  Performance?  Correctness?


> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  git-rebase--interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index ff04d5d..17836d5 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -511,7 +511,7 @@ do_pick () {
>  			   --no-post-rewrite -n -q -C $1 &&
>  			pick_one -n $1 &&
>  			git commit --allow-empty \
> -				   --amend --no-post-rewrite -n -C $1 \
> +				   --amend --no-post-rewrite -n --no-edit \
>  				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
>  			die_with_patch $1 "Could not apply $1... $2"
>  	else
