Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDC8C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiCYRae (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbiCYR2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:28:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC91FD6FC
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bi12so16757503ejb.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kqs7zJbZvXbVRZB14wY492sNVudZQegpH20wNyvylUU=;
        b=X3sIMiTLuQju47pgzYp7dYEd4XNC5gq0QSXiZnPapKNiznVqPGfh0WW0BZoF+JQoIl
         kGLvsM4be9qiYZQmPxg/vErSOWeOX1ZlIrQ1Kp6LhaUfg45j72MlgW/xjuG8mHoEEU/T
         l+YLs7Kwd5pWCAGrh4JDp3T6+pKZodbvoPixVX4JwJ64RqF9xvtGnvnnj02OnqcZHUqW
         ujsfpulDnd1fHO6mc+NpQ6WyXexODC+HwN1mBqY4PThsaABfXUrBWfu3eF5Q8GqpE2Mo
         YH7l22sEu7LfG/RrpN5PEKLVltRXnmudZ+HOE4i0XFWPgg6ftTMem4tDcFvFs0omwEg1
         6q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqs7zJbZvXbVRZB14wY492sNVudZQegpH20wNyvylUU=;
        b=4SKnS+UfOcy2UK0JyjoD55JBW/eOac/dGSKwfdG7ss5cZWrtaoJzwpwQczwLOrYwo9
         JlGs4s2tUkcp16q8Nknx3bhRAJHX3R4Abd6rL/uQz0y804Xdkox9E0pzJFZJKtMlNIAE
         RlfEdAdcOz9w7bk6O4EOIV8D4CBtDKJIjsn0gZL6AzREImUBgN+H4BaUxGA2/1YIlbRJ
         Mis4M+cudZ7IAzjCSV4clyBOwxJ9vIX1a/GefbRhwSbU19/yXzNf6eXorAUYs8ppvM7q
         BOpKgoHY5cvRvH+5ZGVISWjISJ4BpB0mPfzGHKjvcdksyLtlfwI/IqfcFdK/3kwG2mCt
         6nww==
X-Gm-Message-State: AOAM531IX1MHoXUih/BOdvbPtVHVccA6SZ6bo/1PnZNaE8mscFCA0iot
        7t2+IRnGgIqxYMAyfzexMInN/FcHt/XpQg==
X-Google-Smtp-Source: ABdhPJzZ/ML6LLaKS1bzj5Rjvnq6JDeUrDDec/gdmbpVUpKzLljd2D4LRADy0+lOyuzzwapxS6pu5g==
X-Received: by 2002:a05:6000:1d97:b0:204:1b0:74b2 with SMTP id bk23-20020a0560001d9700b0020401b074b2mr10051446wrb.14.1648228793093;
        Fri, 25 Mar 2022 10:19:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:52 -0700 (PDT)
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
Subject: [PATCH v3 23/27] revisions API: release "reflog_info" in release revisions()
Date:   Fri, 25 Mar 2022 18:18:47 +0100
Message-Id: <patch-v3-23.27-af874c17fbd-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
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
index 53b3ab6dc2d..380e6d9fe43 100644
--- a/revision.c
+++ b/revision.c
@@ -2960,6 +2960,7 @@ void release_revisions(struct rev_info *revs)
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
2.35.1.1509.ge4eeb5bd39e

