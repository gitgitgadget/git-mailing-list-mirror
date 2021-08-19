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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82554C432BE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 08:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C8A66113C
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 08:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbhHSIaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbhHSIaB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 04:30:01 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA594C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 01:29:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id o2so5190792pgr.9
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ewlaK7KfwfeQA8a2+RRVtJNZTxO5Fg9rROGsXcCNq9g=;
        b=i9KQ8I91W4zCKtCduF68QxxkmTZcgY65JSaEJWi20AABDLkQENlbwJ6nGrSrht0GWt
         eTk4rlAAnvavzSqYNcgkfFbeoB6Ej4BKFLUzuuIqDDEfG/dIRZuQB10SPqTB9Ot733Bl
         bm7Z+ICJlMDJQPudYzET+ayjPHs4C+VVx9qEeIw/yk3dMYaUssZAuzH7mU/0i8vrlcMb
         +oZboXiiOcDUQWKGJkjvEnoLd6LkiAtQiiJv/tq58qlBWRSOAfjsS04+32q+Uyc3b48V
         Xp1jESP5/rFxDCVUZ+wqm4XfUCLO2Krh8ldEQ32xf55c/VqyIxiDd0UcN79spfyA7MoW
         o1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ewlaK7KfwfeQA8a2+RRVtJNZTxO5Fg9rROGsXcCNq9g=;
        b=kCkWx/R9q1O6NlvGC+YSo2EB6NHCnsKzYd8gVX+hfNvgR7X18SwnAF3QnrnaHAiFxp
         6oqtlubw9Rh3J+ZS7OgXgoecLnIWG/Mp0inQhUszrHhjUHAlsInAY38SgmW7OKEHhSIn
         tTiUDRYh93Z8ee9BI8LtjoOb93LggDQBCtyaiR2NG3iGjq8ov5Er7Mc1EUWNJo5/yLbr
         T63zujDQjpnDRaZ3J0jVtEQyULYnlSD48e2+5ZS2W5NlvICm4Rc4a46viIqDBvYyjbtW
         8e79pQwywZJo6zBeG5OH0+CRlE2+OVWziXZ/QNTkpZxOP23Shhs1tSrAUL9IaIpBSj2t
         NkUw==
X-Gm-Message-State: AOAM533ml7vyYoaiueZXkZGS5sKpgR9xzXuzGk8ydeWt1F/aVdAe2yw/
        /JMRTe0LE03l3OhuMohTIfKkV4ow1Vs=
X-Google-Smtp-Source: ABdhPJyNyKetz092AJN4H6Nk981bgC0O8A53FFX9ap0EMDXYHVLsM0mPt2JcsyWIMS0koTvZU+N0kA==
X-Received: by 2002:a63:682:: with SMTP id 124mr12958959pgg.299.1629361765197;
        Thu, 19 Aug 2021 01:29:25 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63ed:4478:964c:2b9b:388e:4b0])
        by smtp.gmail.com with ESMTPSA id 143sm2428880pfz.13.2021.08.19.01.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:29:24 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Thomas De Zeeuw <thomas@slight.dev>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff-lib: ignore all outsider if --relative asked
Date:   Thu, 19 Aug 2021 15:29:09 +0700
Message-Id: <bc7eda4ed8d52072b929a4af6e4e4ed7478ef9d6.1629361733.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.33.0.254.g68ee769121
In-Reply-To: <40BE2EF2-0AF3-45BA-9880-8A6011B38D03@slight.dev>
References: <40BE2EF2-0AF3-45BA-9880-8A6011B38D03@slight.dev>
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

We can simply check for NULL there before dereferencing said
return value.  However, we can do better by not running diff
on those unintesting entries.  Let's do that instead.

Reported-by: Thomas De Zeeuw <thomas@slight.dev>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

Cc: Junio C Hamano <gitster@pobox.com>

Notes:
    Check for return value of diff_unmerge is not enough.
    
    Yes, it works with --name-only, however, with only --relative,
    git-diff shows unmerged entries outside of subdir, too.
    
    Furthermore, the filename in "diff --cc" ignores the relative prefix.
    Fixing this requires touching all over places, at least from my study.
    Let's fix the crash, first.
    
    We have two choices here:
    
    * Check pair, aka return value of diff_unmerge, like my original
      suggestion, and the unmerged entries from outside will be shown, too.
      Some inconsistent will be observed, --name-only won't list files
      outside of subdir, while the patch shows them.  At least, it doesn't
      create false impression of no change outside of subdir.
    
    * Skip all outsiders, like this patch.
    
    While I prefer this approach, I don't know all ramifications of this change,
    let's say an entry moved to outside of subdir in one side, and modified in
    other side.
    
    Because, I pick the different approach, Junio's ack isn't included here.
    

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

