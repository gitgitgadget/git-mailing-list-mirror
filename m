Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A98EA201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932647AbdERXWr (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:47 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36365 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932641AbdERXWb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:31 -0400
Received: by mail-pf0-f182.google.com with SMTP id m17so30748678pfg.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pArGexPi3b4TMYq+UGn76Pg9R2/awGb8G/dTgZSFfqA=;
        b=rTZq57hrMYVRUaVBtSso19AGp1I+Dn1A0iRliDvR7+ALzdxdvhPrmgQLZoDmXdyHcF
         FwfO6dH0bDDFhNUUja3agAtRYFISCsmmh0WwJ+0C1LWNLugx5sbSeaEq3ilujMgV2X5H
         P9w1RbSdq4pc84AlJHXxIixjv3aiun2QFrqEJcX+CBJuB1PIKCuZp1U+6GW+HKNCmS3O
         uNsYVGbRUOyVuiEvvJKYShPv3a4sXQz3cDJAkVbfGN0Pp4fz7MA36CXFpzKyxN7KDQrx
         J+Md/5JaSEA6U/ubD91JLqXky/CqlDlxo4nAYzgEiyxc+NpD2uc5lObW0ZBYnBEbrmux
         0Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pArGexPi3b4TMYq+UGn76Pg9R2/awGb8G/dTgZSFfqA=;
        b=NixF1gRqxDiW1G58IqesmFTwLcOb5TIStLmxowBV4EVl1XuHdl2kfWbOZh4L3AqvzI
         c61/j4UvzP8WMZImK7RNf6dnVCDNC3MKgGwMe19ajjeARLqPnciEuo8BAaptQIWwxmRj
         sw7bQD+QzWz2a/zkm7BgT+OwcJam1a8gOkYqoZEkBSKSetLRgpbTvFl9KSWKaGgadNS7
         XSPRkwivIZ5mm2UBCGoyRHQB9HAaXTHLwHqiwaudo2wdBG//0rNX371YER/MuN742FQR
         H7xL4LnjOZ2706OZ0AHGPJF9AAzKHU71hVJaxga5tEJnWImfTOS3KkTvRxLKPPUQOeGe
         8gbg==
X-Gm-Message-State: AODbwcCVj0ziFi2dhhNJVuQ64cyDWg5V9oVmjt6rxYqpCFpz9mNOf0i8
        D4nSZdYbNt9p2Lc9
X-Received: by 10.99.152.67 with SMTP id l3mr7080669pgo.97.1495149740449;
        Thu, 18 May 2017 16:22:20 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:19 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 09/23] ls-files: convert show_killed_files to take an index
Date:   Thu, 18 May 2017 16:21:20 -0700
Message-Id: <20170518232134.163059-10-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 9313452e3..7cdee2359 100644
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
2.13.0.303.g4ebf302169-goog

