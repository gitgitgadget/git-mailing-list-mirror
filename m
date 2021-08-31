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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4FDC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14EFF600CD
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbhHaC1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbhHaC1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 22:27:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403AC0613D9
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t15so18889475wrg.7
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FrzIdksY4AjZzPbnmJBtr6bMZRBR7+W1zkHxlVTT4B0=;
        b=B2bBspu9zTqmt4OkYxbdefrGgeXbbAFA7rC5mptMtRXaHjrbylrZGXuaeBxZ93l8lK
         XE9ioQ/B+hwo5VPqsydk6bbKvL+pIkYPFKfwk8xedoCnJOhyaqgRMlMQDrrn8gCzqF4s
         gJ416jc1UbeCPPX/25iiBlev+9q3t4RV6TI7CU8TLYKHYp7zBNYgyB6xJqpQg05FSMSR
         Y0sMIbIJwaMMx+GQ34L0kvJ6GtFoBrMQmSE+kS3AWeZ3ebPa/1r+SGWmZFf1GQcZCCow
         MYmfVzIkYuIH9mNe9TP6OnllBKVK23M8Q18smPQOSTN6U/qcIkwH9xBvFnDPmIm8fCqR
         zELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FrzIdksY4AjZzPbnmJBtr6bMZRBR7+W1zkHxlVTT4B0=;
        b=nI81XPmrGIrGWHZmYQNRCpcS9Tiiot0Ge0PgybNHjSURytQLr2E/OyT30bwLPX0em9
         CNnkDAOC943r8cjSBEpI0EgRv/au/46sGuMa0XTTv5GoHiNHedfRkKdfSqqrPmdrwQ3b
         FdnT5rk3AgTddYPqy9Y1EYquDEVw4cVkvJcuDOnsZWbJNCvQK0g59ZWK9cnl3SSftvy8
         chRbdtQ35eLG4LkBfyNCGPaIh7FOVOVm01/KFCerSbXy+kDzuvHtMIQ/u/CYUe7j/s4k
         ucFe7dX1WHuobN6IsoQYR3jn9Rhp4Fsz1K+i1YLUAjRLv2rCVEir6varOHVQuQIKR69f
         1a9A==
X-Gm-Message-State: AOAM531pFLzIagUNcU8hDEKNM+3rY+OLwbGPgLE7gV9lqqJo1y52zNKZ
        tuCAAnIi4/jcpTar7ck0M3WbcWfKWzI=
X-Google-Smtp-Source: ABdhPJxiYjktmhq+2LfS6AEsz/ukNEFMkN9j0V5XF34azKAUH5e+hq/HJRAb8HKbnbL4o0DP8MJz6g==
X-Received: by 2002:adf:c449:: with SMTP id a9mr28005458wrg.256.1630376803334;
        Mon, 30 Aug 2021 19:26:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm1093487wmq.45.2021.08.30.19.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 19:26:43 -0700 (PDT)
Message-Id: <2bf5efb5169b71ee7c1da006a74aa67794f1399d.1630376800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 02:26:36 +0000
Subject: [PATCH 3/7] ll-merge: add API for capturing warnings in a strbuf
 instead of stderr
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Whenever ll-merge encounters a binary file, it prints a warning to
stderr.  However, for the --remerge-diff option we want to add, we need
to capture all conflict messages and show them in a diff instead of
dumping them straight to stdout or stderr.  Add some new API that will
allow us to capture this output and display it in our preferred method.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 ll-merge.c | 51 +++++++++++++++++++++++++++++++++++++++------------
 ll-merge.h |  9 +++++++++
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index 261657578c7..4d5bdc12464 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -11,11 +11,13 @@
 #include "run-command.h"
 #include "ll-merge.h"
 #include "quote.h"
