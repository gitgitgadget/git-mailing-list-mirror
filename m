Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86805C2D0F0
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 15:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1BF20658
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 15:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFZJVXzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbgDAPzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:55:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46522 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732799AbgDAPzf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 11:55:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id q3so108590pff.13
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07EyyNwdFdVGrLCI0PMJK4tI1rF5z6vKTZ5wZr3yar0=;
        b=XFZJVXzS5oWIIoUH/oZ0+rxS07XWDoeveBSmfdUBALk7HelvQzf4s8mjjociESUfCt
         u+tF6UWfGdjgPegsYnGz9/dZUIpgLGuKfJez/kEB4JsVbcj/uVdg6+3AYptUUv2xbcUw
         JGG85LysvlBt5wQ+MzbgzzOgvC73fqfFYXqJq1j4hWBtR7Jlx8DMx5/vvBQPoQNtGwYD
         3WVsvVKK5KEikJTgx0fO8ioy2fBYeiwdRnisPlQ+dGXvWVQ9kmN8oEJTDmfNAs8vyeRS
         IQoNZD18yUvMVSHAlUFyoCtGZqto5/OuxIhmrzIm/Vo3Xdk0A2UAoPEZGRDfs5DHCCiH
         iVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07EyyNwdFdVGrLCI0PMJK4tI1rF5z6vKTZ5wZr3yar0=;
        b=hvPDWRd6Tci+HlT7tY8Eze5dfqmvOTDC+drHB2AyBJDmpeDyNYP129NM6BKIj4a5ZM
         +4S8gEjEFHXKbrfZvDL05oheY6RrNcckKnJD4QRxGr/WIp7b1a4kWpd8OaYsoRsWpI22
         5VlOb8pepd2qssqB4E2B/VJB0Lc1vHhcgPd0eKWD0Di+Z36RB+Zeem4OPS/qc11l/X9B
         Kk9Wt55VKN3tHMAv4cixhY3a2KifCLEFDV+vb53SHhz9KLZKZYuOA4uDa+4jkUgz3XKu
         1I/2cs+T5RFpIeO9BTvCgZUj2jnHEkxFHXECi4GarOcrFE+VxxQjLqgEGUfzg2RdWYqi
         x9YA==
X-Gm-Message-State: AGi0PubzohSUEujvXZzBPc7oxabeFZU05uNh6e28cgfnA6UvhuKsyfQG
        l+NiphFGYxgWolUMhv+XezrxMrF8
X-Google-Smtp-Source: APiQypLvSLz58v8Gq5ftFdFXoJsPpkH4JQ5F1i45FFawEJeWsFD/qnLhCX5K1EkZesYmUulHmxwgWA==
X-Received: by 2002:a63:de51:: with SMTP id y17mr9895431pgi.70.1585756534269;
        Wed, 01 Apr 2020 08:55:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id x4sm1990826pjf.23.2020.04.01.08.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 08:55:33 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 2/6] ci/lib: allow running in GitHub Actions
Date:   Wed,  1 Apr 2020 22:55:04 +0700
Message-Id: <079038c4a7599d269ffa8286d25c0baeb8426b62.1585756350.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585756350.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1585756350.git.congdanhqx@gmail.com>
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
index 766da75063..d2fe02083f 100755
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

