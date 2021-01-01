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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF89C4332D
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F132620799
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbhAACgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbhAACgN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:36:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B872C06179B
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g185so8374623wmf.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qAYm3lIoZOWgkgmupGAToxGB30CYGq9eTWjDA19TrNY=;
        b=H9GjO220FiTrFrgZTvaPPs4WBFVyhnyvOCTxPBz9cBLWA5V0ppwKyq8C3VQEyYaQr7
         NoXMiQRf8Qo1wqq1U6ciTC+3tr9BCGVm6fqjocqwikdnZrtIRuc04mTfr79TJzTpsKfR
         Z9ZKZOOBgqUrEI++Uk4yRSqsWeggWtb6QIK48timvfthq9CWQNFhvVU6kMrQMQ9JF/Nu
         MH63lXVhkUh9MhBts+jn8/zHIUFQQNB/Xr12+bCMPl96XQ1o4EEK5y4omcmnPHnSLzA7
         ssuSvpUKNsvDg47gBezMNkIu27T5h3AF2+KeLjzmvVHk0GrOchXqxzl+AG5AKwq46rjN
         /rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qAYm3lIoZOWgkgmupGAToxGB30CYGq9eTWjDA19TrNY=;
        b=dxCdKP58gSu9JjmOR6hE4OSEG0GuR3w69MIq8d3EZq1uwGfylOhTv9fZmsT9/UhHXw
         ZrJw/sAN3PhZf8k49Ibt1x4wUlNpnWe0dUTro1Ez/4NyvHM/UfofhfI42pKpvlWpLrmi
         788vDqE8aJ5EJArP4CVHfkzTM/jvcY0aSsnAgg8JZzdiMVPmSvkTTkISLy6DIGppXwG9
         lUwCndxxmLgqKRNTcW5vEisM3piPFuN1mpztfF7DtnEJuG1C4zSxPZeawdMlEFSD1PL2
         JiXdqvUmOdEdjSQzuBZKMP2YKcbFWfeuV4XAYjRmbCE4pr1sFturZce7C+ltVb5hirKi
         1cAQ==
X-Gm-Message-State: AOAM533VYigS2LqHODuFrAGTB8GJKbBWIj3K9pDTxtCUazOj3GoWsFhB
        af92oHKcTXY/EeWPOIDSZFH6jk9VZrg=
X-Google-Smtp-Source: ABdhPJwqCi+ocyeerM/k3cDdd8p98vGkRN5YzBeD3FcHE0KIXT99ZQem0AUCkdSOjFfNgZt552CkSw==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr13912706wmm.80.1609468494827;
        Thu, 31 Dec 2020 18:34:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7sm14655908wmh.2.2020.12.31.18.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:34:54 -0800 (PST)
Message-Id: <d1cc76ac620151e3d8c71b6b0b5fe6ed65c170c3.1609468488.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
        <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 02:34:44 +0000
Subject: [PATCH v2 06/10] merge-ort: copy and adapt merge_3way() from
 merge-recursive.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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

