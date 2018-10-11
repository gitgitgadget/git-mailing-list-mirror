Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2501F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeJLEra (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:30 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:42486 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLEra (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:30 -0400
Received: by mail-qk1-f201.google.com with SMTP id m63-v6so9733788qkb.9
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5aC63YeB6DWEdN/wauV+06XE10cArJdD5GEiqddH5Q0=;
        b=ELpqd+r8vh+WqAnb9EQ9fJXGzqzuTcb2il07okEg2eIT23JDRZsivgBHBHkXU6Z9M9
         E65ekx8WRJqnx6NF7h0N5TZc+Z4N2AZY/0vpSQ/b60dKjt4LuyHp0LVH3fCqwCp2E8Tp
         T1EQ7OVhCNMtNKCY8hyQeDr0F+t/zkeOtuPU9BHHlnD6Z3ApRoEr4nP8ptN0gJbA2NT5
         16jFho9cvUd0+3YZNBIkhHMgBTH0cczrLHXwIvEvTNo/h3YzC634USQuxwTTMfh/bsnG
         ww02f4r44dUyVmNz5QT9g1tKvAHuxOoGPYC0L3Rme7B0q4R1i9i97yEEe8NINoDqBPJI
         LN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5aC63YeB6DWEdN/wauV+06XE10cArJdD5GEiqddH5Q0=;
        b=GHv2QS01GH9e2p8h9npRHTsA2+7+Z58fh77Hq7pAR9EGumRQ9gBgQoiRLHuhYc3L+t
         IuCeBEMJ7KnlUC6VJ8MvoOggMEf0+QjXnVhFo3IgcdYMxRG8artwkVYxrtkbNv0PxSVy
         k9MxgO5f0eh8Cu1qXLfbS9HX4EJ8y4JSPgsJWWxztCBt74Jzci86uPaxaE2Pbk9WyeRJ
         AWfDjq6S1s3K9YzOLnLcxAnL4sFUVn5hM0rQ8ZTVFB8wT4DOkcvTHsJSfsoJfyuk5uuq
         sMSRSVTojacCo8TnM36jl6msYCAnk8jd4q2/+at4w87VjiphfyTIrb927CCyFGoMzCGD
         0EbA==
X-Gm-Message-State: ABuFfogWlxt7a06zSa0Uu8MJjhd1AjuGqYAxfbXOSl/cleRKEWtgC9L2
        CpTC9toQj4WwKIdjH05MYLhhrmiB2IONtBlAk3+YD//NCEQ66vRHMBr4umswTOypat5tSQXfHXi
        T0lSxHSJ6bvJ79TSUE4MsccZjOZbxtnDR8ktHCDsCHhn89T7GADgfCiqVeOCN
X-Google-Smtp-Source: ACcGV63agpdsCk/WOiteWvKBWaaQ9IhrFNcpA5hwZ84uw43F4jyIpv32JfDh6Qp9+N8EdcBaGDSIvtoh2E9H
X-Received: by 2002:a0c:acbc:: with SMTP id m57-v6mr2802669qvc.19.1539292705356;
 Thu, 11 Oct 2018 14:18:25 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:47 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-13-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 12/19] commit: prepare get_commit_buffer to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c                                | 8 +++++---
 commit.h                                | 7 ++++++-
 contrib/coccinelle/the_repository.cocci | 7 +++++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 2733bef019..31f2ca4c78 100644
--- a/commit.c
+++ b/commit.c
@@ -297,13 +297,15 @@ const void *get_cached_commit_buffer(struct repository *r, const struct commit *
 	return v->buffer;
 }
 
-const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
+const void *repo_get_commit_buffer(struct repository *r,
+				   const struct commit *commit,
+				   unsigned long *sizep)
 {
-	const void *ret = get_cached_commit_buffer(the_repository, commit, sizep);
+	const void *ret = get_cached_commit_buffer(r, commit, sizep);
 	if (!ret) {
 		enum object_type type;
 		unsigned long size;
-		ret = read_object_file(&commit->object.oid, &type, &size);
+		ret = repo_read_object_file(r, &commit->object.oid, &type, &size);
 		if (!ret)
 			die("cannot read commit object %s",
 			    oid_to_hex(&commit->object.oid));
diff --git a/commit.h b/commit.h
index f311911785..89b245be03 100644
--- a/commit.h
+++ b/commit.h
@@ -117,7 +117,12 @@ const void *get_cached_commit_buffer(struct repository *, const struct commit *,
  * from disk. The resulting memory should not be modified, and must be given
  * to unuse_commit_buffer when the caller is done.
  */
-const void *get_commit_buffer(const struct commit *, unsigned long *size);
+const void *repo_get_commit_buffer(struct repository *r,
+				   const struct commit *,
+				   unsigned long *size);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define get_commit_buffer(c, s) repo_get_commit_buffer(the_repository, c, s)
+#endif
 
 /*
  * Tell the commit subsytem that we are done with a particular commit buffer.
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 7814f8fa1c..6dad83f17b 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -61,3 +61,10 @@ expression G;
 + repo_get_merge_bases_many_dirty(the_repository,
   E, F, G);
 
+@@
+expression E;
+expression F;
+@@
+- get_commit_buffer(
++ repo_get_commit_buffer(the_repository,
+  E, F);
-- 
2.19.0

