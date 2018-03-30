Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CC01F404
	for <e@80x24.org>; Fri, 30 Mar 2018 05:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeC3F2i (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 01:28:38 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38463 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeC3F2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 01:28:38 -0400
Received: by mail-it0-f67.google.com with SMTP id 19-v6so10347277itw.3
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 22:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yOWs9WIPsehcFTFT+HCQAdMZblwH66GoqxRuTgELtgE=;
        b=VqA3HmVWrW3v2zXQQQvV3NGbnzW94PVDLrxui8MEHSdilNOOdbLAWgyJ5lO7WbYsxQ
         aBFhJQ3iFKtw+8MWVcukBar4Q/f1/omgTBR8yACLDUE+5i48yFw0f091MjjhsmFO+k+N
         /8mdL9kdGlCwmynZVPLAwtcg/DluFs/15W8tZ7dBpc1G0Q9tlNxN7V1m0Nz26w/g5x7e
         Y0rj8OWdpNtMTThchK9u7gkVKfpV+zV8uJGyX3nIVVGnZYW3JfhCoGEypR7AfPgzBvuJ
         qStMELQ9BHPgBH1vEP4PTNN/t7BXgkLFGg/kYgi4QrsyzfdH4Z63XDHzi4YJgQhwHIix
         EvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yOWs9WIPsehcFTFT+HCQAdMZblwH66GoqxRuTgELtgE=;
        b=cIe+MNkWNBawwDrpDCbBCsYUjBJJPIDNS4bc549tMmsqN0O1X6iNYUgAG3qid2ku1t
         hUWeZ1F8+b9WPbDrd9W/QmIDnGBTPvbs2l37k10r4rCEWdsum2z0wr+u1lXlTaEGSbl8
         1XXuQwqS0zisQzI2yt39HBjrVGGkpxwXr0df308RE9nGlXgiJ4hQfd33z9M28Xy9qmXa
         F26eUTBKlZ4mSuWJrnit/XJYKRyCE7lJIk3vmuVMyZC9Kn2pLvoRv0S9x+FVE7DhoH3C
         jcFvKhvLwXfkQ9GYznlY4Bk8xbTSwTJfGP1fFlzkzT69/C9e6gBSTJqw1qT38xXd6RlC
         RkGQ==
X-Gm-Message-State: AElRT7GzJ4E7IpmEF824vApeSdNqd2WepnndKO5Od/S9Xlj1odXFsRbP
        w1Bf6/d42KhTPvf0lSZDZPNnrNAgUAY=
X-Google-Smtp-Source: AIpwx4+c6qJpoKk9S9RBWcDBuLX5T46oV8O/2P2lRSqIigUrxOOfqTRgfL9cXmB6PlvT+SxnhjfVww==
X-Received: by 2002:a24:4707:: with SMTP id t7-v6mr1785227itb.105.1522387717116;
        Thu, 29 Mar 2018 22:28:37 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:1cc3:31e8:a3ff:d05])
        by smtp.gmail.com with ESMTPSA id 4sm4614427iox.55.2018.03.29.22.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Mar 2018 22:28:36 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     peff@peff.net, gitster@pobox.com
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 1/2] builtin/config.c: treat type specifiers singularly
Date:   Fri, 30 Mar 2018 01:28:29 -0400
Message-Id: <20180330052830.57251-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da4f
In-Reply-To: <20180328234719.595-1-me@ttaylorr.com>
References: <20180328234719.595-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Internally, we represent `git config`'s type specifiers as a bitset
using OPT_BIT. 'bool' is 1<<0, 'int' is 1<<1, and so on. This technique
allows for the representation of multiple type specifiers in the `int
types` field, but this multi-representation is left unused.

In fact, `git config` will not accept multiple type specifiers at a
time, as indicated by:

  $ git config --int --bool some.section
  error: only one type at a time.

This patch uses `OPT_SET_INT` to prefer the _last_ mentioned type
specifier, so that the above command would instead be valid, and a
synonym of:

  $ git config --bool some.section

This change is motivated by two urges: (1) it does not make sense to
represent a singular type specifier internally as a bitset, only to
complain when there are multiple bits in the set. `OPT_SET_INT` is more
well-suited to this task than `OPT_BIT` is. (2) a future patch will
introduce `--type=<type>`, and we would like not to complain in the
following situation:

  $ git config --int --type=int

Where--although the legacy and modern type specifier (`--int`, and
`--type`, respectively) do not conflict--we would store the value of
`--type=` in a `char *` and the `--int` as a bit in the `int` bitset.

