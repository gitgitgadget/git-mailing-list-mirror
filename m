Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04791C2BB54
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE232074F
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa2GgXNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgDHEGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:06:20 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:34494 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgDHEGR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:06:17 -0400
Received: by mail-pj1-f48.google.com with SMTP id q16so1772657pje.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2s8YeHubB8Som9HdzP1bglEbIaOh+D+1TDY/7CiVOUI=;
        b=Pa2GgXNpOQAwDKiJh7+wFPqW0QuSA5BdfP2JUOd6IOb9hsZQQ8+Q8URdoznIZRh6dE
         GSE7CNj8fvQpCPrvA8VgFgUeAgSQXfciX5Q0lb5Jg302Uap+k9CIon7QJ9+dNXZO56Hh
         Ysm/s6Ir2t9aCIfyP6GOW8VKxQqVYQvn9qEoYaumHJ1IsS1Mn63L9vFdyj0vGkZUmFIX
         ZB3z5JqoMqi5ZuWeGpUdNUY1dbGlyGHgxg6I1afuX8s6vMx6ETGeTILancjMfnNV+NDu
         QSzc7BdXwFxEcsfuVeOFxrNBH+erT05gB9nlvIKLkL/cBm3+hMqXWaVm6du1Os2NWyja
         fE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2s8YeHubB8Som9HdzP1bglEbIaOh+D+1TDY/7CiVOUI=;
        b=cP1xeNxBwMyz+N5WSkF7sAM6/0R7++/6ZBDXfWJ88WP/fyV4GISY3UG1ckswIc7lDX
         LVb7acq4H/fZyrQT0MYlganWAelc/ao90mG5YfZLcZTsWd1vjq6jm+v7Qo5JMfhcB8CW
         KO7VOzHrIgiGSKyQndnfprUVALQZ5JH7GoP8yvu257jjS3D1vTi+LggfMdYWb9CwsGZX
         Gax4r2kp5fr6cvoSlMlPJ3bVCWaass8Ubzd5Vge5MiI1ZMcZ+0ng2GqbFBkrbAUZNkjl
         xdbFike3tYf1qA481qwfMT99WzbrFe/maLSmyxwLAUb0sF78m4m3Cc8ifBq15jJ6Ty1v
         uzZQ==
X-Gm-Message-State: AGi0PuY6BY4MgkphJv0g0Mepbtr3XpQggfrXwGJu8lkZ4AMbmZRzhKpZ
        sbDKIQNNL981m5fekbucuPVKm2FtCl8=
X-Google-Smtp-Source: APiQypJmg7AL7OkitRDDsqUmBjjasPBD42wd55wqsgcfXsXJpMI2WDLGVl6tvhaYqzfoFnEe8uy1bg==
X-Received: by 2002:a17:90a:be0b:: with SMTP id a11mr3084521pjs.56.1586318776460;
        Tue, 07 Apr 2020 21:06:16 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s9sm2879725pjr.5.2020.04.07.21.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:06:16 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 11/12] ci: add a problem matcher for GitHub Actions
Date:   Wed,  8 Apr 2020 11:05:42 +0700
Message-Id: <715d1f732fd9ee475dd18d28f1b0801abe223d8c.1586309211.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586309211.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586309211.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With this patch, test failures will be annotated with a helpful,
clickable message in GitHub Actions. For details, see
https://github.com/actions/toolkit/blob/master/docs/problem-matchers.md

Note: we need to set `TEST_SHELL_PATH` to Bash so that the problem
matcher is fed a file and line number for each test failure.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/git-problem-matcher.json | 16 ++++++++++++++++
 ci/lib.sh                   |  5 +++++
 2 files changed, 21 insertions(+)
 create mode 100644 ci/git-problem-matcher.json

diff --git a/ci/git-problem-matcher.json b/ci/git-problem-matcher.json
new file mode 100644
index 0000000000..506dfbd97f
--- /dev/null
+++ b/ci/git-problem-matcher.json
@@ -0,0 +1,16 @@
+{
+    "problemMatcher": [
+        {
+            "owner": "git-test-suite",
+            "pattern": [
+                {
+                    "regexp": "^([^ :]+\\.sh):(\\d+): (error|warning|info):\\s+(.*)$",
+                    "file": 1,
+                    "line": 2,
+                    "severity": 3,
+                    "message": 4
+                }
+            ]
+        }
+    ]
+}
diff --git a/ci/lib.sh b/ci/lib.sh
index 8b39624f3c..4c54540fa8 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -157,6 +157,11 @@ then
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test windows != "$CI_OS_NAME" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+
+	# https://github.com/actions/toolkit/blob/master/docs/commands.md#problem-matchers
+	echo "::add-matcher::ci/git-problem-matcher.json"
+	test linux-musl = "$jobname" ||
+	MAKEFLAGS="$MAKEFLAGS TEST_SHELL_PATH=/bin/sh"
 else
 	echo "Could not identify CI type" >&2
 	env >&2
-- 
2.26.0.334.g6536db25bb

