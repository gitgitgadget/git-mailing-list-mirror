Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ECCC1F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeESF2t (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:28:49 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36542 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbeESF2q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:28:46 -0400
Received: by mail-lf0-f65.google.com with SMTP id t129-v6so16883892lff.3
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tmBtGllD9Zr4rETJQmridjQsapnlQNr/BbmgLwj4Uh4=;
        b=aM/Z1SnukK3uHEd2IWC/aXVf2SKTsjD4M+6apszfnSsCWblgX2S16E4g7It3I+cDG0
         pbuXeF9ofgVlBoGUQUFBROy7yv9ABahtfyjN6t1LP60bfS3hjSfkzHtSC1kvatMBameU
         3d3g5YSwsvb9oueRoYOvx0iKQOIyQrVYMNgiHjoFZXjkgv0/fuztoHrpRaF2MT0IZv/h
         10uoiV0qiv+WrfMlkgoz+px4tPj6aUmmRQgsGpcSdaYE5Y5rEECIOKViuxjOoznDokfH
         zZBZYZ3Kp4P3olBlBNGeTLNZYkgdHiO6sOxlpo1JzgWcJcZv9QtD8J0KlwaIEwVJlAjv
         6vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tmBtGllD9Zr4rETJQmridjQsapnlQNr/BbmgLwj4Uh4=;
        b=FCQRugOpOBuPFddHHLM5td5orXJQAUasCunrX0iRtl8w08FYKC+Fa/FyO4YOTCpMMu
         +8L36DJlUgLLqg3jtXy5h+LtfDd17JI/Jao2p3xUGefPsgZV6XeH0Vvn/WUpYc1z5d97
         j9bdR/b6RGQEm6qvv7/Skponjj7SsBUoNUlPFuYTNoDgCtrk9r2FTnHfd/2kl3+F6xQ4
         xFAb/OLKGxQ5ZmpGvnjcnNwACVuOlHVzJFnt0OBlRymdOimW33CHps7n8fnzX/zhl4Gu
         W1OsCE7asSw/8hJZPlLnHRT/QsHM6+VxOkIiQJJoLKb/1vR2CwI1IylU8vkLxetxJppt
         jI9A==
X-Gm-Message-State: ALKqPwfu/HzUOjR7IekIa7tZgnTh8av9nFVJGxFp4AjkmQBLvG+8WDkm
        LtjYJeBC7JSDuvP9ZmbbKmFs5Q==
X-Google-Smtp-Source: AB8JxZqIWCaz3PlDUaJ8kh6sh6P3NTD/Kwfvu4b+CMWq8G+TDqZpEHIWdNeinWMssnsBfWOzrgWhEQ==
X-Received: by 2002:a2e:944d:: with SMTP id o13-v6mr7564935ljh.65.1526707724328;
        Fri, 18 May 2018 22:28:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1490874ljh.84.2018.05.18.22.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 22:28:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 08/15] revision.c: use commit-slab for show_source
Date:   Sat, 19 May 2018 07:28:24 +0200
Message-Id: <20180519052831.12603-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519052831.12603-1-pclouds@gmail.com>
References: <20180513055208.17952-1-pclouds@gmail.com>
 <20180519052831.12603-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of relying on commit->util to store the source string, let the
user provide a commit-slab to store the source strings in.

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.
---
 builtin/fast-export.c | 14 +++++++++-----
 builtin/log.c         |  7 +++++--
 log-tree.c            |  8 ++++++--
 revision.c            | 19 +++++++++++++++----
 revision.h            |  5 ++++-
 5 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 530df12f05..5aaf5c8e59 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -21,6 +21,7 @@
 #include "quote.h"
 #include "remote.h"
 #include "blob.h"
+#include "commit-slab.h"
 
 static const char *fast_export_usage[] = {
 	N_("git fast-export [rev-list-opts]"),
@@ -38,6 +39,7 @@ static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct refspec *refspecs;
 static int refspecs_nr;
 static int anonymize;
+static struct revision_sources revision_sources;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -590,7 +592,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
 			export_blob(&diff_queued_diff.queue[i]->two->oid);
 
-	refname = commit->util;
+	refname = *revision_sources_at(&revision_sources, commit);
 	if (anonymize) {
 		refname = anonymize_refname(refname);
 		anonymize_ident_line(&committer, &committer_end);
@@ -862,10 +864,11 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		 * This ref will not be updated through a commit, lets make
 		 * sure it gets properly updated eventually.
 		 */
-		if (commit->util || commit->object.flags & SHOWN)
+		if (*revision_sources_at(&revision_sources, commit) ||
+		    commit->object.flags & SHOWN)
 			string_list_append(&extra_refs, full_name)->util = commit;
-		if (!commit->util)
-			commit->util = full_name;
+		if (!*revision_sources_at(&revision_sources, commit))
+			*revision_sources_at(&revision_sources, commit) = full_name;
 	}
 }
 
