Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7642C63697
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6BE20825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmFwWoOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgKLWoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbgKLWoY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:24 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27316C0617A6
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:24 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 10so6589588wml.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bz9lu4KR1QtqDHPJDnigt1VO4YxcG7gdelylATP60/I=;
        b=qmFwWoOnR1Zu0SMRSiZqTNY3fhdf0zTFIOezLZavBpunWJdo0oGyxmwVjNLJuKVC1o
         El0O3xVqEwUcAQulzpAlSJX5XBKrkcn0r7m0p3KV2VUW7E7eidf7016OlY7azrlABaI2
         oicIeKS2dYNElHCCEQBUpXt6EUl9xT64XDK6JtAl77PM/fg2YOXzOzojw9K1eBCE/FbD
         KGPpJwum5GAL/DtHxDnkxm8j6diTOCgf3IYxrA8Vb7ydSp8XWIKLtJaYbPoxsgjq0EXs
         zP/AQxcit1i3ifn93W9Vi9VUcDwSELn7sMMqYQsG/sRMSY/nVXJAoEZyBMTtP3Jq+qvq
         ZoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bz9lu4KR1QtqDHPJDnigt1VO4YxcG7gdelylATP60/I=;
        b=dB7TGIQGC4KWbddQPp+38tivfTAdoR/NcptHME8YwWSFZ7e5aaCriXWVjx3GxczE45
         w9drEfR5wo7qBcEf0SgvxnrBtEUG4abE15BPTte6ZHvcRzIK4olyX0xYjGmzNiS85fL0
         1LxUKQXrwCrU5kZjh71/GubLGGY/PO6umL+mA2O4wQZQKuaKnzPoPum/8o/M5CcAedHc
         5WrlGgiJrmn5VuCp5YIBHXofPsQjv7XXhs8a9HDn4hMBC9JHkNSJ/Z71Mftw0OIobGYg
         rDUDpiSBvahyLdkgofieYBzReVHXtTKtihRCEpStqk5BC6v34hpGd5zOyUwM49uwhx6z
         E8RA==
X-Gm-Message-State: AOAM530ps2ep8CbEOCzyAVtl+wMi/eQuGAlXugjU3DfAfUyB2saONbNS
        WSF/UHNIRcQnt97jEBO+g+dA/PLgkTg=
X-Google-Smtp-Source: ABdhPJyt8a1IejOSJaKVb+bVKXVO+GirS1xueWWHOXWaQfS7G6LvYIQ+400ft2rHCftFqa0AoxMxRw==
X-Received: by 2002:a1c:5946:: with SMTP id n67mr64587wmb.162.1605221062821;
        Thu, 12 Nov 2020 14:44:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12sm8858519wro.72.2020.11.12.14.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:22 -0800 (PST)
Message-Id: <f853fa946f5840518577584a5b8c51660da06928.1605221040.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Don Goodman-Wilson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:58 +0000
Subject: [PATCH 28/28] Change the default branch name to `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Don Goodman-Wilson <don@goodman-wilson.com>

The current default name for the initial branch is a loaded term, and
many Open Source projects renamed their principal branches already. A
common choice appears to be `main`.

Let's follow their lead and change the default of `init.defaultBranch`.

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Don Goodman-Wilson <don@goodman-wilson.com>
---
 refs.c                    | 2 +-
 t/lib-submodule-update.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 392f0bbf68..5576a90573 100644
--- a/refs.c
+++ b/refs.c
@@ -575,7 +575,7 @@ char *repo_default_branch_name(struct repository *r)
 		die(_("could not retrieve `%s`"), config_display_key);
 
 	if (!ret)
-		ret = xstrdup("master");
+		ret = xstrdup("main");
 
 	full_ref = xstrfmt("refs/heads/%s", ret);
 	if (check_refname_format(full_ref, 0))
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index bd3fa3c6da..1b0abcb0f8 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -144,7 +144,7 @@ create_lib_submodule_repo () {
 		git checkout -b valid_sub1 &&
 		git revert HEAD &&
 
-		git checkout "${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}"
+		git checkout "${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-main}"
 	)
 }
 
-- 
gitgitgadget
