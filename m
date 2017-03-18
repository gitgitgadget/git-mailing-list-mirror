Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE1C20323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdCRKOR (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:14:17 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34908 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdCRKOO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:14:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id x63so11183860pfx.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A7LR8+xj8tu2Z88NPYxTuil5MoHkM97hj2RgE7JqMsQ=;
        b=RJ8iKNI53dXSswMq9lJV8ZzzHcD8swJ6Xh+qn07ztw6JUjVLIs82wHNS5B9n3flV20
         SlUipQt2HS1eqMVQSoJGBzeHO0CqRVKiAn1TaZX6Bk+f6zibiQLZEyb9EitIf907C/Rv
         twcvGTtLX0WyH5xYY8wBYw0MTuLw3C2D+GXMTNPaz1GIkSDaggLmSN2GZVxHsdBP1Tu3
         1EHYk9RHwh1+M2R1Z5d57EeVDI85hWq5ehHOxKCMMGaw+q4J7Iy5Ux2b/PMXrH6sxfx/
         ww7SN5C7023KvEJ7h2ME3aHLZ2pOXbnVqw2a2kjandFbmvgU+3CPm6hbr6U27JACLWi+
         Xc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A7LR8+xj8tu2Z88NPYxTuil5MoHkM97hj2RgE7JqMsQ=;
        b=jnq4+gio4JF73VyBAZAgVElMMQbQkyk6+J3C+LrBA6AOieEcdR8L0LvVFQvdTIC6YI
         Dxq/zs1Vt08/dj/xKoj+96KA07xYsZSfGtsWUcHc4F4d88kntLYeqbadWYZjrSDR6Rb6
         VXjINiL5jj1tpLDMESzex0WhDwB9f4qUtjbzovw2+TqU25/DSQEvwyi0XPUqxEJOnz06
         RnTslvJ08HIsBVnrs0QuCAhCY4OlMbJlt7VjABxR//8k99LDIDcUpNZnZuNVges59srn
         ZAyjaoW5I0dlAo+WFQYeOKKNDS8UcijdcOn2kNNF76poLcJ7HWr2KRN/QnvB12SQoAkr
         DOsw==
X-Gm-Message-State: AFeK/H1Cdelk8U7D7ijG0zr+g1OM8aGIMCkFmTVj9Lh9T41oLgw3zqnvkMeAvSeiOrfcbw==
X-Received: by 10.99.97.6 with SMTP id v6mr7264703pgb.186.1489831983623;
        Sat, 18 Mar 2017 03:13:03 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id r13sm21835908pfg.55.2017.03.18.03.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:13:03 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:12:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 11/12] revision.c: --reflog add HEAD reflog from all worktrees
Date:   Sat, 18 Mar 2017 17:11:52 +0700
Message-Id: <20170318101153.6901-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318101153.6901-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
 <20170318101153.6901-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that add_other_reflogs_to_pending() is a bit inefficient, since
it scans reflog for all refs of each worktree, including shared refs,
so the shared ref's reflog is scanned over and over again.

We could update refs API to pass "per-worktree only" flag to avoid
that. But long term we should be able to obtain a "per-worktree only"
ref store and would need to revert the changes in reflog iteration
API. So let's just wait until then.

add_reflogs_to_pending() is called by reachable.c so by default "git
prune" will examine reflog from all worktrees.
---
 revision.c       | 28 +++++++++++++++++++++++++++-
 t/t5304-prune.sh | 16 ++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index e5d2913b5c..fcf165bd76 100644
--- a/revision.c
+++ b/revision.c
@@ -1134,6 +1134,7 @@ struct all_refs_cb {
 	int warned_bad_reflog;
 	struct rev_info *all_revs;
 	const char *name_for_errormsg;
+	struct ref_store *refs;
 };
 
 int ref_excluded(struct string_list *ref_excludes, const char *path)
@@ -1169,6 +1170,7 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
 {
 	cb->all_revs = revs;
 	cb->all_flags = flags;
+	cb->refs = NULL;
 }
 
 void clear_ref_exclusion(struct string_list **ref_excludes_p)
@@ -1237,17 +1239,41 @@ static int handle_one_reflog(const char *path, const struct object_id *oid,
 	struct all_refs_cb *cb = cb_data;
 	cb->warned_bad_reflog = 0;
 	cb->name_for_errormsg = path;
-	for_each_reflog_ent(path, handle_one_reflog_ent, cb_data);
+	refs_for_each_reflog_ent(cb->refs, path,
+				 handle_one_reflog_ent, cb_data);
 	return 0;
 }
 
+static void add_other_reflogs_to_pending(struct all_refs_cb *cb)
+{
+	struct worktree **worktrees, **p;
+
+	worktrees = get_worktrees(0);
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+
+		if (wt->is_current)
+			continue;
+
+		cb->refs = get_worktree_ref_store(wt);
+		refs_for_each_reflog(cb->refs,
+				     handle_one_reflog,
+				     cb);
+	}
+	free_worktrees(worktrees);
+}
+
 void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 {
 	struct all_refs_cb cb;
 
 	cb.all_revs = revs;
 	cb.all_flags = flags;
+	cb.refs = get_main_ref_store();
 	for_each_reflog(handle_one_reflog, &cb);
+
+	if (!revs->single_worktree)
+		add_other_reflogs_to_pending(&cb);
 }
 
 static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 683bdb031c..6694c19a1e 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -304,4 +304,20 @@ test_expect_success 'prune: handle HEAD in multiple worktrees' '
 	test_cmp third-worktree/blob actual
 '
 
+test_expect_success 'prune: handle HEAD reflog in multiple worktrees' '
+	git config core.logAllRefUpdates true &&
+	echo "lost blob for third-worktree" >expected &&
+	(
+		cd third-worktree &&
+		cat ../expected >blob &&
+		git add blob &&
+		git commit -m "second commit in third" &&
+		git reset --hard HEAD^
+	) &&
+	git prune --expire=now &&
+	SHA1=`git hash-object expected` &&
+	git -C third-worktree show "$SHA1" >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.11.0.157.gd943d85

