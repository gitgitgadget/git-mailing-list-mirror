Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38F020323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbdCRKOS (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:14:18 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36036 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbdCRKOO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:14:14 -0400
Received: by mail-pf0-f196.google.com with SMTP id r137so7476932pfr.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GzCVk2jPUr/rlmMe104UtRYC0jrW/xse769My0DKpS0=;
        b=AIrHkuWOZZaNUorm8wMtXfpu+b5DA3pG/fJ1QvYDv4qSJ5eggRIdTdJkWs4G5WUvWE
         0UEWU9oCSQ5P7CdFz0bdyztnugh802huXCIUmahNrvquNq+tArHZrrwSSsVJgkVFZFhA
         nw+NI71l3GtUXGLU5gC5u87S2b3cq7MB7O3xzL+tQ/yhoWquc7YHZWpixOFvIoR7qt1T
         YOX6uXdxSjfuWDNESNmFo5iGCekLitnD7VfNQZBNojkZQIqfRMYxsVS1lYkyGZ4QaYZq
         C5xFJhn1NrB2OrEWfrYkUTzEC1aIxBIII1W9i0kwi/Hmpnlbn9/eumu2+S29z3zanJ13
         vG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GzCVk2jPUr/rlmMe104UtRYC0jrW/xse769My0DKpS0=;
        b=JdsTJ1ds8M2Ao/RVvphr1quFXW0evW8exlqjVV7o0QTpyXJDOsTxB+F6++8yRcqKcI
         cxFw5RvYV0qiHg04NfF2niIiVlGy37jCWYYRtmZg2LmHJlN8j/haz9OsIx39Kbx0Qi8m
         cK7MAcPjQVWYHKVTshe5L4Ys2ShR0aNDrZi8YFEw7SezTAJLkPFH6KcBJpmbUzYoYQH2
         DmB+Qu64l4SkBX62pfViyhziMQMgHJLe8eWMimhTpjEIo3cgtgrY2LsDn82wJnYwnn81
         VOh2D+F/Su2Q7PObpa006ICeCLr85e957FEdVxBWr39iBCP2KPHgSA8p7vxnal0YVBXC
         IgPA==
X-Gm-Message-State: AFeK/H3grSfbZO62CbGVpfWDhVkDcTqyB/14eoyoTX1+yBiUWNFqCXpiLlp7xB61OMkl8A==
X-Received: by 10.84.139.195 with SMTP id 61mr26650450plr.109.1489831977955;
        Sat, 18 Mar 2017 03:12:57 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id s87sm21838240pfa.29.2017.03.18.03.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:12:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:12:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 10/12] files-backend: make reflog iterator go through per-worktree reflog
Date:   Sat, 18 Mar 2017 17:11:51 +0700
Message-Id: <20170318101153.6901-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318101153.6901-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
 <20170318101153.6901-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

refs/bisect is unfortunately per-worktree, so we need to look in
per-worktree logs/refs/bisect in addition to per-repo logs/refs. The
current iterator only goes through per-repo logs/refs.

Ideally we should have something like merge_ref_iterator_begin (and
maybe with a predicate), but for dir_iterator. Since there's only one
use case for this pattern, let's not add a bunch more code for
merge_dir_iterator_begin just yet.

