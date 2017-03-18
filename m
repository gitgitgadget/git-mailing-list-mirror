Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C2020323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbdCRKOT (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:14:19 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34817 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdCRKOO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:14:14 -0400
Received: by mail-pf0-f193.google.com with SMTP id x63so11183334pfx.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5qFg99Oug7/ukd9OpILiNl0BV6FWcj6Q6J+fmBdrdAo=;
        b=oIY+I5LQa84OVhUZfpSY5uiN8DE2kE0YreGUnjmvRyF6siJn0X4+D5UsFJ3ZWTIIS4
         uy44qUosgWHPCQyYbYqDcaxfW2Cex1Un81f7JizBP9cWTcYLv2yOaYwZJcIvCA/sSk3h
         9hL5a6PY8TCO4ayV1NTl1PtQGp8csrIZQNzrETjTe3xsQ0bIGKoNxv/nw3pYSMbVIApf
         OmsrMKKOP8lb59ySGPj1eej6bza4TN/Vd5020rbXTNI5EgnN9L/+Bi5Zn/oIP6bT67DE
         Pi57ey42oYqG51J1ek5GUOxSlXdvsqR58xXgTc73rF6W9xv8eD99O5wtDgaXdEfLXFwu
         z6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5qFg99Oug7/ukd9OpILiNl0BV6FWcj6Q6J+fmBdrdAo=;
        b=HXXNbBrINVk/1Wq6N1AU2sFfBGnDxTk/FRu7lnCy73xsRphkRtGv1hLbLC6btKIy5d
         GkiOr1mJ89r5X+xMLVrJgfCIVn4G+GbAKcaVp5ejZGSU3EV77utP1xCUVucMlc1oXSkF
         gPrMi+kKWNU2y0V0yEhi5oFYyYGvU21Bg9LtSb5mz4LCNXWotGgb+fwS16X+Gcj/9qju
         GHA6DjklwXILdV7dOgxnFp8j4hGQKX8zgA2Y6SE/cPuewru8lZEVGWQCWQwL3sz1AfB4
         uN6QTh7vSPwsIMtwcEyAtR/zx/jNS/ThvpqzbJORkeUp3NVO9ftZGDMgQ84UQWjAEzVK
         M/dA==
X-Gm-Message-State: AFeK/H1GSfnAqgh0FFhYzrJ/YPlQ0fBsbF+0H/RInRLe9vXEE6mFIrTuXY08gGd35Ftb/Q==
X-Received: by 10.99.108.74 with SMTP id h71mr20194098pgc.99.1489831972224;
        Sat, 18 Mar 2017 03:12:52 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id v26sm21837569pfl.16.2017.03.18.03.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:12:51 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:12:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 09/12] revision.c: --all adds HEAD from all worktrees
Date:   Sat, 18 Mar 2017 17:11:50 +0700
Message-Id: <20170318101153.6901-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318101153.6901-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
 <20170318101153.6901-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unless single_worktree is set, --all now adds HEAD from all worktrees.

Since reachable.c code does not use setup_revisions(), we need to call
other_head_refs_submodule() explicitly there to have the same effect on
"git prune", so that we won't accidentally delete objects needed by some
other HEADs.

A new FIXME is added because we would need something like

    int refs_other_head_refs(struct ref_store *, each_ref_fn, cb_data);

in addition to other_head_refs() to handle it, which might require

    int get_submodule_worktrees(const char *submodule, int flags);

It could be a separate topic to reduce the scope of this one.
---
 reachable.c      |  1 +
 refs.c           | 22 ++++++++++++++++++++++
 refs.h           |  1 +
 revision.c       | 13 +++++++++++++
 submodule.c      |  2 ++
 t/t5304-prune.sh | 12 ++++++++++++
 6 files changed, 51 insertions(+)

