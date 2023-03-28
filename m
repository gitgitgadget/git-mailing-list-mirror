Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E758C761AF
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjC1OAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjC1N7e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B1DC65D
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l8-20020a05600c1d0800b003ef6708bbf6so5467488wms.5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5aEQy+RkiD2KIuh96chCoxsXrOZ/WjAYOe8f142jtA=;
        b=IZ44REJzv0EM4J/8mM2ZnQAyDAD2zxcHEGPXK7XuWMb662swUgRzaagbyt6ezPAcA+
         WHPgvjX6ZwSYDZimfpbNwZjz6Eo3Jz0lr2RoUlFtmRIRFn38Dq8j+ZwmY5L9VCz4anAg
         A5ql/6htb8gjHomFHPo02dG2az+cDFhlcth0k0EHk+3YBnj3x1ByGz9tHSltDQWzsjYk
         5+E74vIFj1cAelUqw/rLzvxa6lNe9tjpmH+Rmhu7KofYuug37hUCBle4H6dZXdRo0nWu
         31eFds/bpQq1YjRTG2cYIT6PW7HVICFsaE4lSFbuYw5aTuLa/z+ObL+nmh0rN7EuTNPV
         yyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5aEQy+RkiD2KIuh96chCoxsXrOZ/WjAYOe8f142jtA=;
        b=v7WOWBqd6P9lN+7oQyGaWC2ZvcDYrJ9YWR6ZsQKUCFWMvuE5N62X70Ybc/brfZGBA9
         nFAs67+JjrJ8zeH1tNVj2e2xDf+159+uozsRNIKsm/8edWrvpya/IkV6C2xHUG7DSO48
         jiQRKPHA5amaXHik7YgtrdEaX8K5v+/EUpswsOvljKAG8AWQ8pAkxBJp9xXGJ4lXJof2
         loWdVJYNn8hqA42qwFmsyd56rscH0D8jCUXraItztx8wkBYmZHoEkDhuge0X9NnzPdxK
         4yYb5p83AkS9bOJ+U52vEaHwbXLLud5GcFuIIs1aWHW3/G0ZJmUdJUW+GA9b1Be/MWFD
         EGVQ==
X-Gm-Message-State: AO0yUKX0hF/ylF7ie2XCTUscJYc+5tbY0COjpuy9qvc0NypqjKgqp3j3
        pl2nPbH68klkykwnslDNt0WnhQFUKSYTEg==
X-Google-Smtp-Source: AK7set+2JVdplVJ0CdAUYABkYmHlVsm1XPosx5mzB+nRX/AJ3//w6RXvMvP0sbnm/l4SP9MkW9OoOg==
X-Received: by 2002:a7b:c4c6:0:b0:3ee:1afc:c15 with SMTP id g6-20020a7bc4c6000000b003ee1afc0c15mr12327745wmk.33.1680011957871;
        Tue, 28 Mar 2023 06:59:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/17] cocci: apply the "pretty.h" part of "the_repository.pending"
Date:   Tue, 28 Mar 2023 15:58:51 +0200
Message-Id: <patch-v2-10.17-10e05c56231-20230328T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"pretty.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c                                       |  3 ++-
 bisect.c                                        |  3 ++-
 builtin/bisect.c                                | 10 ++++++----
 builtin/commit.c                                | 13 ++++++++-----
 builtin/notes.c                                 |  3 ++-
 builtin/shortlog.c                              |  6 ++++--
 contrib/coccinelle/the_repository.cocci         |  4 ++++
 contrib/coccinelle/the_repository.pending.cocci |  4 ----
 fmt-merge-msg.c                                 |  3 ++-
 log-tree.c                                      |  9 ++++++---
 notes-cache.c                                   |  3 ++-
 object-name.c                                   |  6 ++++--
 pretty.c                                        |  3 ++-
 pretty.h                                        |  4 ----
 sequencer.c                                     | 12 ++++++++----
 t/helper/test-revision-walking.c                |  3 ++-
 16 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/archive.c b/archive.c
