Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AF1C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 15:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0042072E
	for <git@archiver.kernel.org>; Sat,  2 May 2020 15:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REHMcnFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgEBPCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 11:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgEBPCD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 11:02:03 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34691C061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 08:02:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l25so3731170pgc.5
        for <git@vger.kernel.org>; Sat, 02 May 2020 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pF7Nxwvb8DbSBfQCsLiYiUAkqii2J78SrxU0RJ7cvvg=;
        b=REHMcnFm7oXwcB3r2BEIvzms0GHGP3ez3BFd/RkrL+pM55KHm3AOtUa1elDZJhKFiM
         jOJ8ywsu2+kUM5kFUGRoWwVD6yZj3/G1fqxLijmDqT6JQd7Q4O22IXUCIoY01bZwvi/N
         jQptooNyEY+AtWt5zJXw0f7IKJjyc5yulfDD7Hn9Li/0xp7ais6RyP/9+zEnXSNncTq4
         8IQl2M7RsYJiV8kSU5d36tEfCqzmwcfCwllShrKeKRujkP1xpCSUPzTwNNgmkavasIQ3
         vMC37fLC4JbvDXD3dAguFkIt1l7c9L+3+pp5zg6veuJu0jQb967EFqqOpVaxjl4smhKw
         /Jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pF7Nxwvb8DbSBfQCsLiYiUAkqii2J78SrxU0RJ7cvvg=;
        b=BML5Lpxn+IuwLbcz1zMCmFg+OLm2oJdRcqL7q4qnV0jvzmsGwqP7hfMaFb+fv9u6So
         5kzbM4Jv/oR7wpkR9l8CrrUQI35Vp1UbFdD/mKRR20rdJISrqmYK73Np4e20tiiPBryQ
         DQGaU3vVZMNK6PH0tB7ux9HPUbO42AJKvK4arYeHl1gWKV6mwCI3BwR65fmqx0O26I0W
         Kbd/La2L1FoC8Xwk3DbRWH+Qc5ifplcojn/kwsdc5dRm15utyt8+dSTCHmT3VYA1w7Gg
         WaBWE4dE4zyqbeSN+klBPtRz/XbtZKXx573SkcV0XDRmehY+Zt+sAoTSvn83PgXuv7Wt
         V5Uw==
X-Gm-Message-State: AGi0PuYBPYencO28Qid9+tOAbffWxMI+S6W8A8i3hysFVfZkctiolYIS
        3l8FYRh8GaM0UFgyPh+1A2M=
X-Google-Smtp-Source: APiQypKP+6zIKNyBcnhPlHR26gStdwVWX4XtcT6MnhA6+0d/xP7APEMJnjAOLY3MUbglwssC7EYl9A==
X-Received: by 2002:a65:58c4:: with SMTP id e4mr9402675pgu.61.1588431722726;
        Sat, 02 May 2020 08:02:02 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id f37sm858508pgf.0.2020.05.02.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 08:02:01 -0700 (PDT)
Date:   Sat, 2 May 2020 22:02:00 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
Message-ID: <20200502150200.GA26423@danh.dev>
References: <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net>
 <20200427201228.GD1728884@coredump.intra.peff.net>
 <20200428135222.GB31366@danh.dev>
 <20200428210750.GE4000@coredump.intra.peff.net>
 <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>
 <20200502132144.GB3143@danh.dev>
 <CAKiG+9WNkM-9hfp83xz_xv0s3LQaiyG0voMFKoxvMwFKt4YoZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKiG+9WNkM-9hfp83xz_xv0s3LQaiyG0voMFKoxvMwFKt4YoZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-02 20:20:50+0530, Sibi Siddharthan <sibisiddharthan.github@gmail.com> wrote:
> On Sat, May 2, 2020 at 6:51 PM Danh Doan <congdanhqx@gmail.com> wrote:
> The thing with options in cmake is the values it takes are boolean only.
> To do what you want I think you have to do something along the lines of this.
> if(NOT DEFINED SHELL_PATH)
> set(SHELL_PATH  <default value> CACHE STRING "path to POSIX compliance shell")
> endif()
> 
> Then if you want to change this value, edit this value in CMakeCache.txt.

Ah, this is what I mean, I think it's better to use this (without
if_not_define)

	set(SHELL_PATH  "/bin/sh" CACHE PATH "path to POSIX compliance shell")

Then, we can use this:

	cmake -DSHELL_PATH=/path/to/good/sh ...

-- 
Danh
