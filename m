Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A71CFB6
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9COq6Rh"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BE0181
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:52:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507e85ebf50so1120068e87.1
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933154; x=1699537954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOY5TXzUrXgol4ZLdv8qSFDtUXg8XEh0zqgahCLrWBs=;
        b=E9COq6RhBGlYFHXmcTFIvHPSyiCNi9DBFLvloP/TtrwR4osjgp0gUpstd7wiRoiRWm
         4ytNM0BZnf3iUTO0RQvddYsqUmmqukKcOn2tFV6VEhnFnwprjS7az3odMVQfmIF0TxPj
         k8UfZlwibZeFA61Qa1BF/FsaVFamS4kx2qKjBM6cKhSKylJoW5liVa/KdhSoXRAZpXdD
         mNLPP6G7fX67sEBXodabrdUptE8tdYTtVEXqXW9juZQFQB6qOdTI0yLCGsK02RTxvSxG
         LeWt9aTdDFPbBigmDBvA/N2+xzpkv276wF2PrMbBYx4uol+Z/gR6MhOaOzXLy2PlFBjB
         /4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933154; x=1699537954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOY5TXzUrXgol4ZLdv8qSFDtUXg8XEh0zqgahCLrWBs=;
        b=mWpRh95i78I1rWJJI+wAXqH9cfKxmZRpiIZHi/ELYB6I0XW9u8TqSUoaZ1MbR+ln5W
         EE6fOjahfc28Qyh1JYR9JnjTvvyNeHLOQbP1EKyg/0zRVoMSuYI8fuhnBU8npKRToLfr
         Nvx89jqQ2oPHakEE2a70pv9LOU7bE4HGSS2sukWTEU8zvqzMXSMgrh4h7zeaiUsRdSPY
         12f5EWDU+y9yeCLuXlJ4A9CijDfhapbdJwjlUaKnDpoJ+hSKJ0SERj6eJVFBFD2ClodO
         q+KZzvQoBpRgWhcRB2fg3qjWjU/W8X2wH/xJclJZofZQ0jz9TSs4vweZ0XftzdzlHHuG
         HQpQ==
X-Gm-Message-State: AOJu0Yz48kBHkYrl+b6rEc1q0Ws1U2GCbS98CAWwUXEzPr+ImyEemZJI
	cpvGl9DhFwBw1qHyaQztoD4a7K79peo=
X-Google-Smtp-Source: AGHT+IGNROzekgObRjLBebst9Nzqvfu8L++ontJXV9xQIxxwMZpbCy02bRugzmZC8A2ocn/5YquUgQ==
X-Received: by 2002:a05:6512:3051:b0:509:459b:13ae with SMTP id b17-20020a056512305100b00509459b13aemr2679493lfb.53.1698933153785;
        Thu, 02 Nov 2023 06:52:33 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:116d:4e46:313c:1f52:4963:91b6])
        by smtp.gmail.com with ESMTPSA id e6-20020adffc46000000b0030647449730sm2514996wrs.74.2023.11.02.06.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:52:33 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 13/14] replay: add --contained to rebase contained branches
Date: Thu,  2 Nov 2023 14:51:50 +0100
Message-ID: <20231102135151.843758-14-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.496.g529a7fda40
In-Reply-To: <20231102135151.843758-1-christian.couder@gmail.com>
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

Let's add a `--contained` option that can be used along with
`--onto` to rebase all the branches contained in the <revision-range>
argument.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replay.txt | 12 +++++++++++-
 builtin/replay.c             | 13 +++++++++++--
 t/t3650-replay-basics.sh     | 29 +++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index e0c85cebf1..e7551aec54 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -9,7 +9,7 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-'git replay' (--onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL
+'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL
 
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
index 145ce9d9a3..08ff9bab5e 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -258,6 +258,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	const char *advance_name = NULL;
 	struct commit *onto = NULL;
 	const char *onto_name = NULL;
+	int contained = 0;
 
 	struct rev_info revs;
 	struct commit *last_commit = NULL;
@@ -268,7 +269,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	int i, ret = 0;
 
 	const char * const replay_usage[] = {
-		N_("git replay (--onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL"),
+		N_("git replay ([--contained] --onto <newbase> | --advance <branch>) "
+		   "<revision-range>... # EXPERIMENTAL"),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -278,6 +280,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto", &onto_name,
 			   N_("revision"),
 			   N_("replay onto given commit")),
+		OPT_BOOL(0, "contained", &contained,
+			 N_("advance all branches contained in revision-range")),
 		OPT_END()
 	};
 
@@ -289,6 +293,10 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		usage_with_options(replay_usage, replay_options);
 	}
 
+	if (advance_name && contained)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--advance", "--contained");
+
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	/*
@@ -353,7 +361,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
2.42.0.496.g529a7fda40

