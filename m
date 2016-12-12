Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF391FF40
	for <e@80x24.org>; Mon, 12 Dec 2016 02:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbcLLCqS (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 21:46:18 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33607 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753807AbcLLCqR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 21:46:17 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so8250984wmu.0
        for <git@vger.kernel.org>; Sun, 11 Dec 2016 18:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nXj5f1LP3MZDDjPczY3lh3SMyezCyFm698V7ZZNnhrQ=;
        b=Wa9TkLKgG5qYQdXLrapiQP1YKB/d0CBxFGLR2zVOIb1UZiYx+F8l4aWhVUjLOq8/8M
         orPBqjJK39/HrIasKXXYBHP/ybKZVQVL2HdEtdIk6qlKPTPFGYsA8Hds9WCVN/ezGzbi
         ZvJXxwiiTgROcXtEcwZOmlEKdBdcP+m4YbbIm8YJrXGEQsf6elezLQWh0VBOWYsnCi+u
         RjswqNr2jSkaxMCcJKm2nVp0i5t42h8bzLNb2snkwglYyfCAB1Hkjthmr1myPvSy1IxJ
         IB23geBLW2rwymtT2BaC6ctAa5oBgnsxzdko0l8R8wUKtWpkKDAzzchwfwQQlcjjJCf7
         ntzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nXj5f1LP3MZDDjPczY3lh3SMyezCyFm698V7ZZNnhrQ=;
        b=gINMh649xvvd01yJZZDDiZgJDvQ75DpVoVNN0sSIDs3/bn/9DOZcREsmWNUGAg9Pl4
         cwwa7EGZAilOT6vj1M34wB9BFDAlRzX0KJC08wGERqAz3kTGkvV04X2LPhmX+1Snwb8k
         ZRGuy2o2F2/zvzVh4qp+SiX0XkjO6Bk0r4U1RWQ7Gj1bEBdQFNuAMxRn3Ism8ZdGPUz7
         S9hLZFbQi4c4xVqhiSJ80n6JvTab264nqq7sWKDtV+Q0PMBySoS0HE8OK1fbi6qJ6VCL
         r9slc8RDqbDe0KGlSSh1wInHgfYpvoeh6Km5mi2997dNzmEW6E6V50d0M5tH4RizrENl
         Usog==
X-Gm-Message-State: AKaTC02DlWoytlDrqZ/VnOiMZTedSK4Au3c6EkD63y3IvKHWQX3rl9SSQ5fdAkIJv2okVA==
X-Received: by 10.28.16.65 with SMTP id 62mr7940614wmq.81.1481510775800;
        Sun, 11 Dec 2016 18:46:15 -0800 (PST)
Received: from localhost.localdomain ([104.131.203.210])
        by smtp.gmail.com with ESMTPSA id i10sm54855661wjd.15.2016.12.11.18.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Dec 2016 18:46:15 -0800 (PST)
From:   vi0oss@gmail.com
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, stefanbeller@gmail.com,
        "Vitaly \"_Vi\" Shukela" <vi0oss@gmail.com>
Subject: [PATCH] submodule--helper: set alternateLocation for cloned submodules
Date:   Mon, 12 Dec 2016 05:45:55 +0300
Message-Id: <20161212024555.27868-1-vi0oss@gmail.com>
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
    Reviewed by Stefan Beller <sbeller@google.com>
    
    For "maint" branch.

 builtin/submodule--helper.c    | 19 ++++++++++--
 t/t7408-submodule-reference.sh | 66 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4beeda5..92fd676 100644
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
@@ -672,6 +673,20 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		die(_("could not get submodule directory for '%s'"), path);
 	git_config_set_in_file(p, "core.worktree",
 			       relative_path(path, sm_gitdir, &rel_path));
+
+	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
+	git_config_get_string("submodule.alternateLocation", &sm_alternate);
+	if (sm_alternate)
+		git_config_set_in_file(p, "submodule.alternateLocation",
+					   sm_alternate);
+	git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
+	if (error_strategy)
+		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
+					   error_strategy);
+
+	free(sm_alternate);
+	free(error_strategy);
+
 	strbuf_release(&sb);
 	strbuf_release(&rel_path);
 	free(sm_gitdir);
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index 1c1e289..e159fc5 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -125,4 +125,70 @@ test_expect_success 'ignoring missing submodule alternates passes clone and subm
 	)
 '
 
+test_expect_success 'preparing second superproject with a nested submodule plus partial clone' '
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
+	) &&
+	git clone supersuper supersuper2 &&
+	(
+		cd supersuper2 &&
+		git submodule update --init
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
+		test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub &&
+		# nested submodule also has alternate:
+		test_alternate_is_used .git/modules/subwithsub/modules/sub/objects/info/alternates subwithsub/sub
+	)
+'
+
+check_that_two_of_three_alternates_are_used() {
+	test_alternate_is_used .git/objects/info/alternates . &&
+	# immediate submodule has alternate:
+	test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub &&
+	# but nested submodule has no alternate:
+	test_must_fail test_alternate_is_used .git/modules/subwithsub/modules/sub/objects/info/alternates subwithsub/sub
+}
+
+
+test_expect_success 'missing nested submodule alternate fails clone and submodule update' '
+	test_when_finished "rm -rf supersuper-clone" &&
+	test_must_fail git clone --recursive --reference supersuper2 supersuper2 supersuper-clone &&
+	(
+		cd supersuper-clone &&
+		check_that_two_of_three_alternates_are_used &&
+		# update of the submodule fails
+		test_must_fail git submodule update --init --recursive
+	)
+'
+
+test_expect_success 'missing nested submodule alternate in --reference-if-able mode' '
+	test_when_finished "rm -rf supersuper-clone" &&
+	git clone --recursive --reference-if-able supersuper2 supersuper2 supersuper-clone &&
+	(
+		cd supersuper-clone &&
+		check_that_two_of_three_alternates_are_used &&
+		# update of the submodule succeeds
+		git submodule update --init --recursive
+	)
+'
+
 test_done
-- 
2.10.2

