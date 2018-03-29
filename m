Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C6311F404
	for <e@80x24.org>; Thu, 29 Mar 2018 01:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeC2BQr (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 21:16:47 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46801 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeC2BQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 21:16:45 -0400
Received: by mail-pf0-f194.google.com with SMTP id h69so2070614pfe.13
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 18:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1K0aqSF/Y5ee5nPJLsTX1zueRern6WiZijcDkFIJBsA=;
        b=RKgydnR3JPLeSsSq1cgIGCcBJPl5S7fe6zNYYL3dhh3hOYuLOdqimcAcKaI/dGPwGk
         N1tk+6//2HeXqeTvaoasKSCkYL8QaEKZA8T7wDfqD9CTyhM5YDV+5oXkJdSnFLfZP05y
         rHQYtiWJr8V00Y1YtPt4DQqRkvPy96wPWlyG1KWjDy9KfHjaApUNgXwJFCBLsAC1f99v
         zyT05ToOvZvnBtp07M0jHVh1tLxMlQX904PMcMoKM+Vw/WSx1hJktl1DF/oY/X8M8dRd
         FGkt8mQ3qC27QkFyAxurIbFdTsfKcSxjrwI7C2fTUoQGREqdYhTNWpiI7WmQ9d8rnEzS
         eSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1K0aqSF/Y5ee5nPJLsTX1zueRern6WiZijcDkFIJBsA=;
        b=MMg7Pq+DqNTBhBbyrX+8VY3zqPq4UDJORiQvi+FkfO5aAZZJuae1Akcf7UF8y232SY
         VPG/t1ABjWKTSVX0LDK4RLc2qXCH8L8A/QEJCocdJj7QMZgZn7zcRlB/+X79ilGshYIZ
         59Wwf2UMcM05kF+Y0OjYKP261ahh70JBfJ+Kk4PFUYxrbGZ/KAO0NLsqUtpAl7KIpaCA
         LYqY29Rp6ZLk+TVQkqcv57J+oab0ExZhHCDi/p21lb+fH5mDZKbGe0YvZUUSzulVMX8Q
         GNR81keUrIXhlUCPBFymXTaQUY2fzES6cadkXHTZoPH3YjlFEKO4KypOqP4/AgChVt2F
         95Pw==
X-Gm-Message-State: AElRT7FAlWUK1U9tjZbCriyGFoLbQca5JnlWC/YFTXaRclDAOR/IKzvT
        hWp0yCczR8xWiuJ3VU8lQmNmVRzhScE=
X-Google-Smtp-Source: AIpwx48uKEeOEGhj0W+n+8MCnNlcLZ19ofqDsQGRWSwVYEHHDwn4xyDcxpgvaxBwNI60ctMd+ZNTMw==
X-Received: by 10.99.115.68 with SMTP id d4mr4097274pgn.145.1522286203587;
        Wed, 28 Mar 2018 18:16:43 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec10:419d:d341:c920])
        by smtp.gmail.com with ESMTPSA id z84sm11067768pff.135.2018.03.28.18.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 18:16:42 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     peff@peff.net, gitster@pobox.com
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 3/3] builtin/config: introduce `color` type specifier
Date:   Wed, 28 Mar 2018 18:16:34 -0700
Message-Id: <20180329011634.68582-4-me@ttaylorr.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da4f
In-Reply-To: <20180329011634.68582-1-me@ttaylorr.com>
References: <20180324005556.8145-1-me@ttaylorr.com>
 <20180329011634.68582-1-me@ttaylorr.com>
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

  $ git config --default red --type=color core.section

will be have exactly as:

  $ git config --get-color core.section red

For consistency, let's introduce `--color` and encourage `--type=color`,
`--default` together over `--get-color` alone.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt | 11 +++++++----
 builtin/config.c             | 21 +++++++++++++++++++++
 t/t1300-repo-config.sh       | 30 ++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 5aa528878..aaba36615 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -38,10 +38,8 @@ existing values that match the regexp are updated or unset.  If
 you want to handle the lines that do *not* match the regex, just
 prepend a single exclamation mark in front (see also <<EXAMPLES>>).
 