index c6eaa6d6146..98de324362a 100644
--- a/archive.c
+++ b/archive.c
@@ -61,7 +61,8 @@ static void format_subst(const struct commit *commit,
 		strbuf_add(&fmt, b + 8, c - b - 8);
 
 		strbuf_add(buf, src, b - src);
-		format_commit_message(commit, fmt.buf, buf, ctx);
+		repo_format_commit_message(the_repository, commit, fmt.buf,
+					   buf, ctx);
 		len -= c + 1 - src;
 		src  = c + 1;
 	}
diff --git a/bisect.c b/bisect.c
index 5998e4b2e32..d55f2a4da5d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -753,7 +753,8 @@ enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
 	}
 
 	commit = lookup_commit_reference(the_repository, bisect_rev);
-	format_commit_message(commit, "[%H] %s%n", &commit_msg, &pp);
+	repo_format_commit_message(the_repository, commit, "[%H] %s%n",
+				   &commit_msg, &pp);
 	fputs(commit_msg.buf, stdout);
 	strbuf_release(&commit_msg);
 
diff --git a/builtin/bisect.c b/builtin/bisect.c
index f925ceeb3c0..6b01e3c3e8e 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -267,7 +267,8 @@ static void log_commit(FILE *fp, char *fmt, const char *state,
 	struct strbuf commit_msg = STRBUF_INIT;
 	char *label = xstrfmt(fmt, state);
 
-	format_commit_message(commit, "%s", &commit_msg, &pp);
+	repo_format_commit_message(the_repository, commit, "%s", &commit_msg,
+				   &pp);
 
 	fprintf(fp, "# %s: [%s] %s\n", label, oid_to_hex(&commit->object.oid),
 		commit_msg.buf);
@@ -605,8 +606,8 @@ static int bisect_skipped_commits(struct bisect_terms *terms)
 
 	while ((commit = get_revision(&revs)) != NULL) {
 		strbuf_reset(&commit_name);
-		format_commit_message(commit, "%s",
-				      &commit_name, &pp);
+		repo_format_commit_message(the_repository, commit, "%s",
+					   &commit_name, &pp);
 		fprintf(fp, "# possible first %s commit: [%s] %s\n",
 			terms->term_bad, oid_to_hex(&commit->object.oid),
 			commit_name.buf);
@@ -635,7 +636,8 @@ static int bisect_successful(struct bisect_terms *terms)
 
 	read_ref(bad_ref, &oid);
 	commit = lookup_commit_reference_by_name(bad_ref);
-	format_commit_message(commit, "%s", &commit_name, &pp);
+	repo_format_commit_message(the_repository, commit, "%s", &commit_name,
+				   &pp);
 
 	res = append_to_file(git_path_bisect_log(), "# first %s commit: [%s] %s\n",
 			    terms->term_bad, oid_to_hex(&commit->object.oid),
diff --git a/builtin/commit.c b/builtin/commit.c
index c64fc50e923..b8b4893ab20 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -719,7 +719,7 @@ static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
 	 * duplicate the subject line.
 	 */
 	fmt = starts_with(subject, "amend!") ? "%b" : "%B";
-	format_commit_message(commit, fmt, sb, ctx);
+	repo_format_commit_message(the_repository, commit, fmt, sb, ctx);
 	repo_unuse_commit_buffer(the_repository, commit, buffer);
 }
 
@@ -760,8 +760,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			if (!c)
 				die(_("could not lookup commit %s"), squash_message);
 			ctx.output_encoding = get_commit_output_encoding();
-			format_commit_message(c, "squash! %s\n\n", &sb,
-					      &ctx);
+			repo_format_commit_message(the_repository, c,
+						   "squash! %s\n\n", &sb,
+						   &ctx);
 		}
 	}
 
@@ -795,7 +796,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			die(_("could not lookup commit %s"), fixup_commit);
 		ctx.output_encoding = get_commit_output_encoding();
 		fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
-		format_commit_message(commit, fmt, &sb, &ctx);
+		repo_format_commit_message(the_repository, commit, fmt, &sb,
+					   &ctx);
 		free(fmt);
 		hook_arg1 = "message";
 
@@ -1135,7 +1137,8 @@ static const char *find_author_by_nickname(const char *name)
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode.type = DATE_NORMAL;
 		strbuf_release(&buf);
