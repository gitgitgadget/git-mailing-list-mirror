Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC28C433FE
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354793AbiDBKxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354505AbiDBKwf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:52:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FED141DAB
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:50:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bq8so10654253ejb.10
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PL4iQLTBvUUJJrF5hi9w9D8A0brXgbbLowcIb8SFOk8=;
        b=A7XnGWGIgrhL5RtKn+D+JUf6A60BHmbMYxg63JP5IHstO/UEtryZFvLpF3MJIGSpnn
         IYhK1SyOHe2Nc90qqdOWAdQsJ2Kh7kn1PDkjDEEZFq5nKk0Dtz9wyL/jR1iVCHkRQ7kG
         d2HA1eQ0zsrwjxhP2hqf3aYxQpaX7zVx5KKfbO0rqJp0JjnkkYJKGFiFVjQd1na2ICeR
         ZUwH46DJ+4WVGRmj00fJw196FPgMOgMx0Y0x4L2BnjISUIRWQS9P1AI8Lynp12IeX9Ws
         ZjP10wuuOfO+cgusnDNWSqgQ2OVEdo8gYjUvFHQ6FDFR1/lS/kQqhjr+wf/Z1+Kum5ms
         hzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PL4iQLTBvUUJJrF5hi9w9D8A0brXgbbLowcIb8SFOk8=;
        b=t7kUEK2L3QW3/PixvluYusE3inNgbTzOYKJpcMZ/YGqpTE2HC3bAYG75c7gkcgpI3X
         LJ3Oc2S685pDreswSTfhGzG4uOKozTr9tybSC5x5SCaQVzEY9v/1crWEj8gpFqTooDBr
         EmU38BPBoT0Ctgx69BHVjy8L3fp0M+hYnBLZC4I2GaLgGCPUFo5VKjCGDx6T0ixxKWzu
         9PgtFQkIObVlDfQs1hCJMw/Ijt2wJ5ZPa5j/8NH3Ps3m4giIex+eNE0uY/8bC9iS3tbB
         Bfj6Wl1Wt3gnQrPaCVMSBWuRR7CS9h4pYHSJpP+UJ9BJCM+XZTFV7ehuvk+a5fMgeh9w
         yEXg==
X-Gm-Message-State: AOAM531hs0fvUDYxV1hTm/zGXdfMyflt4rxmw3kWoiAGr7a70nQmsjAT
        9vB442KNaw9LVvwykvBCfhp2RW8sMDHaMg==
X-Google-Smtp-Source: ABdhPJxOwW3a2aY/szce5Mt/mmaywSPrXt+x4VYgKdy84hNaMe8joTX5uAf4VoSiNJ6luFJHglxmjw==
X-Received: by 2002:a17:907:d05:b0:6e4:49ac:9b26 with SMTP id gn5-20020a1709070d0500b006e449ac9b26mr3392005ejc.133.1648896607400;
        Sat, 02 Apr 2022 03:50:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:50:06 -0700 (PDT)
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
Subject: [PATCH v5 23/27] revisions API: release "reflog_info" in release revisions()
Date:   Sat,  2 Apr 2022 12:49:37 +0200
Message-Id: <patch-v5-23.27-0e9745d9ee1-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
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
index 40f59c441f7..e972addd8fc 100644
--- a/revision.c
+++ b/revision.c
@@ -2955,6 +2955,7 @@ void release_revisions(struct rev_info *revs)
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
2.35.1.1585.gd85f8dcb745

