Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B6B1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeKJP1I (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:27:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34545 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbeKJP1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:27:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so2832697lfc.1
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5gXvtVWYs8TIJO5EVabMF+rMq5ZVHlPcFQ1crV7ysc=;
        b=TxEHjAfjxOZwDzRrDy1Qlaj6zarOG4mxm+UUKMb2GBEA9MmWdXE50tSPskUMtfsRM+
         qZP06rb9AKMf/Nf4Hjq03GLa9FqCqMK0S/wUd2OqvsgyXMCVQBSqKZ2piK7YJgwKvqgE
         /gTfAIPpRvX1+MaEXOzauGlgewgLek9ssvKhwTFVl3DBzwwkNCKgL4bgrQE6Ncofb4Au
         ocu7Zt7SG7bILGXZafNvguYQH8TyCnuZ1ptJ67Fm9zPyr/8au6+U0y7VyLZQmC1BUbOc
         kESTQekro9eeka5MOG4AF57qweovdNpDroWR+4Gx0S4rNb971e+88ZzehruNhE4cqJ8u
         P3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5gXvtVWYs8TIJO5EVabMF+rMq5ZVHlPcFQ1crV7ysc=;
        b=aYc2isH8G1+UmLCbH2tFphqfFKL6LnbTFgIBhjD9luHyDpkATH/OsqCZ6FQKNDhCIG
         D5ZFuejNWyUcTmFpoFnRXfbRfue4Vj3E3fR3JQCojTqS1WatGZ9trnl0Uu/w0LRDy/73
         3jrcnZ8Ku7jc50UDGh1TPQJFClxKllQaHdZPcFr4Q3BzuUDkgYFIKiE/cOj8wS8h90I0
         L5t+/H03i+lWoNZy4CSD1WDt+vxno4KX4fIypDYZFKJrYs/kVnSXeO+7j1KE9HLAiimC
         /JijFqhjbvxLQEUkBG9eVH799Ha/jLIGpqcoPKEUX1LCCuUUiNyrIosudu0DMF+zPPkh
         N/BA==
X-Gm-Message-State: AGRZ1gKK53CTsm59hE6ZcKjFe3Q4yAPkrESYpOof0crlWh/EPBUfPx/n
        RCn5M7AzhGVrrUQu9SpBK/U=
X-Google-Smtp-Source: AJdET5evKkusrcb012v4c67b57ExuJqkByzwsf7PtE72UErbZChvxBeIuYiNeheGrEJxPoXEqEcQWQ==
X-Received: by 2002:a19:9904:: with SMTP id b4mr6702553lfe.95.1541826995680;
        Fri, 09 Nov 2018 21:16:35 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:34 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 12/16] parse-options: replace opterror() with optname()
Date:   Sat, 10 Nov 2018 06:16:11 +0100
Message-Id: <20181110051615.8641-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce optname() that does the early half of original opterror() to
come up with the name of the option reported back to the user, and use
it to kill opterror().  The callers of opterror() now directly call
error() using the string returned by opterror() instead.

There are a few issues with opterror()

- it tries to assemble an English sentence from pieces. This is not
  great for translators because we give them pieces instead of a full
  sentence.

- It's a wrapper around error() and needs some hack to let the
  compiler know it always returns -1.

- Since it takes a string instead of printf format, one call site has
  to assemble the string manually before passing to it.

Using error() directly solves the second and third problems.

It kind helps the first problem as well because "%s does foo" does
give a translator a full sentence in a sense and let them reorder if
needed. But it has limitations, if the subject part has to change
based on the rest of the sentence, that language is screwed. This is
also why I try to avoid calling optname() when 'flags' is known in
advance.

Mark of these strings for translation as well while at there.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/merge.c     |  2 +-
 builtin/revert.c    |  3 ++-
 parse-options-cb.c  |  7 ++++---
 parse-options.c     | 46 +++++++++++++++++++++++++--------------------
 parse-options.h     |  5 +----
 ref-filter.c        |  8 +++++---
 t/t4211-line-log.sh |  2 +-
 7 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 92ba7e1c6d..82248d43c3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -128,7 +128,7 @@ static int option_read_message(struct parse_opt_ctx_t *ctx,
 		ctx->argc--;
 		arg = *++ctx->argv;
 	} else
