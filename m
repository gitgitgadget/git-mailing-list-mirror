Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105DBC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E716761075
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbhIAN1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243125AbhIAN1J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 09:27:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88263C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 06:26:12 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u26-20020a05600c441a00b002f66b2d8603so1375418wmn.4
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=FRJKeAF2SdAkvjptZdD1aLg9XE7ahq/sPAcHVg9Zrds=;
        b=AYGlhBY0fuq122LCWZTyoQBvrQA3Hhq51kyBIiElJgb1bx6hi6iewKc/8EAeSzbBPL
         9Y9RkBgbrTRNq3I7PxaIjQ8t5M0O5k/q1x1oafdVQxbmpsUeRqjoNabasKzsJJqx9N+V
         gKRkpyZ7asI6/O1QymN87SOorSHSi1FTdXryF+8vE5ircre/h5eQ1hnxk8UKwf3VCVyQ
         HPPd7zb6rVi5khs00KlrJxera6Gd7k7tRHJsbqLldBjbxDiFdi2TOBx8dXrsBBoN4KsL
         s6bxn64WSS0RaNa1LrPhOeXNMuDiteUMxB+zO4TzXza3ET4Ye4CTwJcjRGhWVgdGHLx5
         /CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=FRJKeAF2SdAkvjptZdD1aLg9XE7ahq/sPAcHVg9Zrds=;
        b=jd8PourPusERTxACqcFP4pBh3xU+88ZTwd/kN3JE+FYTeEvPMuY5ASYaRd8N60zoT1
         RwvX6db0M253iLHc3/E9y9Rb1T7z7Setrn75/DUUBi8ISKf6XPJdT8w9vJoKiEgypONN
         1ATvSIYnxQ007rP99mm5I77V+GNot+jSJrdfGnkvhqmRN0tX37mW0NeRxHAf0alAzRo8
         rQUOsW/6lYnYEq5cjfz22SFFQWE3XRTnaHTbBV+nUpRIwkDu8MnshgiR/iHjC0vQXd8G
         SUjeq1bOOAwzvkG/F82jZGNS4Rsy8mcrWC9Wt5Hix3WXCqxPQ1zhNhRMMxRMu0fO92We
         cU1g==
X-Gm-Message-State: AOAM530lKxvD4gU6z3lsvvGvPw5id/9nYjBsnRB2T72Rtze3v2vjECVA
        IZSC5qMpExM2CLV9PqbaGb8=
X-Google-Smtp-Source: ABdhPJz9kEyt2jb3MFF81pHhD1XFYR7bgjYHZPAUlZuw+7bhjeE7Hg/XiNK4B1AL+VWOnZ63olZxug==
X-Received: by 2002:a1c:7403:: with SMTP id p3mr9639719wmc.72.1630502771067;
        Wed, 01 Sep 2021 06:26:11 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o23sm9827994wro.76.2021.09.01.06.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 06:26:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 6/7] git-svn: drop support for `--preserve-merges`
Date:   Wed, 01 Sep 2021 15:25:07 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <a987e9439af6335e15a3d41b82832e9a8824317b.1630497435.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <a987e9439af6335e15a3d41b82832e9a8824317b.1630497435.git.gitgitgadget@gmail.com>
Message-ID: <87zgswv34e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We already passed the `--rebase-merges` option to `git rebase` instead,
> now we make this move permanent.

Unlike the cover letter's claim of deprecated since v2.22, this in
particular has only been deprecated since v2.25, i.e. your follow-up
ea8b7be1476 (git svn: stop using `rebase --preserve-merges`,
2019-11-22).

I think it's fine to do this, but at least updating the commit message
to note the difference would be good.
