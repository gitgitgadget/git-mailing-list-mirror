Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9461C1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbfKHUIi (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:08:38 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:46929 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388674AbfKHUIi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:08:38 -0500
Received: by mail-pg1-f180.google.com with SMTP id r18so4597911pgu.13
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 12:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vskiBgM38foavKoSZjx9cKZwtDsSSNBEfGBZo2K3Rqs=;
        b=mPYczynfUfPsBuAufHYRjN00umnyjM8Idu9pLErWZn+tPAPM3ySJEo1CGd8js2vDea
         ecJFlRu6jOjnzNM+3xDNAzvDNPX5OnDsqBQaXabvYQi8udgmi9q8DalPhxlkJzBP2T5b
         R4A9NTuE0/FHDADcjbiZwV7skxwREthv+StPJWRHtrYWBcizbUKb12MTWLD8jHrqxbQu
         uYriDhRAmpt7pKyEa+T/oFiLDznwJo2YSoGXmAAUg8imnxNqTVwakUmDNE8ZCuREvdVK
         utmcQxyuiMu3IUE/BcrwizkvTnOOttWMrZFqqIHVMKPUs9vVK0dLnQTq+FDegV2Eewhb
         WeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vskiBgM38foavKoSZjx9cKZwtDsSSNBEfGBZo2K3Rqs=;
        b=R7YJkcODcgPO5dylt3RkWMCMKHe7tWT8OYCaYzLoEZjkybUvRBR12Urkt6sJTDHa+6
         NdPCmsUdRlw/XUhLf2xUNPQfZ0JJrN3R0gJ1YI2ierFGnjAjgzp/zim9tr3Zz7TwM2K1
         BzROXmB2FR9OindadjgB/Ev9DdbPXyVtfMvO1nBnz9iG859eziBkkgXSXhc8Um+pn8Jh
         nbdkDHApqH2gGth5tqDRqxQHBJcCmiyN5F09VEswtGnkhF39H2dgHfw4tvy/2HvugjlQ
         QkXVhsYFWsIkRHw2q2YJ1yMRBRDt3jVBfBzabP83yKqRyEzCjuL9RWpr/67XlY6Q2cug
         xJPg==
X-Gm-Message-State: APjAAAUtYUh2dF7LfOMqskb9wHFhp89d4u6J2Zjrpq6xZ4oIQk1MxIS4
        gyszFP273eRzevcLjaW3dg7fxED6
X-Google-Smtp-Source: APXvYqwt+9xJUthekzwk5BUExf2IPxaobSb80NcMzlQtNDSp4Zmle8n4ekR8Ism8APlTvabsN99B6w==
X-Received: by 2002:aa7:814f:: with SMTP id d15mr13955222pfn.14.1573243716843;
        Fri, 08 Nov 2019 12:08:36 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id b21sm7333086pfd.74.2019.11.08.12.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:08:36 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:08:34 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/10] pretty: implement 'summary' format
Message-ID: <e74eab6d21f655698ef8b6e1286b44ea070a7af7.1573241590.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573241590.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The standard format for referencing other commits within some projects
(such as git.git) is the summary format. This is described in
Documentation/SubmittingPatches as

	If you want to reference a previous commit in the history of a stable
	branch, use the format "abbreviated hash (subject, date)",
	with the subject enclosed in a pair of double-quotes, like this:

	....
		Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
		noticed that ...
	....

Since this format is so commonly used, standardize it as a pretty
format.

This format is implemented as a separate flow that skips most of
pretty_print_commit() and instead calls format_commit_summary(). The
reason why this is done is because the other pretty formats expect
output to be generated in a specific order. Specifically, the header,
including the date, is always printed before the commit message,
including the subject. Reversing the order would be possible but would
involve butchering pretty_print_commit() so it is implemented as a
separate flow.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/pretty-formats.txt   |  9 ++++
 Documentation/pretty-options.txt   |  2 +-
 Documentation/rev-list-options.txt |  2 +-
 builtin/log.c                      | 30 +++++++++--
 log-tree.c                         | 11 ++--
 pretty.c                           | 31 ++++++++++-
 pretty.h                           |  1 +
 t/t4205-log-pretty-formats.sh      | 83 +++++++++++++++++++++++++-----
 8 files changed, 144 insertions(+), 25 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 71eef684d0..f9c1296d7c 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -63,6 +63,15 @@ This is designed to be as compact as possible.
 
 	       <full commit message>
 
