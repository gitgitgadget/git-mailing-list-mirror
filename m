Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF34C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 10:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA5920732
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 10:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfxPMTf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgC2KM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 06:12:59 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:42021 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgC2KM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 06:12:59 -0400
Received: by mail-pl1-f170.google.com with SMTP id e1so5463674plt.9
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 03:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iiMkaElhGWAGWzibQkdS/t+S2SLXO5KEB7PiIv4m/h8=;
        b=GfxPMTf6WSRpSOFIEaSs8syXiNODXlfZORY4sOcObXOWMkvNRB6aIu9PMMt9kFTCUj
         AxTZbDJ0TrYqPyx9xrIJCeoHJ9bJXu34I8WoOmsfNxi/gl5FV6KcCTX42vIAC34DS+jU
         ipuI/vTH9bnyJWsqUJDKI+KTMQRIt4z1b5lp/KxQ9n2JeG/lQYDZFUqOfekI97L0AMVi
         xWPCJ6PMCZZRDWoXM1h1IG5elIAtyNNeep2DX+oSWog1Cxx9RYbAjkuJ85lAIfY08Xld
         iYrvKxkMYwZENFrhV8YiWxYsGYitGFMyOI9APPBA1qNQWNEt7iy1x8qFBGBU067WoNp2
         8heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iiMkaElhGWAGWzibQkdS/t+S2SLXO5KEB7PiIv4m/h8=;
        b=A4V1QqY+l3WBYbMiW74z5xxd0t3HKBb7YL8/ZKGTTVtvmQi8TKxphmPN4BuqfmBcCa
         Zhj+A+URzMDWEYjG3zV/jEg+JirTSystgEV8GpARddEEwrvtSSP4SignAa0JeMpmNPIr
         GBDaPLl65be59laAR+4EBiXlZ7xoygniR/90OM+XMyLnF0QhKsk4Z14NbGd+4NS0eWzU
         Qnn4CIiTZWwQOznPLeBMc0BWVy7j2vIxMkFB+hXLqaZDkKiFwsBq0XJxmCvTSdRUAqXU
         wi7XYvnCSVZPu/xrxf4HHph1tOoUurUuYj9i54dYh+slYYBgm2EUgKkuGpoMuImecNjU
         U3YQ==
X-Gm-Message-State: ANhLgQ09Ysd3V0CtnsnHeaebgCaD2+hTpYTCBczKzNg6Bpni/oWL3xHh
        l+CXyfECXcgCwDVPADXiuQ7UT7tw
X-Google-Smtp-Source: ADFU+vsZmEQy6UrjU+b2r2icXsNSA/88bh1lHAciYx2IG7VoLB8mw/IihRMszehSo5A9x0rmcMBDJQ==
X-Received: by 2002:a17:902:59dd:: with SMTP id d29mr7413152plj.246.1585476776190;
        Sun, 29 Mar 2020 03:12:56 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:f121:1d2a:e7e0:840f:1f18])
        by smtp.gmail.com with ESMTPSA id v26sm7757386pfn.51.2020.03.29.03.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 03:12:55 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 1/4] ci: libify logic for usage and checking CI_USER
Date:   Sun, 29 Mar 2020 17:12:29 +0700
Message-Id: <1ec7c2024d60ce2b6888367fc48942e8febef15f.1585474409.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.302.g234993491e
In-Reply-To: <cover.1585474409.git.congdanhqx@gmail.com>
References: <cover.1585203294.git.congdanhqx@gmail.com> <cover.1585474409.git.congdanhqx@gmail.com>
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
2.26.0.302.g234993491e

