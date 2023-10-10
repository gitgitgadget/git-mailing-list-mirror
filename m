Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAB0CD80C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjJJMja (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjJJMjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:39:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B4CAF
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so52842225e9.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941551; x=1697546351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7wh5OwEy8UhTyV+/y0fYzwQph084MhSujI9Va4XL0Q=;
        b=JEyF9XSea4+L5cvGdF42NZZql9IvDmiYNJ6umg/N/C4Lv7n9s9tK1/sSZ1x+x9leWf
         Z8ypDNhvg30AoqYhGmJXUvSg0yvgs+0aAUMFdywlS0NCgSY7WHO9oSbYXpqgf1xqa2PC
         C6PBE+Xz5a998GKjK3Mq7B7DLbhibLoJqMcELc+Ln5uJPOm0jGyhwr7Le9GSjstsarwH
         tJ93uvhu2nrvQQEtRT7WxcMhnHdbU/KPEhVrUctFoPkNC793aFuqQ0tzzWREbBTIJ1ag
         lLbMT1Iplg0Eqld4eivEtmaGsvhDYEdSMswlwsdfWUfpq+bC5LYuCgnbhtx5fxDV9N7E
         5bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941551; x=1697546351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7wh5OwEy8UhTyV+/y0fYzwQph084MhSujI9Va4XL0Q=;
        b=w/87WnahojeKWKjZEH+C3AcZ3YgCQJN2BjACrY+An1Tvt4mU7c1icKz1oYxh241aMG
         tv0a77tEkMwBux7xlDv5kZJKo/qkUG1iayqT7dvsNurKPw3duhIFjva4jfhBxZltP2tp
         O6czLDRP+KtI19sL7mzaheVh/6ijSitRAtZOi6suVeWdPeHpOrGoospRouD2yAxTzbvm
         mvejDKYp5RDGpsU2gPc/gdGon85GTgaS6bSzRra4ZAnYeWY7UwEmY4kGvIbMOW/nopF0
         b1TJHPCvRy4we8xrahYa4dCbGJbhgOg7AJnDN67qkeyFfTbNHXcDW7O4NuNzsnMmJXlA
         vcaA==
X-Gm-Message-State: AOJu0YwapDVQyAlpIDjU9enBIRz/qIc9qONwwzS3Ho5AFt8wrm1xbGe7
        Yh0ILI5TUcj8AuAVBm0PGKImuGANXM07nw==
X-Google-Smtp-Source: AGHT+IGoJXbs+YMxpTnqKxvAWkiIgWkLsCkN0os2Mk0E5ni2pmcUsnxszQYvAvkY3o/3Fes6QgA2tg==
X-Received: by 2002:a5d:538b:0:b0:319:67ac:4191 with SMTP id d11-20020a5d538b000000b0031967ac4191mr15124083wrv.37.1696941550451;
        Tue, 10 Oct 2023 05:39:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:516d:299b:cbff:be05])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm14071689wma.45.2023.10.10.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:39:09 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Dragan Simic <dsimic@manjaro.org>,
        Linus Arver <linusa@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 05/14] replay: introduce pick_regular_commit()
Date:   Tue, 10 Oct 2023 14:38:38 +0200
Message-ID: <20231010123847.2777056-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.339.g663cbc8ab1
In-Reply-To: <20231010123847.2777056-1-christian.couder@gmail.com>
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com>
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
2.42.0.339.g663cbc8ab1

