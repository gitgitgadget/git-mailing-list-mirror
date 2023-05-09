Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CE7C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjEIRyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjEIRyU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:54:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077A04492
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:54:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3062b101ae1so3983947f8f.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654857; x=1686246857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmAhgMg/go7BfZNR2XIJebJfGuLtTMiCBNJpp5IeYpw=;
        b=P+BSlHEhsrLt+/alrAdxW9imdUWHRAD9XlGpTT02njOd1DEZHU7HzRrYMoh7d2P8JN
         6lJgsY3wcPNlYkbnIZj6UG2ybubwAS4M4HZy8CwJ1GPMw0yT84ZHTu6CdGfUs515kekQ
         fW8BHJ2xtI7Nj+eAP6hX5L5K+MzUjwBnNjFb9ByupHzl6miuGnVt0qlFrnNp9Ofn/nEh
         v091vu7U0R2wxNAtUGAVOrJLVTpOFAzSM2pxdSIo62QnVx6R6uzMl9ZTguRHKP5ChRhe
         sQdA8Va0liMmgDzTZx2woE/OMCZPd/d3fOY5MJDnt7Ud7/vfY9HR6fRHdVypyL7SGiej
         BUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654857; x=1686246857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmAhgMg/go7BfZNR2XIJebJfGuLtTMiCBNJpp5IeYpw=;
        b=haBMTkRkygaVjRpRbuVcJKov5zw7FA0Qrq1jZ2uwHTDwAYxqx+OQP5FAaGK9QtXy/j
         rF/r2hIE72ezg0E7hFevTIH52LMgQ3gxV3qLSM+HrFnP2Rr+2SmG+BuMU2JFAWs25aiG
         EJYVO7lCSB+Nil/HrciWXm4DiIQxtstzyFHN2DmggY+jW5YHfNJlYqppVsOfOpNvPDQF
         Bi7bU703MrEUlgQGoxVApkxl1ZaVXgqFkSG0xP+5M6ftHee+l2g0TmBFxxjvNF5sDECB
         /axw9RuFSnijzhv6c/D4c9sAJiXrpJvvt3z0OtvthQhbFjW8wQqGX0AnC713SKN7UGGu
         0Qng==
X-Gm-Message-State: AC+VfDy3wT3anaU9pprC3XdzywUDV2xIINoGqgsDSxQUY/QqxUOa3R0S
        7w3WL8rT3aVGH2TGOrxsXgoK2kWT0Y0=
X-Google-Smtp-Source: ACHHUZ5rU+6helpafl3U8nPhl/N9lE56vp54c8UBtbRHAVjFa3bGJ7Ip1AuWAcfxfNI0/jOsi38CRw==
X-Received: by 2002:a5d:684e:0:b0:307:3bb:10b5 with SMTP id o14-20020a5d684e000000b0030703bb10b5mr9569958wrw.64.1683654856622;
        Tue, 09 May 2023 10:54:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:df87:46e2:83de:c1fa])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm8584435wml.18.2023.05.09.10.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:54:16 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 05/15] replay: introduce pick_regular_commit()
Date:   Tue,  9 May 2023 19:53:37 +0200
Message-ID: <20230509175347.1714141-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.1.491.gbdd8a3b3e1
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Let's refactor the code to handle a regular commit (a commit that is
neither a root commit nor a merge commit) into a single function instead
of keeping it inside cmd_replay().

This is good for separation of concerns, and this will help further work
in the future to replay merge commits.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 54 ++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 366ea8ef08..f087d97353 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -87,6 +87,35 @@ static struct commit *create_commit(struct tree *tree,
 	return (struct commit *)obj;
 }
 
+static struct commit *pick_regular_commit(struct commit *pickme,
+					  struct commit *last_commit,
+					  struct merge_options *merge_opt,
+					  struct merge_result *result)
+{
+	struct commit *base;
+	struct tree *pickme_tree, *base_tree;
+
+	base = pickme->parents->item;
+
+	pickme_tree = repo_get_commit_tree(the_repository, pickme);
+	base_tree = repo_get_commit_tree(the_repository, base);
+
+	merge_opt->branch2 = short_commit_name(pickme);
+	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
+
+	merge_incore_nonrecursive(merge_opt,
+				  base_tree,
+				  result->tree,
+				  pickme_tree,
+				  result);
+
+	free((char*)merge_opt->ancestor);
+	merge_opt->ancestor = NULL;
+	if (!result->clean)
+		return NULL;
+	return create_commit(result->tree, pickme, last_commit);
+}
+
 int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
@@ -98,7 +127,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct rev_info revs;
 	struct commit *commit;
 	struct merge_options merge_opt;
-	struct tree *next_tree, *base_tree, *head_tree;
+	struct tree *head_tree;
 	struct merge_result result;
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct strbuf branch_name = STRBUF_INIT;
@@ -173,7 +202,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	result.tree = head_tree;
 	last_commit = onto;
 	while ((commit = get_revision(&revs))) {
-		struct commit *base;
+		struct commit *pick;
 
 		fprintf(stderr, "Rebasing %s...\r",
 			oid_to_hex(&commit->object.oid));
@@ -183,26 +212,11 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
-		base = commit->parents->item;
-
-		next_tree = repo_get_commit_tree(the_repository, commit);
-		base_tree = repo_get_commit_tree(the_repository, base);
-
-		merge_opt.branch2 = short_commit_name(commit);
-		merge_opt.ancestor = xstrfmt("parent of %s", merge_opt.branch2);
-
-		merge_incore_nonrecursive(&merge_opt,
-					  base_tree,
-					  result.tree,
-					  next_tree,
-					  &result);
-
-		free((char*)merge_opt.ancestor);
-		merge_opt.ancestor = NULL;
-		if (!result.clean)
+		pick = pick_regular_commit(commit, last_commit, &merge_opt, &result);
+		if (!pick)
 			break;
+		last_commit = pick;
 		last_picked_commit = commit;
-		last_commit = create_commit(result.tree, commit, last_commit);
 	}
 
 	merge_finalize(&merge_opt, &result);
-- 
2.40.1.491.gdff9a222ea

