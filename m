Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C335EC873D
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 16:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbjIGQhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbjIGQhO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 12:37:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D552BE4F
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 09:28:28 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-501cef42bc9so1921267e87.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694104046; x=1694708846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEwUmNrS0BKhHHzzGjTQecxqyzmmDDSLK21otX6KA40=;
        b=sY3FJCewKE9xzslyHiVZcvhITdQl85NLnj3ZeZPh5oZKxVUat5SqcXHDlr6ppcuR6C
         JJDQ65tjWcvZLp6zs+oUCYmSrgUtVIP1M27Ewf1/K1aBlQnWLSD7jMlghocoAfk9J/78
         2fH2dvXX75Jf0lUnh9gtvZGHQ9BBL9XsVvKEUxmIhqfQg3zMDBUW1EpqWGUjzLwRQtH5
         VANRz0gVDCOYYfBovQ38r0N8LO38Po651MMPzEpUjiaxhsH5B/xo+DDWC7kY7czTXTrx
         Le5YmP5kTRtm3h3w4TohKXWZqhSiHSSop5tx/O6LcqFKrKvUPnSrqXxFYuItiPbpMXg/
         yMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104046; x=1694708846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEwUmNrS0BKhHHzzGjTQecxqyzmmDDSLK21otX6KA40=;
        b=dW3zEcSJRNd5jVcdh9bA5CPzV7kcU8Qyu3Rzq/RdTuhnusPeuQO9lm04tFPzh5VlUx
         O6jKcPDVoEr3NKVeqfTZfk0w8L9YJNI/QSDINRiQKNtrnhkTZLv4hOLfQDoh1lHEKyFe
         a5zg/kH79YohdJC5/DpFPkQPJPwQ97STCt0zpUKeAZyqpRPiHdUxwidihFHemEHNcuaM
         EXMKgP6JQbCtb9E8jAXqq9BnqgRxaMzGWCeTvrM3K8zUOsEbnrKEJ6fNOsZ3Hsbw/iiZ
         yB+7c/+6EX0bGY7ItyPlaDpnyTYEYwrsIcbYHrJ2R/R9tP1sjFSVxMbPlC1EPqmc1Jdc
         88jw==
X-Gm-Message-State: AOJu0Yx6aB2ExKr7TrR7caciM2lT4VGJdJjo7p908OisBxgu7niR6Xwn
        h8JUrxeSIyX4plTH4ZHRdemzuc4E594=
X-Google-Smtp-Source: AGHT+IGIK1OO0sELtBe3YN7q0fLVrANzQRhy4A5YtXGiSQw2FeIVGHRTAot9UrwroYbunYBMN9VD7Q==
X-Received: by 2002:adf:ed8f:0:b0:318:8ad:f9f with SMTP id c15-20020adfed8f000000b0031808ad0f9fmr4274358wro.24.1694078964676;
        Thu, 07 Sep 2023 02:29:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:29:24 -0700 (PDT)
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
Subject: [PATCH v4 14/15] replay: add --contained to rebase contained branches
Date:   Thu,  7 Sep 2023 11:25:20 +0200
Message-ID: <20230907092521.733746-15-christian.couder@gmail.com>
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
index 5c5c15237d..b94c39b161 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -9,7 +9,7 @@ git-replay - Replay commits on a different base, without touching working tree
 SYNOPSIS
 --------
 [verse]
-'git replay' (--onto <newbase> | --advance <branch>) <revision-range>...
+'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
 
 DESCRIPTION
 -----------
@@ -93,6 +93,16 @@ top of the exact same new base, they only differ in that the first
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
index 6b89964be9..a7d36a639c 100644
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
 	int ret = 0, i;
 
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
 
@@ -303,6 +306,10 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		usage_with_options(replay_usage, replay_options);
 	}
 
+	if (advance_name && contained)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--advance", "--contained");
+
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	argc = setup_revisions(argc, argv, &revs, NULL);
@@ -364,7 +371,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
index 1919f7d5d1..57d2ef9ea4 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -130,4 +130,33 @@ test_expect_success 'replay fails when both --advance and --onto are omitted' '
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
2.42.0.126.gcf8c984877

