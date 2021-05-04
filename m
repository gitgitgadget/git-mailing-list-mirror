Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7772AC433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5924B61090
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhEDCNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 22:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhEDCNS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 22:13:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8428C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 19:12:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l13so5968105wru.11
        for <git@vger.kernel.org>; Mon, 03 May 2021 19:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zXSwx3+sF61LG1Vzw98++skHdpw2Mzzq9AIj1bC/DAg=;
        b=toN9pYwEhQHZMHuIvbLQAEmckSkRP5niGReBp/rQaHLDqj9S6fq2/10fYypV3Z1lpa
         rn0doOQe53aFdVQ3XeVy0+vMy+RU82mlUyS0dRtUKgEDi0yRLWPxxedHxqVKgSvmgKQ5
         MwvWkbDQBs9O9x4iq1xrXyylTKh3B1BRDMKWWINZ/ffPPiEsFMLQpH3C4S3NsDpjaP54
         yOkbmnWgKM+atpBISlO8deKGme4tvYadmrpTnPhXzJfxGhrxxWDCG8pCTShwrS6TJ2HT
         B5d+GR2+egaMB/3XVfRJAPs/WmjC14i5dd6V62To3iZWecP/apDVPR9qN5fQmPRtw4mw
         AseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zXSwx3+sF61LG1Vzw98++skHdpw2Mzzq9AIj1bC/DAg=;
        b=Mxd18zOOeA3v20mXXymgCx0XpuLeO0Mc4uusXKd+PIXO+ENXEbG0fOZS6E/GwH9xzR
         iV2F9v+Qq5Sn3kWnJl+epW35vml8P+f7mU3jUjDyImnZHC0MdhmP8K/21k2X+qQCP2I1
         TXczsnh+txu1NoHWG/mK28g8vBc7o4GqNvx+mbr4yKpERaZOJ8MI3kHo/hxvINhQnW/9
         TI1zZlqhutqPUGzrSizawieXd9eO5S+uOHpIOjAMWEi5or7dbbsAhj2XxHaa2TAqZsar
         KojGBDpC0cyu8zClN0zF3Y8+gT8T+3i5D/A3MIBzuMI7Trp0gZVSSCkGQ2q9+ZlfQLEg
         QRyg==
X-Gm-Message-State: AOAM5322+g7aBlZ+gf11p6nPtLsZTBthZn+RdvofYHtXjbFEi13N9xBF
        ikz8wHIV0CGtDzUZ4jKO2KhPehim8zM=
X-Google-Smtp-Source: ABdhPJx30mX48RDYnycq5qbWNJ3qLvAgFx/90BS5JDKBgVf1/BLJxxOYBdGYkntM/45UfxVQmLCIzA==
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr28803432wrx.82.1620094342697;
        Mon, 03 May 2021 19:12:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm5348516wrp.47.2021.05.03.19.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 19:12:22 -0700 (PDT)
Message-Id: <129136a10c9d37c9cd3d875dfbbd91c452c37554.1620094339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
        <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 02:12:07 +0000
Subject: [PATCH v2 01/13] t6423: rename file within directory that other side
 renamed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add a new testcase where one side of history renames:
   olddir/ -> newdir/
and the other side of history renames:
   olddir/a -> olddir/alpha

When using merge.directoryRenames=true, it seems logical to expect the
file to end up at newdir/alpha.  Unfortunately, both merge-recursive and
merge-ort currently see this as a rename/rename conflict:

   olddir/a -> newdir/a
vs.
   olddir/a -> newdir/alpha

Suggesting that there's some extra logic we probably want to add
somewhere to allow this case to run without triggering a conflict.  For
now simply document this known issue.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 58 +++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 7134769149fc..be84d22419d9 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4966,6 +4966,64 @@ test_expect_success '12g: Testcase with two kinds of "relevant" renames' '
 	)
 '
 
+# Testcase 12h, Testcase with two kinds of "relevant" renames
+#   Commit O: olddir/{a_1, b}
+#   Commit A: newdir/{a_2, b}
+#   Commit B: olddir/{alpha_1, b}
+#   Expected: newdir/{alpha_2, b}
+
+test_setup_12h () {
+	test_create_repo 12h &&
+	(
+		cd 12h &&
+
+		mkdir olddir &&
+		test_seq 3 8 >olddir/a &&
+		>olddir/b &&
+		git add olddir &&
+		git commit -m orig &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		test_seq 3 10 >olddir/a &&
+		git add olddir/a &&
+		git mv olddir newdir &&
+		git commit -m A &&
+
+		git switch B &&
+
+		git mv olddir/a olddir/alpha &&
+		git commit -m B
+	)
+}
+
+test_expect_failure '12h: renaming a file within a renamed directory' '
+	test_setup_12h &&
+	(
+		cd 12h &&
+
+		git checkout A^0 &&
+
+		test_might_fail git -c merge.directoryRenames=true merge -s recursive B^0 &&
+
+		git ls-files >tracked &&
+		test_line_count = 2 tracked &&
+
+		test_path_is_missing olddir/a &&
+		test_path_is_file newdir/alpha &&
+		test_path_is_file newdir/b &&
+
+		git rev-parse >actual \
+			HEAD:newdir/alpha  HEAD:newdir/b &&
+		git rev-parse >expect \
+			A:newdir/a         O:oldir/b &&
+		test_cmp expect actual
+	)
+'
+
 ###########################################################################
 # SECTION 13: Checking informational and conflict messages
 #
-- 
gitgitgadget

