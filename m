Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D89BC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbiA1M5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbiA1M45 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:56:57 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84DFC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:54 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id s5so15795551ejx.2
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=weVc6aPl6ZZG31nvetXK9xiF+bQbZunVoyJAFKaxZOQ=;
        b=JYjym63WWzLdNyG05Lwbla2hbzvwcCftvax1+efxkkytwehuKojqCbwM6lf9YrX1le
         KG5raLjEIG2YF5msTDtIF237C6nQKrMLj6K3po4rp5ajtrqEBQ7DiJM8Ekjlk7Plg+V6
         YKpTQ5fYwjo8vmPXTf7fs0K2NxW6nBYqKSLAjP0CiIV5DkouPFnjZqA+bpdUk+DV0nCT
         NB14q0ABBczV4bhGynfsc0JmPNZx1h8T7baBONNRh/b2CyZhArxKemW1QoRosTxpZi8S
         gkE2DoAbnuqDO8tgvKm8vEDruuvVjKiQCuEvhvzinLAoiUesSCNkpg32AKDMXE5jLHpY
         /URA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=weVc6aPl6ZZG31nvetXK9xiF+bQbZunVoyJAFKaxZOQ=;
        b=lKRmnFL9vjHIB2T2v0JCLaOxYeqTpWP+uSpYmkiTySWgh+Ta+n8r5Mskf0At+70keI
         BwZr+/8rsBy2QaO7PazCc2oYLwNJSAj8YwLeBBIhkpcUmnIsyVxj+va2mp2mcMl+sKVA
         6+3zPbSkWJFZ5VqHbWwCPCB10SGLgaEHnxgAVkoW5gnUypfiKdBFfHaCL46VRTmcCEW3
         gsmbzZUOYpXurtEb8yB0suXCQf2++ejgVbcXVj7V8YOaUaQ86tOn2YeW84UsooIGzJ+i
         iwKvwjp0PMZdGhGe6GQvwXCwQj6F+bx8u0SxCG8I+Q04/mFdxF9mctLzCKBCFARihzHJ
         dATg==
X-Gm-Message-State: AOAM531YAlODNNLZywriFwGBk2eKUvVboVrgs/CFNXJmOfTcry3nwTMn
        0gZ95qWS8iMr4iQhPZLOjftSEW8n1sdb1Q==
X-Google-Smtp-Source: ABdhPJxbZDJJ9Wc9x4rZ3xVtCKOKsVFn6HlA2Kwa2qdMnZY/Ty15AFFSTHozf45honMo+eaj2RlLyA==
X-Received: by 2002:a17:907:724b:: with SMTP id ds11mr6877130ejc.195.1643374613176;
        Fri, 28 Jan 2022 04:56:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g8sm10154691ejt.26.2022.01.28.04.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:56:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 7/9] submodule--helper: don't use bitfield indirection for parse_options()
Date:   Fri, 28 Jan 2022 13:56:38 +0100
Message-Id: <patch-v5-7.9-6b038f558c1-20220128T125206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.914.ge5c8aab0d5b
In-Reply-To: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do away with the indirection of local variables added in
c51f8f94e5b (submodule--helper: run update procedures from C,
2021-08-24).

These were only needed because in C you can't get a pointer to a
single bit, so we were using intermediate variables instead.

This will also make a subsequent large commit's diff smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c2d4fd0347a..4a0890954e9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2045,10 +2045,10 @@ struct update_data {
 	struct object_id suboid;
 	struct submodule_update_strategy update_strategy;
 	int depth;
-	unsigned int force: 1;
-	unsigned int quiet: 1;
-	unsigned int nofetch: 1;
-	unsigned int just_cloned: 1;
+	unsigned int force;
+	unsigned int quiet;
+	unsigned int nofetch;
+	unsigned int just_cloned;
 };
 #define UPDATE_DATA_INIT { \
 	.update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT, \
@@ -2578,16 +2578,17 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 
 static int run_update_procedure(int argc, const char **argv, const char *prefix)
 {
-	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
 	char *prefixed_path, *update = NULL;
 	struct update_data opt = UPDATE_DATA_INIT;
 
 	struct option options[] = {
-		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
-		OPT__FORCE(&force, N_("force checkout updates"), 0),
-		OPT_BOOL('N', "no-fetch", &nofetch,
+		OPT__QUIET(&opt.quiet,
+			   N_("suppress output for update by rebase or merge")),
+		OPT__FORCE(&opt.force, N_("force checkout updates"),
+			   0),
+		OPT_BOOL('N', "no-fetch", &opt.nofetch,
 			 N_("don't fetch new objects from the remote site")),
-		OPT_BOOL(0, "just-cloned", &just_cloned,
+		OPT_BOOL(0, "just-cloned", &opt.just_cloned,
 			 N_("overrides update mode in case the repository is a fresh clone")),
 		OPT_INTEGER(0, "depth", &opt.depth, N_("depth for shallow fetch")),
 		OPT_STRING(0, "prefix", &prefix,
@@ -2618,10 +2619,6 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 	if (argc != 1)
 		usage_with_options(usage, options);
 
-	opt.force = !!force;
-	opt.quiet = !!quiet;
-	opt.nofetch = !!nofetch;
-	opt.just_cloned = !!just_cloned;
 	opt.sm_path = argv[0];
 
 	if (opt.recursive_prefix)
-- 
2.35.0.914.ge5c8aab0d5b

