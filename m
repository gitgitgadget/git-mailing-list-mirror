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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC067C433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEC364FCE
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhCJTol (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhCJTog (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:44:36 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B532BC061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:44:36 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o38so12080999pgm.9
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CnLqt6OCaUFWCoqEf/vQDO4LO1V86MbWBcvvb7hk/10=;
        b=aJ1JDi5iHpKM4psfpoQBFBzyikVRgWrJZpm2YW/PZ/tLE9Ce7hcde2Bnscu+WG5p/U
         882J3ffXaPYkd/pitVxRTxDUFGQqdSwyEXIvNIqDcMUlIfvs24VAxkrGK2h+jw91CQC7
         zZ3hJ82IhiKwWecN3x48nvzWIz4RfLePoUMOkbO4heRQEfMYdxos3bryEkUPzqyUNKnf
         AmI+Rkn67OX34y81QenNOvpZy2YeIqlKmULRGbQ+1QDz1xuJ6tanlIC4daC3q25qOlk8
         he/W1IAkEatOLBS9ew4mNh1okbtg/zQdMEaofBFmYUINqWO11TbZs4U6OkvD1F3n9PLB
         4cAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CnLqt6OCaUFWCoqEf/vQDO4LO1V86MbWBcvvb7hk/10=;
        b=UGRFa43BINfhVa7wC1P81OgX+lBmBs/3I4tvGw5Dk2z5hL1aAoQnqDHVjCLstojV0A
         z63TPBfpCCGaC+WxAsYlY/1YQ0ROPRwdzJgehsQYjNuZAZKMGrRegfe448fv16+a/qpN
         GC9JWRDJtDLnRGf2gS8YaCZSs/0i4SKuL1SBHPzUbFfuYb7G6ZmfBKLTJRGwvbhx1Bp4
         RWTaEYf8fMyTq5rBl0IFaXoH35kRJgNawPl/ZBRVPGkX90V7dziitoQh8u0JlIqlUYPw
         9zq6HhSXaPAxNMigEo3nVrbbMuWddyU7zhhOcuHxlGoPzx89uXI85UD44m7xGItxgX7e
         Iouw==
X-Gm-Message-State: AOAM533QT5Rzlb5ypwdFgBHf9+WZ6BVUASQb7P57r34i8cluyLQILLn1
        kRaN3K1PfKGFFMyIUDDlO951EGRxoYfzMg==
X-Google-Smtp-Source: ABdhPJwWbUjuE2wHkaDukAmpQ9C5t/b9HlcxMzsbjCTP4DmZz3mcuDNUD7p/CJAAknOsEcgkiwqhNQ==
X-Received: by 2002:a62:8c05:0:b029:1d8:7f36:bcd8 with SMTP id m5-20020a628c050000b02901d87f36bcd8mr4303121pfd.43.1615405475961;
        Wed, 10 Mar 2021 11:44:35 -0800 (PST)
Received: from localhost.localdomain ([2405:204:130f:1562:5082:417f:76e8:c75])
        by smtp.googlemail.com with ESMTPSA id p5sm296480pfq.56.2021.03.10.11.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:44:35 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v4 2/6] commit: add amend suboption to --fixup to create amend! commit
Date:   Thu, 11 Mar 2021 01:13:06 +0530
Message-Id: <20210310194306.32565-3-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com>
References: <20210301084512.27170-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git commit --fixup=amend:<commit>` will create an "amend!" commit.
The resulting commit message subject will be "amend! ..." where
"..." is the subject line of <commit> and the initial message
body will be <commit>'s message.

The "amend!" commit when rebased with --autosquash will fixup the
contents and replace the commit message of <commit> with the
"amend!" commit's message body.

In order to prevent rebase from creating commits with an empty
message we refuse to create an "amend!" commit if commit message
body is empty.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 builtin/commit.c | 107 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 97 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 505fe60956..05594fa8ab 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -105,7 +105,8 @@ static const char *template_file;
  */
 static const char *author_message, *author_message_buffer;
 static char *edit_message, *use_message;
-static char *fixup_message, *squash_message;
+static char *fixup_message, *fixup_commit, *squash_message;
+static const char *fixup_prefix;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
@@ -357,7 +358,8 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		die(_("--pathspec-file-nul requires --pathspec-from-file"));
 	}
 
-	if (!pathspec.nr && (also || (only && !amend && !allow_empty)))
+	if (!pathspec.nr && (also || (only && !allow_empty &&
+	    (!amend || (fixup_message && strcmp(fixup_prefix, "amend"))))))
 		die(_("No paths with --include/--only does not make sense."));
 
 	if (read_cache_preload(&pathspec) < 0)
@@ -681,6 +683,23 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	comment_line_char = *p;
 }
 
+static int prepare_amend_commit(struct commit *commit, struct strbuf *sb,
+				struct pretty_print_context *ctx) {
+
+	const char *buffer, *subject, *fmt;
+
+	buffer = get_commit_buffer(commit, NULL);
+	find_commit_subject(buffer, &subject);
+	/*
+	 * If we amend the 'amend!' commit then we don't want to
+	 * duplicate the subject line.
+	 */
+	fmt = starts_with(subject, "amend!") ? "%b" : "%B";
+	format_commit_message(commit, fmt, sb, ctx);
+	unuse_commit_buffer(commit, buffer);
+	return 0;
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct commit *current_head,
 			     struct wt_status *s,
@@ -745,15 +764,32 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	} else if (fixup_message) {
 		struct pretty_print_context ctx = {0};
 		struct commit *commit;
-		commit = lookup_commit_reference_by_name(fixup_message);
+		char *fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
+		commit = lookup_commit_reference_by_name(fixup_commit);
 		if (!commit)
-			die(_("could not lookup commit %s"), fixup_message);
+			die(_("could not lookup commit %s"), fixup_commit);
 		ctx.output_encoding = get_commit_output_encoding();
-		format_commit_message(commit, "fixup! %s\n\n",
-				      &sb, &ctx);
-		if (have_option_m)
-			strbuf_addbuf(&sb, &message);
+		format_commit_message(commit, fmt, &sb, &ctx);
+		free(fmt);
 		hook_arg1 = "message";
+
+		/*
+		 * Only `-m` commit message option is checked here, as
+		 * it supports `--fixup` to append the commit message.
+		 *
+		 * The other commit message options `-c`/`-C`/`-F` are
+		 * incompatible with all the forms of `--fixup` and
+		 * have already errored out while parsing the `git commit`
+		 * options.
+		 */
+		if (have_option_m && !strcmp(fixup_prefix, "fixup"))
+			strbuf_addbuf(&sb, &message);
+
+		if (!strcmp(fixup_prefix, "amend")) {
+			if (have_option_m)
+				die(_("cannot combine -m with --fixup:%s"), fixup_message);
+			prepare_amend_commit(commit, &sb, &ctx);
+		}
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
 		size_t merge_msg_start;
 
@@ -1152,6 +1188,12 @@ static void finalize_deferred_config(struct wt_status *s)
 		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
 }
 
+/* returns the length of intial segment of alpha characters only */
+static size_t get_alpha_len(char *fixup_message) {
+	const char alphas[] = "abcdefghijklmnopqrstuvwxyz";
+	return strspn(fixup_message, alphas);
+}
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const struct option *options,
 				      const char * const usage[],
@@ -1170,7 +1212,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && renew_authorship)
 		die(_("Using both --reset-author and --author does not make sense"));
 
-	if (logfile || have_option_m || use_message || fixup_message)
+	if (logfile || have_option_m || use_message)
 		use_editor = 0;
 	if (0 <= edit_flag)
 		use_editor = edit_flag;
@@ -1227,6 +1269,34 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (also + only + all + interactive > 1)
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
+
+	if (fixup_message) {
+		/*
+		 * To check if fixup_message that contains ':' is a commit
+		 * reference for example: --fixup="HEAD^{/^area: string}" or
+		 * a suboption of `--fixup`.
+		 *
+		 * As `amend` suboption contains only alpha character.
+		 * So check if first non alpha character in fixup_message
+		 * is ':'.
+		 */
+		size_t len = get_alpha_len(fixup_message);
+		if (len && fixup_message[len] == ':') {
+			fixup_message[len++] = '\0';
+			fixup_commit = fixup_message + len;
+			if (!strcmp("amend", fixup_message)) {
+				fixup_prefix = "amend";
+				allow_empty = 1;
+			} else {
+				die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);
+			}
+		} else {
+			fixup_commit = fixup_message;
+			fixup_prefix = "fixup";
+			use_editor = 0;
+		}
+	}
+
 	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
 
 	handle_untracked_files_arg(s);
@@ -1504,7 +1574,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK('m', "message", &message, N_("message"), N_("commit message"), opt_parse_m),
 		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
 		OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reuse message from specified commit")),
-		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
+		/*
+		 * TRANSLATORS: Leave "[amend:]" as-is, and
+		 * only translate <commit>.
+		 */
+		OPT_STRING(0, "fixup", &fixup_message, N_("[amend:]commit"), N_("use autosquash formatted message to fixup or amend specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
@@ -1663,6 +1737,19 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		exit(1);
 	}
 
+	if (fixup_message && starts_with(sb.buf, "amend! ") &&
+	    !allow_empty_message) {
+		struct strbuf body = STRBUF_INIT;
+		size_t len = commit_subject_length(sb.buf);
+		strbuf_addstr(&body, sb.buf + len);
+		if (message_is_empty(&body, cleanup_mode)) {
+			rollback_index_files();
+			fprintf(stderr, _("Aborting commit due to empty commit message body.\n"));
+			exit(1);
+		}
+		strbuf_release(&body);
+	}
+
 	if (amend) {
 		const char *exclude_gpgsig[3] = { "gpgsig", "gpgsig-sha256", NULL };
 		extra = read_commit_extra_headers(current_head, exclude_gpgsig);
-- 
2.29.0.rc1

