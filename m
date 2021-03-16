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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CFAC43619
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546ED6502D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhCPCOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbhCPCOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:14:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDD7C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v4so6653390wrp.13
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGSBrufPIdTQhV4ed4Ysv4+ZD/klDo4S572DiBCs+Bw=;
        b=Yr11lLzPVxczGt/MkyF7gPiTuESmw220Ars1qFLMB3yEo6jroLqlU89NhfWjSje3dI
         YQE7l8o/ZWqVYzKdK1Pyaf1Q3cm5xtOPyHWriCFK9k5fRvWkJqAXv+dRmUDwKq3AEWMX
         k+1ka2ufJ68Cex+MPMLcBUWAa7DCwjaB1u+FywCJ3pKa/piUxA0xwT1IFDlwnRTcOfQF
         At4i6shfNfVQZFecpdlluE0yLvmW0gZvtD2vY3TTCD1zYqe57IchmKgKSdBMz/pQW774
         KtS11chy/LAcBxpy74pYcyusql8fwgJbffpsNwqNcNMHKPzfCUUHibTBbyrVQkKZcL/B
         iHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGSBrufPIdTQhV4ed4Ysv4+ZD/klDo4S572DiBCs+Bw=;
        b=gz84IfHaQ1Jv27vCoNQ5F1hiTceic0JvwlxkCG/98yrHW4Rek9j67zh5NiT9ohPo3a
         gwQhefqUExaO3Om1XqdPtbZ8a3LQY8CA7DBW/cHc3vbbg6xvUlClf/zz8FI0GeLNbkpZ
         iDuLnEeAUmJpLViOdnrOxzUqytgbCsijjbIV0ox3i5e/oGusABH2wj+KCOxmybirxk7i
         GMcU39TXOFqIwliJquE8GxV5oG2SXU0l2hcIdovB/lR/6Jyukt6COuIuOmAXq5/q3nJ0
         EFR4UpKGh1BpqT20+QXqgC6D6ZO2IkzW6a1xxu5sauEjJMhiEFRXH2SnGW+ZppjRxYBw
         21hw==
X-Gm-Message-State: AOAM531OcYMAn6WvFWuwRB3lawL+8/869Bpiwvh82LMZKbi4RVbw0tR5
        TQ/z8FlqmJleJLWn6ZgCQDcYdu6jMf3mmg==
X-Google-Smtp-Source: ABdhPJwnbMj8SRN49o/68WBfppG/yvD7nUFpsoap7BQ6jkb7MWNSXcPhGlemugQyfTnaqWcKKSyZOA==
X-Received: by 2002:a5d:4c85:: with SMTP id z5mr2234563wrs.208.1615860835611;
        Mon, 15 Mar 2021 19:13:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 28/29] blame: emit a better error on 'git blame directory'
Date:   Tue, 16 Mar 2021 03:13:11 +0100
Message-Id: <20210316021312.13927-29-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an early check for non-blobs in verify_working_tree_path() to
let any such objects pass, and instead die shortly thereafter in the
fake_working_tree_commit() caller's type check.

Now e.g. doing "git blame t" in git.git emits:

    fatal: unsupported file type t

Instead of:

    fatal: no such path 't' in HEAD

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 blame.c                         |  8 ++------
 t/t8004-blame-with-conflicts.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/blame.c b/blame.c
index 9e0543e13d4..7da162cd582 100644
--- a/blame.c
+++ b/blame.c
@@ -100,12 +100,8 @@ static void verify_working_tree_path(struct repository *r,
 
 	for (parents = work_tree->parents; parents; parents = parents->next) {
 		const struct object_id *commit_oid = &parents->item->object.oid;
-		struct object_id blob_oid;
-		unsigned short mode;
-		int ret = get_tree_entry_mode(r, commit_oid, path, &blob_oid,
-					      &mode);
-
-		if (!ret && oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
+		struct object_id oid;
+		if (!get_tree_entry_path(r, commit_oid, path, &oid))
 			return;
 	}
 
diff --git a/t/t8004-blame-with-conflicts.sh b/t/t8004-blame-with-conflicts.sh
index 35414a53363..6caa504a0ea 100755
--- a/t/t8004-blame-with-conflicts.sh
+++ b/t/t8004-blame-with-conflicts.sh
@@ -73,4 +73,24 @@ test_expect_success 'blame does not crash with conflicted file in stages 1,3' '
 	git blame file1
 '
 
+test_expect_success 'setup second case' '
+	git merge --abort
+'
+
+test_expect_success 'blame on directory/file conflict' '
+	mkdir d &&
+	test_commit second &&
+	test_commit d/file &&
+	test_must_fail git blame d 2>expected &&
+
+	git reset --hard second &&
+	>d &&
+	git add d &&
+	git commit -m"a not-a-dir" &&
+	test_must_fail git merge d/file &&
+
+	test_must_fail git blame d 2>actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.31.0.rc2.211.g1d0b8788b3

