Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BB3C433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 23:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFE622266
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 23:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="n0D6ibs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgJRXbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 19:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgJRXbr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 19:31:47 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6899C061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 16:31:47 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t12so8705408ilh.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=csIMnxHTWmSw6fQ+rNVti6TDHd+zWDRdjoei0AkzNY4=;
        b=n0D6ibs5FwGXw9RBSp7/we8OPpR8kpQiKviQ9P9z7gO69gliFsoLAZoeAvrSyw6ekL
         EI1ohE5qgjnmoINmBWCdtJBxy3xCFA4F1xv/L4TMTI3tenfWAu2OfO8nQffQLf81PevN
         u1+AlG/+O2CNHUMLBqH9+kMB65w71WWY0KzFNW4EU8OwCBK95UY48JFpHKLBeijCt3d0
         lASyC26f5MLq/S7MK6hh7irk3wO5e7TxLuXzn9tVEeCDQPoSc5c2Y6tmV8Ozni4bS2qO
         M5mCAVYGkIwlIuvgSC3WshYXcwR2+5ueL4ku5ZKvYnwRXS6YhM8cVUWqJH8Kt6SBej9b
         ljYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=csIMnxHTWmSw6fQ+rNVti6TDHd+zWDRdjoei0AkzNY4=;
        b=ribaiYsCPvrLrym4mWoTVAQzirLJybHCdBfHpapUxOEoAmACbN3S2mcVzaXFnQ5/XE
         gQAbs0o0i1exrSOf9jabl7t/cEGH8b6Xukn/ft4U7474m9ve4sp885XSCcz7gnX602uM
         3idO0E65j1YIfTRrDGgCUcmkTg3BCB3wCms+PQKHcC19h5p+SscPOdo9SDiUH3+q4YHu
         PAsevFZTMP0z7APHiaISGvwH5m+7smxRmDOAJRuS14SyPaQqVjgIEdFaSBduDSurNg0l
         B10JmekctL0RyB9ebQRnoAuhR4r4noAuA3asiYKqkrzre/BYFP5KRAxg7EXMmOKxbEQt
         pLIQ==
X-Gm-Message-State: AOAM533q4/ZzAbr156rTVFZMsFPFzlw+hwefDLj5Qodj4mPkNIBm7+Qm
        HBQpwTohetxJro/Bxcok5L+GNw==
X-Google-Smtp-Source: ABdhPJyRzu5N4WY7A3V7c3m+oWpo+bBPFzjI7BhNUN/gf90fXnTlym2IYVgUysxli7KxTEqCUtmssA==
X-Received: by 2002:a05:6e02:54d:: with SMTP id i13mr8874847ils.219.1603063905840;
        Sun, 18 Oct 2020 16:31:45 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:c096:f5e9:cd72:773e])
        by smtp.gmail.com with ESMTPSA id z9sm8574585iln.87.2020.10.18.16.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 16:31:45 -0700 (PDT)
Date:   Sun, 18 Oct 2020 19:31:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] Claryfing the meaning of the sign-off
Message-ID: <20201018233136.GA4204@nand.local>
References: <20201018194912.2716372-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201018194912.2716372-1-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, Oct 18, 2020 at 12:49:09PM -0700, Junio C Hamano wrote:
> So here is to tie the loose ends, based on inputs to the first
> round.

All of this looks very good to me, and I really appreciate 1/3, since it
made reviewing 2/3 much easier (the combination of seeing more-or-less
the same diff twice combined with the re-wrapping made it tricky to
read, at least for me).

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
