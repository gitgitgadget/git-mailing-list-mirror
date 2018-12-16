Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851C21F405
	for <e@80x24.org>; Sun, 16 Dec 2018 12:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbeLPMMp (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 07:12:45 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38348 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbeLPMMp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 07:12:45 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so8601958lja.5
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 04:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dAmM6CeRSag5r4YxWzN/qBwOWbJE2N+PEUKCYnn3tMg=;
        b=Z5wkn/mIbQoTdNos2FARSYFa6qP9m7BObEv0noBHII+8oCGmhEmqXFaA8Zit8DtVqo
         ujZWn5uu7zeBi+eyqYxWJg9wZGJY380wmYiy5yoyQt+OLkSW2i+zaeqnRh8fmFMdMEHt
         gPwnalKMBU8DbaU5JEsZN5WU8jUkMXYU1T84Niq20InJalmaAHzDR1oE3vEa9ny2V+7s
         MivXBDx6QEJcrBHuOQLVpP/WEeZep41ojqXEMKG/15qB8Xw1D5++w8cYVRbrE2IqakwG
         7qTzyYcpruY76GRmKEN6YcC/da6L+nmfK39Ymb+MwkFJBR5R7s6GALfljE12seJie1VY
         5AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dAmM6CeRSag5r4YxWzN/qBwOWbJE2N+PEUKCYnn3tMg=;
        b=pFaaKzOEbW8I3SrhWs9dgPUg9DU95tkqBTiKZ5TK34nvim5jCRtlq1jE/1QZJffn3O
         FfX28HIwSL88Aqw2hB2onfMsMMzN/PbO8Yz+GhIz27lJsJuTFT1wPDsepFShepooAPb4
         Rw1W2Kxpa6oaxqzpPKKp+Q1iHQ6l941RNlOchZB9OpKtIUUm2CbqYySP6YHKab5hFIJl
         ICBpxUC0GVRr/V9oQOIO9/qaAmti6fPXCyVf6EIf99TDm4WhDLWvnypohK1n4tfO43DA
         j3z/mCRnGNoP6MyWmIv65O1A05TEjyqmNuwdTMnpcDJl9M52P0gPahzcSilST045mcqz
         SW9w==
X-Gm-Message-State: AA+aEWZ1D5lG6Myb8fEgCid7cKi0wcF4p1+qEvjNY6XPV7zgx9o/TaxH
        zxSqJx1VLBm4NQXJkPGnK7d9ozNs
X-Google-Smtp-Source: AFSGD/WXCQ7lFZiFESUPemCdqZOdrm91NHAJJC37QFw9dTHO91JPnciZCC/Bddv2poHDFxJ6ih+Anw==
X-Received: by 2002:a2e:9017:: with SMTP id h23-v6mr4046684ljg.71.1544962362748;
        Sun, 16 Dec 2018 04:12:42 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id p10-v6sm1917310ljh.59.2018.12.16.04.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 04:12:41 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] worktree: allow to (re)move worktrees with uninitialized submodules
Date:   Sun, 16 Dec 2018 13:12:39 +0100
Message-Id: <20181216121239.10017-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
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
 builtin/worktree.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5e84026177..af03b83a26 100644
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
@@ -724,20 +725,32 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 static void validate_no_submodules(const struct worktree *wt)
 {
 	struct index_state istate = { NULL };
+	struct strbuf path = STRBUF_INIT;
 	int i, found_submodules = 0;
 
+	if (is_directory(worktree_git_path(wt, "modules")))
+		die(_("working trees containing submodules cannot be moved or removed"));
+
 	if (read_index_from(&istate, worktree_git_path(wt, "index"),
 			    get_worktree_git_dir(wt)) > 0) {
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
-- 
2.20.0.482.g66447595a7

