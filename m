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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688ACC433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F42423444
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbhAGUCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbhAGUCM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABDBC0612F6
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:31 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id g25so5542145wmh.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hDyryaov45i5VpCMwMfYmGC3XG+kMJuhszeqQ9Ks0RE=;
        b=IUIoipE+o/j8OjTFQCpddRh8GIYxlJ1GpvvmsTzdnkQGeNnfkGuSWbWESIh3OYFTOc
         De2GfJs+j4EDcrfwRucmZHupZcA6bIp+mQuFm3nzMFP+eJppxsS1DON88bnGAZmW7q4l
         fyEMXkjAK7Cf204hrnRgurq2jbnxTRylxbek7k0ekDC4lf8LSuDcOA0gLqW/UqqCgq2a
         aPKmxYWJ94W2EgpufkF8ZpTA5Gnt5qGJAgLpftXweNqjUp4Ei1jGh0lEUP2JDPTrSxpq
         9U1XIeaBRwnHmHvWUer2ttIVNgpYS2Fv6g5LWPKEBWVSh8X4EYxiqAsQ67jGmWLtzlcv
         eDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hDyryaov45i5VpCMwMfYmGC3XG+kMJuhszeqQ9Ks0RE=;
        b=XFUqMPhnhaGd+1cZ852oVybkESvpJUiV+BD4r/BaNtI0wA4LxuP9H81WO3OJ5VepDa
         qPKqIqMAkDVkBogL6PtqDbg8gNQtzFRc/Y8YUA9n3kV0kBldEljSkHXeeSq4FzWWYn5F
         hJYBLO6SdBohpBx/DFW+nYDDd/0QgZB5gCBC9oiR1pwUXnPUMS91UrjeTXcoaV6JoANO
         TrZ1Huuh2zcgzri5Y7W3OMPxxVkIZu7/TD1kp1T6X90hpgZXPgzUvIz89hGYQSZYEgkC
         vJOGn1P1j6ht2wBq9NGfjv8Ci1tc3/PyJqYUl0Zu5HMA1xQ8qqjxJ4oA0M1wlkZs2WUm
         GmHw==
X-Gm-Message-State: AOAM531n++40wluS+iQ/isg3Z7H+q2RPOOyNjcLv20VV2/x+AYFKqM2U
        itld+Ech2rR11sbvFLeExI/9EKCcKPE=
X-Google-Smtp-Source: ABdhPJyXG+UfG9vlKSBuX+Wrji65hbzlPTPJY5i5ths2/bZf6B4PsJRIRNgSLuBI0jUp0k2pOnWCOA==
X-Received: by 2002:a1c:e246:: with SMTP id z67mr166812wmg.166.1610049689978;
        Thu, 07 Jan 2021 12:01:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm9339020wme.11.2021.01.07.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:29 -0800 (PST)
Message-Id: <41a99640cc55d71659116dd66db6048cfb436e34.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:10 +0000
Subject: [PATCH 01/18] merge-ort: add new data structures for directory rename
 detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index d36a92b59b7..652ff730afa 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -49,14 +49,42 @@ enum merge_side {
 };
 
 struct rename_info {
+	/*
+	 * All variables that are arrays of size 3 correspond to data tracked
+	 * for the sides in enum merge_side.  Index 0 is almost always unused
+	 * because we often only need to track information for MERGE_SIDE1 and
+	 * MERGE_SIDE2 (MERGE_BASE can't have rename information since renames
+	 * are determined relative to what changed since the MERGE_BASE).
+	 */
+
 	/*
 	 * pairs: pairing of filenames from diffcore_rename()
-	 *
-	 * Index 1 and 2 correspond to sides 1 & 2 as used in
-	 * conflict_info.stages.  Index 0 unused.
 	 */
 	struct diff_queue_struct pairs[3];
 
+	/*
+	 * dirs_removed: directories removed on a given side of history.
+	 */
+	struct strset dirs_removed[3];
+
+	/*
+	 * dir_rename_count: tracking where parts of a directory were renamed to
+	 *
+	 * When files in a directory are renamed, they may not all go to the
+	 * same location.  Each strmap here tracks:
+	 *      old_dir => {new_dir => int}
+	 * That is, dir_rename_count[side] is a strmap to a strintmap.
+	 */
+	struct strmap dir_rename_count[3];
+
+	/*
+	 * dir_renames: computed directory renames
+	 *
+	 * This is a map of old_dir => new_dir and is derived in part from
+	 * dir_rename_count.
+	 */
+	struct strmap dir_renames[3];
+
 	/*
 	 * needed_limit: value needed for inexact rename detection to run
 	 *
-- 
gitgitgadget

