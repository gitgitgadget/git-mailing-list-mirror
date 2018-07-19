Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E8D1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbeGSTlA (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:41:00 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:44560 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbeGSTlA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:41:00 -0400
Received: by mail-ua0-f201.google.com with SMTP id d22-v6so3173368uaq.11
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=EDAmwXDMssiB6dZkE/wv0++GuEbc98HEbtoruGFhpcQ=;
        b=c13xhj8qXAh6OR5DRPBmyPAn1OzzwFKBB1ML01RaychPDy5VMwLUwoR8bTeHACN+h+
         vNyes7+zZSTwXFPayqbqBoB0N6w+qQNLVyIxM00SNHCMyZBooi/3h4eilkthx4yXK9cN
         7BHuNpB8WH8+rpLyKxr1WEgxUGHtS/PG3nNmDAAEpf8dnW2F3LQecDU0XPJ7sCDH2wJM
         C5WJOXt9Xaip2TkghMD0gLH9fK5twxm9Tey2bIz8sHhXiVcebjtqMpOMDTZ3OP6DD5fD
         W/Y4Dzvi9LMrD9NpmMO4rdGE08r6xd4oXpdGrwGvfz9wkU/63l3uxGdxqr0QLfXYi4Ay
         /Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=EDAmwXDMssiB6dZkE/wv0++GuEbc98HEbtoruGFhpcQ=;
        b=q8swntE3Ipkhq/v3OzK99U2YOjyANQkVgIG8Gsu97ibr7cYtTsAgnZUdUKq6nOxeh7
         XV9gRRGFk/fBVbTakXcTdKp1LxLJGiFpNu3/kjUHfPYujJyyDLa6aNaw/mjLOgYjTQUJ
         vQVDn6w6uPB3NBljq1Fa+I9gPIfa5YLAWnVwGC42c2Fxa4JXceTAY0NHeqsZk5lzoVQN
         lopHsUyHU+6gUc9kKJh9CXWxUhhvTNKbtPsj6yEkm6EHCnYcW/Bb39GXB9sQ40y7cCR/
         YJI2a3u4eQJmwnIuyJmuMZSBNLll9lTDHj5E7b/aPUw+X20U5gwQ6c2Zo4uFhO6RyqaY
         Iy7A==
X-Gm-Message-State: AOUpUlGQfKoMeauBBidVwwSc1xrzzHzYsdUEujAMna9yw/euT4kSpIgf
        bO8OvkEmpUEnH6ISUY7hNNFPnuZNyhrKqG6dwBv5438QUPbi2+vRbC/RS/0Bu9SbJjN+5I8iJ1/
        AE03js/wzhqOJKzaWMjzTuhTY52E9CxHPzLzKa5lUGNrbDq/CABQNYsGmWSFp
X-Google-Smtp-Source: AAOMgpf57gfsK21cZlCI/rGY59MnciZFq+4K9wf4TjV6kJktcx/T0EY29FP16zkSWLuNRkhmsI0Prfi9fJHo
MIME-Version: 1.0
X-Received: by 2002:a1f:cec3:: with SMTP id e186-v6mr5123122vkg.16.1532026591761;
 Thu, 19 Jul 2018 11:56:31 -0700 (PDT)
Date:   Thu, 19 Jul 2018 11:56:20 -0700
In-Reply-To: <20180719185620.124768-1-sbeller@google.com>
Message-Id: <20180719185620.124768-4-sbeller@google.com>
References: <20180719185620.124768-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 3/3] xdiff/xhistogram: move index allocation into find_lcs
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a memory issue when recursing a lot, which can be reproduced as

    seq 1   100000 >one
    seq 1 4 100000 >two
    git diff --no-index --histogram one two

Before this patch, histogram_diff would call itself recursively before
calling free_index, which would mean a lot of memory is allocated during
the recursion and only freed afterwards. By moving the memory allocation
(and its free call) into find_lcs, the memory is free'd before we recurse,
such that memory is reused in the next step of the recursion instead of
using new memory.

