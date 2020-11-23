Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73023C63777
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1626D206E3
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPI32aVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbgKWThU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbgKWThU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:37:20 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58764C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 11:37:20 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t8so15874879pfg.8
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 11:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3FLewHKCeuaOWG1MGq7iW1BJrJbBg/8yzT7vuoYU5Tg=;
        b=UPI32aVpNtSOLd+KG2zJUXpHhQ9qGnqCGECqttzr+pLDOzjPjuBQo4fOWrRLfATgXh
         wefLRvZfWuZ03WqfRw8WdBIATxXasTD5J0AelQdUvZTzFEEzJ4d1esBya0ohpr9yUy6E
         cexzEZNOH5njuUWKxCIhZK/Y2ODQK1tr86dsPH4YgmBrxzmbLCk+yJpvWbB7uOe/X72V
         3Qo/K0yrMTuhoMaTydONZONgGmjR2n1dh9J508Wq6d5tz7Vq8kmQ39pgd2SvVY/rsgnm
         0WH0QS/rwd0ZRuyYsUwYJ8Qh45QNJeDokV1vUj1CLEJyTWyZe/4wJwkeQhlEv7tznLwr
         7dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3FLewHKCeuaOWG1MGq7iW1BJrJbBg/8yzT7vuoYU5Tg=;
        b=jaoPrplgnxUO9pmdLu36rqEs/JLUDQnzgEtz5dw/ojcPvNESNT8gGGKZ80I+1OlSC9
         +E0qcAMrbkDeYi7ou7x4NSlblItFy13EHDoEYHVGNYOOps+XqXx4yD81BBQh9pGPbBqw
         dEJhxoy3tBooe2XIvkg/H0XcuZnpASGlvMflXNZJKYSHnADPB01SihBU8NohWTxEu7YC
         td07HZH+TkOF5xoiOrMKfZpL10ik6YDXf4Cw6anPiiSdwUX42D+0kV7t/Vz9jDBOLTnn
         VGe26TiIzlpN0sGeTkFLuYeDKX9VHW47VSOuZyxIh5L+xhyr6k3qGhr12h+hGDbzDXKE
         Aqfw==
X-Gm-Message-State: AOAM531dCQ4+MR6WuyJ5OLxzVsV+yxBkdHl0+NSJvy9t1iXWMRFsqBB7
        7N0i66dM1tRrzKN6tvXgj8c95Q==
X-Google-Smtp-Source: ABdhPJzVmPDtVfnF+cUTSolwrn+ga1QYys73ATQXZaNReyOehgrxo+HVZhznFxvcXYgPifBbHF27xA==
X-Received: by 2002:a17:90b:80c:: with SMTP id bk12mr542887pjb.176.1606160239639;
        Mon, 23 Nov 2020 11:37:19 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id 21sm12677239pfw.105.2020.11.23.11.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 11:37:19 -0800 (PST)
Date:   Mon, 23 Nov 2020 11:37:14 -0800
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
Subject: Re: [PATCH v2 1/7] t1300: test "set all" mode with value_regex
Message-ID: <20201123193714.GA499823@google.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
 <ea3099719c867a5a475468ddb6741bbcd713dccc.1606147507.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea3099719c867a5a475468ddb6741bbcd713dccc.1606147507.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 04:05:01PM +0000, Derrick Stolee via GitGitGadget wrote:
> Add a test that demonstrates these options. Break from the existing
> pattern in t1300-config.sh to use 'git config --file=<file>' instead of
> modifying .git/config directly. Also use 'git config --file=<file>
> --list' for config state comparison instead of the config file format.

I'd normally say "but *why* do you want to do that?" but I think it's
actually pretty clear in the diff based on the naming of the config
files (and clever - I like it). I do think pointing out that you're
breaking from existing style is useful since the existing style isn't
contained in the diff alone.

> +test_expect_success 'set all config with value_regex' '
> +	git config --file=initial abc.key one &&
> +
> +	cp initial config &&
> +	git config --file=config abc.key two a+ &&
Make sure that if the value_regex misses existing keys, it can still add
normally.
> +	git config --file=config --list >actual &&
> +	cat >expect <<-\EOF &&
> +	abc.key=one
> +	abc.key=two
> +	EOF
> +	test_cmp expect actual &&
> +
> +	test_must_fail git config --file=config abc.key three o+ 2>err &&
> +	test_i18ngrep "has multiple values" err &&
Try to change the value of the config, but it's a multiconfig already.
Ok.

> +	git config --file=config abc.key three a+ &&
But /a+/ doesn't match any configs that already exist, so this one gets
added fine.

> +	git config --file=config --list >actual &&
> +	cat >expect <<-\EOF &&
> +	abc.key=one
> +	abc.key=two
> +	abc.key=three
> +	EOF
> +	test_cmp expect actual &&
> +
> +	cp initial config &&
Get back the config before the last exercise (with just 'one').
> +	git config --file=config abc.key three o+ &&
And if the value_regex matches exactly one config, then replace that
one. I could see this case being a little bit more compelling if the
value_regex was doing some lifting, e.g.

abc.key=nil
abc.key=one

git config abc.key two o+

abc.key=nil
abc.key=two

This criteria was kind of implied in #2 in your commit message - does it
work?

> +	git config --file=config --list >actual &&
> +	cat >expect <<-\EOF &&
> +	abc.key=three
> +	EOF
> +	test_cmp expect actual
> +'

Anyway, it's a pain, but I'd like to see either comments describing
which case each one is, or individual tests.

 - Emily
