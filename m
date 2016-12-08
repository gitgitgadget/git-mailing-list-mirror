Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADFF21FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 00:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933825AbcLHAj6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 19:39:58 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36122 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932441AbcLHAj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 19:39:57 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so123558wma.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 16:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=y1fKve/pFYFPVjGrhAomzXZH1EnX+takCE2sQCwwsEg=;
        b=B24By3N2V5j9toVl2nAjwme8xjWV9ZbOZtQeTdPqIImKhx6HLjIF8WIM+WRsv+8IrO
         iC/HMhT8BpFsmnqtHeNkehot1fXbtARAnFAhUHOr/dDJIt3AqP/tXFG/bNRvOTs8uBx0
         BsVYMFEBF7c1ShhFzKJENQSVXXucDLS+WOFLeLILJOH4JSaU9T1ZzUJw5uf/HncJ2+1w
         q+sS80vXMa6ffK5pILjp5fbHSs6Is/OeELaJROcBSJ18JYaehGe2F4loiePcWYt8/+pp
         JarpW8PZaf2DcsM+UBTSXvZDWuR07yhEh1TTBsH//fTb/gwZjkGz52SSDKAfQK6qBF+6
         +2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y1fKve/pFYFPVjGrhAomzXZH1EnX+takCE2sQCwwsEg=;
        b=E48gjqzmF7YaGy8g7DqhOD08++RQU7ZW2db+vF3NJKaRAcfAI7wYkHnQK6j8fqpX5w
         Zr7csSfTtsM0kXt3JLeMFUr8ZamevBaS0mXHRTC4ejgaJSBFSLsaYcc/Qfb4tbmGjSWk
         EtM5uQvAQCWaY0NQn7sExnwvcemThM0bG0HbUp0sBXQOI/ig5WVfQGcApJLH6hCHRtnZ
         NYLj6MAn7K7hCbWKREFgb62aJ48ouFHtohHIa2rBwfD9SusAPJfPb5n1yPM80lQHXALe
         uoWiUmHAPLM36KHCp2DKSXDTIs4vJWMcXb/H6RWQPh2GUObJVdQyMddYH6R8T0vCqimn
         As6Q==
X-Gm-Message-State: AKaTC01cBav1T2I06yMSI0jTM8yW1PQmppFBYqXN/ADO1HFbyv+OG6y1RgMBJ3ecZzbZTg==
X-Received: by 10.28.182.4 with SMTP id g4mr5336903wmf.15.1481157595935;
        Wed, 07 Dec 2016 16:39:55 -0800 (PST)
Received: from localhost.localdomain ([104.131.203.210])
        by smtp.gmail.com with ESMTPSA id 204sm12335181wmj.7.2016.12.07.16.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 16:39:55 -0800 (PST)
From:   vi0oss@gmail.com
To:     git@vger.kernel.org
Cc:     stefanbeller@gmail.com, "Vitaly \"_Vi\" Shukela" <vi0oss@gmail.com>
Subject: [PATCH] submodule--helper: set alternateLocation for cloned submodules
Date:   Thu,  8 Dec 2016 03:39:40 +0300
Message-Id: <20161208003940.28794-1-vi0oss@gmail.com>
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
    Another round of fixups:
    
    * Corrected code style
    * Refactored and fixed the test
    
    Previously test contained errorneous
    test_must_fail, which was masked by
    missing &&.
    
    Mailmap patch omitted this time.

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
index 1c1e289..9325297 100755
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
+		test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub
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