In the above, when error-checking `if (types != && type_str)`, we do not
check additionally whether or not these types are the same, and simply
complain immediately. This change makes `--int` and `--type=int` a true
synonym of each other, and removes the need for additional complexity,
as above in the conditional.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/config.c       | 39 +++++++++++++++++----------------------
 t/t1300-repo-config.sh | 11 +++++++++++
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 01169dd62..fd7b36c41 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -25,7 +25,7 @@ static char term = '\n';
 
 static int use_global_config, use_system_config, use_local_config;
 static struct git_config_source given_config_source;
-static int actions, types;
+static int actions, type;
 static int end_null;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
@@ -84,11 +84,11 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
-	OPT_BIT(0, "bool", &types, N_("value is \"true\" or \"false\""), TYPE_BOOL),
-	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
-	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
-	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
-	OPT_BIT(0, "expiry-date", &types, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
+	OPT_SET_INT(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
+	OPT_SET_INT(0, "int", &type, N_("value is decimal number"), TYPE_INT),
+	OPT_SET_INT(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
+	OPT_SET_INT(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
+	OPT_SET_INT(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
@@ -149,26 +149,26 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 		if (show_keys)
 			strbuf_addch(buf, key_delim);
 
-		if (types == TYPE_INT)
+		if (type == TYPE_INT)
 			strbuf_addf(buf, "%"PRId64,
 				    git_config_int64(key_, value_ ? value_ : ""));
-		else if (types == TYPE_BOOL)
+		else if (type == TYPE_BOOL)
 			strbuf_addstr(buf, git_config_bool(key_, value_) ?
 				      "true" : "false");
-		else if (types == TYPE_BOOL_OR_INT) {
+		else if (type == TYPE_BOOL_OR_INT) {
 			int is_bool, v;
 			v = git_config_bool_or_int(key_, value_, &is_bool);
 			if (is_bool)
 				strbuf_addstr(buf, v ? "true" : "false");
 			else
 				strbuf_addf(buf, "%d", v);
-		} else if (types == TYPE_PATH) {
+		} else if (type == TYPE_PATH) {
 			const char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
 				return -1;
 			strbuf_addstr(buf, v);
 			free((char *)v);
-		} else if (types == TYPE_EXPIRY_DATE) {
+		} else if (type == TYPE_EXPIRY_DATE) {
 			timestamp_t t;
 			if (git_config_expiry_date(&t, key_, value_) < 0)
 				return -1;
@@ -287,7 +287,7 @@ static char *normalize_value(const char *key, const char *value)
 	if (!value)
 		return NULL;
 
-	if (types == 0 || types == TYPE_PATH || types == TYPE_EXPIRY_DATE)
+	if (type == 0 || type == TYPE_PATH || type == TYPE_EXPIRY_DATE)
 		/*
 		 * We don't do normalization for TYPE_PATH here: If
 		 * the path is like ~/foobar/, we prefer to store
@@ -296,11 +296,11 @@ static char *normalize_value(const char *key, const char *value)
 		 * Also don't do normalization for expiry dates.
 		 */
 		return xstrdup(value);
-	if (types == TYPE_INT)
+	if (type == TYPE_INT)
 		return xstrfmt("%"PRId64, git_config_int64(key, value));
-	if (types == TYPE_BOOL)
+	if (type == TYPE_BOOL)
 		return xstrdup(git_config_bool(key, value) ?  "true" : "false");
-	if (types == TYPE_BOOL_OR_INT) {
+	if (type == TYPE_BOOL_OR_INT) {
 		int is_bool, v;
 		v = git_config_bool_or_int(key, value, &is_bool);
 		if (!is_bool)
@@ -309,7 +309,7 @@ static char *normalize_value(const char *key, const char *value)
 			return xstrdup(v ? "true" : "false");
 	}
 
-	die("BUG: cannot normalize type %d", types);
+	die("BUG: cannot normalize type %d", type);
 }
 
 static int get_color_found;
@@ -566,12 +566,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		key_delim = '\n';
 	}
 
-	if (HAS_MULTI_BITS(types)) {
-		error("only one type at a time.");
-		usage_with_options(builtin_config_usage, builtin_config_options);
-	}
-
-	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && types) {
+	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
 		error("--get-color and variable type are incoherent");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 4f8e6f5fd..aa45b9267 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1611,4 +1611,15 @@ test_expect_success '--local requires a repo' '
 	test_expect_code 128 nongit git config --local foo.bar
 '
 
+cat >.git/config <<-\EOF &&
+[core]
+number = 10
+EOF
+
+test_expect_success 'later legacy specifiers are given precedence' '
+	git config --bool --int core.number >actual &&
+	echo 10 > expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.16.2.440.gc6284da4f

