Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FBD920451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbcLMXV7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:21:59 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:32782 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbcLMXV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:21:59 -0500
Received: by mail-pf0-f180.google.com with SMTP id d2so341425pfd.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UOSf51XJRwjIYaro04uk3TRsYLLARJv3lN63pCCEZak=;
        b=UHGYzBME5r5U9joPLHnh/4L7QTiMTuE7RoctuzelYPqU3CYzJl1sQBQdI9/CUka5h0
         aAEI12fSvAjc5NSJLdbrIStyHNhr6A5qfN9yS3yHAW0FA6qCbT8yKtQ1Byov82NHDW+u
         WgWMI8VbjUydrfBBk8keW1CFKaF2JDUASHbG/t1Hl08xfH+oi/an4zxDsPqQSRyWqRj/
         8SqMr+7TbKn0SrUFLyYkKoG11F5qHkSw0orE9NJll+f+kfigVAJ1ueBTS3mHLEaqx/a0
         5ZSG/UV83BnpGG8ILaUtN6bwo6ep9pM7Y7MYnZEyOurZgutDDOS4v04D8hMsNA5YBBV/
         4a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UOSf51XJRwjIYaro04uk3TRsYLLARJv3lN63pCCEZak=;
        b=XqotApTcpcCYTnIRygwJHSZJKMQCR0U/h0gF0V2LYRreney4JC30mw1rjhp3FjfV7S
         Q79nlS1NHJf7hIJMy2EccSiA3GLM9FA5J/5S0Of8GKw5kF2qhfL26pyREODtDw+nbEH8
         o6XreqDraxvirl6fBEOkMtN9ELZew7d7nPvJPD4ZqeyLxJJNhfbBQrUGVaaeGjyruKBd
         19BeAUJSbA+hWlv5JEIBX3VPiAnxYKRV+m5AfuUtUTxcvKXj6n/v5vs8tw0ctM1JYrRT
         54+EXoUJ9XsxlJQgeJjFl5UDsBdb1K8d2UlHem2Hn39L3yBxaad1QCiT/AQI0aya7B5x
         SXWg==
X-Gm-Message-State: AKaTC03ENC4oeu18D0XU9ZeafyQ+ylKM3OAkjiDsSNxs4QbJmGhXrXuDW13aLjzXWMKPjIJj
X-Received: by 10.84.167.168 with SMTP id d37mr47548151plb.71.1481670901877;
        Tue, 13 Dec 2016 15:15:01 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:15:00 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 14/16] pathspec: create strip submodule slash helpers
Date:   Tue, 13 Dec 2016 15:14:28 -0800
Message-Id: <1481670870-66754-15-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
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
index a0fec49..6fd4b8e 100644
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

