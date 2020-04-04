Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2F8C2BA1A
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350AB20731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uciVr87j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgDDBJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:09:12 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:55836 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgDDBJK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:09:10 -0400
Received: by mail-pj1-f44.google.com with SMTP id fh8so3837790pjb.5
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kUOnnFKNplO1jmxotbadtBf5lW2t/73rymw6qrkdEtY=;
        b=uciVr87jUB5Txdgh66KZ1HfZUAu621VBH8dEf5J38y77TQQ1i8EsVjQDMVz4CRhJXT
         q89BjJ0lRL8T17TLCn4ruyhhKL9Yxxh6xOKLzRwX7eZFZXnjf/2esAJi/dt/+dQ+2sPf
         yUUyENCipHfkOFtsewU3wMjR2ZMHv9a0c/p+irAlOXLD/l1LYJCIPgNrHSNX9lAa1zl7
         JNmix1gNLbNgW6lY2Ry4aIAFW+3SGljC/YGRdSu1I8iBY8ZkrhX3rwPvikugIatT5UhJ
         jQmcRHCsYELEk03BLDgXJYWjWUsHqcJryTwX6mROaorJha8SDj6aKvdDvJatoRIG+EfB
         oK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kUOnnFKNplO1jmxotbadtBf5lW2t/73rymw6qrkdEtY=;
        b=R6pAD/geLNzIDHWVngVz9ehTOL4rziiIT3AZGDofhXcNQS7DdIMx/QcOopbNDdwkSR
         xJz30xzG+ztHhWf43x9x9k4JatjQImwjrzuE/IuMNbi/HPDAjGcHgRqBJ2y5OcFIJRaz
         2IP0YqfjVv8uVjWYIZ9oBjZu05iwS0lDRAeQBo1t5mTreONNn0XKV/4OpQaFRdUbFs+W
         tYU3F27VOWLZgiFTaLsMuaqBdLVW+KaSfTOnh0NBN83KsfjXIVGWmmEVsMMJRFQYuRRV
         odrVvt81DgOLB091hcipEZBWRzGujMtfiC4w2dQiPj1rYO4R3MEHt2tkyPjVJwi897qg
         Sy/A==
X-Gm-Message-State: AGi0PuZ16AhVr/TXSV+ku6okeN2RWHAusPLF0ySmgIkZ31YKcZSAIcWw
        PkguZ45l/A82mwHhpDkR7bKbooPh
X-Google-Smtp-Source: APiQypJBjz8YHZoaNK6zedQUA8BB80Yzh6sKd3eoTQvABKqz+3MnBQchuDpPVjlQRj2tcOSxokGCdg==
X-Received: by 2002:a17:90a:8c09:: with SMTP id a9mr12622506pjo.154.1585962547280;
        Fri, 03 Apr 2020 18:09:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o12sm6664319pjt.16.2020.04.03.18.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 18:09:06 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 5/6] ci/linux32: libify install-dependencies step
Date:   Sat,  4 Apr 2020 08:08:49 +0700
Message-Id: <c39451ffe56489a7550ab66fcef6ed132159ee6c.1585961568.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585961568.git.congdanhqx@gmail.com>
References: <cover.1585474409.git.congdanhqx@gmail.com> <cover.1585961568.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, we will add new Travis Job for linux-musl.
Most of other code in this file could be reuse for that job.

Move the code to install dependencies to a common script.
Should we add new CI system that can run directly in container,
we can reuse this script for installation step.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/install-docker-dependencies.sh | 14 ++++++++++++++
 ci/run-docker-build.sh            |  7 +------
 2 files changed, 15 insertions(+), 6 deletions(-)
 create mode 100755 ci/install-docker-dependencies.sh

diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
new file mode 100755
index 0000000000..a104c61d29
--- /dev/null
+++ b/ci/install-docker-dependencies.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# Install dependencies required to build and test Git inside container
+#
+
+case "$jobname" in
+Linux32)
+	linux32 --32bit i386 sh -c '
+		apt update >/dev/null &&
+		apt install -y build-essential libcurl4-openssl-dev \
+			libssl-dev libexpat-dev gettext python >/dev/null
+	'
+	;;
+esac
diff --git a/ci/run-docker-build.sh b/ci/run-docker-build.sh
index a05b48c559..4a153492ba 100755
--- a/ci/run-docker-build.sh
+++ b/ci/run-docker-build.sh
@@ -23,12 +23,7 @@ Linux32)
 	;;
 esac
 
-# Update packages to the latest available versions
-command $switch_cmd sh -c '
-    apt update >/dev/null &&
-    apt install -y build-essential libcurl4-openssl-dev libssl-dev \
-	libexpat-dev gettext python >/dev/null
-'
+"${0%/*}/install-docker-dependencies.sh"
 
 # If this script runs inside a docker container, then all commands are
 # usually executed as root. Consequently, the host user might not be
-- 
2.26.0.334.g6536db25bb

