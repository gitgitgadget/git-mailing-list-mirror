Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43B0C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 11:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943A9610A6
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 11:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbhHZLjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 07:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhHZLja (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 07:39:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80768C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 04:38:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b9so1632871plx.2
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7Jknk1uA5fBvVh9ly8DohaYhIKnnP1n1C6sKF6YC/0=;
        b=CCEQJzlNvnO4pPy4pYpITVH8EY5M/0N/Fy+tHaw4kjWeTJEEXrdz8OOmjZrfYaqjsT
         qDYSvPSjGwIrsBNY44ZZxT6pocnw+10SAg37boPgwP6wJRS0mL8iwaYzEItfwgaljYwb
         1ACD+rtX4nvcIFo1g/oKwMs2mNyItosaCdALMdFsEtdNibAbo74PEVz3JSwkzCgB291O
         VtEkgwuv+XrBE+SLQ3CSOMH6aJHFPEwmKl04YH2aPv7HUUpNGlRhPsYq4FIQfW5OGG/r
         xi2vKDYr0Rm0lGcJLYgyvw7lLUDqzj2tYO8s47TftmGYK/RAL/7s3LP5JZcIb0tSgP8m
         c4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7Jknk1uA5fBvVh9ly8DohaYhIKnnP1n1C6sKF6YC/0=;
        b=mgluYkaLT++nYsXV11p2kjbWkzuGEMi1A60gRnBSzlN60T5n/ywyDJY4phlJLWVfjb
         9ObaTeVt+fT8LSyGgCi3bJjdoZmUVOgznSwjq1kW/2Ts+7+1uTJQ7yY7aVhtLpsr4NpP
         ZHRDOavmhJF6gF727wvWrW2c/5xR0j7nFbgb5TkqYfRpSNMJXkofP/bo/koGC7Dpy7/F
         Y1qy39XaAMSHWyZRPM4H2xO4xA5CbhwuvmcVLx3cAEivzqd0xEZFYBipsAVnbrN7Chfi
         4D5OHFWmSt6B95KVhblB0P2rbkhxLOVJpV6EWUb4WV6oLBly+s+90NEHBfTodeZewI73
         2XgQ==
X-Gm-Message-State: AOAM532AODXkUBHXyCP47dbfUOQhH7NTPWxVPMiTSI6Sl2vzW3BnVMEg
        xpFBGm+U7Qoudi+Y35iKprDdT7ottv0ddw==
X-Google-Smtp-Source: ABdhPJzHAcJue4gFJGBqeGuqVhsRb0Za69qyjjNcmf4o8Xj3HFMwNjESOC0jzDu6QIsXp+1x1igqdA==
X-Received: by 2002:a17:90a:d3d0:: with SMTP id d16mr16382432pjw.103.1629977922938;
        Thu, 26 Aug 2021 04:38:42 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-8.three.co.id. [180.214.232.8])
        by smtp.gmail.com with ESMTPSA id gm5sm2414717pjb.32.2021.08.26.04.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 04:38:42 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, felipe.contreras@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] make: install stripped Git
Date:   Thu, 26 Aug 2021 18:38:22 +0700
Message-Id: <20210826113824.50078-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This two-patch series adds convenient make target to install Git with
stripped executables (programs). The first patch adds such target
(called install-stripped), while the second one deletes the
now-redundant strip target.

Unlike previous attempts [1] and [2], stripping is done after installing
Git into installation prefix, without touching working directory where
Git is compiled. The advantage of it is unstripped programs can be
installed at the same prefix (thus overwriting already installed
stripped ones), particularly useful for debugging and development
purposes.

[1]:
https://lore.kernel.org/git/20210820105052.30631-1-bagasdotme@gmail.com/
[2]:
https://lore.kernel.org/git/20210817110728.55842-1-bagasdotme@gmail.com/

Bagas Sanjaya (2):
  make: add install-stripped target
  make: delete strip target

 Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)


base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
-- 
2.25.1

