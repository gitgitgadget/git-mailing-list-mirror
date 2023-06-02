Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46228C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjFBK2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjFBK16 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:27:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE68A2693
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:26:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f60e730bf2so18996115e9.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701558; x=1688293558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l59AcLLCUVroqGYZSEcJWJ80YBF7a4Xqu5LX5BrHy4M=;
        b=f1KIUy1AVMXjEmRmquqHOSfEBjexMypCWkO4M6m7zKXfmaig5sYqLBvqjmsIUwFNfo
         hvw02lEF8KJzuwhAN/Rda4dxUb/VG773UtE6GlCs5zEh/TX5HL8NRdO9d3AxsxUcSdhN
         GAr1RR7TpG7oxPgnRFkFUasVutXVeM6bb7BoW6T4hrbUHCo1ZGZAaMf+veCt2+hViv1G
         OERXzmsICis9KinKV0FrqMwkobQNKa855og1BUFtbk5Ay5e7rZRUkcrYN7P63GJhC8tc
         c+Q6aFPJFUrms2yN+x/sY1dikYbLAisP8p0uuYqVvGYKTVA6QX/ZBKCeIVBJOITAsLt/
         VOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701558; x=1688293558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l59AcLLCUVroqGYZSEcJWJ80YBF7a4Xqu5LX5BrHy4M=;
        b=F/Ba1Ab6aYkecJLDFVtCjd7fo0BOWSAugYnGFJ3HtkJavN3bdQbhq7AyNB0sYwWQWz
         lrABOFHryY/tCa3iAcEL1PZuIDA2iqbvyte1uw65KoQvYcB1tV6KaMkT8IzIjO5o9gbv
         eWuNm0tOp3o+M229dNLGALSSOQ90KJ/j2gt8kGHy1x+h7BJsB/rwSahAF3tHb+CeL34f
         lBIalyM2MRFLkjqhmON1IvuaU+SZBo/7koFylcfNfdSQx8WcH5+yDU7Gc7Z0XwpXWp4d
         Kn/QzFTFQucFg4K7SyOkCnhVIzorQMqjbKIkUT0zg1ByHQCk2GlPtGNfuC0Azy4xFHtl
         hGGw==
X-Gm-Message-State: AC+VfDwDT5377QTrGy0gBH3iNJnlIJALCR6GdWtT1k6O9y98Q0gdPL/9
        DaGOoNXBf6dL/w+7wD8vc/ORn2PtOBWoLw==
X-Google-Smtp-Source: ACHHUZ4SDl8vmhhMBOoSciwy2q431ROsvn8oU9hEOmFV3PpYIhN0LwkB9blu5G0JwpdemmwpRm2NHA==
X-Received: by 2002:a1c:6a15:0:b0:3f6:89e:2716 with SMTP id f21-20020a1c6a15000000b003f6089e2716mr1783519wmc.33.1685701558318;
        Fri, 02 Jun 2023 03:25:58 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1169:70dc:520b:5de9:c23d:7cde])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1468035wmk.33.2023.06.02.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:25:57 -0700 (PDT)
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
Subject: [PATCH v3 05/15] replay: introduce pick_regular_commit()
Date:   Fri,  2 Jun 2023 12:25:23 +0200
Message-ID: <20230602102533.876905-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.15.ga6d88fc8f0
In-Reply-To: <20230602102533.876905-1-christian.couder@gmail.com>
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
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
index 2537adbaea..319020f5fd 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -88,6 +88,35 @@ static struct commit *create_commit(struct tree *tree,
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
@@ -99,7 +128,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct rev_info revs;
 	struct commit *commit;
 	struct merge_options merge_opt;
-	struct tree *next_tree, *base_tree, *head_tree;
+	struct tree *head_tree;
 	struct merge_result result;
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct strbuf branch_name = STRBUF_INIT;
@@ -174,7 +203,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	result.tree = head_tree;
 	last_commit = onto;
 	while ((commit = get_revision(&revs))) {
-		struct commit *base;
+		struct commit *pick;
 
 		fprintf(stderr, "Rebasing %s...\r",
 			oid_to_hex(&commit->object.oid));
@@ -184,26 +213,11 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
2.41.0.15.ga6d88fc8f0

