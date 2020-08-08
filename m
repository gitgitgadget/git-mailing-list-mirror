Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56754C433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33162206CD
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BquvkSw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHHRBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 13:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgHHRBc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 13:01:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B003C061A2A
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 10:01:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so4434463wrw.1
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sPbkpRFPeiKiOvBBVU6Y21sP3wGJKwK6VHh3lRk+/So=;
        b=BquvkSw4ERVHIy0zHQlZJcZCAkzKV60pXr2rrAmkj1Tr9Rgq4fCFFU8gLy6vxJ/MU8
         fDHJEnYMRIdw5UB/mc3dGv1ydnC6S100JPmzmust9WDBrI2pJW12+QtS9GXH6hbc7jJG
         /mVFDCMkcRvqwaRcwJTkdREJZChvW61as7icykDERPFMR5dG4d1u40zpJ2/y8xd617Lz
         DotD4C4/qgAVZo1DliwtgRVBdAwRFDEDY6FuzoHoe4x7bGHG1FlyXF8aUacg7aypdcLJ
         P0xP1FDm+PAwOsq8FpkIU/ZxFmkq6eyCfJsKIQf+XKHG26OC0LGm7TyopbPsae/ORZvv
         gDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sPbkpRFPeiKiOvBBVU6Y21sP3wGJKwK6VHh3lRk+/So=;
        b=jgInD0nWB29NufiKlBwE4bVCcT/xYCeeIM+WejshC6eBo3vA+3Pxbe5YQAoTTWWu7P
         aRHPr4sm4oq7ivGrLYQ/RgIszqhpcsASdKk3T6magSNbOD4axKLMC8Wh7Ew5nxJEmGFq
         llytigqZYqixpikVRvWNe9uE6GdMucs0BXgC5jis0dWP2GLA1btk2YYUFaLK8sNdHmNO
         kCk51SEQwL2qzFE2Kym/4VPy7QmRIb4tovgiMsbanx8pSX9f7Eyc6vF+1g9Bn+026qCE
         BlnuMAl4dshaFkwog+EYFYbohM4fQiZW5//2e+iDKG0oOJBDUTM5+DrG75AGWgv2uCu4
         /OBw==
X-Gm-Message-State: AOAM532qZ7nR1HQX0uWdsAzCTnwMudy/JjGci86ljb7D9q1E/ewjRWXQ
        Uzs2pGaqBaFA7gdit/K7Ipd+Trwk
X-Google-Smtp-Source: ABdhPJyq4cXxXKZsWs12GXkBO1H5Hx+DxcJXBn2z5K0qWgCVc+ygALDrh0NAP8EN9Xdz9b6f2J1ljQ==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr17296748wrw.155.1596906089721;
        Sat, 08 Aug 2020 10:01:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm13985855wmc.28.2020.08.08.10.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 10:01:29 -0700 (PDT)
Message-Id: <f2d7e744fcd6ef24b8cfdbd837e61c420b0712f7.1596906081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
References: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
        <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Aug 2020 17:01:17 +0000
Subject: [PATCH v2 08/11] t6423: add an explanation about why one of the tests
 does not pass
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

While we're at it, document why one of the two tests doesn't pass (since
I had long since forgotten it)...though the reasoning makes me question
why it's considered a failure at all.  Maybe I had a good reason when I
introduced it, or maybe I just wasn't looking at it clearly?  Either
way, the explanation may help a future reader.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index bd0f17a3be..2b4a482277 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -2843,6 +2843,14 @@ test_expect_success '9f: Renamed directory that only contained immediate subdirs
 #   Commit A: priority/{alpha,bravo}/$more_files
 #   Commit B: goal/{a,b}/$more_files, goal/c
 #   Expected: priority/{alpha,bravo}/$more_files, priority/c
+# We currently fail this test because the directory renames we detect are
+#   goal/a/ -> priority/alpha/
+#   goal/b/ -> priority/bravo/
+# We do not detect
+#   goal/   -> priority/
+# because of no files found within goal/, and the fact that "a" != "alpha"
+# and "b" != "bravo".  But I'm not sure it's really a failure given that
+# viewpoint...
 
 test_setup_9g () {
 	test_create_repo 9g &&
-- 
gitgitgadget

