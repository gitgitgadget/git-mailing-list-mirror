Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD9BCCA47F
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351965AbiFHAX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451844AbiFGXNM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:13:12 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D4418B16C
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:58:38 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id p8so13551746qtx.9
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Vs3O0xOxRuGlgZpyevO9Vog7XjRz4bzW2oCQOIMtFnc=;
        b=GNFs28ZcEHqlFsCUaix675mxctZjuKMtCOliABwFta3S45zM5HVAnp0KhB9oY9LEOz
         sHC5zi3IvvlbBGRYX0TNwmOu/1XYH15xAuWFW+7gw9FGpY3OK4cnh0/B5fiw2g8lu6Ib
         j3Z36pCxGbK9OkWCHIhLCU340QV4NjMFLHH8lK3OKUhKuANiCHOR8+8cewcgxpNZOmHh
         Kn2fTh6Kt1eOsq3iN4CT8e0RGUu+oN74FmywVj3fE0hoBYlfS2JQrJTTWLbod9vR3Qvv
         cgemU56ceOw1svUXrGssHEz88jLNntqb7Pc0piBOhLQZIF4tdD4rR5wWdZjor9UEB/RG
         +Kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vs3O0xOxRuGlgZpyevO9Vog7XjRz4bzW2oCQOIMtFnc=;
        b=raiU02IcaCQPcX/Z4zR9XbaF4cXlLKx/5AEUdD9EF5J3/3Nm7YzI19MOqDFyj5GKtW
         WyFoGwCr31w3byKEtdh40PN3P1M3Lq1EXrnSLBYmvbIhMJs3i/Mbo8xN4IE4RdnSjSCb
         79QM6kH8dFCrcfSXwC7MEmFtrDmBtf7HbqneoGIDuUpIvzg6M/MqUfGYkGU72w8NulmP
         iUCHErfqAbm72ucRfxoOvg8UwRVVnKBNvt5Aak7409PuTIgj9Q/6EA2dZcSg86nsSg5b
         r6AYEUScyLXjisic5XvoMXTOR+tIrKVNt/w9bmaqeUuM4a33qShkVbCY6kUjcJGmBmaj
         NnBw==
X-Gm-Message-State: AOAM531MqfsHt4LWEkcymAmBNJO01R+vdO3EBECACegN7mikEfFkfOs2
        0vliEN0XGzPEWBBol7Ts98A/jA==
X-Google-Smtp-Source: ABdhPJwMrFtAAyy2rl9NPLeZXoe92nIqGhftkuv+v+cpm2RU+Iux+a0P/EaOZaIePlgp7fQzNWdaLw==
X-Received: by 2002:a05:622a:387:b0:304:e67e:815c with SMTP id j7-20020a05622a038700b00304e67e815cmr14724906qtx.337.1654635514409;
        Tue, 07 Jun 2022 13:58:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v10-20020a05620a440a00b0069fc13ce217sm2316887qkp.72.2022.06.07.13.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:58:34 -0700 (PDT)
Date:   Tue, 7 Jun 2022 16:58:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Vicent Marti <tanoku@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 0/3] bitmap-format.txt: fix some formatting issues and
 include checksum info
Message-ID: <Yp+7+QV4HDT3eY53@nand.local>
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
 <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
 <xmqqfskgwcou.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqfskgwcou.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 07, 2022 at 11:28:17AM -0700, Junio C Hamano wrote:
> Will take a look (and audiences are requested to do so, too).

I think this is on a good track. The rendered HTML still has much of its
content inside of <pre> elements, but that may be an acceptable
trade-off to maintain readability of the source material.

If there's a way to make the rendered page more appealing without
compromising on the readability of the source, I'd be in favor of that.
But I trust Abhradeep's judgement here, so if there isn't, I'd be happy
with the series (mostly) as-is.

I left a textual suggestion on the third patch, which I'd like to adopt
before picking this up (this will also give Abhradeep a chance to
investigate the formatting improvements on patch 2/3).

In the meantime, it's probably safe to drop Vicent Martí from the CC
list, since he is no longer working on Git (though I miss him very
much!).

Thanks,
Taylor
