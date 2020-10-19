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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED035C433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F31A223FD
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx7YbfWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbgJSWrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 18:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388615AbgJSWro (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 18:47:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CF7C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c194so40881wme.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ty+osmufCYHp5UuwM+HiHearrRr3lEPv9V0tXUxBAZ8=;
        b=kx7YbfWd4ApOzpQRIyfPn0rxM/jNp16OBC/D8CGummib+DpFSPJSzYtXXWIdxSFRZj
         A3DNOgKnH0Xrkq5ALj0jLyxVoma64xxXxojo3Mu36YhonfAF4ROZl7DeNUk/aH35fp9j
         Wat6MoL7KHvRd8xLplH8Dspy8Fu9dPSKjfKyMos0rbnpucVtvtB6TdIICl52DgGZ5FSE
         TMHNfQXZgcfBr2DiMwb6cXYMnPm6mn0mIWJogiSpqPueGzcwmTssRJZo09CaSYXOyXja
         ElPRoQf81ImTwKeZzC94ooHnpS7pAykqhqUIV7LHE64XlrN8h3M8ww38UWXesvS9n/FY
         v/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ty+osmufCYHp5UuwM+HiHearrRr3lEPv9V0tXUxBAZ8=;
        b=JnreQBtTe3YEBV6cujkpLBRMTWCu5Lx50NnQUckVznQaAfcoiGSMrXum3oeeP+3Dsm
         tyoViYQ7AnC9i6Fd/21AoOw5/5oWDqDg6iyNb1Y85jI0aZrLZvMKuEerY1i3ep528MYc
         tdir9z5VqsmTDBgYzxUAfaD2o4FGtsiAFvInSmJeL8cdU1ifoBe+yAIFZpCtUKYO/DaM
         V1xtFXiurSQ+k7cafmrHmf+RlA8MJw7OkSI8aF4+MU+iqRoTMtlcJvpkOWIPMRoubfEl
         Zn1spSVgfhJhpgTcGYfpZJZc4cuui3Q4q7bStMGlGX71sPQF2+N4uSE4U926iCVUQPLo
         iTQw==
X-Gm-Message-State: AOAM5316wLsnbyN5njL9qYECubjuwvE12ykIoAFMqNwhPEaNU1GPoAHy
        eVGX5QVEjs1NfCKegp9zpWQ0ptF3VaA=
X-Google-Smtp-Source: ABdhPJzYVj0eBSHymWO4eqOclhsgA161ezqkgu1d87wj+LKnKgPhLkh9FesZzeRUCxDErYtTOJ+Xhg==
X-Received: by 2002:a1c:b657:: with SMTP id g84mr104244wmf.0.1603147661926;
        Mon, 19 Oct 2020 15:47:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7sm75684wmh.6.2020.10.19.15.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:47:41 -0700 (PDT)
Message-Id: <b3ad8faac43f7e499c794b4a9c106f9fcc121281.1603147657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
        <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 22:47:34 +0000
Subject: [PATCH v3 4/7] t/perf: add fsmonitor perf test for git diff
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

Results for the git-diff fsmonitor optimization
in patch in the parent-rev (using a 400k file repo to test)

As you can see here - git diff with fsmonitor running is
significantly better with this patch series (80% faster on my
workload)!

GIT_PERF_LARGE_REPO=~/src/server ./run v2.29.0-rc1 . -- p7519-fsmonitor.sh

Test                                                                     v2.29.0-rc1       this tree
-----------------------------------------------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)                 1.46(0.82+0.64)   1.47(0.83+0.62) +0.7%
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)            0.16(0.12+0.04)   0.17(0.12+0.05) +6.3%
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)           1.36(0.73+0.62)   1.37(0.76+0.60) +0.7%
7519.5: diff (fsmonitor=.git/hooks/fsmonitor-watchman)                   0.85(0.22+0.63)   0.14(0.10+0.05) -83.5%
7519.6: diff -- 0_files (fsmonitor=.git/hooks/fsmonitor-watchman)        0.12(0.08+0.05)   0.13(0.11+0.02) +8.3%
7519.7: diff -- 10_files (fsmonitor=.git/hooks/fsmonitor-watchman)       0.12(0.08+0.04)   0.13(0.09+0.04) +8.3%
7519.8: diff -- 100_files (fsmonitor=.git/hooks/fsmonitor-watchman)      0.12(0.07+0.05)   0.13(0.07+0.06) +8.3%
7519.9: diff -- 1000_files (fsmonitor=.git/hooks/fsmonitor-watchman)     0.12(0.09+0.04)   0.13(0.08+0.05) +8.3%
7519.10: diff -- 10000_files (fsmonitor=.git/hooks/fsmonitor-watchman)   0.14(0.09+0.05)   0.13(0.10+0.03) -7.1%
7519.12: status (fsmonitor=)                                             1.67(0.93+1.49)   1.67(0.99+1.42) +0.0%
7519.13: status -uno (fsmonitor=)                                        0.37(0.30+0.82)   0.37(0.33+0.79) +0.0%
7519.14: status -uall (fsmonitor=)                                       1.58(0.97+1.35)   1.57(0.86+1.45) -0.6%
7519.15: diff (fsmonitor=)                                               0.34(0.28+0.83)   0.34(0.27+0.83) +0.0%
7519.16: diff -- 0_files (fsmonitor=)                                    0.09(0.06+0.04)   0.09(0.08+0.02) +0.0%
7519.17: diff -- 10_files (fsmonitor=)                                   0.09(0.07+0.03)   0.09(0.06+0.05) +0.0%
7519.18: diff -- 100_files (fsmonitor=)                                  0.09(0.06+0.04)   0.09(0.06+0.04) +0.0%
7519.19: diff -- 1000_files (fsmonitor=)                                 0.09(0.06+0.04)   0.09(0.05+0.05) +0.0%
7519.20: diff -- 10000_files (fsmonitor=)                                0.10(0.08+0.04)   0.10(0.06+0.05) +0.0%