-		return opterror(opt, "requires a value", 0);
+		return error(_("option `%s' requires a value"), opt->long_name);
 
 	if (buf->len)
 		strbuf_addch(buf, '\n');
diff --git a/builtin/revert.c b/builtin/revert.c
index c93393c89b..11190d2ab4 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -69,7 +69,8 @@ static int option_parse_m(const struct option *opt,
 
 	replay->mainline = strtol(arg, &end, 10);
 	if (*end || replay->mainline <= 0)
-		return opterror(opt, "expects a number greater than zero", 0);
+		return error(_("option `%s' expects a number greater than zero"),
+			     opt->long_name);
 
 	return 0;
 }
diff --git a/parse-options-cb.c b/parse-options-cb.c
index e8236534ac..813eb6301b 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -18,7 +18,8 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 	} else {
 		v = strtol(arg, (char **)&arg, 10);
 		if (*arg)
-			return opterror(opt, "expects a numerical value", 0);
+			return error(_("option `%s' expects a numerical value"),
+				     opt->long_name);
 		if (v && v < MINIMUM_ABBREV)
 			v = MINIMUM_ABBREV;
 		else if (v > 40)
@@ -54,8 +55,8 @@ int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
 		arg = unset ? "never" : (const char *)opt->defval;
 	value = git_config_colorbool(NULL, arg);
 	if (value < 0)
-		return opterror(opt,
-			"expects \"always\", \"auto\", or \"never\"", 0);
+		return error(_("option `%s' expects \"always\", \"auto\", or \"never\""),
+			     opt->long_name);
 	*(int *)opt->value = value;
 	return 0;
 }
diff --git a/parse-options.c b/parse-options.c
index 3b874a83a0..0bf817193d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -32,7 +32,7 @@ static int get_arg(struct parse_opt_ctx_t *p, const struct option *opt,
 		p->argc--;
 		*arg = *++p->argv;
 	} else
-		return opterror(opt, "requires a value", flags);
+		return error(_("%s requires a value"), optname(opt, flags));
 	return 0;
 }
 
