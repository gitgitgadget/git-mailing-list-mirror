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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784F4C2BB86
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514922087E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1aDkdWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDJRS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:18:29 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53171 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgDJRS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:18:27 -0400
Received: by mail-pj1-f65.google.com with SMTP id ng8so1004885pjb.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPaFjH3KSipdKUWur4l/zTpSGAbUmVPzhzG653GbFBo=;
        b=P1aDkdWhimy4BXSs/PbSKN5w3iigXF0cpsXm0mE3ATu5fzXmqEgAfyKdXUOA3V+YwZ
         rEo24tWJybrEhRJA/OOlSaG2sKdwwLCkbWbvjv6aa7QLDbGOjNyCHpzquhGtuR0YmBbX
         UN44YHoA9x0sa+3ItWen22CljD3LKS6PvMhVnne8bJJTuRLeDtMOu6g8ngxgjXBfz5lo
         rWeIZnfvTqnNVDC8gS0Re1KRQw4HLMmMcTrjNmb3iX9uuK/tCLD6F86LyHfIvv6wpom3
         XUT3QVt5ywb9t2qHAPEtzVeBZpFO8fnMn7c5EK0AYk+0PgKTGGx/MdsBojd4DjRYuVVu
         Af4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPaFjH3KSipdKUWur4l/zTpSGAbUmVPzhzG653GbFBo=;
        b=ndoaFmsSTaJI5rec6ByQ7tgAzd06P+QGFPqvh/3zCaOB0qCOJ5rjb2usofv5ac15wP
         nYp4mf0lkBjRYuOmjbKL2vDBycp+3lUDhnayEnjtQdTl8SnZvfnmgJFqtBtweAH5GUHY
         atpDi41nJmeKqQaWXR7OVFMmWz3KnauFjnBG1LmIqjC7xkHp7snUy56JaglHOJrAOt9v
         Cd0dB4t39bMES8zqGCrbNA3bMZ/ArD88+GXL7O80bdnrnNtf/7HFitZBztISUBdpxTww
         cm/7xflCs1yPOj764yIPrOAnx4mdUI45XSItlwCPDahIlJ/Hdd7JUokJDk0tAwBiotbd
         fFhw==
X-Gm-Message-State: AGi0PubJc9g/hK/E9QPeOhtKqTgWoIDysebPjYOLb1fSpRVifVWZ8DXY
        KLqgFiaG+wzb+VaWxseKiytHl3+h
X-Google-Smtp-Source: APiQypIoL12km9Ag2TMJb2N+4u/rtUWCEQG9VDIHD0QDVaMkaUPn0CwKkJW7NAo/FUR+6vmC7G04Tg==
X-Received: by 2002:a17:90a:e7d0:: with SMTP id kb16mr5944052pjb.97.1586539104792;
        Fri, 10 Apr 2020 10:18:24 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s125sm1972897pgc.12.2020.04.10.10.18.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:18:24 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 02/12] ci/lib: allow running in GitHub Actions
Date:   Sat, 11 Apr 2020 00:18:04 +0700
Message-Id: <2818799a4b135db019ac48c59b25032f8cd291ad.1586538752.git.congdanhqx@gmail.com>
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

For each CI system we support, we need a specific arm in that if/else
construct in ci/lib.sh. Let's add one for GitHub Actions.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/lib.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 05fbcf681a..a21c6241b0 100755
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

