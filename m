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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBAAC8300A
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 09:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC5F20838
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 09:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzIHz/2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgD3Jao (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726391AbgD3Jao (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 05:30:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFF1C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 02:30:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l20so2480964pgb.11
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 02:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfCj1WI5+CGCGCz8CqPfZ6x3HlgVZeXZLNh7gp2OH8w=;
        b=NzIHz/2vSdhv4oebRpqslkT79tptLs/ciJZQhXE/u7q2mF4rxCFj81t8Af+xDtpv33
         Yf+nT8A2Zinypumg57LljNNOtfIN+31a086FyqoftGQgVHgvYch4wdHzfSllAT9s9BW/
         UI6oKij+oMKPkb/vZDiRfzg+Zu19DqbEaFu866r4S9e9wSwrNRrgjQTnfWf5GePoM/4g
         3+XSCnBUqagtObfFNxXlwa4CNcCP9KS007q/S79AaGoz1515MjyHD+WCGMSlYLA1aAnu
         UbUpeJra7GRGhSSjp8obORrD+/k3u12hdiYTWI+MRdEa9SVTyI3hAvCZEMHTj5UQs67Y
         /ckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfCj1WI5+CGCGCz8CqPfZ6x3HlgVZeXZLNh7gp2OH8w=;
        b=EQb8rAM6u3fTVvx+wNgdeRYZ4I478A+TvVPtpIR687wvKY/bNa8v+7K1p7ugRsV9Pr
         Sp4vCNAsi3/yZMWp9f9iMJAXcYMMKNIDytY5PPWiUo3pllW2x4HqwufUUUh5rwX1aLnz
         RcZeaTw5mvA1ubQBkaxZK3DJ5fwp65V01p9dir7fuIzG0CSOqr2Q202zUO7ioDzXOZHB
         KQjYJxICHq7AJxNr1OQ5zqAnN7sKpZw/j7CT246niKmZna8kPAANTK3RqpcuK5yEGSje
         6yNj5FnRsfrP+4LQaSWilojukg9ITDX0XVV6zzH0tCAbsD26kIB3sMf/SxSobOaCxO7p
         5ubQ==
X-Gm-Message-State: AGi0PuZDup3mIEsmy5sGQ6ls3x0fIkX1FpTxTJEWkt9wKhocJs+HRM2I
        2exoly/+9StCFc/3qhoiUTK8Ooxj
X-Google-Smtp-Source: APiQypL6JvsrK7q2nALfvvMTn8xDsnxqonU3BnecTZn9p/GgKFmqFf72ujw4fKSdkaZPI10pp9cc/Q==
X-Received: by 2002:a62:17c3:: with SMTP id 186mr2640823pfx.159.1588239043407;
        Thu, 30 Apr 2020 02:30:43 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id o40sm1291163pjb.18.2020.04.30.02.30.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 02:30:42 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v8] credential-store: warn instead of fatal for bogus lines from store
Date:   Thu, 30 Apr 2020 02:29:39 -0700
Message-Id: <20200430092939.3564-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.2.g9c647e0d3b.dirty
In-Reply-To: <20200430011959.70597-1-carenas@gmail.com>
References: <20200430011959.70597-1-carenas@gmail.com>
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
therefore avoid the reported fatal error.

Warn the user indicating the filename and line number so any invalid
entries could be corrected but continue parsing until a match is
found or all valid credentials are processed.

Make sure that the credential that we will use to match is complete by
confirming it has all fields set as expected by the updated rules.

[1] https://stackoverflow.com/a/61420852/5005936

Reported-by: Dirk <dirk@ed4u.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v8:
* only warn during get operations as otherwise line number might be
  incorrect
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
 credential-store.c                     | 31 +++++++--
 t/t0302-credential-store.sh            | 89 ++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 76b0798856..d5841cffad 100644
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
+message points out the problematic file and line number it appears in.
 
 When Git needs authentication for a particular URL context,
 credential-store will consider that context a pattern to match against
diff --git a/credential-store.c b/credential-store.c
index c010497cb2..9bd8ec9b67 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -4,10 +4,20 @@
 #include "string-list.h"
 #include "parse-options.h"
 
+#define PARSE_VERBOSE 0x01
+
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
+				  int flags,
 				  void (*match_cb)(struct credential *),
 				  void (*other_cb)(struct strbuf *))
 {
@@ -15,6 +25,7 @@ static int parse_credential_file(const char *fn,
 	struct strbuf line = STRBUF_INIT;
 	struct credential entry = CREDENTIAL_INIT;
 	int found_credential = 0;
+	int lineno = 0;
 
 	fh = fopen(fn, "r");
 	if (!fh) {
@@ -24,16 +35,23 @@ static int parse_credential_file(const char *fn,
 	}
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
-		credential_from_url(&entry, line.buf);
-		if (entry.username && entry.password &&
-		    credential_match(c, &entry)) {
+		lineno++;
+
+		if (credential_from_url_gently(&entry, line.buf, 1) ||
+			!valid_credential(&entry)) {
+			if (flags & PARSE_VERBOSE)
+				warning(_("%s:%d: ignoring invalid credential"),
+					fn, lineno);
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
 
@@ -62,7 +80,7 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 		die_errno("unable to get credential storage lock");
 	if (extra)
 		print_line(extra);
-	parse_credential_file(fn, c, NULL, print_line);
+	parse_credential_file(fn, c, 0, NULL, print_line);
 	if (commit_lock_file(&credential_lock) < 0)
 		die_errno("unable to write credential store");
 }
@@ -139,7 +157,8 @@ static void lookup_credential(const struct string_list *fns, struct credential *
 	struct string_list_item *fn;
 
 	for_each_string_list_item(fn, fns)
-		if (parse_credential_file(fn->string, c, print_entry, NULL))
+		if (parse_credential_file(fn->string, c, PARSE_VERBOSE,
+						 print_entry, NULL))
 			return; /* Found credential */
 }
 
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index d6b54e8c65..8bc89b7efb 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -120,4 +120,93 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
+test_expect_success 'store: store succeeds silently in corrupted file' '
+	echo "#comment" >"$HOME/.git-credentials" &&
+	check approve store <<-\EOF &&
+	url=https://user:pass@example.com
+	EOF
+	grep "https://user:pass@example.com" "$HOME/.git-credentials" &&
+	test_must_be_empty stderr
+'
+
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
2.26.2.2.g9c647e0d3b.dirty

