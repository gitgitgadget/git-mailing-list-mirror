Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286C6C433EB
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05DD92065E
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UReGNmNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgG1Upu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgG1Upo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:45:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A740C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 13:45:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so19546668wrs.11
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4cE8lBxgbX2JgAX3nPzWkcziKNqXxmfSxxXXSEaTiJA=;
        b=UReGNmNTS42dYQZ/lSPWmN4LB2IMKDRgr+xUpfjLokiVZ3wsdoLrpUK6njhXMfjh1m
         wX5Jdw1C9ASlYRZMWhgdsYQ2j7jArqnu+Y7xV9fKKM73mYMt+XAile0kkmjy8Jk+mwwZ
         DKoglIY0aVSr8oNWtp2hQvoCOEKoSilU87MVPemRdjpVxNZpmfVxWQcPx91FLvbNRsdp
         GOGjP8yzb/yzrRMyhgVa6F81+4XaLra/nhl5jh4eGSKbjQYEOho5avI1FqiNj/HL3QA3
         wQmaY/55C+6u/2vgJEw31OwiK+PDlIptYDL/XsPqSSpVKzaGOvxTyMKeE3of1ri0ajtS
         cLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4cE8lBxgbX2JgAX3nPzWkcziKNqXxmfSxxXXSEaTiJA=;
        b=pVFnB2r8JaM0BjwvwduHDbE/f4015gh+4AM8qaS0GVPo1R02itluLj/n6NtftyiLJB
         pwWPTTrHqEvPAgKkPsIVaVI5MCAdicczge358jbamHMJJznHJICabdIBWY6RPd2si9FQ
         hGp1H0A8cJmxIYsUuDTk5Zz6YWBBR3CPzav+ufqUi954x1gAxlDtpjRcLiX8lsSmExwy
         2sLGlq9l6B5d6DQqUcNAlRLpZ9GKn9KH4G4JGPraFFfpazyuqPI6ATI7hHDIS67yLSqK
         VtO1mD9Pfh1kytsHXvPs3SNkjbMRSBBqWaQOWHmwiet6cshcUqI/Ga//KHYfMXoVKTxk
         XMLw==
X-Gm-Message-State: AOAM532pji+aXuXBR5m/uw9Jy2xyEzeScJ0TX1ZHkhHGbUlPQCCev4E6
        f/RxJQaOFvjyOAO+5zBVqJyicsHc
X-Google-Smtp-Source: ABdhPJzefClXpezYbh0q52/3cxSgQmifSRcdj4+45QatIub0p6cMDpszCHPMO3/Qi3MgSJGhT3vfWA==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr25166739wru.22.1595969142563;
        Tue, 28 Jul 2020 13:45:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b139sm4448wmd.19.2020.07.28.13.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 13:45:42 -0700 (PDT)
Message-Id: <cd9e69a910eebfaa8fd7866326d60a5c9733f1c8.1595969140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.824.git.git.1595969139.gitgitgadget@gmail.com>
References: <pull.824.git.git.1595969139.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jul 2020 20:45:39 +0000
Subject: [PATCH 2/2] hashmap: fix typo in usage docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 hashmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hashmap.h b/hashmap.h
index 79ae9f80de..ef220de4c6 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -168,7 +168,7 @@ struct hashmap_entry {
  * argument `keydata`, respectively. Otherwise, `keydata` is NULL.
  *
  * When it is too expensive to allocate a user entry (either because it is
- * large or varialbe sized, such that it is not on the stack), then the
+ * large or variable sized, such that it is not on the stack), then the
  * relevant data to check for equality should be passed via `keydata`.
  * In this case `key` can be a stripped down version of the user key data
  * or even just a hashmap_entry having the correct hash.
-- 
gitgitgadget
