Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6B8C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31285206CA
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="InnwmodY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgKWWVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgKWWVa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 17:21:30 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B66C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:21:29 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id n137so6320207pfd.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=euNr/YDbd5AFuxzIiGL3gr3zkSTh5W0h8KYu7s/Oy1w=;
        b=InnwmodYt+5yhvN6xvn4+6ek6kvtWDUx+WQYEGP6NALCD8+ryORW1jCBly2HK0WhtN
         QsTbp3Em00GtAnJylohzaetZFHj7L0RBJren2xCvD0fr9K46iSNc/da8XvaD1jkwuMcn
         W5ROdyHsx9ZomhWZJpWJmnXJ/AkiW822s5Dc9JIcXHxns6qh232oq/cVwc1NhNp+8xXn
         jRnyH/baokAKHaIgRB4jWnppKwLwkpVIBsAsrwkxmk2cCwoNUAHEGkSkrronT9Za8m78
         +clVqvAWUusPvY/y2vQHdVz+ECgSjck2QU2WLb+raS+rqnIvLoIKFZbInYHcYgRkFMV7
         KkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=euNr/YDbd5AFuxzIiGL3gr3zkSTh5W0h8KYu7s/Oy1w=;
        b=ptQCmbdcKrI6uZX8kgXgliZ+K230wikNwiTaOQZazG84IkmCwvxhQ/2t+CCQ8ohFox
         mR3RQxnR0T3lH0VehOqUQxm0xo22Vk+SgButJsG7cdhWWd+NsYtuTe3vqC56ebM5jPnr
         /z75mxLGH8VO3UlLrgwJSAKkQKAghRBOozxEigmWPGpqovldv+ESRFJn4VzzMXXPklfr
         5NIDYwJUTj0vWnw9lu/2TdU71uCStzgeYOSpLIfiErTm5ogvj6FIDvn+KlPTnB+SF5Wd
         DI1MFw1R/LO+8TGwjV2g+rSjjfChl62IDmAKqb0fcY8jgQbYKqBndqxg14r9DwYGKzBT
         MUtw==
X-Gm-Message-State: AOAM532Nhjtr+QSiJ6J4lrBEJsFa0G55V/Arab9mWuB+5JU/Uxs+LALT
        RQFiHufz3nm9nnTY8QA2QYEfQQ==
X-Google-Smtp-Source: ABdhPJxUrS5fCiyLPcsmufBb/AmCPbRtV2gbE+AIJqgg0QG1oTOJI3pDE/w0X+/4MAhMIkkZ60vqHw==
X-Received: by 2002:aa7:9490:0:b029:197:cb4b:b678 with SMTP id z16-20020aa794900000b0290197cb4bb678mr1360050pfk.59.1606170088975;
        Mon, 23 Nov 2020 14:21:28 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id y81sm13272738pfc.25.2020.11.23.14.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 14:21:28 -0800 (PST)
Date:   Mon, 23 Nov 2020 14:21:23 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 5/7] config: plumb --fixed-value into config API
Message-ID: <20201123222123.GE499823@google.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
 <39718048cd8f5be053a13ff73f531e3400b80b25.1606147507.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39718048cd8f5be053a13ff73f531e3400b80b25.1606147507.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 04:05:05PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> 
> The git_config_set_multivar_in_file_gently() and related methods now
> take a 'flags' bitfield, so add a new bit representing the --fixed-value
> option from 'git config'. This alters the purpose of the value_regex
> parameter to be an exact string match. This requires some initialization
> changes in git_config_set_multivar_in_file_gently() and a new strcmp()
> call in the matches() method.
> 
> The new CONFIG_FLAGS_FIXED_VALUE flag is initialized in builtin/config.c
> based on the --fixed-value option, and that needs to be updated in
> several callers.
> 
> This patch only affects some of the modes of 'git config', and the rest
> will be completed in the next change.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/config.c  | 16 ++++++++-----
>  config.c          |  5 +++++
>  config.h          |  7 ++++++
>  t/t1300-config.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 80 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/config.c b/builtin/config.c
> index bfb55a96df..3e49e04411 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -616,6 +616,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  {
>  	int nongit = !startup_info->have_repository;
>  	char *value;
> +	int flags = 0;
>  
>  	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
>  
> @@ -769,6 +770,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  			error(_("--fixed-value only applies with 'value_regex'"));
>  			usage_builtin_config();
>  		}
> +
> +		flags = CONFIG_FLAGS_FIXED_VALUE;

I wonder whether using |= here will save someone from a headache later,
when they want to add another flag value or move the
CONFIG_FLAGS_MULTI_REPLACE calculation out of the tail calls below.

[snip]
>  	}
>  	else if (actions == ACTION_REPLACE_ALL) {
>  		check_write();
> @@ -850,7 +855,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		UNLEAK(value);
>  		return git_config_set_multivar_in_file_gently(given_config_source.file,
>  							      argv[0], value, argv[2],
> -							      CONFIG_FLAGS_MULTI_REPLACE);
> +							      flags | CONFIG_FLAGS_MULTI_REPLACE);
[snip]
> @@ -887,7 +893,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		check_argc(argc, 1, 2);
>  		return git_config_set_multivar_in_file_gently(given_config_source.file,
>  							      argv[0], NULL, argv[1],
> -							      CONFIG_FLAGS_MULTI_REPLACE);
> +							      flags | CONFIG_FLAGS_MULTI_REPLACE);

