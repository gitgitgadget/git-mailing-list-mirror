Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3C14A98
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710474818; cv=none; b=Kce93OfYdXBEdek1LeBHWCQEL56dFeGxQ+bC87RzpsGDANVf2gv925VgsjsA1jRImI6WlYJC9dU3zJadGWO3jWEF3YcEUs8FYKmgq4RMTGg79S98dx0s+pGqbUqY7HsP8bhSDl85ESNRri91fTPNr6lO8SLlaJp0bDW0zh0Lto4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710474818; c=relaxed/simple;
	bh=KtqmPDlONvlJ56EMQJfk9hwxyuto8oD1avsNZy900OA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UFP5DTG7HNsbSR4fXm/D5Fj8Wuq8GYmyal+gF2TDb5UWmABFXJ6dO/fJxzGXzMRN3DGq2f0UHBynhlgaj8apiM/G+Ta5kip6FP+nK6Zp5aMBYsapkd/e0ZAH8jYCQziu3AgO9kamQp8WpxcmQ0RwsdlQM4R2IW7xAZ5dfwcm20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=P3cSVN+n; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="P3cSVN+n"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710474811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqAqh3bnM2/+8yWBslRrEhxEwk5hn5YIOI1kLB5Zr3A=;
	b=P3cSVN+nJTgs/4NOKlhlnnwvFSflrMUAPnPWn0kAq8MM+WqEE4hMk6Ij8vPanwuI8ok8Mu
	NO9GljATLVwQr4/kMdImffMYboC7A1ND4FvKBurzfdvEiH+80gYNR+b/GzrRlXKxa/l+bZ
	HjhKkwIe/Z6szHao4aeBn67u7RKheE/sxPuFQjlG3p3QYrEaVVA5jKVXunI9L6u1T28Wa7
	LvGqnJyV44u8cP8Hhs4t198bQHJSdaCfzAFf6aOlOFMm2m+MjHEiaGcBqU8NK+kzALwV8C
	psOWRjXpibWTpBBYOM0OtZv1PGzsoBRoa5iMUeC65GKCyiMabd2r5EZm+0Vh9g==
Date: Fri, 15 Mar 2024 04:53:30 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, David
 Heidelberg <david@ixit.cz>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
In-Reply-To: <20240315010310.GA1901653@quokka>
References: <20240315010310.GA1901653@quokka>
Message-ID: <2da5f5cd5956194e659c88026a12cb9e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Peter,

On 2024-03-15 02:03, Peter Hutterer wrote:
> Allow the default prefixes "a/" and "b/" to be tweaked by the
> diff.srcPrefix and diff.dstPrefix configuration variables.
> 
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>

Looking good to me, except for some of the included tests, please
see my notes below.

Additionally, perhaps the documentation for "--default-prefix"
could use some wording improvements, but I'll try to address that
in my separate patch(es) mentioned below.  Of course, I can send
my suggestions now, if you prefer it that way?

> ---
> Changes to v3:
> - fix capitalization in the commit message
> - quotes changed to " in the diff.txt hunk (for consistency with
>   diff.mnemonicPrefix)
> - reword the diff-options.txt entry to be more explicit/definitive
> 
> Dragan: I used the lowercase `noprefix` spelling here to be consistent
> with the current state of the tree, can you please include the fix for
> this in your pending patch? Thanks.

Sure, I'll cover it later, after your patch is accepted.  Thanks
for the notice.

