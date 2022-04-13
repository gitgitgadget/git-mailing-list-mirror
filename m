Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5384EC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbiDMUFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbiDMUE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE54F7DA80
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r64so1763417wmr.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2kCKOXeROM1QT7hkTHbQ2MCROG15/goV1dWalxaf/c=;
        b=dz5VELKiJH3RXtmume7YVBFJYRTCAa/fGmKZIEptCJ5lIwohwxuYQJ3c6aL8R/q0KX
         yJMM1YSC4mgBYEtUcngDKuIcT0CSwdNLoBWinkZneR36fnThxbvs/xZG5UIXsTx4RuQ2
         fyTXCtenftpi7wBZGeedZZ3B2JCeYaTbtV7VBzsAQttH6hYarzezPDdwobnI+tiTvtRJ
         6jSJ2eVG/rnYaBdDWWn4qKuzSvEHjynbZJ2EFdKkvSZjbu4I9cqxCE6b6QlWhqeWEKtI
         hUm3Uji1ZJL6pjsvMHnPZrJzUQ7b04NCQF3LNz3H9XcA7IPmm0l1eMoOBnhZiEeZT9tn
         TdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2kCKOXeROM1QT7hkTHbQ2MCROG15/goV1dWalxaf/c=;
        b=GICnfsBUF0YvYOn0ZjPU2/zaMnmFBefv1XZlFuPUpsyjodkChNAhTDpB6+aF+XZd2+
         zIU8NtQGorYQCaOCPkVfNyVQWlr2K+byyHAexsMYpnemxZh9JB7PX7hrAa0IIiVhaPuq
         qJtdELRymjqW2M9FZHQfdv36ndqHkxW2V6jfcrODFNy17yQFkjUMht4+4f1MhEhPEMH6
         RsFhGHv/4pu6XCHbFrA459pk5ayJs3HN2Lyr6tQzkv4enNQFn2c5ezg55G/EDOXa7MQ5
         E392wi5YhEAKInMAGQGWHJKLgscuU7qjUyioad0cBwDti/uc/586g0axRzUtkPh5c5rm
         8Zkw==
X-Gm-Message-State: AOAM531+kdC1hr4XP18MGZ9sNE0VMbTOhyOdhEMQIpSMDTQPWWfIkMz4
        axtaNe7adOSgpSWfVdAyLTWCSerr/ctxQg==
X-Google-Smtp-Source: ABdhPJzFqgYIn28kGwZYRHMkgMlywmAGzEj1R/bU5FgHdvCMwOGngDUFUKXa//tGGnTWbRwRYwCJ0w==
X-Received: by 2002:a7b:c8cd:0:b0:38e:c2c1:520a with SMTP id f13-20020a7bc8cd000000b0038ec2c1520amr284126wml.139.1649880142840;
        Wed, 13 Apr 2022 13:02:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 23/27] revisions API: release "reflog_info" in release revisions()
Date:   Wed, 13 Apr 2022 22:01:52 +0200
Message-Id: <patch-v6-23.27-87ba9572b10-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
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
index 5aa6dec4532..8cd849aa2b9 100644
--- a/revision.c
+++ b/revision.c
@@ -2953,6 +2953,7 @@ void release_revisions(struct rev_info *revs)
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
index 975c4ea83a8..da581ec19ac 100755
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
2.36.0.rc2.843.g193535c2aa7

