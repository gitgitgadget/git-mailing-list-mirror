Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D938C7618A
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCQPgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCQPgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:36:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B0C2A176
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so21969240edb.6
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVNmwJwPcdE+Cy+hi9A9oWkWDvesC/vb95+vG3u5NAs=;
        b=e5D0jkhoLeUdY2/tJzIx61GgSqIdTOsHGdSdxb9wqwcwUsxP8FGbbZ5v/yehc6Krs9
         cNOTvWYI5iXBcUyE/1ojWe4YRcsbMo0Kfl3QOnF/gLUNOp+9CyR4Vrb7+zxU7ZrKsNQK
         jKFlTN/YK6HuaIOQ0Btdio7DnIG3dxiJ99mbz1isiE0y+80QkPrCW5wmLCWj8XVTnnjo
         DkcRJdBv/65ObQTD3n/UkNkxpwZNlTQKWsiTmqbZvK9/F5P5FFXaTbX54dqiAzva56w8
         oEYhbFbOu4hZ8fiOX/OuU6wFfzvFBbxPHDfDfacrO8tYbyi8UD/63Fdo+o6OkuPvUic7
         nvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVNmwJwPcdE+Cy+hi9A9oWkWDvesC/vb95+vG3u5NAs=;
        b=4+oDeI/JMm1d43AWilyW9fLpWO0xy1BdPvSc4netdxWcGONU7KgfEdUmKAXNwt4mdi
         iUZwm/7HK/iancgQ0yV0T7DK44V81JKQ2x4v3Hb+R9L17Pjq5MP/m20SUzZHqa/2020e
         0qRrjVmIQxIm2kr19D8aUtY8poTcZA6PT4LEJjU7lqBPsv7lnEeSSv3hxssIM/70nkEu
         gpZTJCs+Ei6yAh160kYO7QNFMtJGBaDiOTapVMzSEF47DS/a37USXCwBxj2mRDoDpiwJ
         QFoW6Eth1LJKETivcteK38xfrCd2uRkEXf8iAGxyRPTAClqbKOU3tJXJ+XA3c0+ivHqV
         LJZQ==
X-Gm-Message-State: AO0yUKXe1VV9OH9hAoqFj3IwmI7B1QAV2Bg9oT671nhoE4duRTce5p9O
        gABxc6I+1TBKRBnD5Vld4j764iBot0f+Jw==
X-Google-Smtp-Source: AK7set+oe/oQa1lhv4GRuIjVpFPYuJ+8ewlfICtiVJEMX5d5bMqtffmdgKizQCVp/9QTb3Kc9w6BrQ==
X-Received: by 2002:a17:907:25ce:b0:932:4990:2563 with SMTP id ae14-20020a17090725ce00b0093249902563mr2102132ejc.24.1679067334423;
        Fri, 17 Mar 2023 08:35:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/17] cocci: apply the "pretty.h" part of "the_repository.pending"
Date:   Fri, 17 Mar 2023 16:35:14 +0100
Message-Id: <patch-10.17-c4bf81a2892-20230317T152724Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
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
index 0b48de00634..d43687a5c44 100644
--- a/archive.c
+++ b/archive.c
@@ -59,7 +59,8 @@ static void format_subst(const struct commit *commit,
 		strbuf_add(&fmt, b + 8, c - b - 8);
 
 		strbuf_add(buf, src, b - src);
-		format_commit_message(commit, fmt.buf, buf, ctx);
+		repo_format_commit_message(the_repository, commit, fmt.buf,
+					   buf, ctx);
 		len -= c + 1 - src;
 		src  = c + 1;
 	}
diff --git a/bisect.c b/bisect.c
index db7aa2032e1..761dd48ad20 100644
--- a/bisect.c
+++ b/bisect.c
@@ -752,7 +752,8 @@ enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
 	}
 
 	commit = lookup_commit_reference(the_repository, bisect_rev);
