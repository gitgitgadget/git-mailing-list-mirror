Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991141F597
	for <e@80x24.org>; Wed, 18 Jul 2018 15:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbeGRPx7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 11:53:59 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38658 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeGRPx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 11:53:59 -0400
Received: by mail-pl0-f67.google.com with SMTP id b1-v6so2183166pls.5
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 08:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=UuxfqhCN9PR3lddejpzWUz8y1z7qJYRFpHP9dfAyALM=;
        b=G5ppYltdinra4k6M2RZMeTY0zGabEoa8m3d3H89l0UluWKHfB9oKsicdd1g0WhLINd
         SA0gG6mqFN7VTY375L+VRoAy56W9sgZzyoES/PIWkBbiWd9KGW/cdlTmUX+Ry3LB4y3x
         2giVDlSKdu9Qu0m7oPNRIV0svcg9dvrIpoJTzedznXceaPjGlbHi+3BJnvaUt81VLuY7
         eiU4Gzh9aQ2kFGABUaBy/oKbrSzYhkDnqp1ArlEGLm0B4AT+HwsLM15FCE9uCx54tYnT
         KD0B1npWqttkoHvjCfcGD7IFS2rza8rR5EtcCSOA9pEjn9kGnWfoQCeyRI/CNjjsrpsD
         8N2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=UuxfqhCN9PR3lddejpzWUz8y1z7qJYRFpHP9dfAyALM=;
        b=h7ASZzCpjRDRPx4PoJhY5kdZgHjLTMZa1XOIegF4am+Pj/j+lgAg8JhbRaNcypeIxu
         24F+vTjV7t8VN0IASDtsS9qQSNtHTHwswEol9313UlafbZ4feYRfAW+/Sl/wJnEfGWjT
         2H4o1ZiMdrQp/6p++nReuvKLlBk3TsO/dv4BQq6iA+JDv5yQ9M67gVuy7tmzSXwGLWW/
         odaJYWU8pVWmwcter/V3prQMBH9Oy1JyL+C1AXoEq94SuRrQhgiUIa34FT5kOkquUqFL
         m7kvekAKraxMy/DLnaxTrayxnbmDP4tsRuhhJOOVKt+bRYiJ+vP6Grq/p/zj8V5vFzvX
         yXWg==
X-Gm-Message-State: AOUpUlF1uZyP8sUZ1ygZQjpuuzUQNAypqfGnWpIHQUIu2TJ5DE8kYYuD
        1Q0ECTabLxE4gucZaI88z70Omw==
X-Google-Smtp-Source: AAOMgpe+4U6wvRpYX6832b6JAB0uT4k4wyOWeDHClpUS7xxdmyDL82fkYHbq+T5iqqx20Pp0KZCd4w==
X-Received: by 2002:a17:902:8215:: with SMTP id x21-v6mr6287626pln.175.1531926936730;
        Wed, 18 Jul 2018 08:15:36 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id o21-v6sm6018812pfa.54.2018.07.18.08.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:15:35 -0700 (PDT)
Date:   Wed, 18 Jul 2018 08:15:35 -0700 (PDT)
X-Google-Original-Date: Wed, 18 Jul 2018 15:15:24 GMT
Message-Id: <43ddcc9ef9267d54fb521319175871e5bf7e4d12.1531926932.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.11.git.gitgitgadget@gmail.com>
References: <pull.11.git.gitgitgadget@gmail.com>
From:   "Stefan Beller via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/8] refs.c: migrate internal ref iteration to pass thru
 repository argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

In 60ce76d3581 (refs: add repository argument to for_each_replace_ref,
2018-04-11) and 0d296c57aec (refs: allow for_each_replace_ref to handle
arbitrary repositories, 2018-04-11), for_each_replace_ref learned how
to iterate over refs by a given arbitrary repository.
New attempts in the object store conversion have shown that it is useful
to have the repository handle available that the refs iteration is
currently iterating over.

To achieve this goal we will need to add a repository argument to
each_ref_fn in refs.h. However as many callers rely on the signature
such a patch would be too large.

