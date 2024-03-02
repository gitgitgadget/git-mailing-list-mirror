Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF27D2C870
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709409477; cv=none; b=N4QQZrLrQi/VW1lezknl8mZq2vUWm9JCUbzY8vPBtabY/La6eUlAfB8KVSXylXOgKChyfD3t5HcmRpbs0NLPZqUvnG9D+7L2+B5Wpt05PG7NUVnAEGDCRxxA3tvN+QWJZNZ1Bm4HP1OA8hhCafNIVMMew0Y/cM8AsxNnU2kT5SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709409477; c=relaxed/simple;
	bh=2hL7wpzHorRuPfvgd9TG77onTUF10za4NfPMOEFRVtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnPL2RHFVWyoQs2JXIy645pGdd/JYuFlHW02jheoDamDHjMagx06FAy7UXGdOIeaba+QQ6vZSQ6e8PEhW2HRC2WQF+0+7zN4oV5+TwlPX4f5cmU+UJlCd0u4esDuFwIX3DGDVBjOQJw/OmOlnQxsdM+SmDyMooy9GuzFE8wlk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=aG1ZVySl; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="aG1ZVySl"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:1c73:7714:ea27:1649])
	(Authenticated sender: jn.avila@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id F14C719F593;
	Sat,  2 Mar 2024 20:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1709409472;
	bh=2hL7wpzHorRuPfvgd9TG77onTUF10za4NfPMOEFRVtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aG1ZVySlAlO80VKhwyvE8WlUJpi4SLUfuPfRVxjgdpVHl3nBZ3l2bsBFLZomKKm8J
	 BZV2Zr9fiZy+10ifzKXztBV60dXIhsC42IBfYL70wtQV1NHkt+4AscujG+b2CYFrth
	 JUd56mu+ImfjPCO+mJgldgnzaP3WfqdUVJx9roxa+OMdxY7u1LWVTmWUyvzeO7smwg
	 suOtZmuFWt0L6XIR1vVLejk9mh78ErBuEFBaWg0SQu5iBYWIikAHwzKHJLfCLbCtRO
	 0uFCcEYHhoZ4VQIvvlD79ZQafJQI5w8G5h3xd9eGA1/khBrSb6Sm4nkIkuDT8Y6jCi
	 JHloFBPtxHLxA==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: oliver@schinagl.nl, Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] diff: add 'diff.wordDiff' config option
Date: Sat, 02 Mar 2024 20:57:48 +0100
Message-ID: <4884140.GXAFRqVoOG@cayenne>
In-Reply-To: <20240302095751.123138-3-karthik.188@gmail.com>
References:
 <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
 <20240302095751.123138-1-karthik.188@gmail.com>
 <20240302095751.123138-3-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello,

On Saturday, 2 March 2024 10:57:51 CET Karthik Nayak wrote:
> The git-diff(1) command supports the `--word-diff` which allows the
> users to specify how to delimit word diffs. Provide this option also as
> a config param 'diff.wordDiff'.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/config/diff.txt |  4 +++
>  diff.c                        | 50 +++++++++++++++++++++++++++--------
>  t/t4034-diff-words.sh         | 11 ++++++--
>  3 files changed, 52 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
> index bd5ae0c337..00459beee2 100644
> --- a/Documentation/config/diff.txt
> +++ b/Documentation/config/diff.txt
> @@ -225,3 +225,7 @@ diff.colorMovedWS::
>  	When moved lines are colored using e.g. the `diff.colorMoved` 
setting,
>  	this option controls the `<mode>` how spaces are treated
>  	for details of valid modes see '--color-moved-ws' in linkgit:git-
diff[1].
> +
> +diff.wordDiff::
> +	Show a word diff, using the `<mode>` to delimit changed words.
> +	For details of valid modes see '--word-diff' in linkgit:git-diff[1].

Let's enforce the new formatting rules: placeholders are _emphasized_  and 
options are `verbatim`

+
 +diff.wordDiff::
 +	Show a word diff, using the _<mode>_ to delimit changed words.
 +	For details of valid modes see `--word-diff` in linkgit:git-diff[1].


