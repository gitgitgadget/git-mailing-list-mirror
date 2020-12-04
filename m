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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AC8C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D39722CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgLDUtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbgLDUtK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:10 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28AEC061A55
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:19 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c198so6591619wmd.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MAygxFzJxH6VuIUbTy5dbpWI5LMqtfnM4A8vTiQGh3o=;
        b=sv8foDz84MwPAZ2IuMTR+FZ/7RsiTRWEftlbcbAielR1Jg1BNQnG0vFhl/BRagudoj
         YOxdUj+KVqwAA/7WtI1jajLWqUaXiKFlDvsaKQIsZhDUbbPVPWIXXmkAG/ZcCdLBmxGA
         RUFdWsjjvPlCzNasR/MuO7ORqExQ4fAMLPWFRfithBRBaaWD7yLRTCuBr/DtUMXvWmsJ
         kcEcWIgghcqbGhta9HafE0rT1XG2AF2crXk0Xri6pxDmlVfdJsNVMfFER6oOO+zJ8qYu
         mAoj7D0JcBGvb1u78GMpMz0TkUtd8xG0YwN8ypjZELk98J/496XGOfrD8aTZ63E2GC30
         RJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MAygxFzJxH6VuIUbTy5dbpWI5LMqtfnM4A8vTiQGh3o=;
        b=ZXDdDnkmrXDPbzWNZpAV8YZe5j/+WdWScUaZC0qmcOfunRAiKKwPOD1K6XpGXtFvas
         C8uDUbHKeh4RITVqEU96xOB5XLSGiCV1O0INWqETgto7S4UOSk/1DkhJaCyvdYEc6XKH
         EmQWhLL2QoENq3DTeeWFNbDwzEDZ3QMhFtprSr1ej9bQYl7M+wBM3wZhNm1a0asgTcar
         Hf9uJzeQVho/dsnpQAux8tqaCU1v9kOL/Zs0aD0OtsjlFlV+W7ZtZ2BMjSJBJiatyI+r
         hbzFDY1dyrZv3kB7Bmt5br0xK1vu77SxYR35CavlK4Q10O2rh1lh+b7WQhxVR2zRTZag
         nWsw==
X-Gm-Message-State: AOAM530j20EcTjMS+0fE5v9RSR5oOjoZnTv4w9laiboRffs8CtTlFTCL
        osFzUvMKWNlUJzAA/nOnmNXayRgQZmU=
X-Google-Smtp-Source: ABdhPJxQtf17WrputJOJj/qJdp4JiFBBIWMFItdUiWL0pUvBRLPvWko8gIQAXPJ0kA25L7+Wflirjw==
X-Received: by 2002:a1c:a9c8:: with SMTP id s191mr6132615wme.89.1607114898208;
        Fri, 04 Dec 2020 12:48:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3sm4473945wma.3.2020.12.04.12.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:17 -0800 (PST)
Message-Id: <6c4c0c15b3d1283d817149181cdf88903926a52b.1607114890.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:47:55 +0000
Subject: [PATCH v2 05/20] merge-ort: add an err() function similar to one from
 merge-recursive
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

Various places in merge-recursive used an err() function when it hit
some kind of unrecoverable error.  That code was from the reusable bits
of merge-recursive.c that we liked, such as merge_3way, writing object
files to the object store, reading blobs from the object store, etc.  So
create a similar function to allow us to port that code over, and use it
for when we detect problems returned from collect_merge_info()'s
traverse_trees() call, which we will be adding next.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index ff305bcbe4..b056db6fc8 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -158,12 +158,27 @@ struct conflict_info {
 	unsigned match_mask:3;
 };
 
+static int err(struct merge_options *opt, const char *err, ...)
+{
+	va_list params;
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addstr(&sb, "error: ");
+	va_start(params, err);
+	strbuf_vaddf(&sb, err, params);
+	va_end(params);
+
+	error("%s", sb.buf);
+	strbuf_release(&sb);
+
+	return -1;
+}
+
 static int collect_merge_info(struct merge_options *opt,
 			      struct tree *merge_base,
 			      struct tree *side1,
 			      struct tree *side2)
 {
-	/* TODO: Implement this using traverse_trees() */
 	die("Not yet implemented.");
 }
 
@@ -266,7 +281,19 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 {
 	struct object_id working_tree_oid;
 
-	collect_merge_info(opt, merge_base, side1, side2);
+	if (collect_merge_info(opt, merge_base, side1, side2) != 0) {
+		/*
+		 * TRANSLATORS: The %s arguments are: 1) tree hash of a merge
+		 * base, and 2-3) the trees for the two trees we're merging.
+		 */
+		err(opt, _("collecting merge info failed for trees %s, %s, %s"),
+		    oid_to_hex(&merge_base->object.oid),
+		    oid_to_hex(&side1->object.oid),
+		    oid_to_hex(&side2->object.oid));
+		result->clean = -1;
+		return;
+	}
+
 	result->clean = detect_and_process_renames(opt, merge_base,
 						   side1, side2);
 	process_entries(opt, &working_tree_oid);
-- 
gitgitgadget

