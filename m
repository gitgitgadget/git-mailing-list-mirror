Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5EF1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754215AbdCXXKa (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:10:30 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36822 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754152AbdCXXK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:10:28 -0400
Received: by mail-wm0-f54.google.com with SMTP id n11so23575653wma.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kPXPDs8cQjZT5/zTxB4/SDsm4XLs6Pqbp/AWGS086vc=;
        b=X/EPaasIHX1Nrfj/B1qWGMC+EeWkb50uGqXn5Rpx/IXxzH4x6iJhCpWIPnHv05iShs
         aFqAkaHmyDD7oy0YUpQGqh9h/dSxOHtcGTPmsR9/FEJZ0ni+Y/EDbgh1AtP5D0kdD5Ho
         5nc9B/7ZrrNTJzFrMrRFNvd/OAQo63OA29KwHmgM3s0aoiro3xUKfDEbc//DV5hju3WE
         0cwt4SYMtMbciqIUdfUqy8ewrM57fyBgUlGEW28EfHuw2hri1YrTEFeKh8o6odV0auQz
         bX6puFt15Anq/hSGrsylQw/9uvkBqbwerr+U5YorIJSfq6HuhjAtbS+yrFFUVhE9fADT
         0kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kPXPDs8cQjZT5/zTxB4/SDsm4XLs6Pqbp/AWGS086vc=;
        b=AyOEHXq5p5coBsCAzgUbe8HsnlbOW6tS+ZvRjckUAezgHEjnvoDCVMtUJoPvD09g/6
         qecxf+VqJs/b8QCxAmg35qiE1MZ7qPPJJgw/q8n7g6hxvU2ngl+1CJRNNJw5vD55j0Fv
         bc/mvnO1iGKq6DOLad/nWmPa3qKhbf9SuiYcwFFfApJaK1e5ZCKfl20kqwrtX/IMztPE
         VayJ/MsCK+XnfEACldWS5TBlevF33penEcPL4joTX6N3JoiAft+2K68xZwOm74Psscnv
         sOtCXZgb9e3P72Pad1qDddnrBVokmJ04136nrywlTDnWWnOCCoCjy7sw1ZoUMNhuIGTt
         wOeQ==
X-Gm-Message-State: AFeK/H3XsUZKtDLP1o+Hkmc8cAr3cMA2nWwhwODH2h/wledfhvylN6C0oock9MaCX/Vzxw==
X-Received: by 10.28.47.205 with SMTP id v196mr5666787wmv.20.1490397026197;
        Fri, 24 Mar 2017 16:10:26 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 134sm4146130wmj.6.2017.03.24.16.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 16:10:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH/RFC] parse-options: add facility to make options configurable
Date:   Fri, 24 Mar 2017 23:10:13 +0000
Message-Id: <20170324231013.23346-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
References: <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a nascent WIP facility to specify via the options parsing that
we'd e.g. like to grab the --status option for commit.status from the
commit.status config key.

This is all very proof-of-concept, and uses the ugly hack of s/const
// for the options struct because I'm now keeping state in it, as
noted in one of the TODO comments that should be moved.

But even so this works, passes all tests, gets rid of 3 lines in
commit.c, and has the promise of getting rid of a *lot* more manual
option parsing in favor of declaring config keys via OPT_*
everywhere. See my
<CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
for more details.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Sun, Mar 19, 2017 at 2:43 PM, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> I don't know if this is what Duy has in mind, but the facility I've
> described is  purely an internal code reorganization issue. I.e. us
> not having to write custom code for each bultin every time we want to
> take an option from the command line || config.

Here's an implementation of this I hacked up this evening. This is
very WIP as noted in the commit message / TODO comments, but it works!
I thought I'd send it to the list for comments on the general approach
before taking it much further.

 builtin/commit.c   |  7 ++-----
 parse-options-cb.c | 21 +++++++++++++++++++++
 parse-options.c    | 40 ++++++++++++++++++++++++++++++++++++----
 parse-options.h    | 16 +++++++++++++---
 4 files changed, 72 insertions(+), 12 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 4e288bc513..a7c9e4128f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1500,10 +1500,6 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 
 	if (!strcmp(k, "commit.template"))
 		return git_config_pathname(&template_file, k, v);
-	if (!strcmp(k, "commit.status")) {
-		include_status = git_config_bool(k, v);
-		return 0;
-	}
 	if (!strcmp(k, "commit.cleanup"))
 		return git_config_string(&cleanup_arg, k, v);
 	if (!strcmp(k, "commit.gpgsign")) {
@@ -1596,7 +1592,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
 		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
-		OPT_BOOL(0, "status", &include_status, N_("include status in commit message template")),
+		OPT_BOOL_C(0, "status", &include_status, N_("include status in commit message template"),
+		           "commit.status", parse_opt_confkey_bool),
 		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		/* end commit message options */
diff --git a/parse-options-cb.c b/parse-options-cb.c
index b7d8f7dcb2..2383d9bbe0 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -236,3 +236,24 @@ int parse_opt_passthru_argv(const struct option *opt, const char *arg, int unset
 
 	return 0;
 }
+
+/* Does it suck that I have to use the cache interface to the config
+ * here? Should we somehow unroll this whole thing so
+ * parse_options_step loops over the config values, and maybe
+ * populates opt->conf_key (which we'd need to add) for all the
+ * options that need it?
+ *
+ * I.e. should we make this more complex because this one-shot
+ * interface is expensive, or is it just fine?
+*/ 
+
+int parse_opt_confkey_bool(const struct option *opt, const char *arg, int unset) {
+	const char *value;
+
+	if (git_config_get_value(opt->conf_key, &value))
+		return 0;
+
+	*(int *)opt->value = git_config_bool(opt->conf_key, value);
+
+	return 0;
+}
diff --git a/parse-options.c b/parse-options.c
index 4fbe924a5d..f9aba088d8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -235,12 +235,13 @@ static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *optio
 }
 
 static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
