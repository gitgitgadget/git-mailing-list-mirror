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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C51C43331
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7489D20731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWrWumZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgDDBJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:09:05 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53671 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgDDBJF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:09:05 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so3846930pjb.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fm/J7oy92nuUfAhK/b9hEElAruJ3Ivpr49s/CEScwMI=;
        b=SWrWumZhIn0VZ7UFYlIPfh428TXDRvovPk351SMjSqliEUEE1b9DYboGNYPnpV6Rsu
         05WG6emC+6OU5k6T4V0AdZn2lXG659K34QbjN8NdGWp3e/lSMmYEXg7aQKw0QVbRuTJc
         b6tPe4EJiEVrSLNirv0gBKoGFkDcyIzAEhOLmA//uPPMLTaB5yzKxwm+z+lpRfHT5XtS
         TbKFYyHIW9tTb5Cby/4bYwGLEzqc7lDlgVnCLJtCM1vK/ZqhBE17Gq5Gbf8zNX4wjIeU
         B+X/pnt/rtUbyhiN8aMBtAXPDU/apNAy45lwxB/rs/ZlipUzqjrdV3SNWGQb0L1Pqtra
         JI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fm/J7oy92nuUfAhK/b9hEElAruJ3Ivpr49s/CEScwMI=;
        b=DBQKkhfm8fmQyQffdwCE6tjBgioCAE5VIiYbg3UUI9mh8AcaFeWsSCcowiv8MM6doC
         DaQmX7KaJ/nT80egPDogH4FClfkPAxq6iOzplTW30dvqJKF31xCNWg/gcVr10jyScjfn
         MDpAngCGu0Pa3k4PIPEd/Szovh5ciLdKV8xUbIFBcwIS4IFXaTCUeKDY4frp9MXNwfYG
         jor8DOYUwW/scsgnzrEqjm0UdnZrG6rF91mGOowj+XhCwYXCc86oWRm6Pci5TTSS43tL
         Ospi2dgRyYq2/zzc65cU9M3ecU7KNb5zgxQ70ykNaYQUcqYop7YeMP7ggulHINW9CA/5
         VTVA==
X-Gm-Message-State: AGi0PuZN1wcjaZrbU27dh3X8xMzHs2yJfCzMccTHCnWp0EUlD3izpM29
        v+GS1oDQ+M7oBiARePdKvbTnaM5T
X-Google-Smtp-Source: APiQypI6acpYeMtv3QKuPGDoWzrx1ku68xakRKbw4hdwWCy3lxy822phPrloP+IOMUs97GNyZtYb7g==
X-Received: by 2002:a17:90a:71c5:: with SMTP id m5mr13285832pjs.193.1585962542529;
        Fri, 03 Apr 2020 18:09:02 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o12sm6664319pjt.16.2020.04.03.18.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 18:09:02 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 2/6] ci/lib-docker: preserve required environment variables
Date:   Sat,  4 Apr 2020 08:08:46 +0700
Message-Id: <db574b3ff9b0a2aff0f3c669e70379bb30d9e8d9.1585961568.git.congdanhqx@gmail.com>
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

We're using "su -m" to preserve environment variables in the shell run
by "su". But, that options will be ignored while "-l" (aka "--login") is
specified in util-linux and busybox's su.

In a later patch this script will be reused for checking Git for Linux
with musl libc on Alpine Linux, Alpine Linux uses "su" from busybox.

Since we don't have interest in all environment variables,
pass only those necessary variables to the inner script.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/run-linux32-build.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index e3a193adbc..7f985615c2 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -51,10 +51,17 @@ else
 fi
 
 # Build and test
-linux32 --32bit i386 su -m -l $CI_USER -c '
+linux32 --32bit i386 su -m -l $CI_USER -c "
 	set -ex
+	export DEVELOPER='$DEVELOPER'
+	export DEFAULT_TEST_TARGET='$DEFAULT_TEST_TARGET'
+	export GIT_PROVE_OPTS='$GIT_PROVE_OPTS'
+	export GIT_TEST_OPTS='$GIT_TEST_OPTS'
+	export GIT_TEST_CLONE_2GB='$GIT_TEST_CLONE_2GB'
+	export MAKEFLAGS='$MAKEFLAGS'
+	export cache_dir='$cache_dir'
 	cd /usr/src/git
-	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
+	test -n '$cache_dir' && ln -s '$cache_dir/.prove' t/.prove
 	make
 	make test
-'
+"
-- 
2.26.0.334.g6536db25bb

