Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E7C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C62961205
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFGMB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:01:29 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:44628 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGMB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:01:28 -0400
Received: by mail-wm1-f44.google.com with SMTP id p13-20020a05600c358db029019f44afc845so9955874wmq.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1mDVaCj1hIb3ucbxdGlCiyCdR6N+Y9CzcBj3RxlkVU=;
        b=nzZKErh8sjU5VvuBsvpn74Cu3HWnja6ogZ0aH0HXisJY8LvvnojMgVPpG3f65ci5t8
         HEbVduFz2Nv8w4I1+s7O1bNses/usVx8DWfYiaYSigTJsGF4JfuDUu/PO+DeWcVfql7S
         ghePjR6Bjxe5sZ+aAq2+vqbx3A8JMVVoKjFxyTJH/TnQANsSwbbva09czkKMP5ZfI66F
         g4gaFU68/Cz9jgvyJ6cl9jugSEVj/m8Ucc6uFdpMhJsQSOTUO1sy7MtrPzBd/bZc0mhz
         r3fOBAl5SGCA6scY9vfJifYXy6FVE0QdjrGTV+7M5RumXD/gjkNH7Fc38cSjbgpixtm9
         Rd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1mDVaCj1hIb3ucbxdGlCiyCdR6N+Y9CzcBj3RxlkVU=;
        b=ejvVSxZA1l57rqV1hmQsHT48rm0kXfygxsrAp7uLhfoDyVJpwhZ5Qpv6hSPnkJ55Wv
         zEQzCtDS+VsOast0WlY18SyDx11/DAFOh4qBNkSj5/BOIU+HcRqG8gFSFI8ic32n8EjR
         76Jho4oJbc1GqbKU24XlNjXQbc+XDiFkjFTrLZjeB6Jk9onnYtVMTSHISGSAMp7I/bg9
         Xd0DDX9W2g4eRtxG3zXl39n33eCPNlwUjZETZkD11rT9KJbqjxwbjq38uCKSdByd7GMD
         0lNnS0dxW/UtaCYLuqVmUky1n3pKoEWKM3o2gf8pG1ObTWoEVDi+AvQ9Xs4PeUdvV5YN
         kKQg==
X-Gm-Message-State: AOAM530EfgsDdHWtgbdtkOJ/2OAbFyjIZmGq+eLkXCiSLJR0K9ikmgaT
        d62UHdb7VpHc1VnO6f9vfUfqwJoNoabaiA==
X-Google-Smtp-Source: ABdhPJzHjlHLkktgAvfOVbl4hdoQPmf/OmlD718/dm9Sn2PcHTWhdKv/2QV2p8/Ir/2VoBQbqO/0ag==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr16684505wme.147.1623067116219;
        Mon, 07 Jun 2021 04:58:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 92sm17215166wrp.88.2021.06.07.04.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:58:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] test-tools: migrate read-cache-again to parse_options()
Date:   Mon,  7 Jun 2021 13:58:26 +0200
Message-Id: <patch-3.4-36f4072b13-20210607T115454Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
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
 t/helper/test-read-cache-again.c | 28 ++++++++++++++++++++++------
 t/t7519-status-fsmonitor.sh      |  2 +-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-read-cache-again.c b/t/helper/test-read-cache-again.c
index 707db036cb..8487f79d04 100644
--- a/t/helper/test-read-cache-again.c
+++ b/t/helper/test-read-cache-again.c
@@ -1,20 +1,36 @@
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
+	int cnt = -1;
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
+	if (cnt == -1)
+		cnt = 2;
+	else if (cnt < 1)
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
index 4c199c16d4..fd0815f6b7 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -359,7 +359,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 test_expect_success 'discard_index() also discards fsmonitor info' '
 	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
 	test_might_fail git update-index --refresh &&
-	test-tool read-cache-again 2 tracked >actual &&
+	test-tool read-cache-again --count=2 tracked >actual &&
 	printf "tracked is%s up to date\n" "" " not" >expect &&
 	test_cmp expect actual
 '
-- 
2.32.0.rc3.434.gd8aed1f08a7

