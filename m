Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A5CC76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbjDGHZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjDGHZS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED7D93E2
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:24:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l26-20020a05600c1d1a00b003edd24054e0so387464wms.4
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35EQYnVpyBv2lx48nBGZzSKw1yCFkFEMZT2pqp7DgYA=;
        b=Quk3BJtao/GxDZ507pm63rbTI9gIdRufCrbCGQfgQLItxd+RnciVzSDS3yf5OEfyly
         s7o+j89ft3stm9WDWOhcIqnF0rD6/1rhFu6bJrSSegOEI3amXM2QnCYNNrJAk37DvI1j
         8re6jZLLHG4TD7UIOCz0PT/nW18v2yfSTnm9d0Z9S1jRw6KwiHzzdvk0Q9t88C5YBm/H
         E9yljOcpAjsEz04iE5BHWZ/B/3xWGbQ+v0n5j9cFx9OiYHGX0WbD+7rdLP7aXtXX8Mz2
         jvuZ1MYlz7CvMMEb1OfpYp/U+9K5OclWfcLzhvbsmOpW8Z6Sy85lQBJEzlqtmrbl3qpC
         aYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35EQYnVpyBv2lx48nBGZzSKw1yCFkFEMZT2pqp7DgYA=;
        b=5JFhsiebr8wU+RXfn3fzB/8FZNcCFgj0K6ToeaXXngKBlE65NGljDPTaoSjSGdf6UN
         4DPFFTXyMZOHSSubBcUpPsufvqlvOPsX2qFHP0D7DRlVqK2zqhSwljf9UxtPC7jRns0G
         7MPJR1sn0xZB7F9ldKhgD41zc6KneAe7Y2bpvkK98Io53J7QWrjHOpsbr5BxKphoRZZM
         /KZa7Gpo9dPWxCpJHalVVeBKxECMJ4BFE5pJHu6rKH19z21cyQV9o8DpJWehdnX+cTto
         IAl6Nf5yvhC3JYt0bnSVk0L1mibk5TzBGYDuSD/ogg25EAc+F/5aPbX+Qc6iV/EwDIjs
         Q8qA==
X-Gm-Message-State: AAQBX9f8D+1cyD9a0j52U4ioTMIGH1g07hZo6FFW+/EiSegaGUmJtYJM
        dLn7vfG0FzrNtc4pzvDWiP+C61Z5Xve2KA==
X-Google-Smtp-Source: AKy350YcDW3c+ZtmXwQX/wgp2GBBf2eGFVcfy0NJZAaRATJE3gxQ1kRirc5fkeyIJD5Zm+6Mu4Rl5w==
X-Received: by 2002:a7b:ce85:0:b0:3ed:ce6f:e86e with SMTP id q5-20020a7bce85000000b003edce6fe86emr582204wmj.23.1680852284944;
        Fri, 07 Apr 2023 00:24:44 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:44 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 04/14] replay: introduce pick_regular_commit()
Date:   Fri,  7 Apr 2023 09:24:05 +0200
Message-Id: <20230407072415.1360068-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
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
index 16efac11ab..ea12d4c8fe 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -80,6 +80,35 @@ static struct commit *create_commit(struct tree *tree,
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
+	pickme_tree = get_commit_tree(pickme);
+	base_tree = get_commit_tree(base);
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
@@ -91,7 +120,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct rev_info revs;
 	struct commit *commit;
 	struct merge_options merge_opt;
-	struct tree *next_tree, *base_tree, *head_tree;
+	struct tree *head_tree;
 	struct merge_result result;
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct strbuf branch_name = STRBUF_INIT;
@@ -166,7 +195,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	result.tree = head_tree;
 	last_commit = onto;
 	while ((commit = get_revision(&revs))) {
-		struct commit *base;
+		struct commit *pick;
 
 		fprintf(stderr, "Rebasing %s...\r",
 			oid_to_hex(&commit->object.oid));
@@ -176,26 +205,11 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
-		base = commit->parents->item;
-
-		next_tree = get_commit_tree(commit);
-		base_tree = get_commit_tree(base);
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
 
 	merge_switch_to_result(&merge_opt, head_tree, &result, 1, !result.clean);
-- 
2.40.0.228.gb2eb5bb98e