>  Documentation/config/diff.txt  |  6 ++++++
>  Documentation/diff-options.txt |  5 +++--
>  diff.c                         | 14 ++++++++++++--
>  t/t4013-diff-various.sh        | 35 ++++++++++++++++++++++++++++++++++
>  4 files changed, 56 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/config/diff.txt 
> b/Documentation/config/diff.txt
> index 6c7e09a1ef5e..afc23d7723b6 100644
> --- a/Documentation/config/diff.txt
> +++ b/Documentation/config/diff.txt
> @@ -111,6 +111,12 @@ diff.mnemonicPrefix::
>  diff.noprefix::
>  	If set, 'git diff' does not show any source or destination prefix.
> 
> +diff.srcPrefix::
> +	If set, 'git diff' uses this source prefix. Defaults to "a/".
> +
> +diff.dstPrefix::
> +	If set, 'git diff' uses this destination prefix. Defaults to "b/".
> +
>  diff.relative::
>  	If set to 'true', 'git diff' does not show changes outside of the 
> directory
>  	and show pathnames relative to the current directory.
> diff --git a/Documentation/diff-options.txt 
> b/Documentation/diff-options.txt
> index aaaff0d46f0c..0e9456957e37 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -865,8 +865,9 @@ endif::git-format-patch[]
> 
>  --default-prefix::
>  	Use the default source and destination prefixes ("a/" and "b/").
> -	This is usually the default already, but may be used to override
> -	config such as `diff.noprefix`.
> +	This overrides configuration variables such as `diff.noprefix`,
> +	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
> +	(see `git-config`(1)).
> 
>  --line-prefix=<prefix>::
>  	Prepend an additional prefix to every line of output.
> diff --git a/diff.c b/diff.c
> index e50def45383e..108c1875775d 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -62,6 +62,8 @@ static const char *diff_order_file_cfg;
>  int diff_auto_refresh_index = 1;
>  static int diff_mnemonic_prefix;
>  static int diff_no_prefix;
> +static const char *diff_src_prefix = "a/";
> +static const char *diff_dst_prefix = "b/";
>  static int diff_relative;
>  static int diff_stat_name_width;
>  static int diff_stat_graph_width;
> @@ -408,6 +410,12 @@ int git_diff_ui_config(const char *var, const char 
> *value,
>  		diff_no_prefix = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "diff.srcprefix")) {
> +		return git_config_string(&diff_src_prefix, var, value);
> +	}
> +	if (!strcmp(var, "diff.dstprefix")) {
> +		return git_config_string(&diff_dst_prefix, var, value);
> +	}
>  	if (!strcmp(var, "diff.relative")) {
>  		diff_relative = git_config_bool(var, value);
>  		return 0;
> @@ -3425,8 +3433,8 @@ void diff_set_noprefix(struct diff_options 
> *options)
> 
>  void diff_set_default_prefix(struct diff_options *options)
>  {
> -	options->a_prefix = "a/";
> -	options->b_prefix = "b/";
> +	options->a_prefix = diff_src_prefix;
> +	options->b_prefix = diff_dst_prefix;
>  }
> 
>  struct userdiff_driver *get_textconv(struct repository *r,
> @@ -5362,6 +5370,8 @@ static int diff_opt_default_prefix(const struct
> option *opt,
> 
>  	BUG_ON_OPT_NEG(unset);
>  	BUG_ON_OPT_ARG(optarg);
> +	diff_src_prefix = "a/";
> +	diff_dst_prefix = "b/";
>  	diff_set_default_prefix(options);
>  	return 0;
>  }
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 1e3b2dbea484..e75f9f7d4cb2 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -663,6 +663,41 @@ test_expect_success 'diff --default-prefix
> overrides diff.mnemonicprefix' '
>  	check_prefix actual a/file0 b/file0
>  '
> 
> +test_expect_success 'diff respects diff.srcprefix' '
> +	git -c diff.srcprefix=x/ diff >actual &&
> +	check_prefix actual x/file0 b/file0
> +'
> +
> +test_expect_success 'diff respects diff.dstprefix' '
> +	git -c diff.dstprefix=y/ diff >actual &&
> +	check_prefix actual a/file0 y/file0
> +'
> +
> +test_expect_success 'diff --src-prefix overrides diff.srcprefix' '
> +	git -c diff.srcprefix=z/ diff --src-prefix=z/ >actual &&

Shouldn't this be

	git -c diff.srcprefix=e/ diff --src-prefix=z/ >actual &&

instead (or something else for diff.srcPrefix, perhaps "y/"), to 
actually
perform the check for overriding?

> +	check_prefix actual z/file0 b/file0
> +'
> +
> +test_expect_success 'diff --dst-prefix overrides diff.dstprefix' '
> +	git -c diff.dstprefix=y/ diff --dst-prefix=z/ >actual &&
> +	check_prefix actual a/file0 z/file0
> +'
> +
> +test_expect_success 'diff src/dstprefix ignored with diff.noprefix' '

Shouldn't this be

     test_expect_success 'diff.*prefix ignored with diff.noprefix' '

instead, to describe the test better?

> +	git -c diff.dstprefix=y/ -c diff.srcprefix=x/ -c diff.noprefix diff 
> >actual &&
> +	check_prefix actual file0 file0
> +'
> +
> +test_expect_success 'diff src/dstprefix ignored with 
> diff.mnemonicprefix' '

Shouldn't this be

     test_expect_success 'diff.*prefix ignored with diff.mnemonicprefix' 
'

instead, to describe the test better?

> +	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ -c diff.mnemonicprefix
> diff >actual &&
> +	check_prefix actual i/file0 w/file0
> +'
> +
> +test_expect_success 'diff src/dstprefix ignored with --default-prefix' 
> '

Shouldn't this be

     test_expect_success 'diff.*prefix ignored with --default-prefix' '

instead, to describe the test better?

> +	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ diff --default-prefix 
> >actual &&
> +	check_prefix actual a/file0 b/file0
> +'
> +
>  test_expect_success 'diff --no-renames cannot be abbreviated' '
>  	test_expect_code 129 git diff --no-rename >actual 2>error &&
>  	test_must_be_empty actual &&
