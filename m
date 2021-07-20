Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7984C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96139610D2
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhGTQjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhGTQii (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:38:38 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85D0C0613DC
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:18:42 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id l5so24845217iok.7
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Y0BRaPGI84uk3L5U4VsZHzqd+ocjmE3McRLc+XLmEKs=;
        b=j13EdSWgRezBjCe+F3IP7VVPGDEACJqug/8J8K1M+LB0YoxKG5V8wiRPl68P0SkpuA
         /+ZxWaWvn0ZF4a40DPMEsXRnqUKIr8qjsoFHP7HWTyjs+wluB3P8m1yfz6u3C3Bj0DSl
         dxE/rLoHigeYrBKhlHb+hN5GZprJe/B8bWsWsfOkpjLxt3mxHrqJtgyXoT4DauUmlI+Y
         hkmf2Vs2i61jWAas5t3WOkuQClRsc2ApsyeHIQgFKaGKEL2G7f6vzcZtr8tOXNX6BBwt
         pjjsFSsTSIxADG0m1ghfiO89uq69jfwn+2/cguFu0GDZ6fEgb7WQ9d6wp3oCmoCcPfuP
         l9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y0BRaPGI84uk3L5U4VsZHzqd+ocjmE3McRLc+XLmEKs=;
        b=teKpPGrjijqY2OK2Eh7FNpp6E28NOkSjVMjOqldSPQ/WsDRq67O0cFuW6zO7Wn0LVo
         /fx2mc5J3dqTNvj1QtShMbAzxzBH7SlaenCZSNlKW62D2+BdbuAWv5aPBorQqaa/PNf1
         xJRt5RNWRItxJLDKy1rQeEDG3bWq1MOuwCdUgSIpdTYyLBF1W4+MzIoKb9oXTXxZ03Ep
         abz/dvnVJou66IGDAADKjCwgd6ViFZxn3ai3kZNb7Mqnc7lvRuKIzbYV2caMp/+FszAH
         Lx/cMC2JYL6qPxBJlg0CWzsEoLgwlv1XD1TPGJbE7m7UZBeyn5X3cgZEvXgrJ7hg31SX
         ULaA==
X-Gm-Message-State: AOAM531RxKHAP4Qg7cRcll9Lezc/RYwz8Ii3iZB/DFZEC8Fc6PxoUEL2
        H+7ihYHuZ6aXcRmPPzjSkNFSYTgac2rcuaK2
X-Google-Smtp-Source: ABdhPJyKBoy0WzfDtjC04L/1NiGdU3Ue0YtaUS6SsZURlRpV9tlOsv4xy0FC8nl9s5HJNNyGvzU0Ow==
X-Received: by 2002:a02:ca58:: with SMTP id i24mr26801257jal.101.1626801522223;
        Tue, 20 Jul 2021 10:18:42 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:9f71:89c7:e095:b8eb])
        by smtp.gmail.com with ESMTPSA id 204sm12662405ioc.50.2021.07.20.10.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:18:42 -0700 (PDT)
Date:   Tue, 20 Jul 2021 13:18:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 0/2] bundle tests: modernize, fix missing coverage &
 test_cmp
Message-ID: <YPcFccdfhW1rvxaw@nand.local>
References: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 01:52:07PM +0200, Ævar Arnfjörð Bjarmason wrote:
> A trivial series to improve the bundle tests a bit. This is split off
> from some larger changes to "git bundle" I have cooking, where the
> "test_cmp" in 2/2 helped assert & catch regressions.

Thanks. Both patches looked good to me, and I left a couple of minor
suggestions on the latter patch to potentially clean things up a little
bit.

But please feel free to ignore them, and only pick them up if you feel
they do improve the readability. Since I would be happy to see this
picked up as-is, it has my:

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