-		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
+		repo_format_commit_message(the_repository, commit,
+					   "%aN <%aE>", &buf, &ctx);
 		release_revisions(&revs);
 		return strbuf_detach(&buf, NULL);
 	}
diff --git a/builtin/notes.c b/builtin/notes.c
index 4b13943be7f..859a56591aa 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -744,7 +744,8 @@ static int merge_commit(struct notes_merge_options *o)
 
 	/* Reuse existing commit message in reflog message */
 	memset(&pretty_ctx, 0, sizeof(pretty_ctx));
-	format_commit_message(partial, "%s", &msg, &pretty_ctx);
+	repo_format_commit_message(the_repository, partial, "%s", &msg,
+				   &pretty_ctx);
 	strbuf_trim(&msg);
 	strbuf_insertstr(&msg, 0, "notes: ");
 	update_ref(msg.buf, o->local_ref, &oid,
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 8afd1ad865e..62f91b8b932 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -223,7 +223,8 @@ static void insert_records_from_format(struct shortlog *log,
 	for_each_string_list_item(item, &log->format) {
 		strbuf_reset(&buf);
 
-		format_commit_message(commit, item->string, &buf, ctx);
+		repo_format_commit_message(the_repository, commit,
+					   item->string, &buf, ctx);
 
 		if (!shortlog_needs_dedup(log) || strset_add(dups, buf.buf))
 			insert_one_record(log, buf.buf, oneline);
@@ -249,7 +250,8 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		if (log->user_format)
 			pretty_print_commit(&ctx, commit, &oneline);
 		else
-			format_commit_message(commit, "%s", &oneline, &ctx);
+			repo_format_commit_message(the_repository, commit,
+						   "%s", &oneline, &ctx);
 	}
 	oneline_str = oneline.len ? oneline.buf : "<none>";
 
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index fa159aba5b5..ff4c56114f1 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -87,6 +87,10 @@
 |
 - has_object_file_with_flags
 + repo_has_object_file_with_flags
+// pretty.h
+|
+- format_commit_message
++ repo_format_commit_message
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 69e9694111e..375850e773c 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,11 +5,7 @@
 @@
 @@
 (
-// pretty.h
-- format_commit_message
-+ repo_format_commit_message
 // packfile.h
-|
 - approximate_object_count
 + repo_approximate_object_count
 // promisor-remote.h
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 5aab1d06619..5236b75fab2 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -383,7 +383,8 @@ static void shortlog(const char *name,
 		if (subjects.nr > limit)
 			continue;
 
-		format_commit_message(commit, "%s", &sb, &ctx);
+		repo_format_commit_message(the_repository, commit, "%s", &sb,
+					   &ctx);
 		strbuf_ltrim(&sb);
 
 		if (!sb.len)
diff --git a/log-tree.c b/log-tree.c
index 5c97bc403fb..f65c36e19dc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -410,7 +410,8 @@ void fmt_output_commit(struct strbuf *filename,
 	struct pretty_print_context ctx = {0};
 	struct strbuf subject = STRBUF_INIT;
 
-	format_commit_message(commit, "%f", &subject, &ctx);
+	repo_format_commit_message(the_repository, commit, "%f", &subject,
+				   &ctx);
 	fmt_output_subject(filename, subject.buf, info);
 	strbuf_release(&subject);
 }
@@ -988,8 +989,10 @@ static int do_remerge_diff(struct rev_info *opt,
 	o.msg_header_prefix = "remerge";
 
 	ctx.abbrev = DEFAULT_ABBREV;
-	format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
-	format_commit_message(parent2, "%h (%s)", &parent2_desc, &ctx);
+	repo_format_commit_message(the_repository, parent1, "%h (%s)",
+				   &parent1_desc, &ctx);
+	repo_format_commit_message(the_repository, parent2, "%h (%s)",
+				   &parent2_desc, &ctx);
 	o.branch1 = parent1_desc.buf;
 	o.branch2 = parent2_desc.buf;
 
diff --git a/notes-cache.c b/notes-cache.c
index 38466091360..e5e9092d367 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -23,7 +23,8 @@ static int notes_cache_match_validity(struct repository *r,
 		return 0;
 
 	memset(&pretty_ctx, 0, sizeof(pretty_ctx));
-	format_commit_message(commit, "%s", &msg, &pretty_ctx);
+	repo_format_commit_message(the_repository, commit, "%s", &msg,
+				   &pretty_ctx);
 	strbuf_trim(&msg);
 
 	ret = !strcmp(msg.buf, validity);
diff --git a/object-name.c b/object-name.c
index b297cbd0a18..c7cef682f20 100644
--- a/object-name.c
+++ b/object-name.c
@@ -395,8 +395,10 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
-			format_commit_message(commit, "%ad", &date, &pp);
-			format_commit_message(commit, "%s", &msg, &pp);
+			repo_format_commit_message(the_repository, commit,
+						   "%ad", &date, &pp);
+			repo_format_commit_message(the_repository, commit,
+						   "%s", &msg, &pp);
 		}
 
 		/*
diff --git a/pretty.c b/pretty.c
index 34e0a3bc786..0ce6ab7e196 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2202,7 +2202,8 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	int need_8bit_cte = pp->need_8bit_cte;
 
 	if (pp->fmt == CMIT_FMT_USERFORMAT) {
-		format_commit_message(commit, user_format, sb, pp);
+		repo_format_commit_message(the_repository, commit,
+					   user_format, sb, pp);
 		return;
 	}
 
diff --git a/pretty.h b/pretty.h
index 921dd6e0cae..421209e9ec2 100644
--- a/pretty.h
+++ b/pretty.h
@@ -120,10 +120,6 @@ void repo_format_commit_message(struct repository *r,
 			const struct commit *commit,
 			const char *format, struct strbuf *sb,
 			const struct pretty_print_context *context);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define format_commit_message(c, f, s, con) \
-	repo_format_commit_message(the_repository, c, f, s, con)
-#endif
 
 /*
  * Parse given arguments from "arg", check it for correctness and
diff --git a/sequencer.c b/sequencer.c
index 749455a2597..d0ad37700fd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1341,8 +1341,10 @@ void print_commit_summary(struct repository *r,
 
 	strbuf_addstr(&format, "format:%h] %s");
 
-	format_commit_message(commit, "%an <%ae>", &author_ident, &pctx);
-	format_commit_message(commit, "%cn <%ce>", &committer_ident, &pctx);
+	repo_format_commit_message(the_repository, commit, "%an <%ae>",
+				   &author_ident, &pctx);
+	repo_format_commit_message(the_repository, commit, "%cn <%ce>",
+				   &committer_ident, &pctx);
 	if (strbuf_cmp(&author_ident, &committer_ident)) {
 		strbuf_addstr(&format, "\n Author: ");
 		strbuf_addbuf_percentquote(&format, &author_ident);
@@ -1350,7 +1352,8 @@ void print_commit_summary(struct repository *r,
 	if (flags & SUMMARY_SHOW_AUTHOR_DATE) {
 		struct strbuf date = STRBUF_INIT;
 
-		format_commit_message(commit, "%ad", &date, &pctx);
+		repo_format_commit_message(the_repository, commit, "%ad",
+					   &date, &pctx);
 		strbuf_addstr(&format, "\n Date: ");
 		strbuf_addbuf_percentquote(&format, &date);
 		strbuf_release(&date);
@@ -2123,7 +2126,8 @@ static void refer_to_commit(struct replay_opts *opts,
 			.abbrev = DEFAULT_ABBREV,
 			.date_mode.type = DATE_SHORT,
 		};
-		format_commit_message(commit, "%h (%s, %ad)", msgbuf, &ctx);
+		repo_format_commit_message(the_repository, commit,
+					   "%h (%s, %ad)", msgbuf, &ctx);
 	} else {
 		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
 	}
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 4a45d5bac2a..c7b22cb33d5 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -19,7 +19,8 @@ static void print_commit(struct commit *commit)
 	struct strbuf sb = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 	ctx.date_mode.type = DATE_NORMAL;
-	format_commit_message(commit, " %m %s", &sb, &ctx);
+	repo_format_commit_message(the_repository, commit, " %m %s", &sb,
+				   &ctx);
 	printf("%s\n", sb.buf);
 	strbuf_release(&sb);
 }
-- 
2.40.0.rc1.1034.g5867a1b10c5

