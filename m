Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08977C433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 05:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhLaFEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 00:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhLaFEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 00:04:09 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C450EC06173E
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r17so54148111wrc.3
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RTMDaNQNW5XOLHlSbnpT5fYlMKYQXeA7CHqMfX/3ZoA=;
        b=ALZV6wfoNL8kaJMJXeL8/JlUAndA3GCCttUXwxiTIHx7+YxkjwO8UOEZ05l/GeZlQo
         Tj8IJOaeJIS16rCCr8an4TRmDOy4hjbgTOLySjdIdOiQYFeibg2vrkqwhmiMLcaq8VDD
         RoNOVS70Rc6O+EE+AHsz68pIZabR5M3qoGZpDrnInrRQpKdR1dr0P8fneqe/RwRrhrTC
         az0sc9DERrXLQpEqxj6nWnUPyC8+0JQ+N1UE6c7Fa2tdXQ3C0udipSqDrbyTZHiRRm5G
         oHiH2bmbltCdO4VOLNch8qPEGpQbCFNLYQyEe5DHpJBue20q17vHKJLUxnRAZ8aMGUiw
         j9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RTMDaNQNW5XOLHlSbnpT5fYlMKYQXeA7CHqMfX/3ZoA=;
        b=UPxWGT+dOSzV49aIsSmznckvsE7+szoHD17oLUHSZmkgbj2gbM3yOc3FW9idnFiOxf
         3vdwU8tx4sOQ/aQb4FWXMNmbwusWco5/HZ3lGehSyeG7coaOJK8SSe2TW/zD2vUFYpNX
         u+LSQUbiPUXGN0tRkvV7nMKmq55zG8oLU7sNo6TFzbvxIrYmMFxNdv8+S04UIQGRlBtT
         El5unM6MhGewN1kLFdh/FiAkEFLT2mqNgI7rHgjFvDH88AoWNL1P03oRkReSGoSinL6/
         1KtF5SlYO7N1XHS7GDGOv5+/iP+ItFMkQNc8dM3LdF/mVPSemhkAigbtZcy92GhZjw+Z
         Kpxw==
X-Gm-Message-State: AOAM532PduZ/rKkB2XUYA8jhimDDy/yQtXrk2NjiNqCX6dojg8FbfFEq
        /aE86/VYP09gEbEyEr8lsyjLL2jV844=
X-Google-Smtp-Source: ABdhPJxGWzl/CKU83L9PlriSq6dU5t9mUdZoMFiVY3QyI7Xd1fRUReFFaMAnCyhLxzdG7GJBywdfXA==
X-Received: by 2002:a5d:64a9:: with SMTP id m9mr28013601wrp.143.1640927047236;
        Thu, 30 Dec 2021 21:04:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd19sm27726634wmb.23.2021.12.30.21.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 21:04:06 -0800 (PST)
Message-Id: <9da8e77c1d7c3645fdad74080c0093f420dcfef4.1640927044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 05:03:58 +0000
Subject: [PATCH 2/8] merge-tree: move logic for existing merge into new
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In preparation for adding a non-trivial merge capability to merge-tree,
move the existing merge logic for trivial merges into a new function.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 06f9eee9f78..9fe5b99f623 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -366,15 +366,11 @@ static void *get_tree_descriptor(struct repository *r,
 	return buf;
 }
 
-int cmd_merge_tree(int argc, const char **argv, const char *prefix)
-{
+static int trivial_merge(int argc, const char **argv) {
 	struct repository *r = the_repository;
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
 
-	if (argc != 4)
-		usage(merge_tree_usage);
-
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
@@ -386,3 +382,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	show_result();
 	return 0;
 }
+
+int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+{
+	if (argc != 4)
+		usage(merge_tree_usage);
+	return trivial_merge(argc, argv);
+}
-- 
gitgitgadget

