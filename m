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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338A3C2BA19
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CED20787
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1sJZq2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgDDBJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:09:12 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:38696 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgDDBJL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:09:11 -0400
Received: by mail-pl1-f172.google.com with SMTP id w3so3491075plz.5
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/sSVghJ66jUjqUbjM2EIL9qrcnOaZ7+I4xQYsEGpouI=;
        b=s1sJZq2fDkdorJQP/ASJjt5JFnPkIpW/zca8R/9PY9/ovAxdK1/oQbELt0354Ma47v
         MeGYfEdipd74VgTL0LOSaD+oxSmnDvhrR/xN/Vg8zkaWBD9OqkIpN6nXNAzX4XfLQ/pz
         k8i/pSMRNawXQUuMU7fl3J38L2HJyHf+JYPgy9Fl/zYBAWmJqODMXizIos21VcZL7ej3
         njfNWItbZmyoG2UCd+YTbiWWIVqcIyHwJXBw9U560+aDWGtp18dyKw4X3aFHR3c7cU9y
         GMdr+W1Zny9S75w9AvFdCCg2636ajq49Z3A1/Z+TIjIJTnu1yx/FUO0mbl29vEWSMsXI
         LuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/sSVghJ66jUjqUbjM2EIL9qrcnOaZ7+I4xQYsEGpouI=;
        b=PeMwhl710Vha+t+NUwcRMNX3cjkJ6/TMQTF8ztUkIS42nG82N7gyKDmo5/xhN/U9pS
         r6R4GOckf6zW829yYH5nvY/iaPiBbUZwt8bgW9YTYUJP1zTyvXmnIHf4zn0NylfAp1YO
         eNW10hcMf3RSCLHgTHmKa7OEoBLYDPL0fTWO9bg7r9HcMHMfUOtxbWCryTMvYh+d04CH
         BN4R3XyiC+nQW0+0Y8Vc/12ZKQqcjv1KRUhceNNT/kBywRnRBqnbU5ZQQWd/Iyho6gOn
         PNPaFjGmSlQoeCHflFjK75jm2b2ZZq0TbGsqSlxJcI0XbCeV4weZ75DAeaE/Z+SnZwDn
         YAvQ==
X-Gm-Message-State: AGi0PuZszNHDsXlkaf1ChXyCBJR1sClIvcsLA9p7gsUDoMCqsomWfUBE
        NOVSEzvwBKmeH8R1YYSl2DdyXkgt
X-Google-Smtp-Source: APiQypKqbCnnJXeR648y5TA7w+MvxVbgH/0OPp54XQF1+jox2wwxj2ElxxUBfYEgNyuNqipSacyFdA==
X-Received: by 2002:a17:90a:7184:: with SMTP id i4mr12605088pjk.40.1585962549285;
        Fri, 03 Apr 2020 18:09:09 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o12sm6664319pjt.16.2020.04.03.18.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 18:09:08 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 6/6] travis: build and test on Linux with musl libc and busybox
Date:   Sat,  4 Apr 2020 08:08:50 +0700
Message-Id: <231affae8376039c68248efa972c37ef92b79d90.1585961568.git.congdanhqx@gmail.com>
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

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .travis.yml                       | 8 ++++++++
 ci/install-docker-dependencies.sh | 4 ++++
 ci/lib.sh                         | 5 +++++
 ci/run-docker-build.sh            | 4 ++++
 ci/run-docker.sh                  | 3 +++
 5 files changed, 24 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 069aeeff3c..0cfc3c3428 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -33,6 +33,14 @@ matrix:
         - docker
       before_install:
       script: ci/run-docker.sh
+    - env: jobname=linux-musl
+      os: linux
+      compiler:
+      addons:
+      services:
+        - docker
+      before_install:
+      script: ci/run-docker.sh
     - env: jobname=StaticAnalysis
       os: linux
       compiler:
diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
index a104c61d29..26a6689766 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -11,4 +11,8 @@ Linux32)
 			libssl-dev libexpat-dev gettext python >/dev/null
 	'
 	;;
+linux-musl)
+	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
+		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
+	;;
 esac
diff --git a/ci/lib.sh b/ci/lib.sh
index d637825222..87cd29bab6 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -201,6 +201,11 @@ GIT_TEST_GETTEXT_POISON)
 Linux32)
 	CC=gcc
 	;;
+linux-musl)
+	CC=gcc
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3 USE_LIBPCRE2=Yes"
+	MAKEFLAGS="$MAKEFLAGS NO_REGEX=Yes ICONV_OMITS_BOM=Yes"
+	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
diff --git a/ci/run-docker-build.sh b/ci/run-docker-build.sh
index 4a153492ba..8d47a5fda3 100755
--- a/ci/run-docker-build.sh
+++ b/ci/run-docker-build.sh
@@ -18,6 +18,10 @@ case "$jobname" in
 Linux32)
 	switch_cmd="linux32 --32bit i386"
 	;;
+linux-musl)
+	switch_cmd=
+	useradd () { adduser -D "$@"; }
+	;;
 *)
 	exit 1
 	;;
diff --git a/ci/run-docker.sh b/ci/run-docker.sh
index 3881f99b53..37fa372052 100755
--- a/ci/run-docker.sh
+++ b/ci/run-docker.sh
@@ -9,6 +9,9 @@ case "$jobname" in
 Linux32)
 	CI_CONTAINER="daald/ubuntu32:xenial"
 	;;
+linux-musl)
+	CI_CONTAINER=alpine
+	;;
 *)
 	exit 1
 	;;
-- 
2.26.0.334.g6536db25bb

