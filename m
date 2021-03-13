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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753FFC43381
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C37664EE4
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhCMWWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 17:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbhCMWWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 17:22:14 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645A6C061765
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:13 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e9so3736909wrw.10
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hfbIQ5ZMDbHAwrELzZGGk8AxVsHiSbiG/2xPriEsgMg=;
        b=M2T4ejO+2BE5UVa8cxcfAAlyHV5szLD+E6Yw0Y9Rox2mU/tQu1Woj3L0gLkHS12tUP
         BMdUZrNAB46cyfUJRYI0Pa76SlTjo4TIHioUw3QnWEOqkpjWCyuKnu3nIROsVXuTTv6M
         Lg/s2WEanXHI/bayBl5B//WVX7BcWQTGLw4M9PSS4Gxj6FfckbqVuAMbZGqyfGub6I/o
         msm9JwBDGS60yIklwQNPLNOI+CK1QL7l7tuKaftV6+SRDeP9/hcFD3+Ud9BrzVEmlg7l
         MDqy+yKzjsvKrd27B9rynjrlSEGmUc5CRa/yXjrOlangKzChZ6qv929UcxwMztyjqlWE
         Qqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hfbIQ5ZMDbHAwrELzZGGk8AxVsHiSbiG/2xPriEsgMg=;
        b=cKT7lFmYqD9L9UQp5bJZHNFP8VNa8TbFjgAtzRhx40GIF9quepCoBhVqL0rPPGbxfd
         mhHupQ7RCWnxqvdSB2tIHNQDfExYEcBg5n3uoSraKz2IuNlkPFBhn4RirYR0DRoWKoNN
         OSbdQnkyo6YVmf+FqBs1ZDDuobP3NWojxQOqGa9PeKmCGZgpepn27xaRKuFspTQaiveP
         HB/MdrLbdoiPPTeyeIMX6HH3SeKYBL5YDqv5TShm0qZs4fM9HTK3IiBdCB2jre7z/V8D
         GYtN8ZqKZxaYeEWvz0lbykaEWj4cP/67gBl/TFxZh5KL6QR2+4DozBoJpRrL+e52EH7c
         wZPQ==
X-Gm-Message-State: AOAM5302rpBXp0diLcrLMT58JLoHMeZ8eiwYlOSeQ/VBA22NbBvb+wmJ
        gTBP+/GEUvp4Kr3jw5pjKKH8mcchNLQ=
X-Google-Smtp-Source: ABdhPJxgyutvdbVLxL/zuBYb4uBmSzYslrySRPl6d2T7lc3KeFhXqmdzlo17NXohk0xLRqtV4eHahA==
X-Received: by 2002:a5d:4281:: with SMTP id k1mr20271529wrq.374.1615674132065;
        Sat, 13 Mar 2021 14:22:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm13273370wrx.79.2021.03.13.14.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 14:22:11 -0800 (PST)
Message-Id: <9e30f4399abefc8af005a2de97eefe692fdb4848.1615674128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.853.git.1615674128.gitgitgadget@gmail.com>
References: <pull.853.git.1615674128.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Mar 2021 22:22:04 +0000
Subject: [PATCH 4/8] diffcore-rename: only compute dir_rename_count for
 relevant directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When one side adds files to a directory that the other side renamed,
directory rename detection is used to either move the new paths to the
newer directory or warn the user about the fact that another path
location might be better.

If a parent of the given directory had new files added to it, any
renames in the current directory are also part of determining where the
parent directory is renamed to.  Thus, naively, we need to record each
rename N times for a path at depth N.  However, we can use the
additional information added to dirs_removed in the last commit to avoid
traversing all N parent directories in many cases.  Let's use an example
to explain how this works.  If we have a path named
   src/old_dir/a/b/file.c
and src/old_dir doesn't exist on one side of history, but the other
added a file named src/old_dir/newfile.c, then if one side renamed
   src/old_dir/a/b/file.c => source/new_dir/a/b/file.c
then this file would affect potential directory rename detection counts
for
   src/old_dir/a/b => source/new_dir/a/b
   src/old_dir/a   => source/new_dir/a
   src/old_dir     => source/new_dir
   src             => source
adding a weight of 1 to each in dir_rename_counts.  However, if src/
exists on both sides of history, then we don't need to track any entries
for it in dir_rename_counts.  That was implemented previously.  What we
are adding now, is that if no new files were added to src/old_dir/a or
src/old_dir/b, then we don't need to have counts in dir_rename_count
for those directories either.

In short, we only need to track counts in dir_rename_count for
directories whose dirs_removed value is RELEVANT_FOR_SELF.  And as soon
as we reach a directory that isn't in dirs_removed (signalled by
returning the default value of NOT_RELEVANT from strintmap_get()), we
can stop looking any further up the directory hierarchy.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index fafec66b29e9..0a17abd46691 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -461,6 +461,8 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 		return;
 
 	while (1) {
+		int drd_flag = NOT_RELEVANT;
+
 		/* Get old_dir, skip if its directory isn't relevant. */
 		dirname_munge(old_dir);
 		if (info->relevant_source_dirs &&
@@ -509,16 +511,31 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 			}
 		}
 
-		if (strintmap_contains(dirs_removed, old_dir))
+		/*
+		 * Above we suggested that we'd keep recording renames for
+		 * all ancestor directories where the trailing directories
+		 * matched, i.e. for
+		 *   "a/b/c/d/e/foo.c" -> "a/b/some/thing/else/e/foo.c"
+		 * we'd increment rename counts for each of
+		 *   a/b/c/d/e/ => a/b/some/thing/else/e/
+		 *   a/b/c/d/   => a/b/some/thing/else/
+		 * However, we only need the rename counts for directories
+		 * in dirs_removed whose value is RELEVANT_FOR_SELF.
+		 * However, we add one special case of also recording it for
+		 * first_time_in_loop because find_basename_matches() can
+		 * use that as a hint to find a good pairing.
+		 */
+		if (dirs_removed)
+			drd_flag = strintmap_get(dirs_removed, old_dir);
+		if (drd_flag == RELEVANT_FOR_SELF || first_time_in_loop)
 			increment_count(info, old_dir, new_dir);
-		else
-			break;
 
+		first_time_in_loop = 0;
+		if (drd_flag == NOT_RELEVANT)
+			break;
 		/* If we hit toplevel directory ("") for old or new dir, quit */
 		if (!*old_dir || !*new_dir)
 			break;
-
-		first_time_in_loop = 0;
 	}
 
 	/* Free resources we don't need anymore */
-- 
gitgitgadget

