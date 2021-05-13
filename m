Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE9CC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 22:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C8E610E6
	for <git@archiver.kernel.org>; Thu, 13 May 2021 22:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhEMWtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 18:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhEMWtK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 18:49:10 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E235BC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 15:47:58 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id d21so26772320oic.11
        for <git@vger.kernel.org>; Thu, 13 May 2021 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=igziLN2TdHu02gewJb3b7VMYWzDneiaVfKC3nvoKSE8=;
        b=gTCRELA9La+zc4eM+ca/2ZXnQz+HzdQ391htAQ9/5UvmmTxCfFqH7leiYAyinoyP8Y
         hREE9qPssDMVs84GsvHvWUf1lyeeJmq34jILCSM9bOyb/ykwplqBVN4/5wgct/eIedny
         1DehZn+7VFT9YKXlquqdvBcoP6H0M9HE3DbXcdqTaETvAXpSMZD3nd6LZOuRrteY8y/5
         0Vc0p8tMSWUmJwGFdKsFS2fmXdy68daUIYKVG0cAhhencyqqosPE+ENrVQ0/liXv/YEQ
         UDUfDR6SdwxH3SsGfYNeVsSZ06b14qED41fCkO2BeU/Uez9LXCiICjA2C4MmVDWNQ96K
         luBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=igziLN2TdHu02gewJb3b7VMYWzDneiaVfKC3nvoKSE8=;
        b=SXiGFwHn6mA/h2QEikzLzrYgFkkD2JhAoiWFMSOfQlw//QRaPGYo2Djcrl4/cRTkN8
         Dgu21ApUTllVZIRlzdPx7lyIRsfR55JcvyNlp3VYYYGpGFjugbyawIMZmpR/cYk1V5PQ
         ZS4w01EqNV0Fl8A/cvqDt6NakE30RvI3a2kVuyUfIkVfL1GAL26wpLC1mB6d39hVQYGL
         jQxxBtJEM+oV04aVWfzNxEWcECImw1+vGvtwunW3fcuDwrZmeSwcJPr/HF2jK2pbvkAJ
         qx5umf1QiqbAAvPZjFueZ2N4jH0DOB5VR+mvVhuhofklwyt2X68CcJ8fP4tdYdhZHve6
         yfYQ==
X-Gm-Message-State: AOAM530M6NT705EepdMRhRBJOqgJcTY0Usp79kzUI7l2fM6m32b5WT29
        iznkJyH0TD3g2YSi493Nxu+RM96gWbN9EQ==
X-Google-Smtp-Source: ABdhPJwy7dbQNE1wszJwCvU48AgVFj8n1aCRk0WIwjxyl7xMurFQyHrpHlAP4wEDcUWaciRQzpcGlg==
X-Received: by 2002:aca:53d8:: with SMTP id h207mr4766331oib.177.1620946078189;
        Thu, 13 May 2021 15:47:58 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id y11sm957587ooq.2.2021.05.13.15.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 15:47:57 -0700 (PDT)
Date:   Thu, 13 May 2021 17:47:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     dwh@linuxprogrammer.org, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Message-ID: <609dac9c16814_42a020839@natae.notmuch>
In-Reply-To: <20210513144930.GC11882@localhost>
References: <4591b3bd-1f35-55cb-6eb0-be97810d6e68@gmail.com>
 <20210513144930.GC11882@localhost>
Subject: Re: [RFC doc] Tracking git.git
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dwh@ wrote:
> On 13.05.2021 20:05, Bagas Sanjaya wrote:
> >But tracking seen is more like tracking linux-next. We do NOT use git
> >pull because often doing so will try to merge origin (upstream) with
> >our local version, which are divergent and most likely will end with
> >conflict.  Instead, we do git fetch first followed by resetting to
> >upstream by git reset --hard origin/seen.
> >
> >Should the fact above be documented? And on what file the fact should
> >be placed? In INSTALL?
> 
> I vote yes. I was trying out tracking the different branches and got
> bitten by this very situation (tons of conflicts) when pulling seen.

git pull is evil.

For more than a decade we've had unending debates about how to fix it,
and nothing comes out of them (last one being [1]).

Just don't use it, and tell your friends to not use it.

Always do `git fetch` plus either one of these:

 1. git merge --ff-only
 2. git rebase
 3. git merge --no-ff
 4. git reset --hard @{upstream}

Cheers.

[1] https://lore.kernel.org/git/20201208002648.1370414-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