-                          const struct option *options)
+                          struct option *options)
 {
 	const struct option *all_opts = options;
 	const char *arg_end = strchrnul(arg, '=');
 	const struct option *abbrev_option = NULL, *ambiguous_option = NULL;
 	int abbrev_flags = 0, ambiguous_flags = 0;
+	int ret;
 
 	for (; options->type != OPTION_END; options++) {
 		const char *rest, *long_name = options->long_name;
@@ -313,7 +314,17 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 				continue;
 			p->opt = rest + 1;
 		}
-		return get_value(p, options, all_opts, flags ^ opt_flags);
+		if (!(ret = get_value(p, options, all_opts, flags ^ opt_flags))) {
+			/* TODO: Keep some different state on the side
+			 * with info about what options we've
+			 * retrieved via the CLI for use in the loop
+			 * in parse_options_step, instead of making
+			 * the 'options' non-const
+			 */
+		    	if (options->flags & PARSE_OPT_CONFIGURABLE)
+				options->flags |= PARSE_OPT_VIA_CLI;
+		}
+		return ret;
 	}
 
 	if (ambiguous_option)
@@ -429,7 +440,7 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *,
 				       const struct option *, int, int);
 
 int parse_options_step(struct parse_opt_ctx_t *ctx,
-		       const struct option *options,
+		       struct option *options,
 		       const char * const usagestr[])
 {
 	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
@@ -514,6 +525,27 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		ctx->out[ctx->cpidx++] = ctx->argv[0];
 		ctx->opt = NULL;
 	}
+
+	/* The loop above is driven by the argument vector, so we need
+	 * to make a second pass and find those options that are
+	 * configurable, and haven't been set via the command-line */
+	for (; options->type != OPTION_END; options++) {
+		if (!(options->flags & PARSE_OPT_CONFIGURABLE))
+			continue;
+
+		if (options->flags & PARSE_OPT_VIA_CLI)
+			continue;
+
+		/* TODO: Maybe factor the handling of OPTION_CALLBACK
+		 * in get_value() into a function.
+		 *
+		 * Do we also need to save away the state from the
+		 * loop above to handle unset? I think not, I think
+		 * we're always unset here by definition, right?
+		 */
+		return (*options->conf_callback)(options, NULL, 1) ? (-1) : 0;
+	}
+
 	return PARSE_OPT_DONE;
 
  show_usage_error:
@@ -530,7 +562,7 @@ int parse_options_end(struct parse_opt_ctx_t *ctx)
 }
 
 int parse_options(int argc, const char **argv, const char *prefix,
-		  const struct option *options, const char * const usagestr[],
+		  struct option *options, const char * const usagestr[],
 		  int flags)
 {
 	struct parse_opt_ctx_t ctx;
diff --git a/parse-options.h b/parse-options.h
index dcd8a0926c..14abf21467 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -38,7 +38,9 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 16,
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
-	PARSE_OPT_SHELL_EVAL = 256
+	PARSE_OPT_SHELL_EVAL = 256,
+	PARSE_OPT_CONFIGURABLE = 512,
+	PARSE_OPT_VIA_CLI = 1024
 };
 
 struct option;
@@ -110,6 +112,9 @@ struct option {
 	int flags;
 	parse_opt_cb *callback;
 	intptr_t defval;
+
+	const char *conf_key;
+	parse_opt_cb *conf_callback;
 };
 
 #define OPT_END()                   { OPTION_END }
@@ -124,7 +129,11 @@ struct option {
 				      (h), PARSE_OPT_NOARG }
 #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (i) }
+#define OPT_SET_INT_C(s, l, v, h, i, ck, cb) \
+				    { OPTION_SET_INT, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG | PARSE_OPT_CONFIGURABLE, NULL, (i), ck, cb }
 #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
+#define OPT_BOOL_C(s, l, v, h, ck, cb) OPT_SET_INT_C(s, l, v, h, 1, ck, cb)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
 #define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
@@ -166,7 +175,7 @@ struct option {
  * Returns the number of arguments left in argv[].
  */
 extern int parse_options(int argc, const char **argv, const char *prefix,
-                         const struct option *options,
+                         struct option *options,
                          const char * const usagestr[], int flags);
 
 extern NORETURN void usage_with_options(const char * const *usagestr,
@@ -210,7 +219,7 @@ extern void parse_options_start(struct parse_opt_ctx_t *ctx,
 				const struct option *options, int flags);
 
 extern int parse_options_step(struct parse_opt_ctx_t *ctx,
-			      const struct option *options,
+			      struct option *options,
 			      const char * const usagestr[]);
 
 extern int parse_options_end(struct parse_opt_ctx_t *ctx);
@@ -231,6 +240,7 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
 extern int parse_opt_unknown_cb(const struct option *, const char *, int);
 extern int parse_opt_passthru(const struct option *, const char *, int);
 extern int parse_opt_passthru_argv(const struct option *, const char *, int);
+extern int parse_opt_confkey_bool(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
-- 
2.11.0

