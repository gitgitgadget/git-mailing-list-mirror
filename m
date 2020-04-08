Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B897AC2BA2B
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FB420747
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/WvzZ+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgDHEGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:06:05 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39532 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgDHEGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:06:04 -0400
Received: by mail-pj1-f67.google.com with SMTP id z3so638954pjr.4
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPaFjH3KSipdKUWur4l/zTpSGAbUmVPzhzG653GbFBo=;
        b=t/WvzZ+dtuoDEZkHa+W2iaihgSmyE6oSnU+TYe1niJ0WGqH7NMgYeLL4yUORfqtgkW
         5ZEYF6+g/LxXz+NhHSNOIxjqwn3qtcYCjfo4fGO9YchNT8WZtmRxOAMOHGskvElo0Zjs
         PJtp9cO4vHDUivp1L06o9MNkt/wT9woIy4tf5KH3qQUQXikYLyxyimyahxp+EJrkU/bg
         +DgMtbTlO/+8kFfqmofYFk/hea+xnYn60rkFg9hIjHvSP/qFUO4p19jKvQ3ZnT7vmyBo
         vvhDDzKq9dpVhsUOCTNraTtHongzO5aKiGXJEpbb5A5G6yqEkKKdYEBewElU95Xd0vSX
         SXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPaFjH3KSipdKUWur4l/zTpSGAbUmVPzhzG653GbFBo=;
        b=nNUUBb78lFM4xL45RY7EavMrNwmvuQxGx7kUdrM/6ytct7BMrJPOxo8f/fRatVAK3g
         SkQV0dNW5ubONADL3pvVfJNUzcI0FM2iKYB4Bd8LpBQ3T/nFxLAZVpymXLxLgtJrorcf
         FccviapqRa41+wEycUBxtp0bgPzLjxlkCE3Mq8O14Xpq0DWYUYCE073krSvqivpkgu6M
         I9MBC3yoK0cEYCVbEailYy/yGw0dLPgL8TNnTfr00lFxYvcHfPRWjbv6UvRruQ+iqnZA
         PU94X3gw5SJ7WZNJ4GgX3FJQ7U3jL7lPgGNuTlsIwrf5tIjqXuq7wJyVVg9FRq0Ddd8N
         ezDw==
X-Gm-Message-State: AGi0PuaLyVZ8w6ttzdHONRIsaFHGhv30vuNcgqxVoDH3pSsVt1wIY+OJ
        3vq+RiqqXFvIMRf63RdRcmdYJ55O7nw=
X-Google-Smtp-Source: APiQypJFQ6YYHB/HmhOqYfTTno2a6zUrZhAJfy5Upnm29qecx6avFcpkV4QmT1degiOuzT8ZPZ7gGg==
X-Received: by 2002:a17:90a:8cf:: with SMTP id 15mr3085646pjn.76.1586318761728;
        Tue, 07 Apr 2020 21:06:01 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s9sm2879725pjr.5.2020.04.07.21.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:06:01 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 02/12] ci/lib: allow running in GitHub Actions
Date:   Wed,  8 Apr 2020 11:05:33 +0700
Message-Id: <2818799a4b135db019ac48c59b25032f8cd291ad.1586309211.git.congdanhqx@gmail.com>
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

