Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03406C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC497206F5
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3nmze7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbgDBNEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:04:47 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:55805 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388174AbgDBNEq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:04:46 -0400
Received: by mail-pj1-f46.google.com with SMTP id fh8so1501354pjb.5
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kUOnnFKNplO1jmxotbadtBf5lW2t/73rymw6qrkdEtY=;
        b=Z3nmze7C/ndxMqUdKB/CGulzGTlroZYR0M2Yo4SZMsh30WbsRB6mkPq25ffGH49MhH
         lsOXH/1RcnG0AL5uK1lBP6DRtvKIBvJaDmEV2xs549bBdYX72ShGDxF+uNJ3Zu7SeYUj
         6GjyTNDSotd1+6394QoUBD0V5LnvVQ0FWBrY9g/kyThW9c/TR0WKNCfDH1iPsdxA645y
         0Fs20Sb5yTl1WdV5xZt3Kc2qNDK3vq5oFQK8VwKd+V3RlTwD5Ts0FVXmZF4J7B3tsKsk
         IjvDpsifj9YRWHCWwizumBGNLWJBmezqG1xFmtE3IuFeN4qZF/1BU6LdlLIWQRZxluxV
         ZlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kUOnnFKNplO1jmxotbadtBf5lW2t/73rymw6qrkdEtY=;
        b=YydAx4fgP1hcfovXvvt7iPImez2nAQ+gjrgDQ9DK8ineEx7wRLiu2VfstvWYG7MIpx
         57LP1lqCfb7H7MPh7XFZjylzywJigRiS4X1MJyV79etRJ3Pfu6djw6iUmLVe8dKh909x
         4si6DwPNcN44nF+mg0YY5WQwiNZ+ZhJiE9raiEtyJ8kDqIPk3bb8i6sKgR+JheR7qhyY
         BJz+M5h2QHbnQEHjTBY/RqHsccNhnkkYGySPKdPTkVA9FJNGgnttQOXnisgi0eR1nPdc
         GMhxse+gJGxHJlEqvL/NQAz5j5yYLvZsi5y7YBVa/NHvGLLHjYjyCzIapIuFSVSuM3Al
         YYqA==
X-Gm-Message-State: AGi0PuZ0mwOBMmAoS4VsxwX7QFy527FcFGsff9xR7TnuYiG9KKUVUo7w
        OmESFHOJUmfP6CaJN2Knws2j9bMm
X-Google-Smtp-Source: APiQypLo+r7L+4IRWkV/jdkUE4p0KPEzD5nr1tJmzM3OVDcoV1yXUCjBNkSg+8ZX8NTJ2c+hCG3+ZA==
X-Received: by 2002:a17:902:9003:: with SMTP id a3mr2776391plp.331.1585832685081;
        Thu, 02 Apr 2020 06:04:45 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o15sm3371124pgj.60.2020.04.02.06.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:04:44 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 5/6] ci/linux32: libify install-dependencies step
Date:   Thu,  2 Apr 2020 20:04:04 +0700
Message-Id: <2e0d54f81e4b997fd469cb6c0d04820140079a7c.1585832270.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585832270.git.congdanhqx@gmail.com>
References: <cover.1585474409.git.congdanhqx@gmail.com> <cover.1585832270.git.congdanhqx@gmail.com>
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

