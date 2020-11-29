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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0026C3E8C5
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC6C207CD
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YULWrSGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgK2Hor (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgK2Hor (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:44:47 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4C0C061A47
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:32 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t4so10781122wrr.12
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vwIVPxVU+l+Pw5Bx9zlRbW7ky00OhooiBwH+telTYaI=;
        b=YULWrSGnGwg0t64X3TsxbqGd1B0DtIXlm+hfBqU4nrBTU3l1VssRbc/ji6s3G03CN9
         VwI3bq/ED+6ABr+q1U21jMM/JAfDGVeRmRdr9EXTNr+Fj0FJNVP2Rq6M1ZmwSpPptbQJ
         B6krYQ0kM6YyejS/Dl66S1/qqWJJTcVaxdUItjwU7L/RShz26kpLMc5ifWdVo94+o2d+
         2TzmNvzULBCSb085JlveaWG08iSVS1UhBlGXkAfstDZOs42LfvRiIrxQvHQvnfSKLdaB
         yf7EZnY9pBrrgTnv2yMcsNDZ/miD4U1diwanQyRzQa8/ijiFmKZgrN5zi2DwjkYkUdxs
         Jw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vwIVPxVU+l+Pw5Bx9zlRbW7ky00OhooiBwH+telTYaI=;
        b=DirKfGPTL4yAP/xG1wjchmQwWkaw+FbLRLbEuSKu2N0nwSGRYlAdOvb6JZSy6Fm+Qo
         WqtYgAUK/qq/SHi8P865tCh+Zwv82b/r8aWo8I9Yj6kXkSnJSeP8UUlTk0O+lJsXm+Df
         uPTsbPkY+F7sCXGS/epErtO6NpSCkGpL1GkW4cLYG3L/2yLv+8m5h97tpHFpH9JQ69qv
         PUWhBKV6I/8w8Ol7B9PqzcGO8BqhK99EWxj61son2rYznMPp9G5C4ACr1GdEAV11nJK4
         w3ytWsebz/rAy+zGUBNnks0WB1zNgY7/fQPTthopNeR3x5J7cN4PDnFf3GmeyXDH6ZH9
         8Wxg==
X-Gm-Message-State: AOAM531zQtHaGv47Pk26ztlnW8MLophHUzIxSY1Z/ZdmFoa9HV+mJKBf
        A2+o/5ZbHfjS4jst/0n5CvJoA5mRArI=
X-Google-Smtp-Source: ABdhPJy8egLY0SormjxkEFnYUXUyZgALNHrariQD+AL/2kekuThYExb4Q6K8VZS0Q3KwsUpyTOtYoA==
X-Received: by 2002:adf:d84b:: with SMTP id k11mr21293619wrl.305.1606635811153;
        Sat, 28 Nov 2020 23:43:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm18773030wmh.44.2020.11.28.23.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:30 -0800 (PST)
Message-Id: <bff758c5ddd3ac49690143fd935f6b29fb687485.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:10 +0000
Subject: [PATCH 07/20] merge-ort: avoid repeating fill_tree_descriptor() on
 the same tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Three-way merges, by their nature, are going to often have two or more
trees match at a given subdirectory.  We can avoid calling
fill_tree_descriptor() on the same tree by checking when these trees
match.  Noting when various oids match will also be useful in other
calculations and optimizations as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index a3096876d4..820809f67e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -196,6 +196,15 @@ static int collect_merge_info_callback(int n,
 	unsigned mbase_null = !(mask & 1);
 	unsigned side1_null = !(mask & 2);
 	unsigned side2_null = !(mask & 4);
+	unsigned side1_matches_mbase = (!side1_null && !mbase_null &&
+					names[0].mode == names[1].mode &&
+					oideq(&names[0].oid, &names[1].oid));
+	unsigned side2_matches_mbase = (!side2_null && !mbase_null &&
+					names[0].mode == names[2].mode &&
+					oideq(&names[0].oid, &names[2].oid));
+	unsigned sides_match = (!side1_null && !side2_null &&
+				names[1].mode == names[2].mode &&
+				oideq(&names[1].oid, &names[2].oid));
 
 	/* n = 3 is a fundamental assumption. */
 	if (n != 3)
@@ -248,10 +257,19 @@ static int collect_merge_info_callback(int n,
 		newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
 
 		for (i = 0; i < 3; i++) {
-			const struct object_id *oid = NULL;
-			if (dirmask & 1)
-				oid = &names[i].oid;
-			buf[i] = fill_tree_descriptor(opt->repo, t + i, oid);
+			if (i == 1 && side1_matches_mbase)
+				t[1] = t[0];
+			else if (i == 2 && side2_matches_mbase)
+				t[2] = t[0];
+			else if (i == 2 && sides_match)
+				t[2] = t[1];
+			else {
+				const struct object_id *oid = NULL;
+				if (dirmask & 1)
+					oid = &names[i].oid;
+				buf[i] = fill_tree_descriptor(opt->repo,
+							      t + i, oid);
+			}
 			dirmask >>= 1;
 		}
 
-- 
gitgitgadget

