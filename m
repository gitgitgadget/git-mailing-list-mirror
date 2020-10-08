Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1E4C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923F021734
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMtpN2OI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgJHIoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 04:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgJHIoR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 04:44:17 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49806C061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 01:44:17 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 188so6088663qkk.12
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 01:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nmgoTkr/PZgj46YIsgx21QS33+vkWi6FMW5xFbOS8gM=;
        b=iMtpN2OIIp0kQlqnl+1RALkm/LYXNNDK1cfja0+yCw6THzWQ9av34GKO/OLScrz9il
         omuFN3khGlmBKamWVpA6otlhtNKVEct5eawhwiYYBjjTrgX21mptnzByL9NUyYEmU1J2
         3NYUOm7dpkDgd7ZYVexjPJ342lMUncYZn6bebSqP8fUFk3setJi9RPEXbdYR5xp7eDgq
         //CJtlgpYhet90sRDABAImnCntqHb4cjyLcmWV56jnb6Iggj3HgcT0U80Su5icfy8NJ/
         SMGTH7mZ72/jHw2z1uoYgoG8eVsD65lgN2DQcqjfoTkVmsggkfuRiFYZ9BZf7Jz6Jz/R
         I+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nmgoTkr/PZgj46YIsgx21QS33+vkWi6FMW5xFbOS8gM=;
        b=tY2Df7Appn6vtKfR3d/w0Fz+zezMW3Wl+d0oMuAeJdj+HO2/23weAf15X1wCxEsjc9
         GaGwF7BlUumrkaMBW1zx/d5310s+5H+/rFec9AYDNCpEcYavrmbP56hpNVPRbT1PjpBj
         zKq7BzO/pl34R/7Z4ZV4J/e3VV3euLRgU/iiAQ9iYGC8/K5olWEeC6jlIMOrl5DLutEK
         QdE0Gxxx+hDUzU5nGbhu+8kVtAsciliK5mFnIuereQi8Hn+5kxm2lL1OIYEL8hRW8yOS
         DAWKSKQIRxa3Wr5iXb2nlNb+j1gWFardW4OQMBw4+tmIjZccYhw5tss6frvcF8K4oStx
         mM6w==
X-Gm-Message-State: AOAM531eXeGQDwCS6EgByjingOSSDBze6WAKJo0F+tAieJ+e3KUeddca
        nrHHDie8YVjGkrXewhPN3gA=
X-Google-Smtp-Source: ABdhPJzzHnLyAwpJmroTAiJebAT5IN9cUvT0RuEXKxmS5CDVAYRCTe1t0YHwExIfZrGftkTI28fa5Q==
X-Received: by 2002:a37:c202:: with SMTP id i2mr7252569qkm.169.1602146656397;
        Thu, 08 Oct 2020 01:44:16 -0700 (PDT)
Received: from partizan.lan ([46.98.122.162])
        by smtp.gmail.com with ESMTPSA id a200sm3463938qkb.66.2020.10.08.01.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 01:44:15 -0700 (PDT)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     me@yadavpratyush.com
Cc:     git@vger.kernel.org, serg.partizan@gmail.com
Subject: Re: [PATCH] git-gui: Basic dark mode support
Date:   Thu,  8 Oct 2020 11:44:06 +0300
Message-Id: <20201008084406.7494-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008082829.h4wno3mntb4kk6oo@yadavpratyush.com>
References: <20201008082829.h4wno3mntb4kk6oo@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thanks. This is a bit complicated to be honest. I don't think we can do 
> much about the "installing Tk themes" part, but we can certainly make it 
> easier to select an installed theme in git-gui. A config option like 
> gui.tktheme would be good. Something to consider in the future...

I think application should not be responsible for setting theme.

Of course, it is simpler for user to set git-gui theme in app config,
but right way to do it - is to set theme on system level.

On mac it is already using aqua (with dark colors if set), and user even
don't know about it.

On windows it uses some windows-like theme by default.

On linux, yes, we must change ~/.Xresources, but this is just how we set themes
for tk apps. It's systemwide, and all tk apps will resect this choice.

--
Regards,
Serg Tereshchenko
