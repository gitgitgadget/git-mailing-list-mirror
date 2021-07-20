Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31793C636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 16:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161DA6113B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 16:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhGTQNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhGTQNF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:13:05 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC09C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 09:53:36 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id a7so19721667iln.6
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 09:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rEQjyAQAklrbHYydv71astHWR6vn1dqXPykYV++7jyQ=;
        b=Zmao7fPwbhEBebMrwookzBnWnRX10GAIOLXZAxtKJ4DPnD01z5UMRljjCbna4PVixc
         BHkLaiian6GTcUM4pKiFyonYsHc9QIynCKFVPxgDsnMxC49CQCEknvjy0fbQ48ik3yiT
         RxktgTR6YDyWbrElgBAPl6tkPOff7+zeDgFXZuZEW+nJ04jvouDHn/gfRFuGo5uG+wg/
         l1hlL/Q7vHrnaH7dOZZZvalYQG+/GKwIrdVSK9KLS/hR6h3zj2XA+j1ucGcunCaKDldd
         BbXmeymC8AEhydDUKz6Tdr0C1x6lPCREaCyPSDhe3Z/yH+Ino2VEXZtiUSxTSRH7EU+5
         TF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rEQjyAQAklrbHYydv71astHWR6vn1dqXPykYV++7jyQ=;
        b=DGb0VIRHX2LcvWpNNxSXFSxliFB4eJlWfbiUFm8m89EcOlJpJyLt+LWe8utHmYpgaK
         Z02PNZ7I+tStxyQpBHiclhcr6OS9C6DDG/ISQ1mgz0Jn7bCqlRJlUYQzBsPKmC/Y3QJH
         QW0G3ynnoKnJ5p3JyyODZDBemQTcYCBogYJX1v8uIH4pySM0/vUAA7lovtSDo63wi9Pt
         PPU6Y8Fd3bOcnFJ0RqXYgpO2mUkypv18TAeyI+7e0WyXBq/HTgPWMfm7GIB2AxTkhu3O
         FdUMU7jnG1y3/vqasIt9bM8OnOKiQJ9OMxPnxgzWX7X8U9OI5c3IoRQglmFaDWKWq3xj
         bFlw==
X-Gm-Message-State: AOAM533WtRZGaJL4r1voHov+CnlM0dv2KSrQS2nlD6h2pjAOkC3lMCBz
        H/YjOxvUyNTv+E24X+DTdOAjuQ==
X-Google-Smtp-Source: ABdhPJx+thDUjBk6HvDp23+BKi24u1z8/mLFruqfFmuQA037apvaws4gFDwEAVTjpPmye6n59qNtnQ==
X-Received: by 2002:a92:d3d2:: with SMTP id c18mr11833048ilh.192.1626800015116;
        Tue, 20 Jul 2021 09:53:35 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:9f71:89c7:e095:b8eb])
        by smtp.gmail.com with ESMTPSA id t24sm12941827ioh.24.2021.07.20.09.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 09:53:34 -0700 (PDT)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Tue, 20 Jul 2021 12:53:33 -0400
To:     Sun Chao <16657101987@163.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin Fick <mfick@codeaurora.org>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] packfile: freshen the mtime of packfile by
 configuration
Message-ID: <YPb9rXLiLcl04k6d@nand.local>
References: <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <pull.1043.v3.git.git.1626724399377.gitgitgadget@gmail.com>
 <YPXluqywHs3u4Qr+@nand.local>
 <5D8CDAF1-256C-4CC3-920C-2063CFACE9BD@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5D8CDAF1-256C-4CC3-920C-2063CFACE9BD@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 11:00:18PM +0800, Sun Chao wrote:
> Meanwhile I find the description of the cached file system for NFS Client:
>    https://www.ibm.com/docs/en/aix/7.2?topic=performance-cache-file-system
> It is mentioned that:
>
>   3. To ensure that the cached directories and files are kept up to date,
>      CacheFS periodically checks the consistency of files stored in the cache.
>      It does this by comparing the current modification time to the previous
>      modification time.
>   4. If the modification times are different, all data and attributes
>      for the directory or file are purged from the cache, and new data and
>      attributes are retrieved from the back file system.
>
> It looks like reasonable, but perhaps I should check it from my test reports ;)

That seems reasonable, assuming that you have CacheFS mounted and that's
what you're interacting with (instead of talking to NFS directly).

It seems reasonable that CacheFS would also have some way to tune how
often the "purge cached blocks because of stale mtimes" would kick in,
and what the grace period for determining if an mtime is "stale" is. So
hopefully those values are (a) configurable and (b) you can find values
that result in acceptable performance.

Thanks,
Taylor
