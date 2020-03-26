Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E544C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 07:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356A7206F8
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 07:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8RisST6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCZHfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:35:46 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:42665 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgCZHfq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 03:35:46 -0400
Received: by mail-pg1-f180.google.com with SMTP id h8so2450461pgs.9
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TYLvl8XLhzcDeF1F2Nj70uz1LJSTL6eRbWXdV1QZuTc=;
        b=X8RisST6fgSPNMEgvwrez2IvXKz8A7MjEABu1cFyW4NExHNJSjTwFyupbGnm/57iXx
         ohCeeFORMPSYvxUTcIei17oxD5rBey1AdcsKAHfsg7SlREZxp2KuRWeE8OP74IAlYvJA
         gpula6v9CsE0aTZQDpYNC0JWY1RCtW0A7oD+fcy55xVBU+aljYg8GBMhcm7RV0Puudha
         AooTMId4BXIJQpZnh0U40r0wlmmY1BmK5PfxF7xt5UGg+m1Hgx/ELnWLu3T004qigXTQ
         /eWQg25LeC7JZyAZXMrgnvXnXIZKa4gy1ltazyaM72RlQKSf4+2ZLgTAempHGNyzLLXH
         67uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TYLvl8XLhzcDeF1F2Nj70uz1LJSTL6eRbWXdV1QZuTc=;
        b=Wne1NRoQRCKMF2hbPg3SRu6PYwZF2qkmcZknIk6DEMAPA8HYlmg/mIgilB5s5mqRq1
         RhpVqNB/8ojkGzNmItLI6XTO76KzVDsdwsc/tqCx4ed+wZql8h/4TZY1YsOGqj55pJuF
         aEHZRs9E1rOvF5m2fbkqfIHA7wXKP71ssUxJNpLZI5s3L+sNz25VnUivB8Zp4DF00KM3
         dm+REII7EHLARUkEro7BWBtkPKbZbm+v4HA7Wu445KetzPfnkRbyB/a/5ekWEcOhcwH+
         4XYLw66BlLJXL00FUxsbe2omOlvVUqG6CPerqlmdXzGUEMmacdz50SGjI+Awwf87R3Xa
         D3Lg==
X-Gm-Message-State: ANhLgQ2DTS47w3qWepre6NGSySmZA25Gy3sOPNeLlnJpGSQbhbPSDq89
        N+oMc5esVYRJy1B+Oj2WyFGINhgi
X-Google-Smtp-Source: ADFU+vs0FqwsXwRyKYY5F2f+QFhMAclbXuAsSQQY9EUWDo0DnbgE3VfHXMSotb6f297Y1dswjibSoQ==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr6908202pgh.331.1585208144388;
        Thu, 26 Mar 2020 00:35:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id d188sm968049pfa.7.2020.03.26.00.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 00:35:43 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 1/3] ci: libify logic for usage and checking CI_USER
Date:   Thu, 26 Mar 2020 14:35:17 +0700
Message-Id: <ca87bea4a379dac5d2e68bc18b0084201afe5fc4.1585203294.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585203294.git.congdanhqx@gmail.com>
References: <cover.1585203294.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This part of logic will be reused for alpine docker later.

Merge those logic into single chunk since they will be used together.

While we're at it, add a comment to tell people run with root inside
podman container.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

This patch is viewed better with "git diff --color-moved"

 ci/lib-docker.sh        | 37 +++++++++++++++++++++++++++++++++++++
 ci/run-linux32-build.sh | 35 +----------------------------------
 2 files changed, 38 insertions(+), 34 deletions(-)
 create mode 100644 ci/lib-docker.sh

diff --git a/ci/lib-docker.sh b/ci/lib-docker.sh
new file mode 100644
index 0000000000..ac155ace54
--- /dev/null
+++ b/ci/lib-docker.sh
@@ -0,0 +1,37 @@
+# Library of functions shared by all CI scripts run inside docker
+
+if test $# -ne 1 || test -z "$1"
+then
+	echo >&2 "usage: $0 <host-user-id>"
+	exit 1
+fi
+
+# If this script runs inside a docker container, then all commands are
+# usually executed as root. Consequently, the host user might not be
+# able to access the test output files.
+# If a non 0 host user id is given, then create a user "ci" with that
+# user id to make everything accessible to the host user.
+HOST_UID=$1
+if test $HOST_UID -eq 0
+then
+	# Just in case someone does want to run the test suite as root.
+	# or podman is used in place of docker
+	CI_USER=root
+else
+	CI_USER=ci
+	if test "$(id -u $CI_USER 2>/dev/null)" = $HOST_UID
+	then
+		echo "user '$CI_USER' already exists with the requested ID $HOST_UID"
+	else
+		useradd -u $HOST_UID $CI_USER
+	fi
+
+	# Due to a bug the test suite was run as root in the past, so
+	# a prove state file created back then is only accessible by
+	# root.  Now that bug is fixed, the test suite is run as a
+	# regular user, but the prove state file coming from Travis
+	# CI's cache might still be owned by root.
+	# Make sure that this user has rights to any cached files,
+	# including an existing prove state file.
+	test -n "$cache_dir" && chown -R $HOST_UID:$HOST_UID "$cache_dir"
+fi
diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index e3a193adbc..81296cdd19 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -8,11 +8,7 @@
 
 set -ex
 
-if test $# -ne 1 || test -z "$1"
-then
-	echo >&2 "usage: run-linux32-build.sh <host-user-id>"
-	exit 1
-fi
+. "${0%/*}/lib-docker.sh"
 
 # Update packages to the latest available versions
 linux32 --32bit i386 sh -c '
@@ -21,35 +17,6 @@ linux32 --32bit i386 sh -c '
 	libexpat-dev gettext python >/dev/null
 '
 
-# If this script runs inside a docker container, then all commands are
-# usually executed as root. Consequently, the host user might not be
-# able to access the test output files.
-# If a non 0 host user id is given, then create a user "ci" with that
-# user id to make everything accessible to the host user.
-HOST_UID=$1
-if test $HOST_UID -eq 0
-then
-	# Just in case someone does want to run the test suite as root.
-	CI_USER=root
-else
-	CI_USER=ci
-	if test "$(id -u $CI_USER 2>/dev/null)" = $HOST_UID
-	then
-		echo "user '$CI_USER' already exists with the requested ID $HOST_UID"
-	else
-		useradd -u $HOST_UID $CI_USER
-	fi
-
-	# Due to a bug the test suite was run as root in the past, so
-	# a prove state file created back then is only accessible by
-	# root.  Now that bug is fixed, the test suite is run as a
-	# regular user, but the prove state file coming from Travis
-	# CI's cache might still be owned by root.
-	# Make sure that this user has rights to any cached files,
-	# including an existing prove state file.
-	test -n "$cache_dir" && chown -R $HOST_UID:$HOST_UID "$cache_dir"
-fi
-
 # Build and test
 linux32 --32bit i386 su -m -l $CI_USER -c '
 	set -ex
-- 
2.26.0.rc2.357.g1e1ba0441d

