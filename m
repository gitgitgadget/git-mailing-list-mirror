Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D667BC433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiBKU5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353605AbiBKU4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:52 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D55D7F
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s10so3657854wrb.1
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Za70ts0UZ+BqPtvwTDEzkC9JFBKIEH+cGjDvbB/L0jw=;
        b=bFzLP9MV97Nqmd6JYuV3BY8xxoePvFe98OQtZtPUTl7DCra7agORqyA3QWdCVKPK3e
         R/1SGa3rNdtWfKMosvGSNv7g/HCcP4GsPMC87NMtZDqOAZCc50X+t59jiVQANize7mDm
         6rGb8A1TpIaxlQC/hfSoZLn8O4qhSSrIuJAbrWsNtRFm2dwVgske0SS0qy9WRJ8z7KsH
         nQFfqA2Xt6M4q+smyNKUsfxotsn+9va9FL2CN2/Wo52YRBguKJKMqAgsi6TOO/OnkDkq
         WXjOAsQM0OjnW8nlFoEVP7ut4XvYrJozFL/uFm7qcj2UtIVWrQcRMg2DE/e42CCVb2TY
         rWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Za70ts0UZ+BqPtvwTDEzkC9JFBKIEH+cGjDvbB/L0jw=;
        b=tCvMuVBGGyZxv23wBj09MzFbLCO0kKrK80eQAiGQDF/2Y5IavAGjg3n76mzhfyu8we
         6Fdf3tJBdr0Sw6WDNHHC1cgif4nEO0vlkCnmOt4ix0IxjiiNAIO+IvM/3y43NE+ZP1PV
         nWMySz9KfemoAkvFAzZvVwNT78s+KwPcv8nNcxhBs/wtJgNqDLgzgYgH/Oe6WOViNORw
         3ENsxdsA7qNZCaD4EfJj66QvYvddLp9LlAxaX9FUSjS0o+D9vkmI3MyOV+RBywPaITP7
         8DHQTOZljKp8n+vhkxo9b72u0VnH8du8gDuhE8mEulwTqCSIdMRqRTe23qWXCGy5+XM+
         FzKg==
X-Gm-Message-State: AOAM532WfKmfgJ0AzVxtDE5e2AIDqft/DEVQ7Xry7Ttfmg5xn5thfIPC
        kl5YNql81R44B8PP7q/XPtDMklZv07s=
X-Google-Smtp-Source: ABdhPJz9MrGz26/fqtSnG5oyty/bdx1HM7/0qwHQWxB6mcYaf3ZsWPUg8rvjDUBo7FuciZsB/BpKCA==
X-Received: by 2002:a5d:4d08:: with SMTP id z8mr2741358wrt.492.1644613000862;
        Fri, 11 Feb 2022 12:56:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4sm14547131wrw.100.2022.02.11.12.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:40 -0800 (PST)
Message-Id: <fcf843a0d42f3a6b1d226b42014835c3e410fc7d.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:13 +0000
Subject: [PATCH v5 24/30] t/perf/p7519: speed up test on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Change p7519 to use `test_seq` and `xargs` rather than a `for` loop
to touch thousands of files.  This takes minutes off of test runs
on Windows because of process creation overhead.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index c8be58f3c76..054fc8d5d1d 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -72,7 +72,7 @@ then
 	fi
 fi
 
-trace_start() {
+trace_start () {
 	if test -n "$GIT_PERF_7519_TRACE"
 	then
 		name="$1"
@@ -91,13 +91,20 @@ trace_start() {
 	fi
 }
 
-trace_stop() {
+trace_stop () {
 	if test -n "$GIT_PERF_7519_TRACE"
 	then
 		unset GIT_TRACE2_PERF
 	fi
 }
 
+touch_files () {
+	n=$1
+	d="$n"_files
+
+	(cd $d ; test_seq 1 $n | xargs touch )
+}
+
 test_expect_success "one time repo setup" '
 	# set untrackedCache depending on the environment
 	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
@@ -119,10 +126,11 @@ test_expect_success "one time repo setup" '
 	fi &&
 
 	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
-	for i in $(test_seq 1 10); do touch 10_files/$i || return 1; done &&
-	for i in $(test_seq 1 100); do touch 100_files/$i || return 1; done &&
-	for i in $(test_seq 1 1000); do touch 1000_files/$i || return 1; done &&
-	for i in $(test_seq 1 10000); do touch 10000_files/$i || return 1; done &&
+	touch_files 1 &&
+	touch_files 10 &&
+	touch_files 100 &&
+	touch_files 1000 &&
+	touch_files 10000 &&
 	git add 1_file 10_files 100_files 1000_files 10000_files &&
 	git commit -qm "Add files" &&
 
@@ -133,7 +141,7 @@ test_expect_success "one time repo setup" '
 	fi
 '
 
-setup_for_fsmonitor() {
+setup_for_fsmonitor () {
 	# set INTEGRATION_SCRIPT depending on the environment
 	if test -n "$INTEGRATION_PATH"
 	then
@@ -173,7 +181,7 @@ test_perf_w_drop_caches () {
 	test_perf "$@"
 }
 
-test_fsmonitor_suite() {
+test_fsmonitor_suite () {
 	if test -n "$INTEGRATION_SCRIPT"; then
 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
 	else
@@ -199,15 +207,15 @@ test_fsmonitor_suite() {
 
 	# Update the mtimes on upto 100k files to make status think
 	# that they are dirty.  For simplicity, omit any files with
-	# LFs (i.e. anything that ls-files thinks it needs to dquote).
-	# Then fully backslash-quote the paths to capture any
-	# whitespace so that they pass thru xargs properly.
+	# LFs (i.e. anything that ls-files thinks it needs to dquote)
+	# and any files with whitespace so that they pass thru xargs
+	# properly.
 	#
 	test_perf_w_drop_caches "status (dirty) ($DESC)" '
 		git ls-files | \
 			head -100000 | \
 			grep -v \" | \
-			sed '\''s/\(.\)/\\\1/g'\'' | \
+			egrep -v " ." | \
 			xargs test-tool chmtime -300 &&
 		git status
 	'
-- 
gitgitgadget

