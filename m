Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD15C433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 17:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41CC564EEC
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 17:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhBVR11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 12:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhBVR10 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 12:27:26 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D7AC06174A
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 09:26:46 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o63so10634496pgo.6
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 09:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=maf97Lo+OhJ1y8p31jT6Hk4GnYvAuhkf+1ZvCGXLtLc=;
        b=kN/PRS2dj65QjjZ4hxeLn1v1Pyzc3eOeYf3f+HPESTA34lsI4GUvTZIfdKMjfHZIp6
         ONmeu6Ao/KFnu3rJxl7JqCtOph5RpaS5oiRlkkzF2NNMLpJQytbX3UK/0tau8yMpXc+h
         bksE/18MrZNQWvRd4NTiWAKlXVyf40kiI+V1Y1zBzn8X8nTH0ZkeQHvTbgKHgCY6FX9C
         QftMZ5FboZ5n96LnomGkJI7GZ1fjsoWT+cUCsuwcmG3uxKZ4Tg/VEgPUseLf1+YRu2yu
         EZBHlc3c9P0R3Q3t9FnN61Hx59FTSo5Q44TeRlPSzAaFluMhKFbCgOAgE56PdDm9iDLC
         l7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=maf97Lo+OhJ1y8p31jT6Hk4GnYvAuhkf+1ZvCGXLtLc=;
        b=K6WPKEIj6qT6C8enZFAFOwpoBjOyxeVa8EXdhjgeeZFN3XP709TKaY1mMp2DcvGIcu
         N5RPb84/A+ZF1Og3rWNRQ/Du+zLyXrSzmfFA+qT8JxVY4qKXltYFrUPJOXed5OBEC1yt
         S3CNWuZG2alK1Tc0KRr+jpX/94ByuNP4zqPaXwRYCOdNi9epsR2LYoLpWBLNjFdni5wF
         kEKy83ElZ+E5zcJuPqCFDKpbiAWJGLFR3Ehs6RUvTdHEZgTt5vmRG/h8A7svEjCEOZtk
         IT7PAPnBqYsv8MS+HrYCMf098ftIQ3KC2BlvqS6b/vYdQq9S/f395w2Zv42plZhauXZ0
         Ulzg==
X-Gm-Message-State: AOAM5335kLa85nJC687TYXW8WJ9WqvzvgV4lGRHSvTNQgb8A1cnou/+F
        ilT18JMTuv92xvZWjaK21lE=
X-Google-Smtp-Source: ABdhPJzn+Nt/3x221h8wvE58TabxVoA3UzcVU3+BQzCw+c22omF0Ym+sP8PxQWhKVqu6Mfp/g0vxvg==
X-Received: by 2002:a63:5d59:: with SMTP id o25mr20203437pgm.322.1614014805963;
        Mon, 22 Feb 2021 09:26:45 -0800 (PST)
Received: from localhost.localdomain ([122.161.0.245])
        by smtp.gmail.com with ESMTPSA id x80sm4737437pfc.71.2021.02.22.09.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 09:26:45 -0800 (PST)
From:   Shourya Shukla <periperidip@gmail.com>
To:     periperidip@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        levraiphilippeblain@gmail.com,
        Javier Mora <javier.moradesambricio@rtx.com>
Subject: [PATCH v2 1/1] rm: stage submodule removal from '.gitmodules' when using '--cached'
Date:   Mon, 22 Feb 2021 22:56:23 +0530
Message-Id: <20210222172623.69313-2-periperidip@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222172623.69313-1-periperidip@gmail.com>
References: <20210218184931.83613-1-periperidip@gmail.com>
 <20210222172623.69313-1-periperidip@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, using 'git rm --cached <submodule>' removes the submodule
<submodule> from the index and leaves the submodule working tree
intact in the superproject working tree, but does not stage any
changes to the '.gitmodules' file, in contrast to 'git rm <submodule>',
which removes both the submodule and its configuration in '.gitmodules'
from the worktree and index.

Fix this inconsistency by also staging the removal of the entry of the
submodule from the '.gitmodules' file, leaving the worktree copy intact,
a behaviour which is more in line with what might be expected when
using '--cached'.

Achieve this by modifying the function 'remove_path_from_gitmodules()'
to also take in the parameter 'index_only' denoting the presence of
the '--cached' option. If present, remove the submodule entry from the
copy of the '.gitmodules' in the index otherwise, do the same for the
working tree copy.

While at it, also change the test 46 of the test script 't3600-rm.sh' to
incorporate for the above changes.

