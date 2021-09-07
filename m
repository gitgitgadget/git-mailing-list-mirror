Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF49C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 22:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D0D6103D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 22:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346723AbhIGWcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344607AbhIGWck (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 18:32:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F977C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 15:31:33 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id c8so823927lfi.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 15:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jPI1KgMS1f16J1wQFMkeGoIKE/KaewXAuaLi3r0krzA=;
        b=q43kVU6pBclH/m5uQqiRBuYDOtAUKIxj8yZlnhqauJiF7QGAT60z4EHy5A5Ys5bUBo
         0QPmW4AHLEkKf+PMZ+IfqPJAMG4pXnrTIxQHDDV+3dSKGmvEZNHg4dPO07wmTtfEEUQx
         ZV37mKRBSdZFQMMIBy2CRuJd0MRr0bRPHGsYBSsKaruNb1QY1VOk9I5x8sSzMUrrH+HV
         AdzPriQ/1jvt5M4dVhtzrQQxPaLSw3FRTXo+VuFDuF3EsaLdkZVt8/3Yn5Br4TUy4fHr
         rDT3XFQGyzepvdNx61PNgGj0GSJzwaiqSklzYlnh9Sh5NuQEKCHPKYhM7FhoarlZ6r7s
         tRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jPI1KgMS1f16J1wQFMkeGoIKE/KaewXAuaLi3r0krzA=;
        b=pxFCjCQKtHndwZ9TDprdmzwKPgDWtyVJUu5uchq+QqKL1KeemkmyMMS+beQaOVR5wP
         bY8KXTR8aM0uZXH6N2EnlRLzHrmorclg19OSOcg74036qxjodK7aEmCQqe82EtWDow26
         XFZdcXITXhZiBVmpB9J38Zkykee20hq/91/5pFsAru+IDcbCHrOLNhxQa9AMDrS530Yy
         tL+3IeCVbCAdzQyyjpvBQCeQfrVLRAvO0ZqaICZYv/w8Z7Ro8/ExSqcrLdJzaEY7PbRq
         JZY1MazD+qWi1Y5Siw/eX2v4NGRYsHV2Kz5dlZrHZFm939BFXCUFPYunmRQdUPtT7FU/
         /tkQ==
X-Gm-Message-State: AOAM532Cn2T4QBkWOkkdnhboamMwBSXS5C+0txlqk+KrmACXh4KI4SO2
        9H0SDqAeT+9/BaPyGnRmpOmh8g==
X-Google-Smtp-Source: ABdhPJwlNyD/0h+/9JHjYoTPvu7gcdyYk5v4usIN+WRCW4qBB9etU4y3q/Tb59ECsYMxvxuAWFpFww==
X-Received: by 2002:a05:6512:3f21:: with SMTP id y33mr476766lfa.606.1631053891489;
        Tue, 07 Sep 2021 15:31:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 203sm22238ljf.63.2021.09.07.15.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:31:31 -0700 (PDT)
Date:   Tue, 7 Sep 2021 18:31:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] pack-write: rename *.idx file into place last
 (really!)
Message-ID: <YTfoQJf6M5BCIT1R@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com>
 <patch-3.3-78976fcb7b2-20210907T193600Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.3-78976fcb7b2-20210907T193600Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 09:42:38PM +0200, Ævar Arnfjörð Bjarmason wrote:
> +			/*
> +			 * We must write the *.idx last, so that anything that expects
> +			 * an accompanying *.rev, *.bitmap etc. can count on it being
> +			 * present.
> +			 *
> +			 * See also corresponding logic in the "exts"
> +			 * struct in builtin/repack.c
> +			 */

TBH, I'm not sure the cycle between comments helps much, and it would
probably suffice to say:

  /*
   * write the .idx last, so everything else can count on its existence
   */

In both places. But I don't think that it makes much of a difference,
really, so either outcome is fine with me.

Thanks,
Taylor
