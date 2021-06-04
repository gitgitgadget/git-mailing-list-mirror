Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDA3C4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 18:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8806D613FA
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 18:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFDSHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 14:07:45 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:33390 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFDSHp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 14:07:45 -0400
Received: by mail-ed1-f45.google.com with SMTP id f5so7136003eds.0
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 11:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tx1NcYEo7Sj2HdSS29xzKa9BgncQZ598mAnCjw15qEw=;
        b=DKHjBGjGeU0USVfYKcYgG31s1gO6+2j0XF/4uNmWfOSKE6/tR1VzGoT9aUz5JDmiQX
         phtt2jD5NSUugzCesTmT6VK3FyeOfKdFdU/1eJxWro1gGwuKL+FIrhl6b4iEMFFgfzdA
         T5ltsGGaKPJFM8vC/luIyF6cnlV9Xfd37awsZoNAemnmHQPazi+SaGGhGdBb30c0J/tZ
         Xv9QNVgSkYCVAHmgjUrU0DJyJYroFKExm7HTJVz6Ns+sCZQ7VfHuuGdlvqa/3ILMv9DJ
         uHKFedxlsjD3AwWje+XMDDQfKYgNVeBEzoYiwzPCNLrsDwk4zEiNuu/8ZdPM5yTAJir/
         ULow==
X-Gm-Message-State: AOAM531ULh/ySoJegfyjrlddb588GLDqbESuVjJcYv09VfMpPROJbi6y
        k3/OMq8SZnZSasHQFwFdLL1U4QxOYFTtEcT9uSQ=
X-Google-Smtp-Source: ABdhPJx2Dbt4Jf18YFO8I/neGRQa4hVwiHeJ4goUBA08929IkjjpwxCQiPcAhLRL2+n2Ey8sXKMMO2tFu0WafPAh7Wk=
X-Received: by 2002:a05:6402:1777:: with SMTP id da23mr5968239edb.181.1622829955673;
 Fri, 04 Jun 2021 11:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.970.git.1622828605.gitgitgadget@gmail.com> <c3bf266cf03a9678933623b48927ee749956218d.1622828605.git.gitgitgadget@gmail.com>
In-Reply-To: <c3bf266cf03a9678933623b48927ee749956218d.1622828605.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 Jun 2021 14:05:44 -0400
Message-ID: <CAPig+cS3SQTP=49jHxEuMahwqdCstD7Qgck2Oxkc35ZJkj_eYA@mail.gmail.com>
Subject: Re: [PATCH 2/3] cmake: create compile_commands.json by default
To:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 1:44 PM Matthew Rogers via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Some users have expressed interest in a more "batteries included" way of
> building via CMake[1], and a big part of that is providing easier access
> to tooling external tools.
>
> A straightforward way to accomplish this is to make it as simple as
> possible is to enable the generation of the compile_commands.json file,
> which is supported by many tools such as: clang-tidy, clang-format,
> sourcetrail, etc.
>
> This does come with a small run-time overhead during the configuration
> step (~6 seconds on my machine):
>     [...]
> This seems like a small enough price to pay to make the project more
> accessible to newer users.  Additionally there are other large projects
> like llvm [2] which has had this enabled by default for >6 years at the
> time of this writing, and no real negative consequences that I can find
> with my search-skills.
>
> NOTE: That the comppile_commands.json is currenntly produced only when
> using the Ninja and Makefile generators.  See The CMake documentation[3]
> for more info.

s/comppile/compile/
s/currenntly/currently/

> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