> diff --git a/diff.c b/diff.c
> index e50def4538..050d83ef85 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -69,6 +69,7 @@ static int diff_dirstat_permille_default = 30;
>  static struct diff_options default_diff_options;
>  static long diff_algorithm;
>  static unsigned ws_error_highlight_default = WSEH_NEW;
> +static int diff_word_diff_default;
>  
>  static char diff_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_RESET,
> @@ -209,6 +210,23 @@ int git_config_rename(const char *var, const char 
*value)
>  	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
>  }
>  
> +static int parse_word_diff_value(const char *value)
> +{
> +	if (!value)
> +		return -1;
> +	else if (!strcmp(value, "plain"))
> +		return DIFF_WORDS_PLAIN;
> +	else if (!strcmp(value, "color")) {
> +		return DIFF_WORDS_COLOR;
> +	}
> +	else if (!strcmp(value, "porcelain"))
> +		return DIFF_WORDS_PORCELAIN;
> +	else if (!strcmp(value, "none"))
> +		return DIFF_WORDS_NONE;
> +
> +	return -1;
> +}
> +
>  long parse_algorithm_value(const char *value)
>  {
>  	if (!value)
> @@ -452,6 +470,18 @@ int git_diff_ui_config(const char *var, const char 
*value,
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "diff.worddiff")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		diff_word_diff_default = parse_word_diff_value(value);
> +		if (diff_word_diff_default < 0)
> +			return error(_("unknown value for config '%s': 
%s"),

Thanks for reusing already an already existing translatable string.

> +				     var, value);
> +		if (diff_word_diff_default == DIFF_WORDS_COLOR)
> +			diff_use_color_default = 1;
> +		return 0;
> +	}
> +
>  	if (git_color_config(var, value, cb) < 0)
>  		return -1;
>  
> @@ -4724,6 +4754,7 @@ void repo_diff_setup(struct repository *r, struct 
diff_options *options)
>  	options->use_color = diff_use_color_default;
>  	options->detect_rename = diff_detect_rename_default;
>  	options->xdl_opts |= diff_algorithm;
> +	options->word_diff |= diff_word_diff_default;
>  	if (diff_indent_heuristic)
>  		DIFF_XDL_SET(options, INDENT_HEURISTIC);
>  
> @@ -5504,21 +5535,18 @@ static int diff_opt_word_diff(const struct option 
*opt,
>  			      const char *arg, int unset)
>  {
>  	struct diff_options *options = opt->value;
> +	int value;
>  
>  	BUG_ON_OPT_NEG(unset);
> +
>  	if (arg) {
> -		if (!strcmp(arg, "plain"))
> -			options->word_diff = DIFF_WORDS_PLAIN;
> -		else if (!strcmp(arg, "color")) {
> -			options->use_color = 1;
> -			options->word_diff = DIFF_WORDS_COLOR;
> -		}
> -		else if (!strcmp(arg, "porcelain"))
> -			options->word_diff = DIFF_WORDS_PORCELAIN;
> -		else if (!strcmp(arg, "none"))
> -			options->word_diff = DIFF_WORDS_NONE;
> -		else
> +		value = parse_word_diff_value(arg);
> +		if (value < 0)
>  			return error(_("bad --word-diff argument: 
%s"), arg);
> +		if (value == DIFF_WORDS_COLOR)
> +			options->use_color = 1;
> +
> +		options->word_diff = value;
>  	} else {
>  		if (options->word_diff == DIFF_WORDS_NONE)
>  			options->word_diff = DIFF_WORDS_PLAIN;
> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index 4f70aa6e9f..2cc391c339 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh
> @@ -56,12 +56,19 @@ diff_with_opts () {
>  	post=$(git rev-parse --short $(git hash-object post)) &&
>  	test_must_fail git diff --no-index "$@" pre post >output &&
>  	test_decode_color <output >output.decrypted &&
> -	sed -e "2s/index [^ ]*/index $pre..$post/" expect >expected
> +	sed -e "2s/index [^ ]*/index $pre..$post/" expect >expected &&
>  	test_cmp expected output.decrypted
>  }
>  
>  word_diff () {
> -	diff_with_opts "--word-diff=$1" $(echo "$@" | cut -d' ' -s -f 2-)
> +	# Capture the rest of the arguments to passthrough.
> +	rest=$(echo "$@" | cut -d' ' -s -f 2-) &&
> +	# Test via the config route.
> +	git config diff.wordDiff $1 &&
> +	diff_with_opts $rest &&
> +	git config --unset diff.wordDiff &&
> +	# Test via the command option route.
> +	diff_with_opts "--word-diff=$1" $rest
>  }
>  
>  test_language_driver () {
> 

Thanks


