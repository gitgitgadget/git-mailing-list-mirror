Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F12CC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFB961184
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbhEQQow (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbhEQQoo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:44:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650B6C08C5EC
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i22so9499909lfl.10
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/t+hUkeB9Tm2lEHiXqCwwDhWnmrWjtJvPvOrpVz+zc=;
        b=sy5uzQmF8YyUZnx/Xk4HIsZffZFNVTt+dQTbjdv8QbsvwbTQHAa6bji5Hvb9jrjLp+
         vgTGtvgmc6I5YCtc1VwtoJCaZ4JW8I/80jsdbl1GbYv6WenIjXa0mlMgLhwtRDPFrtvj
         U5+Eb5rB8hI7OzxRf1c8P2s+nK+7MjvZczAdzWNojEB2+HYxHV9sjc+jrD4XNAhtuVz6
         HwXVFfmoMGMeB6ZwPLvvI3ZMcMKmDuyQ63A4tmq+w/Zk7qjuzLl3xGt0fyamykwlBTGF
         br6NbbV3Hd5nNY0JZMfLeu+w8+ig5N8Nb71nOFRKCzHyVTGMzPp1O7D1h/QOrbsX51z/
         3PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/t+hUkeB9Tm2lEHiXqCwwDhWnmrWjtJvPvOrpVz+zc=;
        b=TZ1SRkJMLHUM1VTHtFOPZNcTipX1irFUylXa3gJDby3dIXThh2XD0L29SEQPBRdB5o
         OJlU+7txoqRMiZkWjEJoCDrOgX0443V0UwDEGJFgFgPTI3kz+r/LCEJ70OfehtPqirHb
         aD4+cx9yhoGQrN+BP1GbVtB3ClWt44pw2bCgu/9dIQVrHaLjkdLyk6jB4lpOhOBMzW/V
         flprbjuinpJrujtyMJydUxBt2nNnirRQVLrPT1Urc6fJWMUg+tPYeSJFnyDwaPQ9vuQn
         WYiYbA2fwYJGcvN6bMbDtf4CN9EXkcG3HeBRugKuN9d261YDKWa7m1UN/Jz+x3HK0PaA
         AXCg==
X-Gm-Message-State: AOAM5311ysgPUoEkbWSNMvhIMbZn/KgGQpK2W23pTPWsO+lGe6s4SXXy
        SukZA7eg+56OYuaGk2URhSE=
X-Google-Smtp-Source: ABdhPJwaJWPwiKGbQNawpHajxj0DdxmttxKl/hsAoyTb8F3WS+z71lRACOtMRM6bLEpqk0LLalhhVQ==
X-Received: by 2002:ac2:4884:: with SMTP id x4mr385106lfc.119.1621267117857;
        Mon, 17 May 2021 08:58:37 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i8sm1996834lfd.12.2021.05.17.08.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:58:37 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 0/9] diff-merges: let -m imply -p
Date:   Mon, 17 May 2021 18:58:09 +0300
Message-Id: <20210517155818.32224-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix long standing inconsistency between -c/--cc that do imply -p, on
one side, and -m that did not imply -p, on the other side.

Only the last patch is the actual functional change. The reset of
patches are additional tests and refactorings that are not expected to
alter existing behaviors.

After these patches

  git log -m

will start to produce diffs without need to provide -p as well, that
improves both consistency and usability. It gets even more useful if
one sets "log.diffMerges" configuration variable to "first-parent" to
force -m produce usual diff with respect to first parent only.

These patches don't change behavior when specific diff format is
explicitly provided on the command-line, so that commands like

  git log -m --raw
  git log -m --stat

are not affected.

Exact historical semantics of -m is still provided by
--diff-merges=separate.

Updates in v1:

  * Stop parsing distinct diff-index options beforehand, as it could
    cause unexpected behaviors. Implement different strategy to avoid
    clash of diff-index "-m" and diff-merges "-m".

  * Added tests for "git log -m --raw" and "git log -m".

