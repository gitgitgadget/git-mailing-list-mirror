Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0A7F
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713486561; cv=none; b=A4gzob8Y3PWlL3fBLeHJtFBnzmv//xR84kYxgRcK8GM2HGTdzhGBiw8ODH3MYOGZ/cgy2OYJOWO1ggbpSQq8XB5ulNHOMxKc/JVELQXemQc2l8wKN5vzZ71n4x2bcM4mHnQ0//Syeo4EB5iLN2lPSjwXii97ewQp1bxgoneO6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713486561; c=relaxed/simple;
	bh=BL78qntmdTWO6oxVtbgN6GD2HYtMIf31FgDo1QJFb3o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RtZtkSzzcNUTyKqFoKSQ7UeWQ+cRTgk4RCti0nDxvu4l8hRLPhmmh9JTgmF+n5fK8GFFF17YyAqc2wKNghUAQC0xU7tHVHmpRl55KHGBffwHCWBD9LKANVefQx6rvMr6O07pgovmVJbT6ALNuHuHSUV+D6mlrGvCsDugZiqWEBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SBdL0rZI; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SBdL0rZI"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713486556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mUgrMZjkT56rc8vdzQbM24umfP4P4h2qhyD2DlB+pM=;
	b=SBdL0rZI8qrA97FNn9Oi7+5qmDGPrv7RxxPKjVS1wbW/xk0St2cseXun1i0u/QY2Tu9Wbd
	/V6IsYQCwxKSEu2gOch2YW6QspqxQkOAeNIwI9mB7T4mbqvnjNHBZODMH+VVvWc/5btA3L
	xz+PZjHFujgqrEdXsolxGBS37xGaBQ6a1h1xkQhXpcZwW6y5mrzql+7Fo4wyd25jf1sSFe
	Ebo3z0RxHcMT5iOql6QTj5SZg37r4b0oIsGT0vDqa5CDLn5v+0YhB7lBPVeSAFWIYYZV/N
	SKFHa8ERfmAn7oD/lBqmWqE94dTpkE11gphMFXFGHWjDC/nMGgKLPNRG/pcWGw==
Date: Fri, 19 Apr 2024 02:29:16 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] format-patch: allow --rfc to optionally take a value,
 like --rfc=WIP
In-Reply-To: <xmqqzftqnuxq.fsf@gitster.g>
References: <xmqqzftqnuxq.fsf@gitster.g>
Message-ID: <47453c9701315d791c580bfdd679a6f1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

Please see my comments below.

On 2024-04-19 00:54, Junio C Hamano wrote:
> With the "--rfc" option, we can tweak the "[PATCH]" (or whatever
> string specified with the "--subject-prefix" option, instead of
> "PATCH") that we prefix the title of the commit with into "[RFC
> PATCH]", but some projects may want "[rfc PATCH]".  Adding a new
> option, e.g., "--rfc-lowercase", to support such need every time
> somebody wants to use different strings would lead to insanity of
> accumulating unbounded number of such options.
> 
> Allow an optional value specified for the option, so that users can
> use "--rfc=rfc" (think of "--rfc" without value as a short-hand for
> "--rfc=RFC").
> 
> This can of course be (ab)used to make the prefix "[WIP PATCH]" by
> passing "--rfc=WIP".

Aren't we also going to allow patch subject prefixes such as
"[PATCH RESEND]" to be produced this way?  Please see my earlier
response [1] for a possible solution.

