Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E8B1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 00:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbeG0B4e (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 21:56:34 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:42805 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbeG0B4e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 21:56:34 -0400
Received: by mail-io0-f202.google.com with SMTP id t23-v6so2456404ioa.9
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 17:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9MhBdZfZuF2iMBcbLN1/uhB3Muq/pk52TemnrKRoy/4=;
        b=U41seZJ6qD8TMg5AFU1VBM1f9aWmNo8qRqlvDmx2f5XKPtRJkbQrRF6LzHVUVFtgvE
         Ih234mvG3BtB3Uswn4paSJoCGnR0w/u4YLFwXBR6Ze88BL415ZJO9F3ZpJDRu1xZajkk
         1nwrcKL5eAlO7Q2zW1Fw54Uu8Ewijs82rCbdWB8rgfAzIAPGGGeXwR19Od57I3GaLTri
         7Kipm77EY/00hfLpcRNdCfKiK6dQNp1Ot4JgwrAlGIKycetzKVFhadmmgkNp35pXGT02
         2Hajp6NXns+ckVjsG0p9WlXuZ1nK6sQK7Pd4jgAfgRI+ik/PQAHnCP/zplfmxQxl6JgQ
         EzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9MhBdZfZuF2iMBcbLN1/uhB3Muq/pk52TemnrKRoy/4=;
        b=II3DwtTzHl6qN+Sb2D+gWFcgQ4nOcDFZkgtmWAeVitwnU+8RtBZDspXysSX1fa3fOm
         jno759hGIQ2QJDZ0ppJJYWFnfe+7Z0cSTdU7jJhbK0UC/XK28QA9HaXR4XfXj5LA3r+Y
         RvDKHhXrkE5OE9Df/3qsvn6SMdZgo1qMjMgnIBEl99QDm9fP92NgaPJLudWQmcbaBV1a
         xVTsuEWzLIZ3ORR4hqxeABgEoqbPGaTD/sst9jgRT+q4swNfs3ZWp7JNfSERDIk++lwS
         vpkmoRkJBgGkU3SONvqdWQNUIqPtH1tCqXk73rL6c1WGl5iBwXQXXyiTOzBVKgny8Oj8
         TZIA==
X-Gm-Message-State: AOUpUlGhpz+L4VezGaqRAP/ZC5/3+ERqifd9h042PBvn4410R7QbU5uz
        HLxn+g2R5C6qPSf1bDh+mTDbz7vTH0NiwSZe5oxXxxakmk26LCh4ZjYEzXrtfmv+ctz7gAiCMDM
        yx9cos2oEW5MijEQcpugOjfFr+FxEDUAGZD33w2z/EVmIn2f+QH+M4JUpwx9f
X-Google-Smtp-Source: AAOMgpcBI0pEfa+JuM0QxgiXVcHNTDyYfDqvUdZ6AK8M1FgG8gW1ZzLfeldQkKr0AAh0o+Ilha7KjMtMiyUS
X-Received: by 2002:a6b:3384:: with SMTP id z126-v6mr1632608ioz.61.1532651837580;
 Thu, 26 Jul 2018 17:37:17 -0700 (PDT)
Date:   Thu, 26 Jul 2018 17:36:38 -0700
In-Reply-To: <20180727003640.16659-1-sbeller@google.com>
Message-Id: <20180727003640.16659-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180727003640.16659-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 1/3] refs.c: migrate internal ref iteration to pass thru
 repository argument
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     mhagger@alum.mit.edu, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---
 refs.c               | 39 +++++++++++++++++++++++++++++++++++++--
 refs.h               | 10 ++++++++++
 refs/iterator.c      |  6 +++---
 refs/refs-internal.h |  5 +++--
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index fcfd3171e83..2513f77acb3 100644
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
@@ -2029,10 +2062,12 @@ int refs_verify_refname_available(struct ref_store *refs,
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
index cc2fb4c68c0..80eec8bbc68 100644
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
index 2ac91ac3401..629e00a122a 100644
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
index dd834314bd8..5c7414bf099 100644
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
2.18.0.345.g5c9ce644c3-goog

