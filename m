Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60E181F404
	for <e@80x24.org>; Tue,  6 Mar 2018 02:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeCFCRq (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 21:17:46 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40579 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753055AbeCFCRp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 21:17:45 -0500
Received: by mail-pl0-f65.google.com with SMTP id i6-v6so10981690plt.7
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 18:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2V7ljihKVGNomRyvSPlW9pNFo4xrrS4gFj+gwjOFG1c=;
        b=ax07ELi1AlVEibrdNqjj4nIX92PyHEeZWuEkXFtXEsxIjGAQ/usUSQ2xJzzmNyYBWB
         yHeDcyPvbCK9+PJ7yTkKL+du9iVaFDfhnVpyiU5U19s6XuPg4goYc1EgoK+iVI0hiZbz
         x0z99qSnj/DNIcz026OdS0r08LBf7ZJRpRIaSkTRMim1ID6S7tft8ehwViIvHLJ9Xo8r
         iwPev90B+efbP4K3nBsC5kYHGT8PFtXQYtvH8SGBo7u29Ktuzez1Ry24ygbpWrfRLNoB
         HEfveTodGtmeoado26aXJe+UP+LeZXH5W6prjQW5QbtnNHAKt16l7UPoQb3I23N0p2PY
         rgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2V7ljihKVGNomRyvSPlW9pNFo4xrrS4gFj+gwjOFG1c=;
        b=ZZ5Prajy3IIcM56VZVoGpiZ0R98e4h/MSId7WkNy9xXa5jp6XtgovfPf2lFpS7SyA6
         AmFM8gdHhl2IK2TaUo+wbepSQKl162yASCuW0WpoSFzo8Gy/tbKA2TYzpRgsHKAPtQbw
         n8Kgv94t2h5hTADxi/Bn85oFqt4VIjlqk2lCb7WAm1nVJVK2VGMZsaHqUCIX/Q9nG2ff
         QEM+WwEXPnsu+GGKfThbpvEyZPHirPUea056vSWiHUbK0VVFZhF7UI/sKywRMMqZJrSY
         WOSGtqEQcEdWvivMwnG1VXzgrW43xLkBEx8d793PQR8JJfGDRvFvkZxoLoKJx2XmfTv1
         K9hQ==
X-Gm-Message-State: APf1xPArwBbUIH5ttGcsrmJ6M0TDDmRrpGxUjKrhb+fRFKyQPOYYNOlM
        xrT3bceA7gTrZtvA/xBUd5QBUFEnATg=
X-Google-Smtp-Source: AG47ELtBC/MDSXipU5SoBxvBeEAIkQmmwubhfGLnwweRSvgP6IgdBC3m3KovHGDas9l0eU23HXz21g==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr15339504plb.113.1520302663854;
        Mon, 05 Mar 2018 18:17:43 -0800 (PST)
Received: from localhost ([2601:602:9500:3a4f:8042:ad20:287d:7753])
        by smtp.gmail.com with ESMTPSA id g13sm24417096pfi.134.2018.03.05.18.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Mar 2018 18:17:42 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 4/4] builtin/config: introduce `--color` type specifier
Date:   Mon,  5 Mar 2018 18:17:29 -0800
Message-Id: <20180306021729.45813-5-me@ttaylorr.com>
X-Mailer: git-send-email 2.15.1.354.g95ec6b1b3
In-Reply-To: <20180306021729.45813-1-me@ttaylorr.com>
References: <20180306021729.45813-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of this commit, the cannonical way to retreive an ANSI-compatible
color escape sequence from a configuration file is with the
`--get-color` action.

This is to allow Git to "fall back" on a default value for the color
should the given section not exist in the specified configuration(s).

With the addition of `--default`, this is no longer needed since:

  $ git config --default red --color core.section

will be have exactly as:

  $ git config --get-color core.section red

For consistency, let's introduce `--color` and encourage `--color`,
`--default` together over `--get-color` alone.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt | 10 +++++++---
 builtin/config.c             | 17 +++++++++++++++++
 t/t1300-repo-config.sh       | 16 ++++++++++++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 28d84ded9..0dfb20324 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -42,9 +42,9 @@ The type specifier can be either `--int` or `--bool`, to make 'git config'
 ensure that the variable(s) are of the given type and convert the value to the
 canonical form (simple decimal number for int, a "true" or "false" string for
 bool, either of for --bool-or-int), or `--path`, which does some path expansion
-(see `--path` below), or `--expiry-date` (see `--expiry-date` below).  If no
-type specifier is passed, no checks or transformations are performed on the
-value.
+(see `--path` below), or `--expiry-date` (see `--expiry-date` below), or
+`--color` (see `--color` below).  If no type specifier is passed, no checks or
+transformations are performed on the value.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
@@ -186,6 +186,10 @@ See also <<FILES>>.
 	a fixed or relative date-string to a timestamp. This option
 	has no effect when setting the value.
 
+--color::
+  `git config` will ensure that the output is converted to an
+  ANSI color escape sequence.
+
 -z::
 --null::
 	For all options that output values and/or keys, always
diff --git a/builtin/config.c b/builtin/config.c
index 76edefc07..05f97f2cb 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -54,6 +54,7 @@ static int show_origin;
 #define TYPE_BOOL_OR_INT (1<<2)
 #define TYPE_PATH (1<<3)
 #define TYPE_EXPIRY_DATE (1<<4)
+#define TYPE_COLOR (1<<5)
 
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
@@ -83,6 +84,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
 	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
 	OPT_BIT(0, "expiry-date", &types, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
+	OPT_BIT(0, "color", &types, N_("value is a color"), TYPE_COLOR),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
@@ -168,6 +170,12 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 			if (git_config_expiry_date(&t, key_, value_) < 0)
 				return -1;
 			strbuf_addf(buf, "%"PRItime, t);
+		} else if (types == TYPE_COLOR) {
+			char *v = xmalloc(COLOR_MAXLEN);
+			if (git_config_color(&v, key_, value_) < 0)
+				return -1;
+			strbuf_addstr(buf, v);
+			free((char *) v);
 		} else if (value_) {
 			strbuf_addstr(buf, value_);
 		} else {
@@ -313,6 +321,15 @@ static char *normalize_value(const char *key, const char *value)
 		else
 			return xstrdup(v ? "true" : "false");
 	}
+	if (types == TYPE_COLOR) {
+		char *v = xmalloc(COLOR_MAXLEN);
+		if (!git_config_color(&v, key, value)) {
+			free((char *) v);
+			return xstrdup(value);
+		}
+		free((char *) v);
+		die("cannot parse color '%s'", value);
+	}
 
 	die("BUG: cannot normalize type %d", types);
 }
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 4f8e6f5fd..c03f54fbe 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -931,6 +931,22 @@ test_expect_success 'get --expiry-date' '
 	test_must_fail git config --expiry-date date.invalid1
 '
 
+cat >expect <<EOF
+[foo]
+	color = red
+EOF
+
+test_expect_success 'get --color' '
+	rm .git/config &&
+	git config --color foo.color "red" &&
+	test_cmp expect .git/config
+'
+
+test_expect_success 'get --color barfs on non-color' '
+	echo "[foo]bar=not-a-color" >.git/config &&
+	test_must_fail git config --get --color foo.bar
+'
+
 cat > expect << EOF
 [quote]
 	leading = " test"
-- 
2.15.1.354.g95ec6b1b3

