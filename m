Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5764EC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF0A2080D
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="sFwTfTbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgEFRp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgEFRp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:45:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAAEC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 10:45:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id n11so1116818pgl.9
        for <git@vger.kernel.org>; Wed, 06 May 2020 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mLdC687VuTQfyioDVyBoj2gxGrEB2zFLVNHkombhspY=;
        b=sFwTfTbW/xcmpX4YhGukLGa+Wid1kknd31NZNY4Q4H7XsUT8DaGPnRRjGfOnP987FB
         RACJHnks9NcVADaHDVZtLWHuySr567joZdUrwoPlEHxOJimMzhdWWe3dhczq8kk+VDrn
         ufw16Ov4NeR6f+Zeg1bkl46L4LHaWrqWGA/b9LlmzyyEdt2+vmrQ8zrvplnGh8kurU6p
         g9r9m2Rf58So/r7D4EcJFBrrzAIrK1/jQrm92RG/dbDgI+KMeQEEThQSCdyueO811DLH
         6XtT9XxJIW9/jILSJ9DnYf2ERNAKAX2nhVSdyrRD0Ggna66opawSlBh+oQ2aFGiv0zlc
         A+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mLdC687VuTQfyioDVyBoj2gxGrEB2zFLVNHkombhspY=;
        b=sfoSKkA95oZJL/bH02DC4VBrsWinrkcVD8Pm4RA7iHbXy7RlH18jZZayPf9VosQOXJ
         CWLnI3yG6yJTgYqvYqiBr4W/H1jEL3Dr+3H0J+IobV7feA3wpW5CkK1zdqcCAmBIUsvl
         2vyz+wW5/fGNz/WSjvliMPQFUJOaOAOcyWZZYycdJF1B481JnyWERArwOVEH4EwpbadZ
         NPTbu9Gie+DGY3AcL9ahacCYE0/US1RM1HhUFQxjmBoDxWnVgMV9dLOnqsuaxno2/hiJ
         6Iol2lwVylmsZJSjJcyaYT95zlyR0eJ4uPPiaJg+ZfWiFQ/kah+y9/DtZKaxh+mfbaMx
         BKAQ==
X-Gm-Message-State: AGi0Pub1bxrJFJ3BPTwWHv2cHvLTNzti21dPzaFc4TVQU2WyNYcrWf88
        ZJLWBG3BJO1ajuL8u8ZgcjYxTf/1PcQ=
X-Google-Smtp-Source: APiQypJUd0VZ2801ZniX+d4n7MPE8EZfN/YAUnK1DMalL/fZ8NzVN8BxdMF8Ka0w8Xu5qfIWawQEQQ==
X-Received: by 2002:a63:c603:: with SMTP id w3mr2538968pgg.291.1588787126711;
        Wed, 06 May 2020 10:45:26 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id l6sm2431744pfl.128.2020.05.06.10.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:45:26 -0700 (PDT)
Date:   Wed, 6 May 2020 11:45:24 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (May 6, 2020)
Message-ID: <20200506174524.GE6078@syl.local>
References: <4a47a215-f636-3f94-17f5-33f13140bdc7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a47a215-f636-3f94-17f5-33f13140bdc7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Wed, May 06, 2020 at 11:19:38AM -0400, Derrick Stolee wrote:
> Here is today's test coverage report.

Thanks as always for running these. I personally find them very helpful.

> Thanks,
> -Stolee
>
>
> [1] https://derrickstolee.github.io/git-test-coverage/reports/2020-05-06-commits.txt
> [2] https://derrickstolee.github.io/git-test-coverage/reports/2020-05-06.txt
> [3] https://derrickstolee.github.io/git-test-coverage/reports/2020-05-06.htm
>
> ---
>
> pu	c0f7ae5a7ea5cf8246270fcf1853726167ca8ef4
> jch	fffcd002d6befa77784a44046b986934b87e6c3b
> next	55c56c9c57da646085d27e61a3420043978ab4a1
> master	07d8ea56f2ecb64b75b92264770c0a664231ce17
> master@{1}	86ab15cb154862b6fa5cc646dac27532f881e1fb
>
>
> Uncovered code in 'pu' not in 'jch'
> --------------------------------------------------------
>
> Taylor Blau	199d758e builtin/commit-graph.c: dereference tags in builtin
> builtin/commit-graph.c
> 199d758e 244) progress = start_delayed_progress(

I think that this one is fine. In the commit message, we even say
something to the effect of "hey, we're probably never going to actually
show this progress meter, at least in the case of a not-horrendous
amount of input with '--stdin-commits'."

I'm not even sure what the standard procedures are for testing progress
meters from 't'. I'm inclined to just let this one be.

> Uncovered code in 'master' not in 'master@{1}'
> --------------------------------------------------------
>
> Taylor Blau	37b9dcab shallow.c: use '{commit,rollback}_shallow_file'
> builtin/receive-pack.c
> 37b9dcab 896) rollback_shallow_file(the_repository, &shallow_lock);

I'm lukewarm on whether or not this should be tested. The same commit,
37b9dcab, is testing another location of 'rollback_shallow_file'. If
'rollback_shallow_file' were defective, we'd expect to see a crash with
'git -c fetch.writeCommitGraph=true fetch ...', which we know from
Elijah's original report.

So, I think that we have high-enough confidence that
'rollback_shallow_file' is working as intended.

> Taylor Blau	fdbde82f builtin/commit-graph.c: introduce split strategy 'no-merge'
> commit-graph.c
> fdbde82f 1788) break;

This is stopping us from trying to roll up commit-graph chains when they
cross an alternate. It's probably worth adding a test for this (although
this line has probably always been uncovered, and is only showing up
again because fdbde82f indented these lines by surrounding the loop with
a new if statement.)

Thanks,
Taylor
