Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6411320754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965127AbdADSEt (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:04:49 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33927 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761466AbdADSEm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:42 -0500
Received: by mail-pg0-f51.google.com with SMTP id y62so177755305pgy.1
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J595azE//eRgRSQa6V/x3ahf1mouzQIyjKrMbZmaajc=;
        b=Dbkyj80ndC6AUWqgGwuhdFMcYyEgoFBaibdQHps1oGOQFY2TslzVXcAPB+n9vevzxg
         Empz8V6q45EM8KIvXJiSJeA1kHsPVQp7Pii4ZWaRe4evkSNUwDzIfn4RHVNW5RtuvVwL
         DyG8hh2lqAtUy3holZF6aKlTjKiCxrz1hy6whsmTt9yDfVhIAp9vCX3aRkoOLSMZQOgi
         VMXaqdUJ5rNSudwSbD+hEDLw18vb55zFAppL7KpdKXtuCQznhBNRPxGp5OclrVssBalm
         kxcLICw82ffT0hDV5xX1c2/N5/T3R4rSuXD5Hn58RJ06v0pAFA/Rb1Cp98lOigH7kcjL
         kRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J595azE//eRgRSQa6V/x3ahf1mouzQIyjKrMbZmaajc=;
        b=i69dIX965sraIVqk7/HEbJPXp45Il2sj/G43CWh6Wdthcfdn8IpKIiE4I3EvNPaKvD
         YQa/kMeTkc/EPISNZW8t0n4HWaDH/xt1zo13wwp1U8TrCe18sP7GxcCNbug72xwELvrk
         Lxz9HZcdZlutDiSivHUSfQwWi/F6bPyWe32y6vPq3/7FT3+JPerHRrCsm4s3W56UsazP
         C73CEKengc2GpsEdUHofmN2mBi8cbSWwHt21/wKJQcQprngO4Qrv0ewa1I9ujJpC9UhL
         g+/ZQ4CBgloqtnrLaXa4NJOUkluctzUemRt/FfiEDV6eI9OBVuo4lBBdpXSXi5+rl8OP
         UetQ==
X-Gm-Message-State: AIkVDXJomq+oPDilkWIt6OPc/vd57iomTvyzHJcBZ8hRFxSob8BdjLVdLe1T2HuA/XAqkh5D
X-Received: by 10.84.211.144 with SMTP id c16mr85125144pli.37.1483553081218;
        Wed, 04 Jan 2017 10:04:41 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:39 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 14/16] pathspec: create strip submodule slash helpers
Date:   Wed,  4 Jan 2017 10:04:09 -0800
Message-Id: <20170104180411.150000-15-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
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
index 00fcae4e1..f3a7a1d33 100644
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

