Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BB1C4363D
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE0721741
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQORHOq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407567AbgJTNlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407566AbgJTNlP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 09:41:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B144C0613D3
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t9so2182341wrq.11
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kRyxFYsdUp56FTApiMNfeHAgQPCyidPizX4u7iT/YYU=;
        b=rQORHOq0x5JswSSucwk3xFomxo0rzukeQ9BQ+ZQJg3abWmlTO/9zvoWwCKuJ1LCn8l
         Lhren33qh0jMFY+Dn2r3ga3Irk6xnnPPlvDBNodgZjBV45qOuS99bloXkR8V8u9K6awc
         zM66fEsmaZ2jT4zhtfGo+jOiTiPHA7bP9LuJC9SaeUL7o6E1NqqrpviQb04hEEvv84WD
         oLjs5N45XX2C8n9yH/jo80aik4HPqVi0XL6eMBWZcgzNo9vDhw3gtLnS0iRUl53Nqr/N
         pEUDvJL6xmOymM5yiqzeS/3G4AlgHJSNmrEtNlhBuGS0d0+KtXVxFGmgic/vQ0eIDJlP
         oBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kRyxFYsdUp56FTApiMNfeHAgQPCyidPizX4u7iT/YYU=;
        b=PaFWLy3vTL2V/6l50oGtXYYbhxGq4dICbK4jlxtbRs5zTRKj07jU8RM5JPxz+6011I
         UQixYCZMSEW1sVTn97wjsztbPxh6Ppx9K27EiF6skgEzeoHvKadYZ09ZZJqMBJk4Oxfr
         7x66goCsXcklebtJwvP9ibq3d+YNvEZf1pvVfgMnKiJoLiMIoG3JEg1c9Ib7ONeXLn2a
         XmkWRlsTWvaR0lJjwwvVVPQr3L1Yy2seDb7DKw/F7tGBUhPzsvrt4ZiZfppVpL56dGgz
         lGWKJ6FNnrURBvM5CXV2QaLLxhnvaxFwiblfdlJz2x1eJA/9El8qUtzwniAaB/vO0Wly
         ujgA==
X-Gm-Message-State: AOAM533UPHklFBMCKnWQB0EoP/KaK7QVKfgvl714lZGbv/LbwCSUIEuL
        O0USSb+lnYWqG1ACtulqL7/WcSnTpeI=
X-Google-Smtp-Source: ABdhPJyX621cWNnuamr2DkoSXEao67woFGkr0lylnJh1xgLf+22AvqJw0N245JvILq5ywnlFOB7r6A==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr3444284wrr.377.1603201271907;
        Tue, 20 Oct 2020 06:41:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14sm2376057wrx.22.2020.10.20.06.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 06:41:11 -0700 (PDT)
Message-Id: <3b20f4c76e31e101da99f8f3e2933ea49b95c6ab.1603201265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
References: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
        <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Oct 2020 13:41:03 +0000
Subject: [PATCH v4 6/7] p7519-fsmonitor: refactor to avoid code duplication
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Much of the benchmark code is redundant. This is
easier to understand and edit.

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 136 +++++++++++---------------------------
 1 file changed, 37 insertions(+), 99 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index ef4c3c8c5c..75a0cef01d 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -125,61 +125,53 @@ test_expect_success "setup for fsmonitor" '
 	git status  # Warm caches
 '
 
-if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-tool drop-caches
-fi
+test_perf_w_drop_caches () {
+	if test -n "$GIT_PERF_7519_DROP_CACHE"; then
+		test-tool drop-caches
+	fi
 
-test_perf "status (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git status
-'
+	test_perf "$@"
+}
 
-if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-tool drop-caches
-fi
+test_fsmonitor_suite() {
+	test_perf_w_drop_caches "status (fsmonitor=$INTEGRATION_SCRIPT)" '
+		git status
+	'
 
-test_perf "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git status -uno
-'
+	test_perf_w_drop_caches "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
+		git status -uno
+	'
 
-if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-tool drop-caches
-fi
+	test_perf_w_drop_caches "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
+		git status -uall
+	'
 
-test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git status -uall
-'
-
-if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-tool drop-caches
-fi
-
-test_perf "diff (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git diff
-'
+	test_perf_w_drop_caches "diff (fsmonitor=$INTEGRATION_SCRIPT)" '
+		git diff
+	'
 
-if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-tool drop-caches
-fi
+	test_perf_w_drop_caches "diff -- 0_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+		git diff -- 1_file
+	'
 
-test_perf "diff -- 0_files (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git diff -- 1_file
-'
+	test_perf_w_drop_caches "diff -- 10_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+		git diff -- 10_files
+	'
 
-test_perf "diff -- 10_files (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git diff -- 10_files
-'
+	test_perf_w_drop_caches "diff -- 100_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+		git diff -- 100_files
+	'
 
-test_perf "diff -- 100_files (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git diff -- 100_files
-'
+	test_perf_w_drop_caches "diff -- 1000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+		git diff -- 1000_files
+	'
 
-test_perf "diff -- 1000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git diff -- 1000_files
-'
+	test_perf_w_drop_caches "diff -- 10000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+		git diff -- 10000_files
+	'
+}
 
-test_perf "diff -- 10000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git diff -- 10000_files
-'
+test_fsmonitor_suite
 
 test_expect_success "setup without fsmonitor" '
 	unset INTEGRATION_SCRIPT &&
@@ -187,61 +179,7 @@ test_expect_success "setup without fsmonitor" '
 	git update-index --no-fsmonitor
 '
 
-if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-tool drop-caches
-fi
-
-test_perf "status (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git status
-'
-
-if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-tool drop-caches
-fi
-
-test_perf "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git status -uno
-'
-
-if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-tool drop-caches
-fi
-
-test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git status -uall
-'
-
-if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-tool drop-caches
-fi
-
-test_perf "diff (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git diff
-'
-
-if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-tool drop-caches
-fi
-
-test_perf "diff -- 0_files (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git diff -- 1_file
-'
-
-test_perf "diff -- 10_files (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git diff -- 10_files
-'
-
-test_perf "diff -- 100_files (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git diff -- 100_files
-'
-
-test_perf "diff -- 1000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git diff -- 1000_files
-'
-
-test_perf "diff -- 10000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
-	git diff -- 10000_files
-'
+test_fsmonitor_suite
 
 if test_have_prereq WATCHMAN
 then
-- 
gitgitgadget

