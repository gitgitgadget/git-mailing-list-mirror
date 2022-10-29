Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307EAC433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 18:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJ2SCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 14:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2SCa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 14:02:30 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E925D700
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:02:30 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p141so6976152iod.6
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sAlpLmcko14wz++Y9eX/LI+4Crqo9+xXY9hAIvrzIjo=;
        b=Uqibxs0YpJv9w4PXTswhDA1wi8jaR51UTc9Q+ilFiUpAnlXuCOKQo7BHg8xeIvGIgy
         B8xe2z4Zn1Tqea1+xUrtMsPuagShAgTaxXkDYMOrxv28XN/PgsLdLbOPXawSIwLMLrIO
         qaiCTiMEs28U5N8zywVErYHoED6IqRBVu6KTT5q65n0pXX5tFkp5xXJlp3Go/JbSysnC
         UXoTLrKG1RjGwiEKJwGiBm8FTk0N78/NFvd3061KKkNNGkqL83GRQKIScYi8o/780EQv
         yukxu/y8eXpqueFsfwFnTEFjyn7xIw8MPRH5NSv40fsAjgDCjcDealh/ZObs3f0wStvx
         /N5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAlpLmcko14wz++Y9eX/LI+4Crqo9+xXY9hAIvrzIjo=;
        b=3x4sHx8hxeKesUAyeZY3AmMusxEMXjl+3Ku+K1LUFUCGdqwYIeIlzrk9zUrTVgxI0G
         MLvqWz00rIgH0lm2s5jn/1fA9idGhy6AKwRu5wxbMuIiNaqK3f989QHHusL8jMHoEwHX
         NlsjfBo5wsBkD7AtL74T6AwM7pVwQfq/cKeOu8gdCPbblid71nzObMjsSX90mPu0Movh
         HXJo7o7oGkjX3rPqjtk379EfvTof5Va1mbyTEjFNh2BsZKun1GnlVQUcCwEBTn0Ocss2
         l+3Vruxcm9A3ZR12fPhvBvbsiQiJ+2JquFzlZLtx6risCVYRKvWIAxN1O7259seTQ3SL
         J7fg==
X-Gm-Message-State: ACrzQf02mRc8azxb2btIz/8wqd2OGQ5SF5Ux4EF8bEqdO9sTdZprPfrR
        gv5y1gBxNh/5x3EBDINZ/Sd3dg==
X-Google-Smtp-Source: AMsMyM6fc+tV9rO1Xo57xZWByZ6M7O2mbsFqdnNchCaGp8GyOzYTpQA8F2+GGLfRpexUOxjXryMk6Q==
X-Received: by 2002:a5e:8517:0:b0:6c6:fbe7:1c0e with SMTP id i23-20020a5e8517000000b006c6fbe71c0emr2435245ioj.95.1667066549560;
        Sat, 29 Oct 2022 11:02:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q125-20020a6b2a83000000b006bca2c3cbe9sm884286ioq.2.2022.10.29.11.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 11:02:29 -0700 (PDT)
Date:   Sat, 29 Oct 2022 14:02:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] archive-tar: report filter start error only once
Message-ID: <Y11qsz+xvm6TVYrh@nand.local>
References: <c51b72e5-1c32-65e4-6faa-04693b623e2e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c51b72e5-1c32-65e4-6faa-04693b623e2e@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2022 at 12:06:06PM +0200, René Scharfe wrote:
> ---
>  archive-tar.c       | 1 +
>  t/t5000-tar-tree.sh | 7 +++++++
>  2 files changed, 8 insertions(+)

Looks very reasonable. Will queue, thanks.

Thanks,
Taylor
