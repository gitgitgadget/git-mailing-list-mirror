Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6E8C7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbjFBK3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjFBK3N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:29:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B33198C
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:27:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f4bdcde899so2459182e87.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701569; x=1688293569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0PaX3m5d7VvOT4SucyqOyF/JAl/clkYcZqYEk89yrQ=;
        b=edij7IpMEicCbmCReIOft6gIQ+Sjr+J9cs5rmoespgEe/yjbKR7X8+i0GRHptU0vzX
         Zz1bKSezbPRFGGDJsZSC9HIXtsbxE3FBAqOKmQahe1S+xE++uQBVk2SJ27CRJszuQkn6
         y+5klETXIkmq+4lDSyo8HScaiwTpI8aMCWJ28l47sltk6XPyDRjN7t/WGpuPjUbg6pJ4
         HuVFZcwor1S+JPnz2TNVPuy65HN5mCasOlXIjVbMKP6iUrBukShtY62gdFpBE58s72IY
         uU/6ZYjN1JRiyA7R9t0Ny3fPWiu5lc2IHNiUfS5+ZCMtVePLRniRIUw5/MTMnp6m4q78
         cxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701569; x=1688293569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0PaX3m5d7VvOT4SucyqOyF/JAl/clkYcZqYEk89yrQ=;
        b=NGDe+JQJD5uUVfXcEaLE+N2XNQqhEzahcmkUB7PnETH6+mDpVLbhQZEFQieQxVQ/Hx
         Av7LsmYVz5aJeqtKnFDUBsXN8mES82fu97S8HzFcsxss2TgZnzb4yiifFS0D+h9BHV/w
         x+3IV5WIqfMIiOy7pa55KLDhHa8x8A3lRM6mFRPFH5vK/8vWD1sDs35tPJUlHlfFgosy
         CA0MifecqCjBvXUue0X3ZCMclJEOOMREImKjIlmLxKf7QDkDh4c2SKAv8lTFtboAGrXL
         CLVVwA8A9sTkrpcAlblim5RM560B2SIk6V0973pAVpphxiiMbX6Cxzn7Gxbk8SDrvCWi
         MbKQ==
X-Gm-Message-State: AC+VfDyutACmgVHwH4QBfYRl9aGBFLLRCR7sirMEJwhE8z0UfXz6Cg2M
        u3LvGYjh6EA+ZSzO2lsghcnQBbj7OS5o2Q==
X-Google-Smtp-Source: ACHHUZ67U3c2kJAeP69WgX/dV7XkLcr4L2y2dMSAl4QBShQhlCgC3/hL2QUxTk5kfN6oKowze4/hNw==
X-Received: by 2002:a05:6512:3906:b0:4f3:b97c:2d91 with SMTP id a6-20020a056512390600b004f3b97c2d91mr1334388lfu.66.1685701569128;
        Fri, 02 Jun 2023 03:26:09 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1169:70dc:520b:5de9:c23d:7cde])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1468035wmk.33.2023.06.02.03.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:26:08 -0700 (PDT)
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
Subject: [PATCH v3 12/15] replay: disallow revision specific options and pathspecs
Date:   Fri,  2 Jun 2023 12:25:30 +0200
Message-ID: <20230602102533.876905-13-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.15.ga6d88fc8f0
In-Reply-To: <20230602102533.876905-1-christian.couder@gmail.com>
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A previous commit changed `git replay` to make it accept standard
revision ranges using the setup_revisions() function. While this is a
good thing to make this command more standard and more flexible, it has
the downside of enabling many revision related options accepted and eaten
by setup_revisions().

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
 builtin/replay.c         | 26 +++++++++++++++++++++++++-
 t/t3650-replay-basics.sh | 16 ++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index c1bd72c0e5..cffbf34290 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -121,7 +121,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct commit *commit;
 	struct merge_options merge_opt;
 	struct merge_result result;
-	int ret = 0;
+	int ret = 0, i;
 
 	const char * const replay_usage[] = {
 		N_("git replay --onto <newbase> <revision-range>..."),
@@ -137,6 +137,20 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
@@ -152,6 +166,16 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 
+	/*
+	 * Reject any pathspec. (They are allowed and eaten by
+	 * setup_revisions() above.) In the future we might accept
+	 * them, after adding related tests and doc though.
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
2.41.0.15.ga6d88fc8f0

