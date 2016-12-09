Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA88E1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbcLITTA (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:19:00 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35274 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbcLITTA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:19:00 -0500
Received: by mail-pg0-f47.google.com with SMTP id p66so10666962pga.2
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 11:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qTccj6kq0NsjHJzQ5pIcWhw406i6riMWpKDpOh/6HhI=;
        b=jq1/sZjWdQs4Z5sRYQgbZCDLc1nmdeF0sgscA6tO8X7SBgVLCN26V2hj56Fq3PuvS4
         XLRdIPrh3Cjr5JIZlCyuM2EZcDj1YXac54/Qmz0qnFhJIdIKJwH2g4rFCQNJFBOvUehL
         PQdDTAQ8Oc4vqk5xKDEUs9yX4pbJv+G+HGohnDdIGNgq9GfLlQFPLWxeauhUddxjjL0y
         3datLXhOh2vYvvqCF3paCyKHnT9gQevfcI2+S4S22bAXA43Azl+NDlhu+9d4qvI/zGuF
         p2mHkBq4mAdlagXqBQbpBhCfV9gYbsuaQG9DTwDNC7pGVGDXo1NzJP/GfD/7r4iAwaLD
         bRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qTccj6kq0NsjHJzQ5pIcWhw406i6riMWpKDpOh/6HhI=;
        b=Ag4m7YFTQOYHHxV3JFh8VyqYiVGunlgdpIVHaoOs6iObx/iT/GyoaoJssHMVH4lJl0
         1ZgvQxS71hRTgRSe11gv27aeoCvvDconTQxqwWPZcvQlIWcZL5V/Zq2XYiMTuQUMgtsH
         tuW3Lbv+qYUDV4WV5txJmAE1MrTahDB6gkafm947QQIQFBg7Rw2NHOLVKwj1mbJV2Wsq
         /fvejYBzeUp32nkrRQ6VRjZHt/dlnCmtqIvmfGI2YNWICcvcFjMg4c5bW12trZrObW65
         vi+3TCH32OnvlWt+YJMUAoomIfgdiHIs1zJHCYkCINePeJK1zWYQKRvWGKEuy//Y9EMn
         4cqA==
X-Gm-Message-State: AKaTC0266iivvpNQO2eR6/Z3+6EdPS6a1FN8ppZi0vXiyJq2dWB4CPvRPEDutfdMJzTASp4E
X-Received: by 10.84.172.131 with SMTP id n3mr156984834plb.5.1481311139251;
        Fri, 09 Dec 2016 11:18:59 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id s3sm59372943pfe.27.2016.12.09.11.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 11:18:58 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH 14/16] pathspec: create strip submodule slash helpers
Date:   Fri,  9 Dec 2016 11:18:38 -0800
Message-Id: <1481311118-174146-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <CACsJy8AX6C8Tux9_8ZynBMNS2EW2pKQOGK8k0hVmbWvbZ8pa=Q@mail.gmail.com>
References: <CACsJy8AX6C8Tux9_8ZynBMNS2EW2pKQOGK8k0hVmbWvbZ8pa=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the logic responsible for stripping the trailing slash on
pathspecs referencing submodules into its own function.

Change-Id: Icad62647c04b4195309def0e3db416203d14f9e4
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 68 ++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 84a57cf..4d9a6a0 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -258,6 +258,44 @@ static const char *parse_element_magic(unsigned *magic, int *prefix_len,
 		return parse_short_magic(magic, elem);
 }
 
+static void strip_submodule_slash_cheap(struct pathspec_item *item)
+{
+	if (item->len >= 1 && item->match[item->len - 1] == '/') {
+		int i = cache_name_pos(item->match, item->len - 1);
+
+		if (i >= 0 && S_ISGITLINK(active_cache[i]->ce_mode)) {
+			item->len--;
+			item->match[item->len] = '\0';
+		}
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
+			die(_("Pathspec '%s' is in submodule '%.*s'"),
+			    item->original, ce_len, ce->name);
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
+		strip_submodule_slash_cheap(item);
 
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
+		strip_submodule_slash_expensive(item);
 
 	if (magic & PATHSPEC_LITERAL)
 		item->nowildcard_len = item->len;
-- 
2.8.0.rc3.226.g39d4020

