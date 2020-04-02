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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37553C2BA15
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F36A2078B
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqdNvQTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbgDBNRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:17:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39473 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbgDBNRc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:17:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id g32so1830879pgb.6
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wfHo2M5Bs1piB7YDILphK9FZxxRBKMm/TnZRbDPLS20=;
        b=NqdNvQTgF3pwvkV5fA9qeMPN12xrlQm5Xgb5TvbibVtJ7p43NxVDcLnx4tAUTNxXlh
         vhJfNMlGU1v/WxE0Aw951SqBiTMxGV5OnUBK6ct4iQietjYZFdcBXZC9g8xXaO7AfM8h
         DU4xbObcDPpICODFqbMIlIS3hzMW5tkGQYGGtl5Fu8Aot5vUggkpOWTUhE+vzynhnyUj
         6eSTv7IrLoZ4ygpN8giQwLDY43vDXEDOZN8ErmgSD9DyUoC4OihrBd38wBcHYdaG4rNs
         Wk2uZnQ50TYYbs/uv4yskpk66ybdqIWiaGI8/DsO5YyXM7SicHzPl/8UeIswRooNATQw
         EmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfHo2M5Bs1piB7YDILphK9FZxxRBKMm/TnZRbDPLS20=;
        b=asQv9o6TYdS5WCrF2OVD95CR24LFQ/r/oz/RTrYRZxhrgs3aWpzYZ5MBePoUGm375Q
         vggOSeBkRd9+GSVY7oC5a4ANXlEjH9rgvS45pc3ijkXHOsPnJFKWgLgUjuJEDJF8CIsB
         D+o37LS4GwOy7nqkjABpqeEQWV70noA2R1Gl3NvOAHpEWkmKTOGIVGYok4epTVRagdxt
         Sa4km7wuMMwBW7T7myV8x8IHC9znd7L3sd0BSTRroOtTn6vJFp0zsnK7dginbocgkbSD
         oYA/IH92JANdqzKVl2rdEy+6Qdf48pNb2ZnJnAEiWwt8mCUWTxHzbbsJu/apE7kchcg4
         flMg==
X-Gm-Message-State: AGi0PuZ4yqSYPAoIxCGPQ+rzihwggL4pwRxFw3Yw387DzvbsDtf58ytt
        dW9QZlMyLXoWannpmlzDCr5E4RsO
X-Google-Smtp-Source: APiQypI55l2m2OfwIiE1/wArgsnJ9dtV1VVEl72yrIscYZyP8ilUO3zshfFUgEPhva9xm6JpBjVfMA==
X-Received: by 2002:a63:a361:: with SMTP id v33mr3222845pgn.324.1585833449161;
        Thu, 02 Apr 2020 06:17:29 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id g18sm3350711pgh.42.2020.04.02.06.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:17:28 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 2/6] ci/lib: allow running in GitHub Actions
Date:   Thu,  2 Apr 2020 20:16:56 +0700
Message-Id: <7a4f646bc1640ffabc5dd01d8c210ce5086d4eb1.1585832999.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585832999.git.congdanhqx@gmail.com>
References: <cover.1585756350.git.congdanhqx@gmail.com> <cover.1585832999.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

For each CI system we support, we need a specific arm in that if/else
construct in ci/lib.sh. Let's add one for GitHub Actions.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/lib.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index bda746df68..f92e3a5211 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -34,7 +34,7 @@ save_good_tree () {
 # successfully before (e.g. because the branch got rebased, changing only
 # the commit messages).
 skip_good_tree () {
-	if test "$TRAVIS_DEBUG_MODE" = true
+	if test "$TRAVIS_DEBUG_MODE" = true || test true = "$GITHUB_ACTIONS"
 	then
 		return
 	fi
@@ -136,6 +136,24 @@ then
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test windows_nt != "$CI_OS_NAME" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+elif test true = "$GITHUB_ACTIONS"
+then
+	CI_TYPE=github-actions
+	CI_BRANCH="$GITHUB_REF"
+	CI_COMMIT="$GITHUB_SHA"
+	CI_OS_NAME="$(echo "$RUNNER_OS" | tr A-Z a-z)"
+	test macos != "$CI_OS_NAME" || CI_OS_NAME=osx
+	CI_REPO_SLUG="$GITHUB_REPOSITORY"
+	CI_JOB_ID="$GITHUB_RUN_ID"
+	CC="${CC:-gcc}"
+
+	cache_dir="$HOME/none"
+
+	export GIT_PROVE_OPTS="--timer --jobs 10"
+	export GIT_TEST_OPTS="--verbose-log -x"
+	MAKEFLAGS="$MAKEFLAGS --jobs=10"
+	test windows != "$CI_OS_NAME" ||
+	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
 	echo "Could not identify CI type" >&2
 	env >&2
-- 
2.26.0.334.g6536db25bb

