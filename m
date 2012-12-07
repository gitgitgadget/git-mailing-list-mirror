From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: add option --recurse-submodules to "git
 push"
Date: Fri, 07 Dec 2012 09:21:33 -0800
Message-ID: <7vehj1ixr6.fsf@alter.siamese.dyndns.org>
References: <1354883304-6860-1-git-send-email-steffen.jaeckel@stzedn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
X-From: git-owner@vger.kernel.org Fri Dec 07 18:21:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th1cX-0002OC-Oi
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 18:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423146Ab2LGRVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 12:21:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423001Ab2LGRVg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 12:21:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 138B89CB5;
	Fri,  7 Dec 2012 12:21:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JZ4JhZXfoUkIOBiZBj6pB2Iy8kg=; b=AF7DiF
	iEX3e0ZtHR5TQe1mBivccD5whrW45/8BMr07LsPKAbLAacbF1C0EyW9ww7XUQDzB
	6cbfBdrX2Y6VxvPOBntuaw9Kn3yXjOGn+BNZoT1muLpLnqxuLZmgeqCH8UbwFBAx
	y3OpIYpEssEQBWVtlG7Fii9aKzmJz0SfnAXiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=erebJLKrNiU6/f1LXHNcibrDuVuY5+Gt
	Q5TSsTC9hvPTZDMszqqNqo37iC0YdDn38TMxKPcRgLJYk/ue1aSsjdKkMazPcL31
	AQsCyYwRsLLVy9Mx51vW/lhGFlTBKu1SDadF9tlOZy4/OhYuT3ONImCBkPN5oiD+
	IBLfd0fjACw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 015E69CB4;
	Fri,  7 Dec 2012 12:21:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 522759CB3; Fri,  7 Dec 2012
 12:21:35 -0500 (EST)
In-Reply-To: <1354883304-6860-1-git-send-email-steffen.jaeckel@stzedn.de>
 (Steffen Jaeckel's message of "Fri, 7 Dec 2012 13:28:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D3BD7A8-4092-11E2-8B2F-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211181>

Steffen Jaeckel <steffen.jaeckel@stzedn.de> writes:

> Signed-off-by: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
> ---
>  contrib/completion/git-completion.bash | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0b77eb1..5b4d2e1 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1434,6 +1434,10 @@ _git_pull ()
>  	__git_complete_remote_or_refspec
>  }
>  
> +__git_push_recurse_submodules_options="
> +	check on-demand
> +"

Most of the existing completion functions do not seem to define
separate variables like this; instead, they literally embed their
choices at the point of use.

Is it expected that the same set of choices will appear in the
completion of many other subcommand options?  [jc: Cc'ed Heiko so
that we can sanity check the answer to this question].  If so, the
variable may be justified; otherwise, not.

>  _git_push ()
>  {
>  	case "$prev" in
> @@ -1446,10 +1450,15 @@ _git_push ()
>  		__gitcomp_nl "$(__git_remotes)" "" "${cur##--repo=}"
>  		return
>  		;;
> +	--recurse-submodules=*)
> +		__gitcomp "$__git_push_recurse_submodules_options" "" "${cur##--recurse-submodules=}"
> +		return
> +		;;

Owners of the completion script, does this look reasonable?
[jc: Cc'ed Felipe for this]

This is a tangent, but why is it a double-hash "##" not a
single-hash "#", other than "because all others use ##"?

>  	--*)
>  		__gitcomp "
>  			--all --mirror --tags --dry-run --force --verbose
>  			--receive-pack= --repo= --set-upstream
> +			--recurse-submodules=
>  		"
>  		return
>  		;;