I also added a benchmark for a tiny git diff workload w/ a pathspec.
I see an approximately .02 second overhead added w/ and w/o fsmonitor

From looking at these results, I suspected that refresh_fsmonitor
is already happening during git diff - independent of this patch
series' optimization. Confirmed that suspicion by breaking on
refresh_fsmonitor.

(gdb) bt  [simplified]
0  refresh_fsmonitor  at fsmonitor.c:176
1  ie_match_stat  at read-cache.c:375
2  match_stat_with_submodule at diff-lib.c:237
4  builtin_diff_files  at builtin/diff.c:260
5  cmd_diff  at builtin/diff.c:541
6  run_builtin  at git.c:450
7  handle_builtin  at git.c:700
8  run_argv  at git.c:767
9  cmd_main  at git.c:898
10 main  at common-main.c:52

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 71 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 9313d4a51d..ef4c3c8c5c 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -115,6 +115,13 @@ test_expect_success "setup for fsmonitor" '
 
 	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
 	git update-index --fsmonitor &&
+	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
+	for i in $(test_seq 1 10); do touch 10_files/$i; done &&
+	for i in $(test_seq 1 100); do touch 100_files/$i; done &&
+	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
+	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
+	git add 1_file 10_files 100_files 1000_files 10000_files &&
+	git commit -m "Add files" &&
 	git status  # Warm caches
 '
 
@@ -142,6 +149,38 @@ test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
 	git status -uall
 '
 
+if test -n "$GIT_PERF_7519_DROP_CACHE"; then
+	test-tool drop-caches
+fi
+
+test_perf "diff (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff
+'
+
+if test -n "$GIT_PERF_7519_DROP_CACHE"; then
+	test-tool drop-caches
+fi
+
+test_perf "diff -- 0_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff -- 1_file
+'
+
+test_perf "diff -- 10_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff -- 10_files
+'
+
+test_perf "diff -- 100_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff -- 100_files
+'
+
+test_perf "diff -- 1000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff -- 1000_files
+'
+
+test_perf "diff -- 10000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff -- 10000_files
+'
+
 test_expect_success "setup without fsmonitor" '
 	unset INTEGRATION_SCRIPT &&
 	git config --unset core.fsmonitor &&
@@ -172,6 +211,38 @@ test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
 	git status -uall
 '
 
+if test -n "$GIT_PERF_7519_DROP_CACHE"; then
+	test-tool drop-caches
+fi
+
+test_perf "diff (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff
+'
+
+if test -n "$GIT_PERF_7519_DROP_CACHE"; then
+	test-tool drop-caches
+fi
+
+test_perf "diff -- 0_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff -- 1_file
+'
+
+test_perf "diff -- 10_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff -- 10_files
+'
+
+test_perf "diff -- 100_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff -- 100_files
+'
+
+test_perf "diff -- 1000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff -- 1000_files
+'
+
+test_perf "diff -- 10000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff -- 10000_files
+'
+
 if test_have_prereq WATCHMAN
 then
 	watchman watch-del "$GIT_WORK_TREE" >/dev/null 2>&1 &&
-- 
gitgitgadget

