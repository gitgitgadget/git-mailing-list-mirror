From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] completion: add missing options for git-merge
Date: Thu, 22 May 2014 16:59:11 -0700
Message-ID: <xmqqiooxl60g.fsf@gitster.dls.corp.google.com>
References: <CANu1nikzk-rGjzKv6R-OR6Et-fB-JYnt245+P6NY-RQiihzXyA@mail.gmail.com>
	<e4a536d29a59d7dc89cc2f42fa8339506b4829f1.1400767118.git.john@keeping.me.uk>
	<5cfeac0e9b7fb0ff4a2468f30476152fc93f4c16.1400767118.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Haralan Dobrev <hkdobrev@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 23 01:59:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnctN-0003qU-Io
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 01:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbaEVX7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 19:59:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60393 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696AbaEVX7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 19:59:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B34B01974F;
	Thu, 22 May 2014 19:59:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7xxdUnqTV+q7M09O21uJYSCZu+s=; b=GdESGJ
	5TgzytatrE5jlzteYxcs/kc6Qm0JpL0G6qIvi/WyFIplNCbixV6gP0zZ6C1soFjm
	yRiIN9LmWYWWR7NmExaKTBt48tgeooytBfxDeLhKR1RQQJwEwhhXICIRNYuO92MT
	ve817/v0sekebL7St8MyiK3rI0ztR2p0cHfuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EquvV1eyDlrlTTWmnC0wqRTZezcZ4OU8
	xrWzFWSRbHpgqP8JCmR+ZDB1SB1x40jpJCZsffspD9dMPJDWH9lw8TDyjfGllkyj
	Ckd4Vryo90kYEPaijGfWTOnGUrT61dy6IZofdnbl+0XcyDshUjEu2AUlDtjytnwV
	3KD3P/5H1SY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A84341974E;
	Thu, 22 May 2014 19:59:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6404019748;
	Thu, 22 May 2014 19:59:13 -0400 (EDT)
In-Reply-To: <5cfeac0e9b7fb0ff4a2468f30476152fc93f4c16.1400767118.git.john@keeping.me.uk>
	(John Keeping's message of "Thu, 22 May 2014 14:58:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 131AA3AA-E20D-11E3-99E7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249967>

John Keeping <john@keeping.me.uk> writes:

> The options added to __git_merge_options are those that git-pull also
> understands, since that variable is used by both commands.  Those added
> directly in _git_merge() are specific to git-merge and are not
> supported by git-pull.

Interesting.

Technically, "are not passed through" would be more accurate than
"are not supported", as there may be a very good reason not to call
"git merge --frotz" from "git pull --frotz=nitfol".  In such a case,
"git pull" would _support_ the "--frotz" option, but in a different
way and possibly with semantics different from "git merge --frotz"
(i.e. option with value vs boolean), and completion of the
"--frotz=<value>" option may need to be supported for "git pull"
separately without using $__git_merge_options.

The patch makes us think if "--[no-]rerere-autoupdate" should be a
pass-thru option.  You are unlikely to have seen the same conflict
that will arise from a pull from another person for autoupdate to
matter, but on the other hand, if you do have seen one and resolved
it already, you may want the autoupdate to kick in, so accepting and
passing it through may not be an unreasonable thing to do.

As long as we declare that "git pull --abort" does not make any
sense (which I think is a sane declaration), the distinction you
made in [PATCH 1/2] will always be with us, whether we make
"--rerere-autoupdate" pass-thru or not, so in that sense, both
patches make sense to me.

Thanks.

>
> Reported-by: Haralan Dobrev <hkdobrev@gmail.com>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  contrib/completion/git-completion.bash | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ff97c20..019026e 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1476,6 +1476,8 @@ _git_log ()
>  __git_merge_options="
>  	--no-commit --no-stat --log --no-log --squash --strategy
>  	--commit --stat --no-squash --ff --no-ff --ff-only --edit --no-edit
> +	--verify-signatures --no-verify-signatures --gpg-sign
> +	--quiet --verbose --progress --no-progress
>  "
>  
>  _git_merge ()
> @@ -1484,7 +1486,8 @@ _git_merge ()
>  
>  	case "$cur" in
>  	--*)
> -		__gitcomp "$__git_merge_options"
> +		__gitcomp "$__git_merge_options
> +			--rerere-autoupdate --no-rerere-autoupdate --abort"
>  		return
>  	esac
>  	__gitcomp_nl "$(__git_refs)"
