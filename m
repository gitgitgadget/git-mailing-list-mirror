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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E664C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 07:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46B4206F8
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 07:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkKJqgVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgCZHft (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:35:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34483 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgCZHfs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 03:35:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id d37so1951758pgl.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 00:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o1d/23CTrwJ5jiQB4tTskeSnDCOiNGYtGkE04AMZBdA=;
        b=lkKJqgVyhRPB6FSG4xIwebkuHQzN8yzCUeH0TZWdw13nBcCDKzSLMurLdeageZWemW
         vblXh7p0io6pefwJYX4B+94F5YiA8zL0UKkgyTu6xea4MJ8UTssyMRtOC4SP122ho7pY
         7uLfxwEZaB1E1D+zQLL8fjL2BDTdGromH4OA9E28Z9292WEC8lyXjhdeIVEt1a78pKUz
         BCrw6tBhRP6NwvKzamKNXIx7BVZ2NT2DxutVcElXLIhdcyt98+t8CsBe5zWo+ZNlANot
         5X9tfK/xonezbYvXQYGibc9+RdA+uqcza/3/ZBxusNNSmNJs7urbJ+SUc0cNmE8JAqDQ
         OLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o1d/23CTrwJ5jiQB4tTskeSnDCOiNGYtGkE04AMZBdA=;
        b=Mxd51ZJWchw5/Ruuxz9bG/s5GztkBRh7QL3SSvfqL8dbYqCdRHGmDoRvX/mFrGyzWA
         BQS2whHa/p2ekCJjk6kakDjbxRx6WNWkFiEBQNcB4Zicldp+Xg2s+AX2w/ua4g1Wg+lM
         jDiU1e2y3UB1hOR/+XXSceCr+iw25VmJVVJZv6s9efdTY87hehja2lxqUnjRITRUSbq3
         1sIBstIcw2AT9NceejDda++KrDiSTZ2zu7qqLq0ANKEeLS2T+mkY30D7DtrT88EYd3jO
         FCNWs5uK5NLodGj7HiUXD39I0MSxOboM2D55e7nrouS1htck90MxYwF+c1o+MYh8d46c
         aXuw==
X-Gm-Message-State: ANhLgQ3DdejzX8d9tSTkOpqJFXwsNjbrt1kLMqBeuMR/52zhdIRzNsx3
        VAUysGPaJ19hUUUN71KqUfO95mV9
X-Google-Smtp-Source: ADFU+vtLxax5+ez44HAcR16jescCe+a5LJw88mJh8AHhAa3w66rxn87vRD2NSl7ZEEFRVpP7dSTXdg==
X-Received: by 2002:a63:c06:: with SMTP id b6mr7163614pgl.218.1585208147342;
        Thu, 26 Mar 2020 00:35:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id d188sm968049pfa.7.2020.03.26.00.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 00:35:46 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 3/3] travis: build and test on Linux with musl libc and busybox
Date:   Thu, 26 Mar 2020 14:35:19 +0700
Message-Id: <7d65bb87a25ab35dbf21d972e10a2c3321cc6761.1585203294.git.congdanhqx@gmail.com>
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

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .travis.yml            |  8 ++++++++
 ci/run-alpine-build.sh | 31 +++++++++++++++++++++++++++++++
 ci/run-docker.sh       |  1 +
 3 files changed, 40 insertions(+)
 create mode 100755 ci/run-alpine-build.sh

diff --git a/.travis.yml b/.travis.yml
index 32e80e2670..a2927dd120 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -33,6 +33,14 @@ matrix:
         - docker
       before_install:
       script: ci/run-docker.sh linux32
+    - env: jobname=linux-musl-busybox
+      os: linux
+      compiler:
+      addons:
+      services:
+        - docker
+      before_install:
+      script: ci/run-docker.sh alpine
     - env: jobname=StaticAnalysis
       os: linux
       compiler:
diff --git a/ci/run-alpine-build.sh b/ci/run-alpine-build.sh
new file mode 100755
index 0000000000..c83df536e4
--- /dev/null
+++ b/ci/run-alpine-build.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+#
+# Build and test Git in Alpine Linux
+#
+# Usage:
+#   run-alpine-build.sh <host-user-id>
+#
+
+set -ex
+
+useradd () {
+	adduser -D "$@"
+}
+
+. "${0%/*}/lib-docker.sh"
+
+# Update packages to the latest available versions
+apk add --update autoconf build-base curl-dev openssl-dev expat-dev \
+	gettext pcre2-dev python3 musl-libintl >/dev/null
+
+# Build and test
+su -m -l $CI_USER -c '
+	set -ex
+	cd /usr/src/git
+	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
+	autoconf
+	echo "PYTHON_PATH=/usr/bin/python3" >config.mak
+	./configure --with-libpcre
+	make
+	make test
+'
diff --git a/ci/run-docker.sh b/ci/run-docker.sh
index c8dff9d41a..47affcd6d3 100755
--- a/ci/run-docker.sh
+++ b/ci/run-docker.sh
@@ -8,6 +8,7 @@
 CI_TARGET=${1:-linux32}
 case "$CI_TARGET" in
 linux32) CI_CONTAINER="daald/ubuntu32:xenial" ;;
+alpine)  CI_CONTAINER="alpine" ;;
 *)       exit 1 ;;
 esac
 
-- 
2.26.0.rc2.357.g1e1ba0441d

