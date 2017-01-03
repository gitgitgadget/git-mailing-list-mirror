Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D9F1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965597AbdACSue (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:50:34 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33992 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965542AbdACSuY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:50:24 -0500
Received: by mail-pg0-f52.google.com with SMTP id y62so165491113pgy.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SQkasPj5uJaeKft2woiPL/flzBf02XQQEjAxkDQz7U0=;
        b=UO/HSW5dfr19xBLBXWWA3LTzJCvymKv7F6pJd5vQZt/QrDuAxWJ8tdSOYpX3ly6QV5
         16xSkd4Ih22x1C39Bv9K6Mr60DBfsoooqQlJtQHSrN15NcbLKggt27wDJHhxGHhQUtW0
         aNxSK6JmRFTnmFGkkPwlqBQFW0JBsOyp9L36VhP/DQZ4Zu2M7ifTs3XlLo0pr49npLV+
         TDh7POtRBSSg8SZ1RZf7g7hkkXa+h59sWG2z/IAjQ5woU7JL2TOT3NE8s5zZXiFJdcmH
         kghb76zPmhBqomlPvyTxq1Jtqv3metthOcyk7WlmY4hAtogH9rupSMSq5Athiu2Pvihq
         tJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SQkasPj5uJaeKft2woiPL/flzBf02XQQEjAxkDQz7U0=;
        b=e0bM5w9KGV0u0Se2xYXpQ+s90ckhSF7VoVSRN1YmLLsuGgRhOZLH06QYxw2Y+tvYzn
         +9oBcoG0QmP4YW0Q8yoXQaoYN6pefYQ4etJL/6RqA1LgwWO4ZSIXqBBCBpw3MIhjRTfN
         +RhxksI8tCtcDCACtYhKFxo01qtiOWz2pHoZGOvZmSPI++2A0sFuBKeJQJ2WVQIbgIHP
         cmGQc7f8cLKQNIc03M29AeHgB1dugKDwdKrClwy69Gxq+DgILYqC4TM6f/i353+gug0Z
         kacncqIVpHYlNDXbZzgS0QphZOemnMxhhDEVNoRVPoqUEOAm7c6JgW6bIm8/AGtqKcdW
         kRJQ==
X-Gm-Message-State: AIkVDXLPvjIzG0VPDvjohsEejB4ax1OLmR6Cl1Xgbhq1ugxWqcOqef4JzBI/ER/RfzbhXBsu
X-Received: by 10.99.207.17 with SMTP id j17mr114833498pgg.57.1483469000638;
        Tue, 03 Jan 2017 10:43:20 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:43:19 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 14/16] pathspec: create strip submodule slash helpers
Date:   Tue,  3 Jan 2017 10:42:39 -0800
Message-Id: <20170103184241.128409-15-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
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
index fe811a0a4..4a1f8ea44 100644
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
2.11.0.390.gc69c2f50cf-goog

