Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB8EC2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A122087E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMoiA6Ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDJRSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:18:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45693 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgDJRSa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:18:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id t4so841198plq.12
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cEZd3ru7g0htbMk1iD1kYmV9OS4NXcNnckWUMiLwPk0=;
        b=VMoiA6TiBQBjAj/lOnOE9tngknDLpjKT65FaeHWnlugbfDg1CgXjHuJC8w4ge3FNPs
         VVTsDAFIh+romh4BkDXdGeJaDfdsuZOE6ED9qDkhz8mZzHYgMg8Lmp1XJZg8EyzkhwzW
         tYZlqqGNGh43h2pMAVDrBoO5VTjYcbRtpfEiqe3YG5z5OreWRqcbXYNxPzRwOXrb5Fay
         w7rEIlImNBtAYhR5JRDC0DjGvknmJZcNg4lbfqA/7G7Za02DFjvECh3cjR02otzrgD+7
         leFS2/GTcYxc0+zZqXAY+OW2v7YLKuvpBob2Jw1ZjOLftzlDUI6RETugmT18FJFbJWoc
         O27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cEZd3ru7g0htbMk1iD1kYmV9OS4NXcNnckWUMiLwPk0=;
        b=aj5anBKuhKcm0zt6yXyDOSNA68FUbdTPIukSQDB9g9puF0qZIOM4KX7pmRjhQ1y8Se
         imHketw6YMbvIHlge4K9ztxFy8B2YUFAIjjTeu9bsh7slZvN2p+fuzc5jpsmrdGGPgna
         KGnZfoXbZNpK1riF8ydWZtulgEl/LlXpUcZAmktzhsP7T+5p+Fdxb1CGITiDw+Ddm26h
         DOkZDh7DWcESvNaDp8FGbOAAnvZIwEB6XCDGo4cKUCtGWk7RGYzBD5dm2+RN8wBywBMQ
         AhMV89UEvFSIuYOXKqQavbXAm0o0ncP6KrqZy2qrk4HjcJKO78IYgSHn6fw/jDvIbJS1
         xgdw==
X-Gm-Message-State: AGi0PuaW5bsNeSFfm9Z0FsT9QQ+qejWTmwjPxV4Ill5YLlkeamr1KcsF
        L05ncBrvvrDAPZUym39SWGraLKkB
X-Google-Smtp-Source: APiQypI/6o4T42xiQ0A8DwH3RLaZ8pVFiSXhL3vxU5gzyUsSk4w/ejkkNERj+c6TUxdmrfzp7Z5Mew==
X-Received: by 2002:a17:902:bd45:: with SMTP id b5mr5370911plx.185.1586539108036;
        Fri, 10 Apr 2020 10:18:28 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s125sm1972897pgc.12.2020.04.10.10.18.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:18:27 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 04/12] ci: fix the `jobname` of the `GETTEXT_POISON` job
Date:   Sat, 11 Apr 2020 00:18:06 +0700
Message-Id: <1df60e677c0b98b010c74914ab49f32a544bc59f.1586538752.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586538752.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586538752.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 6cdccfce1e0f (i18n: make GETTEXT_POISON a runtime option,
2018-11-08), the `jobname` was adjusted to have the `GIT_TEST_` prefix,
but that prefix makes no sense in this context.

Co-authored-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .travis.yml | 2 +-
 ci/lib.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 0cfc3c3428..05f3e3f8d7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -16,7 +16,7 @@ compiler:
 
 matrix:
   include:
-    - env: jobname=GIT_TEST_GETTEXT_POISON
+    - env: jobname=GETTEXT_POISON
       os: linux
       compiler:
       addons:
diff --git a/ci/lib.sh b/ci/lib.sh
index 5c20975c83..8b39624f3c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -211,7 +211,7 @@ osx-clang|osx-gcc)
 	# Travis CI OS X
 	export GIT_SKIP_TESTS="t9810 t9816"
 	;;
-GIT_TEST_GETTEXT_POISON)
+GETTEXT_POISON)
 	export GIT_TEST_GETTEXT_POISON=true
 	;;
 Linux32)
-- 
2.26.0.334.g6536db25bb

