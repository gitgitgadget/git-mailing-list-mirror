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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0240DC433FE
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65DC22D74
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393987AbgLMIG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLMIFv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:05:51 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17CFC06179C
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:34 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k10so11037738wmi.3
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hxJ/gDnigE+oShEMEjtNoVPaR5vzW1LmOaQbRYfF+nQ=;
        b=ZtdEFoz2t4+xXZeeBFRBFlluvmL8R9q9kLQwrG8sIpT2VdPZY+kHPcVo1KBVVGVBzO
         6q4gFqqjINLbZFUjpHfGw2O6fFFg01ItD34ej6lD+xTdrP8SnmN6t99gizySZ1QlaZO/
         WnPzkzNIlDifH5ksPOaGncFrdBhXtKFBmYsRbXNmcqO6ICL4UT1QMJ7qAsxqt/Pn/uas
         yl/mXigBi0n2ImcB7oZh2nidKcpcDt9SMFpuCmd/j5HLwOFbhWQnT1wEjvFgGqdosUub
         zlWVB9Esb8Orx7sW/PpUs67lTDjUFisVZ5lWW+k76PQuT0MKiP1jYAppE2yr/n5FBntD
         8IYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hxJ/gDnigE+oShEMEjtNoVPaR5vzW1LmOaQbRYfF+nQ=;
        b=iTgeyR/xpc3KB+C4lr+GY5tJgojef/t4BOy6O/2Jv3DtjBvau/x5yAKXR1bvGPqxuW
         B6x7PSDh8dzwEBQFNSzzebAh42YoQ8U0o37tslRP07lzgoaVhPorQgIsMUEqc94zRt3I
         KAybN9kC0jOVpWeGRb09sar4euYwKYGPKw+c4mBbRRKf82AfS12KhG2Fi39bVsHPqef4
         A7CqBdashB7pL00kKFX/kvJgFXT7XBTrQZM03YhBnh81Um1jkXG+DkGDWRJfJIJW94UX
         AIBp9Boo0fIE2WHt4ZxRTJNaAIBebzn475CL4UyzINZ9L4rd9PkpYdH/hWZOwOsTmWtK
         ig1Q==
X-Gm-Message-State: AOAM532v31YpiJGjFwhLAIWBWb7UV5J5ydFreeK1P9ElAypi77wwMv7f
        HJ4TsV5tN2L+kXXtjtPrHgMjNlMhgy0=
X-Google-Smtp-Source: ABdhPJz2uHMzq327X4PY8bDAis6NxkB+TR4G6479AjL/G1QyBQSvFasclVS2IrlYd3QDzogHTtE0rw==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr21585903wmc.139.1607846673438;
        Sun, 13 Dec 2020 00:04:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y68sm26493533wmc.0.2020.12.13.00.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:32 -0800 (PST)
Message-Id: <95143bebf09aba6a6dc985b0b33f76e633761115.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:12 +0000
Subject: [PATCH v3 05/20] merge-ort: add an err() function similar to one from
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

While we are at it, also add more documentation for the "clean" field
from struct merge_result, particularly since the name suggests a boolean
but it is not quite one and this is our first non-boolean usage.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 31 +++++++++++++++++++++++++++++--
 merge-ort.h |  9 ++++++++-
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 85942cfa7c7..76c0f934279 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -168,12 +168,27 @@ struct conflict_info {
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
 
@@ -276,7 +291,19 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
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
diff --git a/merge-ort.h b/merge-ort.h
index 74adccad162..55ae7ee865d 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -7,7 +7,14 @@ struct commit;
 struct tree;
 
 struct merge_result {
-	/* Whether the merge is clean */
+	/*
+	 * Whether the merge is clean; possible values:
+	 *    1: clean
+	 *    0: not clean (merge conflicts)
+	 *   <0: operation aborted prematurely.  (object database
+	 *       unreadable, disk full, etc.)  Worktree may be left in an
+	 *       inconsistent state if operation failed near the end.
+	 */
 	int clean;
 
 	/*
-- 
gitgitgadget

