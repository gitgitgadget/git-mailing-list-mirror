Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ACFC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7613A2240C
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obJOwI9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbgJSWru (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 18:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388637AbgJSWrq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 18:47:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1033C0613D1
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a72so32666wme.5
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kRyxFYsdUp56FTApiMNfeHAgQPCyidPizX4u7iT/YYU=;
        b=obJOwI9to9mqU10H2NdwYnnXrJ18bH8lY6TvG7LATfpRwzbvsgmcjrUw9x86jYGBZK
         OE9p75dX3KAiSVykqJALhQYh4NtXPJWz7iDCbXRYDBhcLIukY19TV9GBJGoYppxDEnBy
         a2KPtcccLtt9Ws/aBE3ajM6l8EgdHgi+NudXZzdkLkonwI7ZWqqlP5/mj0YAUh9lQf7P
         KaUXh0DE8fom6LMumtx4K/agSxFrhsnXi8Eg3HeXE6IRBwxlK0oWW5jtYelzXW8ZCGqD
         gMFROt3g31BJ9PGB7fkPJ5pot5qS7bFYTUNwnEO7aVJhiEVG+vdyEtT2cFicia9/NtWh
         v7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kRyxFYsdUp56FTApiMNfeHAgQPCyidPizX4u7iT/YYU=;
        b=N9jrV+qM6wzyFrcb4GFdLotEjunC4wruQA7rMr+RtxG+nKlB/9+Kromow9/RWAI9k/
         NQ4S/mE/eXbcgnB60zl2gsoAvQeLGz/g0s5VuWxofOCs60V+RCZDoU6aNMnjWXVp1zcB
         5AHD2V3h3gDiFo1W19b22iEnTMEy/9mUno+S13eRKHJo9vY2S6Q1jhlhr0tHJQv6R4Oq
         f/OFmUalsEAx+F7Z4UiFlJk67hr1fRdWIvxnybqXWvIrP0+iwdbD7LgHlzl4/2jx/Ng7
         cKNahAk2ez0QXZ7IQ5CA8iSgm8x/R8Vn9AjNn8g2BWwR/zflLE6PoB+2mK8+Cm97TKAr
         jTvA==
X-Gm-Message-State: AOAM531A6uW3WSx/IvPsCo6xusgcnEp6DHnaB9ImVI10QsJoT8jLyUHE
        iuPeAEr5s2BH8DsCTh9YzTYMfGInmE8=
X-Google-Smtp-Source: ABdhPJy9zsECglZC5pDw4eDySDxIe5zZ2+Ic7/pQqR87yuDaS06aKWaU1Unpgxpfi9jtKdEhwR7IHA==
X-Received: by 2002:a1c:6457:: with SMTP id y84mr103066wmb.36.1603147663335;
        Mon, 19 Oct 2020 15:47:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x64sm45820wmg.33.2020.10.19.15.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:47:42 -0700 (PDT)
Message-Id: <b38f2984f93488d6582eff4865d6d5293491ce60.1603147657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
        <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 22:47:36 +0000
Subject: [PATCH v3 6/7] p7519-fsmonitor: refactor to avoid code duplication
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

