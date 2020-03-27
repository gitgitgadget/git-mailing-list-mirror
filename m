Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0094C2D0EC
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7639206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riO6IS1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgC0AtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51789 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgC0AtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id c187so9836098wme.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9VVyl+Vdnkvmj6zrKAQbeNDIBw+QaEFYlwMoweYT/mY=;
        b=riO6IS1FX3D28lk6CSw1H4dD2c65R+5SglAUfpEOLssEpu9oIiEGaHYTsg6ZdqmxvV
         1cWsoRANqzXkdsfWvYFIl9r8q7XAEtburqeTKAyfSe8FSzduAOkzr5dk4nhB7wVDQWLa
         PN2OEWrTBAmkcwzSu1u0YvazrRdcF/EOe5asmNc0M+AUkXlx58MpcujsQ2AuqLNYXmmV
         UQ1fu87EBW+8ejRfo0q8CYvyc/c+gRBYsyW4zdz4vFWVBqm/3DxhHF6b1PVcJaGcBLkT
         b536BSXeksAIE7B6J5RmMytoB2D53TCrc2FkND/7swpknRgrS+WG80fhGcAuguqgtT8p
         hLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9VVyl+Vdnkvmj6zrKAQbeNDIBw+QaEFYlwMoweYT/mY=;
        b=DvPRLh5WIRUCBhfvanYejJx78uC5RFUd2SlodfI1xzuGlY2Eh3wsI57b9OcfyxH28Y
         vgJwhRBhvFbUtrV4OZMby+iEiKdS3Om3UebVuphrwLfIcZmYcklUAYHLDnRTLuXc8utm
         3i9v1Cmeu3WCl0F0qK70AtHzXr7hLDxa0nY4O3PJTvH8z3FS7aZaE1RXtEs9kxl5m0hi
         WTrijAKdzi+Y6VZFGtkqKnLzO0XfJnW15tZdN916a9+d6q+QUvpHjycpk72tqjWHwUzM
         N4E8StSoosiuIIpejviF4mAXoANbKhuLOBGYA+5tEcYTkYxwWsi+3+YRqWVG4oylHWCg
         P9MQ==
X-Gm-Message-State: ANhLgQ1gQndA8yLZ1sIqaAsLYQq6qG0HdrlV45xSv027Jnt/i+hoVCrY
        /7xKKvKFgobIME5eK2eMAslc3ACY
X-Google-Smtp-Source: ADFU+vvhwitDrvKWhkpAFYeJUvzAaUm4zF0lM79TP2Gn1z2zb6BAJtf3KivVZQLQiNug4J46hdL5xA==
X-Received: by 2002:a1c:b356:: with SMTP id c83mr2814428wmf.10.1585270151896;
        Thu, 26 Mar 2020 17:49:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k84sm5947629wmk.2.2020.03.26.17.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:11 -0700 (PDT)
Message-Id: <e9c7e8ec46f284d44c5c7451f1175cbf3d9ce622.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:54 +0000
Subject: [PATCH v3 11/18] sparse-checkout: use improved unpack_trees porcelain
 messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

setup_unpack_trees_porcelain() provides much improved error/warning
messages; instead of a message that assumes that there is only one path
with a given problem despite being used by code that intentionally is
grouping and showing errors together, it uses a message designed to be
used with groups of paths.  For example, this transforms

    error: Entry '	folder1/a
	folder2/a
    ' not uptodate. Cannot update sparse checkout.

into

    error: Cannot update sparse checkout: the following entries are not up to date:
	folder1/a
	folder2/a

In the past the suboptimal messages were never actually triggered
because we would error out if the working directory wasn't clean before
we even called unpack_trees().  The previous commit changed that,
though, so let's use the better error messages.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 2 ++
 t/t1091-sparse-checkout-builtin.sh | 6 ++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a55c60d7594..aa81199f85d 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -112,7 +112,9 @@ static int update_working_directory(struct pattern_list *pl)
 
 	repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
 
+	setup_unpack_trees_porcelain(&o, "sparse-checkout");
 	result = update_sparsity(&o);
+	clear_unpack_trees_porcelain(&o);
 
 	if (result == UPDATE_SPARSITY_WARNINGS)
 		/*
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index a991e0a80d5..9bc65d32f07 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -328,12 +328,10 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
 	echo dirty >dirty/folder1/a &&
 
 	git -C dirty sparse-checkout init 2>err &&
-	test_i18ngrep "error" err &&
-	test_i18ngrep "Cannot update sparse checkout" err &&
+	test_i18ngrep "error.*Cannot update sparse checkout" err &&
 
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
-	test_i18ngrep "error" err &&
-	test_i18ngrep "Cannot update sparse checkout" err &&
+	test_i18ngrep "error.*Cannot update sparse checkout" err &&
 	test_path_is_file dirty/folder1/a &&
 
 	git -C dirty sparse-checkout disable 2>err &&
-- 
gitgitgadget

