Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE451C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 20:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiKHUJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 15:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKHUJh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 15:09:37 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3221B627D2
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 12:09:37 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z3so12373870iof.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 12:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hbRhCZmb+wP1DTqw1GV18jAyNfvMyOCo9QOBzS1KsPM=;
        b=dCPP6NrrT5EDf5lJSEZgSciEuCxNu/T0QEQ7c8lKWHSwjJUSlhhZPm/m/3BoLMLA4S
         yn4YGKzCU4MQEjShXRzEBX6OW2MWc29iPb/UAmny2CUlHLFqU3ubOz5sS2lkP0IqJKQK
         S1PyZS9dGltmrTKNCwydCqUi6wnvF5W7ExosJz11YJcoxXLE+blkw3jM5F5CEZW3ZEMp
         pLFsYYcYmTw85EvMacQgu0cZ5OYl75S5KlOmL2/AguPCOfxgSCWK7liiGJHzq7TMQn/g
         r5Y8yQJwApa/VdXaU1NuHMFxVFKOwyrbtiwCqRiGSCr+wJn8GkfGWYiPGAke525hMouz
         xHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbRhCZmb+wP1DTqw1GV18jAyNfvMyOCo9QOBzS1KsPM=;
        b=ru1FI98P7y1yuaAJi66ciwSnJF2JmzwTyBJzr/TqC10rSYSDdP29Zpk5j70PIBRRuS
         +pGoN7k9jOSX1moDDCozuxuhnKBOlqGLlc/+VD7SV54d562sDPiPsm8rXiV0Sa9/R724
         ZWmsJon63dx9EWfInecPnQ19FujCiDGopxmmJ1OCUmD8C4yJiMQao49ncR+7i4ushh0k
         hfHK0emhxxYymviOrvDEeL88Yf2+/AvDsK7OSReWi48F4/p+SN4Lvgv+w2VPKJL79hMD
         L/Yy8mjscJ+/dixv9m/QgrM09BbdR0/Gub+OpZEtq28f9NCu99c754gYUXFBJvF906eD
         q+eg==
X-Gm-Message-State: ACrzQf2fwTAkg6vTFeSNH43GHCsEIY9gjsrfxJoskZCgzNcLuiy3RvLW
        d5mdV6UhynSRRLsiGhBDlVlc7g==
X-Google-Smtp-Source: AMsMyM6TWF43n0L2fapBALcqPvW27SLYtPICRTyPIT6TOXgtTDvGHjsF1mKeHjaZpvk8FWaJHysQhA==
X-Received: by 2002:a02:9715:0:b0:375:13ba:927 with SMTP id x21-20020a029715000000b0037513ba0927mr32898912jai.127.1667938176588;
        Tue, 08 Nov 2022 12:09:36 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ca9-20020a0566381c0900b003711ce0dc15sm4079668jab.68.2022.11.08.12.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:09:36 -0800 (PST)
Date:   Tue, 8 Nov 2022 15:09:35 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] ci: avoid unnecessary builds
Message-ID: <Y2q3f5noQSXmK0o8@nand.local>
References: <cover.1667931937.git.me@ttaylorr.com>
 <ff172f1de982f6f79b598e4ac6d5b2964ca4a098.1667931937.git.me@ttaylorr.com>
 <221108.86r0ydqmts.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221108.86r0ydqmts.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 07:52:07PM +0100, Ævar Arnfjörð Bjarmason wrote:
> I.e. the "cancel-in-progress" seems to work perfectly. I pushed a branch
> with this, it started CI, then I made a trivial update, re-pushed, and
> the initial branch's CI run was stopped, one job at a time (not all at
> the same time, but almost).

Thanks to Johannes for all of that ;-).

> Now, obviously it's a bit more of a verbose solution v.s. Johannes's
> original in [1], but on the other hand our main.yml is full of that sort
> of copy/pasting already.
>
> Aside from the change under discussion I don't find that to be a big
> deal. It's a general "problem", and we could always generate the file
> with a script if we really cared, but I think for the forseeable future
> the copy/pasting is fine.

To be fair, I think that the solution I came up with is pretty gross.
But after spending a few hours with the Actions docs, I think that it's
the least-gross solution that meets the needs of our respective
workflows.

So I'm OK with it.

Thanks,
Taylor