> --- a/config.c
> +++ b/config.c
> @@ -2402,6 +2402,7 @@ struct config_store_data {
>  	size_t baselen;
>  	char *key;
>  	int do_not_match;
> +	const char *literal_value;
>  	regex_t *value_regex;
>  	int multi_replace;
>  	struct {
> @@ -2431,6 +2432,8 @@ static int matches(const char *key, const char *value,
>  {
>  	if (strcmp(key, store->key))
>  		return 0; /* not ours */
> +	if (store->literal_value)
> +		return !strcmp(store->literal_value, value);

Nice. Short-circuiting the entire regex process if necessary.

> @@ -2803,6 +2806,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
>  			store.value_regex = NULL;
>  		else if (value_regex == CONFIG_REGEX_NONE)
>  			store.value_regex = CONFIG_REGEX_NONE;
> +		else if (flags & CONFIG_FLAGS_FIXED_VALUE)
> +			store.literal_value = value_regex;

Ah, so we use .literal_value instead of pulling the string from
value_regex because value_regex undergoes some special parsing and is
packed into a regex_t instead.

>  		else {
>  			if (value_regex[0] == '!') {
>  				store.do_not_match = 1;
> diff --git a/config.h b/config.h
> index 80844604ab..977e690be8 100644
> --- a/config.h
> +++ b/config.h
> @@ -269,6 +269,13 @@ int git_config_key_is_valid(const char *key);
>   */
>  #define CONFIG_FLAGS_MULTI_REPLACE (1 << 0)
>  
> +/*
> + * When CONFIG_FLAGS_FIXED_VALUE is specified, match key/value pairs
> + * by string comparison (not regex match) to the provided value_regex
In contrast to my comment elsewhere, I think here it makes sense to talk
about strcmp like you did. But notice that here in the dev-facing
documentation you said "not regex" - so I think that you thought it was
a useful distinction, but forgot to say so to the user.
> + * parameter.
> + */
> +#define CONFIG_FLAGS_FIXED_VALUE (1 << 1)
> +

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 6dc8117241..30e80ae9cb 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> +test_expect_success '--fixed-value uses exact string matching' '
> +	GLOB="a+b*c?d[e]f.g" &&
> +	rm -f initial &&
This tells me that when you used 'initial' earlier you probably should
have done something like 'test_when_finished rm initial' in this test
and your earlier ones. Whoops.

> +	git config --file=initial fixed.test "$GLOB" &&
> +
> +	cp initial config &&
> +	git config --file=config fixed.test bogus "$GLOB" &&
> +	git config --file=config --list >actual &&
> +	cat >expect <<-EOF &&
> +	fixed.test=$GLOB
> +	fixed.test=bogus
> +	EOF
> +	test_cmp expect actual &&
> +
> +	cp initial config &&
> +	git config --file=config --fixed-value fixed.test bogus "$GLOB" &&
> +	git config --file=config --list >actual &&
> +	printf "fixed.test=bogus\n" >expect &&
It is jarring to me to see a printf here when everywhere else we use
heredocs. 'git grep' tells me it's not unheard of, but it looks like
those are cases where the whole file doesn't use heredocs.

> +	test_cmp expect actual &&
> +
> +	cp initial config &&
> +	test_must_fail git config --file=config --unset fixed.test "$GLOB" &&
> +	git config --file=config --fixed-value --unset fixed.test "$GLOB" &&
> +	test_must_fail git config --file=config fixed.test &&
Is this one supposed to verify that there is a 'fixed.test' value
already in 'config'? I'd prefer to see that explicitly checked with 'git
config --get' rather than watching for a symptom, that is, fail to set.
This comment applies to the next case too.

> +
> +	cp initial config &&
> +	test_must_fail git config --file=config --unset-all fixed.test "$GLOB" &&
> +	git config --file=config --fixed-value --unset-all fixed.test "$GLOB" &&
> +	test_must_fail git config --file=config fixed.test &&
> +
> +	cp initial config &&
> +	git config --file=config --replace-all fixed.test bogus "$GLOB" &&
> +	git config --file=config --list >actual &&
> +	cat >expect <<-EOF &&
> +	fixed.test=$GLOB
> +	fixed.test=bogus
> +	EOF
> +	test_cmp expect actual &&
Hm, isn't this the same functionality as the tests you added at the
beginning of this series? I guess you are setting up for the last case
with --replace-all...
> +
> +	cp initial config &&
> +	git config --file=config --replace-all fixed.test bogus "$GLOB" &&
> +	git config --file=config --list >actual &&
> +	cat >expect <<-EOF &&
> +	fixed.test=$GLOB
> +	fixed.test=bogus
> +	EOF
> +	test_cmp expect actual &&

Is this one identical to the previous one? I think it is, but if it
isn't and I can't tell, all the more reason that each case here should
either be labeled with a comment or separated into its own test. (Bonus
- you could extend the individual tests from patch 1 to make sure they
work correctly with --fixed-value too ;) )

> +
> +	git config --file=config --fixed-value --replace-all fixed.test bogus "$GLOB" &&
> +	git config --file=config --list >actual &&
> +	cat >expect <<-EOF &&
> +	fixed.test=bogus
> +	fixed.test=bogus

Hum, it does what it says on the box, but is this a valid config, I
wonder?

  $ git config --file=test foo.test aaa
  $ git config --file=test --add foo.test bbb
  $ git config --list --file=test
  foo.test=aaa
  foo.test=bbb
  $ git config --file=test --replace-all foo.test bbb a+
  $ git config --list --file=test
  foo.test=bbb
  foo.test=bbb

So I guess it's fine :)

 - Emily
