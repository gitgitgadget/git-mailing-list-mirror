From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH for maint branch] git-completion: fix zsh support
Date: Thu, 05 May 2011 10:34:39 -0700
Message-ID: <7vtyd9830w.fsf@alter.siamese.dyndns.org>
References: <1304605458-1483-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 19:34:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI2S1-000417-UE
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 19:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab1EERew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 13:34:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab1EERev (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 13:34:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 005815AD0;
	Thu,  5 May 2011 13:36:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JDf+tW+U0xFe3drNbDBV3EVF/F4=; b=CmRQyd
	4qyRwOmBLyOY4RYdhYFym0FxuwoAoCGRS9Np7aNnmBBShOEm8OZdIOVPo6IiMwhZ
	OhKT1HWmkCYnRca0wlST+Veq2+uiCx+WZ4v9PsW4wkrbOvz+GEf2TEkVhFVrTp/f
	w2gOpxzi/01YqbNlHNvNOe8GKtplJPxNViVi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HM93bAysWV1JO2ct2CcPJImnK3nQZWc6
	VNivWo2zEX0R+Rq1wTRK8Uhc9A1B2Pqu3TU0LUmZR05M70sdblJYYHnvtLQYWpxH
	qVPXeWtkK9uUY6YRdIWFhSvxA013cDwiE4e4svlXsCrNFyjEm1+uVWF0/AilZr3R
	Hdbj61xmdBc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C00935ACF;
	Thu,  5 May 2011 13:36:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 98BE95ACE; Thu,  5 May 2011
 13:36:45 -0400 (EDT)
In-Reply-To: <1304605458-1483-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Thu, 5 May 2011 17:24:18 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41D1CB66-773E-11E0-9FBC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172857>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It turns out 'words' is a special variable used by zsh completion.
>
> There's probably a bug in zsh's bashcompinit:
> http://article.gmane.org/gmane.comp.shells.zsh.devel/22546
>
> But in the meantime we can workaround it this way.
>
> Currently zsh is completely broken after commit da48616 (bash: get
> --pretty=m<tab> completion to work with bash v4), which introduced
> _get_comp_words_by_ref() that comes from debian's bash_completion
> scripts, and relies on the 'words' variable to behave like any normal
> variable.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> This patch is meant for the maintenance branch, so Szeder's patches are not
> needed.

Do you mean sg/completion-upadates that is in 'next' need to be reverted
and replaced with this one?  If that is the case I would love to have an
Acked-by in this patch.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 840ae38..8d5eae7 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2710,6 +2710,9 @@ _git ()
>  	if [[ -n ${ZSH_VERSION-} ]]; then
>  		emulate -L bash
>  		setopt KSH_TYPESET
> +
> +		# 'words' has special meaning in zsh; override that
> +		typeset -h words
>  	fi
>  
>  	local cur words cword
