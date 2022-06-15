Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FCCCCA473
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347627AbiFOKxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243714AbiFOKxm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:53:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D894D50E1A
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:53:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v14so14832198wra.5
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEf6/mKgNjPBCIBvqgHSRsQA0Fw1UccGKQh8hWA20h8=;
        b=CSHV9qz2Nwj3P72nzPO7Cw2bWa4+MlYcY2pkdJr1U3x78pa8sB6Vm6zkrYAee9y7gL
         e5V3hyAV/JFpEa32KyH9wtLMwgsS6qeB5dav4EVO4+rQOv1CTpEaclwtovHvwEjdpjEW
         HqyIGiyJbgdBf1Pn251x8DtzDi4Bh/P3A0w80nuoud8S3iIXilk/52vfv/n7/ati4GLw
         hYlB9kL8LA1XEHaUA8Qy8GBxYUG5ygVH17ANLg/Ozi5seP9r0WRpR1BJHhf1u2iH5mf9
         y3q7EitM9BKexZB6EznI+Jboly/0IiE60bHK2qoWdzHJFeAYQba50YVtyAq013+U2DGk
         vUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEf6/mKgNjPBCIBvqgHSRsQA0Fw1UccGKQh8hWA20h8=;
        b=T/d30v/D2Y5/SaYe4M8mhcgC8XNuTRpNljPVzZUxGuNw61il4GxugDMpnadVLkTEjy
         Fhly7iFq/TvpvBwxHHXaj/dyGSuH+EFC2dnW3yWMXLEWsbfKAmLMS9DvM1tMus7C7yJJ
         uSj6QFCyvgxb6gBSvLSBZWl9KDPq4uD87fBzC3a/47NZzqRkHVjuPRuaSY1HSd6f8fX4
         nbOnIqQTq5toYTMJEJRnvclEeo6Z+FTRVudddRpCqzfMfockg9WfcObAuA3g7R6bujLc
         dqmiyw/obPkg1SyN2DeWumxtj2KgK6xcOaIPQJNQqJpWEAYyfy3F1Im6TjaCv4H28s0o
         rJ2w==
X-Gm-Message-State: AJIora9ecvr/V5BMtezlq7ePBNaeTNGf8MMjlO2tWKD1zrXZ9YHbSgPW
        gnof7hyFZQ7E6dlK3wIVFEx3PFb+jfyIqQ==
X-Google-Smtp-Source: AGRyM1v7nAWEsTcWKvcRDqmJ+5L+UvDi9wkoUFyUR294iHeOvoZiYO0qsIyZdQ24565vX/iCEu8E6Q==
X-Received: by 2002:adf:dd4c:0:b0:217:6a02:ea92 with SMTP id u12-20020adfdd4c000000b002176a02ea92mr9289088wrm.685.1655290420070;
        Wed, 15 Jun 2022 03:53:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g12-20020a7bc4cc000000b0039bc95cf4b2sm1786747wmk.11.2022.06.15.03.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:53:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 3/5] CI: add a linux-BUILD-vars job
Date:   Wed, 15 Jun 2022 12:53:30 +0200
Message-Id: <RFC-patch-3.5-d69368c5b39-20220615T104503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
References: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a linux-BUILD-vars job, in a preceding commit we fixed a bug that
would have been spotted by testing under NO_CURL=Y.

This CI job attempts to unset various settings in config.mak.uname and
the Makefile, so that we'll stress our fallbacks and conditionally
compiled code as much as possible.

If there is a missing setting here that we can enable under
"ubuntu-latest" the omission isn't intentional, this list came from a
quick skimming of the relevant parts of the Makefile and
config.mak.uname.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  3 +++
 ci/run-build-and-tests.sh  | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 3fa88b78b6d..25263c6b17a 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -229,6 +229,9 @@ jobs:
             cc: gcc
             os: ubuntu
             cc_package: gcc-8
+          - jobname: linux-BUILD-vars
+            cc: gcc
+            os: ubuntu
             pool: ubuntu-latest
           - jobname: osx-clang
             cc: clang
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 8ebff425967..786285c5071 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -31,6 +31,36 @@ linux-TEST-vars)
 	export GIT_TEST_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	;;
+linux-BUILD-vars)
+	export NO_CURL=Y
+	export NO_PTHREADS=Y
+	export NO_GETTEXT=Y
+
+	# Undo settings in config.mak.uname
+	export HAVE_ALLOCA_H=
+
+	# Various compat/ fallbacks, with "FAIL" omitted if faking it
+	# doesn't work on Linux.
+	export NO_REGEX=Y
+	export NO_MEMMEM=Y
+	export INTERNAL_QSORT=Y
+	export SNPRINTF_RETURNS_BOGUS=Y
+	export FREAD_READS_DIRECTORIES=Y
+	export OPEN_RETURNS_EINTR=Y
+	export NO_HSTRERROR= # compat/hstrerror.c FAIL
+	export NO_POLL=Y
+	export NO_STRCASESTR=Y
+	export NO_STRTOUMAX=Y
+	export NO_SETENV=Y
+	export NO_UNSETENV=Y
+	export NO_MMAP=Y
+	export NO_PREAD=Y
+	export NEEDS_MODE_TRANSLATION= # compat/stat.c FAIL
+	export NO_IPV6=Y
+	export NO_INET_NTOP=Y
+	export NO_INET_PTON=Y
+	export NO_UNIX_SOCKETS=Y
+	;;
 linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha1
 	;;
-- 
2.36.1.1239.gfba91521d90

