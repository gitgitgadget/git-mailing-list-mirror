Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E49C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 22:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C1963217
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 22:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345963AbhKOWza (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 17:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349239AbhKOWwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 17:52:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EC7C03AA2A
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:03:50 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso898871wmf.0
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnUpoO+uYKWj5BWND1Z8G+2M69zTJLepzlQ2Q2nDNMQ=;
        b=AIXIQDUGSYtd08EMk4W3UQhPz16MhgqAdJG8XM28zOPfOErh8lfr2ZH/2LIB2oljqi
         seM1A30y5emNHo94sKnf9G4hDTz0lMSH4oQZ2bwP+zHkgSnjFcHlyd6BJNkrpagCkJa+
         FwjwSWZgE4+WTfNBu4uuCypEiulB5CysJ9vGIfsGlMSBfx5MRFr6VgmBaIJfJIPbdvYE
         Gijpmldm1Vr4PTySF7/+ETMfOy4RPJzyEYjD8wfDZeQWUveEmnsamH84XglTl3Ycc94s
         rKCcFxluy+cfxdgC3xGnukZK9TMUleFhxvOW9raE1RfcaqqODO9EnStKNmuAX1wQSeyU
         ENwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnUpoO+uYKWj5BWND1Z8G+2M69zTJLepzlQ2Q2nDNMQ=;
        b=LYRFn2aVntNQ7OPd6tsTLP3svEXrRUiELuXlEIJtLwM0iwXcdlz9Yx33tLcWhH+IYF
         n2iRoGty4uAuOa3x4ngsDlGyCkqRQj8lATZAuidxHxgoERVI8u48KJB2/RDSX2tsMhap
         cYSe4ZNhwjCC6gJCyAwfVUfFoxZJ/mxIxL6g1GgUekdVbE8Zp8qheWXqPGBjKYPeweG8
         TooarZMtejdx+dTCTqt8AjKn7ho8s8WDbtDo+Xtv9RsDVZBby3Z9DnnLvXzZ3HxDXoGz
         5qX9PAevkx/AnBZzLTHD11qnIJqNGD0biTVBo0dU6ahHbwU5TntgP8SGJ0X2+Elw7ULf
         YNAA==
X-Gm-Message-State: AOAM532imRY9D3QK3XRO3jGU+1KlA6tMQaVws4uanEelQe5dflAij299
        W48NUTfrwWM5+f7AUF9Sf7nF/bIE2Tw=
X-Google-Smtp-Source: ABdhPJwHHePRiA3OVZBtHkfagRk8euQuIiLGc0tJIILaV70TFt0s46DDgxCbQWjyDIgbklDu05rWBw==
X-Received: by 2002:a05:600c:3ba5:: with SMTP id n37mr63074335wms.168.1637013828263;
        Mon, 15 Nov 2021 14:03:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q84sm908098wme.3.2021.11.15.14.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:03:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] parse-options API: simplify OPT_ALIAS()
Date:   Mon, 15 Nov 2021 23:03:43 +0100
Message-Id: <patch-1.1-b09bf423694-20211115T220334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove OPT_ALIAS() while satisfying the use-case that brought it into
existence. This is mostly a code removal, but also a code
simplification.

The reason we've got OPT_ALIAS is detailed in
5c387428f10 (parse-options: don't emit "ambiguous option" for aliases,
2019-04-29), i.e. wanting to have "git clone" understand the
incomplete "--recurs" form without complaining that "--recursive" and
"--recurse-submodules" are ambiguous.

Only the "clone" caller cared about that use-case, the other four,
including two recently added by me in 98e2d9d6f7d (upload-pack:
document and rename --advertise-refs, 2021-08-05), only cared about
the small amount of typing saved by re-declaring the relevant OPT_*()
argument again with mostly the same parameters.

For the more verbose caller in "clone" let's provide a macro inline to
clearly show what is and isn't the same, and for the rest duplicate
the definition inline. The description of the aliased options was
"alias of --%s", which is being carried forward here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c               |  12 ++--
 builtin/log.c                 |   2 +-
 builtin/receive-pack.c        |   2 +-
 builtin/upload-pack.c         |   2 +-
 parse-options.c               | 111 +---------------------------------
 parse-options.h               |   6 +-
 t/helper/test-parse-options.c |   3 +-
 7 files changed, 17 insertions(+), 121 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index fb377b27657..1234ee6e1d9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -107,10 +107,14 @@ static struct option builtin_clone_options[] = {
 		    N_("don't use local hardlinks, always copy")),
 	OPT_BOOL('s', "shared", &option_shared,
 		    N_("setup as shared repository")),
