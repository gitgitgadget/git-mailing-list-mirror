Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AF5E20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934387AbdBQOUe (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:20:34 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35553 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934350AbdBQOUa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:20:30 -0500
Received: by mail-pg0-f65.google.com with SMTP id y6so3967175pgy.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3znVysBI/93G7rM9e3BF270SGlFpEw6dIEGISI1SqhQ=;
        b=X4/1oOpLOWBd31azmdXp2PqiCx19FO+s/myl96UUbnGl6SmVVkHFlGheILbJ1DdVJS
         b2uXVwYVRzJZ6JiTGu8yzWOTr8mG6/gZTsW+TzDKtkoasbHg8AVvtjOjS9GO9CAtfie5
         qnNoCCU0OkHMazIYNodrLRwrf9baaCYH0oW/M6ITALcaSTDr7ZA3pb4vRfA3zDKyyJ/e
         ZEAT0Xj50+wPspfjszB9TTkLmAIzREpIer2EjbqNc9NSQu+ILo638LrWhDA/nelVOT4l
         ml/pjWT0lyUnsA+zEHD4lsjfAR7L3GSR68665/44+0WR8J23k/pRCHepiEUH+dyz3k0d
         8J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3znVysBI/93G7rM9e3BF270SGlFpEw6dIEGISI1SqhQ=;
        b=XOJBnKyiwmCPWb3dtgtypq/H4D0kMp8WekunI04mL73bVaNL7gh2oItPjWtb3IFeaB
         yITUoUYexzYBsWHYASnU60mVjmOeGr4U9yvXhthyDyO9brbBwUogoXkfVWztRxPvE+ze
         fw1Pp26uVu1JNCVx7hozJnBgUUAVnbNaUeu8yRpskELF3w6a90EnWIdKMQ7um0RIlbtU
         Fk/JZRqkf5K+fvgKkknDxtNI9a0yB084MVeK0Q96Dk5ZDLHaKLNcTgyWSGiMbe17C9qD
         Uxt4Q5h4IF5zg7WMz53wLz6yufXlbOqFV7bqM9L7xN/eBantpzPW4cVIbaULLyBZ/9Y8
         Q/ig==
X-Gm-Message-State: AMke39lIcfZIz9crz59cwsY1LhAbmTG5npKIvULmIoa/Qbm01MU3orElnj46lxViZ2hIOw==
X-Received: by 10.99.174.4 with SMTP id q4mr10448786pgf.186.1487341229495;
        Fri, 17 Feb 2017 06:20:29 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id n79sm20097058pfj.31.2017.02.17.06.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:20:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:20:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/15] revision.c: --all adds HEAD from all worktrees
Date:   Fri, 17 Feb 2017 21:19:04 +0700
Message-Id: <20170217141908.18012-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217141908.18012-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 reachable.c      |  1 +
 refs.c           | 22 ++++++++++++++++++++++
 refs.h           |  1 +
 revision.c       | 13 +++++++++++++
 submodule.c      |  2 ++
 t/t5304-prune.sh | 12 ++++++++++++
 6 files changed, 51 insertions(+)

diff --git a/reachable.c b/reachable.c
index d0199cace..61a6ec05c 100644
--- a/reachable.c
+++ b/reachable.c
@@ -177,6 +177,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 
 	/* detached HEAD is not included in the list above */
 	head_ref(add_one_ref, revs);
+	other_head_refs(add_one_ref, revs);
 
 	/* Add all reflog info */
 	if (mark_reflog)
diff --git a/refs.c b/refs.c
index fa2df7a1d..ce165c0ea 100644
--- a/refs.c
+++ b/refs.c
@@ -1676,3 +1676,25 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 
 	return refs->be->rename_ref(refs, oldref, newref, logmsg);
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
index 986d408bd..6665e5c57 100644
--- a/refs.h
+++ b/refs.h
@@ -190,6 +190,7 @@ typedef int each_ref_fn(const char *refname,
  * stop the iteration.
  */
 int head_ref(each_ref_fn fn, void *cb_data);
+int other_head_refs(each_ref_fn fn, void *cb_data);
 int for_each_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
diff --git a/revision.c b/revision.c
index d82c37b44..8ee929cef 100644
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
index 3ce589d55..aed47baaf 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1155,6 +1155,8 @@ static int find_first_merges(struct object_array *result, const char *path,
 			oid_to_hex(&a->object.oid));
 	init_revisions(&revs, NULL);
 	rev_opts.submodule = path;
+	/* FIXME: can't handle linked worktrees in submodules yet */
+	revs.single_worktree = path != NULL;
 	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
 
 	/* save all revisions from the above list that contain b */
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index cba45c7be..683bdb031 100755
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

