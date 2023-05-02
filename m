Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FAAC77B78
	for <git@archiver.kernel.org>; Tue,  2 May 2023 21:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjEBVPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 17:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjEBVPN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 17:15:13 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F340F1701
        for <git@vger.kernel.org>; Tue,  2 May 2023 14:15:08 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64115e69e1eso197278b3a.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683062108; x=1685654108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p43IGMkga+u28vj7O6sZOrz6M24Ckvl4Mob1dtfdiVQ=;
        b=yRevY7V8GVVq+h/MmbVILly/uKLjtHN/bHAIKJ66Kgopy9N0/VDSGvHmR5mes3hsy7
         B2oAkiS8p3HRXVH5VLTbNlr94sAnIy5037izhsFOmzNC0JXmV2cmso9BkLIcxZIYqt/l
         J7wQIMOQgdlNFf1aV4g0rpYkodAvXG0OQ3Gb2B6SZXAtvvjojyzJJ+K8YpENtTU61k+d
         e6InTXmrWMYXf333qwjQ9j5fI1XWfc5FiWbD8T1j6q+BGLB5YjVQz+TpEDcxkj7mQt+5
         1aSLOjbVeFnXAe2mgW0rT8JTetNCqHurPcawrJ/u9MRFUtaZHOT/wV1QQq/rm0QHZWFO
         Ghew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062108; x=1685654108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p43IGMkga+u28vj7O6sZOrz6M24Ckvl4Mob1dtfdiVQ=;
        b=GyUuWI73waz/ygSq6fIDNA8iLCewyYPFgUr3R13aeJfKa3voE4/18y42qC1k7HA/yd
         qLS3MI7RtiMYMZVL80IxJvERoLWir9nYP/pE7P2e7C+RMXkzR53B7ToIqS6tJJXmUzl+
         qU9Kjk/sTU2vmakzhd2ogwNa2Ro/J38Cw9VgmCjOlC8l4Z/dc4xeX9BMrWvY76qK3GKy
         wJdVy+RuWVvs+WHFvZ5j0mycSJMn3jRIbzdjlwMdr5LtSeu2VQiJLY8YB3Op7BAWSBer
         2qCNBZxpyxmITf6wNBwhQuTj8fZGREA2nXvpaklY1yw7fUnJvr1xk05FGyGU+P2r18A/
         Zftw==
X-Gm-Message-State: AC+VfDzPhjv6hjAUcDEBGEmUzJIOvj4PjbdPqfdRaYwXWGiRMLBAZ8Pz
        QNFRxPp9tPgnHUF4uUO7dqJacfPV20fZfCbk3C3YjTOD8Q3GceZm1lj5u/EjEuu0EvYur1/V6nn
        WvYi/nLo4BVMQY0dJRnUZFena+1B+I8jrQpmDVDqb0BsdVcR7ZaK1j2w11v0dL+YTgQ==
X-Google-Smtp-Source: ACHHUZ4Es97WwX+WGR+ZIQXNwQ5ehDvTTvozKSPiEPsEhDdNGZcQRnlsuRizZuIiyJ9w6/xxTMMt9fwoHoKzPOY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:78a:b0:24e:403d:4882 with SMTP
 id l10-20020a17090b078a00b0024e403d4882mr350142pjz.3.1683062108307; Tue, 02
 May 2023 14:15:08 -0700 (PDT)
Date:   Tue,  2 May 2023 21:14:50 +0000
In-Reply-To: <20230502211454.1673000-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502211454.1673000-3-calvinwan@google.com>
Subject: [PATCH 2/6] credential-store: move related functions to
 credential-store file
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Calvin Wan <calvinwan@google.com>
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
index 6b4ad63266..1a4c07a053 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -682,9 +682,6 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
 typedef int (*char_predicate)(char ch);
 
-int is_rfc3986_unreserved(char ch);
-int is_rfc3986_reserved_or_unreserved(char ch);
-
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
 			     char_predicate allow_unencoded_fn);
 
-- 
2.40.1.495.gc816e09b53d-goog

