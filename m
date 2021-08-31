Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B2EC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401536101B
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbhHaIfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 04:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240268AbhHaIfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 04:35:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29D5C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 01:34:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o39-20020a05600c512700b002e74638b567so1898817wms.2
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 01:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GF+HRO5h9/V01ooHsb1RDclhgEsKYzTirS7y9LlfXj8=;
        b=DsEhpNaL18LB3C3/+DA5AUsFR5syEFAbdHdrlXe34fxsKqvDiqrdAJn6I2ju9wiLuC
         UhG9K4pMQPmcritWA8dWJY7mPHxr1eg4vHQC4EVZPbGwSnyQp3fao48T+W34WcP0POg5
         I0C6vzAmLvUoBGg8uDsV++wSwfKsl0dZYYjkZXHIDwwqmF+Ga3A5saq4+uOqBxFHZmmY
         zgaquAj3x/p7x0XkSzVjKBFC57OhSLnkAEoxkZm19jYhY5DmWczskY5IWtmTJ3rCbNu+
         W7pzyT6Ii+Pax9Y4ZG0C+B8rORttABp53JTkTYx7C0L+a1N9BVNWaZ9JTHs5RUlyR4uK
         YWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GF+HRO5h9/V01ooHsb1RDclhgEsKYzTirS7y9LlfXj8=;
        b=PpIbHBaW/MBtANiQHRbf6CaOGHNwfG6Cbu9e0a7bGYb0lhz3F+R1EJO3zaVHIS2r1r
         s4y6R9cgtaFOA3Z7Kk5COAFTTHbPnkf4rnEiv8Tqf8f/DKAASh12xSC7a4dWxttwf74W
         qX696AONOFg8pCwOHuyU4FcTymUEG46xq/Y7FZkYgXrBXVgh2xnpSdEqo+QpKXt0G50p
         b4PEa0moO/mSLWPvAoSpiDWSdTSEv5QYrS0ilJekuEvj6gUhuJ4Np9kQnfdj3plO+9WK
         +n8V35VuXVBOglvd4WZXEPtmlF7MC4YQGBW3t5DXlNFCJP9ihluIZ4pkMKwhSZtqVglO
         52Gg==
X-Gm-Message-State: AOAM530lcxZxWHYwNzR0OeUxWb8bbgnMv49aiOG3+4JhKdJlsN/qYYNM
        Y73iBxscPjsxBtitFajNoIxmn8euyCXkZA==
X-Google-Smtp-Source: ABdhPJzKo1AT7imWBTWImCT9vhCx+m3ZuHTQS9EAftC8+21liaA0ZAd7UuPrPtJhdSwhir+5AjPlLQ==
X-Received: by 2002:a1c:29c3:: with SMTP id p186mr2995666wmp.22.1630398866162;
        Tue, 31 Aug 2021 01:34:26 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m3sm22354279wrg.45.2021.08.31.01.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 01:34:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 15/15] scalar: accept -C and -c options before the
 subcommand
Date:   Tue, 31 Aug 2021 10:32:48 +0200
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <6455b18f1b623032b9066c1730dee045fbe7a3f3.1630359290.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <6455b18f1b623032b9066c1730dee045fbe7a3f3.1630359290.git.gitgitgadget@gmail.com>
Message-ID: <871r6axban.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 30 2021, Johannes Schindelin via GitGitGadget wrote:

> The `git` executable has these two very useful options:
>
> -C <directory>:
> 	switch to the specified directory before performing any actions
>
> -c <key>=<value>:
> 	temporarily configure this setting for the duration of the
> 	specified scalar subcommand
>
> With this commit, we teach the `scalar` executable the same trick.
> [...]
> +	while (argc > 1 && *argv[1] == '-') {
> +		if (!strcmp(argv[1], "-C")) {
> +			if (argc < 3)
> +				die(_("-C requires a <directory>"));
> +			if (chdir(argv[2]) < 0)
> +				die_errno(_("could not change to '%s'"),
> +					  argv[2]);
> +			argc -= 2;
> +			argv += 2;
> +		} else if (!strcmp(argv[1], "-c")) {
> +			if (argc < 3)
> +				die(_("-c requires a <key>=<value> argument"));
> +			git_config_push_parameter(argv[2]);
> +			argc -= 2;
> +			argv += 2;
> +		} else
> +			break;
> +	}

This along with my earlier comment about the Makefile copy/pasting makes
me wonder if an easier way to integrate this wouldn't be to refactor
git.c a bit to have it understand either "git" or "scalar", then instead
of "ls-tree" etc. as "git" the subcommands would become "built-ins".

Which would give us both "[git|scalar] [-c ...] <cmd>" for free, and
elimante the need for the inevetable future divergence of wanting -p,
-P, --exec-path etc. in both.
