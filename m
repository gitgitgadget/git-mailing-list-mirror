Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2B4C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 04:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhLNEJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 23:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbhLNEJT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 23:09:19 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B48C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:19 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o29so13390469wms.2
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yJd7W6b5EpJPKt/oCPU9gfNGc/DAmWzP/z3eqsEVutI=;
        b=gW87z1HUFl3u7QzwWVe9KB0ygB5UYBUdbt8s8kt81qCVcwPgUmapUawSpQxUMqtucU
         sWYPhYWCPPc7MkQyF0Bgox1KaNELbWwJ9BJKcy1SAtrPtV9cc+WXC1h7qEOzvQTe5acN
         pEFjjM0jYqxPhFdA66xMSp4Qq8JER/uPrlLObUb/OKv/Kjo26+2jdzO3KkpoJ47lG1C8
         1JZiAogOdNCnolcmaM5dExZDWsIsHfD4U32xpGsmgtiudBGKmJDf6xBZihnauv+L74UI
         uGMYR/OtU0g4bcdzixOgVcnnIt0aAeZLfiuXIKpAzHwpexsF08Btc9+snF7KSIy0C+fN
         kXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yJd7W6b5EpJPKt/oCPU9gfNGc/DAmWzP/z3eqsEVutI=;
        b=f+VdQhwAtvAJBysjot+P16foLG1XHfTE2J5lol3Z1bkWiCFgSz6ErA+w8CBa9NTy+u
         RzFwUGm9g2PkfwfTojOJ9i17zUxDAUcW3DSm8+G2CTm7GyXjglcSCUpFSa4c2CJv+aYv
         2dToxWDTW9iF2v6sDc/THs55WOE1wwaO0bwf5Lxl0HK9dxJ3Uxw0rGqrAfNS3P5Ld6AZ
         gZoa27mGReLE2czYYAN0CkOWWGAffjjTeYqNyNpbTtm2wJe1N0fuWjpUuzb3WVfBrWYL
         dvF+j54HV/j/Fxzk1hcTeDPlwnYJmxRcV0KC2Ojr1mSOoWxFVK4G78Uuy6kmRlpjVUKB
         P2QQ==
X-Gm-Message-State: AOAM533fzIWen09eNbiH2jHROeKzyQszSbnG0HPILiFrT/F/E6txeSob
        NWmAqJ2cU5umTZboJjK5HcO7F2QxsoA=
X-Google-Smtp-Source: ABdhPJzkot28zgGW8KGZAuIt5MO82xtcu9GzMTA6AOIKz4DabbD4wGA6PnkPmikSkQ8R0BTufn0NUw==
X-Received: by 2002:a1c:741a:: with SMTP id p26mr20507149wmc.133.1639454957319;
        Mon, 13 Dec 2021 20:09:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm1581139wmf.2.2021.12.13.20.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:09:17 -0800 (PST)
Message-Id: <09b13280c2619e9dcbf33422c5dcfba84f0e52be.1639454952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
        <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 04:09:09 +0000
Subject: [PATCH v4 07/10] sparse-checkout: enable reapply to take
 --[no-]{cone,sparse-index}
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Folks may want to switch to or from cone mode, or to or from a
sparse-index without changing their sparsity paths.  Allow them to do so
using the reapply command.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 16daae84975..0dae44c5759 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -759,13 +759,22 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 }
 
 static char const * const builtin_sparse_checkout_reapply_usage[] = {
-	N_("git sparse-checkout reapply"),
+	N_("git sparse-checkout reapply [--[no-]cone] [--[no-]sparse-index] "),
 	NULL
 };
 
+static struct sparse_checkout_reapply_opts {
+	int cone_mode;
+	int sparse_index;
+} reapply_opts;
+
 static int sparse_checkout_reapply(int argc, const char **argv)
 {
 	static struct option builtin_sparse_checkout_reapply_options[] = {
+		OPT_BOOL(0, "cone", &reapply_opts.cone_mode,
+			 N_("initialize the sparse-checkout in cone mode")),
+		OPT_BOOL(0, "sparse-index", &reapply_opts.sparse_index,
+			 N_("toggle the use of a sparse index")),
 		OPT_END(),
 	};
 
@@ -777,6 +786,13 @@ static int sparse_checkout_reapply(int argc, const char **argv)
 			     builtin_sparse_checkout_reapply_usage, 0);
 
 	repo_read_index(the_repository);
+
+	reapply_opts.cone_mode = -1;
+	reapply_opts.sparse_index = -1;
+
+	if (update_modes(&reapply_opts.cone_mode, &reapply_opts.sparse_index))
+		return 1;
+
 	return update_working_directory(NULL);
 }
 
-- 
gitgitgadget

