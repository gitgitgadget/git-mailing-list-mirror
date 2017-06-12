Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776E920401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbdFLWOy (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:54 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:32930 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753000AbdFLWOt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:49 -0400
Received: by mail-pg0-f48.google.com with SMTP id f185so50814599pgc.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I2Wm0p+GOr25oSHmyznq7DiqY/I0iBtxl9aZmw49+kc=;
        b=sH6eHP/z/jP/4IDvunNxyUGG7DFFZiI93Zl6wgwgKnkgEw851+Pw3UezB9YN/f6wmr
         c39ouFfrEidiGc39821JIJcrgaAi+SnMqoJ0OsPaMqPH+AGZwnFAI6Tx5cIRBrcxyrIg
         megn/li9CSmIScgWzDxh/9/ZLqeenxoqXUC3yafF+fRzyDHMIZLnxAMujDve1SggpMxp
         SriOxw84SuPGW+rt7x98mNdT7kaeqqfVduWrSiFWgc1texfCGXrq36DJU5rX7QrppG1z
         av5vRwnxprO2wZyfXP8BMWJbHUMT8WM8RQa/6gaI+EyakuYv2Az0pDJhxf52YhNNN5Oc
         wTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I2Wm0p+GOr25oSHmyznq7DiqY/I0iBtxl9aZmw49+kc=;
        b=E6SPDefOrBKS7iQN2Q6Ivsr0tRkZWa2ayE+Ptpcow81vbedOe+2ITaXhkMJDo9V66k
         SjyYDq5274okNxYJJiWJKljNMjq+GBLu+qd5ncXerl+9Wksmf7Fd+sZMTO4m0A3e/JLn
         RrYSTRN7PUmKDj/Pl1nXWZg3jf4UuWYfWZJPTQSEdmb8Pygs6yz0kInWFZBg9VXvF8tj
         cJleFnCHBiSDrudYk0AFxxXvhcXsKLPrJG+lNbD/cIIh9Su57jofKQ1bcOPjaR3d/KuE
         hxE2PkMIFjz9YFkCdGaLKkkv80wpH5PfhN4h8PzYr7DYAvySehYkGfu3cSJPy7qS1kS6
         hqTA==
X-Gm-Message-State: AODbwcBqJXyFW0Uz2lp7s5jTRtiTkScGAq7D6HJ3e7i3kNRJ4CX8ne9K
        8oKlGOBbZbywCeFKxmyLxA==
X-Received: by 10.101.89.66 with SMTP id g2mr45391442pgu.146.1497305672292;
        Mon, 12 Jun 2017 15:14:32 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:30 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 09/17] ls-files: convert show_killed_files to take an index
Date:   Mon, 12 Jun 2017 15:14:00 -0700
Message-Id: <20170612221408.173876-10-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 8c3f3d8ca..b82b78036 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -120,7 +120,8 @@ static void show_other_files(struct dir_struct *dir)
 	}
 }
 
-static void show_killed_files(struct dir_struct *dir)
+static void show_killed_files(const struct index_state *istate,
+			      const struct dir_struct *dir)
 {
 	int i;
 	for (i = 0; i < dir->nr; i++) {
@@ -134,29 +135,29 @@ static void show_killed_files(struct dir_struct *dir)
 				/* If ent->name is prefix of an entry in the
 				 * cache, it will be killed.
 				 */
-				pos = cache_name_pos(ent->name, ent->len);
+				pos = index_name_pos(istate, ent->name, ent->len);
 				if (0 <= pos)
 					die("BUG: killed-file %.*s not found",
 						ent->len, ent->name);
 				pos = -pos - 1;
-				while (pos < active_nr &&
-				       ce_stage(active_cache[pos]))
+				while (pos < istate->cache_nr &&
+				       ce_stage(istate->cache[pos]))
 					pos++; /* skip unmerged */
-				if (active_nr <= pos)
+				if (istate->cache_nr <= pos)
 					break;
 				/* pos points at a name immediately after
 				 * ent->name in the cache.  Does it expect
 				 * ent->name to be a directory?
 				 */
-				len = ce_namelen(active_cache[pos]);
+				len = ce_namelen(istate->cache[pos]);
 				if ((ent->len < len) &&
-				    !strncmp(active_cache[pos]->name,
+				    !strncmp(istate->cache[pos]->name,
 					     ent->name, ent->len) &&
-				    active_cache[pos]->name[ent->len] == '/')
+				    istate->cache[pos]->name[ent->len] == '/')
 					killed = 1;
 				break;
 			}
-			if (0 <= cache_name_pos(ent->name, sp - ent->name)) {
+			if (0 <= index_name_pos(istate, ent->name, sp - ent->name)) {
 				/* If any of the leading directories in
 				 * ent->name is registered in the cache,
 				 * ent->name will be killed.
@@ -337,7 +338,7 @@ static void show_files(struct dir_struct *dir)
 		if (show_others)
 			show_other_files(dir);
 		if (show_killed)
-			show_killed_files(dir);
+			show_killed_files(&the_index, dir);
 	}
 	if (show_cached || show_stage) {
 		for (i = 0; i < active_nr; i++) {
-- 
2.13.1.518.g3df882009-goog

