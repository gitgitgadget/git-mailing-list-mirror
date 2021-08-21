Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070F6C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 04:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFDA61155
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 04:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhHUEEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 00:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhHUEEs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 00:04:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A30C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 21:04:09 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a5so7088895plh.5
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 21:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6qJ5HL1xbyNtPh6XAe/GhGjv8pNlrOJktQ3W/FmQl4=;
        b=FSW0NMdzVu7cyWVdBYPpksZzC6G48N6yMcFp29Y9C7SQxXY0+rflil7i9r/fxOaPDe
         6PLt2N6zyKRJtrVJOvXKncrw4+uWc6mcJSK8WWr7kyK0Tq/gzFw9eWngi8/yvGnk8SS7
         aK1PBrNKxEtzazuYXJ3JBvCUe33w85yRVj/tFkvLq2hLe1a8vjhru91UW3INgOjCaIKH
         5mSQ6FibBSXLKwfIdfWxmaR+bEYTtKZhOwpv6Zfjc5QFke3HYS0ZTZD3v6Gy2RjzOEQB
         P6/guZFMBXNnV3Bl0uMJiLTTFpPuGg3Dm4/Pp2/vXLL5fMjTlxhmKEgobO24krSVS/lV
         3a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6qJ5HL1xbyNtPh6XAe/GhGjv8pNlrOJktQ3W/FmQl4=;
        b=HfdWjZVMVYBeBNxxZCMB2SLkWjkgVco4fhkGD/VG0SMfIdfBwjcEvBzTcZaTZwTU80
         iersgQdOEWUZ8NY6KdN+x4qlyUsrwn4HoAcCgxV8IWrymtU8tMTcOxJWUK6QnFwx4om7
         fYuZRsAGVsEtnBnlX1nwFiPPftsWjRAAMGKNEJ359CgArF8+fV2TLDPbPDaxFuRoAA1E
         2Bl/97KV8yxFV5dnrUNSfxQzvwuCVQT6mK8bZ0d09+yXMUiNxruX2Pfe/sgNN19d/HP0
         fpS5xIJH41cZmv+6EYpsCOEXvU9JsrsWOpBuWJRfTSpoXxeK1hOhnVnjtuSQrumya3Jr
         DoZw==
X-Gm-Message-State: AOAM530T4fMl22pwlULFi92jVk4EIvYCwr0plWbTcTCQe/pXQiDKnya1
        lVBKAIuEcocApxmu6OUBIhOVTvl6B7s=
X-Google-Smtp-Source: ABdhPJzUUlygBqYR/qQm/jF+9TU386dk7V/9LziqoInpOjh3WJAMdH+pcmKmpLFAsEXh2POpdfvaag==
X-Received: by 2002:a17:90a:d595:: with SMTP id v21mr8289738pju.50.1629518648540;
        Fri, 20 Aug 2021 21:04:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:63b8:c1e5:7ba1:cab2:978b:f7f6])
        by smtp.gmail.com with ESMTPSA id m18sm7893776pjq.32.2021.08.20.21.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 21:04:08 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas De Zeeuw <thomas@slight.dev>,
        Carlo Arenas <carenas@gmail.com>
Subject: [PATCH v2] diff-lib: ignore all outsider if --relative asked
Date:   Sat, 21 Aug 2021 11:03:54 +0700
Message-Id: <0d73c7181969d2916d71d7aeb6d788324a0db68b.1629514355.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.33.0.254.g68ee769121
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For diff family commands, we can tell them to exclude changes outside
of some directories if --relative is requested.

In diff_unmerge(), NULL will be returned if the requested path is
outside of the interesting directories, thus we'll run into NULL
pointer dereference in run_diff_files when trying to dereference
its return value.

Checking for return value of diff_unmerge before dereferencing
is not sufficient, though. Since, diff engine will try to work on such
pathspec later.

Let's not run diff on those unintesting entries, instead.
As a side effect, by skipping like that, we can save some CPU cycles.

