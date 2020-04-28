Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29D9C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 13:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC95206B9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 13:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzJQAmkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgD1Nwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgD1Nwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 09:52:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F04C03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 06:52:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f15so193980plr.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 06:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S27L2Nf9xjsQpIHyXUYoqLsbaYJMetc5OVa6e0zSD18=;
        b=fzJQAmkCytI2xlM90SkenuF7SVFzG+EaWHtn8VNXMcnlwxbnJhfqg4iJnMFTPottna
         UgnqttDRaI82a//9a3yERsuJpQ2OFag/0Z9JOmFZhtro7ilQ2/EciO1//dzGLCWRTS11
         vrP/sinE45sMxGJA/0peWURLljydxrtYOPTiRqnIrjgUsL4FL2WmbvQokm04V0v2UcmL
         j93ysZAR4C92OS+5iRa7bPJ9mw8C/gRZyyngMDb1DNmLZ2++0eMEbcttZcszwU90Fc7j
         1IQAQwTv4lxwY8UAVAyUkICfPI69/+u3jRwiHBtM2NXzG9yjbSfM0ai2qE79zSR23jgr
         PKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S27L2Nf9xjsQpIHyXUYoqLsbaYJMetc5OVa6e0zSD18=;
        b=DYpgD7eQpoCsPxzDe8Qv4/3gu3x5t6m4aPqFN7D3NtgJMndtUCpLDXJPlGheFBnRnm
         GCLLFMOMYg4IfpkrlPoTlVownmeZ0lsVlmbDk/RtKM2HTBQpBmvUhybixGlPwbPLSTbW
         FegemFSBcfuFnRxVdSw9aJwK2XZJtsKOCmrOsvgRYdXOdNfrqJ0pM3j2Y/tUnfpmZGDN
         VN6yQT/WHvUFewEtdJN8ZvA7EDgbxXfGz9HwjA4gvGAgWDThreCinlKPBeZz9C5sQ8Xz
         6+45ahCO2rZdWs+6WaJzIzOAWUic1RRLyHaCyHYbAqdN490jOK0qeQPbntlHjE7KGFee
         h3Qw==
X-Gm-Message-State: AGi0PuZcHf+Wjpll1l38w86GEjWBmoNv0ucx6H944KinqKhcf0+jurKH
        ESCtzEImHSsMo6jQ7WtGGlo=
X-Google-Smtp-Source: APiQypJVeN8yoKN7c/COzFxZCdAqfmR2tEw/ohAjl+YOy8mXsvgfUpNHAeN5PI7xMkOr9QraDaxqtg==
X-Received: by 2002:a17:902:b948:: with SMTP id h8mr15235068pls.309.1588081959877;
        Tue, 28 Apr 2020 06:52:39 -0700 (PDT)
Received: from localhost ([2402:800:6374:bf12:8518:c5e6:e4cc:3967])
        by smtp.gmail.com with ESMTPSA id b9sm15073549pfp.12.2020.04.28.06.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 06:52:38 -0700 (PDT)
Date:   Tue, 28 Apr 2020 20:52:37 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
Message-ID: <20200428135222.GB31366@danh.dev>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com>
 <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net>
 <20200427201228.GD1728884@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427201228.GD1728884@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-27 16:12:28-0400, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 27, 2020 at 04:08:52PM -0400, Jeff King wrote:
> 
> > Skimming the patches, I do wish I didn't see so much repetition with the
> > existing Makefile. I know that some of the logic will just have to be
> > ported manually, but surely we could be pulling things like the list of
> > libgit_SOURCES from the Makefile as the single source of truth?
> 
> Thinking I surely couldn't be the only one to think of this, I dug
> further into some of the sub-threads. And indeed, it seems like you are
> on the same page here.
> 
> IMHO it is worth making the cmake file depend as much as possible on
> what's in the Makefile.

Please correct me if I were wrong (I recall this from my memory
without checking anything).

The worst thing about CMake is we can't override (Make's) variable
in Makefile generated by CMake.

I've made some comment in Sibi's patch about some make's variable,
because Sibi naively translates them from current Makefile.
Namely, the location of some system configuration files, $(libexecdir)
and build conditional macro.

With current Makefile, we can just:

	make VAR=VALUE target

or:
	echo "VAR=VALUE" >> config.mak
	make target

With cmake, we need to define all of them as CMake options (this will
brings along a big burden), whenever we need to change any options,
we need to (assume that cmake generates Makefile):

	cmake -DVAR=VALUE path/to/src/dir
	make target

How many make variables that we need to define in CMakeList.txt,
I don't know.

-- 
Danh
