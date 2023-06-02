Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6855CC7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbjFBKbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbjFBK33 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:29:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51186199D
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:27:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so2432585e87.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701573; x=1688293573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5iobcDlK6GSIrK6NEtemfFGrUTfsyd7OyGW/DnyfiQ=;
        b=XTeo3tNn7b9TNzZEEo0CeyAPAzVOzNWktFkRKzu2BQJtpoU7qfduE0yUvglr9r+Zr6
         GG2X6MOKB1Y0EOvtxu60jQhhjHHpWZ5t4N/xCJma+4bm0aD1jgec1/i/4Mvye/Mk+V5v
         grdv2ErE+vp7RGVZEIbNk62C/oQ+QtDwIi/o2gqIiTGfONtkq6AjDZ7xYYsLgdGrBOGE
         ytj0/IacfQP3fGcA9/Q6O7cl16xcpz5otf33e0JWIeusd21AdIbpTov4rPEXn5NlhaZ0
         95sAF5QTegiwa2reQDOGvNPEHRB6CYlKHQTsWcr+MKBwwcfWH9X7FRlLJNSlVkAHreAW
         +tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701573; x=1688293573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5iobcDlK6GSIrK6NEtemfFGrUTfsyd7OyGW/DnyfiQ=;
        b=g56JKn0jyjvTaFcD+eoVcKMfNaj/cLsVAmR4d+YLKkXm1bhP5M0S/JqkiBbt9YUdf8
         Hfs4YT0QLcsyrdzZJy2Z3q05wFUifL5yEMaextE7O/SXalz4BV11azpt8xbQys2V9eVO
         /9tGioAi7YNfnjOV0o0iZTLH3fiNnsFxrlK+XMcn4u8mC+FTndOwFD0YdKd6EJHaZWJk
         lralnPQITt6qvN4zftH3wALTGXWJ4r3h5FqNfdsVsCtIrNKi7YdYTKDtWFj/Jvt4hEIU
         L9VIZ53pKOMwwYWK3CSJNIzcKT0RiuafOqXJi/z8c/LSE20tIkI66VocVs6Y3vdqwZbI
         UKyw==
X-Gm-Message-State: AC+VfDyguGJtRR9zZy0qD5UoBUwXkqp6AMRG2LCOOMGGX+Ui87HskZVJ
        O+5ukmCN6vUiGoNrwiBBeMYwST+fbQR6gg==
X-Google-Smtp-Source: ACHHUZ6YBly7SuDw+HtlEQ0GMdsIDlApluKLLP3nY5l4zby/VTuNK2Bez0uuZZ9tpAKz5+nEtA0YCg==
X-Received: by 2002:a05:6512:1025:b0:4f1:43de:7c3 with SMTP id r5-20020a056512102500b004f143de07c3mr1189017lfr.51.1685701572613;
        Fri, 02 Jun 2023 03:26:12 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1169:70dc:520b:5de9:c23d:7cde])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1468035wmk.33.2023.06.02.03.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:26:12 -0700 (PDT)
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
Subject: [PATCH v3 14/15] replay: add --contained to rebase contained branches
Date:   Fri,  2 Jun 2023 12:25:32 +0200
Message-ID: <20230602102533.876905-15-christian.couder@gmail.com>
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
index 439b2f92e7..6fcaa44ef2 100644
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
@@ -90,6 +90,16 @@ top of the exact same new base, they only differ in that the first
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
index 4b64d15159..9b182eaa90 100644
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
2.41.0.15.ga6d88fc8f0

