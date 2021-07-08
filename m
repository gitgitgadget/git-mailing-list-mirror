Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8622EC07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 09:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB17619AE
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 09:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhGHJ6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 05:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhGHJ62 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 05:58:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7046DC061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 02:55:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h1so2663696plf.6
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bgKiDYH5MiLz3QnCGu/7trIciC7DbFtCsc1X9c1H/0=;
        b=VElSlpZYU8HZPwiEwoLr7MHdPzWNXLG+qa1dR2xy8yteqgfLSbXO0HmhqJTc2oiTHr
         oangITwTuTsDwDqYHoR6UItTalQ7aGbarMSJIYWz3h96c0eWReH3FPnclD7X/0RCK2AI
         LpSPtMGx4CpigGhXOxFY2IPgcBssKt9OTN1wC9IyrSnjQn3ZWN7YHScbaoEhj/BZHlr8
         Tq5nB+dCVOBgpItfiOYciVwwW0ezvqYxgX9IB3mexyMhVV9g0QoaXwZpismFtGKHT4R7
         B3Dpds6YiyBkL3qGawqLLyro137U7M0Kud+fsLeBHlo2G4E6M41PMsrVykUqyVn9ELwf
         zprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bgKiDYH5MiLz3QnCGu/7trIciC7DbFtCsc1X9c1H/0=;
        b=naUUiOWjui/jhho3CoMIobrMaSTA6DhQdbL6HvhY0eD55i7AnBhCAidwKdfxzK/TL9
         z80JTyn45x+as1134L8klgM32tnAcNq8tehe2ZjaT9f0sP/RtUaKWM/S/aFvJkhMf06r
         QovvZW/mbotWd3UvPpzVOCFmTdqfFXZH/nZGYecVIJZ3UI/ecCEVYvwewTDXAu3uYmy8
         Byk+lufMpiYmaxQTqhcWN+anPl4TRmGySeGC2hO0NYfxnZjz9hzPbNCw+tQGSOJtBBor
         uBdRcKmaYao+y5REVg3wsGmwMsDpC5zr47WL0cnaOrBvdTwbYkY15MqR2w/nUM/qqfnO
         J1Jw==
X-Gm-Message-State: AOAM532iKK8rnWstqsYKR3hB/bG4kwi75p1nStffc5nZccMeJZSenkYp
        q37MP3g9soM3/nWLBlaCyHpDFjyMp96LvWKn
X-Google-Smtp-Source: ABdhPJxP8tpbuGruU27mAHHJweavGaHnbDedHLsBGuUiTf5AqH2C2hVBdZNKtLmpD6I+TJiGaHdNGA==
X-Received: by 2002:a17:90a:b284:: with SMTP id c4mr31736267pjr.213.1625738146737;
        Thu, 08 Jul 2021 02:55:46 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id a9sm2126925pfo.69.2021.07.08.02.55.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jul 2021 02:55:46 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH v2 0/4] submodule add: partial conversion to C
Date:   Thu,  8 Jul 2021 15:25:29 +0530
Message-Id: <20210708095533.26226-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706181936.34087-1-raykar.ath@gmail.com>
References: <20210706181936.34087-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:
 * A custom die routine is no longer used. Instead, the shell script is changed
   to prefix all die messages with 'fatal' to match what the standard 'die()'
   function in C will output when converted.

Fetch-It-Via:
git fetch https://github.com/tfidfwastaken/git.git submodule-helper-add-clone-2

Atharva Raykar (4):
  t7400: test failure to add submodule in tracked path
  submodule: prefix die messages with 'fatal'
  submodule--helper: refactor module_clone()
  submodule--helper: introduce add-clone subcommand

 builtin/submodule--helper.c | 418 ++++++++++++++++++++++++++----------
 git-submodule.sh            |  76 ++-----
 t/t7400-submodule-basic.sh  |  13 +-
 t/t7406-submodule-update.sh |  10 +-
 4 files changed, 342 insertions(+), 175 deletions(-)

-- 
2.32.0

