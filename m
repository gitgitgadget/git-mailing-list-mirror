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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0699C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A40E21D7B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVEppYyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407521AbgJTNlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407559AbgJTNlM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 09:41:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B8BC061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so2179998wrm.13
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ty+osmufCYHp5UuwM+HiHearrRr3lEPv9V0tXUxBAZ8=;
        b=qVEppYyOvBYbuWyvWVY92tJ0OnhCnTwKAceYiYRfvS4Z3uJYTKvpGpxNPXhP1uFJNQ
         oi93RcnFkgeGuLMW/QMeojWCd//RUR51GZzt3Lqh5ptod0VxJXzTKpwE8L9yP1vTcqub
         JwE9uyOWPlKrV9YoqohCRx1Ds7obUCP8T7nDoVpAfaA2wFVTr0NT3RtF7sOnCkIwXtb7
         JtzbqnJLB8acSxhc66j8jpNk4E+xIQjzv4PlizJeXGmACU4qy8Ek62wTv/BeXL4FOFCR
         1ZOVNBeJsAJNCc4+2IAIrN494+0df9RAjzzL6nef6yaNCFyYww5WTGeQSQioyMQA4xnl
         MR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ty+osmufCYHp5UuwM+HiHearrRr3lEPv9V0tXUxBAZ8=;
        b=GMPfG55yGcDy8zsI+OSAJBFBtXt7S7fYND6nOJVjlWzowF57lDfttY5DEWMFYBskNx
         V1HhrDtSvocDcvlAkBh7aUGaH9c8bNLrEnQaEOOp6lqyzN7oXl9NbFZJxs5qly+FYOKK
         cWvC/+h32XF6GRhceX8ksRB3SGcvKGLnGE0ED1rj1n8kMAp1djmB6TVxFpyi0To7MEAm
         BygmB8QSQNzF/rkv58YbXh7zR8lmCepMsN84ban7Mp2LqQdiIKEdiDokQl64yaWxoFWU
         eVJv+VwWmoebqEKhuMVW4bXkW1JvgjX2rvdvMXqafJ/iOy5USwv7TVUwWTROgi8nFfQD
         mwDw==
X-Gm-Message-State: AOAM532jDr6224XLTrPt2ieQbA+8/Rt/TrXyXahzb32zqmKQNVloCwE/
        StEQFouuj2ITn1dmFOIaAqyF+raOPoY=
X-Google-Smtp-Source: ABdhPJy1/Ku37mQ+sVmgEDX2TRJFfdxlj9laenijxAirWQXd6r8qWRL5WpDXTYA6YgIL34Bi1Zr+hQ==
X-Received: by 2002:adf:e549:: with SMTP id z9mr3856800wrm.12.1603201270081;
        Tue, 20 Oct 2020 06:41:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm3217266wro.3.2020.10.20.06.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 06:41:09 -0700 (PDT)
Message-Id: <b3ad8faac43f7e499c794b4a9c106f9fcc121281.1603201265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
References: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
        <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Oct 2020 13:41:01 +0000
Subject: [PATCH v4 4/7] t/perf: add fsmonitor perf test for git diff
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

