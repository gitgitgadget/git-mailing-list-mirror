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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EA5C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB3BC610CC
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhETGLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 02:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhETGLG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 02:11:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBF7C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n2so16372501wrm.0
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zXSwx3+sF61LG1Vzw98++skHdpw2Mzzq9AIj1bC/DAg=;
        b=ZYXQRf4vU85754fwo1j8CGvb/43lj2pIo+I01z6hAxgeuxjyJ49LjQar/FBuG/DDDh
         TFS87h65dPazRXwyQxhPs8OcXCNcoEq7a9cu8sndUmLL2EH2pZjrFFWo6gBq26aHm00Y
         dZ0Jz0TaqcLt9RwE8BwS8lLqsqyLMIHvvzAgXWDnK8QNAnSve2wZUPKPCu5gP8oBX4UC
         sxspcjwYZq4jbxIFZoLA0pIknutaONZ3Je1x1bMtj4deYeLEna/TZH2VldMPj7ymbY/r
         Y09L7cnp3EEZlwbIWS4ArnOtziPgBsdcqGh6fBcDR/aKIDJ4wFkb6ycbcQjxFx0oDAaS
         m8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zXSwx3+sF61LG1Vzw98++skHdpw2Mzzq9AIj1bC/DAg=;
        b=tAfQa7uusBI8kkokRWTODTbkq68W/TG5i2lsSwnDpnc95aXpwKdfqu1eSimDpqSFKr
         QCX9SOqRZwrQ1qMKzUUtMNZWLAn6ua2RXg1iOp7D6tkc7J7Y1lyrOl5gGTxqhuVAzrbj
         JTUU95VIJL1dZOCkLPr93FeciJHnuN00HURmFRAeqDd6mH62z+pPPuw+4yO554F7c8xK
         7NRSY+lzBQEpWiJWzoSe2JUpuCTv8t3Bli6pYesOpRoIIwbfPQS/lWS0JYZNCTze4W/X
         CJ03qS8jH2oKzCojLt+46LN7qXOYbOy61pNFprAe86gJf+8TTcatcSpDQ8ldAjF+5wGp
         t7Sw==
X-Gm-Message-State: AOAM532jkOQ9DSdUcvJVmyatTGuV6En3BUPzmKMjB1eH6W6J3BSDYNQ+
        3sfDe2xLrx5IHcSLo9DWMkRrycT+IkA=
X-Google-Smtp-Source: ABdhPJyysehvv78uotmMPbIp544CBho2fbJPmLymOkbRrpekFEOxt35uIVeSUeWxZFLyigR1qTd9qg==
X-Received: by 2002:adf:c002:: with SMTP id z2mr2422152wre.100.1621490984291;
        Wed, 19 May 2021 23:09:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm1747097wrt.53.2021.05.19.23.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:09:43 -0700 (PDT)
Message-Id: <129136a10c9d37c9cd3d875dfbbd91c452c37554.1621490982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
        <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 06:09:29 +0000
Subject: [PATCH v3 01/13] t6423: rename file within directory that other side
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

