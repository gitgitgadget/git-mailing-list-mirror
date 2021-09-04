Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D13DC433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 06:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF4960F22
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 06:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350815AbhIDG6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 02:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhIDG6S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 02:58:18 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E7BC061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 23:57:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so964113pjb.0
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uYi4tPX30xDIQb8W6Trq9KfBWQ+WNukmswsxj4mFCPI=;
        b=ftncwTuRQwPAaUlJ+nm7VIgjdhN4ky/epWuuL3odIFSfetIaEw90Oo36c9gJCcxOil
         7ZYfJVyGKL8R9M2glS2b0tC/jy60ToMivQl1mAD3MgOCwoRkXN0FrP0Ta6rsMCiZL9xR
         DtXAtZnlwkMpZ9oesGCNaR5K4ptI51d3dzOfY3dQIYk3FS/8biVUslTOlm44olgTEsLK
         1tqBYacT4ZWYGMZglXEH7I3JiEiPwph+R5FEliImzdZavNH8of2FYH2Jx7skpmi1a6nA
         DWewLaNAaDBzwtgTdssMrXAPuWYmWpRuVTacxd1orSrK5d7GBDtqQAcJB6dn+wDDsG2Q
         2irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uYi4tPX30xDIQb8W6Trq9KfBWQ+WNukmswsxj4mFCPI=;
        b=g/9ZJ8y5SBA17qz7+0pC94eaLT/Du/Uj5pwy8usvoXuPOhAycy6BdmxLwRhq0RGHWa
         nIq8yERPXbIrsAbjzeke/rgIkVc3XrIpPSzGdrWTIcdn2xTAVyPp651v6+MBmWO+m4z3
         J7LkDqz0Pe+EQr234ziE+U2QckCtOxuUWJkjqwHrhrFClAqWy0aMAUJGVXBnNDIaiHfT
         BnQZHVSn/Q7Zt8lvEKqIyR4gUFp90Dgj+orcNYQXCnwi7dCk2j+HthURFIrEJN8jIMm0
         39j1oliaPuVlnzymQNehss+RDX9ce8KwsTEUo1gKG25AxqPkLmIfsQd1pW3Wk2h2/ISN
         yRUg==
X-Gm-Message-State: AOAM5315gEY3W2BfgjxMqbgar6/mwp/FchmBaYTbxtmUxZjdJld6snKx
        eX50C+7Al4SmPv99HRdG3DNuca8nsEWNLQ==
X-Google-Smtp-Source: ABdhPJycjkwcV9sCSaBzDmaaylO6ug+fkZl35HaAq2hb3aZsLQrl++EnBGAUlaoa5aG3P6B4BYvUzQ==
X-Received: by 2002:a17:90a:d507:: with SMTP id t7mr2912466pju.174.1630738634001;
        Fri, 03 Sep 2021 23:57:14 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-65.three.co.id. [180.214.233.65])
        by smtp.gmail.com with ESMTPSA id s15sm1264395pfu.67.2021.09.03.23.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 23:57:13 -0700 (PDT)
Subject: Re: Aborting 'rebase main feat' removes unversioned files
To:     Fedor Biryukov <fedor.birjukov@gmail.com>, git@vger.kernel.org
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
 <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
Date:   Sat, 4 Sep 2021 13:57:11 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09/21 03.33, Fedor Biryukov wrote:
> Looks like a bug in git rebase main feat.
> 
> To reproduce:
> git init
> git commit -m 'init' --allow-empty
> git checkout -b feat
> echo 123 > readme.txt
> git add readme.txt
> git commit -m 'txt=123'
> git checkout main
> echo 012 > readme.txt
> git rebase main feat
> git rebase --abort
> 

Did you forget committing?

> Expected result:
> readme.txt contains 012
> 
> Actual result:
> readme.txt contains 123
> 
> According to the docs, git rebase main feat is a shorthand for git checkout feat followed by git rebase main. I have checked that doing checkout and rebase separately instead of using the shorthand does not have the same issue.

I think this is non-issue (behavior as intended).

So when you say `git rebase main feat`, Git will rebase your commits in 
feat on top of main. If any conflicts occur and you abort rebasing (`git 
rebase --abort`), your feat branch just looks like before rebasing.

-- 
An old man doll... just what I always wanted! - Clara
