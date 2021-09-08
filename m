Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9DDC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 04:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A4861152
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 04:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhIHEZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 00:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhIHEZc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 00:25:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942E6C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 21:24:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n5so1095228wro.12
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 21:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OXkAYMoV/d5UwQmG0R4b2B/agA76g5H473lxQGSvcD0=;
        b=KJnrN+e7oQasnG76IRWj5ajCGxyDktXqd7/sZmi7K5Y9b2yvSPv6vFFYH/yQXvyKhZ
         Cyo93C5ehF3NkDqyewt6qsmbGoRMGP5XZlff31mX3JV9eHrIz2aEReFsJVgqIjzM6SSY
         5hKMoxpFvOQEGs9A+R4vPUV1tYSsBaS20Rk5W8atgMw6bc4owfCWhhI9ZOT1B//XltLQ
         r/o8ER1uW8Lj2D3qUWftv3ZnGa92fWIIB+eo33OlA2TwhGIJ3bwPlSSPhT7xlF/XaEUL
         XRMgvw4acaI0GTr+bPH2afArkmECVRTNzv8Yqzfc6pVdf4x+nPSiXIbp94rX5V5ZuXFg
         /0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OXkAYMoV/d5UwQmG0R4b2B/agA76g5H473lxQGSvcD0=;
        b=McXHN1VUAC/WiO3A8DZG/8y4W7Fxr4Z320Mc+ninZ2z7FaBo2mjyFPNkghK+suKmWw
         4dhKe7as8daEp9WCGSy2PA4n5VBm7BuIcvk89HVDRDYChAB6VMPIn+vZ3FCrj4n932Rk
         HfNuz8PPWXKt/y83RIPcjIm9X9X0ZvTxOR9XVsOrocDTMMrr7XlYfcHYWDsrW+/WPlxh
         pvJX1aB039Qt0hvD2fZXACUYphN8qPaoFWsj+HPGlyWZbrLG2T6QPcXn+6ESQCzB6sfL
         TRGaOhU9ORggwsdJKsi6BZzK2oThtR+UMDcySLSPjO6gfFTxjaRZvHwebQIbUoJm5+WS
         z66A==
X-Gm-Message-State: AOAM533TGrUmXtlrCnV/JU6yRS+kz0pqzkx58Kqq121E+DadGpmSfJ3r
        2iHRnUQ0CnhkfRtz+hxD4TO/iA==
X-Google-Smtp-Source: ABdhPJzl4zdZCcDuPbgYZOTUArRNRr8i0PRVzJ2BWmBR1AqR/aHIT3VibqMyxxfG1qNPk05SgCJeYw==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr1580115wrx.262.1631075064047;
        Tue, 07 Sep 2021 21:24:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s10sm870044wrg.42.2021.09.07.21.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 21:24:23 -0700 (PDT)
Date:   Wed, 8 Sep 2021 00:24:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/4] pack-write: rename *.idx file into place last
 (really!)
Message-ID: <YTg69VUlpJvSNvAm@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com>
 <patch-v2-4.4-70f4a9767d-20210908T003631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-4.4-70f4a9767d-20210908T003631Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 02:38:28AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Follow-up a preceding commit (pack-write.c: rename `.idx` file into
> place last, 2021-08-16)[1] and rename the *.idx file in-place after we
> write the *.bitmap. The preceding commit fixed the issue of *.idx
> being written before *.rev files, but did not do so for *.idx files.

s/idx/bitmap/ in the last line, I believe.

Otherwise this patch looks good to me.

Thanks,
Taylor
