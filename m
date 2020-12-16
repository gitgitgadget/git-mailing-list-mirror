Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA30C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B0B20639
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgLPUCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 15:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgLPUCa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 15:02:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0845DC061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:01:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w5so20624565wrm.11
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=scolVVAgLe9ok9VWdSZD8oykzgdl8F6jCxQl+LUTs7k=;
        b=vKR7kghHWt2ZeAEwklrx6M0c4zHSlmBP0kllJzQzdf9G+uv9WPBw4fFnMlA/Uu9JR3
         CUfkf1Nj2ENkFCOyYKBGOXoRZT2qaHkZMP/cJLcKPrRplSPqI9NSPOsZBnQtKGSEiMib
         F3sNhPGuJFB3mnarwzYenkIAxewvObJ35vLn1CHdqMQs+PHe2iWI0mqesTS78QQuMVL/
         AXaMIH6iA3qRz42SMwHj2uIQdhxBM0aWFW7KD7xOyY5UMcYjaR/H3GjZ9gd/2WZ51GO0
         2G6Bs/KxmzuL/nSUnhm+Kghlbm/VfdaRaLcN5YdYmh9rcJ9KHyqFK3Yjv+f4dkndnRSD
         iRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=scolVVAgLe9ok9VWdSZD8oykzgdl8F6jCxQl+LUTs7k=;
        b=Y/HoW8m4jo/YxyTJV5JcuBbk8AgtX91sPTNErNLXLuaAMey52c2JtLtAUtSi+KwZ28
         PWoN1ng4CVkAKtbbkQd+IB4HU8A6x1heCPHyHOgwb6xPGWVH+NgqVbhgZLcy75KE4VSq
         JFbior67pgJpG2sgUYlESb11fjV/bnUqwtSh2gY1H2K0OWKiNvfmDRvUOfESyhFH//wF
         wTC1gHuXdRw3eiX8NwpW/nIRdPAxn3SOZZeIB58VHspkO14VUPZu4EbghY2IZOx8DkCA
         kbAjPc75tVI+X72mCIvCPXMP+qLz4DKj7xyhZPUDrHbO61nc+Hp9agcfsFBrl4+vKV0p
         38Ew==
X-Gm-Message-State: AOAM533lOGllVAyY1bfdolVLzX/YSAOA04toOpq5u5GJwe1JuA3aSA2b
        VGYG9v+MEZJmEj+yQnEx9x/3PgVanWw=
X-Google-Smtp-Source: ABdhPJwk8EaXaz81J14nAU4xCBvACx8goZWzQXdR2LP9+5jEr3AQwWLGQo93MpS21q9eQh3rHMDR3w==
X-Received: by 2002:a5d:69c2:: with SMTP id s2mr8474565wrw.36.1608148908548;
        Wed, 16 Dec 2020 12:01:48 -0800 (PST)
Received: from [192.168.1.240] (108.45.90.146.dyn.plus.net. [146.90.45.108])
        by smtp.gmail.com with ESMTPSA id p9sm4067104wmm.17.2020.12.16.12.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 12:01:47 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 6/8] config: parse more robust format in
 GIT_CONFIG_PARAMETERS
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
References: <cover.1606214397.git.ps@pks.im> <cover.1608104755.git.ps@pks.im>
 <d832f3dedf5bde4cd9389ddab734703ff2dbd5a1.1608104755.git.ps@pks.im>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ccb476b8-9835-3810-c272-b74822fe74eb@gmail.com>
Date:   Wed, 16 Dec 2020 20:01:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <d832f3dedf5bde4cd9389ddab734703ff2dbd5a1.1608104755.git.ps@pks.im>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Patrick/Peff

On 16/12/2020 07:57, Patrick Steinhardt wrote:
> From: Jeff King <peff@peff.net>
> 
> When we stuff config options into GIT_CONFIG_PARAMETERS, we shell-quote
> each one as a single unit, like:
> 
>    'section.one=value1' 'section.two=value2'
> 
> On the reading side, we de-quote to get the individual strings, and then
> parse them by splitting on the first "=" we find. This format is
> ambiguous, because an "=" may appear in a subsection. So the config
> represented in a file by both:
> 
>    [section "subsection=with=equals"]
>    key = value
> 
> and:
> 
>    [section]
>    subsection = with=equals.key=value
> 
> ends up in this flattened format like:
> 
>    'section.subsection=with=equals.key=value'
> 
> and we can't tell which was desired. We have traditionally resolved this
> by taking the first "=" we see starting from the left, meaning that we
> allowed arbitrary content in the value, but not in the subsection.

