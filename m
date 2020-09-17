Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFABC43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 08:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1977E2075B
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 08:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0XPDvVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgIQIGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIQIGe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 04:06:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53527C06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 01:04:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so704107plt.9
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lSr7ARXcAXEsxFWv36oBY4zjo1lQBNyRUq8qLSTjVHQ=;
        b=r0XPDvVnGFAUrEuiwjj/2FMe3uQboJPOqWZG0HgADfnT+Mu5yM9/mxV2IW8d1k8v3i
         4zvCHxEerdbTqDefctJoJmEs2cFoNYttxlsblw2xhcVywHC7M3RE69EGDilay9ZIGgXy
         wQbZ6Q4sQTqg6n+IwYmv7AY3ay4sOsrvMM/te8t65VcklWI/J7v23IvCzHYzjDW0MWAO
         /CHmFoaOkRxJRwq4CgMZ4RMUdK8hijfsajqY6tQwtCLDy8Vg6FMnOa2/bT1loTToKUlu
         GVSuSh8OqMA3ckqFgg/LttE0lg7dhbDjnahBUOEF7+s4lsZN+Xog+/SXfeHn73LYsE6H
         /kAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lSr7ARXcAXEsxFWv36oBY4zjo1lQBNyRUq8qLSTjVHQ=;
        b=ZOLQSV/uRahGal2DvbjLPSzZXnAiHDBSZp8FRMni9hS9Og7zTL1GcCSo8K167EmYND
         YupZ1p4pLfTb/IzGE7k8Di1V2HeVP1uBemUmWCFIh6I2Xw1vX8aYjXHgDL2I3LkI6kDx
         LBjANJ3HsY7ZmB5VU4auyoMuX2/P3/OXN43+OPNqv8GRPKYgo4mwbBkL/v2B5LGJM5PS
         lUVUHA6e5hi6B/RGcUA3UM7abFZ5tXe2eX7BBnvceLx8jsTbpRt5fKmUSud+AzEMFJVF
         0R7cYVBHx++0pAKlazyrd8qUVuQyArkWz7TiQDTmNbKwu2Gm3PMXJyvMdz5lFd7vAUaF
         u1VQ==
X-Gm-Message-State: AOAM531n04BRWRff6Xxj5X524Gkzy81m/ic2Rbbhxj5SrvL3fkwHJhlM
        Q46VcPuzsNDVNl2qD6+7iY/XYg2GV3glgg==
X-Google-Smtp-Source: ABdhPJxq03h5spS5MfSwJuBbN848yqdFEZrusnKFMfUR+oFcPqcLBpAz1RIv9hc13u35bEtLSVBBjw==
X-Received: by 2002:a17:90a:9742:: with SMTP id i2mr7385261pjw.195.1600329882653;
        Thu, 17 Sep 2020 01:04:42 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id y197sm5669422pfc.220.2020.09.17.01.04.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 01:04:41 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] contrib/completion: complete options that take refs for format-patch
Date:   Thu, 17 Sep 2020 01:04:36 -0700
Message-Id: <6b5eac1d20781eecbadf3c3b0c0e34b7cf57134b.1600329854.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The completion for format-patch currently suggests --base=, --interdiff=
and --range-diff= as options. However, with these `=` forms of the
options, there is no space and we'd enter the `--*` case which means we
don't call the __git_complete_revlist() at the end.

Teach _git_format_patch() to complete refs in the case of --base=,
--interdiff= and --range-diff=.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9147fba3d5..8be4a0316e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1784,6 +1784,10 @@ _git_format_patch ()
 			" "" "${cur##--thread=}"
 		return
 		;;
+	--base=*|--interdiff=*|--range-diff=*)
+		__git_complete_refs --cur="${cur#--*=}"
+		return
+		;;
 	--*)
 		__gitcomp_builtin format-patch "$__git_format_patch_extra_options"
 		return
-- 
2.28.0.618.gf4bc123cb7

