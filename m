Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9991F462
	for <e@80x24.org>; Wed, 12 Jun 2019 19:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfFLTgD (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 15:36:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36734 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfFLTgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 15:36:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so18205358wrs.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 12:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUlN58Wvrr4+9ukp/9+iLmvWn1ONrud2Lp+ees9XB3A=;
        b=U0SkmSFNnEFxtiL0GTE+y2SxReGomConbO3ASP939Z7XSP+c60x31RIzqhIfVZt8X3
         VTE0+l0AUbPUWN9E2YZNWrxdnMC51HU0MEL7Px5i85jMyyB9BfQz4iq6U3P8jrRtkhNg
         V6d0AoQ+jCgR6u9uuaCo9waNM7yVlCuvImTuKRyMhY0oJYGqqhXRbcbzHHa19P5y+l1o
         UPSl5xN9iwvAoUboJGzDrNYQpwxsEP6b1kkjEdPJVjh1JxqxHd7WA8QwJyspyD7bUWMH
         jez71fF/nvZsDg7UaDPE5u/GaPHPtwN5+WvhjrMrWwY0WkJInc0iR+bXf0WaJRUMRxsT
         eGbA==
X-Gm-Message-State: APjAAAWLgTmyR0yM6RovLBB//7HGlhg8T5KhIAkm33JRlHhpGrwnR2lS
        iFwEI31tHnxAByt6Jo7av+I7X5hJXxk2cHZegpSysw==
X-Google-Smtp-Source: APXvYqyYIKptzKAozwv5XaWNp8/xo+3HDem770YgnHx9cYmjhywZpZkMGdLpB4f++aMVXqov6uM+b9r+34lZzB15A5s=
X-Received: by 2002:adf:8b83:: with SMTP id o3mr52669745wra.278.1560368161706;
 Wed, 12 Jun 2019 12:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.263.git.gitgitgadget@gmail.com> <e766e5177722dc20837adbd902d596186b1e4997.1560363008.git.gitgitgadget@gmail.com>
In-Reply-To: <e766e5177722dc20837adbd902d596186b1e4997.1560363008.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Jun 2019 15:35:50 -0400
Message-ID: <CAPig+cR5hV3+8RjB=8Vz2cF6Ycnh_kj+LwraZAehAqYxrEt0xg@mail.gmail.com>
Subject: Re: [PATCH 1/1] submodule foreach: fix recursion of options
To:     Morian Sonnet via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Morian Sonnet <MorianSonnet@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 2:10 PM Morian Sonnet via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> . Add -- before the command to execute, such that now correctly
>
>     git --super-prefix <submodulepath> submodule--helper \
>       foreach --recursive -- git reset --hard
>
>   is called.
>
> Signed-off-by: Morian Sonnet <moriansonnet@googlemail.com>
> ---
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> @@ -421,4 +421,9 @@ test_expect_success 'option-like arguments passed to foreach commands are not lo
> +test_expect_success 'option-like arguments passed to foreach recurse correctly' '
> +  cd super &&
> +  git submodule foreach --recursive git reset --hard
> +'

Follow the example of the existing tests in this script and do the
'cd' in a subshell so that it doesn't bleed into tests added later
following this one, thus confusing them.

    (
        cd super &&
        git submodule foreach ...
    )
