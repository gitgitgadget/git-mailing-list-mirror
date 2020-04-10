Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66147C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FD820936
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D366wrBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgDJRSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:18:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46549 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDJRSc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:18:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id k191so1214102pgc.13
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nlER27XWxnwvB+mDIpMBWguXrKb0hg83RLymj3cezec=;
        b=D366wrBo0UYWpHtXVpb+JKpQDU6u54ngLY7Y5oevmjo9VUHwiVP3sI2el+Vva08Med
         N6UdudeZJEUzQ9/Wq+xPHA0eeaubvzrlc848HmK+8xgvMCgz/zky8DGTFbWDAOLQyNfC
         L3rJK2XwqKs+M7Iht5o97a3SHFq/EEtYslXc3TWj16x8JJCRaIDpLf8LpujZOolXGmZP
         ACjBAeUqG6yNidJVEDr8l32TWWy24pAjVUJGBAz/LQL+aOQzL72bTiKIBXaEFGuYpqSY
         XE9zZoGorrNXYw6hd6C3Dz5SzOKmn0C9lkGFLwJq/Fj4Rq/Myu7uL4eutv0oNwhZaDGN
         170A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlER27XWxnwvB+mDIpMBWguXrKb0hg83RLymj3cezec=;
        b=bXk0Pc/TDBhoNZKHt6YeA56QE2czMFmuYieNrhuh+edhZ2YLiD9SdN7bByl0qpHcJm
         CqsR00BXLS0Xr0yQvyQltbUF7IELpgQLaynpj08OvCjtDfxqqb2y7zFU4cAgcFl8+ZHy
         aGvwsNKC5/x23GG0Vak5FFBig5JY3/UyGk/rvHQKppYKyh0hyp9QFEdimGUQadsjavuX
         jl94WqgHGknbhucZiylR20usGU96xDO+nm0GehROlLRc79aq63jzWl7cSSqXJO28B9RR
         PybzO7uhE6A9n8trMMFS/lvKesz6FvjLeBrEZZ/jLB8ua+J+fyxOZeeeIz0gubwIehUq
         hgow==
X-Gm-Message-State: AGi0PuZMbPP2vFmMeS7dt0wZNDV7MMAgEDnmCtkBqpZik8EvN7Bc6V1P
        Lz/DyihObLAm/sxuzQ7kP4seKnJk
X-Google-Smtp-Source: APiQypL0yDdTH0w31DJYR23I/u8mj86emhdqD9nOO4epwRAtMUh2U1tXTjC7D/6PBQDmbUQEKWrt0g==
X-Received: by 2002:a63:2014:: with SMTP id g20mr5278503pgg.180.1586539111354;
        Fri, 10 Apr 2020 10:18:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s125sm1972897pgc.12.2020.04.10.10.18.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:18:30 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 06/12] ci: run gem with sudo to install asciidoctor
Date:   Sat, 11 Apr 2020 00:18:08 +0700
Message-Id: <2fb9f2e2f285a2df40ddab3f954b661fcd5da588.1586538752.git.congdanhqx@gmail.com>
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

In a later patch, we will run Documentation job in GitHub Actions.
The job will run without elevated permission.

Run `gem` with `sudo` to elevate permission in order to be able to
install to system location.
This will also keep this installation in-line with other installation in
our Linux system for CI.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
[Danh: reword commit message]
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 3633a60a1c..0229a77f7d 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -70,7 +70,7 @@ Documentation)
 	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
-	gem install --version 1.5.8 asciidoctor
+	sudo gem install --version 1.5.8 asciidoctor
 	;;
 linux-gcc-4.8|GETTEXT_POISON)
 	sudo apt-get -q update
-- 
2.26.0.334.g6536db25bb

