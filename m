Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA15C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 04:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC07619AB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 04:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCWEua (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 00:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCWEuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 00:50:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC394C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 21:50:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so11662380pjc.2
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 21:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3b8uize+I85FCFvksar/C9ahoaWjWXkNTdS3LD0Vqc=;
        b=IIQG0e63UhUjLq0fQaXuF/zVmNTnCyGvbVX1Cp9vQKiNZUaCuf1+uqQICG+FpEMQ/U
         F06GQySjk0SZ1P1s1IbJSTCz/yF54nj2nAB+kNv5pSqG1yVkIArVboL6h4nDFQoggVWC
         TeADHurWeP2tHPtDOnGlNx1v7HgbPkM3ivSNP4TeKYax/WtkL7H7ALFbi7YxZQpAi+L3
         OJY1fDN/+BF4/x4saL/44yb3+OxQbM12gnRb/k3L8HnjTxfmE5WV1QSOCyiSZz+yuaY+
         0zdfH6grT/NZEpqVN/MUuz19LCD56wjXQEu/x8XsDrhYZvrKXVLSj3fF6DRUV8JRKHiS
         RfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3b8uize+I85FCFvksar/C9ahoaWjWXkNTdS3LD0Vqc=;
        b=FYfwxHM1ePL0Ba7jVEZl1hZcJ63l6CFwLTOoyITMZ219mDqFJycjpxeWDhOY0Wv9rp
         pn3wL3AzF+x6Dnh07KtJ46DuH9iJdsOexz1hgZSJdmXre79We7miPdhLD+KlEUhLrb3h
         vh24FRSwj8Ed3CTtRsGXl02ql+gVeAtzYw/vLXB+kBqPnfryoN9yxbTkgRSrMYTpWD+p
         SNOzlfdqacu/RDCd7/9HKi61DzI1OnzZ7qKpeh1rO3i/6YrZdSGGrU2XPLzBsl/ooyxt
         AiU+NDNt1N94CBtk1mooJmxK9fkTZrKYtzu6wlXR3H+Hx6URq7wulXPJA3Viuw5ijABU
         deLA==
X-Gm-Message-State: AOAM533Rm+cHdkwL7ldwKl2vewQw06AXFpHhtQmE8p0VxWv84liuLJ0d
        E2qXUAQPhAFL29Nnkr/F7SXrJi+Sf6NnXw==
X-Google-Smtp-Source: ABdhPJwj49Bh7M0TCNWMz1p7hJ/a/Qbg+1ackjaFwLkPHhmdn5MxE19U4bfEEWSnQi55ALzgmHHm+g==
X-Received: by 2002:a17:90b:4b87:: with SMTP id lr7mr2416033pjb.5.1616475015205;
        Mon, 22 Mar 2021 21:50:15 -0700 (PDT)
Received: from localhost.localdomain ([2409:4052:2e1e:3747:744e:af84:93cf:1aaa])
        by smtp.gmail.com with ESMTPSA id y2sm13563930pgf.7.2021.03.22.21.50.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 21:50:14 -0700 (PDT)
From:   Prakhar Khandelwal <prakharcs01@gmail.com>
To:     git@vger.kernel.org
Subject: Regarding Git Hooks
Date:   Tue, 23 Mar 2021 10:19:57 +0530
Message-Id: <20210323044958.2744-1-prakharcs01@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey !!!
Hope You are all good in this COVID-Pandemic
I have a query..So, for explaining my query I am telling my used case

Used case-:

I want that as soon as I do push my code to any CVCS(Centralized Version Control System) service provider  like github , I want to do something . It may be sending mail to someone  , sending notification on slack or maybe anything..But, when I made the use of post-commit hook on my local workstation it did not work..Then ,I searched on git hook documentation whether this hook exists or not and found that it doesn't..
So, I want to say that if it exists then please correct me and if not then can I take this idea as  my GSoc'21 project ???
Waiting For reply.....:)
Thanks.....!!!

