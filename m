Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F284EC2BB85
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 14:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71C5206B9
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 14:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s872Yjzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390383AbgDPOQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393571AbgDPOPx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 10:15:53 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D88C061A0F
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 07:15:52 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i7so8686129edq.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TaqoNgbrL9dXk7L8pr2lcgFgioHcIAzdyTV0X0V50rg=;
        b=s872YjzpBB0RE8T8L8Rhf4yLCMCh8q/SBBwkn0iHZmpHfdej1+q8r7BqhrlqgJpOJ2
         d1SUhQD7HWUDeaHgFFsAlhw0yVvu/bm6C4e0fUgY3HA9OJOuXu3eQm/JzcLJo8WDuTcd
         cyutINIzF5afIdR6Du2Csn/Fg9zWsJmmMaOp1K6/8ZhLczgR/O1QUKWr7U2AB5lqD/i3
         oh5kgBXx+HGYWWxqT0QPMzuxO1gH5rJRmtOs56Yph8gXzKpxLBDgmyFQn6XEMeMQXEoO
         7DwyJtSHKzyKn9A+dnzkQbB8UyHpm/oL2+jJg1Xc36eUvDtsdE5sWEpbmse6CpcOLNUO
         3WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TaqoNgbrL9dXk7L8pr2lcgFgioHcIAzdyTV0X0V50rg=;
        b=Gi2KHdG1SQlAlCxfScraP/3LHaEV47Wu60fhcnprKgwZ32fo0TjOSyyahBxQyOXKk5
         R8mh3M/grzXw6jLulfR/tvqU088JBIYFp4QCqkUr48Zz/2DQSriquEcUi/IrIH0g6UCS
         qzdJOXNtwGW8KCAIVZ5W4ez4SUFwZBiJlCrkCbRb1jIQFE+G+gTYplCb9lSAg7T0lPFU
         3x/4QGF+Teclp4P1Zy0nqw2uUvdMvVQECld9n2Ie74G3ycaPXDL8XuQABfOOw1PREC3L
         Gliu4yUWUDxEsCry09ORzr/6Bdy0U+HsUj0GhKQAWdn8akXhj7Udwiu0vNHFN8FeLght
         0zEQ==
X-Gm-Message-State: AGi0Puby5t3Hg1odCbh33waKFa6JQdRweOMpjBF3C+Q6kye3B1dYe9PN
        ufq8vQaDuth5s6i3G7wD3I1VCMYs
X-Google-Smtp-Source: APiQypJqAUYzZYogK+yHvKQLoLkELYNO7spMdqta7o6kq9diA9nTLHKmcmBKplpI0iWe4UIW6ht2eg==
X-Received: by 2002:a05:6402:28b:: with SMTP id l11mr24143233edv.156.1587046551220;
        Thu, 16 Apr 2020 07:15:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm2573447edj.21.2020.04.16.07.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 07:15:50 -0700 (PDT)
Message-Id: <6840f8801e43120cc78e9fa937fd54ad26a10180.1587046549.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.610.v3.git.1587046549.gitgitgadget@gmail.com>
References: <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com>
        <pull.610.v3.git.1587046549.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Apr 2020 14:15:48 +0000
Subject: [PATCH v3 1/2] log-tree: make ref_filter_match() a helper method
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sluongng@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The ref_filter_match() method is defined in refs.h and implemented
in refs.c, but is only used by add_ref_decoration() in log-tree.c.
Move it into that file as a static helper method. The
match_ref_pattern() comes along for the ride.

While moving the code, also make a slight adjustment to have
ref_filter_match() take a struct decoration_filter pointer instead
of multiple string lists. This is non-functional, but will make a
later change be much cleaner.

The diff is easier to parse when using the --color-moved option.

Reported-by: Junio C Hamano <gister@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 log-tree.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 refs.c     | 44 --------------------------------------------
 refs.h     | 12 ------------
 3 files changed, 46 insertions(+), 59 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 52127427ffe..ab6d29a746b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -81,6 +81,51 @@ const struct name_decoration *get_name_decoration(const struct object *obj)
 	return lookup_decoration(&name_decoration, obj);
 }
 
