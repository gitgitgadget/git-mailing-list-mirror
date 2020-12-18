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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97CBC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9529523A5B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgLRFwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgLRFwv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:52:51 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3843C061257
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:35 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 3so1214329wmg.4
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qAYm3lIoZOWgkgmupGAToxGB30CYGq9eTWjDA19TrNY=;
        b=rH5d5M+NNqNGXqerywm2SA8NZ0nMOgy8gduh9GpeER6AFy3VaePmSiBg5hi5IGHCit
         J0uD8IIYgWTgQqAk+f7ia7bcxwBP1qAOa9IaT7b2cThvNulcBqQ+qc8jtSbPVz3D2IyP
         rXCvoapPP4cRfs5FvieXBBbiFGC4rDeq6fsIjNyHctSVCqZqsSj+6+j350LR7MaPZ9gV
         P4p+6MV3l+2BCmZ4KNnIMAy2NYdQ4NWWInPWEAqM9gBE9gf+WOg5i5UAsMe7Nyn0btVU
         d6rZUGMCh6QXn6d52lOv9lHrgC2ad4sGEoRUH+lRVdM7wYKjEyuzwWZ4Kz3ZQo5Rb27X
         HMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qAYm3lIoZOWgkgmupGAToxGB30CYGq9eTWjDA19TrNY=;
        b=htMsihpBlVdxwzeFvHT8g8Q8O7L7BHsOQPAd1TIcgQ1TATCBLENeTc+aErvdTg+vn/
         DbQ18HD4PgoppOgNYP739O472hzkVft0XqM+6Ut8Fe9pc81S4XrP9fD33sn9CMO3xb9T
         bOefuoQQasnwITXE8RVNTjLfikV32ycu1KAxy2anPc8CLvnSo8736JS0YZxf9dB5b/YR
         lpwh2dHg/5HRUr2R/Svi/HuW1W0C7SeRPHAYso8RCsysg9KFpX+YhdLQ3lZHMIegAzV3
         KVVFj3JheH1thgIsQdAzOdeyqVXY58qemCso8d4QKKPBVOTXs2QEjQvJKDAOpJcOVwcl
         Jekw==
X-Gm-Message-State: AOAM531MN8J/UAGIYbyUIxU+FN/yRPFO0RlVeQ8diUpiIxzOQXvJuI5J
        nHGn11RreJfoaGmqbECD7Cq36eJSuLQ=
X-Google-Smtp-Source: ABdhPJxS0uC1dOQlJorXKDsVinZz6qRykj9Aype6ymzQPNhHgbNdKYYNF2451r0anw9zsSZAquhslA==
X-Received: by 2002:a7b:c04c:: with SMTP id u12mr2545149wmc.185.1608270694262;
        Thu, 17 Dec 2020 21:51:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm10849849wmb.37.2020.12.17.21.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 21:51:33 -0800 (PST)
Message-Id: <611141f24af2c8d706fbf2dc6ef776ca61391e41.1608270687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.git.1608270687.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Dec 2020 05:51:23 +0000
Subject: [PATCH 06/10] merge-ort: copy and adapt merge_3way() from
 merge-recursive.c
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

Take merge_3way() from merge-recursive.c and make slight adjustments
based on different data structures (direct usage of object_id
rather diff_filespec, separate pathnames which based on our careful
interning of pathnames in opt->priv->paths can be compared with '!='
rather than 'strcmp').

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 2cfb7ffa3b0..a59adb42aa6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -23,6 +23,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "dir.h"
+#include "ll-merge.h"
 #include "object-store.h"
 #include "strmap.h"
 #include "tree.h"
@@ -650,7 +651,58 @@ static int merge_3way(struct merge_options *opt,
 		      const int extra_marker_size,
 		      mmbuffer_t *result_buf)
 {
-	die("Not yet implemented.");
+	mmfile_t orig, src1, src2;
+	struct ll_merge_options ll_opts = {0};
+	char *base, *name1, *name2;
+	int merge_status;
+
+	ll_opts.renormalize = opt->renormalize;
+	ll_opts.extra_marker_size = extra_marker_size;
+	ll_opts.xdl_opts = opt->xdl_opts;
+
+	if (opt->priv->call_depth) {
+		ll_opts.virtual_ancestor = 1;
+		ll_opts.variant = 0;
+	} else {
+		switch (opt->recursive_variant) {
+		case MERGE_VARIANT_OURS:
+			ll_opts.variant = XDL_MERGE_FAVOR_OURS;
+			break;
+		case MERGE_VARIANT_THEIRS:
+			ll_opts.variant = XDL_MERGE_FAVOR_THEIRS;
+			break;
+		default:
+			ll_opts.variant = 0;
+			break;
+		}
+	}
+
+	assert(pathnames[0] && pathnames[1] && pathnames[2] && opt->ancestor);
+	if (pathnames[0] == pathnames[1] && pathnames[1] == pathnames[2]) {
+		base  = mkpathdup("%s", opt->ancestor);
+		name1 = mkpathdup("%s", opt->branch1);
+		name2 = mkpathdup("%s", opt->branch2);
+	} else {
+		base  = mkpathdup("%s:%s", opt->ancestor, pathnames[0]);
+		name1 = mkpathdup("%s:%s", opt->branch1,  pathnames[1]);
+		name2 = mkpathdup("%s:%s", opt->branch2,  pathnames[2]);
+	}
+
+	read_mmblob(&orig, o);
+	read_mmblob(&src1, a);
+	read_mmblob(&src2, b);
+
+	merge_status = ll_merge(result_buf, path, &orig, base,
+				&src1, name1, &src2, name2,
+				opt->repo->index, &ll_opts);
+
+	free(base);
+	free(name1);
+	free(name2);
+	free(orig.ptr);
+	free(src1.ptr);
+	free(src2.ptr);
+	return merge_status;
 }
 
 static int handle_content_merge(struct merge_options *opt,
-- 
gitgitgadget

