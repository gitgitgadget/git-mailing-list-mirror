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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC15FC2BA17
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE4720787
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feXA3+A/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDDBJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:09:06 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:36240 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDDBJF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:09:05 -0400
Received: by mail-pg1-f182.google.com with SMTP id c23so4453608pgj.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RjJlf+NbEOVWOA3c1dQ7gl1DX4DXq6IImAbBtdg7bHM=;
        b=feXA3+A/M6lkFa0z8pbqIEsfAZ5q1x43OtOuQRkXT+yanQaSAqOpD1QUwaKBKVmLiW
         +Q2/3NodvUwKgNhOBC3v+Ue+5RyZ0T1veXLX40LqWS/T7kiOdcI2PLegUFT1ib7RiZTC
         ckDGDHXxpVaM4ZnnEiImZ4Z7L1iTeuWJy6YfE2qZOJVaePvk7FOHZIAS/AwnkSWkmPeI
         FsF7MQYFvWQAtcsGhQDJkDxtRbiI3+Mcjr4xeRzk0uphxe//56vXQgGW+1epfycCFO/i
         b4v8UfXJKRU+OLhXIaQ+6OMHfQ0C+knA5WSJjUopzVtdzhEOZcWSHXoRrwlLXrorfIB/
         73vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RjJlf+NbEOVWOA3c1dQ7gl1DX4DXq6IImAbBtdg7bHM=;
        b=ezzV8hB5Vgelhn2Qt8AZ0CvKFBmujltrqbl8M40X1Dx15CC6EZrShYB8/i43+Cy6aj
         KY5clBPg1/qXSNnWHRMMNqF53hf3kaDUrrWzkTHKV9m8DkuBEmkxkXjCPi7AMNVkQNYu
         vdY/4OBCI9adhA7t5nh/kuFcgGZoJrA6mUF4Z0ZVbvISMEK5gz/JoAveikT0Kx9nHN4L
         i2lVxqcNAfQht75Jg+v3YwKFnq7ZtxmlBrR1QJqlwB8WJdNrJ89ZTZWz8NO5jEINxGnJ
         bOIUuaM9hbWmv8LfyUr9oALhFwxy5Po5xWEiG+mtc4WUNkvCnTgJYBXq5Ea+IfoG1Hxi
         aAaw==
X-Gm-Message-State: AGi0Pub6Z3xuIBUmNHa39exa8hg+vUkKMN1iMyRxpet832d7YQVkAagi
        KOaR15Bk+64PnJBNAscmULb21CFf
X-Google-Smtp-Source: APiQypIgVgFCsUXytuFGMOe0a8iXvC1209Ej1UOjxcPa9SCEy+sMPY7+XHR0yTVdSy3Sbmk2a+r5MA==
X-Received: by 2002:a63:ff53:: with SMTP id s19mr11034884pgk.247.1585962544018;
        Fri, 03 Apr 2020 18:09:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o12sm6664319pjt.16.2020.04.03.18.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 18:09:03 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 3/6] ci/linux32: parameterise command to switch arch
Date:   Sat,  4 Apr 2020 08:08:47 +0700
Message-Id: <a13715245f4587ea53d2ecbca75b3f25f9c15818.1585961568.git.congdanhqx@gmail.com>
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