Sergey Organov (9):
  t4013: test that "-m" alone has no effect in "git log"
  t4013: test "git -m --raw"
  t4013: test "git -m --stat"
  t4013: test "git diff-index -m"
  diff-merges: move specific diff-index "-m" handling to diff-index
  git-svn: stop passing "-m" to "git rev-list"
  stash list: stop passing "-m" to "git list"
  diff-merges: rename "combined_imply_patch" to "merges_imply_patch"
  diff-merges: let "-m" imply "-p"

 Documentation/diff-options.txt    |  8 ++--
 builtin/diff-index.c              |  9 +++++
 builtin/stash.c                   |  2 +-
 diff-merges.c                     | 36 +++++++++--------
 diff-merges.h                     |  2 +
 perl/Git/SVN.pm                   |  2 +-
 revision.h                        |  2 +-
 t/t3903-stash.sh                  |  2 +-
 t/t4013-diff-various.sh           | 23 +++++++++++
 t/t4013/diff.log_-m_--raw_master  | 61 ++++++++++++++++++++++++++++
 t/t4013/diff.log_-m_--stat_master | 66 +++++++++++++++++++++++++++++++
 11 files changed, 188 insertions(+), 25 deletions(-)
 create mode 100644 t/t4013/diff.log_-m_--raw_master
 create mode 100644 t/t4013/diff.log_-m_--stat_master

Interdiff against v0:
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 28bc51d0d8f4..cf09559e422d 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
+#include "diff-merges.h"
 #include "commit.h"
 #include "revision.h"
 #include "builtin.h"
@@ -12,37 +13,11 @@ static const char diff_cache_usage[] =
 "[<common-diff-options>] <tree-ish> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
-static int parse_distinct_options(int argc, const char **argv,
-				  struct rev_info *revs, unsigned int *options)
-{
-	int i, left;
-
-	for (i = left = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		int leave = 0;
-
-		if (!strcmp(arg, "--cached"))
-			*options |= DIFF_INDEX_CACHED;
-		else if (!strcmp(arg, "--merge-base"))
-			*options |= DIFF_INDEX_MERGE_BASE;
-		else if (!strcmp(arg, "-m"))
-			revs->match_missing = 1;
-		else
-			leave = 1;
-
-		if (leave)
-			argv[left++] = arg;
-	}
-
-	argv[left] = NULL;
-
-	return left;
-}
-
 int cmd_diff_index(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 	unsigned int option = 0;
+	int i;
 	int result;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -54,15 +29,24 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 
 	/*
-	 * It's essential to parse our distinct options before calling
-	 * setup_revisions(), for the latter not to see "-m".
+	 * We need no diff for merges options, and we need to avoid conflict
+	 * with our own meaning of "-m".
 	 */
-	argc = parse_distinct_options(argc, argv, &rev, &option);
+	diff_merges_suppress_options_parsing();
+
 	argc = setup_revisions(argc, argv, &rev, NULL);
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
 
-	if (argc > 1)
-		usage(diff_cache_usage);
-
+		if (!strcmp(arg, "--cached"))
+			option |= DIFF_INDEX_CACHED;
+		else if (!strcmp(arg, "--merge-base"))
+			option |= DIFF_INDEX_MERGE_BASE;
+		else if (!strcmp(arg, "-m"))
+			rev.match_missing = 1;
+		else
+			usage(diff_cache_usage);
+	}
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 
diff --git a/diff-merges.c b/diff-merges.c
index a827482a97ff..0dfcaa1b11b0 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -6,6 +6,7 @@ typedef void (*diff_merges_setup_func_t)(struct rev_info *);
 static void set_separate(struct rev_info *revs);
 
 static diff_merges_setup_func_t set_to_default = set_separate;
+static int suppress_parsing;
 
 static void suppress(struct rev_info *revs)
 {
@@ -90,12 +91,20 @@ int diff_merges_config(const char *value)
 	return 0;
 }
 
