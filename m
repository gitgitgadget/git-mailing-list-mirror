Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACEAC55186
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 03:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9392071E
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 03:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpA/eGqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDZDcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 23:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725942AbgDZDcH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 23:32:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E66C061A0C
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 20:32:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mq3so5863042pjb.1
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 20:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XSIgr4OllAmFWT23JmEqOvGYJpnhm4C/oN2wybxs8Gs=;
        b=OpA/eGqMhawYvaD1x8doFJ/luZMMzavp0yhEoGQcQuKUHni83MPuQVG5MiikMZFAwA
         GNwnj33OjyPMoRBIdgykWIPqST+CDqhp3NHuZzc/LLxnXzfjntTAmakfQM4zIs9t8QNq
         GVS/DDI7U2ZqAqbQMSyuW6gZoBxm/MRW++HGhf41z5t0qGRFkhFk4DxdXWj9/O73hXqt
         p4ZluJZzUb7tYVzSxdPFs8qZLFecFSpcxSmyx8W9eJ1+5UElvUvcaFz97Hl3lmZFTC4Y
         HnR9IszNUWU9jd3LUlTSQO8HzCRJjECQEdnRiwf67M5y/DrLn0h+gRih5TuYTlXTkXdE
         J93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XSIgr4OllAmFWT23JmEqOvGYJpnhm4C/oN2wybxs8Gs=;
        b=Vlks8imGDA65KhSS4qQmEkZ6dgCF8agHO2R6M4cRR6naChdAc926DdCPkXyI0VG2T7
         c9D5jdIio/eYj9fAHJQF7r1wBIm7BWKJnRSYyGW3EbpuN15uQvTend7W4a0rh3xB2a+V
         BQB/Eit7Uyg2icqkHmkiDOVpzOgulLuAi825NiKQExA2x6UJpwllblq5Kxin8pkkz99n
         Brt6O1YSJQVcbteOOOeN75PeUPh6BSKF02SQo3sRvkZ5W8MonXlmiVHuRYl4+DA7x51j
         OM6ZC+S5gFUB5c9D+wWMeS4Zq0jBWGYgcnemde8EZDxO8fO86X+1bRsfWxhdKsL8m3ff
         h/fg==
X-Gm-Message-State: AGi0PuYfu40M3FoZoeo7xoEbyTzgdwoxYJTX1ZiE7JAnN0KXsMnPybxm
        k4rVwfzYc+1P33eyYwN4FhsLWjtc
X-Google-Smtp-Source: APiQypInLMfjInwgVgkTCm1qkyt37eYRmZAEk2F/0BJea5vXr/ZP6dtN1WVjS9GwuGIoupiY82CYSQ==
X-Received: by 2002:a17:90a:2e82:: with SMTP id r2mr10065565pjd.128.1587871925274;
        Sat, 25 Apr 2020 20:32:05 -0700 (PDT)
Received: from localhost ([2402:800:6374:bf12:8518:c5e6:e4cc:3967])
        by smtp.gmail.com with ESMTPSA id z25sm9129473pfa.213.2020.04.25.20.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 20:32:04 -0700 (PDT)
Date:   Sun, 26 Apr 2020 10:32:01 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] fix make sparse warning
Message-ID: <20200426033201.GA14800@danh.dev>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <nycvar.QRO.7.76.6.2004251511550.18039@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2004251511550.18039@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-25 15:13:53+0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Danh,
> 
> On Thu, 23 Apr 2020, Đoàn Trần Công Danh wrote:
> 
> > It's happened that I tried to run make check on project that support autoconf.
> > Git's Makefile told me to run `make sparse` instead.
> >
> > I /think/ if we have a rule in Makefile, we should adhere to it.
> > I also fix another change in ds/blame-on-bloom, which I think it's worth to
> > fix, see: <20200423133937.GA1984@danh.dev>
> 
> FWIW there is still an Azure Pipeline building `sparse` for Ubuntu every
> two weeks: https://dev.azure.com/git/git/_build?definitionId=10&_a=summary
> 
> I created this Pipeline in order to support the proposed project at
> https://github.com/gitgitgadget/git/issues/345 which is: teach our CI
> builds to run `make sparse`.
> 
> Maybe it is time to tackle that?

I don't think it's ready, yet!

May be it's.

But we'll need

	make sparse |
	grep -v -e 'plain integer as NULL pointer' \
		-e 'redeclared with different type'

The first one for:

	struct foo val = { 0 };

to zero structure.

The second one for different in declaration and definition (which is
fixed in sparse's master).


-- 
Danh
