Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B527BC7EE2D
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjEIRzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEIRys (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:54:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757AE55B8
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:54:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f4249b7badso27164105e9.3
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654867; x=1686246867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVlA7yR+DbSQx0buRO+VZzlXgCV6F7afLH5DDhknons=;
        b=hYfLeps9TnE24BxIXQLzKuSVMTOKIMnSPFN42N5zjmglzpL0ZlCLvYkjWxpXj6e1Fs
         oKsz9Oi0vNKDqkJA6XRTw2LIMKtdbfcTu/y01aDoDbBFLciMx8+SpCj0LFOXncRSOH3/
         BGF9f4Nfm5YOV8adCR5F6Ozkni46BqIj8P9MABV8JLQyOKQYKALXTpx+JDdgxHOALeqI
         FNSwGUKIvdn66/CKvi585fNLF0Ixi5M22Of1BXkuOtOSGG45CAnql9rdilXiQXoLHTqP
         pXPuUBwfHEShc2rnroM2vf/NAPKaBdeJ7prp4mGPs6FLcx5W+Sg6PuxNRWnw6YG9DZ+F
         zUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654867; x=1686246867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVlA7yR+DbSQx0buRO+VZzlXgCV6F7afLH5DDhknons=;
        b=EC69NMDyBUzce/VlUOFU/PxbUq2hxuNnwFKqo9YCbEdf4hj66fHMMZ/DY2cjuuukAD
         OvBx1kkJafk2ztYCAShAHsELMxugpf3wMPeiyzHKb8TxkOWJFH89UJfcuJuYIyIWnfVJ
         fEYG2sDK8bgfX86uv1rVS+0l/P9NozFNgjsGe0Efo5P5U1szKFpduswNluPmqA8fK8xb
         rbRZdodxgNUeZrcn5GIzHAjoXAznenoUzSh9NIlUUvOY3ZHLQIlMLWRIa1hdZk56fZbz
         hD5ymzoSrgZ6g/Ln4gnCn0nPxDiM7nWWQB+ALimbv03A29TlMu2FfLD4VqiLLbtIgKzY
         S+4Q==
X-Gm-Message-State: AC+VfDx78VVIj/P05oWttm56hg/pwBHt2aaFfKmygk1tqrQafm5fnxk4
        5t/VisHw6rcjqhKNiHqAUFzbUrQSgiU=
X-Google-Smtp-Source: ACHHUZ7XzdevpMs0fQJkUuKcV7HpdzNfeKyWDDWTnQC1SKGcF+5GFNJuMqnGfkfNQUSYpLRDarBwLA==
X-Received: by 2002:a7b:c391:0:b0:3f4:29dc:6ebf with SMTP id s17-20020a7bc391000000b003f429dc6ebfmr2645878wmj.38.1683654867285;
        Tue, 09 May 2023 10:54:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:df87:46e2:83de:c1fa])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm8584435wml.18.2023.05.09.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:54:26 -0700 (PDT)
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
Subject: [PATCH v2 14/15] replay: add --contained to rebase contained branches
Date:   Tue,  9 May 2023 19:53:46 +0200
Message-ID: <20230509175347.1714141-15-christian.couder@gmail.com>
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

Let's add a `--contained` option that can be used along with
`--onto` to rebase all the branches contained in the <revision-range>
argument.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replay.txt | 16 +++++++++++++++-
 builtin/replay.c             | 12 ++++++++++--
 t/t3650-replay-basics.sh     | 29 +++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index 439b2f92e7..3e06ab2f5e 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -9,7 +9,7 @@ git-replay - Replay commits on a different base, without touching working tree
 SYNOPSIS
 --------
 [verse]
-'git replay' (--onto <newbase> | --advance <branch>) <revision-range>...
+'git replay' [--contained] (--onto <newbase> | --advance <branch>) <revision-range>...
 
 DESCRIPTION
 -----------
@@ -90,6 +90,20 @@ top of the exact same new base, they only differ in that the first
 provides instructions to make mybranch point at the new commits and
 the second provides instructions to make target point at them.
 
+What if you have a stack of branches, one depending upon another, and
+you'd really like to rebase the whole set?
+
+------------
+$ git replay --contained --onto origin/main origin/main..tipbranch
+update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
+update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
+update refs/heads/tipbranch ${NEW_tipbranch_HASH} ${OLD_tipbranch_HASH}
+------------
+
+In contrast, trying to do this with rebase would require 3 separate
+rebases, eacho of which involves a different <ONTO> and <UPSTREAM> and
+forces you to first check out each branch in turn.
+
 When calling `git replay`, one does not need to specify a range of
 commits to replay using the syntax `A..B`; any range expression will
 do:
diff --git a/builtin/replay.c b/builtin/replay.c
index c146f38f58..4d24eb95d8 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -256,6 +256,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	const char *advance_name = NULL;
 	struct commit *onto = NULL;
 	const char *onto_name = NULL;
+	int contained = 0;
 
 	struct rev_info revs;
 	struct commit *last_commit = NULL;
@@ -266,7 +267,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	int ret = 0, i;
 
 	const char * const replay_usage[] = {
-		N_("git replay (--onto <newbase> | --advance <branch>) <revision-range>..."),
+		N_("git replay [--contained] (--onto <newbase> | --advance <branch>) <revision-range>..."),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -276,6 +277,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto", &onto_name,
 			   N_("revision"),
 			   N_("replay onto given commit")),
+		OPT_BOOL(0, "contained", &contained,
+			 N_("advance all branches contained in revision-range")),
 		OPT_END()
 	};
 
@@ -301,6 +304,10 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		usage_with_options(replay_usage, replay_options);
 	}
 
+	if (advance_name && contained)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--advance", "--contained");
+
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	argc = setup_revisions(argc, argv, &revs, NULL);
@@ -363,7 +370,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			continue;
 		while (decoration) {
 			if (decoration->type == DECORATION_REF_LOCAL &&
-			    strset_contains(update_refs, decoration->name)) {
+			    (contained || strset_contains(update_refs,
+							  decoration->name))) {
 				printf("update %s %s %s\n",
 				       decoration->name,
 				       oid_to_hex(&last_commit->object.oid),
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index bca405c431..3fb4167e69 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -122,4 +122,33 @@ test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
 	test_cmp expect result-bare
 '
 
+test_expect_success 'using replay to also rebase a contained branch' '
+	git replay --contained --onto main main..topic3 >result &&
+
+	test_line_count = 2 result &&
+	cut -f 3 -d " " result >new-branch-tips &&
+
+	git log --format=%s $(head -n 1 new-branch-tips) >actual &&
+	test_write_lines F C M L B A >expect &&
+	test_cmp expect actual &&
+
+	git log --format=%s $(tail -n 1 new-branch-tips) >actual &&
+	test_write_lines H G F C M L B A >expect &&
+	test_cmp expect actual &&
+
+	printf "update refs/heads/topic1 " >expect &&
+	printf "%s " $(head -n 1 new-branch-tips) >>expect &&
+	git rev-parse topic1 >>expect &&
+	printf "update refs/heads/topic3 " >>expect &&
+	printf "%s " $(tail -n 1 new-branch-tips) >>expect &&
+	git rev-parse topic3 >>expect &&
+
+	test_cmp expect result
+'
+
+test_expect_success 'using replay on bare repo to also rebase a contained branch' '
+	git -C bare replay --contained --onto main main..topic3 >result-bare &&
+	test_cmp expect result-bare
+'
+
 test_done
-- 
2.40.1.491.gdff9a222ea

