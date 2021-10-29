Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FACC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 11:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0541610CF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 11:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhJ2LER (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 07:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhJ2LEP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 07:04:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35235C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 04:01:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g10so37030848edj.1
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lFVF9wKUONGawRxBiTRxnoKEdoirNd+MnE/0Y45kKDw=;
        b=Sv62iAPmzSpwWatnbHQ1ziO6hYbp5+j6rTxm+Bf/LtS4X3ZO8hbfDREylATEFmpWRv
         HK/vIeoegnjeJ8m4LDtbfk2Jzbgx3rSvF9Ttq6XJPVqOmOdfD5Db825YAMSo9kcCa0gN
         +LJjVcfgpp8UpEAQa0aZPIvmQJZBmJfObnk6j3YtvGToMfjpRm0mGg3l/wkRnl4c1ijE
         7tenWHKe1luysyHgDRStcn5EMdObaYz7VV1+WvpT+Lo59J0W62WipC4U/Grvx7Gtty4w
         G4bnx3rfqNrBNb//J2Bd9e6CIigR+EtlRzcMavb+3IKgbVI/z5ErBP7yXr6Vzts7vFwV
         4ZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lFVF9wKUONGawRxBiTRxnoKEdoirNd+MnE/0Y45kKDw=;
        b=CaJ2ACKxyclBslA8dZvVvTw20X4ZWhJEws98WvzAZqeHslIxT3natT7rJ5+i9iI9iQ
         joKfbke506z6DzUxQrzNCtgEqV+XEnIe3IE8/HzzXUKOzlOnMuFHDSdqBH/FSS8LuWyk
         nA7aCndpyipeC6+8mDOXYhcVb2PAW9N6qEvKEgLCyEtoofAYTa7Akud7fi2LhiSoUKUN
         D4t2AXnemJgFpnJt+5VAol4bbbmTcDniNcEnMfPOVcxUjjc2eg70xaq42HjzVFtJxtFr
         mA5JY3tfFwkirL+wW9NxRhQWCMt/WPQ75wMDCJDuXfxGKWnM0nfWMbGE2KwrL2q/+xo6
         8/AA==
X-Gm-Message-State: AOAM533kCcTAbTh7G5/DL1dOh2WoOTomNn8pgaKV45VhXs9hl7GmZFkd
        TCtdjSizAA7Ovr4lM1qwerQgt3Jbfk8axA==
X-Google-Smtp-Source: ABdhPJx/n37x2UK4+DNsMeu6g11Ld+SqUYNAYixDe4pcLrq2Zvsk/iOxOFhbDYvyYIfIpp/DvLEu9g==
X-Received: by 2002:a05:6402:1012:: with SMTP id c18mr2508974edu.9.1635505305632;
        Fri, 29 Oct 2021 04:01:45 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q2sm3279837edh.44.2021.10.29.04.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 04:01:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mgPdo-0024gz-Ut;
        Fri, 29 Oct 2021 13:01:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Federico Kircheis <federico.kircheis@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git aliases and GIT_PREFIX
Date:   Fri, 29 Oct 2021 12:59:20 +0200
References: <2e328484-d0e3-8801-61da-07544cc93eef@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <2e328484-d0e3-8801-61da-07544cc93eef@gmail.com>
Message-ID: <211029.867ddww0vb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 28 2021, Federico Kircheis wrote:

> Hello to everyone,
>
> today I reported what I believed to be a bug on
>
>  https://github.com/git-for-windows/git/issues/3496
>
> and learned about GIT_DIR when working with aliases and git worktree.
>
>
>
> It's annoying that GIT_DIR it is defined only if (as far as I've
> understood) working from a worktrees or submodule, as it does not seem 
> to be related to those type of repositories.
>
> This is also irritating because apparently working aliases breaks when
> being executed from those repositories.
>
>
> I believe it would be better if GIT_DIR it's either always set or
> never (could someone enlighten me why the variable is needed in first
> place?).

I don't know the full story, but a good place to start is to apply this
patch:

diff --git a/cache.h b/cache.h
index eba12487b99..84d4c8da167 100644
--- a/cache.h
+++ b/cache.h
@@ -486,7 +486,7 @@ static inline enum object_type object_type(unsigned int mode)
 }
 
 /* Double-check local_repo_env below if you add to this list. */
-#define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_DIR_ENVIRONMENT "POISON_GIT_DIR"
 #define GIT_COMMON_DIR_ENVIRONMENT "GIT_COMMON_DIR"
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"

If you then run the full test suite that comes with git you should get a
pretty good picture of why/how not having GIT_DIR breaks.

Surely some of those reasons are fixable, e.g. are we invoking our own
"git" with "GIT_DIR=<path> git [...]", then we can just use "git
--git-dir=<path>", some of the others might be tricky.

When I did that the failed tests were the following:

Test Summary Report
-------------------
t9401-git-cvsserver-crlf.sh                      (Wstat: 256 Tests: 18 Failed: 16)
  Failed tests:  2-8, 10-18
  Non-zero exit status: 1
