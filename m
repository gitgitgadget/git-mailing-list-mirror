Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C9171FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750914AbdALXzf (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:55:35 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35901 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdALXz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:55:26 -0500
Received: by mail-pf0-f174.google.com with SMTP id 189so20633204pfu.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 15:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6VrxKHHJ7VzXC8aYPBoB7vnm5CojA6TXlQB24l78q6g=;
        b=Ebiu1ZNlhWdUkaNrhzbWRRPo6glURbNHmzLK4ipBaphGaj2OHnySO5jrgwvnUA57h4
         qRG89eiz6p+O5JxFCxzsHNEhAxOJliGB+Ul4dyHXBQJJLFNEhP1jtB5IWkOq91KQnrgf
         lVe/+SRHydd3TxfkXXCLcir9E8Sm/Mxz9vnAXzUbr3Faj1C0h3pYv8PQWwTRaWp3UuNO
         8rzyXMEqVVWpQt/1Q/d0k8I2STDwu+ZoMwCD2hGWAxppLe+IRFlv5AnG7GyAOS9qgRPB
         NXpb/VtqXoue6wE9QpYNnlXJjVtbt/L6sHWpTAHIym5ryOxTA+bWQTkagWe8AZUJ41BD
         HTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6VrxKHHJ7VzXC8aYPBoB7vnm5CojA6TXlQB24l78q6g=;
        b=avrFJXJe4w7N7UxiTrF9LCjmsiJ9U6HUIJErJA45s3OrsazZpW94Qt5Wg9xW3hWlfi
         5wQvToqC5oTJrvtKehmjL4+wKdOVI3oiqa5dj0L7PQPpmXgNqI63jWC295KPMl9U1wlK
         g8Dovz8UZmEW0gNujhvUotiQRM9lPP8zjxNBDdg6JZCN7Sa+wSfdrWXBRiur2fFXJ6ST
         rWwlDgmnNwpjd7tll/1QKqMgcj+wLSg0c0x7sYe4bYKRQPuk4UWt/wF6mel5uilBDhfL
         hGT5A0Bffy1WBuTQJlXQv7vIv1RpaQWsaa7FxVVO1i08ialZD3LiWCeMbNro3Hmwl2I9
         GfpA==
X-Gm-Message-State: AIkVDXIqGeLOa7n/J8py0pL2kiQ0wnJVC2PwF1taCAFmm6ES5zUMQjioSAWEK90XR6DiOhTC
X-Received: by 10.98.211.220 with SMTP id z89mr19257994pfk.3.1484265281178;
        Thu, 12 Jan 2017 15:54:41 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:38 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        pclouds@gmail.com, sbeller@google.com
Subject: [PATCH 24/27] attr: tighten const correctness with git_attr and match_attr
Date:   Thu, 12 Jan 2017 15:53:51 -0800
Message-Id: <20170112235354.153403-25-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c               | 14 +++++++-------
 attr.h               |  2 +-
 builtin/check-attr.c |  3 ++-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/attr.c b/attr.c
index 633a12cc3..90f576044 100644
--- a/attr.c
+++ b/attr.c
@@ -209,7 +209,7 @@ static void report_invalid_attr(const char *name, size_t len,
  * dictionary.  If no entry is found, create a new attribute and store it in
  * the dictionary.
  */
-static struct git_attr *git_attr_internal(const char *name, int namelen)
+static const struct git_attr *git_attr_internal(const char *name, int namelen)
 {
 	struct git_attr *a;
 
@@ -233,14 +233,14 @@ static struct git_attr *git_attr_internal(const char *name, int namelen)
 	return a;
 }
 
-struct git_attr *git_attr(const char *name)
+const struct git_attr *git_attr(const char *name)
 {
 	return git_attr_internal(name, strlen(name));
 }
 
 /* What does a matched pattern decide? */
 struct attr_state {
-	struct git_attr *attr;
+	const struct git_attr *attr;
 	const char *setto;
 };
 
@@ -267,7 +267,7 @@ struct pattern {
 struct match_attr {
 	union {
 		struct pattern pat;
-		struct git_attr *attr;
+		const struct git_attr *attr;
 	} u;
 	char is_macro;
 	unsigned num_attr;
@@ -814,7 +814,7 @@ static int fill_one(const char *what, struct attr_check_item *all_attrs,
 	int i;
 
 	for (i = a->num_attr - 1; rem > 0 && i >= 0; i--) {
-		struct git_attr *attr = a->state[i].attr;
+		const struct git_attr *attr = a->state[i].attr;
 		const char **n = &(all_attrs[attr->attr_nr].value);
 		const char *v = a->state[i].setto;
 
@@ -838,7 +838,7 @@ static int fill(const char *path, int pathlen, int basename_offset,
 	const char *base = stk->origin ? stk->origin : "";
 
 	for (i = stk->num_matches - 1; 0 < rem && 0 <= i; i--) {
-		struct match_attr *a = stk->attrs[i];
+		const struct match_attr *a = stk->attrs[i];
 		if (a->is_macro)
 			continue;
 		if (path_matches(path, pathlen, basename_offset,
@@ -988,7 +988,7 @@ struct attr_check *attr_check_initl(const char *one, ...)
 	check->check[0].attr = git_attr(one);
 	va_start(params, one);
 	for (cnt = 1; cnt < check->check_nr; cnt++) {
-		struct git_attr *attr;
+		const struct git_attr *attr;
 		param = va_arg(params, const char *);
 		if (!param)
 			die("BUG: counted %d != ended at %d",
diff --git a/attr.h b/attr.h
index f40524875..9b4dc07d8 100644
--- a/attr.h
+++ b/attr.h
@@ -8,7 +8,7 @@ struct git_attr;
  * Given a string, return the gitattribute object that
  * corresponds to it.
  */
-struct git_attr *git_attr(const char *);
+const struct git_attr *git_attr(const char *);
 
 /* Internal use */
 extern const char git_attr__true[];
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 3d4704be5..cc6caf7ac 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -166,7 +166,8 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	check = attr_check_alloc();
 	if (!all_attrs) {
 		for (i = 0; i < cnt; i++) {
-			struct git_attr *a = git_attr(argv[i]);
+			const struct git_attr *a = git_attr(argv[i]);
+
 			if (!a)
 				return error("%s: not a valid attribute name",
 					     argv[i]);
-- 
2.11.0.390.gc69c2f50cf-goog

