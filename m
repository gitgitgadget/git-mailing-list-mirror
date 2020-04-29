Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6744C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9878720B1F
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrpxBnRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgD2UgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2UgP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 16:36:15 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712DDC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 13:36:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o185so1572753pgo.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 13:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ejKxGjIZsujioWXd42JGBDmqYvzhR5DU0GIkL1HcAn0=;
        b=jrpxBnRTbzsDmdBrivAfqtOIE9PJvql6TgA6HQ/RM1IhqtFrv7DKqJnDd9GqcpncJ5
         GDdue8RopYcWCKQWJqOTby//Y36CCRi5dkQiqZQio2iedniAImvVZrSgLmR6sYMxxCyz
         M3XcTVQjJr4t+NQHz6l36HEZTDUBpvsI9CSmKRv9VoFJXHMoVt1onoCxe3oL5oiewvYT
         b6aH5yknxeM23vhzwphBAOxCTbWShEpc/6symPAeb1TEFzDRkGlWaFFmlq6N9RpLFTNm
         PXVOuGdWjtK54T5ZV5aE3tXJHdNBZ5ftBJ61tE463tyXRLM8B4M4B8FacZNZtWS3paeL
         rF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ejKxGjIZsujioWXd42JGBDmqYvzhR5DU0GIkL1HcAn0=;
        b=pFfbYXLSnedvmXnB2AF4cuAbQKFkLlJLsxysZ7RziwniChEOPBV0eepwhQ1ejfU0ie
         Tt9dCzwdrVOmGFy0m1OzEaKQDozp2etp6frTqyQKInuQk0PYA66GPNm7Dfsy8mOhdSxA
         CfpvjdNsC4MajfJFvrrWmC3RsfgiBCv5YV0tiMMioDI78Ziw4lrbX3fP/tiyynevS9C6
         nypn1yWlQI27wxBB/BmP7fAHob4mAlQOIRuM5D1Hto6twcPBDppK4I0NeZGeuPhFyb5R
         QVxbk29jVoj1KgJZP6OFFmUeB75LXggWc6RlNGYaUzzHq2W46WJW8KR0P93q03ud9BDd
         6S/A==
X-Gm-Message-State: AGi0PuYbhKB5REvK9xI9MnbqCuxdCeZ+Qvp6haP9Sm6eJdOTQ3w6QwzX
        LRpoo76eEZn3zMAB3Jb8Aip1WQYl
X-Google-Smtp-Source: APiQypKc0nG5jPi613Gic/vQqTvq52220h5lcLHU6vJwueeYEveDAf2ML49NTlgNhj97i0UXC4+q5g==
X-Received: by 2002:a62:18c8:: with SMTP id 191mr37871408pfy.255.1588192574671;
        Wed, 29 Apr 2020 13:36:14 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id h14sm1816404pfq.46.2020.04.29.13.36.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 13:36:14 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v6 2/2] credential-store: warn for any incomplete credentials instead of using
Date:   Wed, 29 Apr 2020 13:35:46 -0700
Message-Id: <20200429203546.56753-3-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
In-Reply-To: <20200429203546.56753-1-carenas@gmail.com>
References: <20200429003303.93583-1-carenas@gmail.com>
 <20200429203546.56753-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

originally any credential found was tried for matching as far as it had
a username and password, but that resulted in fatal errors as the rules
were harden.

now that we have a way to report malformed credentials, use it to notify
the user when username/password was missing, instead of just silently
skipping.

do the same for credentials that are missing host (or had one that is
empty) or that are missing a path (for supporting cert://) as well.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 credential-store.c          |  7 ++++---
 t/t0302-credential-store.sh | 38 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index 1cc5ca081a..53f77ff6f5 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -26,9 +26,10 @@ static int parse_credential_file(const char *fn,
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
 		lineno++;
-		if (!credential_from_url_gently(&entry, line.buf, 1)) {
-			if (entry.username && entry.password &&
-				credential_match(c, &entry)) {
+		if (!credential_from_url_gently(&entry, line.buf, 1) &&
+			((entry.host && *entry.host) || entry.path) &&
+			entry.username && entry.password) {
+			if (credential_match(c, &entry)) {
 				found_credential = 1;
 				if (match_cb) {
 					match_cb(&entry);
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 801c1eb200..3150f304cb 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -139,6 +139,44 @@ test_expect_success 'get: credentials without scheme are invalid' '
 	test_i18ngrep "ignoring invalid credential" stderr
 '
 
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
 test_expect_success 'get: store file can contain empty/bogus lines' '
 	echo "" > "$HOME/.git-credentials" &&
 	q_to_tab <<-\CONFIG >>"$HOME/.git-credentials" &&
-- 
2.26.2.569.g1d74ac4d14

