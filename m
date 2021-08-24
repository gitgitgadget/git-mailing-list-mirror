Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28967C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1208361165
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbhHXJQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbhHXJQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 05:16:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07369C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:15:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q11so3246900wrr.9
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cEH/Y2Fj28mOc6KhxS95liyo07g/nVNTIYC4DIb4Vaw=;
        b=Poz6m9EAFCQkMZxDTOz6hYwShD+BZFEpq9Zr+q9Q/WGoPc/inyU06CpJOhWsEWGAYi
         MLde0imuXMG5/tSimLAsTHmBT5Ow/sqaPGYwzy3o3RKKrjN5aSF4pZE7OopyASpHrWms
         5pykGmTzUa/J7F3yLK5ZgnlPSpz3oYkWDmH7IuliwYUQArp/K60z6GkWPcwStQzHxb/P
         BLEuLK/XXul8XF2gEq0MsXlA0I+UAnreYTk4vuBnWIDO5VqNx+JLHfCtzehzlmDCmTTo
         YXAEZJi2j7bVM4+Ia5pTrNsmaJEGSzZW9UV6Du46b7j5zYu1+OpbrLUrGkZWqNmGTD6l
         uiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cEH/Y2Fj28mOc6KhxS95liyo07g/nVNTIYC4DIb4Vaw=;
        b=a6IE+m9bB0BYK2/S1wjQbmp5JrdXl8f9b+TFE3oztCTY3Ef/k4sOiOrSg4Ldx37i0r
         sdzv1Wk3W0nMlJyds83vA/dGMSZ23lAtzfXg4CgRv0zOG6XEPWgpDktIi0yEuG/uqemp
         5zOyY0CNhNZ8R1v15fJxt8OQu5Au+EOsZCN3OLkdSvO8YGQMfkqylypb91WQoCkCcJZ6
         9V7raySUZbe7ozNHyeKhrYaRshtuUQiBw8XG10jTIVDNZweNxDIsF3+LzbVGREvNwR83
         ax6Ra3VrPGUNU8GKnkxrJbSBX4TkiDBCTs30wRRwsILVqWvH/LgIFQZWDLA1Bso/Ai2W
         Ov1A==
X-Gm-Message-State: AOAM531UH3f9nG65b3riH6xnH3HA4zcsqCfgIeBWOCn8PQy+6AY11OZa
        qO4rMWlAIad7lO1IN6RLLk/erXSC3qmKsQ==
X-Google-Smtp-Source: ABdhPJyCnuv8nGEuqaHc8vstefq1D2M5lsPXG0Egd1tusj8FRr5D7kuMgUzsfcCBDkMj9Vku4J/lUg==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr16500971wro.61.1629796533408;
        Tue, 24 Aug 2021 02:15:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u8sm1853104wmq.45.2021.08.24.02.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:15:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/4] test-tool: migrate read-cache-again to parse_options()
Date:   Tue, 24 Aug 2021 11:15:24 +0200
Message-Id: <patch-v2-3.4-a34e69eaa48-20210824T091204Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.663.gbaff4edb973
In-Reply-To: <cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the newly added (but then mostly copy/pasted) read-cache-perf
to use the parse_options() API. I have no plans to further modify
read-cache-again, but making these commands consistent has a value in
and of itself.

Since we check the "cnt = < 1" case now via more idiomatic
post-parse_options() assertions we can move from the for-loop to a
while-loop and ditch the "i" variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-read-cache-again.c | 26 ++++++++++++++++++++------
 t/t7519-status-fsmonitor.sh      |  2 +-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-read-cache-again.c b/t/helper/test-read-cache-again.c
index 707db036cb1..fa456ca229e 100644
--- a/t/helper/test-read-cache-again.c
+++ b/t/helper/test-read-cache-again.c
@@ -1,20 +1,34 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "parse-options.h"
+
+static const char *read_cache_again_usage[] = {
+	"test-tool read-cache-again [<options>...] <file>",
+	NULL
+};
 
 int cmd__read_cache_again(int argc, const char **argv)
 {
 	struct repository *r = the_repository;
-	int i, cnt;
+	int cnt = 2;
 	const char *name;
+	struct option options[] = {
+		OPT_INTEGER(0, "count", &cnt, "number of passes"),
+		OPT_END()
+	};
 
-	if (argc != 2)
-		die("usage: test-tool read-cache-again <count> <file>");
-
-	cnt = strtol(argv[0], NULL, 0);
+	argc = parse_options(argc, argv, "test-tools", options,
+			     read_cache_again_usage, 0);
+	if (argc != 1)
+		usage_msg_opt("Too many arguments.", read_cache_again_usage,
+			      options);
+	if (cnt < 1)
+		usage_msg_opt("Need at least one pass.", read_cache_again_usage,
+			      options);
 	name = argv[2];
 
 	setup_git_directory();
-	for (i = 0; i < cnt; i++) {
+	while (cnt--) {
 		int pos;
 		repo_read_index(r);
 		refresh_index(r->index, REFRESH_QUIET,
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 7de5fcb1bd7..817e642f58e 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -360,7 +360,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 test_expect_success 'discard_index() also discards fsmonitor info' '
 	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
 	test_might_fail git update-index --refresh &&
-	test-tool read-cache-again 2 tracked >actual &&
+	test-tool read-cache-again --count=2 tracked >actual &&
 	printf "tracked is%s up to date\n" "" " not" >expect &&
 	test_cmp expect actual
 '
-- 
2.33.0.663.gbaff4edb973

