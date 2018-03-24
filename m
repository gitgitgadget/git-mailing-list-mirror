Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182471F404
	for <e@80x24.org>; Sat, 24 Mar 2018 00:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeCXA4K (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 20:56:10 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41316 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbeCXA4H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 20:56:07 -0400
Received: by mail-qk0-f196.google.com with SMTP id s78so14791237qkl.8
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 17:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HvcDQi7OgV+Go4yNmUBIipPHjvWOMotFQiVfW+77HC8=;
        b=DnJpB4AHwpYUkorWOH0pWVnmL2/pByyntUd7qgtbaFo9XAbB4I/BYI3lMg0F62JANJ
         OkaT8ZaQLqteNbwgJ/4d21+DuFXVtpd/1XIfrKlAsYM5aTMuvhKshO1a7uy5brV/iaUN
         B/28fIUfGCOXZgijIoyYRjPcLKENs/i1YrK6PkgKRwg62yiX0IEd7NYZ2nfTiPDQE8Dp
         de+tbuQ7A0NIcQQ8oZkEXnX1Ghd4+hVVn9Qt7qtZa1z/IHgc30X9spHPud3rbnET4APq
         Q1HJlE6FjgduIDPZPWW/+7ZZhWndWYtpO9wMEtZuMa2f5hHjPrvbJrze5sNmBY5GbWHJ
         357w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HvcDQi7OgV+Go4yNmUBIipPHjvWOMotFQiVfW+77HC8=;
        b=Ksb48dMvvsMsqxJhKya6j3RoC0Ff1MKsx9XbarbE+IbD9gbmBsKxwI4OLaHoRZEdms
         Ge6LNsMLn+pQ4qJ5qFtr6/c4o64SYmu934soLpHVeNwNw8OgC7Gy/MFuUm/J4RxFHcAS
         pXblHb6jLlsDilup9/Xai06vw7RrxdcdP/8beyfnIrN1h0naEdDleaxNu80HNJOlFb+A
         xaL6gPnOwEw/X4qrtC5GMFTGhSgj8gvj6PNlHg9sR5e5rcQn/GwFhdmGodO35otf5QPW
         EXWkX6ekLyfRLpYdtDsnVikIKNKr9DKbe9u8Vq2CkZBBaQXI/AK2dL0P1ylvlTgMWLLo
         j+/w==
X-Gm-Message-State: AElRT7HjT90/MiVGV2HM0CEiFZ3ydsyU7j4wWBjt1O73NvU5w6jgjEcT
        WbruJ1z6aIRctew/LKGMjP524A==
X-Google-Smtp-Source: AG47ELtrreMbP2UaIEP9IJA44URcFXm4KwLYoz6sRzvbRro1YmUhG8p0Wqb1UViiYaDUexSnJcK75Q==
X-Received: by 10.55.149.135 with SMTP id x129mr44781678qkd.279.1521852966591;
        Fri, 23 Mar 2018 17:56:06 -0700 (PDT)
Received: from localhost (u-of-rochester-128-151-150-17.wireless.rochester.edu. [128.151.150.17])
        by smtp.gmail.com with ESMTPSA id d1sm2598896qtk.47.2018.03.23.17.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 17:56:05 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com
Subject: [PATCH v2 4/4] builtin/config: introduce `--color` type specifier
Date:   Fri, 23 Mar 2018 20:55:56 -0400
Message-Id: <20180324005556.8145-5-me@ttaylorr.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da4f
In-Reply-To: <20180324005556.8145-1-me@ttaylorr.com>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180324005556.8145-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of this commit, the canonical way to retreive an ANSI-compatible
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
 Documentation/git-config.txt |  7 +++++++
 builtin/config.c             | 13 +++++++++++++
 t/t1300-repo-config.sh       | 24 ++++++++++++++++++++++++
 t/t1310-config-default.sh    |  6 ++++++
 4 files changed, 50 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index d9d45aca3..e70c0a855 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -56,6 +56,9 @@ conversion to canonical form.  Currently supported type specifiers are:
 `expiry-date`::
     The value is taken as a timestamp.
 
+`color`::
+    The value is taken as an ANSI color escape sequence.
+
 For more information about the above type specifiers, see <<OPTIONS>> below.
 
 When reading, the values are read from the system, global and
@@ -198,6 +201,10 @@ See also <<FILES>>.
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
index 1410be850..e8661bc12 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -61,6 +61,7 @@ static int show_origin;
 #define TYPE_BOOL_OR_INT (1<<2)
 #define TYPE_PATH (1<<3)
 #define TYPE_EXPIRY_DATE (1<<4)
+#define TYPE_COLOR (1<<5)
 
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
@@ -90,6 +91,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
 	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
 	OPT_BIT(0, "expiry-date", &types, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
+	OPT_BIT(0, "color", &types, N_("value is a color"), TYPE_COLOR),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
@@ -175,6 +177,11 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 			if (git_config_expiry_date(&t, key_, value_) < 0)
 				return -1;
 			strbuf_addf(buf, "%"PRItime, t);
+		} else if (types == TYPE_COLOR) {
+			char v[COLOR_MAXLEN];
+			if (git_config_color(v, key_, value_) < 0)
+				return -1;
+			strbuf_addstr(buf, v);
 		} else if (value_) {
 			strbuf_addstr(buf, value_);
 		} else {
@@ -320,6 +327,12 @@ static char *normalize_value(const char *key, const char *value)
 		else
 			return xstrdup(v ? "true" : "false");
 	}
+	if (types == TYPE_COLOR) {
+		char v[COLOR_MAXLEN];
+		if (!git_config_color(v, key, value))
+			return xstrdup(value);
+		die("cannot parse color '%s'", value);
+	}
 
 	die("BUG: cannot normalize type %d", types);
 }
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 4f8e6f5fd..dab94d0c4 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -931,6 +931,30 @@ test_expect_success 'get --expiry-date' '
 	test_must_fail git config --expiry-date date.invalid1
 '
 
+test_expect_success 'get --color' '
+	rm .git/config &&
+	git config foo.color "red" &&
+	git config --get --color foo.color | test_decode_color >actual &&
+	echo "<RED>" >expect &&
+	test_cmp expect actual
+'
+
+cat >expect << EOF
+[foo]
+	color = red
+EOF
+
+test_expect_success 'set --color' '
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
diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
index 0e464c206..0ebece7d2 100755
--- a/t/t1310-config-default.sh
+++ b/t/t1310-config-default.sh
@@ -62,6 +62,12 @@ test_expect_success 'marshal default value as expiry-date' '
 	test_cmp expect actual
 '
 
+test_expect_success 'marshal default value as color' '
+	echo "\033[31m" >expect &&
+	git config --default red --color core.foo >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'does not allow --default with --get-all' '
 	test_must_fail git config --default quux --get-all a >output 2>&1 &&
 	test_i18ngrep "\-\-default is only applicable to" output
-- 
2.16.2.440.gc6284da4f

