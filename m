Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F2FC433E6
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67EE764E2E
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhBWBLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 20:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhBWBLd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 20:11:33 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E9CC06178A
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 17:10:53 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id x14so14783111qkm.2
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 17:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TbO1zt/X+JGd8omuGI7GLSIVH48owqp2UOkHxbgbu7k=;
        b=vR2YMJRQNO+yWYIeJL4xmwmps4ktRv5aK5P5KsLOTXOzC5AedYaxugGyZRqkkdkKqp
         vrYqu4UQ5RocvH3FhGgOWDSvMBTQf/D5ZbX34LZT/Rp2Tb0Yf5hQBPPgN9wQt+Pe4TVp
         LxrxmvY4itVh5ES/kuHnESDONE/XCs7d8x4QTMV16L5oR/lvDPC+YcJmoJYjvmbq2xep
         FsoUKmr6fkdzlKD5nLsiaTu8g6yOPSBlAVuqM0uwsP8NuEcqSCeu1Ft+nR2KCMHZsHwk
         0vBkykEhinqZqCS9H3FNEgocu0yn+lVMkyaIV1/VbHva3W0jKiesGgPYvEM8lLOqKbZ8
         H5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbO1zt/X+JGd8omuGI7GLSIVH48owqp2UOkHxbgbu7k=;
        b=YswA/jyGSDgClCIYuOohFCVoAaYcMyAhMoWnrWd9GyuBDRvnSrLBZnPlTQ6b2/tW7M
         5DjEY13f5aV5Lf3oru8EO97wKH1InjG7V/F/GYLqIOyFDy67B/o/THabMtvPldj2R/dH
         sPBAq/cGyH9HPSCtuY+I+XwmkUgqsrJ/cpakYQvrv4sjwTrhgxi40hbwugsNdBK/ztDK
         eRaahI0JSP54wg42bzeeUSKSst5g5HgvCvu63I/BajrpO9tNRAVGYMITOnWCDDughZYr
         tGCp6pSGO1AagmlbyWUXbZHWxdyzS+fehaPKuVqBh8d85m6wiLGqEDUPXv3+u3ffUF6G
         hx4A==
X-Gm-Message-State: AOAM532jnJfRbDtp1sbtK4mILVGDybCsRr8j56/H07oXPkzXkYvWV7lO
        jOhwFYUgsfkjuA5Qsvp4gKt/oG3VAsQi2A==
X-Google-Smtp-Source: ABdhPJxt+ndb7UCH0hwphh3rPIvY3Tkozc17Ins5oFsM/FqWTL3h76060bWyyEWai1Iq4cdHQxobsg==
X-Received: by 2002:a05:620a:20ce:: with SMTP id f14mr21164727qka.163.1614042652257;
        Mon, 22 Feb 2021 17:10:52 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id v75sm13599070qkb.14.2021.02.22.17.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 17:10:51 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Subject: [PATCH 3/3] add: propagate --chmod errors to exit status
Date:   Mon, 22 Feb 2021 22:10:35 -0300
Message-Id: <f3fe47aa6d9aec39e521182120c732d12bdfe96c.1614037664.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614037664.git.matheus.bernardino@usp.br>
References: <cover.1614037664.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If `add` encounters an error while applying the --chmod changes, it
prints a message to stderr, but exits with a success code. This might
have been an oversight, as the command does exit with a non-zero code in
other situations where it cannot (or refuses to) update all of the
requested paths (e.g. when some of the given paths are ignored). So make
the exit behavior more consistent by also propagating --chmod errors to
the exit status.

Note: the test "all statuses changed in folder if . is given" uses paths
added by previous test cases, some of which might be symbolic links.
Because `git add --chmod` will now fail with such paths, this test would
depend on whether all the previous tests were executed, or only some
of them. Avoid that by running the test on a fresh repo with only
regular files.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c  | 10 ++++++----
 t/t3700-add.sh | 28 ++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0c5f53c0bb..ea762a41e3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -38,9 +38,9 @@ struct update_callback_data {
 	int add_errors;
 };
 
-static void chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
+static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 {
-	int i;
+	int i, ret = 0;
 
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
@@ -55,8 +55,10 @@ static void chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 			err = S_ISREG(ce->ce_mode) ? 0 : -1;
 
 		if (err < 0)
-			error(_("cannot chmod %cx '%s'"), flip, ce->name);
+			ret = error(_("cannot chmod %cx '%s'"), flip, ce->name);
 	}
+
+	return ret;
 }
 
 static int fix_unmerged_status(struct diff_filepair *p,
@@ -615,7 +617,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		exit_status |= add_files(&dir, flags);
 
 	if (chmod_arg && pathspec.nr)
-		chmod_pathspec(&pathspec, chmod_arg[0], show_only);
+		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
 	unplug_bulk_checkin();
 
 finish:
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 6a8b94a4f7..d402c775c0 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -386,6 +386,16 @@ test_expect_success POSIXPERM 'git add --chmod=[+-]x does not change the working
 	! test -x foo4
 '
 
+test_expect_success 'git add --chmod fails with non regular files (but updates the other paths)' '
+	git reset --hard &&
+	test_ln_s_add foo foo3 &&
+	touch foo4 &&
+	test_must_fail git add --chmod=+x foo3 foo4 2>stderr &&
+	test_i18ngrep "cannot chmod +x .foo3." stderr &&
+	test_mode_in_index 120000 foo3 &&
+	test_mode_in_index 100755 foo4
+'
+
 test_expect_success 'git add --chmod honors --dry-run' '
 	git reset --hard &&
 	echo foo >foo4 &&
@@ -397,7 +407,7 @@ test_expect_success 'git add --chmod honors --dry-run' '
 test_expect_success 'git add --chmod --dry-run reports error for non regular files' '
 	git reset --hard &&
 	test_ln_s_add foo foo4 &&
-	git add --chmod=+x --dry-run foo4 2>stderr &&
+	test_must_fail git add --chmod=+x --dry-run foo4 2>stderr &&
 	test_i18ngrep "cannot chmod +x .foo4." stderr
 '
 
@@ -429,11 +439,17 @@ test_expect_success 'no file status change if no pathspec is given in subdir' '
 '
 
 test_expect_success 'all statuses changed in folder if . is given' '
-	rm -fr empty &&
-	git add --chmod=+x . &&
-	test $(git ls-files --stage | grep ^100644 | wc -l) -eq 0 &&
-	git add --chmod=-x . &&
-	test $(git ls-files --stage | grep ^100755 | wc -l) -eq 0
+	git init repo &&
+	(
+		cd repo &&
+		mkdir -p sub/dir &&
+		touch x y z sub/a sub/dir/b &&
+		git add -A &&
+		git add --chmod=+x . &&
+		test $(git ls-files --stage | grep ^100644 | wc -l) -eq 0 &&
+		git add --chmod=-x . &&
+		test $(git ls-files --stage | grep ^100755 | wc -l) -eq 0
+	)
 '
 
 test_expect_success CASE_INSENSITIVE_FS 'path is case-insensitive' '
-- 
2.30.1

