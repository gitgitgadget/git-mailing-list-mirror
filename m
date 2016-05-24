From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-prompt.sh: Don't error on null ${ZSH,BASH}_VERSION
Date: Tue, 24 May 2016 10:11:46 -0700
Message-ID: <xmqqwpmj5qjx.fsf@gitster.mtv.corp.google.com>
References: <1464078713-3220-1-git-send-email-ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
X-From: git-owner@vger.kernel.org Tue May 24 19:11:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Fs3-0000b7-CP
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 19:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541AbcEXRLv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2016 13:11:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751790AbcEXRLv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2016 13:11:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 947891CE83;
	Tue, 24 May 2016 13:11:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KNVyWBLsBcPE
	Gm9QqxOCKy+RPps=; b=Ld36qvproeevuwhy7eP0Zw/t7TpXgave+DYZFfLVCKHQ
	vv5FtG0A5vG7zcBmqC9b+KctHV0xFc0In2Rkms3D3AZO7LQ0BhYOQIPup8+Q1yVw
	TND9h8tJ6XFd2Rm6bO/zBa5+cpzAKf64aPNdIOzzSv15uLXnf2sQ1n2YWi7X3wg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Mxz5TV
	NDDxHK8PoajUtSjM0bVHhqGGsfo2y2oco5JN3H+i+mpzv2Qp5h6dE4LI5tcI6yFh
	Mbnx9Jn0VPf9RPhlkhBsJqzMT9eoRUNyX4c9apjG7j3o89vKLsxzrvt/tczd08Qk
	yhrE/1sjGRYoVkS1rbVPkVZ63D2jwKi8is5vI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BB731CE82;
	Tue, 24 May 2016 13:11:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0007C1CE81;
	Tue, 24 May 2016 13:11:48 -0400 (EDT)
In-Reply-To: <1464078713-3220-1-git-send-email-ville.skytta@iki.fi> ("Ville
	=?utf-8?Q?Skytt=C3=A4=22's?= message of "Tue, 24 May 2016 11:31:53 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99E4FEF6-21D2-11E6-8370-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295506>

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> When the shell is in "nounset" or "set -u" mode, referencing unset or
> null variables results in an error. Protect $ZSH_VERSION and
> $BASH_VERSION against that.
>
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---

Makes sense from a cursory look.  Thanks.

>  contrib/completion/git-prompt.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/gi=
t-prompt.sh
> index 64219e6..341cf6b 100644
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
