Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2FD31F405
	for <e@80x24.org>; Sun, 16 Dec 2018 14:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbeLPOrE (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 09:47:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43267 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPOrE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 09:47:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id 83-v6so8739289ljf.10
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 06:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SUoNaigX/lLHprVkFJHPUUk1JHby9OWgb1fZVf1kgM=;
        b=aW78J3liXeFpMxe8KP22VohHzPh8ABiEz6th3eFk4aARPAZ4rZR3UBL88PgyW8Jy5M
         GuSFA3C6ok8wQ5OkciuXXVE02O2QU4GPfihcJi0QFPIfD6YtKjnoAm+5JNbnT1/dI2nG
         eIyBQfTww7Lh+DGKU4NHQP1cZFDXuDpcMd8uHF/d13kxkJ6hC+aOJH0fLOTx0GA5WqAA
         l2UyJ7/9EadOapkAIOEE2J2hoSahyEakNi+uARp96dyqZ1mHIXQ/V1VE5UYZrM7pu2l6
         uOrY8dlfP1oOY4XkqDR4xm/zByHW2jgE1SMgvCjNBxjJqVhkaNsdIKBDW4rtCoDAR2H7
         6oCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SUoNaigX/lLHprVkFJHPUUk1JHby9OWgb1fZVf1kgM=;
        b=GYFb+mbs2mOuArVbjicjdQrcOObJNLlzy4fTO4mnN3PguTQqZBA0muqRc7EIQcrhl1
         Idwt9QFWZRiH7fq5ZOB9THu5P8Q7ar2pKRssUYiZ/80lpL4Z7DRHS2+QADBgtMKQVci/
         LyIu+Ft5JAiLyMvrhippsG6YlWSy4Sf5n0AwQkxrpg1yChCmfml2tXdaudaFU7JpZNZK
         +pWwzW3HvYtdQNQOY/33QXeYcRF6AaHsMfnPRBykzQSvQye0ucN3WJMqWxhIPMOAOeTw
         5lCM4MlSRK4GD468a3l1jaDxVmoMPDH4SMjMFDS5wHk/0QWFmyyRHA8aOFR+4DBqshw3
         eeYw==
X-Gm-Message-State: AA+aEWavYJ2oY+F4mbWiKKXxI3WFpIJuURQNJFeWs8jTSwF9Ss7pYJw1
        A3FTK1JiG5B6sGqX8vEbrrM=
X-Google-Smtp-Source: AFSGD/WdabNSUFs+HkoNWs3V7XFFS+SBw9DLnxUQLSGgniKmf7iaIZoUV29jV/WTtfgGFVysvY400g==
X-Received: by 2002:a2e:93d7:: with SMTP id p23-v6mr4898517ljh.22.1544971622114;
        Sun, 16 Dec 2018 06:47:02 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id r76-v6sm2000325ljr.83.2018.12.16.06.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 06:47:00 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com, sunshine@sunshineco.com
Cc:     git@vger.kernel.org
Subject: [PATCH v2] worktree: allow to (re)move worktrees with uninitialized submodules
Date:   Sun, 16 Dec 2018 15:46:57 +0100
Message-Id: <20181216144657.31181-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181216121239.10017-1-pclouds@gmail.com>
References: <20181216121239.10017-1-pclouds@gmail.com>
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
 Fixed Eric's comment. I was a bit annoyed by the duplicate die() too
 but didn't think of adding "else" in front of "if (read_index"

 builtin/worktree.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

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
-- 
2.20.0.482.g66447595a7

