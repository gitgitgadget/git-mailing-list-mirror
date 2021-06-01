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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF895C47092
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDAC613A9
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhFAPA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 11:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbhFAPAW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 11:00:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E345C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 07:58:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z8so9563505wrp.12
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LODumI4lWebuNovaYpML51dqNMvU7NKt7WTC3uOrxLw=;
        b=JnHzWbHNooNnFMTpngm6gu0B8nMYmqYbIozYnX1QYtuQCU7vkE88hVlmwtS4b0rfhV
         p9BfMbcTUTUZiWk9aS/Elr8J/6Ke8JEoC8422mDuhzUt1I/mgQOjq54pfw865IJ21/6w
         l3Q8eVH7wQIp/hVa1ium4EgQvsb9/Laf5TlWn6pfTfi5qrL62Pq+eN6lW9zm0N7ecBVz
         XG5vnCUbHE3aAzokLzzgrIsEa6iTzCcr7AGe6xMpJvMEjULa7L8XbywzTSm50kBpwafv
         sqxuyMwuJu5j4HhuYsqeIx7iki+6G0KbM0c7Yteiyu4l6ycybRnxTV7DxzaFaNzCaY/y
         Hsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LODumI4lWebuNovaYpML51dqNMvU7NKt7WTC3uOrxLw=;
        b=ISke0EZw+uvg3JdonH58nZ/aK+EJKJEvnMJ4uMX4HEJk2l/1Mg5hT3txbrQL4WUVHe
         +EJNuCslFbXsAc7H94g/d1kPZqlazW8nZWKC6etbo0IFeVVRqIyJiK78DQ+DnLaM9+BQ
         o7sOeWLyqbbEb6QzhaUkh7UlONKOj7pRPqrLAW/ogRU9kGrEKlhxx7jcS1HWcvlneadu
         c+xMawSAXV95NdRyulgP+455jwLTCmc46jpnIaD9KClJ99Zv3i+7p6+RgHMfK+qCG6uD
         3R44o4rirrfyNEAtaFRU8j6nQhMk/CmuJ3crVofMsC+HF9yXanS1xzV8a/NQcMxZWnuZ
         5dOw==
X-Gm-Message-State: AOAM533votFSfg5mf9FLYJC9L0nELOqgg81sLX1WpB5SB1Xrcnvrw1Vp
        tbJtgljavJ5FHNHmABdlv5H0W9nmT1U=
X-Google-Smtp-Source: ABdhPJyIkOKFVaLZDYFqiinUTc0DFc/pRNuOdCNcOUz7+3oTOgvKEFYrmjF0JsC6MnPWgBvNJ+CcVQ==
X-Received: by 2002:adf:ed03:: with SMTP id a3mr5752322wro.166.1622559519819;
        Tue, 01 Jun 2021 07:58:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm18662277wmh.2.2021.06.01.07.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:58:39 -0700 (PDT)
Message-Id: <2f26d7e935c08ae792c5c8ae00a1f897fc5b1a5a.1622559516.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
        <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Jun 2021 14:58:34 +0000
Subject: [PATCH v2 4/5] Fix various issues found in comments
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
index 28951c35ddc2..14b3e14bbe47 100644
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

