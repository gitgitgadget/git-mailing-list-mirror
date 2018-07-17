Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105811F597
	for <e@80x24.org>; Tue, 17 Jul 2018 22:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbeGQXYf (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 19:24:35 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:45038 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730137AbeGQXYe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 19:24:34 -0400
Received: by mail-yw0-f201.google.com with SMTP id f206-v6so1424729ywa.11
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 15:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Zh+YxRnOE908ofKBSzly0+idnzzjEoNjbbwAJ3K/6lU=;
        b=WplSvPRsL1J7R04BLPUZSiEeACnGHI4L83bsEtJdVzcUGFLWHBjsnmx5zBx2L2ik4R
         zOclbRefwx3qQA8hnluvdUcC/ZjpzswawSOmttmto+FM1QXIyFypvf4S0Y8ETWfpYypC
         9lYhZAmR4PJXNf4/mWJBpFVqaZkCVpnnTh7uVRBWxsL5/PFzya/uXIZ4DXXvrf7Cje6b
         ecPCwq1+79yiyjGQ942pw89Y8vAUHF1aGG+lYjBSv+atT2pZNwD/j21v8Ygv21aPndd1
         mXNnVPVF7KlSE+p0rVt7YTxl+hSNXRwQaj/1cPf0rj/p6fuoynslFHa17KhiBQJFiQt2
         2jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Zh+YxRnOE908ofKBSzly0+idnzzjEoNjbbwAJ3K/6lU=;
        b=ObeOteMaw7iTqJnReavIxDUdHBkWF+QgEg8nhcGXxcjGkrSzm0/HY9sgRv1Jy6rbb7
         XkIkxoOYMvtHObolgqd0RGX3MppV3ekJ3taflEQi9kceugsglhKSr5kQWlU4Msv52lRT
         WtWGWGzsABtmmHibVzOTjbsOYJ28cMnF/kU1M1zTiIGpS//PLTDpyCbQzClKaFFbZOk+
         rBgpRomuzHUBBlesyqzh4jQaCHVNBt6yCZvX9Km51xbYEfVl82ipdWOLc/ztxwotHoo0
         eCtl6JfWF716Eujkb4mvUxAFNVkwlA2jOCJ4G7ZdEuoWXgBOcdXz/ZAW6OfLVnIiwOFH
         htug==
X-Gm-Message-State: AOUpUlGINvX1K4GJYRNMYin2OKnWlT059QAwWiZdIY/1cJxhD8uLPS+m
        qr5WW7dEt7LoYejuTUfoXe7nrm5J1KbE
X-Google-Smtp-Source: AAOMgpeCuDX+fJxG4pRLj/NfLDqWuNFqAZl8f1F6FLwEeKOG6D4Opcr05JKXb1Et3c5okCznLw6ysixkLQ0G
MIME-Version: 1.0
X-Received: by 2002:a25:39d3:: with SMTP id g202-v6mr1100893yba.4.1531867784537;
 Tue, 17 Jul 2018 15:49:44 -0700 (PDT)
Date:   Tue, 17 Jul 2018 15:49:35 -0700
In-Reply-To: <20180717224935.96397-1-sbeller@google.com>
Message-Id: <20180717224935.96397-3-sbeller@google.com>
References: <20180717224935.96397-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 2/2] refs.c: upgrade for_each_replace_ref to be a
 each_repo_ref_fn callback
From:   Stefan Beller <sbeller@google.com>
To:     dstolee@microsoft.com, stolee@gmail.com
Cc:     git@vger.kernel.org, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/replace.c | 3 ++-
 refs.c            | 9 ++++-----
 refs.h            | 2 +-
 replace-object.c  | 3 ++-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index ef22d724bbc..5f34659071f 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -39,7 +39,8 @@ struct show_data {
 	enum replace_format format;
 };
 
-static int show_reference(const char *refname, const struct object_id *oid,
+static int show_reference(struct repository *r, const char *refname,
+			  const struct object_id *oid,
 			  int flag, void *cb_data)
 {
 	struct show_data *data = cb_data;
diff --git a/refs.c b/refs.c
index 2513f77acb3..5700cd4683f 100644
--- a/refs.c
+++ b/refs.c
@@ -1478,12 +1478,11 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data)
+int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_main_ref_store(r),
-			       git_replace_ref_base, fn,
-			       strlen(git_replace_ref_base),
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	return do_for_each_repo_ref(r, git_replace_ref_base, fn,
+				    strlen(git_replace_ref_base),
+				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
diff --git a/refs.h b/refs.h
index 80eec8bbc68..a0a18223a14 100644
--- a/refs.h
+++ b/refs.h
@@ -317,7 +317,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 int for_each_tag_ref(each_ref_fn fn, void *cb_data);
 int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 int for_each_remote_ref(each_ref_fn fn, void *cb_data);
-int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data);
+int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
diff --git a/replace-object.c b/replace-object.c
index 801b5c16789..01a5a59a35a 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -6,7 +6,8 @@
 #include "repository.h"
 #include "commit.h"
 
-static int register_replace_ref(const char *refname,
+static int register_replace_ref(struct repository *r,
+				const char *refname,
 				const struct object_id *oid,
 				int flag, void *cb_data)
 {
-- 
2.18.0.233.g985f88cf7e-goog

