Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493EBEC874B
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 18:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbjIGSIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343820AbjIGSIM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 14:08:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13141FF5
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 11:07:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so1700138a12.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694110067; x=1694714867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lv7GiXQdh1VNlUx7vsDCS8ejSwSZoYuJnQcoYwDHgdc=;
        b=VQY5/RcHUnntvC+sOaumYE+1rB4SrRh0EHfknMMhljPjEMbGpG1AUeU4HkPWsz6NtM
         70FXrAhqKLtimmeAvYDVcKwztYzpHv8/vGUZXMXqbfdyqRQ7i2BInY4AbEkF8wsQsNa2
         y+pBJQB9MXngIjCR1BzSCax2D06/gcoFJVJX3C906544yKvNLEc/TsS7LmOXJY9OvKjR
         3CZQQ06bvehqcAAjq6055MGT2eBaR7Bf5NZ1Z/q7ln8j0aqgpVQToKHaRgGs3dVrhA10
         ZjM6Qru9Sm9fnxlVtmCVOJ2INcSPdv6Fo9LdgtFN7zYZv128DcA/iAWLawhUHooc/iSv
         p4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694110067; x=1694714867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lv7GiXQdh1VNlUx7vsDCS8ejSwSZoYuJnQcoYwDHgdc=;
        b=tBl3+FHICOMOWI5YM4Lx/KQ5WmmLSVLOrMtZAW8F858/Lf4TeLT07TnwiBfmTiZ4c7
         Az1MaBewKfi5TBg3npS5qPmn+QcsiqttEh4ewEBrKaPN7CwwlwOSjkuUwLwreH72we+s
         JH6Ij+E2Y/lIcVh17RkFEKwbY+3/mL/JLzUlBUtaYJzt45fF8xrN8tnCSXmei3wrE0F9
         qiLcl87Y5DGEVycdWLb8WZXBMg6MNolkGmpNY9zmYNRYDLmfX3K96oB5kDCwpoC6CfxT
         ry4hBYmXfje39uZmSTqZsayh9VbJj7tQGU6BVU2lx4YcTECQkr/YM58shzOXkVQnnuzk
         YKTA==
X-Gm-Message-State: AOJu0YxaMG+UoGIEKWbDwppeZNyV8xbaNLjpr2HV4TWnnpByXHpf86Y+
        5Dpu4jD1fb45C/LkxoejbdxtHwhZQ+k=
X-Google-Smtp-Source: AGHT+IHDEISlyeiIkbbgFBBN6yCw5NMFg9CyoPnsTxdqYj3hsoLlEjxBP2SKkHiFQDGjay3djduwhA==
X-Received: by 2002:a5d:4b87:0:b0:319:6d91:28bf with SMTP id b7-20020a5d4b87000000b003196d9128bfmr3966526wrt.60.1694078830332;
        Thu, 07 Sep 2023 02:27:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:27:09 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 05/15] replay: introduce pick_regular_commit()
Date:   Thu,  7 Sep 2023 11:25:11 +0200
Message-ID: <20230907092521.733746-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.126.gcf8c984877
In-Reply-To: <20230907092521.733746-1-christian.couder@gmail.com>
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com>
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
index f3fdbe48c9..c66888679b 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -89,6 +89,35 @@ static struct commit *create_commit(struct tree *tree,
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
@@ -100,7 +129,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct rev_info revs;
 	struct commit *commit;
 	struct merge_options merge_opt;
-	struct tree *next_tree, *base_tree, *head_tree;
+	struct tree *head_tree;
 	struct merge_result result;
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct strbuf branch_name = STRBUF_INIT;
@@ -175,7 +204,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	result.tree = head_tree;
 	last_commit = onto;
 	while ((commit = get_revision(&revs))) {
-		struct commit *base;
+		struct commit *pick;
 
 		fprintf(stderr, "Rebasing %s...\r",
 			oid_to_hex(&commit->object.oid));
@@ -185,26 +214,11 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
2.42.0.126.gcf8c984877

