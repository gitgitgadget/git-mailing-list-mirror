Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E25491F453
	for <e@80x24.org>; Mon, 29 Apr 2019 10:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfD2KFi (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 06:05:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38149 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfD2KFi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 06:05:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so5076305pfo.5
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5XwiWPPewOnnD8XMsiuNKHbGmeuAmPzYOpfdS72Xnco=;
        b=qynRE61jXDkavfRRFuv4T/Lio/pxQndLgvw9X8HhDHleRS4nPu3jmsApPDcLO3XrBd
         FAbwTnZuNefHiq5yNEU6+lHq8WChPyB944UEylVf1jElcGY5JQ+tUIAeL2ODGRPRDNiB
         ji+y0WSH5gj/6qJXwAdWNNgLhGxdrHaBownoQoRmjeC0t9tqZBqp38t0Sc6QJH1yX0Wh
         +w64/OHiMR0GTIrIWKILO+buM1vc3xbRMKK+OTSQR8EOxEQUwyQCYndtNf3KDqMot01z
         ucpqb9W81DIs8HoJAqrijlI21BI5I3HWiWh8hftS4QoFITNNgAumaNv8oSekX0XQFQLj
         lJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5XwiWPPewOnnD8XMsiuNKHbGmeuAmPzYOpfdS72Xnco=;
        b=Gy8iv0oNNxbKhp7sHmFus86qd9wtHMkNYd8t8KglzlSRSy35uNYdLUC6+vy1IHGS7f
         EB3fexTqLl3cB/GKC6tMspzXOtBhpZDk6BMJQ4z2LSNUmecXNzcvDD0bxfDBUyhRFbv9
         IanftnHSWrDY8Y90xC8irnsPCZSE7w1/rv2m4l8RMOTJEppve5Ozv6xW1gP2r+yZhwkA
         yPLLtkX2EHamZD4R66djaVipKyjUphzArU7F/Oj9oywmBHi4GNhLzcxThGgx7+Gsk2SZ
         0Gka8h7wMVsV+60aYRcUNKrAHX/c292sZNzjwvFVZUg/e71OF84IXmI2ZUcE4PwkX674
         Ny0Q==
X-Gm-Message-State: APjAAAU50CvpEJUY4ClV1ondfbJofcKmxX1ODyIEwenSPSLjuRruw9yP
        M15myAZmNzDnj7aJrImxElg=
X-Google-Smtp-Source: APXvYqxT1AwKY7pWANvKvLYRjXgdjHxrpfiWWeOefJkVC8ntr46tdL1ldZWv5dAsoY9MJGhhLjTI8Q==
X-Received: by 2002:a63:5149:: with SMTP id r9mr42447964pgl.177.1556532336984;
        Mon, 29 Apr 2019 03:05:36 -0700 (PDT)
Received: from ash ([171.226.41.84])
        by smtp.gmail.com with ESMTPSA id s9sm43727321pfe.183.2019.04.29.03.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 03:05:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 29 Apr 2019 17:05:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, liu.denton@gmail.com
Subject: [PATCH v2] parse-options: don't emit "ambiguous option" for aliases
Date:   Mon, 29 Apr 2019 17:05:25 +0700
Message-Id: <20190429100525.32045-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1110.g9614c01b33
In-Reply-To: <20190422122250.15248-1-pclouds@gmail.com>
References: <20190422122250.15248-1-pclouds@gmail.com>
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

Add OPT_ALIAS() to express this link between two or more options and use
it in git-clone. Multiple aliases of an option could be written as

    OPT_ALIAS(0, "alias1", "original-name"),
    OPT_ALIAS(0, "alias2", "original-name"),
    ...

The current implementation is not exactly optimal in this case. But we
can optimize it when it becomes a problem. So far we don't even have two
aliases of any option.

A big chunk of code is actually from Junio C Hamano.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 OK it's working for real this time. test-parse-options.c is also
 updated to for testing OPT_ALIAS.

 builtin/clone.c               |   5 +-
 parse-options.c               | 143 ++++++++++++++++++++++++++++++++--
 parse-options.h               |   6 ++
 t/helper/test-parse-options.c |   3 +
 t/t0040-parse-options.sh      |  17 ++++
 5 files changed, 164 insertions(+), 10 deletions(-)

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
index acc3a93660..1b1cc2add7 100644
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
@@ -574,6 +615,83 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
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
+		int short_name;
+		const char *long_name;
+		const char *source;
+		int j;
+
+		if (newopt[i].type != OPTION_ALIAS)
+			continue;
+
+		short_name = newopt[i].short_name;
+		long_name = newopt[i].long_name;
+		source = newopt[i].value;
+
+		if (!long_name)
+			BUG("An alias must have long option name");
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
+			/*
+			 * NEEDSWORK: this is a bit inconsistent because
+			 * usage_with_options() on the original options[] will print
+			 * help string as "alias of %s" but "git cmd -h" will
+			 * print the original help string.
+			 */
+			memcpy(newopt + i, options + j, sizeof(*newopt));
+			newopt[i].short_name = short_name;
+			newopt[i].long_name = long_name;
+			break;
+		}
+
+		if (j == nr)
+			BUG("could not find source option '%s' of alias '%s'",
+			    source, newopt[i].long_name);
+		ctx->alias_groups[alias * 3 + 0] = newopt[i].long_name;
+		ctx->alias_groups[alias * 3 + 1] = options[j].long_name;
+		ctx->alias_groups[alias * 3 + 2] = NULL;
+		alias++;
+	}
+
+	return newopt;
+}
+
 static int usage_with_options_internal(struct parse_opt_ctx_t *,
 				       const char * const *,
 				       const struct option *, int, int);