I was just wondering what happens if a subsection name contains a single 
quote - can we handle that now and how is it affected by this change?

Best Wishes

Phillip

> Let's make our environment format a bit more robust by separately
> quoting the key and value. That turns those examples into:
> 
>    'section.subsection=with=equals.key'='value'
> 
> and:
> 
>    'section.subsection'='with=equals.key=value'
> 
> respectively, and we can tell the difference between them. We can detect
> which format is in use for any given element of the list based on the
> presence of the unquoted "=". That means we can continue to allow the
> old format to work to support any callers which manually used the old
> format, and we can even intermingle the two formats. The old format
> wasn't documented, and nobody was supposed to be using it. But it's
> likely that such callers exist in the wild, so it's nice if we can avoid
> breaking them. Likewise, it may be possible to trigger an older version
> of "git -c" that runs a script that calls into a newer version of "git
> -c"; that new version would see the intermingled format.
> 
> This does create one complication, which is that the obvious format in
> the new scheme for
> 
>    [section]
>    some-bool
> 
> is:
> 
>    'section.some-bool'
> 
> with no equals. We'd mistake that for an old-style variable. And it even
> has the same meaning in the old style, but:
> 
>    [section "with=equals"]
>    some-bool
> 
> does not. It would be:
> 
>    'section.with=equals=some-bool'
> 
> which we'd take to mean:
> 
>    [section]
>    with = equals=some-bool
> 
> in the old, ambiguous style. Likewise, we can't use:
> 
>    'section.some-bool'=''
> 
> because that's ambiguous with an actual empty string. Instead, we'll
> again use the shell-quoting to give us a hint, and use:
> 
>    'section.some-bool'=
> 
> to show that we have no value.
> 
> Note that this commit just expands the reading side. We'll start writing
> the new format via "git -c" in a future patch. In the meantime, the
> existing "git -c" tests will make sure we didn't break reading the old
> format. But we'll also add some explicit coverage of the two formats to
> make sure we continue to handle the old one after we move the writing
> side over.
> 
> And one final note: since we're now using the shell-quoting as a
> semantically meaningful hint, this closes the door to us ever allowing
> arbitrary shell quoting, like:
> 
>    'a'shell'would'be'ok'with'this'.key=value
> 
> But we have never supported that (only what sq_quote() would produce),
> and we are probably better off keeping things simple, robust, and
> backwards-compatible, than trying to make it easier for humans. We'll
> continue not to advertise the format of the variable to users, and
> instead keep "git -c" as the recommended mechanism for setting config
> (even if we are trying to be kind not to break users who may be relying
> on the current undocumented format).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   config.c          | 69 +++++++++++++++++++++++++++++++++++------------
>   t/t1300-config.sh | 52 +++++++++++++++++++++++++++++++++++
>   2 files changed, 104 insertions(+), 17 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 53ed048689..60a7261807 100644
> --- a/config.c
> +++ b/config.c
> @@ -541,14 +541,62 @@ int git_config_parse_parameter(const char *text,
>   	return ret;
>   }
>   
> +static int parse_config_env_list(char *env, config_fn_t fn, void *data)
> +{
> +	char *cur = env;
> +	while (cur && *cur) {
> +		const char *key = sq_dequote_step(cur, &cur);
> +		if (!key)
> +			return error(_("bogus format in %s"),
> +				     CONFIG_DATA_ENVIRONMENT);
> +
> +		if (!cur || isspace(*cur)) {
> +			/* old-style 'key=value' */
> +			if (git_config_parse_parameter(key, fn, data) < 0)
> +				return -1;
> +		}
> +		else if (*cur == '=') {
> +			/* new-style 'key'='value' */
> +			const char *value;
> +
> +			cur++;
> +			if (*cur == '\'') {
> +				/* quoted value */
> +				value = sq_dequote_step(cur, &cur);
> +				if (!value || (cur && !isspace(*cur))) {
> +					return error(_("bogus format in %s"),
> +						     CONFIG_DATA_ENVIRONMENT);
> +				}
> +			} else if (!*cur || isspace(*cur)) {
> +				/* implicit bool: 'key'= */
> +				value = NULL;
> +			} else {
> +				return error(_("bogus format in %s"),
> +					     CONFIG_DATA_ENVIRONMENT);
> +			}
> +
> +			if (config_parse_pair(key, value, fn, data) < 0)
> +				return -1;
> +		}
> +		else {
> +			/* unknown format */
> +			return error(_("bogus format in %s"),
> +				     CONFIG_DATA_ENVIRONMENT);
> +		}
> +
> +		if (cur) {
> +			while (isspace(*cur))
> +				cur++;
> +		}
> +	}
> +	return 0;
> +}
> +
>   int git_config_from_parameters(config_fn_t fn, void *data)
>   {
>   	const char *env = getenv(CONFIG_DATA_ENVIRONMENT);
>   	int ret = 0;
>   	char *envw;
> -	const char **argv = NULL;
> -	int nr = 0, alloc = 0;
> -	int i;
>   	struct config_source source;
>   
>   	if (!env)
> @@ -561,21 +609,8 @@ int git_config_from_parameters(config_fn_t fn, void *data)
>   
>   	/* sq_dequote will write over it */
>   	envw = xstrdup(env);
> +	ret = parse_config_env_list(envw, fn, data);
>   
> -	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
> -		ret = error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
> -		goto out;
> -	}
> -
> -	for (i = 0; i < nr; i++) {
> -		if (git_config_parse_parameter(argv[i], fn, data) < 0) {
> -			ret = -1;
> -			goto out;
> -		}
> -	}
> -
> -out:
> -	free(argv);
>   	free(envw);
>   	cf = source.prev;
>   	return ret;
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 36a60879f6..35a1a6e8b1 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1294,6 +1294,58 @@ test_expect_success 'git -c is not confused by empty environment' '
>   	GIT_CONFIG_PARAMETERS="" git -c x.one=1 config --list
>   '
>   
> +test_expect_success 'GIT_CONFIG_PARAMETERS handles old-style entries' '
> +	v="${SQ}key.one=foo${SQ}" &&
> +	v="$v  ${SQ}key.two=bar${SQ}" &&
> +	v="$v ${SQ}key.ambiguous=section.whatever=value${SQ}" &&
> +	GIT_CONFIG_PARAMETERS=$v git config --get-regexp "key.*" >actual &&
> +	cat >expect <<-EOF &&
> +	key.one foo
> +	key.two bar
> +	key.ambiguous section.whatever=value
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'GIT_CONFIG_PARAMETERS handles new-style entries' '
> +	v="${SQ}key.one${SQ}=${SQ}foo${SQ}" &&
> +	v="$v  ${SQ}key.two${SQ}=${SQ}bar${SQ}" &&
> +	v="$v ${SQ}key.ambiguous=section.whatever${SQ}=${SQ}value${SQ}" &&
> +	GIT_CONFIG_PARAMETERS=$v git config --get-regexp "key.*" >actual &&
> +	cat >expect <<-EOF &&
> +	key.one foo
> +	key.two bar
> +	key.ambiguous=section.whatever value
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'old and new-style entries can mix' '
> +	v="${SQ}key.oldone=oldfoo${SQ}" &&
> +	v="$v ${SQ}key.newone${SQ}=${SQ}newfoo${SQ}" &&
> +	v="$v ${SQ}key.oldtwo=oldbar${SQ}" &&
> +	v="$v ${SQ}key.newtwo${SQ}=${SQ}newbar${SQ}" &&
> +	GIT_CONFIG_PARAMETERS=$v git config --get-regexp "key.*" >actual &&
> +	cat >expect <<-EOF &&
> +	key.oldone oldfoo
> +	key.newone newfoo
> +	key.oldtwo oldbar
> +	key.newtwo newbar
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'old and new bools with ambiguous subsection' '
> +	v="${SQ}key.with=equals.oldbool${SQ}" &&
> +	v="$v ${SQ}key.with=equals.newbool${SQ}=" &&
> +	GIT_CONFIG_PARAMETERS=$v git config --get-regexp "key.*" >actual &&
> +	cat >expect <<-EOF &&
> +	key.with equals.oldbool
> +	key.with=equals.newbool
> +	EOF
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'detect bogus GIT_CONFIG_PARAMETERS' '
>   	cat >expect <<-\EOF &&
>   	env.one one
> 
