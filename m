Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07820C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiCINTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiCINT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD6F1795E8
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:18:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id x15so2937552wru.13
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHbG4oiF4ptKRe0NOAG1XZcB4R8tEfzJaua8eSmHwKk=;
        b=qF67OVJRQHEewBcj9IvgAjisMALdpaTB8kJm9dV/wC696Jk/Qgmgq1rHAeY2d6BZCr
         xvvwmTiI5bUc4Ts+cvGEaqmiH5yfCgNwhzYHj7Wcu908/V8WHeAhSyk4Lr8BCzYB6ACp
         Btyxu/B6MxMoJ354P4LV1fXQEY1Oqg1rmfBTOhb3Kd6aX5dpaG5ARcO95UYBHUxAlcIo
         y4LguMEL//SL+6PjM3Su/PSArP2n/mW0h7ik4qdYx3K5gTIAm5BMtrkXuy7hbdnWi8Y4
         ybw5SAsYGQ2vctnllpucBp0Q52Gab3+8vbezBU8RdYc8ow2upXXslXV8zHMfzChWS9AL
         tHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHbG4oiF4ptKRe0NOAG1XZcB4R8tEfzJaua8eSmHwKk=;
        b=ENED99bX6SUyUFgVt1MS3bQQhgLvuGkXDGcEzMTUO5aPQqqeD3TDkclB4cORV3g3k3
         q4d5NFEtJ7AjTYVQ98EgMFvQLnrVjAK0DV1Bdjf0C5sXcY9IcZ0E9O8exKsUYy/yaBf/
         TlVMRM4ihQmg3yNJxKc+ooI2TZ5Jp5AAHYh8PCIgkprdDcprZoP4v9ktfwQGnJBOYJAX
         /wnfTiSbq2uiD0XdLGcQSldekjM3sSHH3aXy+fT/ECLqyjvaw71faRBlWva9+OFTp9Yv
         mscuBSnmKapbgLYDivCY0c4+Dds3ehXReQDHU+hxqoLY2f28JCxmbmoWhD311B5cJTDT
         xL4Q==
X-Gm-Message-State: AOAM533OV5mAEeZN5dGGg45U4HdUE91coUwytCcOTjbSXIarH5x127CB
        2nFzW6Ytcc+OPbSxbBhPv9ACN4FGteBECA==
X-Google-Smtp-Source: ABdhPJxq6LP3+C1hdmm7bX1v8VKgY+0XqJ7ItroSAoBnX7t3pYt3FEiGg95llEnEsQ3CjOd43B+mhw==
X-Received: by 2002:adf:db82:0:b0:1ed:bf4b:e327 with SMTP id u2-20020adfdb82000000b001edbf4be327mr15720995wri.527.1646831882408;
        Wed, 09 Mar 2022 05:18:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:18:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 21/24] revisions API: release "reflog_info" in release revisions()
Date:   Wed,  9 Mar 2022 14:16:51 +0100
Message-Id: <patch-21.24-ccf276641d6-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
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
 reflog-walk.c            | 26 ++++++++++++++++++++++++--
 reflog-walk.h            |  1 +
 revision.c               |  1 +
 t/t0100-previous.sh      |  1 +
 t/t1401-symbolic-ref.sh  |  2 ++
 t/t1411-reflog-show.sh   |  1 +
 t/t1412-reflog-loop.sh   |  2 ++
 t/t1415-worktree-refs.sh |  1 +
 8 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 8ac4b284b6b..4322228d122 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -7,7 +7,7 @@
 #include "reflog-walk.h"
 
 struct complete_reflogs {
-	char *ref;
+	const char *ref;
 	const char *short_ref;
 	struct reflog_info {
 		struct object_id ooid, noid;
@@ -50,10 +50,17 @@ static void free_complete_reflog(struct complete_reflogs *array)
 		free(array->items[i].message);
 	}
 	free(array->items);
-	free(array->ref);
+	free((char *)array->ref);
+	free((char *)array->short_ref);
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
index a73e76bed4a..ec6cd662467 100644
--- a/revision.c
+++ b/revision.c
@@ -2956,6 +2956,7 @@ void release_revisions(struct rev_info *revs)
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
2.35.1.1295.g6b025d3e231

