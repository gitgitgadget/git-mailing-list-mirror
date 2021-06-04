Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249CFC4708F
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFB66115B
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFDElq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 00:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhFDElp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 00:41:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E73C061761
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 21:39:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q5so7929526wrm.1
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 21:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cPKlFyOpejA17f5oC0J4nlab9z6K2dpPMUaDBLIIazM=;
        b=oAVA6DjW6CMVLoCr+kpWISYrXKYm1G/MHeUZ3cLZvRXTqulOSvPFDTFkVyRAIRHjAc
         8W9Hpu3h52wncQUKzdkPhCFCmktM1zBK+H4xxbL1GSmYxelly1r/1odqZ/tSU6veA4Vc
         HDXWgcSjMzixTHousBgMXSa41uCL6zeBst10JxQpvEnsAz7bMzSgXn2tzlQGaz6gy6HQ
         DxtsIsIAx6JSFZl0c8k66SrdfIkS8jekc+XjBtpeiGOZEN7iwPP59nXRxuPhanMjpXwQ
         gx7Iakm0bK02GL8KQbKNU0mWKLX9dw/W2lCE51Bi7Z8PQhZzfvcQ7DkkZTf9veXm7QVI
         2uWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cPKlFyOpejA17f5oC0J4nlab9z6K2dpPMUaDBLIIazM=;
        b=COkpMDM2rC9bjYy2uEDJhCmRsuKCtQo0l1kgeIcOF55cymvG9AExF/zHYv9T0oZnrY
         bHt947jZDbBdCvgM+lt27xOEwYYFX5yBE7mN8A8o2NPAzQ4qryCVWkuQ7KG8QI3sqqrT
         o/bnu+9LDqqBjypQmrg4YCQBwVFI16YbCNq8EutvAe0jFDwPrBC68f/I55DMFxjySTQ8
         v/8tBrlciTcIeWT1gC+jZCPUD5ELFOOVKJ2i6T5ycSsXCgpj4F5Rc7Tt//PqR4iOITsh
         h6Q7+PcEJUCcSgwIdfC5aw308KF1O0iyGGOMJI3o0/2v8S3XpHqb6RCFZz14SlH9/zS+
         SLrw==
X-Gm-Message-State: AOAM531PrY1+KXwMZya96fuhFgO2vobLq9MO5+bRFWx3IQs7iDOek0p8
        1dXSsFt0N5PORbk7rCud4DHCCGIVAS8=
X-Google-Smtp-Source: ABdhPJzY4kPfHKyV/Kir1GDVRs99Ye/5qtIdW60gnCnHoo6ynopcnBBZNI8wteyvfDwEAA6CgNGtVg==
X-Received: by 2002:a5d:630f:: with SMTP id i15mr1628254wru.155.1622781581707;
        Thu, 03 Jun 2021 21:39:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm3448173wri.68.2021.06.03.21.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 21:39:41 -0700 (PDT)
Message-Id: <91c0962a7d75f3f56441446b022c05fc87810230.1622781578.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
References: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
        <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Jun 2021 04:39:37 +0000
Subject: [PATCH v3 3/4] Fix various issues found in comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A random hodge-podge of incorrect or out-of-date comments that I found:

  * t6423 had a comment that has referred to the wrong test for years;
    fix it to refer to the right one.
  * diffcore-rename had a FIXME comment meant to remind myself to
    investigate if I could make another code change.  I later
    investigated and removed the FIXME, but while cherry-picking the
    patch to submit upstream I missed the later update.  Remove the
    comment now.
  * merge-ort had the early part of a comment for a function; I had
    meant to include the more involved description when I updated the
    function.  Update the comment now.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Derrick Stolee <dstolee@microsoft.com>
---
 diffcore-rename.c                   | 2 +-
 merge-ort.c                         | 8 +++++---
 t/t6423-merge-rename-directories.sh | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index e333a6d64791..35378d84e8f1 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1543,7 +1543,7 @@ void diffcore_rename_extended(struct diff_options *options,
 			/* all the usual ones need to be kept */
 			diff_q(&outq, p);
 		else
-			/* no need to keep unmodified pairs; FIXME: remove earlier? */
+			/* no need to keep unmodified pairs */
 			pair_to_free = p;
 
 		if (pair_to_free)
diff --git a/merge-ort.c b/merge-ort.c
index 061f15701359..2ec382e292a6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2533,7 +2533,7 @@ static int compare_pairs(const void *a_, const void *b_)
 	return strcmp(a->one->path, b->one->path);
 }
 
-/* Call diffcore_rename() to compute which files have changed on given side */
+/* Call diffcore_rename() to update deleted/added pairs into rename pairs */
 static void detect_regular_renames(struct merge_options *opt,
 				   unsigned side_index)
 {
@@ -2586,8 +2586,10 @@ static void detect_regular_renames(struct merge_options *opt,
 }
 
 /*
- * Get information of all renames which occurred in 'side_pairs', discarding
- * non-renames.
+ * Get information of all renames which occurred in 'side_pairs', making use
+ * of any implicit directory renames in side_dir_renames (also making use of
+ * implicit directory renames rename_exclusions as needed by
+ * check_for_directory_rename()).  Add all (updated) renames into result.
  */
 static int collect_renames(struct merge_options *opt,
 			   struct diff_queue_struct *result,
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index be84d22419d9..e834b7e6efe0 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -454,7 +454,7 @@ test_expect_success '1f: Split a directory into two other directories' '
 #   the directory renamed, but the files within it. (see 1b)
 #
 #   If renames split a directory into two or more others, the directory
-#   with the most renames, "wins" (see 1c).  However, see the testcases
+#   with the most renames, "wins" (see 1f).  However, see the testcases
 #   in section 2, plus testcases 3a and 4a.
 ###########################################################################
 
-- 
gitgitgadget

