Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF2EC2BBC7
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B4E2145D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz66rFkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgDJRSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:18:42 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39798 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgDJRSl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:18:41 -0400
Received: by mail-pj1-f66.google.com with SMTP id o1so135307pjs.4
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2s8YeHubB8Som9HdzP1bglEbIaOh+D+1TDY/7CiVOUI=;
        b=Wz66rFkz2Wkwaa54gw9sdm/UzRcOuaO0AlyX0HFHPnJvk4k3z6D0Mw8DcDo1Xnl8n0
         powV4Nko38SCRxQ/AZp838LtIEpjjKrUZlU+S7iG88CPB2/Y05PSGGfl1RcBv6g0lIyk
         RjWmPWrJuHm+NgaHoa6NgUttIjpgl175FpNE6dlfj1eLRW6dJGNVu+v3eQgS5EH75IOf
         tUOBnyHs4HyBzbtmgEzEpR6dJectlVrzlogDaVnxRyMZglxyvkeoqeDFefbQq5FsV4x2
         XoPZRv1TtA9/jaDmXtQ6oxfHR3MDNuk1ikWij2l/hZg1FQQ7FiWJfr4vOeWR/xh/x+P5
         gpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2s8YeHubB8Som9HdzP1bglEbIaOh+D+1TDY/7CiVOUI=;
        b=M+rBWDX7fJdBW3UO4hr+ZzhebpIJ+yEPum3a4OCbyuzZ9aR6jOHeBLygmeleRP8W8B
         XZkUfe2fcA+vJQi/RwNro2KY1Jz5glg9PFVhdbpUmrU9NqazfbcD5jn9zLwVvdix2hZB
         xdo+9fN6gsoI2RvrGoEurEwzXa9uHfnGuQKWTRPaztbwX4RaATthOOX4oXoTMoMSUfN/
         Nkse7WXzcLD6Vv0tCWijEqluyqhZ9JKVOlADguWP6J4iZ+Xxst+Ek+j36GzlDon9bglS
         xBf/9rXUnp6vIzi6NCk6KG9rKo9ROTqMm+ZqS+WW7ESsFACu1lcziWG1+gBYa+kVR8DL
         bKzA==
X-Gm-Message-State: AGi0PuZu+oAe2wiA78ju2bIOcalEffxXzZAcWB1SEFzwSG82AX5YoHSe
        Bl/0QmdF04nBXC+JEPj2TNxEdxv1
X-Google-Smtp-Source: APiQypLAPcRNgG4oT4dSyVnzFB/InqMsqU5j2bt73VaU1lGDOrMvcB/VNiCstXPvQlwgPTJbHI497w==
X-Received: by 2002:a17:902:164:: with SMTP id 91mr5412501plb.207.1586539120447;
        Fri, 10 Apr 2020 10:18:40 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s125sm1972897pgc.12.2020.04.10.10.18.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:18:39 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 11/12] ci: add a problem matcher for GitHub Actions
Date:   Sat, 11 Apr 2020 00:18:13 +0700
Message-Id: <3caeb0b7f44d6f034050e3e1a14ed700e6077659.1586538752.git.congdanhqx@gmail.com>
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

