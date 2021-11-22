Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDECC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 14:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbhKVOWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 09:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbhKVOWT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 09:22:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4996EC06173E
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 06:19:12 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i12so15554150wmq.4
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 06:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=li9ddWIvcXsuTHY5iNnPUzk8eSGj8BuNLECtLyzi3Zk=;
        b=ZFfL0EQv4GepJhZOH+tqPad+gI/ODXphJ5ESVGlxxqbgZX/DUPjHw4VfLxpyZCeJpe
         +Fkoi3CZki7WO5uHV8RxYFyRGVxkgil8Dq6Sh6UuV7GNo1lfXRakdfq04kYlDXU3v5CI
         k8eGSxy08k3wuhyx9xKPl4RaiVFKiUADwCrqgSQeH3FBgl1v/rftnWnyJkDTskhyuJY9
         FSljvbrAo0Ic9KNR2aPdakKw5WhkvmBZL0vjhK1xjssb6qaRn09Ycs5knko3xaWvQF9+
         njOiSbWEjjxBv4i3RC5u5rKxc4vQI5CfnEkqB/m5SW77Axlnn4dmRhviHhpDOlsX4mLz
         FCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=li9ddWIvcXsuTHY5iNnPUzk8eSGj8BuNLECtLyzi3Zk=;
        b=6PvN8uiw7zC/psKFTsWzyVzjfrdbnLluSoIRq9p3ODLWQvqlcoqBt+SYVnuaEDPuCZ
         wdT18zdb9o/jEpHqpA7Rnr9NTV4KWNZiP3aKRNT+pnAZRsNhkU1J9DaIvBAgBpR5m9ph
         umg1TGznNzdDzbHCuP1knLQlX6sj84zlsihPUel5jeuPU2osOf3BQsdAYpwwjz8bFjwB
         ysRRjoyjmc0ohVXxfqvC2cM6UCsxM2QCRmuSrYwS14cm00SWKmD/iRapbODtd9ljBGPU
         nIiS9JI3CJstE0jpcyAuqTQ0eZcf11dovPK+MrAjVD1hJZ0NSjBgnb5OshW8VyFW0ceH
         uCJw==
X-Gm-Message-State: AOAM533GblWSc0UunCNCbH5vtYtQESd5Ipqq+7rS2zDAcUkbdbNOgs4G
        jBos5CgE3EeUkKsUtecTXxPc842XBG8=
X-Google-Smtp-Source: ABdhPJy1r6fgE2QD/+aCexx07EPF0RHF/kz6SYjy7bJ8TDmr6cJsUqsIkXwARcyxoFugq34sMk8B5g==
X-Received: by 2002:a05:600c:4fcd:: with SMTP id o13mr24243191wmq.175.1637590750572;
        Mon, 22 Nov 2021 06:19:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16sm10394566wmq.46.2021.11.22.06.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:19:10 -0800 (PST)
Message-Id: <pull.1144.git.git.1637590749342.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 14:19:08 +0000
Subject: [PATCH] refs: drop force_create argument of create_reflog API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

There is only one caller, builtin/checkout.c, and it hardcodes
force_create=1.

This argument was introduced in abd0cd3a301 (refs: new public ref function:
safe_create_reflog, 2015-07-21), which promised to immediately use it in a
follow-on commit, but that never happened.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs: drop force_create argument of create_reflog API
    
    There is only one caller, builtin/checkout.c, and it hardcodes
    force_create=1.
    
    This argument was introduced in abd0cd3a301 (refs: new public ref
    function: safe_create_reflog, 2015-07-21), which promised to immediately
    use it in a follow-on commit, but that never happened.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1144%2Fhanwen%2Freflog-create-arg-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1144/hanwen/reflog-create-arg-v1
Pull-Request: https://github.com/git/git/pull/1144

 builtin/checkout.c             | 2 +-
 refs.c                         | 9 ++++-----
 refs.h                         | 4 ++--
 refs/debug.c                   | 5 ++---
 refs/files-backend.c           | 5 ++---
 refs/packed-backend.c          | 3 +--
 refs/refs-internal.h           | 2 +-
 t/helper/test-ref-store.c      | 3 +--
 t/t1405-main-ref-store.sh      | 2 +-
 t/t1406-submodule-ref-store.sh | 2 +-
 10 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cbf73b8c9f6..19d752847f8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -874,7 +874,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				int ret;
 				struct strbuf err = STRBUF_INIT;
 
-				ret = safe_create_reflog(refname, 1, &err);
+				ret = safe_create_reflog(refname, &err);
 				if (ret) {
 					fprintf(stderr, _("Can not do reflog for '%s': %s\n"),
 						opts->new_orphan_branch, err.buf);
diff --git a/refs.c b/refs.c
index d7cc0a23a3b..cc291ee49fc 100644
--- a/refs.c
+++ b/refs.c
@@ -2358,16 +2358,15 @@ int reflog_exists(const char *refname)
 }
 
 int refs_create_reflog(struct ref_store *refs, const char *refname,
-		       int force_create, struct strbuf *err)
+		       struct strbuf *err)
 {
-	return refs->be->create_reflog(refs, refname, force_create, err);
+	return refs->be->create_reflog(refs, refname, err);
 }
 
