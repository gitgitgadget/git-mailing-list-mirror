Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0493C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 06:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8321E2071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 06:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw0MmTFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgE0GOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 02:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0GOD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 02:14:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BEBC061A0F
        for <git@vger.kernel.org>; Tue, 26 May 2020 23:14:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so8766023plv.9
        for <git@vger.kernel.org>; Tue, 26 May 2020 23:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=emEgplKtlO4viku/l1JOFC8awFqn2Zv0857TJdl+br0=;
        b=mw0MmTFHoYor3kW1EEmQ127AD46jJYX25WhPJr7mMs3Mr6cZ5LhAf0Z03xel+6yw7N
         bvRDiINolTpaP6vIxBmqSAYQbBYXUEu//B+4j9rZMK/KHNcKt09kb46xVujfV1fhBSSI
         XJ9CAJVsFLuUeRspVvP/f8SpovFFVmmZu/R1J9Qzi96Ni9w3R9y48b958k03tg9cvOmt
         6GSP2FJRONl1kzt8cTfAoqLtn2JuKXICPZLupWK8+58Q4MTLbY8Xy8wdXzVPXQUWhiis
         6Ssh9Xv3uWX3Q4CvtiPmy2vvVi9hWu3YCfE8rGhRWyOEYFzZU46/rlMjdRkPBuvC8t0v
         RUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=emEgplKtlO4viku/l1JOFC8awFqn2Zv0857TJdl+br0=;
        b=AxZKvZMCxKkK+B/2Ix5ZNEsBLZM3TOISIGh8KBnSi7UbHhHsET9PakIzb19x7sZM/p
         Qf+x7CvDK0fb4X9Tm7bgUNQJpG08KFm6M+xEYVwtQp0hGMSN/agTK7Yml0VSBRgojHhP
         F3mLiuStol9v610cbcGwmQwLy301ONkxssft9VvvXFiHwsvz2JYBKg3dhyXktdPMbBFR
         BqRARqM3DEdHXQwsdHt6UJyPLbWLGLMsXd4WsD/MMQ8YssEPtaiV6Sn/y8f6Bwgfak1d
         OJF1AJr3aUS3tPW5im5X3ArOyzNQp4/QOgYwKPosPPU4YyTYqdQgWvOdTwa2tHgEFnuc
         z1aA==
X-Gm-Message-State: AOAM533CJpy3foi6O64xQL1amqVuXuNNeB0/3+7dg0QLP/rkrRXS5Miz
        q5uz4G9vsxA/i7Vsq/kPqS4=
X-Google-Smtp-Source: ABdhPJwrFnOAfLKxnh17yziFjubNhuukwfcTqcG1jA1G0x4fgKoq4rqmYdYh2R/gXiNOb6heyLqhxA==
X-Received: by 2002:a17:90a:7b8b:: with SMTP id z11mr3437633pjc.234.1590560042422;
        Tue, 26 May 2020 23:14:02 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id j26sm1126911pfr.215.2020.05.26.23.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 23:14:01 -0700 (PDT)
Date:   Tue, 26 May 2020 23:13:59 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Marco Trevisan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Marco Trevisan <mail@3v1n0.net>
Subject: Re: [PATCH] completion: use native ZSH array pattern matching
Message-ID: <20200527061359.GB40564@Carlos-MBP>
References: <pull.645.git.1590520398132.gitgitgadget@gmail.com>
 <20200526235834.GG1915090@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526235834.GG1915090@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 26, 2020 at 11:58:34PM +0000, brian m. carlson wrote:
> 
> This file is necessarily used by both bash and zsh.  Does bash
> (including the bash 3 used on macOS) happen to continue to work with
> this syntax?

if by that you meant t9902.[150-152] to succeed with macOS bash?:

$ bash --version
GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin17)
Copyright (C) 2007 Free Software Foundation, Inc.

then I think we can add (on top of master):

Tested-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>

Carlo
