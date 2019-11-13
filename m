Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341DF1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 18:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfKMSzs (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 13:55:48 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44943 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfKMSzs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 13:55:48 -0500
Received: by mail-lf1-f67.google.com with SMTP id z188so2806089lfa.11
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 10:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zDaJ3ejsEjFrg3NLsT1DueVCsQNNykvNu+wDyBOlz0E=;
        b=gosZNqXZG2v79nKaujUKrU9v2avOirUoD5IrUKGY4ErSnm8+ZBp+b/F2BD9jjSWh/Q
         oOwljm4yzQilhYIIT0bsUj2GoGd0MZuUgz3VWZ0cDyAfadjspBMa5YNM5NW2RhqF2/HF
         kxM7RrQO1jUa5sG3V2UZXpih3pSK8svzo67dpbDL7Oy9QAF0haLP4FJf/bIamKkmnK/B
         y/HaAHwzFdWxtZA0fI9XLGZAE9UJEUYdUD6XOuHG8hzbsBFxnW2yaxCY13zCPhoETxUh
         jJvuR2bG8sc0aeVlyg/glg2/fb+kdK1LPH26KebRX3beZYK2in9UXXcWsvhr4OwqNQmw
         jAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zDaJ3ejsEjFrg3NLsT1DueVCsQNNykvNu+wDyBOlz0E=;
        b=KVDpKUqN/NR3Nkdh1eLiKvLozFXyMwU1gsRElUEiUaeuOoJWxIzXZYPG2XON0hChSC
         a8sAvYWrJhxw9nf/oaEAyNJ5SFjJKcJ/yVJ/wmEGbByL7wc3SKy8VxrMW7jL8LM9jlph
         /fafZe0HOcSEqqgCTCZsCnCZWRKBAGB6T6zOSP2f6l22YLcGD0T8y0Qfil4JbT8AJDaL
         h0OMyO48OAHnEL6ZvAN8CIQZNRAA3wzWgAUkXgkgoBmKSgBhOUCuJbuIOLKLtprLCqss
         VehMH3cofzoMPzQb1a7wRFV39b8sFq9nqhWWFk1mtPWojomVDnYGhN+tDlxkCDY0OmC7
         Ufww==
X-Gm-Message-State: APjAAAVHmn2LRKONGEYHjfvBONUhIU2FDp/FpH9c4u3SGq11ujLwfYkU
        /RQqAO41BPnAPxvNO0EgXrJkcS77
X-Google-Smtp-Source: APXvYqztMmkyrEgU+WWU2EULiCNa0IWkV8F6v5uyPrVHCMxB6up6TBLxF1tyZz8E/6B/BcHgHlQL/A==
X-Received: by 2002:a19:8ac5:: with SMTP id m188mr3912436lfd.186.1573671344832;
        Wed, 13 Nov 2019 10:55:44 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c24sm1422765lfm.20.2019.11.13.10.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:55:44 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/8] builtin/config: canonicalize "value_regex" with `--type=bool`
Date:   Wed, 13 Nov 2019 19:55:04 +0100
Message-Id: <beb0cfbb78e3ae69e64ff2ed57c8e628ccb187ce.1573670565.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1573670565.git.martin.agren@gmail.com>
References: <cover.1573670565.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With `--type=bool`, we use the "value_regex" as a normal regex and do
not use our knowledge about the different well-defined ways we have of
spelling the boolean values. Let's consider a few examples.

These output "true":
	git -c foo.bar=true config --type=bool --get foo.bar true
	git -c foo.bar=true config --type=bool --get foo.bar t

These produce no output:
	git -c foo.bar=true config --type=bool --get foo.bar True
	git -c foo.bar=true config --type=bool --get foo.bar 1

Canonicalize the provided "value_regex", then canonicalize candidate
values as we go through the config and compare the canonicalized values.
If the parameter doesn't canonicalize, fall back to handling it as a
regex, as before. This would happen in the second example above, but
also if someone has hand-rolled their own canonicalisation with, e.g.,
something like "^(on|On|ON|true|1|42)$".

This commit affects all modes that take a "value_regex", e.g.,
`--get-regexp` which can be used in a more useful way than the examples
above might at first suggest:

	git config --type=bool --name-only --get-regexp '^foo\.' true

