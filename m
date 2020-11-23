Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C173FC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBCE206CA
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8IY9H++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbgKWVv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 16:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgKWVv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 16:51:28 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8F8C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 13:51:28 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id n137so6231999pfd.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 13:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ppTcEdf0GTaZFvHQPlEhllAvXHqtYYtLM0CPsiYv3Oo=;
        b=H8IY9H++uT2gCSqpwx4E8Ttd6cmHKsnsNLxg9Ka8W6HcECUhlMPwMNDKu6CYqhxhKC
         RHEhUtEZMkFLqMOSnwrVC754yF6kZs9TqiVnN2k9TCMXQPCx3BsVeQHS6NzPwiXl9qzz
         ub/72YFJcoNdYKtayz2mJ/yrvVOzw34rP/OE+IYwOBwsXgcNNScyv9pkAjKxU4LX/PC6
         xVTYVbGIesljUjwMeReG7KodukdGsUQdTcliAIByb5rRzrX2pMss0Uo3YT49pZX3XhgY
         UjNlMDQSUTry6a2RxBVRkG0oiA6im948HwVE72oKk2QtNcBiHpdElUTtXFSDnHizkeL1
         ANsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ppTcEdf0GTaZFvHQPlEhllAvXHqtYYtLM0CPsiYv3Oo=;
        b=cg/9KyPTr9/OWe0Mpx+mr4rESV7GpGNy+4ebRCzj+sbF6W21tplxx2YK/MWb0jRHgW
         isosxiZTbIHxOlxPnHI4nIOhKmAA8ijNp6BA8kEvfKpY/+OUAQ6mBs41PJ1kUqmYUKrH
         3Kfss8u3dT9ZKt7FemHZpR8dUKYlggaU8hsSkqdNfcXhhY/t6wzrcbJjeTPWXZRuwxwi
         rh0ay3vfk5rbE429s5UkAQO/buvMLWxAVEQ65oIopdlqpGvPSFwnXQPoCW2zJ6VCG42S
         SKKOmNSzw+BoxoRtEWo01UL/qoLBPkkb55uE2nKSUj+qheQs3sbtEUEFP2/1GsGEQZaw
         C1TA==
X-Gm-Message-State: AOAM531pb9O7DVwTh8bSlKikwAOjTzLjrrj1XFtD0NuyDQTOIx9m8oU/
        4m9sWm+ilXVzUiK48dqey9bbyHY2tJJWdA==
X-Google-Smtp-Source: ABdhPJwXYyH3/PhWDXAuA5j9m5g20mGZ1Hjr9OGM4RbIdBhAjSW8ssgFkGo+RkDHo+eYhpuu5NQgSA==
X-Received: by 2002:a17:90b:1058:: with SMTP id gq24mr1055127pjb.29.1606168287692;
        Mon, 23 Nov 2020 13:51:27 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id i4sm11256769pgg.67.2020.11.23.13.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 13:51:27 -0800 (PST)
Date:   Mon, 23 Nov 2020 13:51:22 -0800
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
Subject: Re: [PATCH v2 4/7] config: add --fixed-value option, un-implemented
Message-ID: <20201123215122.GD499823@google.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
 <0e6a7371ed4696f6cc85df07466fb6c20d58d62e.1606147507.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6a7371ed4696f6cc85df07466fb6c20d58d62e.1606147507.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 04:05:04PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> 