@@ -713,11 +831,16 @@ int parse_options(int argc, const char **argv, const char *prefix,
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
@@ -740,6 +863,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	}
 
 	precompose_argv(argc, argv);
+	free(real_options);
+	free(ctx.alias_groups);
 	return parse_options_end(&ctx);
 }
 
@@ -834,6 +959,12 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
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
index 74cce4e7fc..9ed479f41d 100644
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
 
+#define OPT_ALIAS(s, l, source_long_name) \
+	{ OPTION_ALIAS, (s), (l), (source_long_name) }
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
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index cc88fba057..76cfb87588 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -149,6 +149,9 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_CALLBACK(0, "expect", &expect, "string",
 			     "expected output in the variable dump",
 			     collect_expect),
+		OPT_GROUP("Alias"),
+		OPT_STRING('A', "alias-source", &string, "string", "get a string"),
+		OPT_ALIAS('Z', "alias-target", "alias-source"),
 		OPT_END(),
 	};
 	int i;
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 800b3ea5f5..cebc77fab0 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -48,6 +48,12 @@ Standard options
     -q, --quiet           be quiet
     --expect <string>     expected output in the variable dump
 
+Alias
+    -A, --alias-source <string>
+                          get a string
+    -Z, --alias-target <string>
+                          get a string
+
 EOF
 
 test_expect_success 'test help' '
@@ -224,6 +230,17 @@ test_expect_success 'non ambiguous option (after two options it abbreviates)' '
 	test-tool parse-options --expect="string: 123" --st 123
 '
 
+test_expect_success 'Alias options do not contribute to abbreviation' '
+	test-tool parse-options --alias-source 123 >output &&
+	grep "^string: 123" output &&
+	test-tool parse-options --alias-target 123 >output &&
+	grep "^string: 123" output &&
+	test_must_fail test-tool parse-options --alias &&
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	test-tool parse-options --alias 123 >output &&
+	grep "^string: 123" output
+'
+
 cat >typo.err <<\EOF
 error: did you mean `--boolean` (with two dashes ?)
 EOF
-- 
2.21.0.1110.g9614c01b33

