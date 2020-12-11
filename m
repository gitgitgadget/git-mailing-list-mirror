Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C06C2BB48
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6355923F38
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437429AbgLKJK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 04:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437398AbgLKJKN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 04:10:13 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F6C0617A7
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:58 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id i9so8227726wrc.4
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eRAhQFYeUrdX9pZ+F6hjVvCTkeVuTmB0eYXdB7dAjOA=;
        b=oF4MX3gmdMAG+Kf2c2YWhQN5MV+4U9dNnbD4txapPZbnsUH0O6P4+4SBhETFtXsYy8
         6E6rBaWXVEdU2WxMPyq1z1WnSoC9Zqhp1b0XWAiRVpIqOiSy8vuZUzgA97eGGruelSlB
         IXmlxFbvFj+myPsivrwOManwFjqrm9oTBGr4MUKwQHlrzeXc8qn7ABOshZCSEiZD3y1m
         g47KyHpG38Vn3N3Wu+rZplnhE/SkAeX/XwE0dfH0mzXXcfQnzwnyIe+h5u71HgqCS0Gk
         ow/PjojMuZK5/PESlt60WnpvO2gw5wCj6Mqouv3I0cN+M8CLvRaAf3gCzqncU1sZeQQx
         NQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eRAhQFYeUrdX9pZ+F6hjVvCTkeVuTmB0eYXdB7dAjOA=;
        b=AozuXVyNL48f3aV6dsXrTDKzphbip1SWuA57kq6CztTNhf1Uwwza8uu9LsE43+54su
         c/61qvD1giFCbSaeR9xi1nqm03f6XkCBSf+b3Kk4KoA1reqM6Yr7TGY33uyy+GuNvL9a
         nmO6SIj2g9e6KkT1vi5Sey4OslDwxKYvhInhi8ygp/+1S7Y4PaFffR/uOP2TRFizU6oB
         FiaUOtKC6jOYUeVVC4dC0+R0ckTY9qsSWxwuNtoa6jtC9nP1E+P5IDzvtzSeN5g+IaS2
         gDtVm6dbGJ/nWeIdQP8ZP4w37+6RLZIJBZZDooO6waNlTaMUReTZ8FGHgxEPjf56gu9I
         VmSg==
X-Gm-Message-State: AOAM532HMJmwtYVz9wbmzEAIh9rkix8Yh3/VX3Mlc3A+XPUUMJ8B3imA
        PoA1e7/K64jvvOCHPN/cMhQH0dbpLIY=
X-Google-Smtp-Source: ABdhPJwGYGRcVICQ6x4ZFabTrISY/50nDg+AahXjMh2p8MjX5xg95pyEqtE1Qh3Rj4qgqGItVIlsHA==
X-Received: by 2002:adf:e84c:: with SMTP id d12mr13250160wrn.382.1607677736653;
        Fri, 11 Dec 2020 01:08:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1sm13002574wrr.48.2020.12.11.01.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 01:08:56 -0800 (PST)
Message-Id: <a58639b2927fc9b51351d2d1da134a757c657723.1607677728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Dec 2020 09:08:46 +0000
Subject: [PATCH v2 7/9] diffcore-rename: simplify and accelerate
 register_rename_src()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
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

