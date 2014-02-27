From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/25] setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
Date: Wed, 26 Feb 2014 16:22:56 -0800
Message-ID: <xmqqios11k0v.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-18-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 01:23:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIokj-0000OA-Ht
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 01:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbaB0AXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Feb 2014 19:23:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45565 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753323AbaB0AW7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 19:22:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C7F2702F4;
	Wed, 26 Feb 2014 19:22:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zdSeSMdYSNcT
	4ZWhtoKr0eLQkZQ=; b=SYVNRccY7K3aa5WJ6REo+zLaZ+/Gsna50mf/8RIdNyFF
	nZKmo9dRV98sz5W/OyZhzO7+Od0Ty4Hnj7JeJmux2XehGfWwFp0eI2Ibzg9cjVcg
	LiEa7V0FeBjidoynqa456iY+rgpkfsWgJrYe/C+bU5CVrH6H0Ut49682s4kZXQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=x9MQn4
	HBSZHXVb7oHSBN3IA5WUmScfD2p0b19zewA4YR8R6RQDmzY41JErwgLiwBH4Q6Ss
	ppbc2GnRXtFp+E6cX2V40pwmLylmK+X5vX7KuwpSYI0r82djimbyBXK4FmkMbAWS
	3ZSt2Fd3OQxqc4/7j4eWUnD/USMDWEVlfQzc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78F55702F3;
	Wed, 26 Feb 2014 19:22:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE484702F2;
	Wed, 26 Feb 2014 19:22:57 -0500 (EST)
In-Reply-To: <1392730814-19656-18-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:40:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4EF1582A-9F45-11E3-B87E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242780>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

It is a good thing to do to read config from the real repository we
are borrowing from when we have .git/commondir, but it makes me
wonder if we should signal some kind of error if we find .git/config
in such a borrowing repository---which will be silently ignored.

My gut feeling is that such a check may be necessary, but may not
belong to this function.

>  setup.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 282fdc9..e56ec11 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -285,6 +285,10 @@ static int check_repository_format_gently(const =
char *gitdir, int *nongit_ok)
>  	const char *repo_config;
>  	int ret =3D 0;
> =20
> +	get_common_dir(&sb, gitdir);
> +	strbuf_addstr(&sb, "/config");
> +	repo_config =3D sb.buf;
> +
>  	/*
>  	 * git_config() can't be used here because it calls git_pathdup()
>  	 * to get $GIT_CONFIG/config. That call will make setup_git_env()
> @@ -294,8 +298,6 @@ static int check_repository_format_gently(const c=
har *gitdir, int *nongit_ok)
>  	 * Use a gentler version of git_config() to check if this repo
>  	 * is a good one.
>  	 */
> -	strbuf_addf(&sb, "%s/config", gitdir);
> -	repo_config =3D sb.buf;
>  	git_config_early(check_repository_format_version, NULL, repo_config=
);
>  	if (GIT_REPO_VERSION < repository_format_version) {
>  		if (!nongit_ok)
