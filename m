Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627E8C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 20:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiKHU2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 15:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKHU2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 15:28:42 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0C8627F6
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 12:28:36 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q21so9522200iod.4
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 12:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0RwubXFnIrO2jtCfBjecr2cYfQjF43Kr4X1Tavfaec=;
        b=kAMzBoCYHBCNtQDYczzWGgENgWBrbE/M1kWyXfqa+m9XBgaQ5QtE274Ccqd+L+TJ63
         QaX684TbDFmxI1AIuQTpLyf8RYX42BmiKAYUfu3D4mA63QlrDiIaDESLtVF7BDKdyEyU
         Qrymf6SgSXu2weKwAxPyn3GheVpn9QxhMQEc6a/xFeyHFLNP8Q8PtNQdmHksFLFD96qp
         dLazV2KPaun2sU5lSzYRki3P1DwRuCNfcPT/tPgejDP+WADDp1V5LRM6ztnmKbFQYJc6
         CPQpBnNkTacsHzxFrkxXxDVfbDsbSIo7DP/ytFDtx5flBDheRkxuf1BtIhBIxxO0sijr
         CGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0RwubXFnIrO2jtCfBjecr2cYfQjF43Kr4X1Tavfaec=;
        b=3js2IIexateuXw7J6BjP7T2O+kwVA7Txz1978g2VKM/airW73uA2CxZhhSJ+xRBktl
         z2KyhFTco8jf8bu1YS2GwKez5W7Jnpp0EJmetLTyqfUb8ZDxEf0oqfRactXTkS4zcQ2J
         jCWsskMWJqMqKKkDVo/vKC70YymJSZ9qUwr+WnFxqm6XwOgPHsFLuANdXVGMmS13pVA7
         zPRm739pE4MkPiHg/uCJWFAi4n23nGEETNmAL4OS2sIKaUhoWT39wGbbz1VIOFoC7mmL
         PPOi3a+UUAeRs7YNnbluR8jwgqop/Tcd3uXer608Grwmk/PeSoZQJKcXlTC6YqhNCMkg
         M/EQ==
X-Gm-Message-State: ACrzQf3gi3zunO0G7rFw/TmwPmN4jf9QLQ0o4b2l67KGUygVF3uqVdff
        jv+fHXr+ImUolQ8Dz0LvAckYgA==
X-Google-Smtp-Source: AMsMyM5L+6cU8djoeusG50H+qMWn1dwkfbyVzwoj6T8Vv1a3OGGu1dTW3ORMAmFr0+4h5wzG69yXPw==
X-Received: by 2002:a05:6638:3d0b:b0:372:104d:8049 with SMTP id cl11-20020a0566383d0b00b00372104d8049mr1024809jab.241.1667939316275;
        Tue, 08 Nov 2022 12:28:36 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b5-20020a05660214c500b006bccaa66ee4sm4742130iow.40.2022.11.08.12.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:28:35 -0800 (PST)
Date:   Tue, 8 Nov 2022 15:28:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/4] chainlint: improve annotated output
Message-ID: <Y2q78ofF8fsAX8XU@nand.local>
References: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 07:08:26PM +0000, Eric Sunshine via GitGitGadget wrote:
> This patch series further improves the output by instead making chainlint.pl
> annotate the original test definition rather than the parsed token stream,
> thus preserving indentation (and whitespace, in general), here-doc bodies,
> etc., which should make it easier for a test author to relate each problem
> back to the source.

Very nicely done. The changes all seemed reasonable to me (and, in fact,
the approach is pretty straightforward -- the diffstat is misleading
since many of changes are to chainlint's expected output).

So I'm happy with it, but let's hear from some other folks who are more
familiar with this area before we start merging it down.


Thanks,
Taylor