+* 'summary'
+
+	  <abbrev hash> ("<title line>", <short author date>)
++
+This format is useful for referring to other commits when writing a new
+commit message. Although by default, '<abbrev hash>' is used, this can
+be overridden with '--no-abbrev'. In addition, '<short author date>' can
+be overridden by with '--date='.
+
 * 'email'
 
 	  From <hash> <date>
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index e44fc8f738..0a5b206193 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -3,7 +3,7 @@
 
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
-	'full', 'fuller', 'email', 'raw', 'format:<string>'
+	'full', 'fuller', 'summary', 'email', 'raw', 'format:<string>'
 	and 'tformat:<string>'.  When '<format>' is none of the above,
 	and has '%placeholder' in it, it acts as if
 	'--pretty=tformat:<format>' were given.
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 90ff9e2bea..76df494ed6 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -289,7 +289,7 @@ depending on a few rules:
 4. Otherwise, show the index format.
 --
 +
-Under `--pretty=oneline`, the commit message is
+Under `--pretty=oneline` and `--pretty=summary`, the commit message is
 prefixed with this information on the same line.
 This option cannot be combined with `--reverse`.
 See also linkgit:git-reflog[1].
diff --git a/builtin/log.c b/builtin/log.c
index e4df16be79..ad96a746a3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -223,15 +223,35 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		read_mailmap(rev->mailmap, NULL);
 	}
 
-	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
+	if (rev->pretty_given) {
+		switch (rev->commit_format) {
+
 		/*
 		 * "log --pretty=raw" is special; ignore UI oriented
 		 * configuration variables such as decoration.
 		 */
-		if (!decoration_given)
-			decoration_style = 0;
-		if (!rev->abbrev_commit_explicit)
-			rev->abbrev_commit = 0;
+		case CMIT_FMT_RAW:
+			if (!decoration_given)
+				decoration_style = 0;
+			if (!rev->abbrev_commit_explicit)
+				rev->abbrev_commit = 0;
+			break;
+
+		/*
+		 * "log --pretty=summary" is special; ignore UI oriented
+		 * configuration variables such as decoration but keep
+		 * abbreviations.
+		 */
+		case CMIT_FMT_SUMMARY:
+			if (!decoration_given)
+				decoration_style = 0;
+			if (!rev->abbrev_commit_explicit)
+				rev->abbrev_commit = 1;
+			break;
+
+		default:
+			break;
+		}
 	}
 
 	if (decoration_style) {
diff --git a/log-tree.c b/log-tree.c
index 4a7d668af6..433adaf0f1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -627,7 +627,8 @@ void show_log(struct rev_info *opt)
 		ctx.print_email_subject = 1;
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), opt->diffopt.file);
-		if (opt->commit_format != CMIT_FMT_ONELINE)
+		if (opt->commit_format != CMIT_FMT_ONELINE &&
+		    opt->commit_format != CMIT_FMT_SUMMARY)
 			fputs("commit ", opt->diffopt.file);
 
 		if (!opt->graph)
@@ -644,7 +645,8 @@ void show_log(struct rev_info *opt)
 			       find_unique_abbrev(&parent->object.oid, abbrev_commit));
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_RESET), opt->diffopt.file);
 		show_decorations(opt, commit);
-		if (opt->commit_format == CMIT_FMT_ONELINE) {
+		if (opt->commit_format == CMIT_FMT_ONELINE ||
+		    opt->commit_format == CMIT_FMT_SUMMARY) {
 			putc(' ', opt->diffopt.file);
 		} else {
 			putc('\n', opt->diffopt.file);
@@ -658,12 +660,15 @@ void show_log(struct rev_info *opt)
 			 * graph info here.
 			 */
 			show_reflog_message(opt->reflog_info,
-					    opt->commit_format == CMIT_FMT_ONELINE,
+					    (opt->commit_format == CMIT_FMT_ONELINE ||
+					     opt->commit_format == CMIT_FMT_SUMMARY),
 					    &opt->date_mode,
 					    opt->date_mode_explicit);
 			if (opt->commit_format == CMIT_FMT_ONELINE) {
 				putc('\n', opt->diffopt.file);
 				return;
+			} else if (opt->commit_format == CMIT_FMT_SUMMARY) {
+				putc(' ', opt->diffopt.file);
 			}
 		}
 	}
diff --git a/pretty.c b/pretty.c
index a6e5fc115a..8efb2486a5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -97,7 +97,8 @@ static void setup_commit_formats(void)
 		{ "mboxrd",	CMIT_FMT_MBOXRD,	0,	0 },
 		{ "fuller",	CMIT_FMT_FULLER,	0,	8 },
 		{ "full",	CMIT_FMT_FULL,		0,	8 },
