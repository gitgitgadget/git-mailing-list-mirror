From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-prompt.sh: Don't error on null ${ZSH,BASH}_VERSION, $short_sha
Date: Mon, 06 Jun 2016 13:08:32 -0700
Message-ID: <xmqq37oqw05b.fsf@gitster.mtv.corp.google.com>
References: <1465230573-18357-1-git-send-email-ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
X-From: git-owner@vger.kernel.org Mon Jun 06 22:08:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA0pE-0006nc-Tz
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 22:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbcFFUIg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 16:08:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751190AbcFFUIg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 16:08:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5F28236AA;
	Mon,  6 Jun 2016 16:08:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ltonji+eOO+N
	HJW+SEI/BBHbXjk=; b=G4ymAg7eoPnODtJ7woi+ZjRx/cl1jG+m0fDZ/Ap6zsIZ
	qiN4l9897NTbh8878TI7MkY6YJO7FAseD75KnQ4lR2MYAT4qCfgIpMrBtHfWKCFl
	pW5t+gtYFrxignoLaaTnkWSSCdbObnok+HTi+JTqjTJh3+VZuFryVtRfs2wqFxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DSQwuI
	Xg8xKrh14hl+/s8Fr78eH4LoFBeyofwU34uYYYhzEmgGKF9T1FJgJ/L7vtp0DXNG
	H2mwEL+9/lmPRgM47jOT+DOVWMfYvrdUDoVgtkpxwaRLR5JuaOR1jvgaFC+nWIG/
	vPwlUMiZTVzMWCCy6fHiq4sdHUZlyBG/nw2fM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC982236A9;
	Mon,  6 Jun 2016 16:08:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 399EA236A8;
	Mon,  6 Jun 2016 16:08:34 -0400 (EDT)
In-Reply-To: <1465230573-18357-1-git-send-email-ville.skytta@iki.fi> ("Ville
	=?utf-8?Q?Skytt=C3=A4=22's?= message of "Mon, 6 Jun 2016 19:29:33 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 72798878-2C22-11E6-80AD-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296561>

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> When the shell is in "nounset" or "set -u" mode, referencing unset or
> null variables results in an error. Protect $ZSH_VERSION and
> $BASH_VERSION against that, and initialize $short_sha before use.
>
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---

Thanks for following up.  I do not run my interactive shells with
"set -u", so I never noticed these, but apparently you do (or you
know who does)--does this patch cover everything that is not "-u"
safe?

Will queue.

>  contrib/completion/git-prompt.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/gi=
t-prompt.sh
> index 64219e6..97eacd7 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -355,8 +355,8 @@ __git_ps1 ()
>  	# incorrect.)
>  	#
>  	local ps1_expanded=3Dyes
> -	[ -z "$ZSH_VERSION" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=3Dno
> -	[ -z "$BASH_VERSION" ] || shopt -q promptvars || ps1_expanded=3Dno
> +	[ -z "${ZSH_VERSION-}" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=3D=
no
> +	[ -z "${BASH_VERSION-}" ] || shopt -q promptvars || ps1_expanded=3D=
no
> =20
>  	local repo_info rev_parse_exit_code
>  	repo_info=3D"$(git rev-parse --git-dir --is-inside-git-dir \
> @@ -368,7 +368,7 @@ __git_ps1 ()
>  		return $exit
>  	fi
> =20
> -	local short_sha
> +	local short_sha=3D""
>  	if [ "$rev_parse_exit_code" =3D "0" ]; then
>  		short_sha=3D"${repo_info##*$'\n'}"
>  		repo_info=3D"${repo_info%$'\n'*}"
