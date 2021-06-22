Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69B0C48BC2
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833E6611C1
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFVA3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhFVA3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 20:29:35 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E9AC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:27:19 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so19642661otl.0
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NDqEm2E2qA0ujhZbG6OpuXTvXRUI80SKfLBuDzOX4KE=;
        b=m/qVmnb+OAG70WosHch3WP6U65jbAzpCllY3h6nyzWxmVeiq7VxWAFhICJ5K62s3Mp
         YLiuTvh6y7kTeuHxd+UawksE7v2K2qBl4DCp4CzseE0FAYjXDGaySUkRs5GMBDKXyXFn
         idsAnAlFcO0VnVb+tgrtESlR25cHBzdSx/UdU7MztJUrwInOuIFeXbwrEbMDcumduAYk
         NIjye/4pqaA0PQEz68D+ZIk1cXe48uCXKhc4j87aFHncFOJ1f7HhPTKLgf0BrAkhClNR
         +J1bKy/KTAJxWeGYMn/r6cRURbFKxCIOgCMzdNaToMUwZC1MlY++3+INQYA233CRZb5B
         XsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDqEm2E2qA0ujhZbG6OpuXTvXRUI80SKfLBuDzOX4KE=;
        b=Voh/PBW0gBPE86ddPKIpn4N40MIHnlHBcrG9V9ctyrbnXRMfTaz3UgCQjno6y1wXNB
         ggA06ZEzu0P2D/dmb90IZKKOSOKnkJWjVvopHW5aU4Ts1V7ti6d5kaN3Hj9b8A/m9sCi
         +sWNpfpbVfzVRgUorfNr8bUPPI0LUMdr8yHjMp4Dinm53Z2OWe/eVdMY07lbmEtf8Bxt
         DL31ScZF4MN+joE9tHYcGMzACnBE9dW0kEKR0nQPyqybEv89oDtyXQesTYUHZODY/iLF
         g4/CDcvOObvCsKs1Cw+hU14d/PeHHMa1YypcwmGQEyPRYUsciAPUlkbjsX0OcxL1X5jL
         WU6g==
X-Gm-Message-State: AOAM533ehqPEdFeVZIIivcTVWcsC3K8wL4rjUn/MsoEgDYhDO7tvY6Fw
        zVlW/2Y5g7ShUBHsyytCjD74VK/NdsK6Bw==
X-Google-Smtp-Source: ABdhPJwUCK7B5qzlcMfysmoxqs7vPKPobc62ihY7Cclf/CA81DhF+WKApm0hs30+f6AejY6ET/tjXw==
X-Received: by 2002:a9d:6244:: with SMTP id i4mr648835otk.136.1624321638805;
        Mon, 21 Jun 2021 17:27:18 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id g1sm161187ooi.34.2021.06.21.17.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:27:18 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/4] merge-tree: fix merge.conflictstyle handling
Date:   Mon, 21 Jun 2021 19:27:12 -0500
Message-Id: <20210622002714.1720891-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210622002714.1720891-1-felipe.contreras@gmail.com>
References: <20210622002714.1720891-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently it's completely ignored.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge-tree.c               |  4 ++++
 t/t6440-config-conflict-markers.sh | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index de8520778d..7d677bd75c 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -7,6 +7,8 @@
 #include "blob.h"
 #include "exec-cmd.h"
 #include "merge-blobs.h"
+#include "config.h"
+#include "xdiff-interface.h"
 
 static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
 
@@ -378,6 +380,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	if (argc != 4)
 		usage(merge_tree_usage);
 
+	git_config(git_xmerge_config, NULL);
+
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
index 813d7dda9a..cb2ee3ad0a 100755
--- a/t/t6440-config-conflict-markers.sh
+++ b/t/t6440-config-conflict-markers.sh
@@ -34,4 +34,25 @@ test_expect_success 'merge' '
 	)
 '
 
+test_expect_success 'merge-tree' '
+	test_create_repo merge-tree &&
+	(
+		cd merge-tree &&
+
+		test_commit initial initial-file initial &&
+		test_commit r content r &&
+		git reset --hard initial &&
+		test_commit l content l &&
+
+		git merge-tree initial r l >actual &&
+		! grep "^+|||||||" content &&
+
+		git -c merge.conflictstyle=diff3 merge-tree initial r l >actual &&
+		grep "^+|||||||" actual &&
+
+		git -c merge.conflictstyle=merge merge-tree initial r l >actual &&
+		! grep "^+|||||||" content
+	)
+'
+
 test_done
-- 
2.32.0

