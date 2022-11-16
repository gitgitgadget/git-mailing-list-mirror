Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE106C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 22:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiKPWdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiKPWdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 17:33:16 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EADA59FE0
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 14:33:15 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 11so121721iou.0
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 14:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVMuTZw4Eal5WRTW8CDPlFhODH22C7c61KC/4Kstoac=;
        b=Dte2Gkic35DnOK+aXY/6npwqw0ouf2jYSpbNJuu2XTq6HgI6NVwpOEn2QgKRpLBMy4
         e+kEoPeT/VJwWFkPe6jJELvbImHruc3RA1LgbJvMah9/HYvkTu4/A6nYy/vc6uBLqfIF
         WA0r6TUIRh48HyqTPHvqwfMxYlBxhJSFea+O9d+3cGywjl7n3zrNINURFMp+pqohRlIl
         GrLsNe+nKiVCNdN+34EcKpSBqpycWCgYdNsW0Ts4+/1MXWXy3PNx9vHHws+Jy8lwzxOP
         l2Rhl5VJnvzhKzOo5my6/LjhOv929nDAXGioracr3DhDaZlPxWtEMjmiCfpxBUDqPp31
         NvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVMuTZw4Eal5WRTW8CDPlFhODH22C7c61KC/4Kstoac=;
        b=kzq1FFtGxkiB9laSf562ga3EMdkwjontntzwlRHTTcMO49WdV7D2PESTe6uKM6NYM8
         zmhjRtkuZbdymeBrLhJ5inqOg7FB37A6sJ5PzCsGKhDvigYAPtPFFuVEOY/wGBu0s8ay
         56MfsRiFKZ6UEJu1vjxHQ9F6hZfpXg7+0R6sRMe0X9Q30rQ8BVi9OoQOi1N2rfxluRX6
         VhcCG/6RWbXUqrsY6K+lvTOOd5znwAJy1/ccuUpr+mUpBfadFjteJA01TXm4qdfBGJHu
         h+7zNVnp8kT+woQh6dxHW+jrbHziQcd+IffYpad5T4joem7fRqU4omF2O2uNc9h5lhjf
         dufw==
X-Gm-Message-State: ANoB5pnnq2VvkSQtmyQe7yHTkNMlZfL75VlyxMvAdMHu1hH4JFavuAjM
        wOaZZiMucF9ICZvIrDcfnviX5A==
X-Google-Smtp-Source: AA0mqf5QIkw1C5uUlF3Eo9HGV0ysE1ZXxfTuDtAWsQSPHcDpi85BChiZ8a1Ac71EL1UdpQNSZK3dxQ==
X-Received: by 2002:a02:11c4:0:b0:372:8ed5:aee0 with SMTP id 187-20020a0211c4000000b003728ed5aee0mr11162022jaf.311.1668637994753;
        Wed, 16 Nov 2022 14:33:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b6-20020a923406000000b00300e6efca96sm6533760ila.55.2022.11.16.14.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:33:13 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:33:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 0/7] receive-pack: only use visible refs for
 connectivity check
Message-ID: <Y3VlKPFCLkFj188G@nand.local>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668149149.git.ps@pks.im>
 <Y27KL0Yg7nzdQ+HC@nand.local>
 <Y3PLwW7krP0eJS6+@coredump.intra.peff.net>
 <Y3VUkKoKd8j7IW6T@nand.local>
 <Y3VeWvj6bTw1C3jP@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3VeWvj6bTw1C3jP@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2022 at 05:04:10PM -0500, Jeff King wrote:
> > I haven't looked too deeply at what is going on here, but let's make
> > sure to resolve this before graduating the topic down (which I would
> > otherwise like to do in the next push-out, probably tomorrow or the next
> > day).
>
> The issue is that some of the tests assume that hiding "refs/" should
> produce no output from "--exclude-hidden=receive --all". But it will
> also show HEAD, even if it points to a hidden ref (which I think is OK,
> and matches what receive-pack would do).
>
> But because the setup uses "main" as one of the sample refs, HEAD may or
> may not be valid, depending on what it points to (without setting
> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME it points to master, which is
> unborn).
>
> So the fix is just:
>
> [...]

Makes perfect sense, and thanks for looking into it.

Patrick: it sounds like there was one typo in the earlier round which
you may want to pick up also, assuming you reroll this.

Thanks,
Taylor
