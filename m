Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCEFC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbiCWUfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344779AbiCWUef (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE968D6AB
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so3752826wrg.12
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/iZXUqR/ms7gS8hoEZljSAWGJ3+Zeu2Z3LRA+xPjw4=;
        b=BcGPO66+HC9C3i49Whk1abwl7kLXx/Ln9InzV95/Ow2PS2fmeZ5Ge0c5EYuEIdnYoD
         TVmZcBaDiTNGuRSTmCYqBzf4PRNXubiKgRAbAVerxziu25Hs6+hu4Twke/VjzfRxUra5
         /VyyiNlEL0FEpAHpN0OzztTVTfdZjWagWyGjECigtSktgbFSTFt13sLAW5XL23B4yJZc
         umZCqvKfFdoaF1KR61htjPIsZimHvi4w+ia+YW82LXfoMTU3f8KJJtKxxuf5Q5F+aet/
         hXWEeJjZeHSNXdrVeNcNHyyxNzRWZ7aTQhJ6Lj2JfrzpOeDaRbL/1MxlDVidYBnYtVVd
         iDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/iZXUqR/ms7gS8hoEZljSAWGJ3+Zeu2Z3LRA+xPjw4=;
        b=RQfLau9zFPygeRN8+hlvCkq0YBCI/XSnWZsZWyTiAOa97+ieEkFAmakmy0b5aVzUgk
         HZrmbd1XIiVNEk1YSKY2SMGFpmoX9SMIt0ZCiNwRIhN5lESmPxKQfVPfe2JiaxM/fHkN
         wsM0dY1rH/rOCLVpLJ5AjONgufyRFE2c2DnhYg28NcoixGpd1KQlL9Qtlz04YCAx/Mpl
         2CX1uaFC14OZsKzSB9lZ8jV3vLBmRVh74Ao5Vq231QnhTt/TZztLz7nRH3XJvnsqkWGr
         YWMHs9ClpSb/C4DOknwUNYaQx0Ku90QJ9ml00bMhhqbwhbkYZ8dZxm2BITbJjhyZnF4d
         WEww==
X-Gm-Message-State: AOAM53283gehuJzCGftz4SVRJ4VwqwhPSDUtT/WqrY4wkr5rJdDbGI6V
        RH4PkMVMAKixcjTBpZjaBAJgFyK+bX6hWg==
X-Google-Smtp-Source: ABdhPJwVnEstyt//sz1NUxc7kyRYBSy8ouJD6yjLtUnPBtQmclyPBGon7nZUTTXvT+seH/3/7mq63g==
X-Received: by 2002:a5d:6542:0:b0:203:da90:969f with SMTP id z2-20020a5d6542000000b00203da90969fmr1543308wrv.479.1648067567002;
        Wed, 23 Mar 2022 13:32:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:46 -0700 (PDT)
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
Subject: [PATCH v2 23/27] revisions API: release "reflog_info" in release revisions()
Date:   Wed, 23 Mar 2022 21:32:13 +0100
Message-Id: <patch-v2-23.27-c559b7d538b-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
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
index 020f32f6eca..ce23590a219 100644
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
2.35.1.1452.ga7cfc89151f

