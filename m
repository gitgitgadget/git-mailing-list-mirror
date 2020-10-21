Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239A1C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC2A223C7
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ZG+KT4e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506207AbgJUVbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 17:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506189AbgJUVbl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 17:31:41 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D138C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 14:31:41 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z33so3384009qth.8
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 14:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nEBg7LTtzfU9Dw+TepVFMuLvUnd9JKKJjrHC+fmAGhY=;
        b=ZG+KT4e8JB3skCfju2RF0PVHIm5LOGsw6+jOo89DGTeSC4muZWLrpH8T3IixGgwpm0
         qoVZZe21SZo4Hk8I+mv8bAY4p3+Yqli6v2MWiKwCT3pk8w8gsA0Nj1t+B4/x49e3gdy2
         YjK3ERk64zDb3xM5gRQjktVsV7x47A7DWToTz1oCOYcoV5hnuzEN8XsUteL8wTUvPR+v
         8+OSN5QBV6IDXJ2zw6EOXK1DkAgWsGDsG3Cq+Khbtc2k77WxVFZVl3rga8mf6K71BAlq
         TxouPKZpAUafa4r9B5Yt50J7T+sNH9hvMCEPb847fFwh+CYVxzE0yDp4tNoTARKujzT5
         f0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nEBg7LTtzfU9Dw+TepVFMuLvUnd9JKKJjrHC+fmAGhY=;
        b=eaSc9dQL7ossnTa6xL5LfiDpiMHhRp32UedkmpsTDBMBhFbqFuQt+MT3HuZJVDNSfU
         R1CRaS9vE3NeBWhE85Sbgkog2+AV+gnLJ4M/hIt0VzvYgtmq845zRM/5C0RNeE/KBZVi
         C1a3+LmSxgv5yg9PTcrE3yS7HfwwKix4xdzjHR6EjZymcts1y1mmEPP9v6EWeHjOtm4N
         /Lr6jhNeLDLO/jQclCk/HNzPEpT/ffzR6JZuq7ARMbx3HicOoc/SrbzeoyH/VqhPlor5
         WhTTD3rGsfuO65XBkQr+5wUj1DGxjhnrR5vuwR9zTwxN6lOYmBq+Z553XxMIQV66OOZa
         UqGw==
X-Gm-Message-State: AOAM532JaEGtKmzi93bB3sBLIYtGzt1cg82UDQ6eLJCW47s0hVUKwOJY
        YM+xnuXBc05IOEjdkzGKroSzVA==
X-Google-Smtp-Source: ABdhPJzo8W0dPHscU8YvJP0qoUK9ju9RdE2/2TatpptIpq+jsBG0Cu0gFKR6aYU/vHLT7V9Ey0+Dcg==
X-Received: by 2002:ac8:5709:: with SMTP id 9mr5043387qtw.77.1603315900322;
        Wed, 21 Oct 2020 14:31:40 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:fdf3:f65:ad7d:8324])
        by smtp.gmail.com with ESMTPSA id 129sm2000358qkf.62.2020.10.21.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 14:31:39 -0700 (PDT)
Date:   Wed, 21 Oct 2020 17:31:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Alex Vandiver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH 1/2] fsmonitor: stop inline'ing mark_fsmonitor_valid /
 _invalid
Message-ID: <20201021213136.GA1877888@nand.local>
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
 <049989652cefb90304e711dbfe354b55a5a71f41.1603303474.git.gitgitgadget@gmail.com>
 <20201021205537.GB1270359@nand.local>
 <xmqqo8kv5l2x.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8kv5l2x.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 02:24:22PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > Any reason that these need to be externed explicitly? Note that these
> > functions are already externed by default since you haven't said
> > otherwise (and for no other reason than this'd be the only explicitly
> > externed function in fsmonitor.h).
>
> Possibly due to the recent discussion?
>
> https://lore.kernel.org/git/xmqqtuv3ryhr.fsf_-_@gitster.c.googlers.com/

Ah, thanks. I remember the thread, but I wasn't sure where the
discussion ended up. After re-reading it, it sounds like new function
declarations in header files should be prefixed with 'extern' (making
this patch correct as it already is).

Tangential to this discussion: are you still expecting a tree-wide
change to start use extern everywhere?

Thanks,
Taylor
