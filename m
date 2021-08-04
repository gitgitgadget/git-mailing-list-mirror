Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56772C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 18:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37BFC60C3E
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 18:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbhHDSHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 14:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbhHDSHP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 14:07:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19E6C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 11:07:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n12so3222650wrr.2
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0keLC4rgQaA09lrIQ4PRBDq3UuwXzc36/c5vKxTD2/M=;
        b=g1rEAi0F4S+YZX8P5xd9B2i0X3qnGPlYxDqp7jJ7sxM6Y5mNB7Uf6VS+5t38Jww3op
         KiCOkT6W9mT2dth9sad7SQgkCY8bGYRTf06KVx3EMar1jMIP5gVMLsOrmdHMB5ONEgrL
         Bp423AaHmTCAGUez5OUGTLAt92hYxprwUmGW798Hugfva0OrK0NU+lJK+dNSwpfdHN86
         GR+wL5IfpqSX04dK9IPPSOs9nngcuAt+4e/Z+21qkLFsin5WhbAlsGIaXKF2073ZxrX6
         aylP4gxHRpNuOh2ZXjjw8DxsbJ2lZ8TBAz+5UV05tOnxhuE0odRnV0BYLOtZMEcW7jef
         qoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0keLC4rgQaA09lrIQ4PRBDq3UuwXzc36/c5vKxTD2/M=;
        b=P68TSpBhqt9eePa+SxAH7nwWFN3V6q/uLPfdZoUvmFwLEAQfXm1K2afUuG1LiKUCQc
         LYXCqE0drSypBI76SSMblLUV+4Ku7/XbYDHLpjP/C9ud41m2YKCePMAkjBQWSQifthPl
         ExT70uZ7bjprGfRcLKVIl5uXETbKFSwtnGEUWPRGxPJhTcf+poi9wvPHH+voD3YunxiX
         ajtWhaOxlK+6tpPLWdpUmGUsTSdjAogepwSNLrZcUme0Z2ogHDYzxcHQoRcIantxA1EM
         cMDPfFd0S80bZXhW+kc/arx1xJ4AdROD9WOCaa9d54hP1TJQ/+ltpRe/rWCogq/UWtks
         v6Pw==
X-Gm-Message-State: AOAM532/F7LiTzr0lvKMKKPZ1pv2U+e0GPhMJVn8ziCw/6YOu3DZ8MpM
        8BLJpgWfNBmOL72YIzNqJgw=
X-Google-Smtp-Source: ABdhPJyZdxUNQmC6XNu+EaAW7UPWoogj1fhXDnXt4Dzrs866wDw9S51cbOGtljNE8v5pd2W3GNXlgQ==
X-Received: by 2002:a5d:4f0c:: with SMTP id c12mr640409wru.63.1628100420299;
        Wed, 04 Aug 2021 11:07:00 -0700 (PDT)
Received: from szeder.dev (78-131-14-245.pool.digikabel.hu. [78.131.14.245])
        by smtp.gmail.com with ESMTPSA id z2sm2966085wma.45.2021.08.04.11.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 11:07:00 -0700 (PDT)
Date:   Wed, 4 Aug 2021 20:06:58 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
Message-ID: <20210804180658.GG23408@szeder.dev>
References: <xmqqfsvpr8t5.fsf@gitster.g>
 <87wnp1mqv2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnp1mqv2.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 04, 2021 at 12:22:44PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > * ab/progress-users-adjust-counters (2021-07-23) 3 commits
> >  - entry: show finer-grained counter in "Filtering content" progress line
> >  - midx: don't provide a total for QSORT() progress
> >  - commit-graph: fix bogus counter in "Scanning merged commits" progress line
> >
> >  The code to show progress indicator in a few codepaths did not
> >  cover between 0-100%, which has been corrected.
> >
> >  Waiting for a clarification.
> >  cf. <xmqqbl6slmer.fsf@gitster.g>
> 
> I think that what SZEDER had to say in
> https://lore.kernel.org/git/20210802220506.GF23408@szeder.dev/ should be
> enough to clear this to proceed forward.

Note that I also pointed out errors in the commit messages that should
be addressed before this patch series advances; see:

  https://public-inbox.org/git/20210802210759.GD23408@szeder.dev/
  https://public-inbox.org/git/20210802214827.GE23408@szeder.dev/

But none of these patches fixes regressions introduced in this release
cycle, so it's not urgent.


> I.e. this topic is missing his subsequent
> https://lore.kernel.org/git/20210620200303.2328957-7-szeder.dev@gmail.com/
> patch.
> 
> But as he notes we only encounter this in one of our tests (and are
> unlikely to in the wild).
> 
> Between this topic and my ab/only-single-progress-at-once I think we're
> better off getting those basic fixes in before proceeding with any
> tricky additions of BUG() and other assertions, per what I noted in
> https://public-inbox.org/git/cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com/;
> i.e. that some of those assertions were themselves buggy.
