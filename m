Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CDCC83000
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 01:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C2020757
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 01:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgojUzAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgD3BUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgD3BUW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 21:20:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29EEC035494
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 18:20:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v63so2050230pfb.10
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 18:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FCqpkjF5f52QmYRNFpzfFjmbfDY343beXJvucCJ/bJw=;
        b=QgojUzAZzsSqRS88ZBdmaW8K66DOvICZQwWnwX0XTUxP+vH4ke8fn8lcN1s6f7X6i+
         HuCqoBNU74U4CBkamngsNa4kYmJIRnptPg+QnYLFyHmWPpKhgSRa2PpleNBjhFsYD/7c
         djcvQkMzcoYK4hUIDAuS3WcyNRPYN0WMGn/pm/MUFPTphjiFMPoxroF2cMjJwBEZGx+H
         x1Yw0L/bOXyUiDj4uXTqvZL9ltq752c4rMwbpQieOn8a6Q42r/p0qoGtPD79Nx6jCwOh
         RuCPacWvINkY+fM46NqIRen1ptwN8doUOF07LSidpNYFKsEm75z+nQNGIoZ/23P0eYjo
         IbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FCqpkjF5f52QmYRNFpzfFjmbfDY343beXJvucCJ/bJw=;
        b=MJhzNf0QqpVeujeeCuy1lzSkGnty+YE+ZUuCgAyxU3at3PAubI64zVl9v9WaHcB+Aq
         CKqpcOLz8ZyV63yUKJNoezurvtkrAgxajE6XphdWOS/3WY4I+S8LXnT9bpjHZR9OOtzU
         FtsNM+UGvE3G/p9yqo1XFjZUx4Mn8tpEEq8by2r6tsWJoZgOuoP/jzcHbg/y+0Hix5y0
         99sFSvIt1uWutogrH0O1vyva8JojOeDHiciEXvHsu2PEFMw+/svrhS2zpykBI0JYbwer
         91RGBrl/ITBYKODc0/YIe9Jn90yX9/Xvr4sgRu9O7TgL2Sj58faVHNlEh8ARf4GZlyAC
         XvhA==
X-Gm-Message-State: AGi0PuZM91zexEPQ4fJ+udRtECDOo70tcngFFHz1N0mfUuCGNf+GzSvU
        uDQkB5s1RNjnwOYWMwPih8H0dDvD
X-Google-Smtp-Source: APiQypIboCZ5m2fXQ5SJD4CPnDFe+UWMqJKlbO3kSnlE58FbxHkuFe/MRM2Ca2h68kqQclP0hvgeEA==
X-Received: by 2002:a63:2ad3:: with SMTP id q202mr965106pgq.55.1588209620557;
        Wed, 29 Apr 2020 18:20:20 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id cp22sm369858pjb.28.2020.04.29.18.20.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 18:20:20 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v7] credential-store: warn instead of fatal for bogus lines from store
Date:   Wed, 29 Apr 2020 18:19:59 -0700
Message-Id: <20200430011959.70597-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
In-Reply-To: <20200429232322.68038-1-carenas@gmail.com>
References: <20200429232322.68038-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the added checks for invalid URLs in credentials, any locally
modified store files which might have empty lines or even comments
were reported[1] failing to parse as valid credentials.

Instead of doing a hard check for credentials, do a soft one and
warn the user so any invalid entries could be corrected.

Make sure that the credential to use is complete before calling
credential_match by confirming it has all fields set as expected
by the updated rules.

[1] https://stackoverflow.com/a/61420852/5005936

Reported-by: Dirk <dirk@ed4u.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v7:
* check for protocol in helper as suggested by Junio
v6:
* get rid of redacter and only use line number for context in warning
* make validation more strict to also catch incomplete credentials
* reorder check as suggested by Junio
v5:
* q_to_tab this round, with a single echo to make sure empty line
  is covered, as that seems to be a popular issue
* rebase on top of jc/credential-store-file-format-doc
* implement a redacter for credentials to use on errors to avoid
  leaking passwords
v4:
* use credential_from_url_gently instead as shown by Jonathan
* add documentation to clarify "comments" is not a supported feature
v3:
* avoid using q_to_cr as suggested by Peff
* a more verbose commit message and slightly more complete documentation
v2:
* use a here-doc for clarity as suggested by Eric
* improve commit message and include documentation

 Documentation/git-credential-store.txt | 11 +++-
 credential-store.c                     | 22 +++++--
 t/t0302-credential-store.sh            | 80 ++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 76b0798856..122e238eb2 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -95,8 +95,15 @@ https://user:pass@example.com
 ------------------------------
 
 No other kinds of lines (e.g. empty lines or comment lines) are
-allowed in the file, even though some may be silently ignored. Do
-not view or edit the file with editors.
+allowed in the file, even though historically the parser was very
+lenient and some might had been silently ignored.
+
+Do not view or edit the file with editors as it could compromise the
+validity of your credentials by sometimes subtle formatting issues,
+like spaces, line wrapping or text encoding.
+
+An unparseable or otherwise invalid line is ignored, and a warning
+message points out the problematic line number and file it appears in.
 
 When Git needs authentication for a particular URL context,
 credential-store will consider that context a pattern to match against
