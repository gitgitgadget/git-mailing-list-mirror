Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4EFC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 22:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6223F20787
	for <git@archiver.kernel.org>; Sat,  2 May 2020 22:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDafwym7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgEBWfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 18:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728550AbgEBWfJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 18:35:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39225C061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 15:35:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f15so5188926plr.3
        for <git@vger.kernel.org>; Sat, 02 May 2020 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1hPjtrsI1ZyHlRhjui5gTu0hqJe2H4rlFrqJQtqj5k=;
        b=XDafwym7E1HWabR0/022qZK3+xkI3n4ZlsDVbePZ4H898VawBgFFj7pgdbPn8mZMwa
         A3fZHj/TGicBPw484aISLJiIhq4ktA2T1imkUtJ0cKnUMVh2nC8w+IGSSlGm+cQE+1Oe
         0tKdiBVu8N2h5L7nz13Rl12v6q2JKlS6euL6etLa/LytIGShhfYZz9FX1ibcuyI6Luwq
         Mt4Hpto7rR8L6ZLfDyPMD7D59ThWqPtY/x37nPgpcpiKoGs59xBp4JTVpv6CqjKK2usv
         LP7vYtQssv1i8JNZm3mg4QtyptkKPxLmznuDGw7mHxXD5AVyr9id/CGRL9QLTxg+dWSc
         XnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1hPjtrsI1ZyHlRhjui5gTu0hqJe2H4rlFrqJQtqj5k=;
        b=H/RQyOQ3rvBRFpkVET4ORLsQLiFs9nkjoxYQKqFntCfZ8T8I1uoS3rkLcOShNfa/k5
         u9krddMN+SNQzn9737ORGjI4Ihv5K6lylWXwZ5m4bTnDeGjx3lcTmrAYocCaBx9LxqHz
         KKuVZ0xIeiR/RyghpIzMcPhYKyh9GCki8TNrKGTRXDZF34hA/XiiiYcT2U/ZZsXe/7ZU
         8yJ1UgIM5eitKgcLAVAx05/Q6ExILkLXmC5HZ2d7b/VK/MfQMCppLYXoDaqfPp2h8tg4
         cNatorr/TxNl0AK8uZV/CmQDGVwZv2+PWjkcS5LFGh+TqJ2ybt/Uq5b+YYQr421HB+SP
         q8hA==
X-Gm-Message-State: AGi0PuaQMZtNV7osNsF00Tso5mkg5nvx/wRO2/uDdY5y35AAMjLUCTsH
        tRb2UWA81QnhuNFluchmXXs7F+pF
X-Google-Smtp-Source: APiQypJen3Qk20gB8pVW1L5e2VXqTioKSzoehUd8lKOuFDoKtXEGnyWJPvTi3G48pMPJmxRHkwKIzA==
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr11070706plo.134.1588458907914;
        Sat, 02 May 2020 15:35:07 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id g43sm2850522pje.22.2020.05.02.15.35.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2020 15:35:07 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Dirk <dirk@ed4u.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v11] credential-store: ignore bogus lines from store file
Date:   Sat,  2 May 2020 15:34:47 -0700
Message-Id: <20200502223447.61478-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
In-Reply-To: <20200502181643.38203-1-carenas@gmail.com>
References: <20200502181643.38203-1-carenas@gmail.com>
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

While at it add tests for all known corruptions that are currently
ignored to keep track of them and avoid the risk of regressions.

[1] https://stackoverflow.com/a/61420852/5005936

Reported-by: Dirk <dirk@ed4u.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v11:
* remove bogus early check for CR characters
v10:
* go back to v4 but with better testing and commit message
* make sure broken CR characters are ignored early
v9:
* use strbuf_getline() instead to better handle files with CRLF
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

 credential-store.c          |  4 +-
 t/t0302-credential-store.sh | 91 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index c010497cb2..294e771681 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -24,8 +24,8 @@ static int parse_credential_file(const char *fn,
 	}
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
-		credential_from_url(&entry, line.buf);
-		if (entry.username && entry.password &&
+		if (!credential_from_url_gently(&entry, line.buf, 1) &&
+		    entry.username && entry.password &&
 		    credential_match(c, &entry)) {
 			found_credential = 1;
 			if (match_cb) {
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index d6b54e8c65..716bf1af9f 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -107,7 +107,6 @@ test_expect_success 'store: if both xdg and home files exist, only store in home
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
-
 test_expect_success 'erase: erase matching credentials from both xdg and home files' '
 	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
 	mkdir -p "$HOME/.config/git" &&
@@ -120,4 +119,94 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
+invalid_credential_test() {
+	test_expect_success "get: ignore credentials without $1 as invalid" '
+		echo "$2" >"$HOME/.git-credentials" &&
+		check fill store <<-\EOF
+		protocol=https
+		host=example.com
+		--
+		protocol=https
+		host=example.com
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''https://example.com'\'':
+		askpass: Password for '\''https://askpass-username@example.com'\'':
+		--
+		EOF
+	'
+}
+
+invalid_credential_test "scheme" ://user:pass@example.com
+invalid_credential_test "valid host/path" https://user:pass@
+invalid_credential_test "username/password" https://pass@example.com
+
+test_expect_success 'get: credentials with DOS line endings are invalid' '
+	printf "https://user:pass@example.com\r\n" >"$HOME/.git-credentials" &&
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=askpass-username
+	password=askpass-password
+	--
+	askpass: Username for '\''https://example.com'\'':
+	askpass: Password for '\''https://askpass-username@example.com'\'':
+	--
+	EOF
+'
+
+test_expect_success 'get: credentials with path and DOS line endings are valid' '
+	printf "https://user:pass@example.com/repo.git\r\n" >"$HOME/.git-credentials" &&
+	check fill store <<-\EOF
+	url=https://example.com/repo.git
+	--
+	protocol=https
+	host=example.com
+	username=user
+	password=pass
+	--
+	EOF
+'
+
+test_expect_success 'get: credentials with DOS line endings are invalid if path is relevant' '
+	printf "https://user:pass@example.com/repo.git\r\n" >"$HOME/.git-credentials" &&
+	test_config credential.useHttpPath true &&
+	check fill store <<-\EOF
+	url=https://example.com/repo.git
+	--
+	protocol=https
+	host=example.com
+	path=repo.git
+	username=askpass-username
+	password=askpass-password
+	--
+	askpass: Username for '\''https://example.com/repo.git'\'':
+	askpass: Password for '\''https://askpass-username@example.com/repo.git'\'':
+	--
+	EOF
+'
+
+test_expect_success 'get: store file can contain empty/bogus lines' '
+	echo "" >"$HOME/.git-credentials" &&
+	q_to_tab <<-\CREDENTIAL >>"$HOME/.git-credentials" &&
+	#comment
+	Q
+	https://user:pass@example.com
+	CREDENTIAL
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=user
+	password=pass
+	--
+	EOF
+'
+
 test_done

base-commit: 49458fb91d61461938881559ce23abbb1a2f8c35
-- 
2.26.2.686.gfaf46a9ccd