+static int match_ref_pattern(const char *refname,
+			     const struct string_list_item *item)
+{
+	int matched = 0;
+	if (item->util == NULL) {
+		if (!wildmatch(item->string, refname, 0))
+			matched = 1;
+	} else {
+		const char *rest;
+		if (skip_prefix(refname, item->string, &rest) &&
+		    (!*rest || *rest == '/'))
+			matched = 1;
+	}
+	return matched;
+}
+
+static int ref_filter_match(const char *refname,
+			    const struct decoration_filter *filter)
+{
+	struct string_list_item *item;
+	const struct string_list *exclude_patterns = filter->exclude_ref_pattern;
+	const struct string_list *include_patterns = filter->include_ref_pattern;
+
+	if (exclude_patterns && exclude_patterns->nr) {
+		for_each_string_list_item(item, exclude_patterns) {
+			if (match_ref_pattern(refname, item))
+				return 0;
+		}
+	}
+
+	if (include_patterns && include_patterns->nr) {
+		int found = 0;
+		for_each_string_list_item(item, include_patterns) {
+			if (match_ref_pattern(refname, item)) {
+				found = 1;
+				break;
+			}
+		}
+
+		if (!found)
+			return 0;
+	}
+	return 1;
+}
+
 static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
@@ -88,9 +133,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 	enum decoration_type type = DECORATION_NONE;
 	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
 
-	if (filter && !ref_filter_match(refname,
-			      filter->include_ref_pattern,
-			      filter->exclude_ref_pattern))
+	if (filter && !ref_filter_match(refname, filter))
 		return 0;
 
 	if (starts_with(refname, git_replace_ref_base)) {
diff --git a/refs.c b/refs.c
index 1ab0bb54d3d..28c91d603c2 100644
--- a/refs.c
+++ b/refs.c
@@ -321,50 +321,6 @@ int ref_exists(const char *refname)
 	return refs_ref_exists(get_main_ref_store(the_repository), refname);
 }
 
-static int match_ref_pattern(const char *refname,
-			     const struct string_list_item *item)
-{
-	int matched = 0;
-	if (item->util == NULL) {
-		if (!wildmatch(item->string, refname, 0))
-			matched = 1;
-	} else {
-		const char *rest;
-		if (skip_prefix(refname, item->string, &rest) &&
-		    (!*rest || *rest == '/'))
-			matched = 1;
-	}
-	return matched;
-}
-
-int ref_filter_match(const char *refname,
-		     const struct string_list *include_patterns,
-		     const struct string_list *exclude_patterns)
-{
-	struct string_list_item *item;
-
-	if (exclude_patterns && exclude_patterns->nr) {
-		for_each_string_list_item(item, exclude_patterns) {
-			if (match_ref_pattern(refname, item))
-				return 0;
-		}
-	}
-
-	if (include_patterns && include_patterns->nr) {
-		int found = 0;
-		for_each_string_list_item(item, include_patterns) {
-			if (match_ref_pattern(refname, item)) {
-				found = 1;
-				break;
-			}
-		}
-
-		if (!found)
-			return 0;
-	}
-	return 1;
-}
-
 static int filter_refs(const char *refname, const struct object_id *oid,
 			   int flags, void *data)
 {
diff --git a/refs.h b/refs.h
index 545029c6d80..a92d2c74c83 100644
--- a/refs.h
+++ b/refs.h
@@ -361,18 +361,6 @@ int for_each_rawref(each_ref_fn fn, void *cb_data);
 void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 			const char *pattern);
 
-/*
- * Returns 0 if refname matches any of the exclude_patterns, or if it doesn't
- * match any of the include_patterns. Returns 1 otherwise.
- *
- * If pattern list is NULL or empty, matching against that list is skipped.
- * This has the effect of matching everything by default, unless the user
- * specifies rules otherwise.
- */
-int ref_filter_match(const char *refname,
-		     const struct string_list *include_patterns,
-		     const struct string_list *exclude_patterns);
-
 static inline const char *has_glob_specials(const char *pattern)
 {
 	return strpbrk(pattern, "?*[");
-- 
gitgitgadget

