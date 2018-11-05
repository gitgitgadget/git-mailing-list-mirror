Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E9291F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbeKFEmd (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45888 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388025AbeKFEmc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id j4-v6so9107273ljc.12
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HfXrscd1950SlZXWlB907D0ZDjatnBQ3hxZR8Gb2P2M=;
        b=Apv71E5rlnsqPVy0hw6naIM5DKJsYgWOqjHty7hTT3b0UB8l3sgwIs1jagcOLwrvpe
         V9LuLJzDOWaGE5VKFSkGSJQe73cl6iGuGszgEwwBQIRbaurUTzy6ZVZu6u7CWzOoribf
         LNBy8NqWdWjdv/oiS2hnZ0TgipJ9Sjg3ZyQr45v8eVvTsrAT2h8n2KR585ThyBV+UWqz
         nJAMbcpOKztpv95hnHUCu7Qfoo6v5fpLIPP5ey22qNdLQ/NJ3g4tXBYI/egflQMqzVz5
         V2XYVMOMN1GiVz6Bc7mNhGk+ou1ZlhtpStyqp2BGFiUyBhOl7u5IIap36rjfxwyekY6T
         fnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfXrscd1950SlZXWlB907D0ZDjatnBQ3hxZR8Gb2P2M=;
        b=MdFOF7xJUjL16vLv7tv2Lnykz5ieUeA0w3nWVi6ko9mc6kySQZHYs9AQkMVK6ZOIk1
         XYm0nKql9VAq91gEyTXLp7Lrn4S5fDd2ALTfkoJ5XcW5qo3ikvWv7p5jJJ234T+qnYYH
         ws/t12jh2NH1/y3SXCMMkr0wjQFaNtDsuPVKPvo1Pw5pDEO8j0bF9KKailndwkSYf6P+
         e506OYAEo6G3R2+d59d79u2EJK11ybB/USDr6eWgzDk1IeMa1mACj0XhujQGTilAvFep
         GSEXeXP0uIsQNHlr/nKejGjlUUc0xOURTDQdL+U8SvOvbd68HOUxSwUdQD/FV6h5yNPQ
         OmCw==
X-Gm-Message-State: AGRZ1gKwCetyWDLMPd1HEY5mps63fgZ8RwBqClWE36hda1Dmh1PwMisC
        Iv7El/E3KVlBoeICEwFF73U=
X-Google-Smtp-Source: AJdET5cH7e+aD9fxe/nF2+kFt0QidKhWdJhQvplxQHUptNMuFSxESLbKp+EqFFDnb4cVsNV5C2+PsA==
X-Received: by 2002:a2e:2d01:: with SMTP id t1-v6mr3803761ljt.159.1541445681646;
        Mon, 05 Nov 2018 11:21:21 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:20 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 12/16] parse-options: replace opterror() with optname()
Date:   Mon,  5 Nov 2018 20:20:55 +0100
Message-Id: <20181105192059.20303-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a few issues with opterror()

- it tries to assemble an English sentence from pieces. This is not
  great for translators because we give them pieces instead of a full
  sentence.

- It's a wrapper around error() and needs some hack to let the
  compiler know it always returns -1.

- Since it takes a string instead of printf format, one call site has
  to assemble the string manually before passing to it.

Kill it and produce the option name with optname(). The user will use
error() directly. This solves the second and third problems.

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
2.19.1.1005.gac84295441