> The 'git config' builtin takes a 'value_regex' parameter for several
> actions. This can cause confusion when expecting exact value matches
> instead of regex matches, especially when the input string contains glob
> characters. While callers can escape the patterns themselves, it would
> be more friendly to allow an argument to disable the pattern matching in
> favor of an exact string match.
> 
> Add a new '--fixed-value' option that does not currently change the
> behavior. The implementation will follow for each appropriate action.
> For now, check and test that --fixed-value will abort the command when
> included with an incompatible action or without a 'value_regex'
> argument.
> 
> The name '--fixed-value' was chosen over something simpler like
> '--fixed' because some commands allow regular expressions on the
> key in addition to the value.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-config.txt | 20 +++++++++++++-------
>  builtin/config.c             | 26 ++++++++++++++++++++++++++
>  t/t1300-config.sh            | 23 +++++++++++++++++++++++
>  3 files changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 7573160f21..d4bb928ea7 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -34,6 +34,7 @@ static int respect_includes_opt = -1;
>  static struct config_options config_options;
>  static int show_origin;
>  static int show_scope;
> +static int fixed_value;
>  
>  #define ACTION_GET (1<<0)
>  #define ACTION_GET_ALL (1<<1)
> @@ -141,6 +142,7 @@ static struct option builtin_config_options[] = {
>  	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
>  	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
>  	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
> +	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when matching values")),
I'm not sure how to feel about this phrasing. I wonder if it would be
clearer to say something like 'treat 'value_regex' as a literal string
instead'? Hmmm.

> +	if (fixed_value) {
> +		int allowed_usage = 0;
> +
> +		switch (actions) {
> +		case ACTION_GET:
> +		case ACTION_GET_ALL:
> +		case ACTION_GET_REGEXP:
> +		case ACTION_UNSET:
> +		case ACTION_UNSET_ALL:
> +			allowed_usage = argc > 1 && !!argv[1];
> +			break;
> +
> +		case ACTION_SET_ALL:
> +		case ACTION_REPLACE_ALL:
> +			allowed_usage = argc > 2 && !!argv[2];
> +			break;
> +		}
> +
> +		if (!allowed_usage) {
> +			error(_("--fixed-value only applies with 'value_regex'"));
> +			usage_builtin_config();
> +		}
> +	}
> +

To me this really needs a comment. I think you are checking whether the
value_regex is actually present, and the position of that regex changes
depending on the rest of the arg list... What about something like:

  /* If set, ensure 'value_regex' was provided also */
  if (fixed_value) {
    ...
    /* 'git config --unset-all <key> <value_regex>' */
    case ACTION_UNSET_ALL:
    ...
    /* 'git config --replace-all <key> <new value> <value_regex>' */
    case ACTION_REPLACE_ALL:
    ...

> +test_expect_success 'refuse --fixed-value for incompatible actions' '
> +	git config --file=config dev.null bogus &&
> +
> +	# These modes do not allow --fixed-value at all
> +	test_must_fail git config --file=config --fixed-value --add dev.null bogus &&
> +	test_must_fail git config --file=config --fixed-value --get-urlmatch dev.null bogus &&
> +	test_must_fail git config --file=config --fixed-value --get-urlmatch dev.null bogus &&
> +	test_must_fail git config --file=config --fixed-value --rename-section dev null &&
> +	test_must_fail git config --file=config --fixed-value --remove-section dev &&
> +	test_must_fail git config --file=config --fixed-value --list &&
> +	test_must_fail git config --file=config --fixed-value --get-color dev.null &&
> +	test_must_fail git config --file=config --fixed-value --get-colorbool dev.null &&
> +
> +	# These modes complain when --fixed-value has no value_regex
> +	test_must_fail git config --file=config --fixed-value dev.null bogus &&
> +	test_must_fail git config --file=config --fixed-value --replace-all dev.null bogus &&
> +	test_must_fail git config --file=config --fixed-value --get dev.null &&
> +	test_must_fail git config --file=config --fixed-value --get-all dev.null &&
> +	test_must_fail git config --file=config --fixed-value --get-regexp "dev.*" &&
> +	test_must_fail git config --file=config --fixed-value --unset dev.null &&
> +	test_must_fail git config --file=config --fixed-value --unset-all dev.null
> +'
> +

I'd expect to see a positive test as well, which you could later evolve
into a test to ensure behavior.

 - Emily
