Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B54AC7EE23
	for <git@archiver.kernel.org>; Fri, 12 May 2023 17:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbjELRPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 13:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbjELRPf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 13:15:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C23D87F
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55a04468981so212667947b3.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683911730; x=1686503730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VAwqJwwujHeb2Bu6PMwggB4Ic8y8htba73uL1uqg53Q=;
        b=GkkuVSSw/RY+p7u+U6kQ38bruT0OZszA/CxD3yghtgJWYh28ErUG/CtaHX0VV1RnUM
         ML8VYQhp8xA+BgOPt/CVwnhDMnswX6rPS9wxVn8dz6Ughqbh1yeMg/07FVJN5vtlKcQy
         AjckhuNFudsRFKTtm/Y3Pq85H2qw2n7fCngn/s3zsyqPYnvjeZmCrb06yqMt4MzEypc6
         6W8m/k/ljIs//DFDmQTnN6SmojkeiK7p7slWmgVv2pYvYblDcynSji4pZKhkZOlnUoUR
         KkNYWRB2mTD8Bp+RcSEtfWRBYccysJSuacENWtLvBso2qP1mNxpEY6QQY6lELt3ERMiL
         HMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683911730; x=1686503730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAwqJwwujHeb2Bu6PMwggB4Ic8y8htba73uL1uqg53Q=;
        b=kLs3svY745NnTrgQnPS89gR3NkaHKWTro9aHsGZR23/GQ3eZfZT3EsbeD5eEHVvVhI
         xq2ROc6q9QTxyPYvQL/kY7gKXlKylO9iZ/fwEdAah1b7mM5gE62MnWk5F/llnyG3PjL2
         Y0JsH/ajMdlg5PLH0aCU/qnH8P3UtzbvOTk3pAhNypOpchqqCpONO+kdMW1OZiF3YSQ6
         wLSnriwUmKpA1ogNVNi+q18jsME2iFpr+8TPLBbyEiHDIDbBQ9P6MnDfjAW/7n9sGTUy
         W+UE1RqDPoDjpkc2O4UAKeXKSw7H/FCPk7KlYS8EygyZX0KZ9dAZDSftnlMyzzakW7CJ
         PQ9w==
X-Gm-Message-State: AC+VfDxJBIpG1D5tJF4Mi1RpE5y52tpsVdqgOhNU54w1/DbtmCRgV7Al
        zYyrOGiTo04qoR/oZEQcCnDnmbgXJ3Vafq5V2hhtccCz5YOH7tUDdk0pDY2CAgGGt4P8G11Nm4B
        dsRuWq6RmVBl6wzd1zTXMG7L6aNFQVSagL9AxaSCUsdM0/XgZ6xO4qq3Pf8SCrENmnQ==
X-Google-Smtp-Source: ACHHUZ5rW0QWe6MFo4aVni1a0XyF02igjQOmBgkEwq3Q12pExHaW3+GYFxO0lns8MYWr7Ozc7N+GxnDKrA9XeQ0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:ac4c:0:b0:545:f7cc:f30 with SMTP id
 z12-20020a81ac4c000000b00545f7cc0f30mr15579511ywj.0.1683911730746; Fri, 12
 May 2023 10:15:30 -0700 (PDT)
Date:   Fri, 12 May 2023 17:15:12 +0000
In-Reply-To: <20230512171429.2202982-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230512171429.2202982-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512171516.2203472-3-calvinwan@google.com>
Subject: [PATCH v6 3/7] credential-store: move related functions to
 credential-store file
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        sunshine@sunshineco.com
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
2.40.1.606.ga4b1b128d6-goog