Reported-by: Javier Mora <javier.moradesambricio@rtx.com>
Helped-by: Phillipe Blain <levraiphilippeblain@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/rm.c  | 42 +++++++++++++++++++++---------------------
 submodule.c   |  5 +++--
 submodule.h   |  2 +-
 t/t3600-rm.sh |  6 ++----
 4 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 4858631e0f..5854ef0996 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -254,7 +254,7 @@ static struct option builtin_rm_options[] = {
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	struct lock_file lock_file = LOCK_INIT;
-	int i;
+	int i, removed = 0;
 	struct pathspec pathspec;
 	char *seen;
 
@@ -365,30 +365,33 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (show_only)
 		return 0;
 
-	/*
-	 * Then, unless we used "--cached", remove the filenames from
-	 * the workspace. If we fail to remove the first one, we
-	 * abort the "git rm" (but once we've successfully removed
-	 * any file at all, we'll go ahead and commit to it all:
-	 * by then we've already committed ourselves and can't fail
-	 * in the middle)
-	 */
-	if (!index_only) {
-		int removed = 0, gitmodules_modified = 0;
-		struct strbuf buf = STRBUF_INIT;
-		for (i = 0; i < list.nr; i++) {
-			const char *path = list.entry[i].name;
-			if (list.entry[i].is_submodule) {
+	for (i = 0; i < list.nr; i++) {
+		const char *path = list.entry[i].name;
+		if (list.entry[i].is_submodule) {
+			/*
+			 * Then, unless we used "--cached", remove the filenames from
+			 * the workspace. If we fail to remove the first one, we
+			 * abort the "git rm" (but once we've successfully removed
+			 * any file at all, we'll go ahead and commit to it all:
+			 * by then we've already committed ourselves and can't fail
+			 * in the middle)
+			 */
+			if (!index_only) {
+				struct strbuf buf = STRBUF_INIT;
 				strbuf_reset(&buf);
 				strbuf_addstr(&buf, path);
 				if (remove_dir_recursively(&buf, 0))
 					die(_("could not remove '%s'"), path);
 
 				removed = 1;
-				if (!remove_path_from_gitmodules(path))
-					gitmodules_modified = 1;
-				continue;
+				strbuf_release(&buf);
 			}
+			if (!remove_path_from_gitmodules(path, index_only))
+				stage_updated_gitmodules(&the_index);
+
+			continue;
+		}
+		if (!index_only) {
 			if (!remove_path(path)) {
 				removed = 1;
 				continue;
@@ -396,9 +399,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			if (!removed)
 				die_errno("git rm: '%s'", path);
 		}
-		strbuf_release(&buf);
-		if (gitmodules_modified)
-			stage_updated_gitmodules(&the_index);
 	}
 
 	if (write_locked_index(&the_index, &lock_file,
diff --git a/submodule.c b/submodule.c
index 9767ba9893..6ce8c8d0d8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -131,7 +131,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
  * path is configured. Return 0 only if a .gitmodules file was found, a section
  * with the correct path=<path> setting was found and we could remove it.
  */
-int remove_path_from_gitmodules(const char *path)
+int remove_path_from_gitmodules(const char *path, int index_only)
 {
 	struct strbuf sect = STRBUF_INIT;
 	const struct submodule *submodule;
@@ -149,7 +149,8 @@ int remove_path_from_gitmodules(const char *path)
 	}
 	strbuf_addstr(&sect, "submodule.");
 	strbuf_addstr(&sect, submodule->name);
-	if (git_config_rename_section_in_file(GITMODULES_FILE, sect.buf, NULL) < 0) {
+	if (git_config_rename_section_in_file(index_only ? GITMODULES_INDEX :
+					      GITMODULES_FILE, sect.buf, NULL) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not remove .gitmodules entry for %s"), path);
 		strbuf_release(&sect);
diff --git a/submodule.h b/submodule.h
index 4ac6e31cf1..4d8707d911 100644
--- a/submodule.h
+++ b/submodule.h
@@ -43,7 +43,7 @@ int is_gitmodules_unmerged(const struct index_state *istate);
 int is_writing_gitmodules_ok(void);
 int is_staging_gitmodules_ok(struct index_state *istate);
 int update_path_in_gitmodules(const char *oldpath, const char *newpath);
-int remove_path_from_gitmodules(const char *path);
+int remove_path_from_gitmodules(const char *path, int index_only);
 void stage_updated_gitmodules(struct index_state *istate);
 void set_diffopt_flags_from_submodule_config(struct diff_options *,
 					     const char *path);
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 7547f11a5c..c0ca4be5a1 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -390,16 +390,14 @@ test_expect_success 'rm of a populated submodule with different HEAD fails unles
 	test_must_fail git config -f .gitmodules submodule.sub.path
 '
 
-test_expect_success 'rm --cached leaves work tree of populated submodules and .gitmodules alone' '
+test_expect_success 'rm --cached leaves work tree of populated submodules alone' '
 	git reset --hard &&
 	git submodule update &&
 	git rm --cached submod &&
 	test_path_is_dir submod &&
 	test_path_is_file submod/.git &&
 	git status -s -uno >actual &&
-	test_cmp expect.cached actual &&
-	git config -f .gitmodules submodule.sub.url &&
-	git config -f .gitmodules submodule.sub.path
+	test_cmp expect.cached actual
 '
 
 test_expect_success 'rm --dry-run does not touch the submodule or .gitmodules' '
-- 
2.25.1