-A type specifier may be given as an argument to `--type` to make 'git config'
-ensure that the variable(s) are of the given type and convert the value to the
-canonical form. If no type specifier is passed, no checks or transformations are
-performed on the value.
+`color`::
+    The value is taken as an ANSI color escape sequence.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
@@ -177,6 +175,7 @@ Valid `[type]`'s include:
   ~/` from the command line to let your shell do the expansion.)
 - 'expiry-date': canonicalize by converting from a fixed or relative ate-string
   to a timestamp. This specifier has no effect when setting the value.
+- 'color': canonicalize by converting to an ANSI color escape sequence.
 +
 
 --bool::
@@ -184,6 +183,7 @@ Valid `[type]`'s include:
 --bool-or-int::
 --path::
 --expiry-date::
+--color::
   Historical options for selecting a type specifier. Prefer instead `--type`,
   (see: above).
 
@@ -223,6 +223,9 @@ Valid `[type]`'s include:
 	output it as the ANSI color escape sequence to the standard
 	output.  The optional `default` parameter is used instead, if
 	there is no color configured for `name`.
++
+It is preferred to use `--type=color`, or `--type=color --default=[default]`
+instead of `--get-color`.
 
 -e::
 --edit::
diff --git a/builtin/config.c b/builtin/config.c
index 4340f5f3d..1aae228a6 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -62,6 +62,7 @@ static int show_origin;
 #define TYPE_BOOL_OR_INT (1<<2)
 #define TYPE_PATH (1<<3)
 #define TYPE_EXPIRY_DATE (1<<4)
+#define TYPE_COLOR (1<<5)
 
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
@@ -177,6 +178,11 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
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
@@ -322,6 +328,19 @@ static char *normalize_value(const char *key, const char *value)
 		else
 			return xstrdup(v ? "true" : "false");
 	}
+	if (types == TYPE_COLOR) {
+		char v[COLOR_MAXLEN];
+		if (!git_config_color(v, key, value))
+			/*
+			 * The contents of `v` now contain an ANSI escape
+			 * sequence, not suitable for including within a
+			 * configuration file. Treat the above as a
+			 * "sanity-check", and return the given value, which we
+			 * know is representable as valid color code.
+			 */
+			return xstrdup(value);
+		die("cannot parse color '%s'", value);
+	}
 
 	die("BUG: cannot normalize type %d", types);
 }
@@ -519,6 +538,8 @@ static int type_name_to_specifier(char *name)
 		return TYPE_PATH;
 	else if (!(strcmp(name, "expiry-date")))
 		return TYPE_EXPIRY_DATE;
+	else if (!(strcmp(name, "color")))
+		return TYPE_COLOR;
 	die(_("unexpected --type argument, %s"), name);
 }
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 12dc94bd2..12e852a1d 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -931,6 +931,36 @@ test_expect_success 'get --expiry-date' '
 	test_must_fail git config --expiry-date date.invalid1
 '
 
+test_expect_success 'get --type=color' '
+	rm .git/config &&
+	git config foo.color "red" &&
+	git config --get --type=color foo.color >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	echo "<RED>" >expect &&
+	test_cmp expect actual
+'
+
+cat >expect << EOF
+[foo]
+	color = red
+EOF
+
+test_expect_success 'set --type=color' '
+	rm .git/config &&
+	git config --type=color foo.color "red" &&
+	test_cmp expect .git/config
+'
+
+test_expect_success 'get --type=color barfs on non-color' '
+	echo "[foo]bar=not-a-color" >.git/config &&
+	test_must_fail git config --get --type=color foo.bar
+'
+
+test_expect_success 'set --type=color barfs on non-color' '
+	test_must_fail git config --type=color foo.color "not-a-color" 2>error &&
+	test_i18ngrep "cannot parse color" error
+'
+
 cat > expect << EOF
 [quote]
 	leading = " test"
-- 
2.16.2.440.gc6284da4f