[1] 
https://lore.kernel.org/git/84dcb80be916f85cbb6a4b99aea0d76b@manjaro.org/

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  Documentation/git-format-patch.txt | 15 ++++++++++-----
>  builtin/log.c                      | 22 ++++++++++++++++++----
>  t/t4014-format-patch.sh            |  9 +++++++++
>  3 files changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/git-format-patch.txt
> b/Documentation/git-format-patch.txt
> index 728bb3821c..8d634f5b1b 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -20,7 +20,7 @@ SYNOPSIS
>  		   [--in-reply-to=<message-id>] [--suffix=.<sfx>]
>  		   [--ignore-if-in-upstream] [--always]
>  		   [--cover-from-description=<mode>]
> -		   [--rfc] [--subject-prefix=<subject-prefix>]
> +		   [--rfc[=<rfc>]] [--subject-prefix=<subject-prefix>]
>  		   [(--reroll-count|-v) <n>]
>  		   [--to=<email>] [--cc=<email>]
>  		   [--[no-]cover-letter] [--quiet]
> @@ -238,10 +238,15 @@ the patches (with a value of e.g. "PATCH 
> my-project").
>  	value of the `format.filenameMaxLength` configuration
>  	variable, or 64 if unconfigured.
> 
> ---rfc::
> -	Prepends "RFC" to the subject prefix (producing "RFC PATCH" by
> -	default). RFC means "Request For Comments"; use this when sending
> -	an experimental patch for discussion rather than application.
> +--rfc[=<rfc>]::
> +	Prepends the string _<rfc>_ (defaults to "RFC") to
> +	the subject prefix.  As the subject prefix defaults to
> +	"PATCH", you'll get "RFC PATCH" by default.
> ++
> +RFC means "Request For Comments"; use this when sending
> +an experimental patch for discussion rather than application.
> +"--rfc=WIP" may also be a useful way to indicate that a patch
> +is not complete yet.
> 
>  -v <n>::
>  --reroll-count=<n>::
> diff --git a/builtin/log.c b/builtin/log.c
> index c0a8bb95e9..2d6e0f3688 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1494,6 +1494,18 @@ static int subject_prefix_callback(const struct
> option *opt, const char *arg,
>  	return 0;
>  }
> 
> +static int rfc_callback(const struct option *opt, const char *arg,
> +			int unset)
> +{
> +	struct strbuf *rfc;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	rfc = opt->value;
> +	strbuf_reset(rfc);
> +	strbuf_addstr(rfc, arg ? arg : "RFC");
> +	return 0;
> +}

"subject_prefix = 1;" should also be in this function, to prevent
'--rfc="" -k' from being a valid combination of parameters.

Checking "rfc.len" later in the code checks the length of the string
passed for '--rfc="<string>"', which can be zero, instead of checking
for the existence of "--rfc" as an option on the command-line, so the
"subject_prefix" flag also needs to be set.

> +
>  static int numbered_cmdline_opt = 0;
> 
>  static int numbered_callback(const struct option *opt, const char 
> *arg,
> @@ -1907,8 +1919,8 @@ int cmd_format_patch(int argc, const char
> **argv, const char *prefix)
>  	struct strbuf rdiff2 = STRBUF_INIT;
>  	struct strbuf rdiff_title = STRBUF_INIT;
>  	struct strbuf sprefix = STRBUF_INIT;
> +	struct strbuf rfc = STRBUF_INIT;
>  	int creation_factor = -1;
> -	int rfc = 0;
> 
>  	const struct option builtin_format_patch_options[] = {
>  		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
> @@ -1932,7 +1944,9 @@ int cmd_format_patch(int argc, const char
> **argv, const char *prefix)
>  			    N_("mark the series as Nth re-roll")),
>  		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
>  			    N_("max length of output filename")),
> -		OPT_BOOL(0, "rfc", &rfc, N_("use [RFC PATCH] instead of [PATCH]")),
> +		OPT_CALLBACK_F(0, "rfc", &rfc, N_("extra"),
> +			       N_("add <extra> (default 'RFC') before 'PATCH'"),
> +			       PARSE_OPT_NONEG|PARSE_OPT_OPTARG, rfc_callback),
>  		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
>  			    N_("cover-from-description-mode"),
>  			    N_("generate parts of a cover letter based on a branch's 
> description")),
> @@ -2050,8 +2064,8 @@ int cmd_format_patch(int argc, const char
> **argv, const char *prefix)
>  	if (cover_from_description_arg)
>  		cover_from_description_mode =
> parse_cover_from_description(cover_from_description_arg);
> 
> -	if (rfc)
> -		strbuf_insertstr(&sprefix, 0, "RFC ");
> +	if (rfc.len)
> +		strbuf_insertf(&sprefix, 0, "%s ", rfc.buf);
> 
>  	if (reroll_count) {
>  		strbuf_addf(&sprefix, " v%s", reroll_count);
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index e37a1411ee..905858da35 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1377,6 +1377,15 @@ test_expect_success '--rfc' '
>  	test_cmp expect actual
>  '
> 
> +test_expect_success '--rfc=WIP' '
> +	cat >expect <<-\EOF &&
> +	Subject: [WIP PATCH 1/1] header with . in it
> +	EOF
> +	git format-patch -n -1 --stdout --rfc=WIP >patch &&
> +	grep "^Subject:" patch >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success '--rfc does not overwrite prefix' '
>  	cat >expect <<-\EOF &&
>  	Subject: [RFC PATCH foobar 1/1] header with . in it