-	{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
-	  N_("pathspec"), N_("initialize submodules in the clone"),
-	  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
-	OPT_ALIAS(0, "recursive", "recurse-submodules"),
+#define OPT_RECURSE_F(l, d, f) \
+	{ OPTION_CALLBACK, 0, (l), &option_recurse_submodules, \
+	  N_("pathspec"), (d), \
+	  PARSE_OPT_OPTARG | (f), recurse_submodules_cb, (intptr_t)"." }
+	OPT_RECURSE_F("recurse-submodules",
+		      N_("initialize submodules in the clone"), 0),
+	OPT_RECURSE_F("recursive", N_("alias of --recurse-submodules"),
+		      PARSE_OPT_AMBIGUOUS_ALIAS),
 	OPT_INTEGER('j', "jobs", &max_jobs,
 		    N_("number of submodules cloned in parallel")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
diff --git a/builtin/log.c b/builtin/log.c
index f75d87e8d7f..4dfdc6e1671 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -179,7 +179,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT__QUIET(&quiet, N_("suppress diff output")),
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("use mail map file")),
-		OPT_ALIAS(0, "mailmap", "use-mailmap"),
+		OPT_BOOL(0, "mailmap", &mailmap, N_("alias of --use-mailmap")),
 		OPT_STRING_LIST(0, "decorate-refs", &decorate_refs_include,
 				N_("pattern"), N_("only decorate refs that match <pattern>")),
 		OPT_STRING_LIST(0, "decorate-refs-exclude", &decorate_refs_exclude,
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d9605..e4c825af1a9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2480,7 +2480,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("quiet")),
 		OPT_HIDDEN_BOOL(0, "stateless-rpc", &stateless_rpc, NULL),
 		OPT_HIDDEN_BOOL(0, "http-backend-info-refs", &advertise_refs, NULL),
-		OPT_ALIAS(0, "advertise-refs", "http-backend-info-refs"),
+		OPT_HIDDEN_BOOL(0, "advertise-refs", &advertise_refs, NULL),
 		OPT_HIDDEN_BOOL(0, "reject-thin-pack-for-testing", &reject_thin, NULL),
 		OPT_END()
 	};
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 125af53885f..5ab20fcb1c9 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -24,7 +24,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 			 N_("quit after a single request/response exchange")),
 		OPT_HIDDEN_BOOL(0, "http-backend-info-refs", &advertise_refs,
 				N_("serve up the info/refs for git-http-backend")),
-		OPT_ALIAS(0, "advertise-refs", "http-backend-info-refs"),
+		OPT_HIDDEN_BOOL(0, "advertise-refs", &advertise_refs, NULL),
 		OPT_BOOL(0, "strict", &strict,
 			 N_("do not try <directory>/.git/ if <directory> is no Git directory")),
 		OPT_INTEGER(0, "timeout", &timeout,
diff --git a/parse-options.c b/parse-options.c
index fc5b43ff0b2..0b5c71e923b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -389,7 +389,8 @@ static enum parse_opt_result parse_long_opt(
 		die("disallowed abbreviated or ambiguous option '%.*s'",
 		    (int)(arg_end - arg), arg);
 
-	if (ambiguous_option) {
+	if (ambiguous_option &&
+	    !(abbrev_option->flags & PARSE_OPT_AMBIGUOUS_ALIAS)) {
 		error(_("ambiguous option: %s "
 			"(could be --%s%s or --%s%s)"),
 			arg,
@@ -484,10 +485,6 @@ static void parse_options_check(const struct option *opts)
 			if (opts->callback)
 				BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
 			break;
-		case OPTION_ALIAS:
-			BUG("OPT_ALIAS() should not remain at this point. "
-			    "Are you using parse_options_step() directly?\n"
-			    "That case is not supported yet.");
 		default:
 			; /* ok. (usually accepts an argument) */
 		}
@@ -594,7 +591,7 @@ static int show_gitcomp(const struct option *opts, int show_all)
 		if (!opts->long_name)
 			continue;
 		if (!show_all &&
-			(opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE | PARSE_OPT_FROM_ALIAS)))
+			(opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE | PARSE_OPT_AMBIGUOUS_ALIAS)))
 			continue;
 
 		switch (opts->type) {
@@ -628,97 +625,6 @@ static int show_gitcomp(const struct option *opts, int show_all)
 	return PARSE_OPT_COMPLETE;
 }
 
-/*
- * Scan and may produce a new option[] array, which should be used
- * instead of the original 'options'.
- *
- * Right now this is only used to preprocess and substitute
- * OPTION_ALIAS.
- *
- * The returned options should be freed using free_preprocessed_options.
- */
-static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
-					 const struct option *options)
-{
-	struct option *newopt;
-	int i, nr, alias;
-	int nr_aliases = 0;
-
-	for (nr = 0; options[nr].type != OPTION_END; nr++) {
-		if (options[nr].type == OPTION_ALIAS)
-			nr_aliases++;
-	}
-
-	if (!nr_aliases)
-		return NULL;
-
-	ALLOC_ARRAY(newopt, nr + 1);
-	COPY_ARRAY(newopt, options, nr + 1);
-
-	/* each alias has two string pointers and NULL */
-	CALLOC_ARRAY(ctx->alias_groups, 3 * (nr_aliases + 1));
-
-	for (alias = 0, i = 0; i < nr; i++) {
-		int short_name;
-		const char *long_name;
-		const char *source;
-		struct strbuf help = STRBUF_INIT;
-		int j;
-
-		if (newopt[i].type != OPTION_ALIAS)
-			continue;
-
-		short_name = newopt[i].short_name;
-		long_name = newopt[i].long_name;
-		source = newopt[i].value;
-
-		if (!long_name)
-			BUG("An alias must have long option name");
-		strbuf_addf(&help, _("alias of --%s"), source);
-
-		for (j = 0; j < nr; j++) {
-			const char *name = options[j].long_name;
-
-			if (!name || strcmp(name, source))
-				continue;
-
-			if (options[j].type == OPTION_ALIAS)
-				BUG("No please. Nested aliases are not supported.");
-
-			memcpy(newopt + i, options + j, sizeof(*newopt));
-			newopt[i].short_name = short_name;
-			newopt[i].long_name = long_name;
-			newopt[i].help = strbuf_detach(&help, NULL);
-			newopt[i].flags |= PARSE_OPT_FROM_ALIAS;
-			break;
-		}
-
-		if (j == nr)
-			BUG("could not find source option '%s' of alias '%s'",
-			    source, newopt[i].long_name);
-		ctx->alias_groups[alias * 3 + 0] = newopt[i].long_name;
-		ctx->alias_groups[alias * 3 + 1] = options[j].long_name;
-		ctx->alias_groups[alias * 3 + 2] = NULL;
-		alias++;
-	}
-
-	return newopt;
-}
-
-static void free_preprocessed_options(struct option *options)
-{
-	int i;
-
-	if (!options)
-		return;
-
-	for (i = 0; options[i].type != OPTION_END; i++) {
-		if (options[i].flags & PARSE_OPT_FROM_ALIAS)
-			free((void *)options[i].help);
-	}
-	free(options);
-}
-
 static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *,
 							 const char * const *,
 							 const struct option *,
