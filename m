Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFABC433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 04:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8620621655
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 04:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="GNF2WmXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIOEb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 00:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOEb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 00:31:58 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA77C06174A
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 21:31:57 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t20so2227667qtr.8
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 21:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ABeXY6Y6sbEgqeoe2ObAEItHh3Q1CYvFqd4+0x6ZBNQ=;
        b=GNF2WmXeHExIy2KTZlevc/QnHwLHNCqOpjecNLnVCWRLKAmWiEe3aCNo3bs2E8LD8I
         Q3sLmvJkfBKj5mciLFl/uK3AvgXcom71la/8zfHexd4TjnVv1O7KPeRdfzaZI69VdeNC
         hXHm3/q+3pY/bEbFO3DRCwP4XqUUu7Pj7zWGoNMnUugeEXpdxd/iZKV2AWzJXQkw1Dv2
         bVZxbQAVqnhHwlxPY2oT0MgVUENW826ryDMesEf39wkKq9TL/+BBPmLegSUagGyGFIXe
         yn8qG/1zsVdaY8ikAjLkOadrfwf+eWh+XBdbnyKhB396mZBrch51tHkOP4Xf39ZG4ZSx
         gTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ABeXY6Y6sbEgqeoe2ObAEItHh3Q1CYvFqd4+0x6ZBNQ=;
        b=dVR33rM/Xgwyn6U4d1uHUIAw1aDrTg96iXecj4f91/8sdmmOff4F+bOXyCPXDEYOxP
         X1NoVpxijkaVQuRH2ohTsFY45n3solre/M4uZHQw7ywie1WCe9dnI+0iANLB5tIOCDtZ
         JG3sORCffob7/aewGFMRi5S7ViltI9EtrfVMg3WwLDxiFzXOa9tIM9Hv0HgOK8Eq+nxi
         31okvorbIt2ymPsm/2nXWSP8E4UrdpSpXJJf2JVb/IyFhHNhIVr4Bu3NBoFiXBtDvbLw
         yB/QXHo6oIZSdg0CvPvB65o7nojvVY2quVmn7g+zaDpcwaQGjSNqUerILMZJ/V72Z1Dv
         Xkfw==
X-Gm-Message-State: AOAM531L0BTtjo1VWG9El1gXzhYakPyWoePFPyMv6ni+a47ruTQwM7C+
        /09+e5X49KiwJgh28dOyNGC9WQ==
X-Google-Smtp-Source: ABdhPJztxpYhmrMLS3eARskONTVpWmKED86cUkYkLCDW9vZb3uFqFVPqdPqIZcnfuRaltK3hAJgfhA==
X-Received: by 2002:ac8:7108:: with SMTP id z8mr17022153qto.55.1600144316895;
        Mon, 14 Sep 2020 21:31:56 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:bc05:1f7d:98e:e354])
        by smtp.gmail.com with ESMTPSA id i5sm16096082qko.86.2020.09.14.21.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 21:31:56 -0700 (PDT)
Date:   Tue, 15 Sep 2020 00:31:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, dstolee@microsoft.com, szeder.dev@gmail.com,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/12] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200915043154.GA19585@nand.local>
References: <cover.1599664389.git.me@ttaylorr.com>
 <4ff11cec37d17d788a3ee076b7c3de1c873a5fbd.1599664389.git.me@ttaylorr.com>
 <20200911175216.GA2693949@coredump.intra.peff.net>
 <20200911185934.GA2871@xor.lan>
 <20200911192555.GA3612@nand.local>
 <20200914201258.GA12431@nand.local>
 <134d64a0-abb6-bdc9-2c05-7aded01a906a@gmail.com>
 <20200914203659.GA12855@nand.local>
 <aa53f17a-6e48-f4e7-821c-1db35cf48652@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa53f17a-6e48-f4e7-821c-1db35cf48652@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 14, 2020 at 08:59:28PM -0400, Derrick Stolee wrote:
> This is fine. Adding an option along with the config version of it
> is easy enough. Just a thought for future series.
>
> I'm fine with the series as-is. My nits are just that.

Thanks for your review, and for all of your thoughts and help on this
series in general. I'm sorry if I seemed dismissive; I just wanted to
avoid holding up some important fixes besides the '--max-new-filters'
feature.

I'm not quite sure how to handle series like these. On the one hand, I'd
like to send a couple of small series to fix the important bugs quickly.
On the other hand, the small series can generate a lot of noise and
burden reviewers and the maintainer when the dependencies between those
series aren't straightforward.

So, I dunno. That's at least shedding a little bit of light on how this
series came to be / got so large, which is part of the reason that it
took so long.

Anyway, thank you again. I'm looking forward to seeing this merged
hopefully soon.

> Thanks,
> -Stolee

Thanks,
Taylor