-int safe_create_reflog(const char *refname, int force_create,
-		       struct strbuf *err)
+int safe_create_reflog(const char *refname, struct strbuf *err)
 {
 	return refs_create_reflog(get_main_ref_store(the_repository), refname,
-				  force_create, err);
+				  err);
 }
 
 int refs_delete_reflog(struct ref_store *refs, const char *refname)
diff --git a/refs.h b/refs.h
index d5099d4984e..bd3836c97ef 100644
--- a/refs.h
+++ b/refs.h
@@ -413,8 +413,8 @@ int refs_pack_refs(struct ref_store *refs, unsigned int flags);
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
 int refs_create_reflog(struct ref_store *refs, const char *refname,
-		       int force_create, struct strbuf *err);
-int safe_create_reflog(const char *refname, int force_create, struct strbuf *err);
+		       struct strbuf *err);
+int safe_create_reflog(const char *refname, struct strbuf *err);
 
 /** Reads log for the value of ref during at_time. **/
 int read_ref_at(struct ref_store *refs,
diff --git a/refs/debug.c b/refs/debug.c
index 8667c640237..756d07c7247 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -339,11 +339,10 @@ static int debug_reflog_exists(struct ref_store *ref_store, const char *refname)
 }
 
 static int debug_create_reflog(struct ref_store *ref_store, const char *refname,
-			       int force_create, struct strbuf *err)
+			       struct strbuf *err)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->create_reflog(drefs->refs, refname,
-						 force_create, err);
+	int res = drefs->refs->be->create_reflog(drefs->refs, refname, err);
 	trace_printf_key(&trace_refs, "create_reflog: %s: %d\n", refname, res);
 	return res;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 151b0056fe5..00f596dd68c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1639,15 +1639,14 @@ error:
 	return -1;
 }
 
-static int files_create_reflog(struct ref_store *ref_store,
-			       const char *refname, int force_create,
+static int files_create_reflog(struct ref_store *ref_store, const char *refname,
 			       struct strbuf *err)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE, "create_reflog");
 	int fd;
 
-	if (log_ref_setup(refs, refname, force_create, &fd, err))
+	if (log_ref_setup(refs, refname, 1, &fd, err))
 		return -1;
 
 	if (fd >= 0)
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1c5211b03e4..472458b844e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1628,8 +1628,7 @@ static int packed_reflog_exists(struct ref_store *ref_store,
 }
 
 static int packed_create_reflog(struct ref_store *ref_store,
-			       const char *refname, int force_create,
-			       struct strbuf *err)
+				const char *refname, struct strbuf *err)
 {
 	BUG("packed reference store does not support reflogs");
 }
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 12224742ede..5b40b3bbbf8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -606,7 +606,7 @@ typedef int for_each_reflog_ent_reverse_fn(struct ref_store *ref_store,
 					   void *cb_data);
 typedef int reflog_exists_fn(struct ref_store *ref_store, const char *refname);
 typedef int create_reflog_fn(struct ref_store *ref_store, const char *refname,
-			     int force_create, struct strbuf *err);
+			     struct strbuf *err);
 typedef int delete_reflog_fn(struct ref_store *ref_store, const char *refname);
 typedef int reflog_expire_fn(struct ref_store *ref_store,
 			     const char *refname,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b314b81a45b..98f827edfb7 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -181,11 +181,10 @@ static int cmd_reflog_exists(struct ref_store *refs, const char **argv)
 static int cmd_create_reflog(struct ref_store *refs, const char **argv)
 {
 	const char *refname = notnull(*argv++, "refname");
-	int force_create = arg_flags(*argv++, "force-create");
 	struct strbuf err = STRBUF_INIT;
 	int ret;
 
-	ret = refs_create_reflog(refs, refname, force_create, &err);
+	ret = refs_create_reflog(refs, refname, &err);
 	if (err.len)
 		puts(err.buf);
 	return ret;
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 49718b7ea7f..c89cef2d26b 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -108,7 +108,7 @@ test_expect_success 'delete_reflog(HEAD)' '
 '
 
 test_expect_success 'create-reflog(HEAD)' '
-	$RUN create-reflog HEAD 1 &&
+	$RUN create-reflog HEAD &&
 	git reflog exists HEAD
 '
 
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 0a87058971e..f1e57a9c051 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -92,7 +92,7 @@ test_expect_success 'delete_reflog() not allowed' '
 '
 
 test_expect_success 'create-reflog() not allowed' '
-	test_must_fail $RUN create-reflog HEAD 1
+	test_must_fail $RUN create-reflog HEAD
 '
 
 test_done

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
gitgitgadget
