Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38BD81FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbcLFVxd (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:33 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33037 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbcLFVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:13 -0500
Received: by mail-pg0-f44.google.com with SMTP id 3so153592447pgd.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BMZTQn2YDuzmoD5zm4L5WJ5C8tWGuf9kF1/1MicjXjY=;
        b=CCGAjlWnut2gI9xzfDtXACA2CeTKJsIHEjJd54DGGkfEmXv6Kt/z+AyUL/vku3JcnB
         4P8ErCYaIBgJCllzVOljjR0r5sX/3zEC3wDWYocicybSmFJ0zxtl3jupizTxk18ujd4f
         dvRRSuVaVjXHFNLfM1P+TC5PrJQHgjwp14MzKnJ35T+E4A4UhI8BQGFPh++3T2EtI2fF
         qgXUtRjVu6MHoU8ZUl7tSdF9JcWFTuDERX48BQij70rdd0iOJcrKAt9WnxjiWY5jvHbV
         0VBHG4QeHHznLFWuyof31bG4GMYwvVZQeuIdbPssmq53zMSTzvr59F2zCYQj8uO7eORa
         PMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BMZTQn2YDuzmoD5zm4L5WJ5C8tWGuf9kF1/1MicjXjY=;
        b=CDc4Rus2vFHIfkS1Q1kM+2Qw/IgUvTp/Dv7uJtTQOAPIDyCyvXNzzRRW2fQIm20qUD
         5fFi4TfEPc00r8VLy2mpyTyCRcM8upNhgAJHVuyS/2T8GLwZixMKz9IqDdxKZuckLpo1
         FadoUwlZ/33wGA5NwBng7l8lg6GEWMIQ3UKgBF2xlv/nWuR6+Q4VPD/hYlV7H49mioSA
         TgyUiQL2eXf8HEbfg347T4hurVtOOUgMjgEGVRFVQOUtHXfxLfmnbTARogYA3GBVrCk5
         ealWXxGPSX5W7GrgHD/KBkERAC43mT2aaEnd1yOMTPN64hbhUj5NESBLY9AyTRAPqVXI
         JGig==
X-Gm-Message-State: AKaTC02EnrhwYYj5P6GaKmhyKmsDHQxlYsd2XM9hva9ZVq4n+b8KrlMKcPLPqAuKchJXuD20
X-Received: by 10.99.226.83 with SMTP id y19mr115628842pgj.147.1481061157017;
        Tue, 06 Dec 2016 13:52:37 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:36 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 15/17] pathspec: create strip submodule slash helpers
Date:   Tue,  6 Dec 2016 13:51:44 -0800
Message-Id: <1481061106-117775-16-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the logic responsible for stripping the trailing slash on
pathspecs referencing submodules into its own function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 68 ++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 793caf1..41aa213 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -257,6 +257,44 @@ static const char *parse_element_magic(unsigned *magic, int *prefix_len,
 		return parse_short_magic(magic, elem);
 }
 
+static void strip_submodule_slash_cheap(struct pathspec_item *item)
+{
+	int i;
+
+	if ((item->len >= 1 && item->match[item->len - 1] == '/') &&
+	    (i = cache_name_pos(item->match, item->len - 1)) >= 0 &&
+	    S_ISGITLINK(active_cache[i]->ce_mode)) {
+		item->len--;
+		item->match[item->len] = '\0';
+	}
+}
+
+static void strip_submodule_slash_expensive(struct pathspec_item *item)
+{
+	int i;
+
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		int ce_len = ce_namelen(ce);
+
+		if (!S_ISGITLINK(ce->ce_mode))
+			continue;
+
+		if (item->len <= ce_len || item->match[ce_len] != '/' ||
+		    memcmp(ce->name, item->match, ce_len))
+			continue;
+
+		if (item->len == ce_len + 1) {
+			/* strip trailing slash */
+			item->len--;
+			item->match[item->len] = '\0';
+		} else {
+			die (_("Pathspec '%s' is in submodule '%.*s'"),
+			     item->original, ce_len, ce->name);
+		}
+	}
+}
+
 /*
  * Take an element of a pathspec and check for magic signatures.
  * Append the result to the prefix. Return the magic bitmap.
@@ -278,7 +316,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	unsigned magic = 0, element_magic = 0;
 	const char *copyfrom = elt;
 	char *match;
-	int i, pathspec_prefix = -1;
+	int pathspec_prefix = -1;
 
 	/* PATHSPEC_LITERAL_PATH ignores magic */
 	if (!(flags & PATHSPEC_LITERAL_PATH)) {
@@ -327,33 +365,11 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	item->len = strlen(item->match);
 	item->prefix = prefixlen;
 
-	if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
-	    (item->len >= 1 && item->match[item->len - 1] == '/') &&
-	    (i = cache_name_pos(item->match, item->len - 1)) >= 0 &&
-	    S_ISGITLINK(active_cache[i]->ce_mode)) {
-		item->len--;
-		match[item->len] = '\0';
-	}
+	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP)
+	    strip_submodule_slash_cheap(item);
 
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
-		for (i = 0; i < active_nr; i++) {
-			struct cache_entry *ce = active_cache[i];
-			int ce_len = ce_namelen(ce);
-
-			if (!S_ISGITLINK(ce->ce_mode))
-				continue;
-
-			if (item->len <= ce_len || match[ce_len] != '/' ||
-			    memcmp(ce->name, match, ce_len))
-				continue;
-			if (item->len == ce_len + 1) {
-				/* strip trailing slash */
-				item->len--;
-				match[item->len] = '\0';
-			} else
-				die (_("Pathspec '%s' is in submodule '%.*s'"),
-				     elt, ce_len, ce->name);
-		}
+	    strip_submodule_slash_expensive(item);
 
 	if (magic & PATHSPEC_LITERAL)
 		item->nowildcard_len = item->len;
-- 
2.8.0.rc3.226.g39d4020

