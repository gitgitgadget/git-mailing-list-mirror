Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBF5C43381
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF9022209
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgL2UG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 15:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgL2UGY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 15:06:24 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B89C06179C
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t30so15640778wrb.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eRAhQFYeUrdX9pZ+F6hjVvCTkeVuTmB0eYXdB7dAjOA=;
        b=eCGLmvZZaZvf94hDS84A9/DirkkQRi2sc7j0XYMemfGutZhAV5tqqgHTyBzUAT0s6a
         8LRCkqxdLoWZQuGWRitY3LiI/a/vXccom7mzl8M+OCJo7kdBvRaIuyAJ+GI6A3lqcU1N
         y5bJ3wIjVGcE2uKz4IMLQCeFl+QTko3o+4zG0MjD55zBQb6QtSS8jWrOn9a+vrsWunXc
         hr7Y1ADwgZhrhdsBHiSjjgYTHGHdG5bxiiCNYEJ1jxF0Fwa9GEf6pebIr97t38coCPjZ
         hWys5aC4MjzhpTtt0LnhDszDwxwoBM/JCc19YRGhLFk8Rjbz83NBpxpLsvCgdJJt8ymG
         E8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eRAhQFYeUrdX9pZ+F6hjVvCTkeVuTmB0eYXdB7dAjOA=;
        b=aldfTgaacjUGFCwwIoIbs3rS9oh7n1Jqlj8xwZRmPrmbjkhpQea4vJgarABUvaQez0
         nGe4Q8NM0NUI1hrL6Nd8I9CPjkjhftH3CW33YsgYlNK81THPJUUSN5PDbOybE/cW8A3C
         Vo4BdydUoQ3mY2PEy7Nixd8yBdrNPHJIp6N9faYyJ7MlB0IpUELbWQhPcCoAI1kHzxru
         lRYSgJQ8TtFOJrLoF0v/aW4oENQG+OxcN1egvPAolYF8U41kPUUOZCUUbRWGHYX98scc
         3sTj2ktC7yMO64PVzr/sqIDnTH3d/15/wAYkpxpxbYkqIGo97nuyvmEEaXTlI/T4SFZq
         x9NQ==
X-Gm-Message-State: AOAM533bytXgDxOL5da9X6Oglz+0Amee/rPDweZmzaQQQUlofzgHiVxs
        QoCSKlHKGtpKLJx3k9F9Cd3mzkno8Ak=
X-Google-Smtp-Source: ABdhPJzFEwcxyJimhRRjLIc2rYJvAkmBhJLr5oW4w6YjVdaO8TG+bSYTl2fY4KsWOH/mKCPJcNbgRw==
X-Received: by 2002:adf:c403:: with SMTP id v3mr55934656wrf.55.1609272336222;
        Tue, 29 Dec 2020 12:05:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y130sm5005845wmc.22.2020.12.29.12.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 12:05:35 -0800 (PST)
Message-Id: <a58639b2927fc9b51351d2d1da134a757c657723.1609272328.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
References: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
        <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Dec 2020 20:05:26 +0000
Subject: [PATCH v3 7/9] diffcore-rename: simplify and accelerate
 register_rename_src()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

register_rename_src() took pains to create an array in rename_src which
was sorted by pathname of the contained diff_filepair.  The sorting was
entirely unnecessary since callers pass filepairs to us in sorted
order.  We can simply append to the end of the rename_src array,
speeding up diffcore_rename() setup time.

Also, note that I dropped the return type on the function since it was
unconditionally discarded anyway.

This patch is being submitted in a different order than its original
development, but in a large rebase of many commits with lots of renames
and with several optimizations to inexact rename detection,
diffcore_rename() setup time was a sizeable chunk of overall runtime.
This patch dropped execution time of rebasing 35 commits with lots of
renames by 2% overall.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 55a188abcc3..a215421a9cb 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -76,36 +76,23 @@ static struct diff_rename_src {
 } *rename_src;
 static int rename_src_nr, rename_src_alloc;
 
-static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
+static void register_rename_src(struct diff_filepair *p)
 {
-	int first, last;
-	struct diff_filespec *one = p->one;
-	unsigned short score = p->score;
-
-	first = 0;
-	last = rename_src_nr;
-	while (last > first) {
-		int next = first + ((last - first) >> 1);
-		struct diff_rename_src *src = &(rename_src[next]);
-		int cmp = strcmp(one->path, src->p->one->path);
-		if (!cmp)
-			return src;
-		if (cmp < 0) {
-			last = next;
-			continue;
-		}
-		first = next+1;
-	}
+	/*
+	 * If we have multiple entries at the same path in the source tree
+	 * (an invalid tree, to be sure), avoid using more more than one
+	 * such entry in rename detection.  Once upon a time, doing so
+	 * caused segfaults; see commit 25d5ea410f ("[PATCH] Redo
+	 * rename/copy detection logic.", 2005-05-24).
+	 */
+	if (rename_src_nr > 0 &&
+	    !strcmp(rename_src[rename_src_nr-1].p->one->path, p->one->path))
+		return;
 
-	/* insert to make it at "first" */
 	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
+	rename_src[rename_src_nr].p = p;
+	rename_src[rename_src_nr].score = p->score;
 	rename_src_nr++;
-	if (first < rename_src_nr)
-		MOVE_ARRAY(rename_src + first + 1, rename_src + first,
-			   rename_src_nr - first - 1);
-	rename_src[first].p = p;
-	rename_src[first].score = score;
-	return &(rename_src[first]);
 }
 
 static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
-- 
gitgitgadget

