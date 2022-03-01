Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0068C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 13:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiCANw6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 08:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiCANw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 08:52:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3266542497
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 05:52:16 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s24so22085681edr.5
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 05:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6q0d4bg4FwONUEW+iESHXgHEow1mkBAMaFEry1M2vc=;
        b=PlG+2191VUXDDvT211uA6XyFOuGNsQAww3c823Nr7trqGmykFhpuB29CT7hDmu/ufF
         Q6hIyZSjujhhgZRElu/XA8ONUVmg3tx/eqqFXoGPSPqPirg8jx0S0Wgd5UM9OTzvUX5U
         LLiGJqMNiT0sAvoxcZtHT5Y76f9fJ+Ck9GUPNR7NmTtB554Mtc/A40slaprN2JDaEi69
         u4FEaCXVZuSLGo5Wdn06x+DJpiLd+PHCQhHyFFg/OkcdMLgFDaCVfo4hqKeFVVsV1fF/
         iNpeBAAYy1gHONFq59hUYC+SFRGC7ctSFN41L8PIVeu2cyrEXdJBI2SPNg1GNTHoNK92
         l1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6q0d4bg4FwONUEW+iESHXgHEow1mkBAMaFEry1M2vc=;
        b=YvD6atAv0Gf44+i1zM9JD2xDKtqLZm7Gx4HjFOLzB8YTauL/C0pPIlAz5c3lFWXjmT
         Dt0HfrtkJexnHnsZddhENrpqbPQY8Uyg0P9JBJZ1nFwaSb44gAjyHt5o3F0Ijnw5YixL
         W9r2vKg5NXIuRYXJABv0/yGli9CmdVq6bW5rwfoQQ5Hub3r35y39Q27te8JOFyJTwJh7
         cXYzi+r+Zc/pDcM2ufMrQd6qjzVOpmCOCr/qXM3M+bfPyeDtQ49teaDiiwhDxt1cdyR2
         bZEBXEKvl9pOcA4AVtUt1keGiK6tzvAvSduXwTDvPQ1g8k8dvhLabvAxgX9FuQxT/TTA
         +HhQ==
X-Gm-Message-State: AOAM532/sYOtefe5IM2Ndml7mHO2g2f3JzYoYTrHbazFCg+4n6tl440B
        UEiTOBTUIeOyzwS5De1uW8yvHnfvcZ621GGvhO4Bz0Y9
X-Google-Smtp-Source: ABdhPJxLM0+qJEC/XBjv9zkbkJcHU+SCktM9amcye+eH7PdCMiNE/Ttd/gl6uyvj3V+5x6SjB/wsN68muY5ShP+lyx8=
X-Received: by 2002:a05:6402:3549:b0:412:b31c:5509 with SMTP id
 f9-20020a056402354900b00412b31c5509mr24818862edd.224.1646142734649; Tue, 01
 Mar 2022 05:52:14 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <YfGpjm8mCkWIPM6V@nand.local> <742c7455-8f74-ac03-350a-7c3851f2b792@gmail.com>
 <CAP8UFD1bEjg20Twn0pjVqxmgCU7Nhzkg16O2t6gacSsqCYfXng@mail.gmail.com> <CA+ARAtrwt-Ov=b13s2g8AGuATS8fNfk_ohNQPscSjAs3n0y=0w@mail.gmail.com>
In-Reply-To: <CA+ARAtrwt-Ov=b13s2g8AGuATS8fNfk_ohNQPscSjAs3n0y=0w@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 1 Mar 2022 14:51:56 +0100
Message-ID: <CAP8UFD1WMn=-6Ais10xpJR70BR28UzEtbTeGSx3uNfkNt2kJ3Q@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 7:02 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

> On Mon, Feb 28, 2022 at 4:33 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Sat, Feb 26, 2022 at 9:30 PM Kaartic Sivaraam
> > <kaartic.sivaraam@gmail.com> wrote:
> >
> > > Thanks for adding the ideas to the SoC-2022-Ideas[1] list! I noticed that
> > > you're the only one mentioned as mentor for the idea there. It's usually
> > > good to have at least 2 mentors per project. Is anyone else interested
> > > in co-mentoring with Taylor for the idea?
> >
> > If no one else wants to co-mentor with Taylor, I am happy with it.
>
> If it's fine, I would be willing to co-mentor with Taylor. In case
> there are other
> potential mentors who are willing to volunteer, do chime in :-)

Great! As I already co-mentor another project, I will let you
co-mentor this one with Taylor.

Thanks!
