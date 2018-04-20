Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 755461F404
	for <e@80x24.org>; Fri, 20 Apr 2018 18:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753670AbeDTSNq (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 14:13:46 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43081 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbeDTSNp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 14:13:45 -0400
Received: by mail-wr0-f194.google.com with SMTP id v15-v6so7100616wrm.10
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 11:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGthjebJfKuMF54WEkgFCamqBSJ6Ugv4sUOnETFOiWo=;
        b=apEUtVlsWRPOu0nl5Col5+nB1CiTaANqhCjrJh95m3VjvhG27toH27WFx6zsz1R9xB
         I25H5R3NA2V1WXwBK7i7CYhTIeCWLAuYUzEG+ZGee2XXpLJnJ9uWz8PSu9hwyVijDtGp
         riuJ7oAb+F10Avl/AKFkZ2gIzkPULhe4vWwdjeEn0dpGTezuoE1NDp6N4UpCQaTb/3LV
         zgTZli3PIRnAEGgm5aaS38cbKWDlgzAb7+EJKDaNG43p84A07Qr6XuhMm/TlI3KHh7gC
         VJ4DDc8vycMnQDpebNIJXLik+9uU+n/RSSTDrg8ScEFvXLUULlAyEqR5EU0BVpRN2T6p
         Ks0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGthjebJfKuMF54WEkgFCamqBSJ6Ugv4sUOnETFOiWo=;
        b=QbeV/TDjTveOF0e1SC3mPNROV/kCNsTxwMELq7An9TP38A7WRDmLCXynZeUMjM/iH8
         srlxut4bMWc2m1AE1KJzjVpKlSr2noJLDYrQsgOdNMd7F/N12hlU/FirtbpixaGh/t5a
         jph1jPpi8Tz5ppX/j3dbJRaBHlXoJM4xCSHRh/GkVtibbL/z2v1U/jG+pA4dgmf3lLrJ
         CcM0PWkYqy5sUT/I7rCj/Ks+O5jDipQ4oTiQ9eKdeiXVppkWxa7X/50TF4y+smQinf0f
         +kkDF/7Y1UUPFeSDtxME7PD/6rCLsi6HPqkfwVJHJ5ZbLE5aTWOz+JdQf6FPHtBRWvrC
         GKfA==
X-Gm-Message-State: ALQs6tCNw3iP/3Foiz/MXgabOg8FSpIfIYa3Q4PNkQBhuaQlxbf3VnwR
        sIh8PJ/gO7+TZH3jgcu8c5M7BmRuVdg=
X-Google-Smtp-Source: AIpwx4/CNoZiRBo4Kev+SrySjicRlBCsSjGrMH752uD4PFt8AjyW522c4RnIPRPg2kc0g7KuhhNgeQ==
X-Received: by 10.28.91.203 with SMTP id p194mr2836931wmb.52.1524248023115;
        Fri, 20 Apr 2018 11:13:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id z18-v6sm384280wrc.36.2018.04.20.11.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Apr 2018 11:13:42 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org, Isaac Chou <Isaac.Chou@microfocus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] fast-export: fix regression skipping some merge-commits
Date:   Fri, 20 Apr 2018 20:12:48 +0200
Message-Id: <20180420181248.2015922-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <MW2PR18MB228432C95C18DE786957DE70E5B40@MW2PR18MB2284.namprd18.prod.outlook.com>
References: <MW2PR18MB228432C95C18DE786957DE70E5B40@MW2PR18MB2284.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

7199203937 (object_array: add and use `object_array_pop()`, 2017-09-23)
noted that the pattern `object = array.objects[--array.nr].item` could
be abstracted as `object = object_array_pop(&array)`.

Unfortunately, one of the conversions was horribly wrong. Between
grabbing the last object (i.e., peeking at it) and decreasing the object
count, the original code would sometimes return early. The updated code
on the other hand, will always pop the last element, then maybe do the
early return before doing anything with the object.

The end result is that merge commits where all the parents have still
not been exported will simply be dropped, meaning that they will be
completely missing from the exported data.

Reintroduce the pattern of first grabbing the last object (using a new
function `object_array_peek()`), then later poping it. Using
`..._peek()` and `..._pop()` makes it clear that we are referring to the
same item, i.e., we do not grab one element, then remove another one.

Add a test that would have caught this.

Reported-by: Isaac Chou <Isaac.Chou@microfocus.com>
Analyzed-by: Isaac Chou <Isaac.Chou@microfocus.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
Based on maint, but applies equally well on master.

My sincerest apologies for the stupid train-wreck that the original
conversion was. Weird interactions between different components can make
for fun bugs, but this one is just embarassing.

Isaac, this should solve the problem you are seeing. Unfortunately, I do
not have any experience with building Git for Windows [1]. I really hope
that this bug did not take up too much of your time. Or eat your data!

Martin

[1] The least I can do is provide a link:
https://github.com/git-for-windows/git/wiki/Building-Git

 t/t9350-fast-export.sh | 22 ++++++++++++++++++++++
 object.h               |  9 +++++++++
 builtin/fast-export.c  |  3 ++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 866ddf6058..2b46a83a49 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -540,4 +540,26 @@ test_expect_success 'when using -C, do not declare copy when source of copy is a
 	test_cmp expected actual
 '
 
+test_expect_success 'todo' '
+	test_create_repo merging &&
+	git -C merging commit --allow-empty -m initial &&
+
+	git -C merging checkout -b topic &&
+	>merging/topic-file &&
+	git -C merging add topic-file &&
+	git -C merging commit -m topic-file &&
+
+	git -C merging checkout master &&
+	>merging/master-file &&
+	git -C merging add master-file &&
+	git -C merging commit -m master-file &&
+
+	git -C merging merge --no-ff topic -m "merge the topic" &&
+
+	oid=$(git -C merging rev-parse HEAD^^) &&
+	echo :1 $oid >merging/git-marks &&
+	git -C merging fast-export --import-marks=git-marks refs/heads/master >out &&
+	grep "merge the topic" out
+'
+
 test_done
diff --git a/object.h b/object.h
index f13f85b2a9..4d8ce280d9 100644
--- a/object.h
+++ b/object.h
@@ -129,6 +129,15 @@ void add_object_array_with_path(struct object *obj, const char *name, struct obj
  */
 struct object *object_array_pop(struct object_array *array);
 
+/*
+ * Returns NULL if the array is empty. Otherwise, returns the last object.
+ * That is, the returned value is what `object_array_pop()` would have returned.
+ */
+inline struct object *object_array_peek(const struct object_array *array)
+{
+	return array->nr ? array->objects[array->nr - 1].item : NULL;
+}
+
 typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
 
 /*
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 27b2cc138e..8377d27b46 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -650,9 +650,10 @@ static void handle_tail(struct object_array *commits, struct rev_info *revs,
 {
 	struct commit *commit;
 	while (commits->nr) {
-		commit = (struct commit *)object_array_pop(commits);
+		commit = (struct commit *)object_array_peek(commits);
 		if (has_unshown_parent(commit))
 			return;
+		(void)object_array_pop(commits);
 		handle_commit(commit, revs, paths_of_changed_objects);
 	}
 }
-- 
2.17.0