@@ -1029,8 +1032,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	init_revisions(&revs, prefix);
+	init_revision_sources(&revision_sources);
 	revs.topo_order = 1;
-	revs.show_source = 1;
+	revs.sources = &revision_sources;
 	revs.rewrite_parents = 1;
 	argc = parse_options(argc, argv, prefix, options, fast_export_usage,
 			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
diff --git a/builtin/log.c b/builtin/log.c
index 71f68a3e4f..d017e57475 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -148,6 +148,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
 	struct decoration_filter decoration_filter = {&decorate_refs_include,
 						      &decorate_refs_exclude};
+	static struct revision_sources revision_sources;
 
 	const struct option builtin_log_options[] = {
 		OPT__QUIET(&quiet, N_("suppress diff output")),
@@ -194,8 +195,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	    rev->diffopt.filter || rev->diffopt.flags.follow_renames)
 		rev->always_show_header = 0;
 
-	if (source)
-		rev->show_source = 1;
+	if (source) {
+		init_revision_sources(&revision_sources);
+		rev->sources = &revision_sources;
+	}
 
 	if (mailmap) {
 		rev->mailmap = xcalloc(1, sizeof(struct string_list));
diff --git a/log-tree.c b/log-tree.c
index d1c0bedf24..0b41ee3235 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -295,8 +295,12 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	if (opt->show_source && commit->util)
-		fprintf(opt->diffopt.file, "\t%s", (char *) commit->util);
+	if (opt->sources) {
+		char **slot = revision_sources_peek(opt->sources, commit);
+
+		if (slot && *slot)
+			fprintf(opt->diffopt.file, "\t%s", *slot);
+	}
 	if (!opt->show_decorations)
 		return;
 	format_decorations(&sb, commit, opt->diffopt.use_color);
diff --git a/revision.c b/revision.c
index 1cff11833e..be8fe7d67b 100644
--- a/revision.c
+++ b/revision.c
@@ -29,6 +29,8 @@ volatile show_early_output_fn_t show_early_output;
 static const char *term_bad;
 static const char *term_good;
 
+implement_shared_commit_slab(revision_sources, char *);
+
 void show_object_with_name(FILE *out, struct object *obj, const char *name)
 {
 	const char *p;
@@ -255,14 +257,19 @@ static struct commit *handle_commit(struct rev_info *revs,
 	 */
 	if (object->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)object;
+
 		if (parse_commit(commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
 			revs->limited = 1;
 		}
-		if (revs->show_source && !commit->util)
-			commit->util = xstrdup(name);
+		if (revs->sources) {
+			char **slot = revision_sources_at(revs->sources, commit);
+
+			if (!*slot)
+				*slot = xstrdup(name);
+		}
 		return commit;
 	}
 
@@ -814,8 +821,12 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			}
 			return -1;
 		}
-		if (revs->show_source && !p->util)
-			p->util = commit->util;
+		if (revs->sources) {
+			char **slot = revision_sources_at(revs->sources, p);
+
+			if (!*slot)
+				*slot = *revision_sources_at(revs->sources, commit);
+		}
 		p->object.flags |= left_flag;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= SEEN;
diff --git a/revision.h b/revision.h
index b8c47b98e2..bf2239f876 100644
--- a/revision.h
+++ b/revision.h
@@ -6,6 +6,7 @@
 #include "notes.h"
 #include "pretty.h"
 #include "diff.h"
+#include "commit-slab-decl.h"
 
 /* Remember to update object flag allocation in object.h */
 #define SEEN		(1u<<0)
@@ -29,6 +30,7 @@ struct rev_info;
 struct log_info;
 struct string_list;
 struct saved_parents;
+define_shared_commit_slab(revision_sources, char *);
 
 struct rev_cmdline_info {
 	unsigned int nr;
@@ -111,7 +113,6 @@ struct rev_info {
 			right_only:1,
 			rewrite_parents:1,
 			print_parents:1,
-			show_source:1,
 			show_decorations:1,
 			reverse:1,
 			reverse_output_stage:1,
@@ -224,6 +225,8 @@ struct rev_info {
 
 	struct commit_list *previous_parents;
 	const char *break_bar;
+
+	struct revision_sources *sources;
 };
 
 extern int ref_excluded(struct string_list *, const char *path);
-- 
2.17.0.705.g3525833791

