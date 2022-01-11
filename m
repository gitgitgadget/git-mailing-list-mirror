Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66250C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 20:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbiAKUSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242704AbiAKUSV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 15:18:21 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E84C06118C
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:18:18 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id v6so474453iom.6
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7HrM+7xtByrCLdWQp//yR70jzkPQyUjBG++s7FTp3WM=;
        b=vliWEX8SeSK2r7c6Q9RON5iRch2MjNWXf4D8ZLI7PkykM4W9RFV5Vb1SA9b8dYO1ta
         13dl/PSzokEbWMDaosMW29o4rtglmqG3iVOlP+HM03pWF/Lf/OGSkkjc9XXdLU22SGpO
         10snr+/kf1vAAaHRRgFQMpZiJZ6+1DF2DXaJgoTLNHcLhlEHdLsb2TyABNmzcbq8VsF7
         wwyj6ooHMZhScP5FyRCAciE8PD63akZY1Z84pW8KbownBIGBrdIgnXcJvLSf2XfqlRNM
         fYSaESvtzumBHvE6HMkus1gxU1cfphNXkEnoX10+WBZZoQpWzCIVZ9Z48j8Mt3/dG1yK
         kEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7HrM+7xtByrCLdWQp//yR70jzkPQyUjBG++s7FTp3WM=;
        b=shh5acuqo/VbZZG9K9sSBup8btmAS8JwvOGH2cUN38S2zYV1u9cJ/FUoVfbLusVW/L
         iCDL+BAGsREBRk5wBLjVPs5pRXUiho9562JKFvtQoqYnYthTIZP3e/3K8UuXZvgnvOBo
         v4NTmb/4OYV1hX8TgAxyAHq+npYPp+GbKvsSb6n5jydJMNhfSc/6kj6K34PTOfZZiSHJ
         6IIq1NR51znLqp+dIVTMzsbtPJyawGVNMfzTrfi2wjyYZKwXW5pDszWfJDD8luuyf2ET
         l8aP1vAvXFBvtY43YJdZowdFE6RI2PL7K/azjDrFshTDigun+chbi/AKoDU2lMGCaBiL
         JNzg==
X-Gm-Message-State: AOAM532eHgU1WXexEe65V8ekp8+7CG9RGev01CtFH5LLpKxaqaAuJVJq
        0eMrRGIejoTw/502Xz1G4HhSouaZEP37GQ==
X-Google-Smtp-Source: ABdhPJz98WmxbOl4Tsof/epIKq002tFChqCz6HLrUxaiXRsHV60s+82heVb87EclSbSaxcQrWTrcMQ==
X-Received: by 2002:a05:6602:29d0:: with SMTP id z16mr3092772ioq.122.1641932298190;
        Tue, 11 Jan 2022 12:18:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y15sm6880075iow.44.2022.01.11.12.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:18:17 -0800 (PST)
Date:   Tue, 11 Jan 2022 15:18:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] reftable tests: avoid "int" overflow, use "uint64_t"
Message-ID: <Yd3mCVLyxkVTNcS9@nand.local>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-3.3-93112305523-20220111T163908Z-avarab@gmail.com>
 <Yd3aZ5Q9Ph0H+Ijn@nand.local>
 <CAFQ2z_M0Fjjx8tAd_cXqk9K9q43hwienEy=UsLJi2aW8G3sEwA@mail.gmail.com>
 <Yd3dao5Qh5yl/cBs@nand.local>
 <45baffd7-c9f3-cc52-47b4-ea0fee0182a8@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45baffd7-c9f3-cc52-47b4-ea0fee0182a8@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 09:08:46PM +0100, Johannes Sixt wrote:
> Am 11.01.22 um 20:41 schrieb Taylor Blau:
> > On Tue, Jan 11, 2022 at 08:31:47PM +0100, Han-Wen Nienhuys wrote:
> >> On Tue, Jan 11, 2022 at 8:28 PM Taylor Blau <me@ttaylorr.com> wrote:
> >>> In any case, you're only setting the lower half of `min` high. Maybe:
> >>>
> >>>     uint64_t min = ~0ul;
> >>
> >> yeah, that works.
> >
> > I'm pretty sure this is OK on 32-bit systems, too, but confirmation from
> > somebody more confident than I in this area would be welcome :).
>
> It does not work on Windows: unsigned long is 32 bits wide. You have to
> make it
>
>    uint64_t min = ~(uint64_t)0;

Perfect; this is exactly what I was looking for. Thanks!

Taylor