This addresses only the memory pressure, not the run time complexity,
that is also awful for the corner case outlined above.

Helpful in understanding the code (in addition to the sparse history of
this file), was https://stackoverflow.com/a/32367597 which reproduces
most of the code comments of the JGit implementation.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xhistogram.c | 96 +++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 43 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 5098b6c5021..fc2d3cd95d9 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -251,44 +251,13 @@ static inline void free_index(struct histindex *index)
 	xdl_cha_free(&index->rcha);
 }
 
-static int find_lcs(struct histindex *index, struct region *lcs,
-	int line1, int count1, int line2, int count2) {
-	int b_ptr;
-
-	if (scanA(index, line1, count1))
-		return -1;
-
-	index->cnt = index->max_chain_length + 1;
-
-	for (b_ptr = line2; b_ptr <= LINE_END(2); )
-		b_ptr = try_lcs(index, lcs, b_ptr, line1, count1, line2, count2);
-
-	return index->has_common && index->max_chain_length < index->cnt;
-}
-
-static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
-	int line1, int count1, int line2, int count2)
+static int find_lcs(xpparam_t const *xpp, xdfenv_t *env,
+		    struct region *lcs,
+		    int line1, int count1, int line2, int count2)
 {
+	int b_ptr;
+	int sz, ret = -1;
 	struct histindex index;
-	struct region lcs;
-	int sz;
-	int result = -1;
-
-	if (count1 <= 0 && count2 <= 0)
-		return 0;
-
-	if (LINE_END(1) >= MAX_PTR)
-		return -1;
-
-	if (!count1) {
-		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
-		return 0;
-	} else if (!count2) {
-		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
-		return 0;
-	}
 
 	memset(&index, 0, sizeof(index));
 
@@ -326,8 +295,52 @@ static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
 	index.ptr_shift = line1;
 	index.max_chain_length = 64;
 
+	if (scanA(&index, line1, count1))
+		goto cleanup;
+
+	index.cnt = index.max_chain_length + 1;
+
+	for (b_ptr = line2; b_ptr <= LINE_END(2); )
+		b_ptr = try_lcs(&index, lcs, b_ptr, line1, count1, line2, count2);
+
+	if (index.has_common && index.max_chain_length < index.cnt)
+		ret = 1;
+	else
+		ret = 0;
+
+cleanup:
+	free_index(&index);
+	return ret;
+}
+
+static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
+	int line1, int count1, int line2, int count2)
+{
+	struct region lcs;
+	int lcs_found;
+	int result = -1;
+
+	if (count1 <= 0 && count2 <= 0)
+		return 0;
+
+	if (LINE_END(1) >= MAX_PTR)
+		return -1;
+
+	if (!count1) {
+		while(count2--)
+			env->xdf2.rchg[line2++ - 1] = 1;
+		return 0;
+	} else if (!count2) {
+		while(count1--)
+			env->xdf1.rchg[line1++ - 1] = 1;
+		return 0;
+	}
+
 	memset(&lcs, 0, sizeof(lcs));
-	if (find_lcs(&index, &lcs, line1, count1, line2, count2))
+	lcs_found = find_lcs(xpp, env, &lcs, line1, count1, line2, count2);
+	if (lcs_found < 0)
+		goto out;
+	else if (lcs_found)
 		result = fall_back_to_classic_diff(xpp, env, line1, count1, line2, count2);
 	else {
 		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
@@ -341,18 +354,15 @@ static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
 						line1, lcs.begin1 - line1,
 						line2, lcs.begin2 - line2);
 			if (result)
-				goto cleanup;
+				goto out;
 			result = histogram_diff(xpp, env,
 						lcs.end1 + 1, LINE_END(1) - lcs.end1,
 						lcs.end2 + 1, LINE_END(2) - lcs.end2);
 			if (result)
-				goto cleanup;
+				goto out;
 		}
 	}
-
-cleanup:
-	free_index(&index);
-
+out:
 	return result;
 }
 
-- 
2.18.0.233.g985f88cf7e-goog

