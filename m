Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BDE43AB5
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709503573; cv=none; b=Ww2UFdAhwel1QLDVbqEIFFAZY1njXsSSN4UCXcP1q8E+fIAOanjNPEVnEXk3neNhOpTuYCcCnE/uNl74EmjHNrovUvy6Vbr3oPfHjJ7lIdJvsH2p7gt5zpI4h+sPN0rZT2cnbqdIvMfMD4YjeccwrzevwgYf1pFuyT7L+KSkVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709503573; c=relaxed/simple;
	bh=8WMUJhl7MM80mXRftblRuab3bIuNgQ+/zcy+5+MSoRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foMs+npA77K2ZWBn0osKN6CcfdJvnx5xFY6ish5DR7y1zi3WdcK9fOgp8r0ZqziIkWHS1Quo54jatSOh/gsFgH1o0JY3cGbyzGHtA0591QA2zaUGW54EXbnsP8P1Ob6HsD3ILYhw+sktJUQrrvCVNYYtTOWQITKsG2S3yD6py+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=w4cu/PUZ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w4cu/PUZ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AAF0F30279;
	Sun,  3 Mar 2024 17:06:05 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=8WMUJhl7MM80mXRftblRuab3b
	IuNgQ+/zcy+5+MSoRw=; b=w4cu/PUZjSac/K/jcRVYATv4hFIIyKBPmhvbGRkw6
	/cfcGaRhqeiLrs0XVk9LlV5NSmZxM7sNvAn+trely4nYS8VNXhZQGBDXQmfySBVo
	JIWd23miGs6ZJPUySTNn0P8n0vOrs/N4QPFM4FMx6cLlqji8SnC4XLGp1xup/+sU
	M0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A304330278;
	Sun,  3 Mar 2024 17:06:05 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 40DBA30276;
	Sun,  3 Mar 2024 17:06:02 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Sergey Organov <sorganov@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <avila.jn@gmail.com>,
	"Kristoffer Haugsbakk" <code@khaugsbakk.name>
Subject: Re: [PATCH v2] clean: improve -n and -f implementation and documentation
Date: Sun,  3 Mar 2024 14:05:59 -0800
Message-ID: <20240303220600.2491792-1-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-84-gb387623c12
In-Reply-To: <7le6ziqzb.fsf_-_@osv.gnss.ru>
References: <7le6ziqzb.fsf_-_@osv.gnss.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 3939C328-D9AA-11EE-9013-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Sergey Organov <sorganov@gmail.com> writes:

> Changes since v1:
>
>  * Fixed style of the if() statement
>
>  * Merged two error messages into one
>
>  * clean.requireForce description changed accordingly

Excellent.

> diff --git a/builtin/clean.c b/builtin/clean.c
> index d90766cad3a0..41502dcb0dde 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -25,7 +25,7 @@
>  #include "help.h"
>  #include "prompt.h"
> =20
> -static int force =3D -1; /* unset */
> +static int require_force =3D -1; /* unset */
>  static int interactive;
>  static struct string_list del_list =3D STRING_LIST_INIT_DUP;
>  static unsigned int colopts;
> @@ -128,7 +128,7 @@ static int git_clean_config(const char *var, const =
char *value,
>  	}
> =20
>  	if (!strcmp(var, "clean.requireforce")) {
> -		force =3D !git_config_bool(var, value);
> +		require_force =3D git_config_bool(var, value);
>  		return 0;
>  	}
> =20
> @@ -920,7 +920,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
>  {
>  	int i, res;
>  	int dry_run =3D 0, remove_directories =3D 0, quiet =3D 0, ignored =3D=
 0;
> -	int ignored_only =3D 0, config_set =3D 0, errors =3D 0, gone =3D 1;
> +	int ignored_only =3D 0, force =3D 0, errors =3D 0, gone =3D 1;
>  	int rm_flags =3D REMOVE_DIR_KEEP_NESTED_GIT;
>  	struct strbuf abs_path =3D STRBUF_INIT;
>  	struct dir_struct dir =3D DIR_INIT;
> @@ -946,22 +946,17 @@ int cmd_clean(int argc, const char **argv, const =
char *prefix)
>  	};
> =20
>  	git_config(git_clean_config, NULL);
> -	if (force < 0)
> -		force =3D 0;
> -	else
> -		config_set =3D 1;

The above changes are a significant improvement.  Instead of a
single "force" variable whose meaning is fuzzy, we now have
"require_force" to track the config setting, and "force" to indicate
the "--force" option.  THis makes the code's intent much clearer.

>  	argc =3D parse_options(argc, argv, prefix, options, builtin_clean_usa=
ge,
>  			     0);
> =20
> -	if (!interactive && !dry_run && !force) {
> -		if (config_set)
> -			die(_("clean.requireForce set to true and neither -i, -n, nor -f gi=
ven; "
> -				  "refusing to clean"));
> -		else
> -			die(_("clean.requireForce defaults to true and neither -i, -n, nor =
-f given;"

And thanks to that, the above trick with an extra variable "config_set",
which smells highly a round-about way, can be simplified.

> +	/* Dry run won't remove anything, so requiring force makes no sense *=
/
> +	if (dry_run)
> +		require_force =3D 0;
> +	if (require_force !=3D 0 && !force && !interactive)

However, the above logic could be improved.  The behaviour we have,
for a user who does *not* explicitly disable config.requireForce,
is, that when clean.requireForce is not set to 0, we would fail
unless one of these is in effect: -f, -n, -i.  Even though using
either -n or -i makes it unnecessary to use -f *exactly* the same
way, the above treats dry_run and interactive separately with two if
statements, which is suboptimal as a "code/logic clean-up".

The reason for the behaviour can be explained this way:

 * "git clean" (with neither -i nor -n.  The user wants the default
   mode that has no built-in protection will be stopped without -f.

 * "git clean -n".  The user wants the dry-run mode that has its own
   protection, i.e. being always no-op to the files, so there is no
   need to fail here for the lack of "-f".

 * "git clean --interactive".  The user wants the interactive mode
   that has its own protection, i.e. giving the end-user a chance to
   say "oh, I didn't mean to remove these files, 'q'uit from this
   mistake", so there is no need to fail here for the lack of "-f".

> +		die(_("clean.requireForce is true and neither -f nor -i given:"
>  				  " refusing to clean"));

The message is certainly cleaner compared to the previous round, but
this also can be improved.  Stepping back a bit and thinking who are
the target audience of this message.  The only users who see this
message are running "git clean" in its default (unprotected) mode,
and they wanted to "clean" for real.  If they wanted to do dry-run,
they would have said "-n" themselves, and that is why we can safely
omit mention of "-n" we had in the original message.

These users did not want to run the interractive clean, either---if
they wanted to go interractive, they would have said "-i"
themselves.  So we do not need to mention "-i" either for exactly
the same logic.

Based on the above observation,

I'll send a follow-up patch to clean up the code around here (both
implementation and documentation), taking '-i' into account as well.
