Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD731F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeGUIN3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:13:29 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35615 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbeGUIN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:13:28 -0400
Received: by mail-yb0-f196.google.com with SMTP id x15-v6so5487561ybm.2
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wzK/5BeGWlB+amEuLUMx4XI4nhxdvdzOdHQxV8vn/Zw=;
        b=SEjyZKAU82QyS2Zk9Yc+rWcNuFBIyGF/Fj74tt+Df2XwmKXbcrAsYpsKTjRIUGQLl1
         2qXSv4wNy0QapHrBV7G5PCecyZbWCZ1Jk+rUKmILGYK1Q6MTtyNPOsJ53jUeEe+BCJYb
         s1hoJndaKhl+gslic0i90lBi5qeeKpubc3eARSjf1+pS1rp6JFJKOs5R57HQGTpmIiaR
         UIqLOkRjqzwRHYxjZQzf57fHlpp04syfJSrdvn+Eu3Cvu3yKyoo9qg4PEqXGFpdgfefv
         PqgfbvI4M+bb38pbsBglmeRl3tM72PSa52Mg/jXyIROdHNFb5LpeqBCQ4ynOHDqHYTrJ
         unJA==
X-Gm-Message-State: AOUpUlFhqvT0vXPdn4g8f699QY6NA5iNHLC2H55R0va2QwYAZJBlV1R7
        nkzmP5Nho2bnakSPunJgcOtgUcJ1heWIs833S9A=
X-Google-Smtp-Source: AAOMgpeScBAdAE4m5MtgH5OTY5fd2CxUAqoiTU09LuGxSm/sDCbY2wMWlBqMVsJ41WyWrKuo15ZYASmM7PWyadhvI/Y=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr2484607ybf.287.1532157705739;
 Sat, 21 Jul 2018 00:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
 <20180721063428.20518-1-newren@gmail.com> <20180721063428.20518-2-newren@gmail.com>
In-Reply-To: <20180721063428.20518-2-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 21 Jul 2018 03:21:34 -0400
Message-ID: <CAPig+cTjQ74gOt8gJbYUBaTRsHBvqtcmucoVdiudFt2TrhCn+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] t3507: add a testcase showing failure with sparse checkout
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>, kewillf@microsoft.com,
        peartben@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 21, 2018 at 2:34 AM Elijah Newren <newren@gmail.com> wrote:
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> @@ -392,4 +392,17 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
> +test_expect_failure 'failed cherry-pick with sparse-checkout' '
> +       pristine_detach initial &&
> +       git config core.sparseCheckout true &&

Should this be test_config()?

> +       echo /unrelated >.git/info/sparse-checkout &&
> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git cherry-pick -Xours picked>actual &&
> +       test_i18ngrep ! "Changes not staged for commit:" actual &&
> +       echo "/*" >.git/info/sparse-checkout &&
> +       git read-tree --reset -u HEAD &&
> +       git config core.sparseCheckout false &&

See question above.

> +       rm .git/info/sparse-checkout

Should this cleanup be done by test_when_finished()?

> +'
