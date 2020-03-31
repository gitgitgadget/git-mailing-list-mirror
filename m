Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09C5C2D0EE
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B785620848
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unlOCCUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgCaMsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:48:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41130 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730824AbgCaMsl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 08:48:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id v1so24936919edq.8
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CMEwJOkUItdJQ0xWMHIa6rJf/HsgOG9qk3FLfbQdSiQ=;
        b=unlOCCUb9bsmIicCsfbC24RNHSVahUcRkgF/qEjZi80/x6svIpOX1cmP1zIuWDtU6b
         STJf9FqcH1FT/Z3rr/euSfZcwGpl06ICt9LSt7pJPagWTlrnzw1Gu0i4Y+i7ZguMMhCH
         TEqyBkF4SUJAehWCv1ywCgTHg4oJB8TthexwQ029qjkjFzNVdJci6nuOdXZXLuHcS3Ym
         H/ECwezGO6zZxJ313JS7EREJKRxhI1xHXA/RJgikNTU+QYpOkDOECDKiR9+m4AGi/AqN
         FYFvAmSDStFQlcuUMfM8dOWagM9IwGkROC/1xucC/l8iymkwzY4bX2J2YOwBcaHhObqG
         KOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CMEwJOkUItdJQ0xWMHIa6rJf/HsgOG9qk3FLfbQdSiQ=;
        b=Hc+ZQDOJBsUNznixepumIemubfRBJdO/TEOKAppKGAFP1gY/GOuBxdlDJ7vmrk1BtC
         qSL9RpXJHGInS4/7AgMXxJR0J2JUDRd5YZfvEGmxeGy+nviPTMND2IHg+sHyC2qtQNa5
         i9JC5KRIGAJ7ImuAfj4vtOM43uwX4qe+brZiZUqkNm1jYnplR0xMPEPIXFw0I6w7QtGL
         8gdgQsYD4hZV+Ep3VnkJroHuX8z4aPTjGtPqh0Jxa1G6/hwFkeFKF6lDlh3niUngivv/
         D47TBUxndYYdQiNRAOnzaeZ5+Ixi/dLVkAsmPq5c/cMJe9jHnAmT+2bS7nsj8OzhvmcH
         m4Mg==
X-Gm-Message-State: ANhLgQ1ha+Y09VgRLZ1+alxfNaeWLi8c1tT9+wupQdUWTCgWJ56zt0s2
        3tBkXSOyVQElhdmPQqcIuzFzujr/
X-Google-Smtp-Source: ADFU+vsS8OLe6vyJ3dHxtCBMpH2MXsYGmmCHCRNQAJ9FJYreHU0YuwrVuGgCs+zcWogl/vRluBfW8Q==
X-Received: by 2002:a50:cdda:: with SMTP id h26mr10025260edj.364.1585658915904;
        Tue, 31 Mar 2020 05:48:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm1725723eja.68.2020.03.31.05.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:48:35 -0700 (PDT)
Message-Id: <d9227c87a7bb2872f6a69f48f6a4988f08545d8a.1585658913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Mar 2020 12:48:30 +0000
Subject: [PATCH 2/5] ci/lib: allow running in GitHub Actions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

For each CI system we support, we need a specific arm in that if/else
construct in ci/lib.sh. Let's add one for GitHub Actions.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 8d73551a12f..52e350496a3 100755
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
gitgitgadget

