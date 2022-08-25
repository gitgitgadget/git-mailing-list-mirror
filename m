Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCAFECAAD1
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 22:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbiHYWRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiHYWRC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 18:17:02 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E0F8E4C9
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 15:17:01 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id n14so13253253qvq.10
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=s4Fj5/2fsGxY5jkwwjJG5gYneKEHOZyBoVgyPCR9SVQ=;
        b=Dh28sTsi2hsCM7FtIKVkjwPV/Vy0pU3j5ZrrJe0sKraNsHHk1GOs3eEOQP1TDZApET
         yd9d4hotmifShA+k0jUgimLeitidO82Z1rbhHqw2SE5E6+v1v3ERE7SPjMzUvShiuEO/
         6lK/ScJFOF93TBsG4Avdx+eu2s8uqSUesi3IIzSd13+JAeYlNrA6GIPGdKR5P93Wha/g
         6uRdwyxEvifbxoF1xeccww2nIP8Ux13vUtJrenaaEdfg0vluoIaRHyEPdEU/9O1j7g1Y
         rpWF1x8rhoXhpNQYWqN8kwgsRCQsyqIn1ndLz4753IdAluYc4sOrfL/9mgCXdeUDMXdJ
         ftYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=s4Fj5/2fsGxY5jkwwjJG5gYneKEHOZyBoVgyPCR9SVQ=;
        b=PBz4WV/vsh8fzy8bdascm4PjBDUaF+BEVZSQKa/DfCcR23/fOXwuJDTRuiFR78hSwq
         B9T4DS1CKZUgBoeoiD6QzUrgpyLLLaTzcD1cmrV/NyG3zgrWH5eeSy24uVQCdK0yEM1A
         NRs/gtvIBksDmDCVLN3Nrg07VbZ3ZcviOj72y+++gL7uCXMkQGXtRvNYvYXsp0aBXyOC
         /sYavtd1MjhKG7Nk6b6bKlUYmXrSw4AHtTCVDmHxA3PoJZ1V/04ETnBXpFZ13A1BYz1b
         L9VhD0VVVO65kujUWohOs/JTy3Y0+HCFyIoPl/WTCk+UTjaipEyJKCSIJOKaMChChVPE
         fbaw==
X-Gm-Message-State: ACgBeo3jDDZzU10Ddby161/O0gGPW6gQ3eFFizs5wcZf4KHyjeO/lBWe
        UZ4k9t1VVpyu32xvjcUowzCY4Q==
X-Google-Smtp-Source: AA6agR7wJeA7MEfL0HwuH6TQh/ysW3NEenHyDzY0yAwZAU727JKAPh/wdyuoFl17k4dplmBYk4/FqA==
X-Received: by 2002:a05:6214:c2b:b0:476:813a:b173 with SMTP id a11-20020a0562140c2b00b00476813ab173mr5775902qvd.31.1661465820192;
        Thu, 25 Aug 2022 15:17:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id de17-20020a05620a371100b006bc5cdc890bsm495200qkb.77.2022.08.25.15.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:16:59 -0700 (PDT)
Date:   Thu, 25 Aug 2022 18:16:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v6 0/6] [GSoC] bitmap: integrate a lookup table extension
 to the bitmap format
Message-ID: <Ywf01YqJKNsGfffx@nand.local>
References: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
 <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Sun, Aug 14, 2022 at 04:55:05PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> Changes since v5:
>
> As the failure in the test case is not due to this code, I think it makes no
> sense to delay the patch further.
>
>  * The performance test changes were not accurate as the second
>    test_bitmap_cases call using the repo built for the previous call. This
>    version fixes that.
>  * Taylor suggested some minor changes. Those are addressed in this version.

Apologies for my slow reaction time reviewing this series. Between
looking at that preferred pack bug you and Dscho spotted to catching up
after my vacation, it has taken me longer than I wanted to to take a
look at this.

I read through v6 carefully and am happy with the current state of
things. I think there are some small incremental clean-ups that we could
do on top, but they need not block this series, especially since the new
code is made opt-in behind a configuration knob.

This series all looks great to me, and the performance numbers that you
achieved at the end are a nice payoff for all of your hard work. Well
done!

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
