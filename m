Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6048C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 702E864E12
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhA2WMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 17:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhA2WMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 17:12:14 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB86C061573
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 14:11:34 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id a19so10346688qka.2
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 14:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hT3uGtHvWDe8JO61wYqEiI4pCsJdxjpC2xE9sbKz0Jw=;
        b=Ce9CuGWK9TtuPnWMwiDuSxqQSizHnG39buacFmVc0Mpc85m+RFmE5LQbLQnRkerpui
         WIKQw2GB/NCadMP5KDeReIUmXT8kTkpXLDwptz1yDdxpzJ4IB/0XUGAyUjlffjiwkrX9
         f6vojRTYzQyyX189+/JNOD3IiETUUV0NY5EHtUeSY2K7xCFPdTyuisi8i0wyfTDxLjZN
         iTDu0tU9NMEt5ruCfxuQ4e+V58miijP/tkKK2E20sUrAnBmLkiMrsYmpHDJ/ceOO4hGy
         DUFJKiksdfwGl9e+OyXEuI0raIJl44PZEhEaLpGT8xJ22JBhAXhgMi2X/cYfE2GGqT/3
         iuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hT3uGtHvWDe8JO61wYqEiI4pCsJdxjpC2xE9sbKz0Jw=;
        b=qMYC7Ho78vgJJwxATWhGwPDdmFNjQn08+IWCA5r7GwW7buXUa6AKMXCx3rZxoPTj/h
         i4mrWhvR0clsHd2ZBAtywAyIkHxg4LdD90AmLsTtnuel4EGd44JfzLTkpc3wg1T7qbsW
         uvHiW1XGzYjqGV8lYwBXc+GDGyAF2LV8O2HCphoYVKtT4NYl2+fZiN/SicZs1dInm8uO
         0cebwvKeRkJPxVqokNzgIHlStH1TARgaXSg4QW7SIC7NEMRJXttB8STigQ/uikjRuknJ
         rIuywDnJkm+fn8yPgMBluq4cnW/nvjYe0XJM+uy823osx02Wi45Yu+dM1dqdBtlItLld
         txqw==
X-Gm-Message-State: AOAM532y2MHg9vRFtAAWkJzJzxSigW9ETw/IdEg2LE3pitxV7wVanv92
        Qst4xogC4fydIsuHfxLVPtd5LQ==
X-Google-Smtp-Source: ABdhPJx/ksyqpoZAPcICWG02gt4BTZb4yXYLsLkPfyD/ouGHfcL/t8EKGKMjBJdNfMV+sfwluTd9Lw==
X-Received: by 2002:a37:ad4:: with SMTP id 203mr6166050qkk.125.1611958293979;
        Fri, 29 Jan 2021 14:11:33 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f05a:e493:9aaa:4c8c])
        by smtp.gmail.com with ESMTPSA id t8sm6799624qkt.125.2021.01.29.14.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:11:33 -0800 (PST)
Date:   Fri, 29 Jan 2021 17:11:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] p5303: avoid sed GNU-ism
Message-ID: <YBSIE7Om1SGR83LJ@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <b3b2574d4d9d10f226b52d81fe0e6bf1f761504e.1611098616.git.me@ttaylorr.com>
 <xmqqft2ktnpj.fsf@gitster.c.googlers.com>
 <YBRi4v/AeDD/Zc9X@coredump.intra.peff.net>
 <YBRqOI84MkU+HNzt@coredump.intra.peff.net>
 <CAPig+cTc3RGEu4anOmnYBBQxXgB0UL8Z_vJfnV=FoNTOFYEpTQ@mail.gmail.com>
 <YBRvy3s5gnsrIBEB@coredump.intra.peff.net>
 <CAPig+cS9Fp3N9XNux8=JZo-T3QWdr7O3+NbChhhs62hh6D_5tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cS9Fp3N9XNux8=JZo-T3QWdr7O3+NbChhhs62hh6D_5tQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 03:36:01PM -0500, Eric Sunshine wrote:
> On Fri, Jan 29, 2021 at 3:28 PM Jeff King <peff@peff.net> wrote:
> > On Fri, Jan 29, 2021 at 03:19:31PM -0500, Eric Sunshine wrote:
> > > It's not just exotic platforms on which this can be a problem. BSD
> > > lineage `sed`, such as stock `sed` on macOS, doesn't understand this
> > > notation.
> >
> > OK, then I'm doubly surprised nobody has noticed and complained about
> > this. :)
>
> Aside from there possibly being relatively few regular Git developers
> using macOS, it could also be because it's difficult to run the perf
> tests on macOS in the first place due to the GNU prerequisites. For
> instance, the perf tests have an unconditional dependency on GNU
> `time` which is not installed on macOS by default, and it's not always
> easy to figure out how to obtain it.

Yep, I agree completely. I was going to say that this would produce a
conflict (albeit, a trivial one) with the series that this came out of.

But I think that we're better off abandoning that series for now until I
send a different version, so I think we should just go ahead an apply
this.


Thanks,
Taylor