diff --git a/reachable.c b/reachable.c
index a8a979bd4f..a3b938b46c 100644
--- a/reachable.c
+++ b/reachable.c
@@ -177,6 +177,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 
 	/* detached HEAD is not included in the list above */
 	head_ref(add_one_ref, revs);
+	other_head_refs(add_one_ref, revs);
 
 	/* Add all reflog info */
 	if (mark_reflog)
diff --git a/refs.c b/refs.c
index 1f2f870084..6006d4fdbc 100644
--- a/refs.c
+++ b/refs.c
@@ -1787,3 +1787,25 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 {
 	return refs_rename_ref(get_main_ref_store(), oldref, newref, logmsg);
 }
+
+int other_head_refs(each_ref_fn fn, void *cb_data)
+{
+	struct worktree **worktrees, **p;
+	int ret = 0;
+
+	worktrees = get_worktrees(0);
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+		struct ref_store *refs;
+
+		if (wt->is_current)
+			continue;
+
+		refs = get_worktree_ref_store(wt);
+		ret = refs_head_ref(refs, fn, cb_data);
+		if (ret)
+			break;
+	}
+	free_worktrees(worktrees);
+	return ret;
+}
diff --git a/refs.h b/refs.h
index e06db37118..cc71b6c7a0 100644
--- a/refs.h
+++ b/refs.h
@@ -247,6 +247,7 @@ int refs_for_each_remote_ref(struct ref_store *refs,
 			     each_ref_fn fn, void *cb_data);
 
 int head_ref(each_ref_fn fn, void *cb_data);
+int other_head_refs(each_ref_fn fn, void *cb_data);
 int for_each_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
diff --git a/revision.c b/revision.c
index da19071960..e5d2913b5c 100644
--- a/revision.c
+++ b/revision.c
@@ -2105,6 +2105,13 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	int argcount;
 
 	if (submodule) {
+		/*
+		 * We need some something like get_submodule_worktrees()
+		 * before we can go through all worktrees of a submodule,
+		 * .e.g with adding all HEADs from --all, which is not
+		 * supported right now, so stick to single worktree.
+		 */
+		assert(revs->single_worktree != 0);
 		refs = get_submodule_ref_store(submodule);
 	} else
 		refs = get_main_ref_store();
@@ -2122,6 +2129,12 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (!strcmp(arg, "--all")) {
 		handle_refs(refs, revs, *flags, refs_for_each_ref);
 		handle_refs(refs, revs, *flags, refs_head_ref);
+		if (!revs->single_worktree) {
+			struct all_refs_cb cb;
+
+			init_all_refs_cb(&cb, revs, *flags);
+			other_head_refs(handle_one_ref, &cb);
+		}
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
 		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
diff --git a/submodule.c b/submodule.c
index 3c445f274e..63a190f0f6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1225,6 +1225,8 @@ static int find_first_merges(struct object_array *result, const char *path,
 			oid_to_hex(&a->object.oid));
 	init_revisions(&revs, NULL);
 	rev_opts.submodule = path;
+	/* FIXME: can't handle linked worktrees in submodules yet */
+	revs.single_worktree = path != NULL;
 	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
 
 	/* save all revisions from the above list that contain b */
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index cba45c7be9..683bdb031c 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -292,4 +292,16 @@ test_expect_success 'prune: handle index in multiple worktrees' '
 	test_cmp second-worktree/blob actual
 '
 
+test_expect_success 'prune: handle HEAD in multiple worktrees' '
+	git worktree add --detach third-worktree &&
+	echo "new blob for third-worktree" >third-worktree/blob &&
+	git -C third-worktree add blob &&
+	git -C third-worktree commit -m "third" &&
+	rm .git/worktrees/third-worktree/index &&
+	test_must_fail git -C third-worktree show :blob &&
+	git prune --expire=now &&
+	git -C third-worktree show HEAD:blob >actual &&
+	test_cmp third-worktree/blob actual
+'
+
 test_done
-- 
2.11.0.157.gd943d85

