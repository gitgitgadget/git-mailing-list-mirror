Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25C0420899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754057AbdHWMik (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:38:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33842 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMij (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:38:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id m6so1358222pfm.1
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tazi3CeH2ilymkXOw3TMhgZ/ElWfql+ffVLS+UFX82U=;
        b=arlBzTWP6KILjZtbRrzIQ/kWy3+4BiN1kWIZDQPCSk0gLxZLre2ybYxqht3e/MErRx
         jadoRRFD7HKPBJ7iX6wApfFPIVM/CzGLtpk0bmJ6PrsZI7m6a6KIyh7iqB0qkGFMpgva
         udmZPIsIQwVrkxT/+u2xwbSq+TU1y9YE5+GSAqdib80edC1E9Ps4Q783nCwGLTEcmeQh
         gP074nmUk/2NLv2pT22XZk7Gra8YOkNqantb6xoVCGMrEvrG8YjYW/kV/jlt819YRFUU
         dZHFnb0oiNTEOQid9TAY8pXIJqj+VM4q+Mvk2wOnEsj15wU66lzlZN6JQqdPTvRPZ7iC
         aczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tazi3CeH2ilymkXOw3TMhgZ/ElWfql+ffVLS+UFX82U=;
        b=MiETPQfUVsPo7EV2afBQKHwt9LsmuhnhGZ2NNrDMHQNTQX41uuvnJElohzt+Q4nw/o
         Q/T65Sm6vJQ+KdB0dfHtHQlWRq5y3/E+KxsM02ZbeHWXNXjJXtCD9fSZsBoAYQCAM0si
         7hrIMHMEuIcgUuroZeDXSHiqyObPZYu0fB+CSc/ER+FMP1cfTa3tTjbk6darxPQMocJZ
         J/n2azdkKc3mHMyuMuLdqWmsCaY6DlZm6ZU4FIjGWiH+kdDMB7eHX3083GDiAg6YJ69O
         twtfyCKuIbm5JvFGGymUOapfGMTRuQsSfxoLimK29ZvaPTfBuuL21WhAqsJELZJ9vrmB
         dfTg==
X-Gm-Message-State: AHYfb5hcDrQ0uvstpKzXWg6cHDT1cnfi8xGVgNnjLX6rTQtzKy/TH0pt
        xoc8KbDh+QKJ3PJO
X-Received: by 10.84.237.2 with SMTP id s2mr2890735plk.70.1503491918773;
        Wed, 23 Aug 2017 05:38:38 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id w63sm2956490pfw.28.2017.08.23.05.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:38:37 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:38:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 13/16] revision.c: --reflog add HEAD reflog from all worktrees
Date:   Wed, 23 Aug 2017 19:37:01 +0700
Message-Id: <20170823123704.16518-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c       | 28 +++++++++++++++++++++++++++-
 t/t5304-prune.sh | 16 ++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 0e98444857..d100b3a3be 100644
--- a/revision.c
+++ b/revision.c
@@ -1132,6 +1132,7 @@ struct all_refs_cb {
 	int warned_bad_reflog;
 	struct rev_info *all_revs;
 	const char *name_for_errormsg;
+	struct ref_store *refs;
 };
 
 int ref_excluded(struct string_list *ref_excludes, const char *path)
@@ -1168,6 +1169,7 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
 	cb->all_revs = revs;
 	cb->all_flags = flags;
 	revs->rev_input_given = 1;
+	cb->refs = NULL;
 }
 
 void clear_ref_exclusion(struct string_list **ref_excludes_p)
@@ -1236,17 +1238,41 @@ static int handle_one_reflog(const char *path, const struct object_id *oid,
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