+#include "strbuf.h"
 
 struct ll_merge_driver;
 
 typedef int (*ll_merge_fn)(const struct ll_merge_driver *,
 			   mmbuffer_t *result,
+			   struct strbuf *warnings,
 			   const char *path,
 			   mmfile_t *orig, const char *orig_name,
 			   mmfile_t *src1, const char *name1,
@@ -51,6 +53,7 @@ void reset_merge_attributes(void)
  */
 static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   mmbuffer_t *result,
+			   struct strbuf *warnings,
 			   const char *path,
 			   mmfile_t *orig, const char *orig_name,
 			   mmfile_t *src1, const char *name1,
@@ -59,6 +62,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   int marker_size)
 {
 	mmfile_t *stolen;
+	const char *msg = "Cannot merge binary files: %s (%s vs. %s)";
 	assert(opts);
 
 	/*
@@ -71,8 +75,11 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 	} else {
 		switch (opts->variant) {
 		default:
-			warning("Cannot merge binary files: %s (%s vs. %s)",
-				path, name1, name2);
+			if (warnings) {
+				strbuf_addstr(warnings, "Warning: ");
+				strbuf_addf(warnings, msg, path, name1, name2);
+			} else
+				warning(msg, path, name1, name2);
 			/* fallthru */
 		case XDL_MERGE_FAVOR_OURS:
 			stolen = src1;
@@ -98,6 +105,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 
 static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			mmbuffer_t *result,
+			struct strbuf *warnings,
 			const char *path,
 			mmfile_t *orig, const char *orig_name,
 			mmfile_t *src1, const char *name1,
@@ -114,7 +122,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	    buffer_is_binary(orig->ptr, orig->size) ||
 	    buffer_is_binary(src1->ptr, src1->size) ||
 	    buffer_is_binary(src2->ptr, src2->size)) {
-		return ll_binary_merge(drv_unused, result,
+		return ll_binary_merge(drv_unused, result, warnings,
 				       path,
 				       orig, orig_name,
 				       src1, name1,
@@ -138,6 +146,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 
 static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 			  mmbuffer_t *result,
+			  struct strbuf *warnings,
 			  const char *path,
 			  mmfile_t *orig, const char *orig_name,
 			  mmfile_t *src1, const char *name1,
@@ -150,7 +159,7 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 	assert(opts);
 	o = *opts;
 	o.variant = XDL_MERGE_FAVOR_UNION;
-	return ll_xdl_merge(drv_unused, result, path,
+	return ll_xdl_merge(drv_unused, result, warnings, path,
 			    orig, orig_name, src1, name1, src2, name2,
 			    &o, marker_size);
 }
@@ -180,6 +189,7 @@ static void create_temp(mmfile_t *src, char *path, size_t len)
  */
 static int ll_ext_merge(const struct ll_merge_driver *fn,
 			mmbuffer_t *result,
+			struct strbuf *warnings,
 			const char *path,
 			mmfile_t *orig, const char *orig_name,
 			mmfile_t *src1, const char *name1,
@@ -362,13 +372,14 @@ static void normalize_file(mmfile_t *mm, const char *path, struct index_state *i
 	}
 }
 
-int ll_merge(mmbuffer_t *result_buf,
-	     const char *path,
-	     mmfile_t *ancestor, const char *ancestor_label,
-	     mmfile_t *ours, const char *our_label,
-	     mmfile_t *theirs, const char *their_label,
-	     struct index_state *istate,
-	     const struct ll_merge_options *opts)
+int ll_merge_with_warnings(mmbuffer_t *result_buf,
+			   struct strbuf *warnings,
+			   const char *path,
+			   mmfile_t *ancestor, const char *ancestor_label,
+			   mmfile_t *ours, const char *our_label,
+			   mmfile_t *theirs, const char *their_label,
+			   struct index_state *istate,
+			   const struct ll_merge_options *opts)
 {
 	struct attr_check *check = load_merge_attributes();
 	static const struct ll_merge_options default_opts;
@@ -401,11 +412,27 @@ int ll_merge(mmbuffer_t *result_buf,
 	if (opts->extra_marker_size) {
 		marker_size += opts->extra_marker_size;
 	}
-	return driver->fn(driver, result_buf, path, ancestor, ancestor_label,
+	return driver->fn(driver, result_buf, warnings, path,
+			  ancestor, ancestor_label,
 			  ours, our_label, theirs, their_label,
 			  opts, marker_size);
 }
 
+int ll_merge(mmbuffer_t *result_buf,
+	     const char *path,
+	     mmfile_t *ancestor, const char *ancestor_label,
+	     mmfile_t *ours, const char *our_label,
+	     mmfile_t *theirs, const char *their_label,
+	     struct index_state *istate,
+	     const struct ll_merge_options *opts)
+{
+	return ll_merge_with_warnings(result_buf, NULL, path,
+				      ancestor, ancestor_label,
+				      ours, our_label,
+				      theirs, their_label,
+				      istate, opts);
+}
+
 int ll_merge_marker_size(struct index_state *istate, const char *path)
 {
 	static struct attr_check *check;
diff --git a/ll-merge.h b/ll-merge.h
index aceb1b24132..a5469918ad4 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -96,6 +96,15 @@ int ll_merge(mmbuffer_t *result_buf,
 	     struct index_state *istate,
 	     const struct ll_merge_options *opts);
 
+int ll_merge_with_warnings(mmbuffer_t *result_buf,
+			   struct strbuf *warnings,
+			   const char *path,
+			   mmfile_t *ancestor, const char *ancestor_label,
+			   mmfile_t *ours, const char *our_label,
+			   mmfile_t *theirs, const char *their_label,
+			   struct index_state *istate,
+			   const struct ll_merge_options *opts);
+
 int ll_merge_marker_size(struct index_state *istate, const char *path);
 void reset_merge_attributes(void);
 
-- 
gitgitgadget

