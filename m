Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC7920899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbdHWMie (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:38:34 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37686 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMid (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:38:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id r62so1346829pfj.4
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwVBZ2gUtylFmulhT4TbR6rkHUgyCiOcUYIcbAwUVdo=;
        b=iZbD+DO8gDmHaML5tA4/N3bWbald76mRHTyVY1qt9Gksk/Ay79REikNoly8JkF2LOL
         V9Nm52K3f4TxNQIBHPOqrM+K4fBP3tgIRZeRBdSWq5aW+ytXIzrSdDaGLF60wbKEgzPu
         n0/D1LgS4EWfxgMZVZr0FPFXLEMmyq5qk4Zf19Tqb7zKi3pg11qLbuZlQOof2OykIQUB
         Sr+ohBF1g5FmCdvm5b+/rscoFg87NZgn516I0cfgqUCZ8abjxYnlvxL9OM/s8kFgeQhE
         SBxoPkK/ySTYhX9F4+Fn/EB7JqX7FQoJPsnstqr3DoE0Ge+x6rlvRbvE6glttTSH475l
         5kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwVBZ2gUtylFmulhT4TbR6rkHUgyCiOcUYIcbAwUVdo=;
        b=cOPEoU3zXff5yWP1GIwKuTq6EILreJOfTsmI+LAAEp5kcru8j41TEC8DqEmo0GmnJ+
         stTdRUy2yceg515QPGo53sYdASFWiXvKrc56HO4ZrHsr+AutCIASN4dhKwJ3He3wyWp8
         eezvls3P2Bmfv4EhEn+cwnHhXXxG4MGe4A/YfsY4E5i9Vt6TzJttsm545AAbcVzi3Dan
         /Bp+4KdPN7ex3w1xUJF079a315xBOp8ATdOdGqX86jzSHkIlg+k4i+vvu9GSCyAv1VGT
         4TXyCCgkEuYXZXvhVj6RQfqtEB1urdrcZutGod6Win9LDwXQeiVh+ePHLm/sjLnl6W2X
         vMlQ==
X-Gm-Message-State: AHYfb5jXEHv6VEqxfcOfo/6L0dlIcU9ERFV1qW/kGZ0YXw9BVsKYXuML
        mmGdTIkMHB/GupwF
X-Received: by 10.98.86.154 with SMTP id h26mr2600337pfj.250.1503491912642;
        Wed, 23 Aug 2017 05:38:32 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id l24sm3031350pgu.91.2017.08.23.05.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:38:31 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:38:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 12/16] files-backend: make reflog iterator go through per-worktree reflog
Date:   Wed, 23 Aug 2017 19:37:00 +0700
Message-Id: <20170823123704.16518-13-pclouds@gmail.com>
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

refs/bisect is unfortunately per-worktree, so we need to look in
per-worktree logs/refs/bisect in addition to per-repo logs/refs. The
current iterator only goes through per-repo logs/refs.

Use merge iterator to walk two ref stores at the same time and pick
per-worktree refs from the right iterator.

PS. Note the unsorted order of for_each_reflog in the test. This is
supposed to be OK, for now. If we enforce order on for_each_reflog()
then some more work will be required.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c          | 59 +++++++++++++++++++++++++++++++++----------
 t/t1407-worktree-ref-store.sh | 30 ++++++++++++++++++++++
 2 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5cca55510b..d4d22882ef 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -106,15 +106,6 @@ static void files_reflog_path(struct files_ref_store *refs,
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
@@ -2055,23 +2046,63 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	files_reflog_iterator_abort
 };
 
-static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
+static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
+						  const char *gitdir)
 {
-	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_READ,
-			       "reflog_iterator_begin");
 	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
 	struct strbuf sb = STRBUF_INIT;
 
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
-	files_reflog_path(refs, &sb, NULL);
+	strbuf_addf(&sb, "%s/logs", gitdir);
 	iter->dir_iterator = dir_iterator_begin(sb.buf);
 	iter->ref_store = ref_store;
 	strbuf_release(&sb);
+
 	return ref_iterator;
 }
 
+static enum iterator_selection reflog_iterator_select(
+	struct ref_iterator *iter_worktree,
+	struct ref_iterator *iter_common,
+	void *cb_data)
+{
+	if (iter_worktree) {
+		/*
+		 * We're a bit loose here. We probably should ignore
+		 * common refs if they are accidentally added as
+		 * per-worktree refs.
+		 */
+		return ITER_SELECT_0;
+	} else if (iter_common) {
+		if (ref_type(iter_common->refname) == REF_TYPE_NORMAL)
+			return ITER_SELECT_1;
+
+		/*
+		 * The main ref store may contain main worktree's
+		 * per-worktree refs, which should be ignored
+		 */
+		return ITER_SKIP_1;
+	} else
+		return ITER_DONE;
+}
+
+static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
+{
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_READ,
+			       "reflog_iterator_begin");
+
+	if (!strcmp(refs->gitdir, refs->gitcommondir)) {
+		return reflog_iterator_begin(ref_store, refs->gitcommondir);
+	} else {
+		return merge_ref_iterator_begin(
+			reflog_iterator_begin(ref_store, refs->gitdir),
+			reflog_iterator_begin(ref_store, refs->gitcommondir),
+			reflog_iterator_select, refs);
+	}
+}
+
 /*
  * If update is a direct update of head_ref (the reference pointed to
  * by HEAD), then add an extra REF_LOG_ONLY update for HEAD.
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