-		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 }
+		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 },
+		{ "summary",	CMIT_FMT_SUMMARY,	1,	0 },
 		/*
 		 * Please update $__git_log_pretty_formats in
 		 * git-completion.bash when you add new formats.
@@ -1672,6 +1673,26 @@ void repo_format_commit_message(struct repository *r,
 				   do_repo_format_commit_message, (void *)format);
 }
 
+static void do_repo_format_commit_summary(struct strbuf *sb,
+					  struct format_commit_context *context,
+					  void *additional_context)
+{
+	struct ident_split ident;
+
+	parse_commit_header(context);
+	parse_commit_message(context);
+
+	strbuf_addstr(sb, "(\"");
+	format_subject(sb, context->message + context->subject_off, " ");
+	if (!split_ident_line(&ident,
+			      context->message + context->author.off,
+			      context->author.len)) {
+		strbuf_addstr(sb, "\", ");
+		strbuf_addstr(sb, show_ident_date(&ident, &context->pretty_ctx->date_mode));
+	}
+	strbuf_addstr(sb, ")");
+}
+
 static void pp_header(struct pretty_print_context *pp,
 		      const char *encoding,
 		      const struct commit *commit,
@@ -1923,6 +1944,14 @@ void pretty_print_commit(struct pretty_print_context *pp,
 		format_commit_message(commit, user_format, sb, pp);
 		return;
 	}
+	if (pp->fmt == CMIT_FMT_SUMMARY) {
+		if (!pp->date_mode_explicit)
+			pp->date_mode = *DATE_MODE(SHORT);
+
+		repo_format_commit_generic(the_repository, commit, sb, pp,
+					   do_repo_format_commit_summary, NULL);
+		return;
+	}
 
 	encoding = get_log_output_encoding();
 	msg = reencoded = logmsg_reencode(commit, NULL, encoding);
diff --git a/pretty.h b/pretty.h
index 4ad1fc31ff..6d5b18a4f1 100644
--- a/pretty.h
+++ b/pretty.h
@@ -16,6 +16,7 @@ enum cmit_fmt {
 	CMIT_FMT_FULL,
 	CMIT_FMT_FULLER,
 	CMIT_FMT_ONELINE,
+	CMIT_FMT_SUMMARY,
 	CMIT_FMT_EMAIL,
 	CMIT_FMT_MBOXRD,
 	CMIT_FMT_USERFORMAT,
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index d35650cae7..fcfd66faf9 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -154,20 +154,23 @@ do
 	'
 done
 
-test_expect_success 'NUL termination with --reflog --pretty=oneline' '
-	>expect &&
-	revs="$(git rev-list --reflog)" &&
-	for r in $revs
-	do
-		# trim trailing newline
-		output="$(git show -s --pretty=oneline "$r")" || return 1
-		printf "%s" "$output" >>expect
-		emit_nul >>expect
-	done &&
-	git log -z --pretty=oneline --reflog >actual &&
-	# no trailing NUL
-	test_cmp expect actual
-'
+for p in oneline summary
+do
+	test_expect_success "NUL termination with --reflog --pretty=$p" '
+		>expect &&
+		revs="$(git rev-list --reflog)" &&
+		for r in $revs
+		do
+			# trim trailing newline
+			output="$(git show -s --pretty='$p' "$r")" || return 1
+			printf "%s" "$output" >>expect
+			emit_nul >>expect
+		done &&
+		git log -z --pretty='$p' --reflog >actual &&
+		# no trailing NUL
+		test_cmp expect actual
+	'
+done
 
 test_expect_success 'setup more commits' '
 	test_commit "message one" one one message-one &&
@@ -823,4 +826,56 @@ test_expect_success '%S in git log --format works with other placeholders (part
 	test_cmp expect actual
 '
 
+test_expect_success 'log --pretty=summary' '
+	git log --date=short --pretty="tformat:%h (\"%s\", %ad)" >expect &&
+	git log --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with log.date is overridden by short date' '
+	git log --date=short --pretty="tformat:%h (\"%s\", %ad)" >expect &&
+	test_config log.date rfc &&
+	git log --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with explicit date overrides short date' '
+	git log --date=rfc --pretty="tformat:%h (\"%s\", %ad)" >expect &&
+	git log --date=rfc --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with log.abbrevCommit is overidden' '
+	git log --date=short --pretty="tformat:%h (\"%s\", %ad)" >expect &&
+	test_config log.abbrevCommit false &&
+	git log --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with explicit --no-abbrev overrides abbreviated' '
+	git log --date=short --pretty="tformat:%H (\"%s\", %ad)" >expect &&
+	git log --no-abbrev --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with log.decorate is overridden' '
+	git log --date=short --pretty="tformat:%h (\"%s\", %ad)" >expect &&
+	test_config log.decorate short &&
+	git log --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with explicit decorate overrides no decoration' '
+	git log --date=short --pretty="tformat:%h%d (\"%s\", %ad)" >expect &&
+	git log --decorate=short --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=summary with --walk-reflogs' '
+	test_config log.date short &&
+	git log --walk-reflogs --pretty="tformat:%h %gd: %gs (\"%s\", %ad)" >expect &&
+	git log --walk-reflogs --pretty=summary >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.24.0.298.g3e88fbd976

