Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65E8B1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933482AbcLGWuE (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:50:04 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34201 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932583AbcLGWuC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:50:02 -0500
Received: by mail-wj0-f195.google.com with SMTP id xy5so52126468wjc.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 14:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Aqjgj9O3a9LqP/cyBFHHjOXFaDMrcvj9zJdsYgDmGXU=;
        b=SzWy2hSdD2cXghF3KgRy/J4hwVIMtZP2/LmOlbCVAaqTItWzF6hmLlhsZ+mfntQhWV
         qR6wqGSCJEGVuHmwM5eKfZw+JHk1jT8+ImOqC24W3y+NEs34kj+Y34Be0FENkAFNPsMo
         gTbVjkN/Jj3yM/8X66TnKqCd2dK+6kMnuiiZkb7yfRWhk6QR0N8g6aTesMLR2n7zaac1
         lD3Xlqoyet5jD6GwFOZZ5afdzbF9Po1F5RGQ5uJG0khh3MyD9pCkq4dCfkNc9ZBuGORB
         D9lOOVDJaP0S27WYSAR3zeRYLVHY7Pjrc7WxHCnYDcmdP8gd4D86jKxpqhGsEWttmX1G
         AP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Aqjgj9O3a9LqP/cyBFHHjOXFaDMrcvj9zJdsYgDmGXU=;
        b=lqhyBPT1p36aC2ZmVMzkIi01Sgc8e5gCE9gzM8//dBwLwEjXKCK657NTtnvIQBUcsH
         nrkNyl7t9xoXUvmV6sNzZPjPUe2povML53ETl+ixSgnGR+SDYgORg3SStginvCpCtYVv
         44k3JY6sacL5gdtJ/lKLYQ7yBM7nwuZ3FIseMao/88DxxMCbnUWaIcvChpPDaZ9J3LOL
         JaX5zhxh4s1nkJWVjcvkvdK5ziN+OwVHMertVIHtBHXcoQDdYbv0QGw/uPk8JHttZLTM
         fMgGrgFv/QtTyOSFNE6qYNqXtjPE8ag2jFdFc1srcWYbfD32n+TUYYnAWMZHrUsHUa6G
         BQZw==
X-Gm-Message-State: AKaTC0219Hb7UivWxRgBbbxBKCPvLuGdKUoic8S4OFJm8p3TdlNu2yOwc2s4cilFbTonQA==
X-Received: by 10.194.85.137 with SMTP id h9mr59052257wjz.23.1481151000978;
        Wed, 07 Dec 2016 14:50:00 -0800 (PST)
Received: from localhost.localdomain ([104.131.203.210])
        by smtp.gmail.com with ESMTPSA id w8sm11954308wmw.4.2016.12.07.14.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 14:50:00 -0800 (PST)
From:   vi0oss@gmail.com
To:     git@vger.kernel.org
Cc:     stefanbeller@gmail.com, "Vitaly \"_Vi\" Shukela" <vi0oss@gmail.com>
Subject: [PATCH 1/2] submodule--helper: set alternateLocation for cloned submodules
Date:   Thu,  8 Dec 2016 01:49:47 +0300
Message-Id: <20161207224948.7957-1-vi0oss@gmail.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Vitaly \"_Vi\" Shukela" <vi0oss@gmail.com>

In 31224cbdc7 (clone: recursive and reference option triggers
submodule alternates, 2016-08-17) a mechanism was added to
have submodules referenced.  It did not address _nested_
submodules, however.

This patch makes all not just the root repository, but also
all submodules (recursively) have submodule.alternateLocation
and submodule.alternateErrorStrategy configured, making Git
search for possible alternates for nested submodules as well.

As submodule's alternate target does not end in .git/objects
(rather .git/modules/qqqqqq/objects), this alternate target
path restriction for in add_possible_reference_from_superproject
relates from "*.git/objects" to just */objects".

New tests have been added to t7408-submodule-reference.

Signed-off-by: Vitaly _Vi Shukela <vi0oss@gmail.com>
---

Notes:
    Resolved issues pointed by Stefan Beller except of
    the one about loosened path check, which he aggreed
    to be relaxed for this case.

 builtin/submodule--helper.c    | 21 ++++++++++--
 t/t7408-submodule-reference.sh | 72 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4beeda5..7b7633d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -498,9 +498,9 @@ static int add_possible_reference_from_superproject(
 
 	/*
 	 * If the alternate object store is another repository, try the
-	 * standard layout with .git/modules/<name>/objects
+	 * standard layout with .git/(modules/<name>)+/objects
 	 */
-	if (ends_with(alt->path, ".git/objects")) {
+	if (ends_with(alt->path, "/objects")) {
 		char *sm_alternate;
 		struct strbuf sb = STRBUF_INIT;
 		struct strbuf err = STRBUF_INIT;
@@ -583,6 +583,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	struct strbuf rel_path = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
+	char *sm_alternate = NULL, *error_strategy = NULL;
 
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -672,6 +673,22 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		die(_("could not get submodule directory for '%s'"), path);
 	git_config_set_in_file(p, "core.worktree",
 			       relative_path(path, sm_gitdir, &rel_path));
+
+	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
+	git_config_get_string("submodule.alternateLocation", &sm_alternate);
+	if (sm_alternate) {
+		git_config_set_in_file(p, "submodule.alternateLocation",
+					   sm_alternate);
+	}
+	git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
+	if (error_strategy) {
+		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
+					   error_strategy);
+	}
+
+		free(sm_alternate);
+		free(error_strategy);
+
 	strbuf_release(&sb);
 	strbuf_release(&rel_path);
 	free(sm_gitdir);
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index 1c1e289..ef7771b 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -125,4 +125,76 @@ test_expect_success 'ignoring missing submodule alternates passes clone and subm
 	)
 '
 
+test_expect_success 'preparing second superproject with a nested submodule' '
+	test_create_repo supersuper &&
+	(
+		cd supersuper &&
+		echo "I am super super." >file &&
+		git add file &&
+		git commit -m B-super-super-initial
+		git submodule add "file://$base_dir/super" subwithsub &&
+		git commit -m B-super-super-added &&
+		git submodule update --init --recursive &&
+		git repack -ad
+	)
+'
+
+# At this point there are three root-level positories: A, B, super and super2
+
+test_expect_success 'nested submodule alternate in works and is actually used' '
+	test_when_finished "rm -rf supersuper-clone" &&
+	git clone --recursive --reference supersuper supersuper supersuper-clone &&
+	(
+		cd supersuper-clone &&
+		# test superproject has alternates setup correctly
+		test_alternate_is_used .git/objects/info/alternates . &&
+		# immediate submodule has alternate:
+		test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub
+		# nested submodule also has alternate:
+		test_alternate_is_used .git/modules/subwithsub/modules/sub/objects/info/alternates subwithsub/sub
+	)
+'
+
+test_expect_success 'missing nested submodule alternate fails clone and submodule update' '
+	test_when_finished "rm -rf supersuper-clone supersuper2" &&
+	git clone supersuper supersuper2 &&
+	(
+		cd supersuper2 &&
+		git submodule update --init
+	) &&
+	test_must_fail git clone --recursive --reference supersuper2 supersuper2 supersuper-clone &&
+	(
+		cd supersuper-clone &&
+		# test superproject has alternates setup correctly
+		test_alternate_is_used .git/objects/info/alternates . &&
+		# update of the submodule fails
+		test_must_fail git submodule update --init --recursive &&
+		# immediate submodule has alternate:
+		test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub
+		# but nested submodule has no alternate:
+		test_must_fail test_alternate_is_used .git/modules/subwithsub/modules/sub/objects/info/alternates subwithsub/sub
+	)
+'
+
+test_expect_success 'missing nested submodule alternate in --reference-if-able mode' '
+	test_when_finished "rm -rf supersuper-clone supersuper2" &&
+	git clone supersuper supersuper2 &&
+	(
+		cd supersuper2 &&
+		git submodule update --init
+	) &&
+	git clone --recursive --reference-if-able supersuper2 supersuper2 supersuper-clone &&
+	(
+		cd supersuper-clone &&
+		# test superproject has alternates setup correctly
+		test_alternate_is_used .git/objects/info/alternates . &&
+		# update of the submodule fails
+		test_must_fail git submodule update --init --recursive &&
+		# immediate submodule has alternate:
+		test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub
+		# but nested submodule has no alternate:
+		test_must_fail test_alternate_is_used .git/modules/subwithsub/modules/sub/objects/info/alternates subwithsub/sub
+	)
+'
+
 test_done
-- 
2.10.2

