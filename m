Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7075C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ED320936
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYEgsjIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgDJRSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:18:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40489 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgDJRSf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:18:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id x3so1024495pfp.7
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gT7c91AbNzt9s4NLVVCFVAOJXpLUduxjSqCE+yLOFFQ=;
        b=cYEgsjIgXCi8nOq+hxub/z1M5U5FQ9UYGf0QPHCgCoPdvgOlI7IWvCjKE7qrlFX5jG
         qVIPhn32tAgYMh0nA4UF+vH7KQieH+rMYFe5g/cou3h6cV0vHTHYEabnwKzmK3exy2/b
         X60WrAALItKMnoqb8qWNwszpog+VEHpgtRfjrvNCXPaEhJcyuGHPDKhJBeu0WmgVGPHJ
         SjQQ/nUn1QlBloLYXds8wa8XHxf/nle0WgqHkKIhYOwSUGI8bJhGNkvEpCJ9RYk//HJO
         3oA9XVuhB3VMT00fhaVU2LDJw2b2+rXRpGSoo9wpRYmXiUOSiDTnZS1NLgJKcYWD+pQZ
         2zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gT7c91AbNzt9s4NLVVCFVAOJXpLUduxjSqCE+yLOFFQ=;
        b=KnkoVB6Rba+ktJkBVGWIgS7kbEa0tFUTOX/sA9/T6i6u9FjP3cE7RAfDZJNzFecV9X
         w7DDGisoXWpSEt9skx1dc7/oO22kt9t6/nwEGvgUY9lTZC8L8cDDm6k8nWuU9a+q75+s
         eIhE5MDdUjXWuQ3+khHnRlxEjKIi5NwVyBLE0XSyJVthaJDWIM2CXykCS8Ni/BW+YNvh
         TB924rzC98kwXjqV92CV/UiJY0t1Y2xehdMKK1CuyTVcW3gd0QUR9E8+TxCtQFqMlcf7
         XrS6alXkwiAh5DiCIzrE7MpydjoBMxiHemxk3mEYLa3JQz8/KCjcuxMmGW5hJo4SMCwB
         YDzw==
X-Gm-Message-State: AGi0Puar6bLDQ2fkWthGtWH9Xw49to6QIGm/qOro8FJGBHmT10YFc/xP
        2lPwgSP8LR/0ngKqgmUr+zE4Zq9B
X-Google-Smtp-Source: APiQypJ/ZacEk/ug9RSBFRhov+dKalhKGxcJnR7HEOZUFz/pgy7gANoJxcd6ce+GMDI3GOc8wfo20w==
X-Received: by 2002:a63:313:: with SMTP id 19mr5339846pgd.360.1586539114846;
        Fri, 10 Apr 2020 10:18:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s125sm1972897pgc.12.2020.04.10.10.18.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:18:34 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 08/12] README: add a build badge for the GitHub Actions runs
Date:   Sat, 11 Apr 2020 00:18:10 +0700
Message-Id: <09735fb1de03391cbd1ba1d303623f5142fe5ae0.1586538752.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586538752.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586538752.git.congdanhqx@gmail.com>
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