This commit does change the behavior for certain usages, but it almost
certainly does so for the better: We don't exclude config items based on
how the config happens to spell "true" or "false". This commit would
cause a regression if someone uses different synonyms for "true",
knowing that Git handles them all the same in day-to-day operation, but
relying on the encoding (using, say, integers 1-100) to signal some sort
of confidence and using `git config` to query for various such "levels".
I'm tempted to bet no-one will be hurt by this change.

Do not rename the "value_regex" in the documentation. This commit can be
seen as teaching `git config --type=bool` about a particular type of
regex, where "true" matches "yes", but not "no". So arguably,
"value_regex" still describes quite well what is going on.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-config.txt |  4 ++++
 builtin/config.c             | 15 +++++++++++-
 t/t1300-config.sh            | 45 ++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 899e92a1c9..139750bbda 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -43,6 +43,10 @@ outgoing values are canonicalize-able under the given <type>.  If no
 `--type=<type>` is given, no canonicalization will be performed. Callers may
 unset an existing `--type` specifier with `--no-type`.
 
+With `--type=bool`, if `value_regex` is given
+and canonicalizes to a boolean value, it matches all entries
+that canonicalize to the same boolean value.
+
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
 `--system`, `--global`, `--local`, `--worktree` and
diff --git a/builtin/config.c b/builtin/config.c
index d812e73e2b..c9fe0c5752 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -15,9 +15,10 @@ static const char *const builtin_config_usage[] = {
 static char *key;
 static regex_t *key_regexp;
 static struct {
-	enum { none, regexp } mode;
+	enum { none, regexp, boolean } mode;
 	regex_t *regexp;
 	int do_not_match; /* used with `regexp` */
+	int boolean;
 } cmd_line_value;
 static int show_keys;
 static int omit_values;
@@ -278,6 +279,9 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 	     !!regexec(cmd_line_value.regexp, value_ ? value_ : "",
 		       0, NULL, 0)))
 		return 0;
+	if (cmd_line_value.mode == boolean &&
+	    git_parse_maybe_bool(value_) != cmd_line_value.boolean)
+		return 0;
 
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
 	strbuf_init(&values->items[values->nr], 0);
@@ -292,6 +296,15 @@ static int handle_value_regex(const char *regex_)
 		return 0;
 	}
 
+	if (type == TYPE_BOOL) {
+		int boolval = git_parse_maybe_bool(regex_);
+		if (boolval >= 0) {
+			cmd_line_value.mode = boolean;
+			cmd_line_value.boolean = boolval;
+			return 0;
+		}
+	}
+
 	cmd_line_value.mode = regexp;
 
 	if (regex_[0] == '!') {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index a38cc143a1..e4906a893e 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -427,6 +427,51 @@ test_expect_success 'no arguments, but no crash' '
 	test_i18ngrep usage output
 '
 
+test_expect_success 'setup config file with several boolean values' '
+	cat >.git/config <<-\EOF
+	[foo]
+		n1 = no
+		n2 = NO
+		n3 = off
+		n4 = false
+		n5 = 0
+		n6 =
+		y1 = yes
+		y2 = YES
+		y3 = on
+		y4 = true
+		y5 = 1
+		y6 = 42
+		y7
+	EOF
+'
+
+test_expect_success '--get-regexp canonicalizes value_regex with --type=bool (false)' '
+	git config --type=bool --get-regexp "foo\..*" OFF >output &&
+	test_line_count = 6 output &&
+	! grep -v "^foo.n" output
+'
+
+test_expect_success '--get-regexp canonicalizes value_regex with --type=bool (true)' '
+	git config --type=bool --get-regexp "foo\..*" ON >output &&
+	test_line_count = 7 output &&
+	! grep -v "^foo.y" output
+'
+
+test_expect_success '--get canonicalizes integer value_regex with --type=bool' '
+	echo true >expect &&
+	git config --type=bool --get foo.y2 1 >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--type=bool with "non-bool" value_regex' '
+	echo true >expect &&
+	git config --type=bool --get foo.y4 "t.*" >output &&
+	test_cmp expect output &&
+	test_must_fail git config --type=bool --get foo.y4 "T.*" >output &&
+	test_must_be_empty output
+'
+
 test_expect_success 'setup simple config file' '
 	q_to_tab >.git/config <<-\EOF
 	[a.b]
-- 
2.24.0

