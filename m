Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDE9C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 13:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 239166105A
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 13:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344654AbhIXNYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 09:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345926AbhIXNYt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 09:24:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922EFC08EADC
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 05:54:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v10so31084805edj.10
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 05:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ueGBaeJgtY/xwX6H1em0ojCVRC5SasDk/8IFji2vtc0=;
        b=Yke0lKdrgKoopTYdJdWpFN57ug9sI1fASVJyd4v3iOERXuuviznM0zKZSUtUMjQtFG
         veVTyrX2xKwW4JlWDUa9o9JEg/c+zBA3v9rMSMHUXYN6/yGSN67y0075tAiUivrkYiK+
         WWuGQQEvnKNY9+LVv6DzKBFzqXnBaq0p2FXmWbSnhagAaQaikT7txOiH8XmUE7m1rg59
         np3zWCXzTb1L2/nHVVusc+7x/xaI4ERPburVtJWIOIwQdNHDfp3L/Ie2eSjZUGu8vzQ3
         QG3thxcn6KaWDb9M+JebJol041TM1cd9yUrQxFerx2bkFUWteeOqgkGLQiF1IlDCTMsT
         KBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ueGBaeJgtY/xwX6H1em0ojCVRC5SasDk/8IFji2vtc0=;
        b=HxTLEkPVZeqxhmTDJV2iiWHR9BNlYdDXaGgnBZnydlbR2svrK7h/EElscsjWZYiwum
         fUBX9/5R4sjiQkoJQLrn9ZL4uE2aXek9FVlKfVWBqzX5JfpYVBedS026wKAR99mQ9dJT
         VNdVaXPdX3aoHl1TOPJo/7gXrp1KelftmMcx8TG6FcQi9pJrza9+o+/v9N5dknmhs9Q1
         4TC/Gr1vRT7Rv5vL+2wtLKSr050lOc6sCHH8LTN/ivPpRvqELlR4g1qzP3aX8GRAcvdW
         5yn1F8LXsf37dhsCM50iNcjHGcqbW0A1kK74m14g4kjkjzQN3Nn9ld4ZeYYmLtGAg5fI
         siXg==
X-Gm-Message-State: AOAM5326lZi/aPoGA3LL+Mu5DJTP517J0Saq3CErYMe2xHr4pTtToAkM
        CVWmTZ/VQMjmK5in24mKCoKDJv6QyYWbHw==
X-Google-Smtp-Source: ABdhPJzx9+jkAzMC09ruuvztGXF+rv+NdkDbVoGB3t4zzvQ5cHXrAuNcaomZgN+UiNCZVlMgujRBpw==
X-Received: by 2002:a05:6402:142a:: with SMTP id c10mr192847edx.106.1632488045808;
        Fri, 24 Sep 2021 05:54:05 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm26sm5072614ejb.16.2021.09.24.05.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:54:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 01/15] scalar: create a rudimentary executable
Date:   Fri, 24 Sep 2021 14:52:55 +0200
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
 <852ec003109b8244e2f9360ec64749779989c4a2.1631630356.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <852ec003109b8244e2f9360ec64749779989c4a2.1631630356.git.gitgitgadget@gmail.com>
Message-ID: <87sfxu2kyc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 14 2021, Johannes Schindelin via GitGitGadget wrote:


> +int cmd_main(int argc, const char **argv)
> +{
> +	struct strbuf scalar_usage = STRBUF_INIT;
> +	int i;
> +
> +	if (argc > 1) {
> +		argv++;
> +		argc--;
> +
> +		for (i = 0; builtins[i].name; i++)
> +			if (!strcmp(builtins[i].name, argv[0]))
> +				return !!builtins[i].fn(argc, argv);
> +	}
> +
> +	strbuf_addstr(&scalar_usage,
> +		      N_("scalar <command> [<options>]\n\nCommands:\n"));
> +	for (i = 0; builtins[i].name; i++)
> +		strbuf_addf(&scalar_usage, "\t%s\n", builtins[i].name);
> +
> +	usage(scalar_usage.buf);
> +}

In 04/15 you continue and use the parse-options.c API, but here it's the
usage.c API, which is generally being phased out. Any reason for the
difference? It's preferrable not to add new usage() users if we can help
it, I think we'll eventually want to remove it.
