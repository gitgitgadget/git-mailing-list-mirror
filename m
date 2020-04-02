Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABB1C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07BC20757
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7yOJvaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbgDBNEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:04:45 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:38381 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388171AbgDBNEm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:04:42 -0400
Received: by mail-pl1-f169.google.com with SMTP id w3so1312648plz.5
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RjJlf+NbEOVWOA3c1dQ7gl1DX4DXq6IImAbBtdg7bHM=;
        b=U7yOJvaAttToLh6NBLq8zTCS/zD+CMvy5Mny/j786qZL6wDnSKgCqzhXanQeLQJEqy
         /KtCzguCkUlwKzx3U1kvto3d7GKABiWVr5rpFxxAHFscqeI93M8kYhL1fcNb6/xb3pOA
         KoW8AM50joOpVtrXE+hfsk+2lDbz9ay/Klyy5ofAhlHNrolp3T5Mpc0QdXYFaS7qTzfb
         v/CAELq0X+9IbVzLeLsLeb/rCFKvXwC7xtWeAj220h9o9hwVD3II8ia0dZDobQJhmYUQ
         7YZXVuApE2n256hvMt6MzBGHncKRixGPBlqRvmYoCdRiMD8QrdAxSKiLf+Wp5t/2Jod8
         60lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RjJlf+NbEOVWOA3c1dQ7gl1DX4DXq6IImAbBtdg7bHM=;
        b=s/6TtsiV2NMo4WHASwV1uS47mp/m7VX9Rreu3Ls8f3aNdgzADH//F81qT4b/ILNdSY
         es2DO/eAdwPg5CJh1AtXjhVszJT/HnZnk/b5Z0VN/seLlIPx+TnrKdgpLEP5QK2LzV0z
         x1UKlVfE24UyDdHry1JJ1UsBDUFKBAdvhUUFieF9itVB1z3rUenkYy2/YZi9izXJTwUe
         YN12oRCn6jzPlgjy+bElWHmHtEkgPV/izySNYDponpksd4aZqzLounwpAvKpGVbaOu7R
         47ifIgAbGxz1DEo8ZtJJ/+kwadkHUwXsfNlQDbEvFHabf8MjouT4elPYdwa2v43IPH4o
         T+8w==
X-Gm-Message-State: AGi0PuakRFatApzrCoW/W/QHO+O3EWSwkDmLhs7OPSAhmS++n+19DTja
        W47rxZH8c0M487btkFeid+N0twE/
X-Google-Smtp-Source: APiQypL0NX0MinsKIc+jrKJ0JbW2jTW3/Xph0Vf2y5fLTwnsEbkWORhXUfvWPCiv54Ykd2Cx5BS6Pw==
X-Received: by 2002:a17:902:bf42:: with SMTP id u2mr2636637pls.99.1585832680521;
        Thu, 02 Apr 2020 06:04:40 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o15sm3371124pgj.60.2020.04.02.06.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:04:40 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 3/6] ci/linux32: parameterise command to switch arch
Date:   Thu,  2 Apr 2020 20:04:02 +0700
Message-Id: <8c8cf3eb24d3099fcf95807a10c5e1b9b0256a98.1585832270.git.congdanhqx@gmail.com>
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

In a later patch, the remaining of this command will be re-used for the
CI job for linux with musl libc.

Allow customisation of the emulator, now.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/run-linux32-build.sh  | 13 +++++++++++--
 ci/run-linux32-docker.sh |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index 7f985615c2..44bb332f64 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -14,8 +14,17 @@ then
 	exit 1
 fi
 
+case "$jobname" in
+Linux32)
+	switch_cmd="linux32 --32bit i386"
+	;;
+*)
+	exit 1
+	;;
+esac
+
 # Update packages to the latest available versions
-linux32 --32bit i386 sh -c '
+command $switch_cmd sh -c '
     apt update >/dev/null &&
     apt install -y build-essential libcurl4-openssl-dev libssl-dev \
 	libexpat-dev gettext python >/dev/null
@@ -51,7 +60,7 @@ else
 fi
 
 # Build and test
-linux32 --32bit i386 su -m -l $CI_USER -c "
+command $switch_cmd su -m -l $CI_USER -c "
 	set -ex
 	export DEVELOPER='$DEVELOPER'
 	export DEFAULT_TEST_TARGET='$DEFAULT_TEST_TARGET'
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index ebb18fa747..54186b6aa7 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -9,6 +9,7 @@ docker pull daald/ubuntu32:xenial
 
 # Use the following command to debug the docker build locally:
 # $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
+# root@container:/# export jobname=<jobname>
 # root@container:/# /usr/src/git/ci/run-linux32-build.sh <host-user-id>
 
 container_cache_dir=/tmp/travis-cache
@@ -21,6 +22,7 @@ docker run \
 	--env GIT_TEST_OPTS \
 	--env GIT_TEST_CLONE_2GB \
 	--env MAKEFLAGS \
+	--env jobname \
 	--env cache_dir="$container_cache_dir" \
 	--volume "${PWD}:/usr/src/git" \
 	--volume "$cache_dir:$container_cache_dir" \
-- 
2.26.0.334.g6536db25bb