-	format_commit_message(commit, "[%H] %s%n", &commit_msg, &pp);
+	repo_format_commit_message(the_repository, commit, "[%H] %s%n",
+				   &commit_msg, &pp);
 	fputs(commit_msg.buf, stdout);
 	strbuf_release(&commit_msg);
 
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 7d51eecab82..34ba7b18f69 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -265,7 +265,8 @@ static void log_commit(FILE *fp, char *fmt, const char *state,
 	struct strbuf commit_msg = STRBUF_INIT;
 	char *label = xstrfmt(fmt, state);
 
-	format_commit_message(commit, "%s", &commit_msg, &pp);
+	repo_format_commit_message(the_repository, commit, "%s", &commit_msg,
+				   &pp);
 
 	fprintf(fp, "# %s: [%s] %s\n", label, oid_to_hex(&commit->object.oid),
 		commit_msg.buf);
@@ -603,8 +604,8 @@ static int bisect_skipped_commits(struct bisect_terms *terms)
 
 	while ((commit = get_revision(&revs)) != NULL) {
 		strbuf_reset(&commit_name);
-		format_commit_message(commit, "%s",
-				      &commit_name, &pp);
+		repo_format_commit_message(the_repository, commit, "%s",
+					   &commit_name, &pp);
 		fprintf(fp, "# possible first %s commit: [%s] %s\n",
 			terms->term_bad, oid_to_hex(&commit->object.oid),
 			commit_name.buf);
@@ -633,7 +634,8 @@ static int bisect_successful(struct bisect_terms *terms)
 
 	read_ref(bad_ref, &oid);
 	commit = lookup_commit_reference_by_name(bad_ref);
-	format_commit_message(commit, "%s", &commit_name, &pp);
+	repo_format_commit_message(the_repository, commit, "%s", &commit_name,
+				   &pp);
 
 	res = append_to_file(git_path_bisect_log(), "# first %s commit: [%s] %s\n",
 			    terms->term_bad, oid_to_hex(&commit->object.oid),
diff --git a/builtin/commit.c b/builtin/commit.c
index bda6afc4bd6..92b7e8c56f7 100644
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
index ba1daa4ff0f..f4939176dae 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -742,7 +742,8 @@ static int merge_commit(struct notes_merge_options *o)
 
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
index e9c6623647d..62529344407 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -385,7 +385,8 @@ static void shortlog(const char *name,
 		if (subjects.nr > limit)
 			continue;
 
-		format_commit_message(commit, "%s", &sb, &ctx);
+		repo_format_commit_message(the_repository, commit, "%s", &sb,
+					   &ctx);
 		strbuf_ltrim(&sb);
 
 		if (!sb.len)
diff --git a/log-tree.c b/log-tree.c
index 1bd4d6ab008..7eee664cd23 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -407,7 +407,8 @@ void fmt_output_commit(struct strbuf *filename,
 	struct pretty_print_context ctx = {0};
 	struct strbuf subject = STRBUF_INIT;
 
-	format_commit_message(commit, "%f", &subject, &ctx);
+	repo_format_commit_message(the_repository, commit, "%f", &subject,
+				   &ctx);
 	fmt_output_subject(filename, subject.buf, info);
 	strbuf_release(&subject);
 }
@@ -985,8 +986,10 @@ static int do_remerge_diff(struct rev_info *opt,
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
index 2926f26251f..df31f192ce3 100644
--- a/object-name.c
+++ b/object-name.c
@@ -394,8 +394,10 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
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
index 7e1614f67fe..076d1c363e7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2199,7 +2199,8 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	int need_8bit_cte = pp->need_8bit_cte;
 
 	if (pp->fmt == CMIT_FMT_USERFORMAT) {
-		format_commit_message(commit, user_format, sb, pp);
+		repo_format_commit_message(the_repository, commit,
+					   user_format, sb, pp);
 		return;
 	}
 
diff --git a/pretty.h b/pretty.h
index f34e24c53a4..1e37c56d73d 100644
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
index 592b3d2875a..aa3ebb47d98 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1343,8 +1343,10 @@ void print_commit_summary(struct repository *r,
 
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
@@ -1352,7 +1354,8 @@ void print_commit_summary(struct repository *r,
 	if (flags & SUMMARY_SHOW_AUTHOR_DATE) {
 		struct strbuf date = STRBUF_INIT;
 
-		format_commit_message(commit, "%ad", &date, &pctx);
+		repo_format_commit_message(the_repository, commit, "%ad",
+					   &date, &pctx);
 		strbuf_addstr(&format, "\n Date: ");
 		strbuf_addbuf_percentquote(&format, &date);
 		strbuf_release(&date);
@@ -2125,7 +2128,8 @@ static void refer_to_commit(struct replay_opts *opts,
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

