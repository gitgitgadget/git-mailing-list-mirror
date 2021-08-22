Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC7DC4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 08:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A61361250
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 08:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhHVIuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 04:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhHVIuT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 04:50:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011FDC061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 01:49:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so10106828pjb.3
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JZJGHmKWW/ZHwQQNDXsxGnhWZhLMdSb83e7/ThSRbc=;
        b=u+R5j+puGdg8t7gJHP6m2eXTgybqTAKATTcPmtRxIBdoBi28I5q9hgzetyGWDRp6h4
         hxe3/4ScB7AsNKgz+SB10Gk92ffP9QCsqKVliqLsFICYHsXNnJqW4NXcHqyY3TN468LZ
         zk143YU74R2Hm+PhChIIUfJ29sswLZsG5KnBVde9Pe0ZQqmUhYB14AAya9AbHJl4smW8
         P65eCpEF8iU2B4Z7KTDZ6pMvbqmS6ZmpzU5pWzJaoAigapqiGoB2IPIStMgn5W4hGxgV
         2Z/Zy8Ux+ZnLejJZ64h5QDe7Atiw97irrgz59s3KcjrP1NMctcD96ABbdpVn26NJmepk
         bfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JZJGHmKWW/ZHwQQNDXsxGnhWZhLMdSb83e7/ThSRbc=;
        b=t8ut7ZL4O77n9KxPbIAoMUEy5bBe5t6Vfg0DVPVos+qnOkbTpdaWRvsZ1cu3GoyblT
         Rsjz7/PY5lFLqq3FLfcAhdnuI6l0FvMQkxD0x4jDAOCxc7pn1J/6iv1WuEKwL1NMmWLF
         5bOa0SsISNd5ZVVWlkIx220mKxuIkYdB18UEmNc16zZjed5FILRMSj2/J1zIOKfSd1RA
         PkK4qF+ofILJbegpX+/5EWRfWsmeEx0P/8MKq0OU8qGXIqm/ZYP3ZbLDKnZcm0BYjR8v
         5CZni+Mms39Ep0W8rbp04cQBWH1FG5W55rgTQ0cSnfaeKKm2ECyRSG8Aris7ZqtLt0/E
         tdgg==
X-Gm-Message-State: AOAM533zJ0lf7jEdA33gSd5VOQ6hfM4/R0GVuHisuA6f6qD45A4bek1Z
        q9zp8NHXdNqe9k11EDns5+3ur8U4kXM=
X-Google-Smtp-Source: ABdhPJwXk4JUekW/MNsUt0VrY4gjeAKMEMRKrAVmXNfRMTv+w/EjrGIvLB1nZg5Ds9oPxf8swRCduQ==
X-Received: by 2002:a17:90b:1d88:: with SMTP id pf8mr13682679pjb.152.1629622178211;
        Sun, 22 Aug 2021 01:49:38 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:c1e5:7ba1:cab2:978b:f7f6])
        by smtp.gmail.com with ESMTPSA id b190sm14325551pgc.91.2021.08.22.01.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 01:49:37 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas De Zeeuw <thomas@slight.dev>,
        Carlo Arenas <carenas@gmail.com>
Subject: [PATCH v3] diff-lib: ignore all outsider if --relative asked
Date:   Sun, 22 Aug 2021 15:49:08 +0700
Message-Id: <a140b292f94de9f4d96f79f3817ed7d2d609c7ba.1629621310.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.33.0.254.g68ee769121
In-Reply-To: <0d73c7181969d2916d71d7aeb6d788324a0db68b.1629514355.git.congdanhqx@gmail.com>
References: <0d73c7181969d2916d71d7aeb6d788324a0db68b.1629514355.git.congdanhqx@gmail.com>, <40BE2EF2-0AF3-45BA-9880-8A6011B38D03@slight.dev>, <bc7eda4ed8d52072b929a4af6e4e4ed7478ef9d6.1629361733.git.congdanhqx@gmail.com>
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

Sorry for the noise, I need to send v3, because:

Change in v3 from v2:
 Fix the conflict marker in failure test. Originally, I wrote the test with:
 "git merge sub1" not "git merge br1"

Range-diff against v2:
1:  0d73c71819 ! 1:  a140b292f9 diff-lib: ignore all outsider if --relative asked
    @@ t/t4045-diff-relative.sh: check_diff_relative_option subdir file2 true --no-rela
     +	 +sub3
     +	++=======
     +	+ sub1
    -+	++>>>>>>> sub1
    ++	++>>>>>>> br1
     +	EOF
     +	git -C subdir diff --relative >out &&
     +	test_cmp expected out

Range-diff of v2 against v1:
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
index 61ba5f707f..fab351b48a 100755
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
+	++>>>>>>> br1
+	EOF
+	git -C subdir diff --relative >out &&
+	test_cmp expected out
+'
+
 test_done
-- 
2.33.0.254.g68ee769121

