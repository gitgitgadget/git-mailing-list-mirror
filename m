Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E48CC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 21:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F25B61182
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 21:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhDIV1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 17:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhDIV1m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 17:27:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EEDC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 14:27:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z1so8131158edb.8
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BuCiBGb82Z0RNxuGJ5+8YWRkYBibE/mNJ1Y9fyzEoa0=;
        b=GBOBTRunvk6gZbviuGXNAVnhIH64v5Fifsvr6FDrz8CZw3WQoi5X3rHs9tWIXSGAu9
         0Cu2PRDP2Hp3wpNnCKaZQDOynopSK4MVqgD4niwxpGrLUm/c/dX9hX/ruAY6fLwaslFq
         /kgUZ1RiKsE3UwxpRE60mGxYXWcfP+3Fq2ms/VrDH9K7VPieH6BPTMVnR7U4QTZrXQms
         mWTnAf31yEAvvOkg+agXG/JORE4GXd/uWM7BUxSNA2myiqxe3SOCVSmgwTDH4D0PsQ8K
         xzxQTjU7qHd6l9hXzJbuLoiUUYkTNELp5CjXlQU4bMJjfio9Z0N9kt5VKciKHDKyXEAN
         bhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BuCiBGb82Z0RNxuGJ5+8YWRkYBibE/mNJ1Y9fyzEoa0=;
        b=peLu+48lO1Tpt+gPRWPc5ATORO3kch1ybMhb/btX0YIXVvziq0VBoGP4VBZHIjWoqA
         z8CiRorp2F68fb+VyRAHYm4F8cKDUkP1+MqdPLmpgVqMNhHXqDldgOWU15UpuiGQRuth
         tPGxPpmc+Tm9FUSUhSjQF8fvQ59JjgNSoUZMuuKSVyZTNJJkfXnJxcrCfUbQN8kzIuzo
         SSu2PBjpDlD7Q438YmdHGL945Yn8MiNYnZkLMSK+RlpGR2cq0PgMmFZVfMPVa+ekbb9P
         1bs5GUVC/oh/oIDiDBlJtMJqwc/KedMX/ZHojhtMGVcmPf20uB2WTa0mRcT7WmdGVUPd
         qFlg==
X-Gm-Message-State: AOAM532/RpD21w4+3l3Mcmhv9Wgu58fy8IPgkGF4+DpJrHlP1La+0Mwl
        kibUmWoEz2FNAwWL/Na5CH8=
X-Google-Smtp-Source: ABdhPJxRK3ns6HBY3qPrdBxBBnRHOdxjtlQghfRq2t3t+IFNq2m4sqnd90VFeWuKunasOfJ6fQJ34w==
X-Received: by 2002:a05:6402:27d4:: with SMTP id c20mr19464071ede.271.1618003646335;
        Fri, 09 Apr 2021 14:27:26 -0700 (PDT)
Received: from szeder.dev (94-21-23-40.pool.digikabel.hu. [94.21.23.40])
        by smtp.gmail.com with ESMTPSA id ck29sm2037435edb.47.2021.04.09.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 14:27:26 -0700 (PDT)
Date:   Fri, 9 Apr 2021 23:27:24 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v13 4/5] bugreport: add uname info
Message-ID: <20210409212724.GE2947267@szeder.dev>
References: <20200416211807.60811-1-emilyshaffer@google.com>
 <20200416211807.60811-5-emilyshaffer@google.com>
 <87mtu8ifmj.fsf@evledraar.gmail.com>
 <xmqqv98wquqp.fsf@gitster.g>
 <87h7kgieyh.fsf@evledraar.gmail.com>
 <YG+Ux3UKJDa4yWUr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG+Ux3UKJDa4yWUr@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 08, 2021 at 04:41:59PM -0700, Emily Shaffer wrote:
> On Fri, Apr 09, 2021 at 12:33:42AM +0200, Ævar Arnfjörð Bjarmason wrote:
> > On Fri, Apr 09 2021, Junio C Hamano wrote:
> > > By the way, what's this sudden interest in re-reviewing an age old
> > > topic?
> > 
> > The thread got bumped by SZEDER in [1] and I'd read an April date
> > without noticing the year, so I see this has long-since landed,
> > nevermind :)
> > 
> > 1. https://lore.kernel.org/git/20200416211807.60811-2-emilyshaffer@google.com/
> 
> Phew, you scared me :)

Doesn't the output of your bugreport tests scares you?

  Initialized empty Git repository in /home/szeder/src/git/t/trash directory.t0091-bugreport/.git/
  expecting success of 0091.1 'creates a report with content in the right places': 
  	test_when_finished rm git-bugreport-check-headers.txt &&
  	git bugreport -s check-headers &&
  	check_all_headers_populated <git-bugreport-check-headers.txt
  
  Created new report at 'git-bugreport-check-headers.txt'.
  grep: Thank you for filling out a Git bug report!: No such file or directory
  grep: Please answer the following questions to help us understand your issue.: No such file or directory
  grep: : No such file or directory
  grep: What did you do before the bug happened? (Steps to reproduce your issue): No such file or directory
  grep: : No such file or directory
  grep: What did you expect to happen? (Expected behavior): No such file or directory
  grep: : No such file or directory
  grep: What happened instead? (Actual behavior): No such file or directory
  grep: : No such file or directory
  grep: What's different between what you expected and what actually happened?: No such file or directory
  grep: : No such file or directory
  grep: Anything else you want to add:: No such file or directory
  grep: : No such file or directory
  grep: Please review the rest of the bug report below.: No such file or directory
  grep: You can delete any lines you don't wish to share.: No such file or directory
  grep: : No such file or directory
  grep: : No such file or directory
  grep: [System Info]: No such file or directory
  grep: git version:: No such file or directory
  grep: git version 2.31.0.7.ga9ff022d9b: No such file or directory
  grep: cpu: x86_64: No such file or directory
  grep: built from commit: a9ff022d9b49e64336612f89100eb5220ed793bd: No such file or directory
  grep: sizeof-long: 8: No such file or directory
  grep: sizeof-size_t: 8: No such file or directory
  grep: shell-path: /bin/sh: No such file or directory
  grep: uname: Linux 5.10.17-051017-generic #202102170631 SMP Wed Feb 17 11:37:41 UTC 2021 x86_64: No such file or directory
  grep: compiler info: gnuc: 9.3: No such file or directory
  grep: libc info: glibc: 2.31: No such file or directory
  grep: $SHELL (typically, interactive shell): /bin/bash: No such file or directory
  grep: : No such file or directory
  grep: : No such file or directory
  grep: [Enabled Hooks]: No such file or directory
  
  ok 1 - creates a report with content in the right places

It does scare me...

