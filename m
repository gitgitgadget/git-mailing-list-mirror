Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB70C1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 19:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932362AbcLHS7r (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:59:47 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:32967 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbcLHS7o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:44 -0500
Received: by mail-pg0-f47.google.com with SMTP id 3so176788154pgd.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DMS/0fLy0PnCgpbNLD5bdlU5t2yw6WgIPvilov+WUWs=;
        b=gQUX5Zt1TVgwSkxO+7RJm0/IxqEUUvW1m+m51zzmNsIoP/k2Ff8yB/KwweY70i81sf
         chBcrducvp4BnYWqwlqpc5Syop9xHzZkyRXRFBRcRQHKNgQf/UNeGJQ4po3XFNCvdKFM
         skoynlqG0Zd3NeWA7RecraILZov/bdNwOPHmRWZfa+TqImMmE4FdhSrXPKHAMX3xI+NN
         uP7EqRJT9TGrEuxOR3ciUNrD6tW6+vnJMta6lkFWYQavJaL9EHeGVDPPEcrwajbm5Vyi
         f9Ui1KnFpvof+ZAXEqeeSm24i5s7gmW2CEZUYZGs1yXnHQ/dGpf+llb+JGWDvVn20wwe
         mNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DMS/0fLy0PnCgpbNLD5bdlU5t2yw6WgIPvilov+WUWs=;
        b=TX3Qp48bw+k8j7fjXrizRMj7aZAkww3kmY6iCEa1yR+lSBIxjU6/KJs56/xf9J47k2
         y9B33igQv5+6+2+GRCftIXloXD0LCHc4qnGP6Nel/KjHBnQhDdWDbD2/vWHpNJUXBT/0
         f1MChs8lmPHxOfKtI7Nw3e0RAB22Esl2WmIc6iKKN2+KnORgGV8FNalKb5MvpvT+MQSi
         y/jPJh4r1z9hz4W/KhLFR17dfavPGzfbDcXMoi3I7FZGV44a3r/vcXVzcPY1Ii1HAFH+
         dzxV4KhQJb3WnttKmfeEOd/Vhp4Uj+bNWDMu+9ZAT4MdrQppAYtnvzGiHntkJ6Pjas0h
         SUSw==
X-Gm-Message-State: AKaTC00NBfiU4ChohGqp/ZdnvZ3TZea2t5PAbGC5oL7aWTZpZJabY6U25B6dY84pNGMn7k1l
X-Received: by 10.99.109.6 with SMTP id i6mr133260833pgc.139.1481223583877;
        Thu, 08 Dec 2016 10:59:43 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:42 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 14/16] pathspec: create strip submodule slash helpers
Date:   Thu,  8 Dec 2016 10:59:08 -0800
Message-Id: <1481223550-65277-15-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
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
index f37f887..cf88390 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -258,6 +258,44 @@ static const char *parse_element_magic(unsigned *magic, int *prefix_len,
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
@@ -278,7 +316,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	unsigned magic = 0, element_magic = 0;
 	const char *copyfrom = elt;
 	char *match;
-	int i, pathspec_prefix = -1;
+	int pathspec_prefix = -1;
 
 	/* PATHSPEC_LITERAL_PATH ignores magic */
 	if (flags & PATHSPEC_LITERAL_PATH) {
@@ -329,33 +367,11 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
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

