Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5FC11F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 05:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfAEFIr (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 00:08:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46527 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfAEFIr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 00:08:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so18308235pgp.13
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 21:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3/DKNYXozTWsGfi58On5CfdWqaqxGmaOQ2sB2GddbX4=;
        b=aFp7IuOBU81AzPsy+5iSJKz4Dx5fuH475OWls4fz4EwcdiWv5YUAWTejLdImYb2/w7
         DVhbF7EzTxE0lb0Z2ee6sbFjYf3HodadcQPbB7MRPmuxJAPULuQUQmal+bLQ4JpAMSBw
         cXRDkXXt/c18EJNgyjRzJm2mWaAnp8bSZJ03ORyfx3qMxDeHHbCVTiT6Aa0r0knsilZT
         f7+LT5WsXpK+OCwL7usHfI5KIvrs6yMPB3DjBt6OyCMNpXpheEXexLfPYntk00h/ourv
         sD2SvYjmwQ3QHGxv0DdVx+sChjwaE9PlCeGx1D3gxKAqgg0xDZT1iRM08H+9fBR2+Lx8
         emUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/DKNYXozTWsGfi58On5CfdWqaqxGmaOQ2sB2GddbX4=;
        b=Cq5STK50ST3tEzZBunyU66Anp6Tq5TNIzUbI9fxQ2ETJvoFRHB9BTBLtMB7lEPkJzp
         ETr7noVfzm7IkaOmIP1GoMIfyjKDz5EEunAOkxsfwZ25Gc135N5CfpiGtEp4MVeKXGmD
         RK9qrlFmA1xYIZzlrfsZihaNThq4plQWggsjt/z0ZQZAzAv906AiwKoxaLWkhoAux6s9
         lhqS5dbXiq1KgcbryiGShjcKNcZ8nHDpL3Nu0rQFVbE3q/C90XdjiPGe2EYnEAb96Nbu
         ZyiO/6j7w7HQ2Sj6lsqqPiGj5YXGk2+pj53O5ne8FdZbqWAEKCRKWUCX2makYWE5Jo7m
         2Ttw==
X-Gm-Message-State: AA+aEWZc6HwnLu4FxQ2RYG4xLP8b8iGUs7x5cwHY5rQpqLculRmV5zDK
        ucBtR+caUdsmrf8hAx8OtOY=
X-Google-Smtp-Source: AFSGD/W/08Bg+3A0TSFBstmDr+KYrqgvSc9RdY7smfqdfpGxdbCbNlqoi9ZGO4zyo5uFV7Am/QzCMw==
X-Received: by 2002:a62:d005:: with SMTP id p5mr55104728pfg.175.1546664926396;
        Fri, 04 Jan 2019 21:08:46 -0800 (PST)
Received: from ash ([171.232.90.54])
        by smtp.gmail.com with ESMTPSA id z14sm73759959pgv.47.2019.01.04.21.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 21:08:45 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 05 Jan 2019 12:08:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] worktree: allow to (re)move worktrees with uninitialized submodules
Date:   Sat,  5 Jan 2019 12:08:40 +0700
Message-Id: <20190105050840.18409-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181216144657.31181-1-pclouds@gmail.com>
References: <20181216144657.31181-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uninitialized submodules have nothing valueable for us to be worried
about. They are just SHA-1. Let "worktree remove" and "worktree move"
continue in this case so that people can still use multiple worktrees
on repos with optional submodules that are never populated, like
sha1collisiondetection in git.git when checked out by doc-diff script.

Note that for "worktree remove", it is possible that a user
initializes a submodule (*), makes some commits (but not push), then
deinitializes it. At that point, the submodule is unpopulated, but the
precious new commits are still in

    $GIT_COMMON_DIR/worktrees/<worktree>/modules/<submodule>

directory and we should not allow removing the worktree or we lose
those commits forever. The new directory check is added to prevent
this.

(*) yes they are screwed anyway by doing this since "git submodule"
    would add submodule.* in $GIT_COMMON_DIR/config, which is shared
    across multiple worktrees. But it does not mean we let them be
    screwed even more.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v3 adds tests. This test file is being renamed by
 tg/checkout-no-overlay but it seems rename is handled correctly, no
 merge conflicts on 'pu'.

 builtin/worktree.c       | 29 +++++++++++++++++++++++------
 t/t2028-worktree-move.sh | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5e84026177..3f9907fcc9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -9,6 +9,7 @@
 #include "refs.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "submodule.h"
 #include "refs.h"
 #include "utf8.h"
 #include "worktree.h"
@@ -724,20 +725,36 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 static void validate_no_submodules(const struct worktree *wt)
 {
 	struct index_state istate = { NULL };
+	struct strbuf path = STRBUF_INIT;
 	int i, found_submodules = 0;
 
-	if (read_index_from(&istate, worktree_git_path(wt, "index"),
-			    get_worktree_git_dir(wt)) > 0) {
+	if (is_directory(worktree_git_path(wt, "modules"))) {
+		/*
+		 * There could be false positives, e.g. the "modules"
+		 * directory exists but is empty. But it's a rare case and
+		 * this simpler check is probably good enough for now.
+		 */
+		found_submodules = 1;
+	} else if (read_index_from(&istate, worktree_git_path(wt, "index"),
+				   get_worktree_git_dir(wt)) > 0) {
 		for (i = 0; i < istate.cache_nr; i++) {
 			struct cache_entry *ce = istate.cache[i];
+			int err;
 
-			if (S_ISGITLINK(ce->ce_mode)) {
-				found_submodules = 1;
-				break;
-			}
+			if (!S_ISGITLINK(ce->ce_mode))
+				continue;
+
+			strbuf_reset(&path);
+			strbuf_addf(&path, "%s/%s", wt->path, ce->name);
+			if (!is_submodule_populated_gently(path.buf, &err))
+				continue;
+
+			found_submodules = 1;
+			break;
 		}
 	}
 	discard_index(&istate);
+	strbuf_release(&path);
 
 	if (found_submodules)
 		die(_("working trees containing submodules cannot be moved or removed"));
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 33c0337733..939d18d728 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -112,6 +112,26 @@ test_expect_success 'move locked worktree (force)' '
 	git worktree move --force --force flump ploof
 '
 
+test_expect_success 'move a repo with uninitialized submodule' '
+	git init withsub &&
+	(
+		cd withsub &&
+		test_commit initial &&
+		git submodule add "$PWD"/.git sub &&
+		git commit -m withsub &&
+		git worktree add second HEAD &&
+		git worktree move second third
+	)
+'
+
+test_expect_success 'not move a repo with initialized submodule' '
+	(
+		cd withsub &&
+		git -C third submodule update &&
+		test_must_fail git worktree move third forth
+	)
+'
+
 test_expect_success 'remove main worktree' '
 	test_must_fail git worktree remove .
 '
@@ -185,4 +205,21 @@ test_expect_success 'remove cleans up .git/worktrees when empty' '
 	)
 '
 
+test_expect_success 'remove a repo with uninitialized submodule' '
+	(
+		cd withsub &&
+		git worktree add to-remove HEAD &&
+		git worktree remove to-remove
+	)
+'
+
+test_expect_success 'not remove a repo with initialized submodule' '
+	(
+		cd withsub &&
+		git worktree add to-remove HEAD &&
+		git -C to-remove submodule update &&
+		test_must_fail git worktree remove to-remove
+	)
+'
+
 test_done
-- 
2.20.0.482.g66447595a7

