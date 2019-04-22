Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F07C1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 12:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfDVMXE (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 08:23:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43874 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfDVMXD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 08:23:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so5641785pfd.10
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AWM1zIvf8i2HHd5h3ZecE/eMzIOaVZ5uS2lv4ljXNdE=;
        b=sDyhD/QLIqn8+RGb28Wl5BenETgPfN1RVE+BvbgUYz1ycjPbzb2MpC40INiSrtjM/R
         ivfTKbX7w5rTwOSAgfa3LSoC3E6ul6sIstLBB4qf0Y0QQ+C7+dRx8I/wXfIdDghAp9s9
         7QyZ9gcqhJfp1iTd+PlxrWu1knqriQxCHXeYao2Z5COy6TQQZVKtbBBP65Pn7l53qGF7
         zU4IzMLT/6ySBMNGEQCr9a1jCe5axGS8wweq6ZNrDrEQPNItLULc3MK2gqAtb+uf02Yc
         Vf5xSOxhPKv4LYMve6Px66st6Ea0fpla4su0ahrfOmyfvW+KnfK7yeN5j0IeoyvAuvBd
         /LEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AWM1zIvf8i2HHd5h3ZecE/eMzIOaVZ5uS2lv4ljXNdE=;
        b=qkT75SIV1hkZTISMUMboTSCatGmKJnu8CKPomWab4gxov0iogEF1FWGIPfbDwCHrhE
         gfq/DFfdWm3kktzYIatvnWyZxYs7wE8mz2Jz4myNKNoSbLdQv+nCrbMr19tXXl+K27cH
         lfiJb4uIgy6l3L8HaoKxiFeRJxIaP86sJtmqn5PPoXDFo2avmG+879amGsdCRmOvUsrV
         czFu2qI5sukU+0nQbkAIivMdinXKTEoM/SI7cXQzhigc4TvaFOtEahMowFivX2IBhkFq
         ut3LKkh2ku5c/yCjHHt1+sERcwzCrV7+yweBKXJ9CtT9QtYEJVJJDsSknOeIi+lr5OEU
         vNeQ==
X-Gm-Message-State: APjAAAUps8t27mzjGl6T3X0XSlfXws+WQpy/0gfbnlc7bSv/7Wx0qyKM
        p8dpWjBcBA8UgrCZU2D9+Hk=
X-Google-Smtp-Source: APXvYqyMnwSDSRnC4kCnj67Grvi4zVIAncKVCsLNg4V5d3A9O16H7tafwTxzEItFrPJav701C/JdZg==
X-Received: by 2002:a62:7549:: with SMTP id q70mr20731035pfc.112.1555935782684;
        Mon, 22 Apr 2019 05:23:02 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id n65sm11917542pga.92.2019.04.22.05.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 05:23:00 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 22 Apr 2019 19:22:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        liu.denton@gmail.com, pclouds@gmail.com
Subject: [PATCH] parse-options: don't emit "ambiguous option" for aliases
Date:   Mon, 22 Apr 2019 19:22:50 +0700
Message-Id: <20190422122250.15248-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <xmqq1s1yfw24.fsf@gitster-ct.c.googlers.com>
References: <xmqq1s1yfw24.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the option parsing machinery so that e.g. "clone --recurs ..."
doesn't error out because "clone" understands both "--recursive" and
"--recurse-submodules" to mean the same thing.

Initially "clone" just understood --recursive until the
--recurses-submodules alias was added in ccdd3da652 ("clone: Add the
--recurse-submodules option as alias for --recursive",
2010-11-04). Since bb62e0a99f ("clone: teach --recurse-submodules to
optionally take a pathspec", 2017-03-17) the longer form has been
promoted to the default.

But due to the way the options parsing machinery works this resulted
in the rather absurd situation of:

    $ git clone --recurs [...]
    error: ambiguous option: recurs (could be --recursive or --recurse-submodules)

Add OPT_ALIAS() to express this linke between two options and use it in
git-clone.

A big chunk of code is actually from Junio C Hamano. The test case (and
most of the commit message) is from Ævar Arnfjörð Bjarmason.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I'm not sure if Junio is an evil genius who lures me with his helpful
 suggestions. Either way I ended up spending a couple hours writing and
 rewriting and finally decided all other options were too ugly. And his
 suggestions were mostly there already.
 
 So here's OPT_ALIAS(). I avoid rewriting all the option iteration code
 by simply making a copy of options[] array to use, then free it
 afterwards. Not the best, but at least it could be easily removed if we
 end up not want OPT_ALIAS() after all.

 This probably needs signoff from both Ævar and Junio, if accepted.

 builtin/clone.c          |   5 +-
 parse-options.c          | 130 +++++++++++++++++++++++++++++++++++++--
 parse-options.h          |   6 ++
 t/t0040-parse-options.sh |   5 ++
 4 files changed, 136 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..703b7247ad 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -98,10 +98,7 @@ static struct option builtin_clone_options[] = {
 		    N_("don't use local hardlinks, always copy")),
 	OPT_BOOL('s', "shared", &option_shared,
 		    N_("setup as shared repository")),
-	{ OPTION_CALLBACK, 0, "recursive", &option_recurse_submodules,
-	  N_("pathspec"), N_("initialize submodules in the clone"),
-	  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, recurse_submodules_cb,
-	  (intptr_t)"." },
+	OPT_ALIAS(0, "recursive", "recurse-submodules"),
 	{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
 	  N_("pathspec"), N_("initialize submodules in the clone"),
 	  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
diff --git a/parse-options.c b/parse-options.c
index acc3a93660..7ec768e376 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -261,6 +261,35 @@ static enum parse_opt_result parse_short_opt(struct parse_opt_ctx_t *p,
 	return PARSE_OPT_UNKNOWN;
 }
 
+static int has_string(const char *it, const char **array)
+{
+	while (*array)
+		if (!strcmp(it, *(array++)))
+			return 1;
+	return 0;
+}
+
+static int is_alias(struct parse_opt_ctx_t *ctx,
+		    const struct option *one_opt,
+		    const struct option *another_opt)
+{
+	const char **group;
+
+	if (!ctx->alias_groups)
+		return 0;
+
+	if (!one_opt->long_name || !another_opt->long_name)
+		return 0;
+
+	for (group = ctx->alias_groups; *group; group += 3) {
+		/* it and other are from the same family? */
+		if (has_string(one_opt->long_name, group) &&
+		    has_string(another_opt->long_name, group))
+			return 1;
+	}
+	return 0;
+}
+
 static enum parse_opt_result parse_long_opt(
 	struct parse_opt_ctx_t *p, const char *arg,
 	const struct option *options)
@@ -296,7 +325,8 @@ static enum parse_opt_result parse_long_opt(
 			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN) &&
 			    !strncmp(long_name, arg, arg_end - arg)) {
 is_abbreviated:
-				if (abbrev_option) {
+				if (abbrev_option &&
+				    !is_alias(p, abbrev_option, options)) {
 					/*
 					 * If this is abbreviated, it is
 					 * ambiguous. So when there is no
@@ -445,6 +475,10 @@ static void parse_options_check(const struct option *opts)
 			if (opts->callback)
 				BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
 			break;
+		case OPTION_ALIAS:
+			BUG("OPT_ALIAS() should not remain at this point. "
+			    "Are you using parse_options_step() directly?\n"
+			    "That case is not supported yet.");
 		default:
 			; /* ok. (usually accepts an argument) */
 		}
@@ -456,11 +490,10 @@ static void parse_options_check(const struct option *opts)
 		exit(128);
 }
 
-void parse_options_start(struct parse_opt_ctx_t *ctx,
-			 int argc, const char **argv, const char *prefix,
-			 const struct option *options, int flags)
+static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
+				  int argc, const char **argv, const char *prefix,
+				  const struct option *options, int flags)
 {
-	memset(ctx, 0, sizeof(*ctx));
 	ctx->argc = argc;
 	ctx->argv = argv;
 	if (!(flags & PARSE_OPT_ONE_SHOT)) {
@@ -482,6 +515,14 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	parse_options_check(options);
 }
 
+void parse_options_start(struct parse_opt_ctx_t *ctx,
+			 int argc, const char **argv, const char *prefix,
+			 const struct option *options, int flags)
+{
+	memset(ctx, 0, sizeof(*ctx));
+	parse_options_start_1(ctx, argc, argv, prefix, options, flags);
+}
+
 static void show_negated_gitcomp(const struct option *opts, int nr_noopts)
 {
 	int printed_dashdash = 0;
@@ -574,6 +615,70 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 	return PARSE_OPT_COMPLETE;
 }
 
+/*
+ * Scan and may produce a new option[] array, which should be used
+ * instead of the original 'options'.
+ *
+ * Right now this is only used to preprocess and substitue
+ * OPTION_ALIAS.
+ */
+static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
+					 const struct option *options)
+{
+	struct option *newopt;
+	int i, nr, alias;
+	int nr_aliases = 0;
+
+	for (nr = 0; options[nr].type != OPTION_END; nr++) {
+		if (options[nr].type == OPTION_ALIAS)
+			nr_aliases++;
+	}
+
+	if (!nr_aliases)
+		return NULL;
+
+	ALLOC_ARRAY(newopt, nr + 1);
+	COPY_ARRAY(newopt, options, nr + 1);
+
+	/* each alias has two string pointers and NULL */
+	CALLOC_ARRAY(ctx->alias_groups, 3 * (nr_aliases + 1));
+
+	for (alias = 0, i = 0; i < nr; i++) {
+		const char *source;
+		int j;
+
+		if (newopt[i].type != OPTION_ALIAS)
+			continue;
+
+		if (!newopt[i].long_name)
+			BUG("An alias must have long option name");
+
+		source = newopt[i].value;
+
+		for (j = 0; j < nr; j++) {
+			const char *name = options[j].long_name;
+
+			if (!name || strcmp(name, source))
+				continue;
+
+			if (options[j].type == OPTION_ALIAS)
+				BUG("No please. Nested aliases are not supported.");
+
+			memcpy(newopt + i, options + j, sizeof(*newopt));
+			break;
+		}
+
+		if (j == nr)
+			BUG("could not find source option '%s' of alias '%s'",
+			    source, newopt[i].long_name);
+		ctx->alias_groups[alias * 3 + 0] = newopt[i].long_name;
+		ctx->alias_groups[alias * 3 + 1] = options[j].long_name;
+		alias++;
+	}
+
+	return newopt;
+}
+
 static int usage_with_options_internal(struct parse_opt_ctx_t *,
 				       const char * const *,
 				       const struct option *, int, int);
@@ -713,11 +818,16 @@ int parse_options(int argc, const char **argv, const char *prefix,
 		  int flags)
 {
 	struct parse_opt_ctx_t ctx;
+	struct option *real_options;
 
 	disallow_abbreviated_options =
 		git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0);
 
-	parse_options_start(&ctx, argc, argv, prefix, options, flags);
+	memset(&ctx, 0, sizeof(ctx));
+	real_options = preprocess_options(&ctx, options);
+	if (real_options)
+		options = real_options;
+	parse_options_start_1(&ctx, argc, argv, prefix, options, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
 	case PARSE_OPT_ERROR:
@@ -740,6 +850,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	}
 
 	precompose_argv(argc, argv);
+	free(real_options);
+	free(ctx.alias_groups);
 	return parse_options_end(&ctx);
 }
 
@@ -834,6 +946,12 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 			fputc('\n', outfile);
 			pad = USAGE_OPTS_WIDTH;
 		}
