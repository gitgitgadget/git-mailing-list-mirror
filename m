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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1EDC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602FA22CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgLDUtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbgLDUtf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:35 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C539DC08C5F2
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:21 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id f190so8238618wme.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lKs/4/NmcQsdKxhykR0Z1o5EmnS1ZCM82SOYo5NY8Tc=;
        b=BWKxYiRDCkCh8E/BZoJbQcDhFnK09BRbskMXokqd6jjgSkyf0tNYQ57WQrSEFaJOno
         v2A8bThDC8FQPH/H1+zUOY/vQk6keGAH6xd4Ht/p1XdymL9OUJCIBh4EYd2b3x6YjE6A
         U6lAP1PG5MxBA9n9owka8YpmixNfUrcS1MP3s/KFfpbf3OXqtsj4h1zwEEAPTrL3azUV
         kiA81a0h2w8rpl+9TDb4SNU9bXD3haIkD9cGeCjnF5/yD+cNftcZXb2hllybxjjgfpup
         kfKFZCI3v8L4K/lOjgUGgvc2K1/jbdFUuxVoqx0CyRUNR7DvNhnS2v6bqgph7+TxtQFm
         ISQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lKs/4/NmcQsdKxhykR0Z1o5EmnS1ZCM82SOYo5NY8Tc=;
        b=NT8zSOT/rFPz5Vsw0wU5kdgFQA7CwC9T3Pr3m3S+eGbQSXADvFFTHi0fPKM1Wccvxp
         0MoKR08o6S1XW03+nutM8TU3yv207SVJUocIn1cI59sKRzifzXNCxLGwu7sd0YfHwjEB
         /YriwrvxRkIL5r3SzRcQuBZvNgsi/Ot8mk/DJMtVjIJJ0Hoee+xoI1c6JcUqvb+ZG26Q
         VMAbGnmtTTNMdi4SVRChHGUrJtax5pHKocJH4co8DSMO3q9Gg9rPXWRNjNraqNIHTKL0
         UQqtZ7bt8evCa/uPB7BEzwabUfgvPTTu4Ztk9Eqz77h9JAWojOIUZE83E/R2BRsQNEii
         4GGw==
X-Gm-Message-State: AOAM531GbuVmZ/FVjfWdQ2b7D2pTTiE/pQSDImNO0bEdfSLbSDDMmX2w
        Z1RfD/jM0bn5v1COGDg+WymwzqluFnw=
X-Google-Smtp-Source: ABdhPJzIpmBP3nLrRVKqKH47reS/cBvM0cWkfPAy4KTJ1Reg1ALITvOcMUhutNKpaoMOjVxmHRLXvg==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr6202555wmi.36.1607114900317;
        Fri, 04 Dec 2020 12:48:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm4860976wrq.38.2020.12.04.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:19 -0800 (PST)
Message-Id: <c6e5621c21040d7996551810238921f717400f08.1607114891.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:47:57 +0000
Subject: [PATCH v2 07/20] merge-ort: avoid repeating fill_tree_descriptor() on
 the same tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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
index 0c37f8bf52..ab3119d2d8 100644
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

