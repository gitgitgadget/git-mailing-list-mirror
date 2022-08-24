Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4530C04AA5
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 22:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbiHXWJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 18:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbiHXWJt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 18:09:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F4AAE64
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 15:09:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-334370e5ab9so315136257b3.22
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date:from:to
         :cc;
        bh=2/fR1Mag95LvHUJLwnmuLZIsytI474RlA77XCMJEiEo=;
        b=ajwRP3INF2K8+IHxENkYvwQunyVZOQZk7ezxl8Kqp+qEUKFPFUGVWBAAwoaP7ZNIfj
         bc4rOa2iIebSLUIU9if6whaI1b5H2KNIz/dTjpET8fEVtJ9aLrs1MUuOgeTMHBXJSMCC
         rWuZFr98pcNGWRsvnxp0j7BGr8/ofKewM+8q5pIxARr1cnJsZ2h8vwhtj8xXGsOkP0Hy
         a072Xy4Utd+O2EoCQoxZ/MydhfBOj65rH9DoJvHsi+FuVWPIxCMVdz4kHtw1OZwe5H39
         B6GFUz4xxM+rq8Cy9GpoMN1+OZ6YbdfJYOa2q5XwLckLFDjAIj40YM6oijWF9Ykgs3KX
         2Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc;
        bh=2/fR1Mag95LvHUJLwnmuLZIsytI474RlA77XCMJEiEo=;
        b=qtzBhVCAbnHaQy6yFrFZMZW5BG7s13oBmfcvFr1AhM6ZWNbHl/Txt7xfrQwzs3ZxkF
         GNV1KVcRY8XvGUutapA4tZjgCzv7k8QSENlDE9mRyabXWH0XQCWho5gIDZu/U8p9FnDS
         6ZDr+gjT9SKlM6lyayx8lANr4D7de6+7H0tqpsORdvKZEkwvaLLBizlcsNtNam6ac+ln
         IX5FrXwgxtaiTvHE+HBOdun8FdE4lPCDs8kmXCeCEsfWGMJ/F6vbZswSa+EslbQ/Ie0E
         oon16gC5lojbYD5oVhvJcLNf8HH/DhvQwmPaAEvsQp2U2nj+JUlRRG/ocScB3SDMRjLY
         heDg==
X-Gm-Message-State: ACgBeo3YH/94Ht7Upe3wGwtpQT5lDS0tIt3TiJo9YS4ttXLy3eIUT0mT
        MdYThg/I2t9PYhywVjmEWDt4YsdHkFUOvA0pC6Yb
X-Google-Smtp-Source: AA6agR7Mb/AaMQ9/SDxd3U7oZfZOsQuOQQv8dhC+y7wJ9wjwNlrB852/JDxF0heG/xYltiUyj8C+uW7HF7dWqEDffWYu
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0d:fdc6:0:b0:335:aa0b:8381 with
 SMTP id n189-20020a0dfdc6000000b00335aa0b8381mr1340581ywf.271.1661378988261;
 Wed, 24 Aug 2022 15:09:48 -0700 (PDT)
Date:   Wed, 24 Aug 2022 15:09:45 -0700
In-Reply-To: <9cd4c372ee4b3e5ba45c66a43ad0edaf52f0eed9.1660576283.git.gitgitgadget@gmail.com>
Message-Id: <20220824220945.1683473-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: [PATCH 4/5] rebase --keep-base: imply --reapply-cherry-picks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -1240,6 +1241,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		if (options.root)
>  			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
>  	}
> +	/*
> +	 * --keep-base defaults to --reapply-cherry-picks as it is confusing if
> +	 * commits disappear when using this option.
> +	 */
> +	if (options.reapply_cherry_picks < 0)
> +		options.reapply_cherry_picks = keep_base;

Here, we set options.reapply_cherry_picks to 1 if keep_base is 1, but...

> @@ -1416,7 +1423,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	if (options.empty != EMPTY_UNSPECIFIED)
>  		imply_merge(&options, "--empty");
>  
> -	if (options.reapply_cherry_picks)
> +	/*
> +	 * --keep-base implements --reapply-cherry-picks by altering upstream so
> +	 * it works with both backends.
> +	 */
> +	if (options.reapply_cherry_picks && !keep_base)
>  		imply_merge(&options, "--reapply-cherry-picks");

...if we implement --reapply-cherry-picks by altering upstream (and
hence not need to rely on the "merge" backend), shouldn't we suppress
the setting of options.reapply_cherry_picks too?
