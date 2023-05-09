Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB750C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjEIRzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjEIRyp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:54:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB27527B
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:54:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f42bcf5df1so10496825e9.3
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654865; x=1686246865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jed0s0nDhEXcW0zfqv2FioKJY+CdAbH5nQ5W4h0WUAQ=;
        b=ZBgNHyvI7u/lkCZicMicf0cvpG6v3ksjcuKlClZ8wqBXsfkzzlQjfP4jEuDngLBdNm
         pRcJpG8Ixw0QtoPZ6iuDxGgte5C4mJlknSysaIdbTnUAiXEhB49W4ylt8ZG8KbS0QYJo
         UTujlDaNCjjnyj3ojUnff7gy5rZwuhpkAFzWFRzy2DncQVA6s0YSKI7+7QmPe5GLpcJJ
         t0v+4OF9tebwRwu34OSqxpc84WqJmr+LfHNLi4zZ0X1Matu06IaR3mmnA1AzKEtdJDdQ
         Ls1bHWrvlBOgwaaXeyMxkut8QAqwyEQkqRlS+hN0yTKi/ZXFpQdRwq7VJN/Gn56zFjuX
         3+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654865; x=1686246865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jed0s0nDhEXcW0zfqv2FioKJY+CdAbH5nQ5W4h0WUAQ=;
        b=MFTMWqg3NNwiVxpv/d6xkXSPhYON3OuJuN1VuKN0W9Tj5t9I4BxeRkjBs2BtVv/oWk
         ULJR8Wyk/OKRzAyDVlI7hwQukUmxnpC2m0YNk3QqX+y2Nnf6vPYK2d/ISn9wr03EBfVi
         tGJRYEUqPQ0zMjd1M2hKwYlhac2FjS2x5RpGFnMqZwMaggh2v9abFxWeug+Gaa0U4gES
         IIGiCLNl3jaVGA6KcWojtkU4/GIelo+EX9xRrv+MPjFnCisMAGXiAOizTEj0vwB7YjI1
         526OhOzVQiacZCnRYzJ3wH6SNNd0IEyM1vm9AC9GzjHlQ1OhF838OKiYjd03k8ofT/+3
         6wTQ==
X-Gm-Message-State: AC+VfDxQ1M1rp5nokJRbhIsIFJGXiRfhHIQcM7WXAmnsg0K0sl8wGd4s
        Jo8teP1Zv2Sj9xMamMMU1/5lkJdAHQg=
X-Google-Smtp-Source: ACHHUZ7TNlXv8ydeVyyEJle4+vnwqKzQ4UH3maGAgxedJU+Y22EXEmwXPofJHWoUtD1Jjyy4RLMbXw==
X-Received: by 2002:a7b:c84c:0:b0:3f4:2506:3d58 with SMTP id c12-20020a7bc84c000000b003f425063d58mr4880690wml.23.1683654864765;
        Tue, 09 May 2023 10:54:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:df87:46e2:83de:c1fa])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm8584435wml.18.2023.05.09.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:54:23 -0700 (PDT)
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
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 12/15] replay: disallow revision specific options and pathspecs
Date:   Tue,  9 May 2023 19:53:44 +0200
Message-ID: <20230509175347.1714141-13-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.1.491.gbdd8a3b3e1
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A previous commit changed `git replay` to make it accept standard
revision ranges using the setup_revisions() function. While this is good
thing to make this command more standard and more flexible, it has the
downside of enabling many revision related options accepted and eaten by
setup_revisions().

Some of these options might make sense, but others, like those
generating non-contiguous history, might not. Anyway those we might want
to allow should probably be tested and perhaps documented a bit, which
could be done in future work.

For now it is just simpler and safer to just disallow all of them, so
let's do that.

Other commands, like `git fast-export`, currently allow all these
revision specific options even though some of them might not make sense,
as these commands also use setup_revisions() but do not check the
options that might be passed to this function.

So a way to fix those commands as well as git replay could be to improve
or refactor the setup_revisions() mechanism to let callers allow and
disallow options in a relevant way for them. Such improvements are
outside the scope of this work though.

Pathspecs, which are also accepted and eaten by setup_revisions(), are
likely to result in disconnected history. That could perhaps be useful,
but that would need tests and documentation, which can be added in
future work. So, while at it, let's disallow them too.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c         | 27 ++++++++++++++++++++++++++-
 t/t3650-replay-basics.sh | 16 ++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index c855e1a128..7b3c0f2bc4 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -119,7 +119,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct commit *commit;
 	struct merge_options merge_opt;
 	struct merge_result result;
-	int ret = 0;
+	int ret = 0, i;
 
 	const char * const replay_usage[] = {
 		N_("git replay --onto <newbase> <revision-range>..."),
@@ -135,6 +135,20 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
 
+	/*
+	 * TODO: For now, we reject any unknown or invalid option,
+	 * including revision related ones, like --not,
+	 * --first-parent, etc that would be allowed and eaten by
+	 * setup_revisions() below. In the future we should definitely
+	 * accept those that make sense and add related tests and doc
+	 * though.
+	 */
+	for (i = 0; i < argc; i++)
+		if (argv[i][0] == '-') {
+			error(_("invalid option: %s"), argv[i]);
+			usage_with_options(replay_usage, replay_options);
+		}
+
 	if (!onto_name) {
 		error(_("option --onto is mandatory"));
 		usage_with_options(replay_usage, replay_options);
@@ -150,6 +164,17 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 
+	/*
+	 * TODO: For now, we reject any pathspec. (They are allowed
+	 * and eaten by setup_revisions() above.) In the future we
+	 * should definitely accept them and add related tests and doc
+	 * though.
+	 */
+	if (revs.prune_data.nr) {
+		error(_("invalid pathspec: %s"), revs.prune_data.items[0].match);
+		usage_with_options(replay_usage, replay_options);
+	}
+
 	/* requirements/overrides for revs */
 	revs.reverse = 1;
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index a1da4f9ef9..de6e40950e 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -80,4 +80,20 @@ test_expect_success 'using replay on bare repo to rebase with a conflict' '
 	test_expect_code 1 git -C bare replay --onto topic1 B..conflict
 '
 
+test_expect_success 'using replay with (for now) disallowed revision specific option --not' '
+	test_must_fail git replay --onto main topic2 --not topic1
+'
+
+test_expect_success 'using replay on bare repo with (for now) disallowed revision specific option --first-parent' '
+	test_must_fail git -C bare replay --onto main --first-parent topic1..topic2
+'
+
+test_expect_success 'using replay with disallowed pathspec' '
+	test_must_fail git replay --onto main topic1..topic2 A.t
+'
+
+test_expect_success 'using replay on bare repo with disallowed pathspec' '
+	test_must_fail git -C bare replay --onto main topic1..topic2 -- A.t
+'
+
 test_done
-- 
2.40.1.491.gdff9a222ea

