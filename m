Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5F6C6369E
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB065246EB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdcO+NgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgKROwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 09:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgKROwM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 09:52:12 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74ABC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:52:11 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id o9so3177616ejg.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=58lfqZnBRzoqnGDvNAqxyFtJf7Y/xGuT7yGt4UXzMLs=;
        b=CdcO+NgKA9xcyqhX+LFfqKcM+LBJ2UFjtzZTkCN/jEdzqzerbCN/V322y2O4j1qJTN
         DUvpCw7zhNPJ6tzqflOhoK7C8DH+08zbp6irFaaatK0agwiaTAyimwia4tIIqVVPbHSG
         6SXMDJDesMhw4d3S+gpPTaP/XrlDbyqHslXziCOaISXs/4eBtBqEGUBV415j5sNWdqSh
         EiWKPadLd47k1wuCs3YZjM0nITEqgSZU4gL0+HvqRPEE/m0TxsuYZawZNWWIFz9fQlmb
         /35x5vJBZ0JGviKm79t1E9zHlcr08yKegfuZl8gtTbhzU8vn6gny4BKJdo9TVYAJWJQD
         2UhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=58lfqZnBRzoqnGDvNAqxyFtJf7Y/xGuT7yGt4UXzMLs=;
        b=QbNK1eUYhi/wSs+AAl0fH3zxxLrPhRS1KuoJAua6JQf+ftrAMpvhvD4nPZilMEr2Ww
         kPDpoI9Woh5YgZBCwjTHMk8FL1MJUESSaT4baP69nCJEaSXAe/draqRXh0I0A5CJTXiR
         b0EK9KECl1xuF564rFbLf84F/MXwz38e1ufUiuFRS+ZDaIZSexKJKlS9+ZJX+0/WWD7u
         ctgOYv6OQ5185uDY1fvavn4REW/5aznT5IgUoYYp/sjgQxsGVKn3SeFbzTL13gQjpP3D
         ZeiPDGiWdUsJXdsUy64AZGE/cPP+Po+YlR7b+IOMh23UmuLy4nY8YHuUxiDi1RF90Dry
         2s7g==
X-Gm-Message-State: AOAM532LhZP4tkT77WWo6eTuF60rY+HMAp1l3EqnfdkNItqFnTlUdi/X
        21d8L5BzzMi/hwyG3z1zRk/OqIb6D2nHKQ==
X-Google-Smtp-Source: ABdhPJzi4oM01l7+81CMnDy+fJx8p8OHR8LgKscPQoWngBLcgmXqb8pa8JXHT9oyj/Evuvi62/MQUA==
X-Received: by 2002:a17:906:4104:: with SMTP id j4mr25121537ejk.439.1605711130538;
        Wed, 18 Nov 2020 06:52:10 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id x15sm5147964edj.91.2020.11.18.06.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:52:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1309: use a non-loaded branch name in the `onbranch` test cases
References: <pull.791.git.1605709410465.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <pull.791.git.1605709410465.gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 15:52:09 +0100
Message-ID: <87a6vera3q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 18 2020, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `onbranch` test cases in question do not actually want to include
> anything; Instead, they want to verify that the `onbranch` code path
> does not regress in the early-config case or in the non-Git case, where
> the `onbranch` include is actually ignored.

It's unclear to me what this patch is for & why it's needed.

Yesterday in your v2 27/27 series you sent a different one that changed
this from s/master/main/g:
https://lore.kernel.org/git/b8fa037791683b50c3efb01aa6ac0d3f7b888a2b.1605629548.git.gitgitgadget@gmail.com/

That's on top of "next", but this one is on "master", the two would
conflict, and the 02/27 one seems like the right thing to do.

> Therefore, the actual branch name does not matter at all. We might just
> as well avoid racially-charged names here.

It seems to me the actual name matters a lot, and it must whatever the
default branch name is.

I.e. what the test is doing is producing intentionally broken config,
and asserting that we don't read it at an early stage.

Therefore if we regressed and started doing that the test wouldn't catch
it, because the default branch name is "master", or "main" if/when that
refs.c change lands, neither of which is "topic".

Maybe I'm missing something but it seems 58ebccb478 ("t1309: use short
branch name in includeIf.onbranch test", 2019-08-06) and your own
85fe0e800c ("config: work around bug with includeif:onbranch and early
config", 2019-07-31) which added the test support reading.


> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     t1309: use a non-loaded branch name in the onbranch test cases
>     
>     Just something I stumbled over while working on 
>     https://github.com/gitgitgadget/git/pull/762.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-791%2Fdscho%2Ft1309-onbranch-tests-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-791/dscho/t1309-onbranch-tests-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/791
>
>  t/t1309-early-config.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
> index ebb8e1aecb..b4a9158307 100755
> --- a/t/t1309-early-config.sh
> +++ b/t/t1309-early-config.sh
> @@ -91,11 +91,11 @@ test_expect_failure 'ignore .git/ with invalid config' '
>  
>  test_expect_success 'early config and onbranch' '
>  	echo "[broken" >broken &&
> -	test_with_config "[includeif \"onbranch:master\"]path=../broken"
> +	test_with_config "[includeif \"onbranch:topic\"]path=../broken"
>  '
>  
>  test_expect_success 'onbranch config outside of git repo' '
> -	test_config_global includeIf.onbranch:master.path non-existent &&
> +	test_config_global includeIf.onbranch:topic.path non-existent &&
>  	nongit git help
>  '
>  
>
> base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500

