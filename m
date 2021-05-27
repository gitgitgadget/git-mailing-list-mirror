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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ADFC4708A
	for <git@archiver.kernel.org>; Thu, 27 May 2021 08:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9171E613C9
	for <git@archiver.kernel.org>; Thu, 27 May 2021 08:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhE0IjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 04:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbhE0IjB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 04:39:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A46C061760
        for <git@vger.kernel.org>; Thu, 27 May 2021 01:37:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so2058146wmf.5
        for <git@vger.kernel.org>; Thu, 27 May 2021 01:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P7QN3I4WING/y1zuJ9mtu4XjnjEMhHH1ekim8qeDxq0=;
        b=ChTKnzcPqw0en7+ACX9hWyQKqn/QaFmCxNK+3M/gHRf2ijwJLCz9T60HvUScXl9YDS
         1pK3YKwtOR498lbwNO4L89LwewpXZ2ZcKDOvBWA7rKuC2OyGSuiny4GY6jY+KvkhoBC1
         qklKOSWiKDCZrPsKE1uN5uZK8mBtjZOVdYTMu302dsD2s4ony21HaHkDh/DdbSzh22tL
         OSu/Zt5f39vwMjdLNC4rd+fsnOxaYgUGLbVu64SlGpX4LDdUrKSY7fzHmrl/HLxv0yyu
         tA/ro38xjYe16Dmu8nZOGk+12njyqsCHyv3dwHiHPkzNyRQm/LSfgeJIeVdDDFRUpIM9
         kjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P7QN3I4WING/y1zuJ9mtu4XjnjEMhHH1ekim8qeDxq0=;
        b=gE1W0YLnjBgwmwW8ScQkRRS46QgeHw7T/S3c8nYT6kgK6bUKbVaOrNdbds9HdWx/E4
         FBRJSoObnJtuny7djUc7LsVCKmac5cNrVh1ix9v/MHn6lqiNcNlzDKH5ZCBMhHJG4ASX
         ZTUFTQU9GMrkC17dQk+VPXncF+F4vLIU1Tjz19SgumPkx7DKccDcpNbf+CEf2m1MYt/L
         4w0q9CAO8XKZNsPXmY/xOZpIFixAJ8HJtN3s8H7mJOBnDo+v1DddMP41RmGvHuZqRlVo
         z1CN7xYy+hPcz/K/bbtobd4MPTm2M118MOZPOjbSYqy2P50gR5jMxvqzI6oxKKY1AU7H
         aKcw==
X-Gm-Message-State: AOAM530EgPeLTdpFJXdKbi32LTqxPZkEBUHAGU2YMU1baYzlL8dMxkGt
        pi08LS6lMq94JCcDjMi4oYbSe+8EISk=
X-Google-Smtp-Source: ABdhPJw3YAWVBCempxeOmfajuM6MPpUnlIctlCkY3NHxTYsJobCcwMx821g0huN7kBLW1k9wJjDm4Q==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr2291584wmj.155.1622104646308;
        Thu, 27 May 2021 01:37:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm1145722wmb.36.2021.05.27.01.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:37:25 -0700 (PDT)
Message-Id: <98c9a419b313261a21d3794742181c27ed8cd0cb.1622104642.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.git.1622104642.gitgitgadget@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 May 2021 08:37:20 +0000
Subject: [PATCH 4/5] Fix various issues found in comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
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
---
 diffcore-rename.c                   | 2 +-
 merge-ort.c                         | 8 +++++---
 t/t6423-merge-rename-directories.sh | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 8ff83a9f3b99..c9f7d59cf62b 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1579,7 +1579,7 @@ void diffcore_rename_extended(struct diff_options *options,
 			/* all the usual ones need to be kept */
 			diff_q(&outq, p);
 		else
-			/* no need to keep unmodified pairs; FIXME: remove earlier? */
+			/* no need to keep unmodified pairs */
 			pair_to_free = p;
 
 		if (pair_to_free)
diff --git a/merge-ort.c b/merge-ort.c
index db16cbc3bd33..6cb103c8e855 100644
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
@@ -2587,8 +2587,10 @@ static void detect_regular_renames(struct merge_options *opt,
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

