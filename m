Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC85420193
	for <e@80x24.org>; Mon,  5 Sep 2016 09:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932744AbcIEJps (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 05:45:48 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60105 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932413AbcIEJpa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 05:45:30 -0400
X-AuditID: 1207440e-dc3ff70000000931-38-57cd3eae0679
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 9C.98.02353.EAE3DC75; Mon,  5 Sep 2016 05:45:19 -0400 (EDT)
Received: from bagpipes.fritz.box (p57907BC3.dip0.t-ipconnect.de [87.144.123.195])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u859iwtV008788
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 5 Sep 2016 05:45:16 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 8/8] blame: honor the diff heuristic options and config
Date:   Mon,  5 Sep 2016 11:44:53 +0200
Message-Id: <8c78cd7079c925f93488850154fc8352db4e4cb8.1473068229.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473068229.git.mhagger@alum.mit.edu>
References: <cover.1473068229.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsUixO6iqLve7my4waNn4hZdV7qZLBp6rzBb
        7F7cz2yx4uocZoszW4Gs2yvmM1v8aOlhtph51dpi8+Z2FgdOj7/vPzB57Jx1l91jwaZSj2e9
        exg9Ll5S9ti/dBubx+dNch63n21jCeCI4rJJSc3JLEst0rdL4Mq4e7WbuWCFe8XyN1uZGxgn
        WHcxcnBICJhITL1Z0MXIxSEksJVRYvvjI4wQzkkmiecd39i7GDk52AR0JRb1NDOB2CIC4hJv
        j89kByliFvjLJLH40V02kISwgJdE/4RpYA0sAqoSi5b1gcV5BaIkHi76zQJiSwjISVza9oUZ
        xOYUsJBY8qUPrF5IwFxi3rxm5gmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrr5WaW
        6KWmlG5ihAQf3w7G9vUyhxgFOBiVeHgttM+EC7EmlhVX5h5ilORgUhLlLVA9Gy7El5SfUpmR
        WJwRX1Sak1p8iFGCg1lJhDfHFijHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgST
        leHgUJLgVQNpFCxKTU+tSMvMKUFIM3FwggznARrubAMyvLggMbc4Mx0if4pRUUqcNwUkIQCS
        yCjNg+uFJYdXjOJArwjz3gJZwQNMLHDdr4AGMwENXrf7NMjgkkSElFQDY7T0MYOuU5riU14d
        XrDdVVEjYZlbt9ryg59UIv4w1v9S7P67bauD9532josy7594MQndE+V3mRy757aCVMu7n0en
        q1hmqsxYvCDUT3HSgdS6LpkbfbZ584x8j76pk5urvu9gXlT4Mvuef/Lh7/kKfnAXnVMLrr/z
        ylZuhoFCiPOe2vJr+/4IKLEUZyQaajEXFScCAN/BL7fpAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach "git blame" and "git annotate" the --compaction-heuristic and
--indent-heuristic options that are now supported by "git diff".

Also teach them to honor the `diff.compactionHeuristic` and
`diff.indentHeuristic` configuration options.

It would be conceivable to introduce separate configuration options for
"blame" and "annotate"; for example `blame.compactionHeuristic` and
`blame.indentHeuristic`. But it would be confusing to users if blame
output is inconsistent with diff output, so it makes more sense for them
to respect the same configuration.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/diff-heuristic-options.txt |  7 +++++++
 Documentation/diff-options.txt           |  8 +-------
 Documentation/git-annotate.txt           |  1 +
 Documentation/git-blame.txt              |  2 ++
 builtin/blame.c                          | 12 ++++++++++++
 diff.c                                   | 29 +++++++++++++++++------------
 diff.h                                   |  1 +
 t/t4059-diff-indent.sh                   | 29 +++++++++++++++++++++++++++++
 8 files changed, 70 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/diff-heuristic-options.txt

diff --git a/Documentation/diff-heuristic-options.txt b/Documentation/diff-heuristic-options.txt
new file mode 100644
index 0000000..36cb549
--- /dev/null
+++ b/Documentation/diff-heuristic-options.txt
@@ -0,0 +1,7 @@
+--indent-heuristic::
+--no-indent-heuristic::
+--compaction-heuristic::
+--no-compaction-heuristic::
+	These are to help debugging and tuning experimental heuristics
+	(which are off by default) that shift diff hunk boundaries to
+	make patches easier to read.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index ffc2b60..d6d41e4 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -63,13 +63,7 @@ ifndef::git-format-patch[]
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
---indent-heuristic::
---no-indent-heuristic::
---compaction-heuristic::
---no-compaction-heuristic::
-	These are to help debugging and tuning experimental heuristics
-	(which are off by default) that shift diff hunk boundaries to
-	make patches easier to read.
+include::diff-heuristic-options.txt[]
 
 --minimal::
 	Spend extra time to make sure the smallest possible
diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
index 05fd482..94be4b8 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -23,6 +23,7 @@ familiar command name for people coming from other SCM systems.
 OPTIONS
 -------
 include::blame-options.txt[]
