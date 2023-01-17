Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF43C54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjAQRLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjAQRLe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:34 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF37367D7
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s3so7849157edd.4
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG+7ZZwi7C15rKfBHpcosgJoEHQ/85pRKJLqCcfbtc0=;
        b=AwPqlrfgvc42yhjf520o/EEFasIlxoaML9FLTR+xQl0FEg+M8uI9lf6G6p/1YmwbJJ
         lUp261M91tpKXqIM9hfLAYjsZXziLpZMcb3uJE3wLlOV8PbAxT/GeO6ctpN3BQFfqB4v
         4klXQKi83hV9T3CvCn3s15OTuoltsAqGJxcdeRwBZHc9QsghhDGj8863IqrINBO25rBr
         r8vaLfNtK99LCsmva5RWpLjYxKYiWJXYHk2xV8vS9u/aJMyLYV8J4CrbE0OGwHhiYVQ9
         5OE70pJDRjRBvyX5868U5ln0pBw9RIOUasPmsnkgE0f2kEd4gASwsnfgdY/gn15I09H9
         XrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cG+7ZZwi7C15rKfBHpcosgJoEHQ/85pRKJLqCcfbtc0=;
        b=0Wt9+lDLHYClGH7JDlvMzPD1NWoRe0To5qxRYwTIbNhTnGV8+6QDGDwMYDWh7V8SZM
         qixTBMkGkijSlIfoQLJnegra9QRJYyxd+DdO2QlnY1ovcT2lHhqdl4GofOr5i5iL+tHl
         a/T0wYASsQm95dg3OZkWXskkqF7WSicoEmHQK/mMuU/5ttHf0bGhcSpFasad08qDVlwT
         wmP3krR70miiIPKos/vfqBTSqTyS4L8/sNq39vTl1ADxGHFX1zYjritp22+Lv1gvI8cf
         WVQ1ONrZDnJ5zSz77N7XZamtu7XiHfXx0l3IZ3/RLgrEKuQ+fNGZYChjj1wg/skZ2Sjp
         VRMw==
X-Gm-Message-State: AFqh2krXzED4rav/nGJ6LLm3vgogvDcsiC1dBAZFGiDm3RWLg0i8ZTuG
        diYbXYBsIyRL1BDv5x2PO68br7NfatAR4A==
X-Google-Smtp-Source: AMrXdXtuRlAaLyeVuX6sQ2GBfCBLe0o7jR1fIvuwWQGFU6O06ZndbOj/DrHGLl6XHILXpCn6VZA6oA==
X-Received: by 2002:a05:6402:4d6:b0:46c:6ed1:83ac with SMTP id n22-20020a05640204d600b0046c6ed183acmr3912994edw.9.1673975490716;
        Tue, 17 Jan 2023 09:11:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/19] various: add missing clear_pathspec(), fix leaks
Date:   Tue, 17 Jan 2023 18:11:10 +0100
Message-Id: <patch-v4-05.19-93a8f8fa1b9-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks resulting from a missing clear_pathspec().

- archive.c: Plug a leak in the "struct archiver_args", and
  clear_pathspec() the "pathspec" member that the "parse_pathspec_arg()"
  call in this function populates.

- builtin/clean.c: Fix a memory leak that's been with us since
  893d839970c (clean: convert to use parse_pathspec, 2013-07-14).

- builtin/reset.c: Add clear_pathspec() calls to cmd_reset(),
  including to the codepaths where we'd return early.

- builtin/stash.c: Call clear_pathspec() on the pathspec initialized
  in push_stash().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c                       |  1 +
 builtin/clean.c                 |  1 +
 builtin/reset.c                 | 11 ++++++++---
 builtin/stash.c                 |  7 +++++--
 t/t5001-archive-attr.sh         |  1 +
 t/t5004-archive-corner-cases.sh |  2 ++
 t/t7105-reset-patch.sh          |  2 ++
 t/t7106-reset-unborn-branch.sh  |  2 ++
 t/t7107-reset-pathspec-file.sh  |  1 +
 t/t7301-clean-interactive.sh    |  1 +
 10 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/archive.c b/archive.c
index 941495f5d78..a2d813e50db 100644
--- a/archive.c
+++ b/archive.c
@@ -710,6 +710,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 
 	string_list_clear_func(&args.extra_files, extra_file_info_clear);
 	free(args.refname);
+	clear_pathspec(&args.pathspec);
 
 	return rc;
 }
diff --git a/builtin/clean.c b/builtin/clean.c
index b2701a28158..b15eab328b7 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -1092,5 +1092,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	strbuf_release(&buf);
 	string_list_clear(&del_list, 0);
 	string_list_clear(&exclude_list, 0);
+	clear_pathspec(&pathspec);
 	return (errors != 0);
 }
diff --git a/builtin/reset.c b/builtin/reset.c
index fea20a9ba0b..e9c10618cd3 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -390,7 +390,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		if (reset_type != NONE)
 			die(_("options '%s' and '%s' cannot be used together"), "--patch", "--{hard,mixed,soft}");
 		trace2_cmd_mode("patch-interactive");
-		return run_add_interactive(rev, "--patch=reset", &pathspec);
+		update_ref_status = run_add_interactive(rev, "--patch=reset", &pathspec);
+		goto cleanup;
 	}
 
 	/* git reset tree [--] paths... can be used to
@@ -439,8 +440,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				       LOCK_DIE_ON_ERROR);
 		if (reset_type == MIXED) {
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
-			if (read_from_tree(&pathspec, &oid, intent_to_add))
-				return 1;
+			if (read_from_tree(&pathspec, &oid, intent_to_add)) {
+				update_ref_status = 1;
+				goto cleanup;
+			}
 			the_index.updated_skipworktree = 1;
 			if (!no_refresh && get_git_work_tree()) {
 				uint64_t t_begin, t_delta_in_ms;
@@ -488,5 +491,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	discard_index(&the_index);
 
+cleanup:
+	clear_pathspec(&pathspec);
 	return update_ref_status;
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index bb0fd861434..45bffdf54bb 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1727,6 +1727,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 		OPT_END()
 	};
+	int ret;
 
 	if (argc) {
 		force_assume = !strcmp(argv[0], "-p");
@@ -1766,8 +1767,10 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
-	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
-			     include_untracked, only_staged);
+	ret = do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
+			    include_untracked, only_staged);
+	clear_pathspec(&ps);
+	return ret;
 }
 
 static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 2f6eef5e372..04d300eeda7 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -3,6 +3,7 @@
 test_description='git archive attribute tests'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SUBSTFORMAT='%H (%h)%n'
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index ae508e21623..9f2c6da80e8 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test corner cases of git-archive'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # the 10knuls.tar file is used to test for an empty git generated tar
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index fc2a6cf5c7a..9b46da7aaa7 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git reset --patch'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success PERL 'setup' '
diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
index ecb85c3b823..a0b67a0b843 100755
--- a/t/t7106-reset-unborn-branch.sh
+++ b/t/t7106-reset-unborn-branch.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git reset should work on unborn branch'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index 523efbecde1..af5ea406db3 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -2,6 +2,7 @@
 
 test_description='reset --pathspec-from-file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index a07e8b86de2..d82a3210a1d 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -2,6 +2,7 @@
 
 test_description='git clean -i basic tests'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-- 
2.39.0.1225.g30a3d88132d

