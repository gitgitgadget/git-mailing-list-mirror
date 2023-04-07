Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427AFC77B6E
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbjDGHZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbjDGHZT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E276FAA
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:24:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t4so36368310wra.7
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN9vFUWxPoulKIlSZYk1lZU5x2q73yl+mO73oAkxjtY=;
        b=KbUXGU25uIKlGr3taKKE24MSYGp+6Ru39qjPq2mZm+HWFnzOADA6JPPTL5TmGHxgdp
         S4L5XmwoHQfSugINu+XnECOevF2pqVTkT2mWlUjAHTaLx8PZCepvCLEZk7Hwd5yv9rym
         f0QoIyysCvCVY8NSvOEadXzAjuCjs4N7wde+uWyYflz958PFFs9qEWSCvMfm/wp+SfDN
         c05PQo84JuIDsaO32PBK65/ZtSxLFZPaJgo9lOpXHTStMt4Tu/k97uPj0+9W+u1B2Mwr
         1TVYfiD0ty/Y5kGmugu3aB3TCuiBhU5BzWTeJuRrhoTgtLO4OE6yw8D2sI7570netPVf
         BUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hN9vFUWxPoulKIlSZYk1lZU5x2q73yl+mO73oAkxjtY=;
        b=PNDeGqPuCM7+1dziFtiaP2/+xzlBqdvQYzMTKQfACHV+pSuMF67k2yKB+SBnca11PX
         qYKi5kFrGhk5GrctU1Il2dkA2rTeoO5DejtWr2VCPof8Y6j/jK4j0/MgnVX80cQ4+bPW
         OPf12oPGldYAdJfHzi/R6JuLaxDOCCd/Z0yzppUfYY8OJdoyHq719sgk3eEz2H6E74Mg
         FS+uG4c/LxH5GURwR5BXV6OD0n1CRDulf1E4tY4qiw/zbVT/RehCOGwFKVawsDvuZZao
         zy8V+Wi5dFkI+OFtqBwODOWmefYA9q0mXRf1TH4hO8GyTGeosd4TO5idof0zfgzlz1Th
         Ut0w==
X-Gm-Message-State: AAQBX9ef6f6AAkCIs5iyj3OC7WxIUUfTLs98GIZBGxZQvXgJDr5aXewL
        btmT3wnqjQdtWKFenZmpB9pHprFWlFZDZA==
X-Google-Smtp-Source: AKy350YOzWuLt9ql+qxCgLruIwHWt2OkQZMmJhXZQrTO7hoagmeYZ0l7CagYqTUWDoKs6JopfmqKNA==
X-Received: by 2002:a5d:6b03:0:b0:2ef:b257:b46c with SMTP id v3-20020a5d6b03000000b002efb257b46cmr430251wrw.29.1680852289013;
        Fri, 07 Apr 2023 00:24:49 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:48 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/14] replay: very coarse worktree updating
Date:   Fri,  7 Apr 2023 09:24:10 +0200
Message-Id: <20230407072415.1360068-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In case of conflict, let's just update the worktree and index. And then
let's just die() as this command doesn't have ways to handle conflicts
yet.

Note that we might want to improve this behavior in the case of a bare
repository in a future commit.

We also have to lock the index only after all the commits have been
picked, so that in case of conflict the index is not already locked.
Note that this locking of the index will be removed in a following
commit as we will not want to modify it anymore.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index a331887d12..9c795c05a7 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -152,10 +152,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	onto = peel_committish(onto_name);
 	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
-	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
-	if (repo_read_index(the_repository) < 0)
-		BUG("Could not read index");
-
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
@@ -194,12 +190,39 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			die(_("replaying merge commits is not supported yet!"));
 
 		pick = pick_regular_commit(commit, last_commit, &merge_opt, &result);
-		if (!pick)
-			break;
+		if (!pick) {
+			/* TODO: handle conflicts in sparse worktree instead */
+			struct object_id head;
+			struct tree *head_tree;
+			struct lock_file lock = LOCK_INIT;
+
+			repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
+			if (repo_read_index(the_repository) < 0)
+				BUG("Could not read index");
+
+			get_oid("HEAD", &head);
+			head_tree = parse_tree_indirect(&head);
+			printf("Switching from %s to %s.\n",
+			       oid_to_hex(&head_tree->object.oid),
+			       oid_to_hex(&result.tree->object.oid));
+			merge_switch_to_result(&merge_opt, head_tree, &result,
+					       1, 1);
+			if (write_locked_index(&the_index, &lock,
+					       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+				die(_("unable to write %s"), get_index_file());
+
+			die(_("failure to pick %s; cannot handle conflicts yet"),
+			    oid_to_hex(&commit->object.oid));
+		}
+
 		last_commit = pick;
 		last_picked_commit = commit;
 	}
 
+	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
+	if (repo_read_index(the_repository) < 0)
+		BUG("Could not read index");
+
 	merge_switch_to_result(&merge_opt, head_tree, &result, 1, !result.clean);
 
 	if (result.clean < 0)
-- 
2.40.0.228.gb2eb5bb98e

