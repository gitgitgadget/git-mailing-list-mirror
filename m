Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_ABUSE_SURBL,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD408C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBF720BED
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 15:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2T8nka1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbgDAPzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:55:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43220 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733193AbgDAPzk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 11:55:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id f206so118514pfa.10
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gT7c91AbNzt9s4NLVVCFVAOJXpLUduxjSqCE+yLOFFQ=;
        b=q2T8nka1bzA/paoqXUBIWT9oq8D2D2cDe6fbGE/rPL+eogrrcmP9lKlg8GZ/YMsIG0
         cown36uHYiaS6RMHNoGT0YtuwX0unJDf4ToHoCC0IhzTmoXtuyYezPeNwJmB7n8yWLqr
         sGQfjgPGY5NNpWeozPbBFpTWOHtk/6BBlWVPt0GYPDnbqrYzQvoCcDwXW9kMePFLZqoD
         q3EZDo8+AoLyvefzkatAiSCoa7NnK+W/533IoNnCBsQElQAivgTkg6pzIFmqDydq+cAT
         KE510Fp+PERykBzjMKluo9KHNZG8lo67SaEOAHe+uKChqlBnHDFID6Swxx+9mR1uUnA3
         Oq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gT7c91AbNzt9s4NLVVCFVAOJXpLUduxjSqCE+yLOFFQ=;
        b=Ow5pH66+p/ZjDy5gfqqybZxwHoyVmSWgfI8L4pbdcJJYp+GmQu7yUyzUFc4i7rmpst
         I/gTPweviqwbUfBKBcqHHvOnbVHpntgF7DXEPOABcK+EZRPvyw4+17znxWi2OVowXTv4
         GN4wCONs7lVL1VG+s9Mi2yeiROyfwzAYV/eP+BZr8Can4icXx/s67BF786IsMUu/IeFS
         7u5d50Ic8tJb54j26RfxX7u4S1oDuOr8DAGvE3yO7w1VEgr7aaNRXGaXWtvar+5YA6Le
         F9K9bNL0xmjkYxvA7UH/Mqw2JNuaCO+4/WEaL+Z6ZJRbQellC8/LajOU0i+F2J7rBErT
         PO4A==
X-Gm-Message-State: AGi0PubOu1NJOWwGM2x+hccIeJDqn4qX0DPWWgn3/Yowsi0hpJ9YcqCp
        pSgpkswZVDyO8lzsW7i06UYRd1Kj
X-Google-Smtp-Source: APiQypLPT/oMTN1E5SYOzNjlzdeUCjI3W6rfWuWp8Y5l0hQmYm0GMumCUI0NQ/0NCdDy1khPafVY9g==
X-Received: by 2002:a63:dd0a:: with SMTP id t10mr9488167pgg.50.1585756539325;
        Wed, 01 Apr 2020 08:55:39 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id x4sm1990826pjf.23.2020.04.01.08.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 08:55:38 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 5/6] README: add a build badge for the GitHub Actions runs
Date:   Wed,  1 Apr 2020 22:55:07 +0700
Message-Id: <4310a7c9d6062e10a74ff8910a6abc1a7806eabd.1585756350.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585756350.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1585756350.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 README.md | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README.md b/README.md
index 9d4564c8aa..e2e00ae249 100644
--- a/README.md
+++ b/README.md
@@ -1,3 +1,4 @@
+[![Build status](https://github.com/git/git/workflows/CI/PR/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
 [![Build Status](https://dev.azure.com/git/git/_apis/build/status/git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=11)
 
 Git - fast, scalable, distributed revision control system
-- 
2.26.0.334.g6536db25bb

