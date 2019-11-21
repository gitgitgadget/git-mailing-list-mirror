Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70154C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACC5206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKa0AEkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKUWFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45758 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfKUWFN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id z10so6259805wrs.12
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ips6wWu7Xdah4SBzOLvtoLKr422mshCSp/ecYyPpC+c=;
        b=jKa0AEkr6p8g2Ac4R0qn21U2vqvxaOjPpZMnhMcAYgR3Y/6DeH4B0GbUbxNRPGS+pr
         0zHf0LFhq8HBaUBKPUXvpeueBPQxIx9GVLk6Nh9s+TXxbPcJD3Blr13AAP4j8Q6RyB0p
         c4okumknjEkvqeY/7xjpWzUIVysQFjY9dLBWv7UflcQsExdqQ4QSYcpqpSmTb2tFCDZt
         6Bdb/nG1dunS7pypsh2E0i0g/gQTnE/0tImDGiel798wIrZWf8vRzjmkLg9mIoqTu6Yr
         zEYjiiwSedA20tk5f1VEntJ12zB2AXjw2l2fvxASNmGFUbLIreBQrnqB5Kx27zudT8Sw
         oM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ips6wWu7Xdah4SBzOLvtoLKr422mshCSp/ecYyPpC+c=;
        b=l4CInu9XmiIAvd9qbMstTpuLb4L1hUPmvVy35ESS8wyvQzWtaP+I1FFpNCk418qkzE
         2i8Oi0nz1vs7ipB1JWymO8ioMIkEqW3/WV6dJ7M+1W56k8UFfoYNCorMaeuaEqH59VYh
         XvYY/fUuXKyuojkE0tpAKfvHSkWwlb6QJVH6ouF4D1ldpdMxXVR+vYUgEhAC3g4h5OBX
         ca+uKwhP4S3w0bmWCWWXgXpUliZig72JNCKR6q2fVolhBU2xCRK3tLp4Zj8c2cxtOlYf
         aDy3Yh+G91UrhNgtJx/BtqxEe54WfulOA9uSbD07p1++upXVEjPsdiHVq1ELiCCWg6iS
         IaWQ==
X-Gm-Message-State: APjAAAUzcec9/xGJapo1sY7pEXjvRq80W6nPLOAS6vI9jYzcYzXc1mHv
        /1cKkntuC5UcLFExSzEVs5UqcjmU
X-Google-Smtp-Source: APXvYqzFDU4++SliBwzdy8NUh6p0omvv8HdjO6FA/WZPwGc/xXbOwU0RUK+Qlv/zUS/P90L0Jy4/Nw==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr9528634wrp.265.1574373910818;
        Thu, 21 Nov 2019 14:05:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g207sm611793wmg.40.2019.11.21.14.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:05:10 -0800 (PST)
Message-Id: <745910bb8e7afe9cf0c66e0d8f873a00b506fdfa.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:43 +0000
Subject: [PATCH v6 11/19] unpack-trees: hash less in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse-checkout feature in "cone mode" can use the fact that
the recursive patterns are "connected" to the root via parent
patterns to decide if a directory is entirely contained in the
sparse-checkout or entirely removed.

In these cases, we can skip hashing the paths within those
directories and simply set the skipworktree bit to the correct
value.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c          |  4 ++--
 dir.h          |  1 +
 unpack-trees.c | 38 +++++++++++++++++++++++---------------
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/dir.c b/dir.c
index 35c1ca9e24..2ef92a50a0 100644
--- a/dir.c
+++ b/dir.c
@@ -1270,7 +1270,7 @@ enum pattern_match_result path_matches_pattern_list(
 
 	if (hashmap_contains_path(&pl->recursive_hashmap,
 				  &parent_pathname)) {
-		result = MATCHED;
+		result = MATCHED_RECURSIVE;
 		goto done;
 	}
 
@@ -1292,7 +1292,7 @@ enum pattern_match_result path_matches_pattern_list(
 	if (hashmap_contains_parent(&pl->recursive_hashmap,
 				    pathname,
 				    &parent_pathname))
-		result = MATCHED;
+		result = MATCHED_RECURSIVE;
 
 done:
 	strbuf_release(&parent_pathname);
diff --git a/dir.h b/dir.h
index 8e232085cd..77a43dbf89 100644
--- a/dir.h
+++ b/dir.h
@@ -264,6 +264,7 @@ enum pattern_match_result {
 	UNDECIDED = -1,
 	NOT_MATCHED = 0,
 	MATCHED = 1,
+	MATCHED_RECURSIVE = 2,
 };
 
 /*
diff --git a/unpack-trees.c b/unpack-trees.c
index a90d71845d..c0dca20865 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1283,15 +1283,17 @@ static int clear_ce_flags_dir(struct index_state *istate,
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
 	int rc;
-	enum pattern_match_result ret;
-	ret = path_matches_pattern_list(prefix->buf, prefix->len,
-					basename, &dtype, pl, istate);
+	enum pattern_match_result ret, orig_ret;
+	orig_ret = path_matches_pattern_list(prefix->buf, prefix->len,
+					     basename, &dtype, pl, istate);
 
 	strbuf_addch(prefix, '/');
 
 	/* If undecided, use matching result of parent dir in defval */
-	if (ret == UNDECIDED)
+	if (orig_ret == UNDECIDED)
 		ret = default_match;
+	else
+		ret = orig_ret;
 
 	for (cache_end = cache; cache_end != cache + nr; cache_end++) {
 		struct cache_entry *ce = *cache_end;
@@ -1299,17 +1301,23 @@ static int clear_ce_flags_dir(struct index_state *istate,
 			break;
 	}
 
-	/*
-	 * TODO: check pl, if there are no patterns that may conflict
-	 * with ret (iow, we know in advance the incl/excl
-	 * decision for the entire directory), clear flag here without
-	 * calling clear_ce_flags_1(). That function will call
-	 * the expensive path_matches_pattern_list() on every entry.
-	 */
-	rc = clear_ce_flags_1(istate, cache, cache_end - cache,
-			      prefix,
-			      select_mask, clear_mask,
-			      pl, ret);
+	if (pl->use_cone_patterns && orig_ret == MATCHED_RECURSIVE) {
+		struct cache_entry **ce = cache;
+		rc = (cache_end - cache) / sizeof(struct cache_entry *);
+
+		while (ce < cache_end) {
+			(*ce)->ce_flags &= ~clear_mask;
+			ce++;
+		}
+	} else if (pl->use_cone_patterns && orig_ret == NOT_MATCHED) {
+		rc = (cache_end - cache) / sizeof(struct cache_entry *);
+	} else {
+		rc = clear_ce_flags_1(istate, cache, cache_end - cache,
+				      prefix,
+				      select_mask, clear_mask,
+				      pl, ret);
+	}
+
 	strbuf_setlen(prefix, prefix->len - 1);
 	return rc;
 }
-- 
gitgitgadget

