Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCE4C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDCA76127B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbhHXWUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 18:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhHXWUl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 18:20:41 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7E9C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 15:19:56 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b7so28346597iob.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 15:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=51P7K7Q3n8HOTvBWr0B/zKspau7nL+N8B+kpQ9GwVuQ=;
        b=gwQqQR34lbm/yFF/EK0zOADdouSpVUSTlKJggaBEuQTVn6yyiDdGebGLxm/n1iU0/E
         CvoBMmsFjbyaKUGfVqtiRYiqn9rWqTPRHQVYrBMiJezh64s8H/3fPF+rryf5Bhg+c4rk
         wh5sQC6ELmDdNzU4ZY7NP6h7wqkTedkJse2+YzP0NG5dwPp0AeF4m7fQlwsIEC85/wFv
         imPFDKPeuqXeKS/VTSncga2Mutr4Gdkpw/IShYObz8tjW6by/gd0LeSEpZEpBtGv8Po4
         Yx7EEJpo2jT+QorZEQGoZiR5NxnnpV8WRXGiOomFgcvsEVOtrvNb4D5M5rM6xwYD173M
         O03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=51P7K7Q3n8HOTvBWr0B/zKspau7nL+N8B+kpQ9GwVuQ=;
        b=n2lSktui9cTz8fDJEnZMV0WrzkP+B+vm6ERLgurH3an709AYDTdhCfABvst2sOyaoV
         3IZwZk7neKqfbt4MMat5xhoisyUVFKvyh3a6XBXozWa3yn8SW1xZjmi4QZr8xcKvnlqP
         1yi5m9A34mer8xB6rMf88Fka5jxGQK4D/0S+GqxpghILeExbkWFntF1CqlZ8sVSPvAIk
         uKE1IAKA4Zz0CqGuh7fzWgXAKtmWAnBR2Bb2KoEa3dIG0f4aSozY5ND6z3ahcPUrgpAz
         PvLoLLqcqdij2WYhe9blfTlya37p+dJ65qjN2oVeJM42obcSKKWpB170d3YOJaH4x27n
         EKlA==
X-Gm-Message-State: AOAM531bY/c+o2fJ9OLseC5GRf/AgIiZ1Bwm64X8muBsdR1xH73m5LTF
        FQusCPEJgfY8VLZk4ktMlX9YRw==
X-Google-Smtp-Source: ABdhPJyGuquVRsxrMCCVY2KOCL9/lBg3fWhJuKRon2f9H3gnTwpgvRbO+ab5mGVyMey/UlIFPKgxBA==
X-Received: by 2002:a6b:710f:: with SMTP id q15mr26742751iog.77.1629843595902;
        Tue, 24 Aug 2021 15:19:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o15sm10971894ilo.73.2021.08.24.15.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 15:19:55 -0700 (PDT)
Date:   Tue, 24 Aug 2021 18:19:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/4] test-tool: split up "read-cache" tool
Message-ID: <YSVwioizjGKVSXQA@nand.local>
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 11:15:21AM +0200, Ævar Arnfjörð Bjarmason wrote:
> A re-roll addressing the feedback v1 got, see
> https://lore.kernel.org/git/cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com
>
> I think the gist of that feedback from Emily was that v1 could be
> understood as aiming to optimize the perf test, but the main reason
> I'm doing this split up is to make the code easier to read. The
> changed commit message summarizes both goals.
>
> I also changed some nits in the code I spotted myself, e.g. "argc > 0"
> checks to just "argc", and a simpler way of providing the "cnt"
> default.

Playing devil's advocate for a moment: I think that the current
implementation is somewhat easier to read as it lives in a single file,
and makes clear that each option implies different behavior through the
body of the loop.

If we're looking for things to clean up, I do like the conversion to the
parse-options API instead of reading argv ourselves, but probably
otherwise prefer the code as-is instead of split across many files.

But I may be in the minority, and there may be others who do find the
split-up version easier to grok.

Thanks,
Taylor