t9400-git-cvsserver-server.sh                    (Wstat: 256 Tests: 45 Failed: 23)
  Failed tests:  2, 20, 22-25, 27-41, 43, 45
  Non-zero exit status: 1
t9200-git-cvsexportcommit.sh                     (Wstat: 256 Tests: 15 Failed: 13)
  Failed tests:  1-2, 4-8, 10-15
  Non-zero exit status: 1
t9402-git-cvsserver-refs.sh                      (Wstat: 256 Tests: 37 Failed: 25)
  Failed tests:  7-12, 14-24, 27-29, 31-32, 34, 36-37
  Non-zero exit status: 1
t5516-fetch-push.sh                              (Wstat: 256 Tests: 103 Failed: 3)
  Failed tests:  101-103
  Non-zero exit status: 1
t5500-fetch-pack.sh                              (Wstat: 256 Tests: 373 Failed: 6)
  Failed tests:  7, 38-42
  Non-zero exit status: 1
t7003-filter-branch.sh                           (Wstat: 256 Tests: 48 Failed: 10)
  Failed tests:  6-7, 9-14, 16, 19
  Non-zero exit status: 1
t7406-submodule-update.sh                        (Wstat: 256 Tests: 57 Failed: 1)
  Failed test:  13
  Non-zero exit status: 1
t9902-completion.sh                              (Wstat: 256 Tests: 212 Failed: 2)
  Failed tests:  11-12
  Non-zero exit status: 1
t5601-clone.sh                                   (Wstat: 256 Tests: 107 Failed: 3)
  Failed tests:  12-13, 35
  Non-zero exit status: 1
t1510-repo-setup.sh                              (Wstat: 256 Tests: 109 Failed: 26)
  Failed tests:  3-4, 6, 8-9, 14-17, 21, 23-24, 29-30, 55
                57, 59-60, 67, 69-70, 73-74, 78, 80-81
  Non-zero exit status: 1
t5310-pack-bitmaps.sh                            (Wstat: 256 Tests: 73 Failed: 1)
  Failed test:  48
  Non-zero exit status: 1
t5401-update-hooks.sh                            (Wstat: 256 Tests: 13 Failed: 9)
  Failed tests:  3-10, 12
  Non-zero exit status: 1
t5531-deep-submodule-push.sh                     (Wstat: 256 Tests: 27 Failed: 22)
  Failed tests:  2-3, 5-15, 18-20, 22-27
  Non-zero exit status: 1
t2400-worktree-add.sh                            (Wstat: 256 Tests: 71 Failed: 2)
  Failed tests:  61-62
  Non-zero exit status: 1
t3430-rebase-merges.sh                           (Wstat: 256 Tests: 25 Failed: 1)
  Failed test:  11
  Non-zero exit status: 1
t5801-remote-helpers.sh                          (Wstat: 256 Tests: 31 Failed: 28)
  Failed tests:  2, 4-17, 19-31
  Non-zero exit status: 1
t7401-submodule-summary.sh                       (Wstat: 256 Tests: 23 Failed: 1)
  Failed test:  14
  Non-zero exit status: 1
t0001-init.sh                                    (Wstat: 256 Tests: 61 Failed: 3)
  Failed tests:  10, 13, 36
  Non-zero exit status: 1
t1500-rev-parse.sh                               (Wstat: 256 Tests: 75 Failed: 7)
  Failed tests:  35-36, 45, 49-51, 59
  Non-zero exit status: 1
t1501-work-tree.sh                               (Wstat: 256 Tests: 39 Failed: 19)
  Failed tests:  4-7, 9-11, 13-15, 17-18, 24-26, 31, 33-34
                39
  Non-zero exit status: 1
t5509-fetch-push-namespaces.sh                   (Wstat: 256 Tests: 14 Failed: 1)
  Failed test:  14
  Non-zero exit status: 1
t4201-shortlog.sh                                (Wstat: 256 Tests: 25 Failed: 1)
  Failed test:  9
  Non-zero exit status: 1
t5519-push-alternates.sh                         (Wstat: 256 Tests: 8 Failed: 8)
  Failed tests:  1-8
  Non-zero exit status: 1
t6060-merge-index.sh                             (Wstat: 256 Tests: 7 Failed: 2)
  Failed tests:  6-7
  Non-zero exit status: 1
t7409-submodule-detached-work-tree.sh            (Wstat: 256 Tests: 2 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t5403-post-checkout-hook.sh                      (Wstat: 256 Tests: 8 Failed: 1)
  Failed test:  8
  Non-zero exit status: 1
t2201-add-update-typechange.sh                   (Wstat: 256 Tests: 6 Failed: 2)
  Failed tests:  5-6
  Non-zero exit status: 1
t5402-post-merge-hook.sh                         (Wstat: 256 Tests: 6 Failed: 4)
  Failed tests:  3-6
  Non-zero exit status: 1
t1515-rev-parse-outside-repo.sh                  (Wstat: 256 Tests: 4 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
Files=940, Tests=24858, 144 wallclock secs ( 6.34 usr  1.64 sys + 654.49 cusr 307.66 csys = 970.13 CPU)
Result: FAIL
make: *** [Makefile:53: prove] Error 1
