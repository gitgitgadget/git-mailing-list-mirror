Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34285203C1
	for <e@80x24.org>; Thu, 11 Aug 2016 18:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbcHKSrS (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:47:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34489 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbcHKSrL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:47:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so870158wma.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 11:47:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F2unykANUJ9uUsL490RmqtwtO5meIQJ2V178hQDQtL0=;
        b=Sm+jhc/+V1OrlmoN5PeAxlpTv9jbFAnpvEl6Nkrmrhf0Mx0F/JiyPWOGOf8fWbVBni
         KwxIOA0H3bIJA2z2xib3YJ/+Yf8Jmnk5WzOzGvGS3qpHuxsw1xewFJ9JeEoX8rXjHOU5
         R4+jKcboiWQL0awGaAW3BAkWLmozka4W3cAxCv9KTZcbn5U+uMWzT2mIxEbzHu6I9mAd
         In/wBGBctgunScnMvcZR78829QC1ZgoNlNiBaX7Z2sDDzvMt8F15gn9P8ePwrC0vACKt
         efHLr2gnOiqLU962SetwCcbQ8WIgtMvvqsQCEw7CgIvRWXQGde4PgVJkFqWSfE4zHNew
         J1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F2unykANUJ9uUsL490RmqtwtO5meIQJ2V178hQDQtL0=;
        b=erx91VMA6paXGSCxAnnoKLoiPqBlt0Ty8dal28QD61RWlR+3haXkQNF+upA9GvJB1c
         k/+tiDkP0h3W9bBACHLZ9di6VVRlsWb41eccyI/Pg92sTM7Sl/0B8dBqwkNCm4ZPpL6m
         nv9S364T2qgOhUZrprkN1INP7wTqB0/xJNdKY0rJeOM3ZC3hkPLy9YG23tEhMm8Q4K76
         oZF7n6vsY5Gxaa22poW/6CIVIaG5YTEameHdYTk2GEFIqvNR0P99ASfl+Yy5EQSdOjrH
         EOte2AMkLcNjefaAn9lGQQ04GJMEVvqg4Ah4DNc/zINSmY2G65Ey73JR95iQGQKaO6sl
         aSlA==
X-Gm-Message-State: AEkoouvQQv8NxP+1nDl/RI181zmcb6rZJqLc2yhGkSCI7By0wbFvjIVojI6kQoJ+naM3Ww==
X-Received: by 10.195.13.18 with SMTP id eu18mr11102347wjd.121.1470941229441;
        Thu, 11 Aug 2016 11:47:09 -0700 (PDT)
Received: from localhost.localdomain ([80.215.37.180])
        by smtp.gmail.com with ESMTPSA id 190sm1047236wmk.13.2016.08.11.11.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 11:47:08 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 11/13] apply: refactor `git apply` option parsing
Date:	Thu, 11 Aug 2016 20:44:59 +0200
Message-Id: <20160811184501.384-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.769.gc0f0333
In-Reply-To: <20160811184501.384-1-chriscool@tuxfamily.org>
References: <20160811184501.384-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Parsing `git apply` options can be useful to other commands that
want to call the libified apply functionality, because this way
they can easily pass some options from their own command line to
the libified apply functionality.

This will be used by `git am` in a following patch.

To make this possible, let's refactor the `git apply` option
parsing code into a new libified apply_parse_options() function.

Doing that makes it possible to remove some functions definitions
from "apply.h" and make them static in "apply.c".

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c         | 103 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 apply.h         |  18 +++-------
 builtin/apply.c |  74 ++--------------------------------------
 3 files changed, 97 insertions(+), 98 deletions(-)

diff --git a/apply.c b/apply.c
index bf81b70..2ec2a8a 100644
--- a/apply.c
+++ b/apply.c
@@ -4730,16 +4730,16 @@ static int apply_patch(struct apply_state *state,
 	return res;
 }
 