@@ -867,15 +773,11 @@ int parse_options(int argc, const char **argv,
 		  enum parse_opt_flags flags)
 {
 	struct parse_opt_ctx_t ctx;
-	struct option *real_options;
 
 	disallow_abbreviated_options =
 		git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0);
 
 	memset(&ctx, 0, sizeof(ctx));
-	real_options = preprocess_options(&ctx, options);
-	if (real_options)
-		options = real_options;
 	parse_options_start_1(&ctx, argc, argv, prefix, options, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
@@ -899,7 +801,6 @@ int parse_options(int argc, const char **argv,
 	}
 
 	precompose_argv_prefix(argc, argv, NULL);
-	free_preprocessed_options(real_options);
 	free(ctx.alias_groups);
 	return parse_options_end(&ctx);
 }
@@ -1048,12 +949,6 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 			fputc('\n', outfile);
 			pad = USAGE_OPTS_WIDTH;
 		}
-		if (opts->type == OPTION_ALIAS) {
-			fprintf(outfile, "%*s", pad + USAGE_GAP, "");
-			fprintf_ln(outfile, _("alias of --%s"),
-				   (const char *)opts->value);
-			continue;
-		}
 		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", _(opts->help));
 	}
 	fputc('\n', outfile);
diff --git a/parse-options.h b/parse-options.h
index 275fb440818..3ad0c7dbafd 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -10,7 +10,6 @@ enum parse_opt_type {
 	OPTION_END,
 	OPTION_GROUP,
 	OPTION_NUMBER,
-	OPTION_ALIAS,
 	/* options with no arguments */
 	OPTION_BIT,
 	OPTION_NEGBIT,
@@ -44,7 +43,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 1 << 4,
 	PARSE_OPT_NODASH = 1 << 5,
 	PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
-	PARSE_OPT_FROM_ALIAS = 1 << 7,
+	PARSE_OPT_AMBIGUOUS_ALIAS = 1 << 7,
 	PARSE_OPT_NOCOMPLETE = 1 << 9,
 	PARSE_OPT_COMP_ARG = 1 << 10,
 	PARSE_OPT_CMDMODE = 1 << 11,
@@ -197,9 +196,6 @@ struct option {
 	  N_("no-op (backward compatibility)"),		\
 	  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, parse_opt_noop_cb }
 
-#define OPT_ALIAS(s, l, source_long_name) \
-	{ OPTION_ALIAS, (s), (l), (source_long_name) }
-
 /*
  * parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[]. argv0 is assumed program name and
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 48d3cf6692d..e0a3d9e8f51 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -153,7 +153,8 @@ int cmd__parse_options(int argc, const char **argv)
 			     collect_expect),
 		OPT_GROUP("Alias"),
 		OPT_STRING('A', "alias-source", &string, "string", "get a string"),
-		OPT_ALIAS('Z', "alias-target", "alias-source"),
+		{ OPTION_STRING, 'Z', "alias-target", &string, "string",
+		  "alias of --alias-source", PARSE_OPT_AMBIGUOUS_ALIAS },
 		OPT_END(),
 	};
 	int i;
-- 
2.34.0.rc2.809.g11e21d44b24

