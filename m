Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DA1C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 22:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiKKWXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 17:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiKKWWy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 17:22:54 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A88B1FA
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:22:43 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id l6so3190801ilq.3
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LXnzChLbTQFiemWT+0PbX6dYA4sRPofEkl/GAwCg/T0=;
        b=Zpf9hay479/+kI2QWkQczhajQ5irDcoEO/CRZSq/hdFhzNMFXr/DKLlGYyA8WeB8ya
         5eljN+eTR9KnMmNZqpnViNUKK0yjy2YZw44kcJvF/6QBwbx0xPJzwxK9Il2uBspwgvgj
         5+9SQwAvQZvEhT6up6eMpMwQQgufpChYLAmFPeHYHZfQmXwfDjgzr0qnK3FoyxiVyzpO
         F7UVTIH4Yt2WZN/jUrv5JrWSQe4EPV+BtxV4nP4g/KOXjMz4SSbmoeIsazdl4AHq3QtN
         SqWtgmGAR3F8dMS/hGPUpHp036qPdjEr3GlhsQ4cev5Ccz3S+Aijh/3fhsxNFCuEVM48
         3GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXnzChLbTQFiemWT+0PbX6dYA4sRPofEkl/GAwCg/T0=;
        b=43Dm9NpoaaXtNh2YQkQXjRt/uP10ynqkGFK75dk8SdZpwjUv6vm41f6r5noGms7EDh
         kmjZHYDJgvWcJhI5jYY77xsmJad+V5FckWtQ+hrNxjNh1bxTmS8ubmg7apd9mFkHoMCn
         BMAO2C/sB+4H+u+y+M0Y/F6yxG8Oo7s45vraA++mWCKAyGFkFOWZnb3VPAVOXlhkRFev
         uiCnl+yXIVjMSxUm7nBKneCCTn7sToRoeHeHdfBWfev5dpjCGQNN19aSSB2KYNbw4Gjk
         Nozgpdn2sEwarg5bxJmkBm8oPfKM86OopSw6imSm6vXrz7iRW6lLQ4SF5yyanvwEL9Jg
         qhOw==
X-Gm-Message-State: ANoB5plJX75v7Q2B9Br5urMK0N5D5hpEMCJqGXI4GnvWiOAFOE6uW7q1
        5NQeWaliosvqtxbIG46n0//mkg==
X-Google-Smtp-Source: AA0mqf6dIpOuc8iqXoYIEiwwyZ7/oy0nQalzS4PFLGTzXhVlJYD/WUrMuGIkB5WAcRmJ7n6Y/QsqMQ==
X-Received: by 2002:a92:c108:0:b0:300:ee15:9973 with SMTP id p8-20020a92c108000000b00300ee159973mr2036405ile.234.1668205362542;
        Fri, 11 Nov 2022 14:22:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w11-20020a056602034b00b006d276f4e01csm1250565iou.20.2022.11.11.14.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:22:42 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:22:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: don't create a ".build/.build/" for cocci, fix
 output
Message-ID: <Y27LMXTCF7o1Vv1i@nand.local>
References: <221109.86tu38p1x8.gmgdl@evledraar.gmail.com>
 <patch-1.1-5bdb8deb0c7-20221110T161232Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-5bdb8deb0c7-20221110T161232Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 05:14:18PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Fix a couple of issues in the recently merged 0f3c55d4c2b (Merge
> branch 'ab/coccicheck-incremental' into next, 2022-11-08):

Thanks for coming back for these. Will queue this on top of
ab/coccicheck-incremental and re-merge back into 'next'.


Thanks,
Taylor
