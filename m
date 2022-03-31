Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A5CC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352281AbiCaBOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352301AbiCaBOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD0466CB2
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i4so12716099wrb.5
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5F5ODo7Iy/Ox7bjqtiXj5mOJlwc2BfGLgthF+WhNP4=;
        b=F6hoGFAafG5/C2X7HyILXN+28n/a5Oi/Mmg6hrIKAKDqn/SLifpeAYy5cfaNmKgKof
         N7J5QMDDjgngMp6S0Bsi9AtoF6MvjqmPKCzL91ENxeTiSeNkf07sk05m4aXFff9UEsJo
         05n1YfU3Kksv4D4Pk0BJQjID5vl1UGRdU12FmBzE2CntpsgDHGSxME+J6+JyioDvH24y
         ZvX3oWbOc6U8xLV4j3e3VHllrZImHPuXMOrlGJxBBUTWkvd27mLDFrJ4a+3EFHA0FBwv
         /u7WMY50pPe1Ly4MWFSp4MoNw6MRtvmVyxylnhJNt+cwW6gHKFe3l3nZ08a3zPeO0Np9
         mXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5F5ODo7Iy/Ox7bjqtiXj5mOJlwc2BfGLgthF+WhNP4=;
        b=hpoaVEouvnjrichbBrXHp2cE6jTMdBQ/Io5o1Gg4BosOQIHndND9Hfi3gtepjRMmpi
         lfuaSwe21Q874jPsbZ1T2Pyt5WxoEwznGIIV4Xst8lJFAdYqtspIMlZITg+WDz0tSip6
         Cpuau1hXOADDm3aFiV/ClceAGutL5wXnDgDD6yXNMoi4t0C4RWNwupN8/uyPxKi+2Yle
         S3XWl4lrOZZhS6EAsolSpr1R1UZKAwr5+4GSXU0Q3jlfkUbYkIOgP0YRHpoqj30MBgBn
         pYkP7oKv1NeurIM9CUFYd2fSBRZA5cj6WkTp0HOTLpKnpj4YN7cA0TpY0dBJyDL0VjMO
         28Zw==
X-Gm-Message-State: AOAM532Ao/B3604Ty4w/R+FowhkR4gKeeMna2CuQ2xTwqh/Q1yQ4LNe1
        uYqXBwR6UIghbuGiDftmTGY29QTc0NjC9g==
X-Google-Smtp-Source: ABdhPJxG7Cb+8bhIjUXxVvWVYn1U/ur6h9TQ2orXammqdp8rRODc+DIaJCRAtFObiCuk7KxypEH41A==
X-Received: by 2002:a05:6000:1010:b0:204:c3c0:ad93 with SMTP id a16-20020a056000101000b00204c3c0ad93mr1960952wrx.311.1648689145331;
        Wed, 30 Mar 2022 18:12:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 23/27] revisions API: release "reflog_info" in release revisions()
Date:   Thu, 31 Mar 2022 03:11:28 +0200
Message-Id: <patch-v4-23.27-0363a69073c-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing reflog_walk_info_release() to "reflog-walk.c" and use it
in release_revisions().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 reflog-walk.c            | 24 +++++++++++++++++++++++-
 reflog-walk.h            |  1 +
 revision.c               |  1 +
 t/t0100-previous.sh      |  1 +
 t/t1401-symbolic-ref.sh  |  2 ++
 t/t1411-reflog-show.sh   |  1 +
 t/t1412-reflog-loop.sh   |  2 ++
 t/t1415-worktree-refs.sh |  1 +
 8 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 8ac4b284b6b..7aa6595a51f 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -8,7 +8,7 @@
 
 struct complete_reflogs {
 	char *ref;
-	const char *short_ref;
+	char *short_ref;
 	struct reflog_info {
 		struct object_id ooid, noid;
 		char *email;
@@ -51,9 +51,16 @@ static void free_complete_reflog(struct complete_reflogs *array)
 	}
 	free(array->items);
 	free(array->ref);
+	free(array->short_ref);
 	free(array);
 }
 
+static void complete_reflogs_clear(void *util, const char *str)
+{
+	struct complete_reflogs *array = util;
+	free_complete_reflog(array);
+}
+
 static struct complete_reflogs *read_complete_reflog(const char *ref)
 {
 	struct complete_reflogs *reflogs =
@@ -116,6 +123,21 @@ void init_reflog_walk(struct reflog_walk_info **info)
 	(*info)->complete_reflogs.strdup_strings = 1;
 }
 
+void reflog_walk_info_release(struct reflog_walk_info *info)
+{
+	size_t i;
+
+	if (!info)
+		return;
+
+	for (i = 0; i < info->nr; i++)
+		free(info->logs[i]);
+	string_list_clear_func(&info->complete_reflogs,
+			       complete_reflogs_clear);
+	free(info->logs);
+	free(info);
+}
+
 int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name)
 {
diff --git a/reflog-walk.h b/reflog-walk.h
index e9e00ffd479..8076f10d9fb 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -8,6 +8,7 @@ struct reflog_walk_info;
 struct date_mode;
 
 void init_reflog_walk(struct reflog_walk_info **info);
+void reflog_walk_info_release(struct reflog_walk_info *info);
 int add_reflog_for_walk(struct reflog_walk_info *info,
 			struct commit *commit, const char *name);
 void show_reflog_message(struct reflog_walk_info *info, int,
diff --git a/revision.c b/revision.c
index 9806240770c..24b6bc3ac7e 100644
--- a/revision.c
+++ b/revision.c
@@ -2964,6 +2964,7 @@ void release_revisions(struct rev_info *revs)
 	clear_pathspec(&revs->prune_data);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
+	reflog_walk_info_release(revs->reflog_info);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index 69beb59f627..a16cc3d2983 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -5,6 +5,7 @@ test_description='previous branch syntax @{-n}'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'branch -d @{-1}' '
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 132a1b885ac..9fb0b90f252 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='basic symbolic-ref tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # If the tests munging HEAD fail, they can break detection of
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 0bb319b944a..3770ceffafd 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -4,6 +4,7 @@ test_description='Test reflog display routines'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1412-reflog-loop.sh b/t/t1412-reflog-loop.sh
index 977603f7f1c..ff30874f940 100755
--- a/t/t1412-reflog-loop.sh
+++ b/t/t1412-reflog-loop.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='reflog walk shows repeated commits again'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup commits' '
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index a3e6ea08088..3b531842dd4 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -2,6 +2,7 @@
 
 test_description='per-worktree refs'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.35.1.1557.g4e3e9cdb5e0