diff --git a/credential-store.c b/credential-store.c
index c010497cb2..2c5f9736fc 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -6,6 +6,13 @@
 
 static struct lock_file credential_lock;
 
+static int valid_credential(struct credential *entry)
+{
+	return (entry->username && entry->password &&
+		entry->protocol && *entry->protocol &&
+		((entry->host && *entry->host) || entry->path));
+}
+
 static int parse_credential_file(const char *fn,
 				  struct credential *c,
 				  void (*match_cb)(struct credential *),
@@ -15,6 +22,7 @@ static int parse_credential_file(const char *fn,
 	struct strbuf line = STRBUF_INIT;
 	struct credential entry = CREDENTIAL_INIT;
 	int found_credential = 0;
+	int lineno = 0;
 
 	fh = fopen(fn, "r");
 	if (!fh) {
@@ -24,16 +32,22 @@ static int parse_credential_file(const char *fn,
 	}
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
-		credential_from_url(&entry, line.buf);
-		if (entry.username && entry.password &&
-		    credential_match(c, &entry)) {
+		lineno++;
+
+		if (credential_from_url_gently(&entry, line.buf, 1) ||
+			!valid_credential(&entry)) {
+			warning(_("%s:%d: ignoring invalid credential"),
+				fn, lineno);
+		} else if (credential_match(c, &entry)) {
 			found_credential = 1;
 			if (match_cb) {
 				match_cb(&entry);
 				break;
 			}
+			continue;
 		}
-		else if (other_cb)
+
+		if (other_cb)
 			other_cb(&line);
 	}
 
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index d6b54e8c65..3150f304cb 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -120,4 +120,84 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
+test_expect_success 'get: credentials without scheme are invalid' '
+	echo "://user:pass@example.com" >"$HOME/.git-credentials" &&
+	cat >expect-stdout <<-\STDOUT &&
+	protocol=https
+	host=example.com
+	username=askpass-username
+	password=askpass-password
+	STDOUT
+	test_config credential.helper store &&
+	git credential fill <<-\EOF >stdout 2>stderr &&
+	protocol=https
+	host=example.com
+	EOF
+	test_cmp expect-stdout stdout &&
+	grep "askpass: Username for '\''https://example.com'\'':" stderr &&
+	grep "askpass: Password for '\''https://askpass-username@example.com'\'':" stderr &&
+	test_i18ngrep "ignoring invalid credential" stderr
+'
+
+test_expect_success 'get: credentials without valid host/path are invalid' '
+	echo "https://user:pass@" >"$HOME/.git-credentials" &&
+	cat >expect-stdout <<-\STDOUT &&
+	protocol=https
+	host=example.com
+	username=askpass-username
+	password=askpass-password
+	STDOUT
+	test_config credential.helper store &&
+	git credential fill <<-\EOF >stdout 2>stderr &&
+	protocol=https
+	host=example.com
+	EOF
+	test_cmp expect-stdout stdout &&
+	grep "askpass: Username for '\''https://example.com'\'':" stderr &&
+	grep "askpass: Password for '\''https://askpass-username@example.com'\'':" stderr &&
+	test_i18ngrep "ignoring invalid credential" stderr
+'
+
+test_expect_success 'get: credentials without username/password are invalid' '
+	echo "https://pass@example.com" >"$HOME/.git-credentials" &&
+	cat >expect-stdout <<-\STDOUT &&
+	protocol=https
+	host=example.com
+	username=askpass-username
+	password=askpass-password
+	STDOUT
+	test_config credential.helper store &&
+	git credential fill <<-\EOF >stdout 2>stderr &&
+	protocol=https
+	host=example.com
+	EOF
+	test_cmp expect-stdout stdout &&
+	grep "askpass: Username for '\''https://example.com'\'':" stderr &&
+	grep "askpass: Password for '\''https://askpass-username@example.com'\'':" stderr &&
+	test_i18ngrep "ignoring invalid credential" stderr
+'
+
+test_expect_success 'get: store file can contain empty/bogus lines' '
+	echo "" > "$HOME/.git-credentials" &&
+	q_to_tab <<-\CONFIG >>"$HOME/.git-credentials" &&
+	#comment
+	Q
+	https://user:pass@example.com
+	CONFIG
+	cat >expect-stdout <<-\STDOUT &&
+	protocol=https
+	host=example.com
+	username=user
+	password=pass
+	STDOUT
+	test_config credential.helper store &&
+	git credential fill <<-\EOF >stdout 2>stderr &&
+	protocol=https
+	host=example.com
+	EOF
+	test_cmp expect-stdout stdout &&
+	test_i18ngrep "ignoring invalid credential" stderr &&
+	test_line_count = 3 stderr
+'
+
 test_done

base-commit: 272281efcc18fcedd248597b8859f343cae1c5a0
-- 
2.26.2.569.g1d74ac4d14

