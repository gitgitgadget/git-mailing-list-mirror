Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB9AC77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 19:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbjFFTtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 15:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbjFFTs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 15:48:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B82810D7
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 12:48:52 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2562fbb193bso2191596a91.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 12:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686080932; x=1688672932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ea/r2aFX5xsJ9Rb3DThSB+ojzHdABHASIBU1nJqtQJs=;
        b=g58QzathEK6gu8X8o6jrh57ejV3U8lcT9Fh0qJCArSKRI6iN8ltn1bU+ZNwkrlWKma
         xNgrvy0zbH3NWV6F+moFU7FC9BqmagLHKOAfOGqNl5wNfrCo+F0WLfTP+nU0EvCTzfMH
         acgZWnaGdWfBxTunznE7V9KfJJ6N83gV2Rh3ZOFYpOP2KIcyEvdzug1vcrzNVsb4b6sn
         QXt7HcMEYjpedCBDguCzJZWHYKOkQCEqfM9a91YR9cATDLnnXwQmXnZ2Hmr/A5aU3sUZ
         caH1JarG2GiWe2xnirIxLzZd/Pg4WSR3BWloBpUxIEaSPFdQI3LtdcmkyG6EUsgSmJsJ
         eQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686080932; x=1688672932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ea/r2aFX5xsJ9Rb3DThSB+ojzHdABHASIBU1nJqtQJs=;
        b=jP5lkuqQh5Fl97uVQbAy3Ke5bXov9fSQUEesteXDfyX1YIXi5maifNSnbflXOiMibf
         G/g+YjIsDfiSQeIM/7AVZLMX/qbVhVXvcWwmIuRhBUc0xCSY6+JNqS2rhC1aked+aJpV
         ufY71uIJEYAg7I1DTNi0uz5X0uRvdwUaAEeBVQHzSHp/4LRFJ6ZPYfcesTusM0iG+ftd
         WeXo3Y8FUip5IuFG7XYu9Opuk++JlvYTUMe4Q8TBoG5praD+AGIjfTNSjVloS61ykxGp
         CvaLVhcQ5EWwPAwwmbeAQ3SlIrjU3buEqLTiadDbVmucElu/vyAmy6ekEnJ/BqG6KCNU
         pvsA==
X-Gm-Message-State: AC+VfDzKrD/O+5gpobmvOWCInKzZSBkJ8oiPVUMXtUTsF6Q/WI7X7mBm
        G9Q+psYHbbAtsIvEMM8aytZCdd32vzWUIJRBuP7ihgJjkMjkwTujmNeqrfKoIviAGmc2P6dMjxb
        RX5Fm7rVEkkcgFODnBTgsSIsGLRGMA/2NbwcpLhwu6knqCJ2Z4VCVEdYVHZP1uAxU+w==
X-Google-Smtp-Source: ACHHUZ7r/sH2zYxEyuiCnPFF5QnVnYbZDoT4DM/O/gHwtkGdvG+D51oEvKXBetQCAcMAKFRHD/ebFNwauLmQOqg=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:d311:b0:246:6a3a:6aec with SMTP
 id p17-20020a17090ad31100b002466a3a6aecmr849501pju.4.1686080931904; Tue, 06
 Jun 2023 12:48:51 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:48:40 +0000
In-Reply-To: <20230606194720.2053551-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606194720.2053551-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230606194843.2054314-4-calvinwan@google.com>
Subject: [PATCH v7 4/7] credential-store: move related functions to
 credential-store file
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

is_rfc3986_unreserved() and is_rfc3986_reserved_or_unreserved() are only
called from builtin/credential-store.c and they are only relevant to that
file so move those functions and make them static.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 builtin/credential-store.c | 19 +++++++++++++++++++
 strbuf.c                   | 19 -------------------
 strbuf.h                   |  3 ---
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 30c6ccf56c..5eea5bdb58 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -74,6 +74,25 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 		die_errno("unable to write credential store");
 }
 
+static int is_rfc3986_unreserved(char ch)
+{
+	return isalnum(ch) ||
+		ch == '-' || ch == '_' || ch == '.' || ch == '~';
+}
+
+static int is_rfc3986_reserved_or_unreserved(char ch)
+{
+	if (is_rfc3986_unreserved(ch))
+		return 1;
+	switch (ch) {
+		case '!': case '*': case '\'': case '(': case ')': case ';':
+		case ':': case '@': case '&': case '=': case '+': case '$':
+		case ',': case '/': case '?': case '#': case '[': case ']':
+			return 1;
+	}
+	return 0;
+}
+
 static void store_credential_file(const char *fn, struct credential *c)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/strbuf.c b/strbuf.c
index a2249ae7ed..5244029d91 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -810,25 +810,6 @@ void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
 	}
 }
 
-int is_rfc3986_reserved_or_unreserved(char ch)
-{
-	if (is_rfc3986_unreserved(ch))
-		return 1;
-	switch (ch) {
-		case '!': case '*': case '\'': case '(': case ')': case ';':
-		case ':': case '@': case '&': case '=': case '+': case '$':
-		case ',': case '/': case '?': case '#': case '[': case ']':
-			return 1;
-	}
-	return 0;
-}
-
-int is_rfc3986_unreserved(char ch)
-{
-	return isalnum(ch) ||
-		ch == '-' || ch == '_' || ch == '.' || ch == '~';
-}
-
 static void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
 				 char_predicate allow_unencoded_fn)
 {
diff --git a/strbuf.h b/strbuf.h
index 207efb4f98..114ad0c024 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -690,9 +690,6 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
 typedef int (*char_predicate)(char ch);
 
-int is_rfc3986_unreserved(char ch);
-int is_rfc3986_reserved_or_unreserved(char ch);
-
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
 			     char_predicate allow_unencoded_fn);
 
-- 
2.41.0.162.gfafddb0af9-goog

