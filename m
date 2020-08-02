Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D3C433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 03:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67612067D
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 03:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnWK0WWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgHBDOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 23:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHBDOb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 23:14:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C63C06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 20:14:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x5so11511076wmi.2
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 20:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=mKFj9KsdyIVToWDv2SPNaRVDtav/tPPMJ9lRL1fyw3o=;
        b=MnWK0WWMvN4vbJGXCsHcUeCzyUA7MogciCDDrcnLECsGd4eoiz90bmyWnHwMQtZCH5
         HfxAWfbxQ5Wqatt9XPT4MXOZucLSDGLcvBRrwXD8wPTIC7fGh4iOsRYs/zOdAnq23eKv
         8IYimxq5+4uoG+9nTe2NLrWzrvYQJWkkUo4Tot916d94GN3NjXe3ly8TukyvRSvdizDM
         b/WWIgi43KEgSAoir/6O0SU5lxpmdh1ZIjJSaxbVNT1C4/MKPx4WL/L+LE2qt8U1e5aD
         4WboPTuLQ1uM+Ltx6VDj3/oMcZQx2dsPZ09slyxFio5iUDFEUr8d0pwwEm1SvGeHDjTB
         QNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mKFj9KsdyIVToWDv2SPNaRVDtav/tPPMJ9lRL1fyw3o=;
        b=oC3PJ0Bugmb8hSYkc/PL/qd+x+TnT8G4MUkjMqWiU7Pirv8sT5lZlMTongcBHvurlX
         NXBIk5c4NdRiNKvyJf2G5t3/4nBj+m6KVDgUe1rWRK5DQy1BFjCxw3TGC0t0jbRHBff5
         TKpqce40cZezD9+0XQYjT1KVG6kqIrfrWJKXVxUatEunn/HHsH9v44r1x4RN+7JkNeBc
         nc6WFEiyK8Sz/bhkB9DfRvl10XYNWdBW186PY9sUuBDdZCR12bBNuLQnQregzBFWd9Wu
         AiKuybrhan4GcVS65bLxnXFAjU6j3k1sgligBFeX297QX5DktHduggWTmggPEui+6v4g
         Ty+A==
X-Gm-Message-State: AOAM531dO8wOpD5iHiY8qbXV4OqoIioSymwT76XshfnOUBr5U8z+3cn5
        iefwgcHyFCbK98f8Va5zn8egAvkm
X-Google-Smtp-Source: ABdhPJxj94fEmcdgdwAw8W3MROG3O2SIfANR9V/+cb+en/qAkLQMT0wd4H6i9wZVY7iaC17kDHfHvA==
X-Received: by 2002:a1c:18b:: with SMTP id 133mr10064280wmb.178.1596338069407;
        Sat, 01 Aug 2020 20:14:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g25sm16544615wmh.35.2020.08.01.20.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 20:14:28 -0700 (PDT)
Message-Id: <pull.826.git.git.1596338068072.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 02 Aug 2020 03:14:27 +0000
Subject: [PATCH] merge-recursive: fix unclear and outright wrong comments
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

Commits 7c0a6c8e47 ("merge-recursive: move some definitions around to
clean up the header", 2019-08-17), and b4db8a2b76 ("merge-recursive:
remove useless parameter in merge_trees()", 2019-08-17) added some
useful documentation to the functions, but had a few places where the
new comments were unclear or even misleading.  Fix those comments.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    fix unclear and misleading comments in merge-recursive

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-826%2Fnewren%2Ffix-merge-recursive-comments-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-826/newren/fix-merge-recursive-comments-v1
Pull-Request: https://github.com/git/git/pull/826

 merge-recursive.c |  5 +++--
 merge-recursive.h | 13 ++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 36948eafb7..01c633d807 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3529,8 +3529,9 @@ static struct commit_list *reverse_commit_list(struct commit_list *list)
 }
 
 /*
- * Merge the commits h1 and h2, return the resulting virtual
- * commit object and a flag indicating the cleanness of the merge.
+ * Merge the commits h1 and h2, returning a flag (int) indicating the
+ * cleanness of the merge.  Also, if opt->priv->call_depth, create a
+ * virtual commit and write its location to *result.
  */
 static int merge_recursive_internal(struct merge_options *opt,
 				    struct commit *h1,
diff --git a/merge-recursive.h b/merge-recursive.h
index 978847e672..0795a1d3ec 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -69,9 +69,8 @@ int parse_merge_opt(struct merge_options *opt, const char *s);
  *
  * Outputs:
  *   - See RETURN VALUES above
- *   - No commit is created
  *   - opt->repo->index has the new index
- *   - $GIT_INDEX_FILE is not updated
+ *   - new index NOT written to disk
  *   - The working tree is updated with results of the merge
  */
 int merge_trees(struct merge_options *opt,
@@ -81,7 +80,7 @@ int merge_trees(struct merge_options *opt,
 
 /*
  * merge_recursive is like merge_trees() but with recursive ancestor
- * consolidation and, if the commit is clean, creation of a commit.
+ * consolidation.
  *
  * NOTE: empirically, about a decade ago it was determined that with more
  *       than two merge bases, optimal behavior was found when the
@@ -91,9 +90,9 @@ int merge_trees(struct merge_options *opt,
  *
  * Outputs:
  *   - See RETURN VALUES above
- *   - If merge is clean, a commit is created and its address written to *result
+ *   - *result is treated as scratch space for temporary recursive merges
  *   - opt->repo->index has the new index
- *   - $GIT_INDEX_FILE is not updated
+ *   - new index NOT written to disk
  *   - The working tree is updated with results of the merge
  */
 int merge_recursive(struct merge_options *opt,
@@ -109,9 +108,9 @@ int merge_recursive(struct merge_options *opt,
  *
  * Outputs:
  *   - See RETURN VALUES above
- *   - If merge is clean, a commit is created and its address written to *result
+ *   - *result is treated as scratch space for temporary recursive merges
  *   - opt->repo->index has the new index
- *   - $GIT_INDEX_FILE is updated
+ *   - new index also written to $GIT_INDEX_FILE on disk
  *   - The working tree is updated with results of the merge
  */
 int merge_recursive_generic(struct merge_options *opt,

base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
-- 
gitgitgadget