So convert the internals of the ref subsystem first to pass through a
repository argument without exposing the change to the user. Assume
the_repository for the passed through repository, although it is not
used anywhere yet.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 refs.c               | 39 +++++++++++++++++++++++++++++++++++++--
 refs.h               | 10 ++++++++++
 refs/iterator.c      |  6 +++---
 refs/refs-internal.h |  5 +++--
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index fcfd3171e..2513f77ac 100644
--- a/refs.c
+++ b/refs.c
@@ -1390,17 +1390,50 @@ struct ref_iterator *refs_ref_iterator_begin(
  * non-zero value, stop the iteration and return that value;
  * otherwise, return 0.
  */
+static int do_for_each_repo_ref(struct repository *r, const char *prefix,
+				each_repo_ref_fn fn, int trim, int flags,
+				void *cb_data)
+{
+	struct ref_iterator *iter;
+	struct ref_store *refs = get_main_ref_store(r);
+
+	if (!refs)
+		return 0;
+
+	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
+
+	return do_for_each_repo_ref_iterator(r, iter, fn, cb_data);
+}
+
+struct do_for_each_ref_help {
+	each_ref_fn *fn;
+	void *cb_data;
+};
+
+static int do_for_each_ref_helper(struct repository *r,
+				  const char *refname,
+				  const struct object_id *oid,
+				  int flags,
+				  void *cb_data)
+{
+	struct do_for_each_ref_help *hp = cb_data;
+
+	return hp->fn(refname, oid, flags, hp->cb_data);
+}
+
 static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	struct ref_iterator *iter;
+	struct do_for_each_ref_help hp = { fn, cb_data };
 
 	if (!refs)
 		return 0;
 
 	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
 
-	return do_for_each_ref_iterator(iter, fn, cb_data);
+	return do_for_each_repo_ref_iterator(the_repository, iter,
+					do_for_each_ref_helper, &hp);
 }
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
@@ -2029,10 +2062,12 @@ cleanup:
 int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	struct ref_iterator *iter;
+	struct do_for_each_ref_help hp = { fn, cb_data };
 
 	iter = refs->be->reflog_iterator_begin(refs);
 
-	return do_for_each_ref_iterator(iter, fn, cb_data);
+	return do_for_each_repo_ref_iterator(the_repository, iter,
+					     do_for_each_ref_helper, &hp);
 }
 
 int for_each_reflog(each_ref_fn fn, void *cb_data)
diff --git a/refs.h b/refs.h
index cc2fb4c68..80eec8bbc 100644
--- a/refs.h
+++ b/refs.h
@@ -274,6 +274,16 @@ struct ref_transaction;
 typedef int each_ref_fn(const char *refname,
 			const struct object_id *oid, int flags, void *cb_data);
 
+/*
+ * The same as each_ref_fn, but also with a repository argument that
+ * contains the repository associated with the callback.
+ */
+typedef int each_repo_ref_fn(struct repository *r,
+			     const char *refname,
+			     const struct object_id *oid,
+			     int flags,
+			     void *cb_data);
+
 /*
  * The following functions invoke the specified callback function for
  * each reference indicated.  If the function ever returns a nonzero
diff --git a/refs/iterator.c b/refs/iterator.c
index 2ac91ac34..629e00a12 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -407,15 +407,15 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 
 struct ref_iterator *current_ref_iter = NULL;
 
-int do_for_each_ref_iterator(struct ref_iterator *iter,
-			     each_ref_fn fn, void *cb_data)
+int do_for_each_repo_ref_iterator(struct repository *r, struct ref_iterator *iter,
+				  each_repo_ref_fn fn, void *cb_data)
 {
 	int retval = 0, ok;
 	struct ref_iterator *old_ref_iter = current_ref_iter;
 
 	current_ref_iter = iter;
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
-		retval = fn(iter->refname, iter->oid, iter->flags, cb_data);
+		retval = fn(r, iter->refname, iter->oid, iter->flags, cb_data);
 		if (retval) {
 			/*
 			 * If ref_iterator_abort() returns ITER_ERROR,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dd834314b..5c7414bf0 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -473,8 +473,9 @@ extern struct ref_iterator *current_ref_iter;
  * adapter between the callback style of reference iteration and the
  * iterator style.
  */
-int do_for_each_ref_iterator(struct ref_iterator *iter,
-			     each_ref_fn fn, void *cb_data);
+int do_for_each_repo_ref_iterator(struct repository *r,
+				  struct ref_iterator *iter,
+				  each_repo_ref_fn fn, void *cb_data);
 
 /*
  * Only include per-worktree refs in a do_for_each_ref*() iteration.
-- 
gitgitgadget