PS. Note the unsorted order of for_each_reflog in the test. This is
supposed to be OK, for now. If we enforce order on for_each_reflog()
then some more work will be required.
---
 refs/files-backend.c          | 46 ++++++++++++++++++++++++++++++++-----------
 t/t1407-worktree-ref-store.sh | 30 ++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 62d8e0713a..0f423be185 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1172,15 +1172,6 @@ static void files_reflog_path(struct files_ref_store *refs,
 			      struct strbuf *sb,
 			      const char *refname)
 {
-	if (!refname) {
-		/*
-		 * FIXME: of course this is wrong in multi worktree
-		 * setting. To be fixed real soon.
-		 */
-		strbuf_addf(sb, "%s/logs", refs->gitcommondir);
-		return;
-	}
-
 	switch (ref_type(refname)) {
 	case REF_TYPE_PER_WORKTREE:
 	case REF_TYPE_PSEUDOREF:
@@ -3371,6 +3362,7 @@ struct files_reflog_iterator {
 
 	struct ref_store *ref_store;
 	struct dir_iterator *dir_iterator;
+	struct dir_iterator *worktree_dir_iterator;
 	struct object_id oid;
 };
 
@@ -3391,6 +3383,21 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		if (ends_with(diter->basename, ".lock"))
 			continue;
 
+		if (iter->worktree_dir_iterator) {
+			const char *refname = diter->relative_path;
+
+			switch (ref_type(refname)) {
+			case REF_TYPE_PER_WORKTREE:
+			case REF_TYPE_PSEUDOREF:
+				continue;
+			case REF_TYPE_NORMAL:
+				break;
+			default:
+				die("BUG: unknown ref type %d of ref %s",
+				    ref_type(refname), refname);
+			}
+		}
+
 		if (refs_read_ref_full(iter->ref_store,
 				       diter->relative_path, 0,
 				       iter->oid.hash, &flags)) {
@@ -3404,7 +3411,11 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		return ITER_OK;
 	}
 
-	iter->dir_iterator = NULL;
+	iter->dir_iterator = iter->worktree_dir_iterator;
+	if (iter->worktree_dir_iterator) {
+		iter->worktree_dir_iterator = NULL;
+		return files_reflog_iterator_advance(ref_iterator);
+	}
 	if (ref_iterator_abort(ref_iterator) == ITER_ERROR)
 		ok = ITER_ERROR;
 	return ok;
@@ -3425,6 +3436,12 @@ static int files_reflog_iterator_abort(struct ref_iterator *ref_iterator)
 	if (iter->dir_iterator)
 		ok = dir_iterator_abort(iter->dir_iterator);
 
+	if (iter->worktree_dir_iterator) {
+		int ok2 = dir_iterator_abort(iter->worktree_dir_iterator);
+		if (ok2 == ITER_ERROR)
+			ok = ok2;
+	}
+
 	base_ref_iterator_free(ref_iterator);
 	return ok;
 }
@@ -3445,10 +3462,17 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 	struct strbuf sb = STRBUF_INIT;
 
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
-	files_reflog_path(refs, &sb, NULL);
+	strbuf_addf(&sb, "%s/logs", refs->gitcommondir);
 	iter->dir_iterator = dir_iterator_begin(sb.buf);
 	iter->ref_store = ref_store;
 	strbuf_release(&sb);
+
+	if (strcmp(refs->gitdir, refs->gitcommondir)) {
+		strbuf_addf(&sb, "%s/logs", refs->gitdir);
+		iter->worktree_dir_iterator = dir_iterator_begin(sb.buf);
+		strbuf_release(&sb);
+	}
+
 	return ref_iterator;
 }
 
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 5df06f3556..8842d0329f 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -49,4 +49,34 @@ test_expect_success 'create_symref(FOO, refs/heads/master)' '
 	test_cmp expected actual
 '
 
+test_expect_success 'for_each_reflog()' '
+	echo $_z40 > .git/logs/PSEUDO-MAIN &&
+	mkdir -p     .git/logs/refs/bisect &&
+	echo $_z40 > .git/logs/refs/bisect/random &&
+
+	echo $_z40 > .git/worktrees/wt/logs/PSEUDO-WT &&
+	mkdir -p     .git/worktrees/wt/logs/refs/bisect &&
+	echo $_z40 > .git/worktrees/wt/logs/refs/bisect/wt-random &&
+
+	$RWT for-each-reflog | cut -c 42- | sort >actual &&
+	cat >expected <<-\EOF &&
+	HEAD 0x1
+	PSEUDO-WT 0x0
+	refs/bisect/wt-random 0x0
+	refs/heads/master 0x0
+	refs/heads/wt-master 0x0
+	EOF
+	test_cmp expected actual &&
+
+	$RMAIN for-each-reflog | cut -c 42- | sort >actual &&
+	cat >expected <<-\EOF &&
+	HEAD 0x1
+	PSEUDO-MAIN 0x0
+	refs/bisect/random 0x0
+	refs/heads/master 0x0
+	refs/heads/wt-master 0x0
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
2.11.0.157.gd943d85