-int apply_option_parse_exclude(const struct option *opt,
-			       const char *arg, int unset)
+static int apply_option_parse_exclude(const struct option *opt,
+				      const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	add_name_limit(state, arg, 1);
 	return 0;
 }
 
-int apply_option_parse_include(const struct option *opt,
-			       const char *arg, int unset)
+static int apply_option_parse_include(const struct option *opt,
+				      const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	add_name_limit(state, arg, 0);
@@ -4747,9 +4747,9 @@ int apply_option_parse_include(const struct option *opt,
 	return 0;
 }
 
-int apply_option_parse_p(const struct option *opt,
-			 const char *arg,
-			 int unset)
+static int apply_option_parse_p(const struct option *opt,
+				const char *arg,
+				int unset)
 {
 	struct apply_state *state = opt->value;
 	state->p_value = atoi(arg);
@@ -4757,8 +4757,8 @@ int apply_option_parse_p(const struct option *opt,
 	return 0;
 }
 
-int apply_option_parse_space_change(const struct option *opt,
-				    const char *arg, int unset)
+static int apply_option_parse_space_change(const struct option *opt,
+					   const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	if (unset)
@@ -4768,8 +4768,8 @@ int apply_option_parse_space_change(const struct option *opt,
 	return 0;
 }
 
-int apply_option_parse_whitespace(const struct option *opt,
-				  const char *arg, int unset)
+static int apply_option_parse_whitespace(const struct option *opt,
+					 const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	state->whitespace_option = arg;
@@ -4778,8 +4778,8 @@ int apply_option_parse_whitespace(const struct option *opt,
 	return 0;
 }
 
-int apply_option_parse_directory(const struct option *opt,
-				 const char *arg, int unset)
+static int apply_option_parse_directory(const struct option *opt,
+					const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	strbuf_reset(&state->root);
@@ -4893,3 +4893,80 @@ int apply_all_patches(struct apply_state *state,
 		return res;
 	return (res == -1 ? 1 : 128);
 }
+
+int apply_parse_options(int argc, const char **argv,
+			struct apply_state *state,
+			int *force_apply, int *options,
+			const char * const *apply_usage)
+{
+	struct option builtin_apply_options[] = {
+		{ OPTION_CALLBACK, 0, "exclude", state, N_("path"),
+			N_("don't apply changes matching the given path"),
+			0, apply_option_parse_exclude },
+		{ OPTION_CALLBACK, 0, "include", state, N_("path"),
+			N_("apply changes matching the given path"),
+			0, apply_option_parse_include },
+		{ OPTION_CALLBACK, 'p', NULL, state, N_("num"),
+			N_("remove <num> leading slashes from traditional diff paths"),
+			0, apply_option_parse_p },
+		OPT_BOOL(0, "no-add", &state->no_add,
+			N_("ignore additions made by the patch")),
+		OPT_BOOL(0, "stat", &state->diffstat,
+			N_("instead of applying the patch, output diffstat for the input")),
+		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
+		OPT_NOOP_NOARG(0, "binary"),
+		OPT_BOOL(0, "numstat", &state->numstat,
+			N_("show number of added and deleted lines in decimal notation")),
+		OPT_BOOL(0, "summary", &state->summary,
+			N_("instead of applying the patch, output a summary for the input")),
+		OPT_BOOL(0, "check", &state->check,
+			N_("instead of applying the patch, see if the patch is applicable")),
+		OPT_BOOL(0, "index", &state->check_index,
+			N_("make sure the patch is applicable to the current index")),
+		OPT_BOOL(0, "cached", &state->cached,
+			N_("apply a patch without touching the working tree")),
+		OPT_BOOL(0, "unsafe-paths", &state->unsafe_paths,
+			N_("accept a patch that touches outside the working area")),
+		OPT_BOOL(0, "apply", force_apply,
+			N_("also apply the patch (use with --stat/--summary/--check)")),
+		OPT_BOOL('3', "3way", &state->threeway,
+			 N_( "attempt three-way merge if a patch does not apply")),
+		OPT_FILENAME(0, "build-fake-ancestor", &state->fake_ancestor,
+			N_("build a temporary index based on embedded index information")),
+		/* Think twice before adding "--nul" synonym to this */
+		OPT_SET_INT('z', NULL, &state->line_termination,
+			N_("paths are separated with NUL character"), '\0'),
+		OPT_INTEGER('C', NULL, &state->p_context,
+				N_("ensure at least <n> lines of context match")),
+		{ OPTION_CALLBACK, 0, "whitespace", state, N_("action"),
+			N_("detect new or modified lines that have whitespace errors"),
+			0, apply_option_parse_whitespace },
+		{ OPTION_CALLBACK, 0, "ignore-space-change", state, NULL,
+			N_("ignore changes in whitespace when finding context"),
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
+		{ OPTION_CALLBACK, 0, "ignore-whitespace", state, NULL,
+			N_("ignore changes in whitespace when finding context"),
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
+		OPT_BOOL('R', "reverse", &state->apply_in_reverse,
+			N_("apply the patch in reverse")),
+		OPT_BOOL(0, "unidiff-zero", &state->unidiff_zero,
+			N_("don't expect at least one line of context")),
+		OPT_BOOL(0, "reject", &state->apply_with_reject,
+			N_("leave the rejected hunks in corresponding *.rej files")),
+		OPT_BOOL(0, "allow-overlap", &state->allow_overlap,
+			N_("allow overlapping hunks")),
+		OPT__VERBOSE(&state->apply_verbosity, N_("be verbose")),
+		OPT_BIT(0, "inaccurate-eof", options,
+			N_("tolerate incorrectly detected missing new-line at the end of file"),
+			APPLY_OPT_INACCURATE_EOF),
+		OPT_BIT(0, "recount", options,
+			N_("do not trust the line counts in the hunk headers"),
+			APPLY_OPT_RECOUNT),
+		{ OPTION_CALLBACK, 0, "directory", state, N_("root"),
+			N_("prepend <root> to all filenames"),
+			0, apply_option_parse_directory },
+		OPT_END()
+	};
+
+	return parse_options(argc, argv, state->prefix, builtin_apply_options, apply_usage, 0);
+}
diff --git a/apply.h b/apply.h
index 5cde641..e2b89e8 100644
--- a/apply.h
+++ b/apply.h
@@ -111,20 +111,10 @@ struct apply_state {
 	int applied_after_fixing_ws;
 };
 
-extern int apply_option_parse_exclude(const struct option *opt,
-				      const char *arg, int unset);
-extern int apply_option_parse_include(const struct option *opt,
-				      const char *arg, int unset);
-extern int apply_option_parse_p(const struct option *opt,
-				const char *arg,
-				int unset);
-extern int apply_option_parse_whitespace(const struct option *opt,
-					 const char *arg, int unset);
-extern int apply_option_parse_directory(const struct option *opt,
-					const char *arg, int unset);
-extern int apply_option_parse_space_change(const struct option *opt,
-					   const char *arg, int unset);
-
+extern int apply_parse_options(int argc, const char **argv,
+			       struct apply_state *state,
+			       int *force_apply, int *options,
+			       const char * const *apply_usage);
 extern int init_apply_state(struct apply_state *state,
 			    const char *prefix,
 			    struct lock_file *lock_file);
diff --git a/builtin/apply.c b/builtin/apply.c
index 7338701..81b9a61 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -18,80 +18,12 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	int ret;
 	struct apply_state state;
 
-	struct option builtin_apply_options[] = {
-		{ OPTION_CALLBACK, 0, "exclude", &state, N_("path"),
-			N_("don't apply changes matching the given path"),
-			0, apply_option_parse_exclude },
-		{ OPTION_CALLBACK, 0, "include", &state, N_("path"),
-			N_("apply changes matching the given path"),
-			0, apply_option_parse_include },
-		{ OPTION_CALLBACK, 'p', NULL, &state, N_("num"),
-			N_("remove <num> leading slashes from traditional diff paths"),
-			0, apply_option_parse_p },
-		OPT_BOOL(0, "no-add", &state.no_add,
-			N_("ignore additions made by the patch")),
-		OPT_BOOL(0, "stat", &state.diffstat,
-			N_("instead of applying the patch, output diffstat for the input")),
-		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
-		OPT_NOOP_NOARG(0, "binary"),
-		OPT_BOOL(0, "numstat", &state.numstat,
-			N_("show number of added and deleted lines in decimal notation")),
-		OPT_BOOL(0, "summary", &state.summary,
-			N_("instead of applying the patch, output a summary for the input")),
-		OPT_BOOL(0, "check", &state.check,
-			N_("instead of applying the patch, see if the patch is applicable")),
-		OPT_BOOL(0, "index", &state.check_index,
-			N_("make sure the patch is applicable to the current index")),
-		OPT_BOOL(0, "cached", &state.cached,
-			N_("apply a patch without touching the working tree")),
-		OPT_BOOL(0, "unsafe-paths", &state.unsafe_paths,
-			N_("accept a patch that touches outside the working area")),
-		OPT_BOOL(0, "apply", &force_apply,
-			N_("also apply the patch (use with --stat/--summary/--check)")),
-		OPT_BOOL('3', "3way", &state.threeway,
-			 N_( "attempt three-way merge if a patch does not apply")),
-		OPT_FILENAME(0, "build-fake-ancestor", &state.fake_ancestor,
-			N_("build a temporary index based on embedded index information")),
-		/* Think twice before adding "--nul" synonym to this */
-		OPT_SET_INT('z', NULL, &state.line_termination,
-			N_("paths are separated with NUL character"), '\0'),
-		OPT_INTEGER('C', NULL, &state.p_context,
-				N_("ensure at least <n> lines of context match")),
-		{ OPTION_CALLBACK, 0, "whitespace", &state, N_("action"),
-			N_("detect new or modified lines that have whitespace errors"),
-			0, apply_option_parse_whitespace },
-		{ OPTION_CALLBACK, 0, "ignore-space-change", &state, NULL,
-			N_("ignore changes in whitespace when finding context"),
-			PARSE_OPT_NOARG, apply_option_parse_space_change },
-		{ OPTION_CALLBACK, 0, "ignore-whitespace", &state, NULL,
-			N_("ignore changes in whitespace when finding context"),
-			PARSE_OPT_NOARG, apply_option_parse_space_change },
-		OPT_BOOL('R', "reverse", &state.apply_in_reverse,
-			N_("apply the patch in reverse")),
-		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
-			N_("don't expect at least one line of context")),
-		OPT_BOOL(0, "reject", &state.apply_with_reject,
-			N_("leave the rejected hunks in corresponding *.rej files")),
-		OPT_BOOL(0, "allow-overlap", &state.allow_overlap,
-			N_("allow overlapping hunks")),
-		OPT__VERBOSE(&state.apply_verbosity, N_("be verbose")),
-		OPT_BIT(0, "inaccurate-eof", &options,
-			N_("tolerate incorrectly detected missing new-line at the end of file"),
-			APPLY_OPT_INACCURATE_EOF),
-		OPT_BIT(0, "recount", &options,
-			N_("do not trust the line counts in the hunk headers"),
-			APPLY_OPT_RECOUNT),
-		{ OPTION_CALLBACK, 0, "directory", &state, N_("root"),
-			N_("prepend <root> to all filenames"),
-			0, apply_option_parse_directory },
-		OPT_END()
-	};
-
 	if (init_apply_state(&state, prefix, &lock_file))
 		exit(128);
 
-	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
-			apply_usage, 0);
+	argc = apply_parse_options(argc, argv,
+				   &state, &force_apply, &options,
+				   apply_usage);
 
 	if (check_apply_state(&state, force_apply))
 		exit(128);
-- 
2.9.2.769.gc0f0333