+		if (opts->type == OPTION_ALIAS) {
+			fprintf(outfile, "%*s", pad + USAGE_GAP, "");
+			fprintf_ln(outfile, _("alias of --%s"),
+				   (const char *)opts->value);
+			continue;
+		}
 		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", _(opts->help));
 	}
 	fputc('\n', outfile);
diff --git a/parse-options.h b/parse-options.h
index 74cce4e7fc..e6b4a8d1c7 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -7,6 +7,7 @@ enum parse_opt_type {
 	OPTION_ARGUMENT,
 	OPTION_GROUP,
 	OPTION_NUMBER,
+	OPTION_ALIAS,
 	/* options with no arguments */
 	OPTION_BIT,
 	OPTION_NEGBIT,
@@ -181,6 +182,9 @@ struct option {
 	  N_("no-op (backward compatibility)"),		\
 	  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, parse_opt_noop_cb }
 
+#define OPT_ALIAS(s, l, alias_source) \
+	{ OPTION_ALIAS, (s), (l), (alias_source) }
+
 /*
  * parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[]. argv0 is assumed program name and
@@ -256,6 +260,8 @@ struct parse_opt_ctx_t {
 	const char *opt;
 	int flags;
 	const char *prefix;
+	const char **alias_groups; /* must be in groups of 3 elements! */
+	struct option *updated_options;
 };
 
 void parse_options_start(struct parse_opt_ctx_t *ctx,
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 800b3ea5f5..14e6664240 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -224,6 +224,11 @@ test_expect_success 'non ambiguous option (after two options it abbreviates)' '
 	test-tool parse-options --expect="string: 123" --st 123
 '
 
+test_expect_success 'NOCOMPLETE options do not contribute to abbreviation' '
+	test_when_finished "rm -rf A" &&
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false git clone --recurs . A
+'
+
 cat >typo.err <<\EOF
 error: did you mean `--boolean` (with two dashes ?)
 EOF
-- 
2.21.0.854.ge34a79f761

