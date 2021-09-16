Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECECC433FE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6056C61207
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbhIPTEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346442AbhIPTEX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:04:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5BCC0C6CBB
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:37:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u15so11008387wru.6
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1W+Gs52s2A2GXwFshhEzcrig4K83erzWSnFdO+ZDpFc=;
        b=NDRXR3l8ubvBXcKQmVKt8KxeYbLzO4p00bDUzVzmNwHXcE4DUXPN8oB4RSF8D6I1U7
         GdXZZi36nhYrCsOKYDfUNMB/c4aot6Amc1iMrEQwnV7+ivb8DCsSv3m1+M00LGISJUB0
         GajKY+q/nbtAFtw6+KaFVHuiow/xVB2iI5REv1N3vPIHCUQsymCLLqiTDF/9t9nEOxfd
         +ezsYJ7m14eZ/E8dB4+eMZEd21RD5dAmj1Bg+aLem68r2KhX0A0/9VxLoWoozCg65zpU
         lGG3PdMc+hEnDxQohzv/aCCAQ6lJXlSR2RJJQDdeP4kpONCMbv/Zz3AVM+sGGKsVROUN
         cbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1W+Gs52s2A2GXwFshhEzcrig4K83erzWSnFdO+ZDpFc=;
        b=P0yPPwOMOfRz4BOnywmgkw1F8sk2AFfBlGApRrkL/1kWd6ojuuAqFHrMpF9LQGO2SP
         CHGuiphtOGtgw/lwmPFD2yEdaFwdh7YUulJOkJkU2/zXLXBH9NPxlMUFBC+W4QqY1kEt
         FagC1ZEQfkokZE6qGi1XJkvKaFF4DbJrTeYLkTpfnIZxvacU+dU70khLgXY/A6elbsyS
         UHUjdaQYDo+goWjeksf0qcdNHzfa9fVqaCPA2ILAxsnrPP/qEWZQ+vfX6z8QHEHK62LH
         v/2i5SQneNofdVRpzb98Mp3qX9317yPzYqCp4ce0g+R9L94dUh5NKgXb4l/veth1Acq5
         IbPw==
X-Gm-Message-State: AOAM531pUKYyEOvbjcy5ReEWNNg61DLTWvJe62wL+xfWwDZew7/9YOm9
        4Dkjh0pTyLo56yHlfxaA/30=
X-Google-Smtp-Source: ABdhPJxsmhe/ey+Gg1ARaaMcahJ2kQefKnOeHy7PHm9ok/+dOFcyKjy/EuKLow3t5yhM20lA6kEszA==
X-Received: by 2002:adf:f911:: with SMTP id b17mr7781445wrr.412.1631817433746;
        Thu, 16 Sep 2021 11:37:13 -0700 (PDT)
Received: from szeder.dev (94-21-37-152.pool.digikabel.hu. [94.21.37.152])
        by smtp.gmail.com with ESMTPSA id i1sm3982454wrb.93.2021.09.16.11.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:37:13 -0700 (PDT)
Date:   Thu, 16 Sep 2021 20:37:11 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 18/25] progress.c: emit progress on first signal, show
 "stalled"
Message-ID: <20210916183711.GE76263@szeder.dev>
References: <YNKWsTsQgB2Ijxu7@nand.local>
 <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
 <patch-18.25-e21fc66623f-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-18.25-e21fc66623f-20210623T155626Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 07:48:18PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Ever since the progress.c code was added in 96a02f8f6d2 (common
> progress display support, 2007-04-18) we have been driven purely by
> calls to the display() function (via the public display_progress()),
> or via stop_progress(). Even though we got a signal and invoked
> progress_interval() that function would not actually emit progress
> output for us.
> 
> Thus in cases like "git gc" we don't emit any "Enumerating Objects"
> output until we get past the setup code, and start enumerating
> objects, we'll now (at least on my laptop) show output earlier, and
> emit a "stalled" message before we start the count.
> 
> But more generally, this is a first step towards never showing a
> hanging progress bar from the user's perspective. If we're truly
> taking a very long time with one item we can show some spinner that we
> update every time we get a signal. We don't right now, and only
> special-case the most common case of hanging before we get to the
> first item.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  progress.c                  |  7 +++++
>  t/t0500-progress-display.sh | 63 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 66 insertions(+), 4 deletions(-)
> 
> diff --git a/progress.c b/progress.c
> index 6c4038df791..35847d3a7f2 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -255,6 +255,13 @@ void display_progress(struct progress *progress, uint64_t n)
>  static void progress_interval(int signum)
>  {
>  	progress_update = 1;
> +
> +	if (global_progress->last_value != -1)
> +		return;
> +
> +	display(global_progress, 0, _(", stalled."), 0);

We have a few progress lines that are updated from multiple threads,
and to prevent concurrency issues those threads call display() while
holding a mutex.  This call without synchronization causes undefined
behavior.