+void diff_merges_suppress_options_parsing(void)
+{
+	suppress_parsing = 1;
+}
+
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 {
 	int argcount = 1;
 	const char *optarg;
 	const char *arg = argv[0];
 
+	if (suppress_parsing)
+		return 0;
+
 	if (!strcmp(arg, "-m")) {
 		set_to_default(revs);
 		revs->merges_imply_patch = 1;
@@ -145,6 +154,9 @@ void diff_merges_set_dense_combined_if_unset(struct rev_info *revs)
 
 void diff_merges_setup_revs(struct rev_info *revs)
 {
+	if (suppress_parsing)
+		return;
+
 	if (revs->combine_merges == 0)
 		revs->dense_combined_merges = 0;
 	if (revs->separate_merges == 0)
diff --git a/diff-merges.h b/diff-merges.h
index 09d9a6c9a4fb..b5d57f6563e3 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -11,6 +11,8 @@ struct rev_info;
 
 int diff_merges_config(const char *value);
 
+void diff_merges_suppress_options_parsing(void);
+
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
 
 void diff_merges_suppress(struct rev_info *revs);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index bd16d4885cfd..15ca3c75bff7 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -337,6 +337,8 @@ log -m -p --first-parent master
 log -m -p master
 log --cc -m -p master
 log -c -m -p master
+log -m --raw master
+log -m --stat master
 log -SF master
 log -S F master
 log -SF -p master
@@ -452,6 +454,14 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
+test_expect_success 'log -m matches log -m -p' '
+	git log -m -p master >result &&
+	process_diffs result >expected &&
+	git log -m >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
 	git log -p --diff-merges=separate master >result &&
 	process_diffs result >expected &&
diff --git a/t/t4013/diff.log_-m_--raw_master b/t/t4013/diff.log_-m_--raw_master
new file mode 100644
index 000000000000..cd2ecc462832
--- /dev/null
+++ b/t/t4013/diff.log_-m_--raw_master
@@ -0,0 +1,61 @@
+$ git log -m --raw master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+:100644 100644 cead32e... 992913c... M	dir/sub
+:100644 100644 b414108... 10a8a9f... M	file0
+
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+:100644 100644 7289e35... 992913c... M	dir/sub
+:100644 100644 f4615da... 10a8a9f... M	file0
+:000000 100644 0000000... b1e6722... A	file1
+:100644 000000 01e79c3... 0000000... D	file2
+:100644 000000 7289e35... 0000000... D	file3
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+:100644 100644 35d242b... 7289e35... M	dir/sub
+:100644 100644 01e79c3... f4615da... M	file0
+:000000 100644 0000000... 7289e35... A	file3
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+:100644 100644 8422d40... cead32e... M	dir/sub
+:000000 100644 0000000... b1e6722... A	file1
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+:100644 100644 35d242b... 8422d40... M	dir/sub
+:100644 100644 01e79c3... b414108... M	file0
+:100644 000000 01e79c3... 0000000... D	file2
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
diff --git a/t/t4013/diff.log_-m_--stat_master b/t/t4013/diff.log_-m_--stat_master
new file mode 100644
index 000000000000..c7db084fd905
--- /dev/null
+++ b/t/t4013/diff.log_-m_--stat_master
@@ -0,0 +1,66 @@
+$ git log -m --stat master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+ dir/sub | 2 ++
+ file0   | 3 +++
+ 2 files changed, 5 insertions(+)
+
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+ dir/sub | 4 ++++
+ file0   | 3 +++
+ file1   | 3 +++
+ file2   | 3 ---
+ file3   | 4 ----
+ 5 files changed, 10 insertions(+), 7 deletions(-)
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
+ 3 files changed, 9 insertions(+)
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+ dir/sub | 2 ++
+ file1   | 3 +++
+ 2 files changed, 5 insertions(+)
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
+ 3 files changed, 5 insertions(+), 3 deletions(-)
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
-- 
2.25.1

