Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4903C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90522065C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="surR2svp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbgEMX4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 19:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732456AbgEMX4g (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 19:56:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE15C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 16:56:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so28348329wmk.5
        for <git@vger.kernel.org>; Wed, 13 May 2020 16:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6fu8mvFgIPri2yjzwlTqm2KAPf+Zjbjgq0k0bIGVt2Y=;
        b=surR2svpMgMrj7QRAVpRo+xdcX33yavepCeJAEpq3NxeAcw45SdsPLk6Vk7IsOARoA
         8oRbOeDHwZJ5RnGKZAs+cXsn4Esux+c+JDwRtPbnaZA1Xf3UgC2SJkAwc9Ye2QCI8rQp
         46mCL6mUhsJRbNiJ4qpPAaM9Y//BGgIFpp5MCjgSfRCp08mG+0npo8bV6ZMJcTWtXso6
         p+uSv1IrXc1bp4iC3C4yxCMhrjsM4nV9AXxZS824adbo85z9ZaGuIYlScG5NEIhWUCCn
         X6YqvsH02XWt45RYtwKcFZGL8eg6oCgXVxEKMqJE/knZbtDZbZUWr9dGXzrB49foYvKw
         j+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6fu8mvFgIPri2yjzwlTqm2KAPf+Zjbjgq0k0bIGVt2Y=;
        b=gxWyPPiz71xzkyW5bcGWTYSv1gbXH0XKVK7gD4F7q6BuA9IFVrF95GEGc58hNjsjzf
         vg61fizYTBsfcGv1otRSGCWZ8Doyvlvcntl6IYrrt3Q2ndxWAWjJdUW7ZUju39JcVhGT
         KRdkxD9bG8iZiwlZuBg0yT7fsK/C3gtBvcZB9iNySBsw6zl8QXBX5z5C2H8z+UILJcO2
         SzkY24telREnXBtT+fxHsf39sXDp0cuunY7QpDvq4RkaRvm47umwXbxg+1PQF5RKA+oA
         TTlb84dfuz7+iTAuMMp93o3L/eKwH8IjCUI1224832gyop0nomNqcEqLSPJm0ohrN0oK
         +Xiw==
X-Gm-Message-State: AGi0PuZePpvLhcco9wU07D3yOzZ7/kOVB4iCyPFtjZ1WhBHzwsrxSQHL
        /4csruyfd5gVzPFYLlvcxFRNknZr
X-Google-Smtp-Source: APiQypL3orsxEieIyml8saynLDe7/HT2tiWF/0kCsC8S6B6xSnHiqA2yw2LuyOVdrWos6exO+HTBZQ==
X-Received: by 2002:a7b:c927:: with SMTP id h7mr44894216wml.122.1589414194132;
        Wed, 13 May 2020 16:56:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 77sm1632484wrc.6.2020.05.13.16.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 16:56:33 -0700 (PDT)
Message-Id: <pull.784.git.git.1589414193064.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 May 2020 23:56:32 +0000
Subject: [PATCH] merge-recursive: fix rename/rename(1to2) for working tree
 with a binary
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

With a rename/rename(1to2) conflict, we attempt to do a three-way merge
of the file contents, so that the correct contents can be placed in the
working tree at both paths.  If the file is a binary, however, no
content merging is possible and we should just use the original version
of the file at each of the paths.

Reported-by: Chunlin Zhang <zhangchunlin@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-recursive: fix rename/rename(1to2) for working tree with a binary
    
    rename/rename(1to2) is unique among our conflict resolutions in that it
    tries to put the as-merged-as-possible contents into two different
    paths, so I think this should be the only code path that needs an update
    for this issue.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-784%2Fnewren%2Frr1to2-binary-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-784/newren/rr1to2-binary-v1
Pull-Request: https://github.com/git/git/pull/784

 merge-recursive.c                    | 12 ++++++
 t/t6042-merge-rename-corner-cases.sh | 55 ++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index d92e2acf1ed..36948eafb75 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1750,6 +1750,18 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 			return -1;
 	}
 
+	if (!mfi.clean && mfi.blob.mode == a->mode &&
+	    oideq(&mfi.blob.oid, &a->oid)) {
+		/*
+		 * Getting here means we were attempting to merge a binary
+		 * blob.  Since we can't merge binaries, the merge algorithm
+		 * just takes one side.  But we don't want to copy the
+		 * contents of one side to both paths; we'd rather use the
+		 * original content at the given path for each path.
+		 */
+		oidcpy(&mfi.blob.oid, &b->oid);
+		mfi.blob.mode = b->mode;
+	}
 	add = &ci->ren2->dst_entry->stages[flip_stage(3)];
 	if (is_valid(add)) {
 		add->path = mfi.blob.path = b->path;
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index b047cf1c1c3..f163893ff97 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -1379,4 +1379,59 @@ test_expect_success 'check nested conflicts from rename/rename(2to1)' '
 	)
 '
 
+# Testcase rename/rename(1to2) of a binary file
+#   Commit O: orig
+#   Commit A: orig-A
+#   Commit B: orig-B
+#   Expected: CONFLICT(rename/rename) message, three unstaged entries in the
+#             index, and contents of orig-[AB] at path orig-[AB]
+test_setup_rename_rename_1_to_2_binary () {
+	test_create_repo rename_rename_1_to_2_binary &&
+	(
+		cd rename_rename_1_to_2_binary &&
+
+		echo '* binary' >.gitattributes &&
+		git add .gitattributes &&
+
+		test_seq 1 10 >orig &&
+		git add orig &&
+		git commit -m orig &&
+
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv orig orig-A &&
+		test_seq 1 11 >orig-A &&
+		git add orig-A &&
+		git commit -m orig-A &&
+
+		git checkout B &&
+		git mv orig orig-B &&
+		test_seq 0 10 >orig-B &&
+		git add orig-B &&
+		git commit -m orig-B
+
+	)
+}
+
+test_expect_success 'rename/rename(1to2) with a binary file' '
+	test_setup_rename_rename_1_to_2_binary &&
+	(
+		cd rename_rename_1_to_2_binary &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 &&
+
+		# Make sure the index has the right number of entries
+		git ls-files -s >actual &&
+		test_line_count = 4 actual &&
+
+		git rev-parse A:orig-A B:orig-B >expect &&
+		git hash-object orig-A orig-B >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done

base-commit: b994622632154fc3b17fb40a38819ad954a5fb88
-- 
gitgitgadget