@@ -49,7 +49,6 @@ static int opt_command_mode_error(const struct option *opt,
 				  int flags)
 {
 	const struct option *that;
-	struct strbuf message = STRBUF_INIT;
 	struct strbuf that_name = STRBUF_INIT;
 
 	/*
@@ -67,13 +66,13 @@ static int opt_command_mode_error(const struct option *opt,
 			strbuf_addf(&that_name, "--%s", that->long_name);
 		else
 			strbuf_addf(&that_name, "-%c", that->short_name);
-		strbuf_addf(&message, ": incompatible with %s", that_name.buf);
+		error(_("%s is incompatible with %s"),
+		      optname(opt, flags), that_name.buf);
 		strbuf_release(&that_name);
-		opterror(opt, message.buf, flags);
-		strbuf_release(&message);
 		return -1;
 	}
-	return opterror(opt, ": incompatible with something else", flags);
+	return error(_("%s : incompatible with something else"),
+		     optname(opt, flags));
 }
 
 static int get_value(struct parse_opt_ctx_t *p,
@@ -86,11 +85,11 @@ static int get_value(struct parse_opt_ctx_t *p,
 	int err;
 
 	if (unset && p->opt)
-		return opterror(opt, "takes no value", flags);
+		return error(_("%s takes no value"), optname(opt, flags));
 	if (unset && (opt->flags & PARSE_OPT_NONEG))
-		return opterror(opt, "isn't available", flags);
+		return error(_("%s isn't available"), optname(opt, flags));
 	if (!(flags & OPT_SHORT) && p->opt && (opt->flags & PARSE_OPT_NOARG))
-		return opterror(opt, "takes no value", flags);
+		return error(_("%s takes no value"), optname(opt, flags));
 
 	switch (opt->type) {
 	case OPTION_LOWLEVEL_CALLBACK:
@@ -176,7 +175,8 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return -1;
 		*(int *)opt->value = strtol(arg, (char **)&s, 10);
 		if (*s)
-			return opterror(opt, "expects a numerical value", flags);
+			return error(_("%s expects a numerical value"),
+				     optname(opt, flags));
 		return 0;
 
 	case OPTION_MAGNITUDE:
@@ -191,9 +191,9 @@ static int get_value(struct parse_opt_ctx_t *p,
 		if (get_arg(p, opt, flags, &arg))
 			return -1;
 		if (!git_parse_ulong(arg, opt->value))
-			return opterror(opt,
-				"expects a non-negative integer value with an optional k/m/g suffix",
-				flags);
+			return error(_("%s expects a non-negative integer value"
+				       " with an optional k/m/g suffix"),
+				     optname(opt, flags));
 		return 0;
 
 	default:
@@ -257,7 +257,8 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 			if (!rest)
 				continue;
 			if (*rest == '=')
-				return opterror(options, "takes no value", flags);
+				return error(_("%s takes no value"),
+					     optname(options, flags));
 			if (*rest)
 				continue;
 			p->out[p->cpidx++] = arg - 2;
@@ -773,12 +774,17 @@ void NORETURN usage_msg_opt(const char *msg,
 	usage_with_options(usagestr, options);
 }
 
-#undef opterror
-int opterror(const struct option *opt, const char *reason, int flags)
+const char *optname(const struct option *opt, int flags)
 {
+	static struct strbuf sb = STRBUF_INIT;
+
+	strbuf_reset(&sb);
 	if (flags & OPT_SHORT)
-		return error("switch `%c' %s", opt->short_name, reason);
-	if (flags & OPT_UNSET)
-		return error("option `no-%s' %s", opt->long_name, reason);
-	return error("option `%s' %s", opt->long_name, reason);
+		strbuf_addf(&sb, "switch `%c'", opt->short_name);
+	else if (flags & OPT_UNSET)
+		strbuf_addf(&sb, "option `no-%s'", opt->long_name);
+	else
+		strbuf_addf(&sb, "option `%s'", opt->long_name);
+
+	return sb.buf;
 }
diff --git a/parse-options.h b/parse-options.h
index dd14911a29..2e146aa6fa 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -189,10 +189,7 @@ extern NORETURN void usage_msg_opt(const char *msg,
 				   const struct option *options);
 
 extern int optbug(const struct option *opt, const char *reason);
-extern int opterror(const struct option *opt, const char *reason, int flags);
-#if defined(__GNUC__)
-#define opterror(o,r,f) (opterror((o),(r),(f)), const_error())
-#endif
+const char *optname(const struct option *opt, int flags);
 
 /*----- incremental advanced APIs -----*/
 
diff --git a/ref-filter.c b/ref-filter.c
index 2a05619211..0681359100 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2302,9 +2302,11 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 
 	if (rf->merge) {
 		if (no_merged) {
-			return opterror(opt, "is incompatible with --merged", 0);
+			return error(_("option `%s' is incompatible with --merged"),
+				     opt->long_name);
 		} else {
-			return opterror(opt, "is incompatible with --no-merged", 0);
+			return error(_("option `%s' is incompatible with --no-merged"),
+				     opt->long_name);
 		}
 	}
 
@@ -2318,7 +2320,7 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 	rf->merge_commit = lookup_commit_reference_gently(the_repository,
 							  &oid, 0);
 	if (!rf->merge_commit)
-		return opterror(opt, "must point to a commit", 0);
+		return error(_("option `%s' must point to a commit"), opt->long_name);
 
 	return 0;
 }
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index ef1322148e..bd5fe4d148 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -25,7 +25,7 @@ canned_test_failure () {
 test_bad_opts () {
 	test_expect_success "invalid args: $1" "
 		test_must_fail git log $1 2>errors &&
-		grep '$2' errors
+		test_i18ngrep '$2' errors
 	"
 }
 
-- 
2.19.1.1231.g84aef82467

