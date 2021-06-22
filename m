Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C170C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 09:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E466044F
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 09:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFVJ2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 05:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVJ2E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 05:28:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17A6C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 02:25:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m18so22786012wrv.2
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 02:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zcI8uPiancCgYhqDLndYIxtOoxLLQeyv7OUBPrOflCU=;
        b=zrl/5v/WrStFwgImED6QsYOo6ruXiXqQA/p/Cj4IO64qqDzLuo5lX1yQ+JC3+1t/9D
         jsmd2Br65j/MfcVHpF5U//3BgZvnWDJsnV5CaD2lFnzvkzfY0wYZ1oAFsVHdz2Yyj4Im
         9/cbzEQEC4bXEJHKcY2u2+OrIlTjz0J0oSOMdysvqtRj1DMjCZqbyt5rR/lXuhPCzhjl
         xd6mALvfG1XGLRlOn3Ss4FYzpokYROFv5tAe0bRHsAozR5O+HJTZ+CKj31qA5P1RG4UB
         qPt0n19PNFjzjlq43dgaK7+gNL/L+miSWLZ+5LOoeqKG51Bc5pOCEVs8tFE75Wz4r8Gw
         AT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zcI8uPiancCgYhqDLndYIxtOoxLLQeyv7OUBPrOflCU=;
        b=GMa8nTC3RCBs04Ks2LAjS/3JQtSP6NJd+23abBmyQbmoPrUBKlyxMQf4aeSJML4q2T
         JJWgkpIt+AblITZgjAek6p+2rAGiChUu4qxQj32R8KYhkMac6IGn5AYoSKLxJZHTgpDV
         /RT+gTvX7Bev0AG8lwf5FJM6z263kBjyB/6gPw2aIcW5TElLICVq13UgwYEn+FJDejNx
         zGPqufe3xj0T0fuS5Ets0cmjUwbBXu1bZj44iSWZzgufNGIl33nJaEXaAi5ceK0q1s6W
         ye9XlQ+SlAw9hsccmBS35uyXBqEgUCvPUl+y3kiecnxczzO7B7K+3CrnJ6sourkZ2lfX
         1/Ww==
X-Gm-Message-State: AOAM530mOWYQWLZn5rea95HBs+fLukmj8nqwIHui8QLmBXlDDqWOQ945
        fMrTpSC7se0jR9i/anoDCYUTNGI3h3I1Z+j7WZ3Yft0EYIu8exeB
X-Google-Smtp-Source: ABdhPJwPT9FiH5ESGGwoKOteiNysw/AffTTL4RwJdZL14XLlJW0VvxqnFu2bYwSPef5biCy7CYhWtn5o4EVxUzKamdc=
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr3489616wry.15.1624353947101;
 Tue, 22 Jun 2021 02:25:47 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 22 Jun 2021 11:25:36 +0200
Message-ID: <CAPMMpohp6+jW2C0ewfYEp3rrwbKSqGVa94LRgQDcKJvYmiANuA@mail.gmail.com>
Subject: Untracked Cache and --untracked-files=all
To:     git <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I'm hoping for a little help understanding *intent* around a
particular code comment in dir.c, and reaching out to the whole list
because someone (Junio?) said they consider any mail that *doesn't*
copy the list to be spam anyway, and the original author of the
comment in question (Duy Nguyen) is no longer active on git.

Context:
I am trying to explore how to get "--untracked-files=all" to play nice
with the untracked cache, so that windows users using tooling that
sets "--untracked-files=all" can benefit from the same
orders-of-magnitude git status performance improvements as commandline
users.

There is a "naive" approach to this (store the untracked cache in the
index file with whatever dir flags were specified/used in the
recursive walk, and ignore/rewrite that cached data every time the
flags change), and there is presumably a more "comprehensive" approach
(store all the information required in the untracked cache to be able
to satisfy requests with either set of flags - even if this is a
little more expensive on first run).

The main disadvantage of the "naive" approach is that is every time
you flip-flop between "git status" and "git status -u", the untracked
cache is ignored, a recursive directory walk ensues, and the untracked
cache is rewritten to the index file for the next time you rerun,
hopefully with the same flags. However, I would think in most
situations flip-flopping will be less common - more commonly you're
using a tool or workflow that ends up running the same command(s)
repeatedly... At least, that's my thesis. I would put this "store the
untracked cache every time dir flags change" behavior behind a config
switch, anyway.

This "naive" approach *is* rather easy to achieve - you just need to
recreate a new "untracked" structure inside
dir.c#validate_untracked_cache() if you find a mismatch of flags (and
make other small fixes to store the correct flags in that new
"untracked" structure).

The one thing that sticks out after making these changes is a code
comment first introduced in 2015 by Duy Nguyen in ccad261f, explaining
*why* we refuse to use the untracked cache with "-uall":
> * See treat_directory(), case index_nonexistent. Without
> * this flag, we may need to also cache .git file content
> * for the resolve_gitlink_ref() call, which we don't.

I've seen this comment many times over the past few months, and I've
previously always interpreted it as a "correctness" concern.

Looking at the original code in question, however (as of ccad261f,
dir.c#treat_directory(), "resolve_gitlink_ref" call), I don't
understand how correctness could be impacted.

Fast-forward 6 years and all this code has been substantially
overhauled by several folks over the years (most recently and majorly
Elijah Newren), and the "resolve_gitlink_ref()" call is long-gone.

Does this look familiar to anyone? Is there any remaining obvious
reason to be wary of storing the untracked cache structure produced
with '-uall'?

Thanks,
Tao
