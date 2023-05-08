Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF7FC77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 16:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjEHQ7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 12:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjEHQ7p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 12:59:45 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F0F5261
        for <git@vger.kernel.org>; Mon,  8 May 2023 09:59:44 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-645538f6101so8724702b3a.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683565184; x=1686157184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/R0a/kHnyx4o9/HChG7nHUd642uhvmHNwkgsegQmtY8=;
        b=qxMJZHHe+qGOTEBO88Jf8C1D1fIbyvpK4W7+hpdvp13nju3gqV70UKra4umJRc/DSC
         HLmTcFgcuf+AyjvoXhLoQrjrJ2DcH6/KvIapDeLyhyHuhtBVImI37ECdwxsHq9sQ6sS5
         95AzFPN2mi5NfI4+WWOY1ej3iq/b/uU29eyA/hAzpuNLpuu+SSfKcpvfwSNkUmnYaEaq
         8t//82oMHEKBIZsT6T7Z65WVuLAX4xE7GFH1luxRhur5e1A1mXhQ3u+I/qVcWd0DGpYH
         MS98XULDT9qelkSweSxzEvzh7iLOx4s7qVHnSblfYGz+Qbtm89C7vFt/C9hJo9Yfxljr
         TbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683565184; x=1686157184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/R0a/kHnyx4o9/HChG7nHUd642uhvmHNwkgsegQmtY8=;
        b=PbOAws4WHmiO3z/bhI9fiobYTn6/XI7fsiqtZFErcpWE8eH0f4qJogEI/eHxzg/sAt
         1iKiIH23h+DhTY/yFkwW+n0i7HI7k9YfPPrY6UmBaAKuFTBS8rEJ1RdPhPDfRteRbM7s
         kfZbHvBc+S6N0KC8SVr96SBfOemSqpMVtAXwKTjkhHtMJ5g6hpYtehtagQjY0sZf+8lO
         l5IaU7pN2hsfg5+p4d2Lzpn5FfH8y3q0LscPB/SNTKV5NKwtsqmJj4ovG0/PV/WifyJP
         ua0X6TpPkORWqvlmDecwt0mbLlSpz5IrDiKvlwpC6Hiqqy+kU0NnyU9EKqxiRy7T7QnV
         mfxg==
X-Gm-Message-State: AC+VfDyR3m9z2XsjzibPiNh1sqQizUA54WuMHjiC9658hNR4FA6T/OCz
        q7AHjZ2qjW8+JCL08pgBH7YxoV0Pj5In7xwGn8z8xzf16zGsg42hIcm5ZcM0ykC2F18Fwv8dQ+D
        haXzyp31E5eMqpRPi/uyNed1qQMxT6dW/CrkU2KcZplVbGpOk/8tXJduPqUUkk1SeRQ==
X-Google-Smtp-Source: ACHHUZ7s4EB3BeiXTA5R+mXa0KfwLq8XQFGBqBuKx0g6FRN88Pxzn9LbjDRZxhrsw6Usb6603vNHORDLSMZbuB0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:885:b0:24e:403d:4882 with SMTP
 id bj5-20020a17090b088500b0024e403d4882mr4023050pjb.3.1683565183757; Mon, 08
 May 2023 09:59:43 -0700 (PDT)
Date:   Mon,  8 May 2023 16:59:04 +0000
In-Reply-To: <20230508165728.525603-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230508165728.525603-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230508165908.526247-3-calvinwan@google.com>
Subject: [PATCH v4 3/7] credential-store: move related functions to
 credential-store file
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
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
index 8977604eb9..4776118331 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -73,6 +73,25 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
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
index c3b6d48797..da2693b21f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -809,25 +809,6 @@ void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
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
index 20d0e37d9c..9e52fe7706 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -686,9 +686,6 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
 typedef int (*char_predicate)(char ch);
 
-int is_rfc3986_unreserved(char ch);
-int is_rfc3986_reserved_or_unreserved(char ch);
-
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
 			     char_predicate allow_unencoded_fn);
 
-- 
2.40.1.521.gf1e218fcd8-goog

