Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18057CD80C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjJJMjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjJJMj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:39:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF17C110
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4054f790190so54666885e9.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941563; x=1697546363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JKhnpjl5sOQBmmvXRBONT2nlbP6VD+7ya0BpBA/o80=;
        b=lhQ8H53n+ELUjiEbXnTfXmAe+Zfx44O2FhssrGRv/jN3utoWHS0Y4ZuUrteFjeaBQL
         DAaaPLoqgWLHyRVBHMcei+9RIsBtqBcmBp5iWMcnVy3MExWGDZTgoO6ECfnVwL9Et8gw
         /yPOM2G1O2CrEnQfiGhBe+3JdobFGx4LxtVXzS1o68gn75sJ2X8KlutpydckBD8q5Uq/
         NDJzfzHAtt9eDoucb5cBKf0/hOmdRmj6gIu91KGCxWMVKZREHiMAxPX6pFInVIAC3iPD
         XiIbwKZsUd48qakPoL0GywIiiq/fbxQB1j3MEtPoIAmRwSaeUeRQ7Sv5VYpdV0mE7LRh
         xrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941563; x=1697546363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JKhnpjl5sOQBmmvXRBONT2nlbP6VD+7ya0BpBA/o80=;
        b=A3EvTb0MOjGltPjP1wGdXZefWgXCdM8LPn9jT9pIGEs7H6LVH7BbPJBVXqvxBNcYG1
         VXPb+ebta35882UfktLUWXxPCtLPmA0Z/9ggjY2FtrrsMkzy1gsYd7gg/DUL3ncPxPaD
         tFjqOvvaZjw6+NR13AejM1d59i4SfMZGaBukYPEBpeYbHacS/xzVs/XUoNtdgLXd1X0l
         HjjqbkaAWlyw2TQ2ieh3k7dTzse6yeFlPb0UEdmSeH+HodTKeaqQRIZaO/Gp2j3m15+4
         ziALsDQmFu683pWX70F/Mac3JK9kpZ+XWyr8oWCCWisgqcUChk71TE6YLhnTbW+lLRi9
         d7iA==
X-Gm-Message-State: AOJu0Yz354GgKQVQrR4AFEB7CbBe+QlN4CTsORBj29AwH8al6ybxnAm2
        uJcXPTdypKs+tyz0/DBUq5GDl5RKQonRMw==
X-Google-Smtp-Source: AGHT+IFoSoeo2wBWo416yoKwe8LEc4t9qITD6JYFR9AxpOmXBWGPBUSGEQ1yImPFUnTuEx2cHkBA8A==
X-Received: by 2002:a05:600c:2150:b0:402:8c7e:ba5 with SMTP id v16-20020a05600c215000b004028c7e0ba5mr14800534wml.18.1696941562693;
        Tue, 10 Oct 2023 05:39:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:516d:299b:cbff:be05])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm14071689wma.45.2023.10.10.05.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:39:21 -0700 (PDT)
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
Subject: [PATCH v5 13/14] replay: add --contained to rebase contained branches
Date:   Tue, 10 Oct 2023 14:38:46 +0200
Message-ID: <20231010123847.2777056-14-christian.couder@gmail.com>
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

Let's add a `--contained` option that can be used along with
`--onto` to rebase all the branches contained in the <revision-range>
argument.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replay.txt | 12 +++++++++++-
 builtin/replay.c             | 12 ++++++++++--
 t/t3650-replay-basics.sh     | 29 +++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index 2c09232c8f..e9697fcfb6 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -9,7 +9,7 @@ git-replay - Replay commits on a new base, works on bare repos too
 SYNOPSIS
 --------
 [verse]
-'git replay' (--onto <newbase> | --advance <branch>) <revision-range>...
+'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
 
 DESCRIPTION
 -----------
@@ -96,6 +96,16 @@ top of the exact same new base, they only differ in that the first
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
 When calling `git replay`, one does not need to specify a range of
 commits to replay using the syntax `A..B`; any range expression will
 do:
diff --git a/builtin/replay.c b/builtin/replay.c
index d458837e9c..12689f1c89 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -258,6 +258,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	const char *advance_name = NULL;
 	struct commit *onto = NULL;
 	const char *onto_name = NULL;
+	int contained = 0;
 
 	struct rev_info revs;
 	struct commit *last_commit = NULL;
@@ -268,7 +269,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	int ret = 0;
 
 	const char * const replay_usage[] = {
-		N_("git replay (--onto <newbase> | --advance <branch>) <revision-range>..."),
+		N_("git replay ([--contained] --onto <newbase> | --advance <branch>) <revision-range>..."),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -278,6 +279,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto", &onto_name,
 			   N_("revision"),
 			   N_("replay onto given commit")),
+		OPT_BOOL(0, "contained", &contained,
+			 N_("advance all branches contained in revision-range")),
 		OPT_END()
 	};
 
@@ -289,6 +292,10 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		usage_with_options(replay_usage, replay_options);
 	}
 
+	if (advance_name && contained)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--advance", "--contained");
+
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	argc = setup_revisions(argc, argv, &revs, NULL);
@@ -340,7 +347,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
index 68a87e7803..d6286f9580 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -114,4 +114,33 @@ test_expect_success 'replay fails when both --advance and --onto are omitted' '
 	test_must_fail git replay topic1..topic2 >result
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
2.42.0.339.g663cbc8ab1

