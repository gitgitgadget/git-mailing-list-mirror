Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031311F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeDIWq7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:46:59 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37296 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbeDIWq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:46:58 -0400
Received: by mail-pf0-f195.google.com with SMTP id p6so3049264pfn.4
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XB5SWbMqA66Ip8iqu3d27HE2/v9VnewTN/3dchi8Fbo=;
        b=EhEAbIt2IXLM4L5L5cFUc24lWK1aZfD1oYVquDI5aFdYZXsC7bnTHwdBNGqHfCE301
         qba3k0z+bD/JskIYmq6Go7crSbIcrKd6OtlZ9Ijtm6GMa560aRVgw7kfy529XxeQ9rRT
         febY8gMlegLLGNspdPgL+WBt9aSh5Fqiw3RhWa3EnwilOloXwB+uBagwhE1OKMx7QceY
         wxrSSlcRKr8jDnIqOwB2MOfxjj7o5D5hy1m04QLO5fbz7XHWEaRByZtB02NMW8PrXlpW
         qUrzpbHys6bNPhiEJ8yycUHJ3CoyQ5HLe3U3wnMvMVNaYl05a5Iahqffsdut0dtHAXNH
         RZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XB5SWbMqA66Ip8iqu3d27HE2/v9VnewTN/3dchi8Fbo=;
        b=kOqUoOyMN3o84HErfauOhQX9oZIMqgF7h1+8mFZfxdm24l13z/O/kcezWdiu2d87Qc
         SfnUlvKRlKliSZu9BF3MnCpSIYo1l+83UJy0VPd/UjymDoKGt2P/8nyp1o3TCbJEobsI
         zJhLungJS/9Ijy4dvRB/PCH5xAZ7z2sU609md2Gb68vXLM0LIqK7kKhJ6/GPcR8U329L
         BeXb82lsXKvC5aWwI8vzR69pce88cwwoPkEWugplPth73Ue6dS9H1TPDIyU8pRFCz0s/
         fSu+BgsTNywUZaLHoPgPFZ0j1xPbROC8A6VpeEXdZVayyCvGp6ccLd6DvJMOfzywFaf9
         g2qg==
X-Gm-Message-State: ALQs6tA3w62KBZqaEZkaA0pUZiRJkYpXmJ8DpbS+n1U74QS5GR+FUU8e
        xOPiet+J0DIM+P3WoQSwtXYnKuvkFyw=
X-Google-Smtp-Source: AIpwx4+aibpuUjraaTOfyaY1W2PooEUuhUcCkemjsbsf0j+8OVsEZNtGlv4/rEQMZnIxSE0CwXPdHA==
X-Received: by 10.99.102.195 with SMTP id a186mr12405489pgc.207.1523314016632;
        Mon, 09 Apr 2018 15:46:56 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d66:22f3:ac1d:6007])
        by smtp.gmail.com with ESMTPSA id w134sm2982681pfd.132.2018.04.09.15.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 15:46:55 -0700 (PDT)
Date:   Mon, 9 Apr 2018 15:46:54 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ericsunshine@sunshineco.com
Subject: [PATCH v7 1/2] builtin/config.c: treat type specifiers singularly
Message-ID: <20180409224654.GB34547@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1523313730.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1523313730.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
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

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/config.c       | 49 +++++++++++++++++++-----------------------
 t/t1300-repo-config.sh | 11 ++++++++++
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 01169dd628..92fb8d56b1 100644
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
@@ -55,11 +55,11 @@ static int show_origin;
 #define PAGING_ACTIONS (ACTION_LIST | ACTION_GET_ALL | \
 			ACTION_GET_REGEXP | ACTION_GET_URLMATCH)
 
-#define TYPE_BOOL (1<<0)
-#define TYPE_INT (1<<1)
-#define TYPE_BOOL_OR_INT (1<<2)
-#define TYPE_PATH (1<<3)
-#define TYPE_EXPIRY_DATE (1<<4)
+#define TYPE_BOOL		1
+#define TYPE_INT		2
+#define TYPE_BOOL_OR_INT	3
+#define TYPE_PATH		4
+#define TYPE_EXPIRY_DATE	5
 
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
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
index 4f8e6f5fde..24de37d544 100755
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
+	echo 10 >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.17.0