Reported-by: Thomas De Zeeuw <thomas@slight.dev>
Tested-by: Carlo Arenas <carenas@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
Range-diff against v1:
1:  57a9edc3af ! 1:  0d73c71819 diff-lib: ignore all outsider if --relative asked
    @@ Commit message
         pointer dereference in run_diff_files when trying to dereference
         its return value.
     
    -    We can simply check for NULL there before dereferencing said
    -    return value.  However, we can do better by not running diff
    -    on those unintesting entries.  Let's do that instead.
    +    Checking for return value of diff_unmerge before dereferencing
    +    is not sufficient, though. Since, diff engine will try to work on such
    +    pathspec later.
    +
    +    Let's not run diff on those unintesting entries, instead.
    +    As a side effect, by skipping like that, we can save some CPU cycles.
     
         Reported-by: Thomas De Zeeuw <thomas@slight.dev>
    +    Tested-by: Carlo Arenas <carenas@gmail.com>
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
    -
    - ## Notes ##
    -    Check for return value of diff_unmerge is not enough.
    -
    -    Yes, it works with --name-only, however, with only --relative,
    -    git-diff shows unmerged entries outside of subdir, too.
    -
    -    Furthermore, the filename in "diff --cc" ignores the relative prefix.
    -    Fixing this requires touching all over places, at least from my study.
    -    Let's fix the crash, first.
    -
    -    We have two choices here:
    -
    -    * Check pair, aka return value of diff_unmerge, like my original
    -      suggestion, and the unmerged entries from outside will be shown, too.
    -      Some inconsistent will be observed, --name-only won't list files
    -      outside of subdir, while the patch shows them.  At least, it doesn't
    -      create false impression of no change outside of subdir.
    -
    -    * Skip all outsiders, like this patch.
    -
    -    While I prefer this approach, I don't know all ramifications of this change,
    -    let's say an entry moved to outside of subdir in one side, and modified in
    -    other side.
    -
    -    Because, I pick the different approach, Junio's ack isn't included here.
    -
    -    Cc: Junio C Hamano <gitster@pobox.com>
    -
      ## diff-lib.c ##
     @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
      		if (!ce_path_match(istate, ce, &revs->prune_data, NULL))

 diff-lib.c               |  4 +++
 t/t4045-diff-relative.sh | 53 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index f9eadc4fc1..ca085a03ef 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -117,6 +117,10 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		if (!ce_path_match(istate, ce, &revs->prune_data, NULL))
 			continue;
 
+		if (revs->diffopt.prefix &&
+		    strncmp(ce->name, revs->diffopt.prefix, revs->diffopt.prefix_length))
+			continue;
+
 		if (ce_stage(ce)) {
 			struct combine_diff_path *dpath;
 			struct diff_filepair *pair;
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 61ba5f707f..8cbbe53262 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -162,4 +162,57 @@ check_diff_relative_option subdir file2 true --no-relative --relative
 check_diff_relative_option . file2 false --no-relative --relative=subdir
 check_diff_relative_option . file2 true --no-relative --relative=subdir
 
+test_expect_success 'setup diff --relative unmerged' '
+	test_commit zero file0 &&
+	test_commit base subdir/file0 &&
+	git switch -c br1 &&
+	test_commit one file0 &&
+	test_commit sub1 subdir/file0 &&
+	git switch -c br2 base &&
+	test_commit two file0 &&
+	git switch -c br3 &&
+	test_commit sub3 subdir/file0
+'
+
+test_expect_success 'diff --relative without change in subdir' '
+	git switch br2 &&
+	test_when_finished "git merge --abort" &&
+	test_must_fail git merge one &&
+	git -C subdir diff --relative >out &&
+	test_must_be_empty out &&
+	git -C subdir diff --relative --name-only >out &&
+	test_must_be_empty out
+'
+
+test_expect_success 'diff --relative --name-only with change in subdir' '
+	git switch br3 &&
+	test_when_finished "git merge --abort" &&
+	test_must_fail git merge sub1 &&
+	test_write_lines file0 file0 >expected &&
+	git -C subdir diff --relative --name-only >out &&
+	test_cmp expected out
+'
+
+test_expect_failure 'diff --relative with change in subdir' '
+	git switch br3 &&
+	br1_blob=$(git rev-parse --short --verify br1:subdir/file0) &&
+	br3_blob=$(git rev-parse --short --verify br3:subdir/file0) &&
+	test_when_finished "git merge --abort" &&
+	test_must_fail git merge br1 &&
+	cat >expected <<-EOF &&
+	diff --cc file0
+	index $br3_blob,$br1_blob..0000000
+	--- a/file0
+	+++ b/file0
+	@@@ -1,1 -1,1 +1,5 @@@
+	++<<<<<<< HEAD
+	 +sub3
+	++=======
+	+ sub1
+	++>>>>>>> sub1
+	EOF
+	git -C subdir diff --relative >out &&
+	test_cmp expected out
+'
+
 test_done
-- 
2.33.0.254.g68ee769121