+include::diff-heuristic-options.txt[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index ba54175..9dccb33 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -89,6 +89,8 @@ include::blame-options.txt[]
 	abbreviated object name, use <n>+1 digits. Note that 1 column
 	is used for a caret to mark the boundary commit.
 
+include::diff-heuristic-options.txt[]
+
 
 THE PORCELAIN FORMAT
 --------------------
diff --git a/builtin/blame.c b/builtin/blame.c
index 7ec7823..f7b67f8 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2220,6 +2220,8 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (git_diff_heuristic_config(var, value, cb) < 0)
+		return -1;
 	if (userdiff_config(var, value) < 0)
 		return -1;
 
@@ -2549,6 +2551,15 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+
+		/*
+		 * The following two options are parsed by parse_revision_opt()
+		 * and are only included here to get included in the "-h"
+		 * output:
+		 */
+		{ OPTION_LOWLEVEL_CALLBACK, 0, "indent-heuristic", NULL, NULL, N_("Use an experimental indent-based heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
+		{ OPTION_LOWLEVEL_CALLBACK, 0, "compaction-heuristic", NULL, NULL, N_("Use an experimental blank-line-based heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
+
 		OPT_BIT(0, "minimal", &xdl_opts, N_("Spend extra cycles to find better match"), XDF_NEED_MINIMAL),
 		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("Use revisions from <file> instead of calling git-rev-list")),
 		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("Use <file>'s contents as the final image")),
@@ -2595,6 +2606,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	}
 parse_done:
 	no_whole_file_rename = !DIFF_OPT_TST(&revs.diffopt, FOLLOW_RENAMES);
+	xdl_opts |= revs.diffopt.xdl_opts & (XDF_COMPACTION_HEURISTIC | XDF_INDENT_HEURISTIC);
 	DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
 	argc = parse_options_end(&ctx);
 
diff --git a/diff.c b/diff.c
index 8b15ed7..8a2003d 100644
--- a/diff.c
+++ b/diff.c
@@ -175,6 +175,21 @@ void init_diff_ui_defaults(void)
 	diff_detect_rename_default = 1;
 }
 
+int git_diff_heuristic_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "diff.indentheuristic")) {
+		diff_indent_heuristic = git_config_bool(var, value);
+		if (diff_indent_heuristic)
+			diff_compaction_heuristic = 0;
+	}
+	if (!strcmp(var, "diff.compactionheuristic")) {
+		diff_compaction_heuristic = git_config_bool(var, value);
+		if (diff_compaction_heuristic)
+			diff_indent_heuristic = 0;
+	}
+	return 0;
+}
+
 int git_diff_ui_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
@@ -191,18 +206,6 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_detect_rename_default = git_config_rename(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.indentheuristic")) {
-		diff_indent_heuristic = git_config_bool(var, value);
-		if (diff_indent_heuristic)
-			diff_compaction_heuristic = 0;
-		return 0;
-	}
-	if (!strcmp(var, "diff.compactionheuristic")) {
-		diff_compaction_heuristic = git_config_bool(var, value);
-		if (diff_compaction_heuristic)
-			diff_indent_heuristic = 0;
-		return 0;
-	}
 	if (!strcmp(var, "diff.autorefreshindex")) {
 		diff_auto_refresh_index = git_config_bool(var, value);
 		return 0;
@@ -243,6 +246,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (git_diff_heuristic_config(var, value, cb) < 0)
+		return -1;
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
diff --git a/diff.h b/diff.h
index 7883729..1ecc9b6 100644
--- a/diff.h
+++ b/diff.h
@@ -266,6 +266,7 @@ extern int parse_long_opt(const char *opt, const char **argv,
 			 const char **optarg);
 
 extern int git_diff_basic_config(const char *var, const char *value, void *cb);
+extern int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 extern void init_diff_ui_defaults(void);
 extern int git_diff_ui_config(const char *var, const char *value, void *cb);
 extern void diff_setup(struct diff_options *);
diff --git a/t/t4059-diff-indent.sh b/t/t4059-diff-indent.sh
index 0a65b58..5564506 100755
--- a/t/t4059-diff-indent.sh
+++ b/t/t4059-diff-indent.sh
@@ -14,6 +14,14 @@ compare_diff () {
 	test_cmp .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
 
+# Compare blame output using the expectation for a diff as reference.
+# Only look for the lines coming from non-boundary commits.
+compare_blame () {
+	sed -n -e "1,4d" -e "s/^\+//p" <"$1" >.tmp-1
+	sed -ne "s/^[^^][^)]*) *//p" <"$2" >.tmp-2
+	test_cmp .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
+
 test_expect_success 'prepare' '
 	cat <<-\EOF >spaces.txt &&
 	1
@@ -184,4 +192,25 @@ test_expect_success 'diff: nice functions with --indent-heuristic' '
 	compare_diff functions-compacted-expect out-compacted
 '
 
+test_expect_success 'blame: ugly spaces' '
+	git blame old..new -- spaces.txt >out-blame &&
+	compare_blame spaces-expect out-blame
+'
+
+test_expect_success 'blame: nice spaces with --indent-heuristic' '
+	git blame --indent-heuristic old..new -- spaces.txt >out-blame-compacted &&
+	compare_blame spaces-compacted-expect out-blame-compacted
+'
+
+test_expect_success 'blame: nice spaces with diff.indentHeuristic' '
+	git -c diff.indentHeuristic=true blame old..new -- spaces.txt >out-blame-compacted2 &&
+	compare_blame spaces-compacted-expect out-blame-compacted2
+'
+
+test_expect_success 'blame: --no-indent-heuristic overrides config' '
+	git -c diff.indentHeuristic=true blame --no-indent-heuristic old..new -- spaces.txt >out-blame2 &&
+	git blame old..new -- spaces.txt >out-blame &&
+	compare_blame spaces-expect out-blame2
+'
+
 test_done
-- 
2.9.3

