Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFF6C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiGYMjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiGYMjX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189F1AF11
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i13so4619726edj.11
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zAlMlT24uIYZjK+98WfAg1VY5iZ/v7pWKaA2b8lA2Qs=;
        b=jVZkUVUd2WQ6oJJydTLkswBL4AKMUfMS5xVu1Mt+RYHT8WZpOkRTC2D2D9FZAAG3AO
         OxHaEb9AtUaSzg3JzXbuh/ExJiaGVE1YLyNXH6am3yF2hAf4Ldp+wr8/rZOYAm2fHPdb
         JrVdser0Z2QuID3l/c77AC1eZXlRKwBVtlPBeADtagGDcfvYyzpaHhWsu7Rp1SpN0bb2
         kc4tDVhvMB0jYKgnwPmCW7nkz2MPOxROeeZzjYjeL3CFSPB4QedKgmDwLaNNMExfV5xQ
         FmJ4FU4TvVg+3P8OfEhuXi+q123UMncfCyPSayxrthIV7uH0RIVX+QBCSKEFLDRhg74Q
         /HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zAlMlT24uIYZjK+98WfAg1VY5iZ/v7pWKaA2b8lA2Qs=;
        b=c15VbqLyHlUAkfjel7uRWulbwMlOwkVWwwkrtCAYGENcPuMNQ9TQ8GQfXcukSkBxdz
         pMyrMPC71u2HwqyNgbgDoB5suVAnlM4npjD38ltL5uBv0t/7kK1WvqG1JIPMTRe/ou2m
         AAzpG0EH02n6CNSMSoEk7FRJ8RcD5LEAsB1PMhkXCtUB6QDa4UJPFfN/BXI29XOCUbQr
         0HvYLWtiF38DkSpgTrHZ+BNyylsymChO4mvscDgh9jdez8392nvHAC7Gp3wgdTOXOARp
         oCGJTT8F5Jt0rorLYgrYivr3xR3UNtPDKcK/f/DKT1SYxnufr88hPFK/sQf8DfKuc2y5
         LC7g==
X-Gm-Message-State: AJIora/FEfnxkBZM5kdrtXVzfF7d5tCzvp3ceng+yG67tO0grcBWQfac
        9Y02zmQ6rxTYKOzC77LDZI6J4Bi7D8w=
X-Google-Smtp-Source: AGRyM1vTKrt63E4taYpRJopsXlJOetCNOwmgxaPUQiPP+p7RwKIcVStnGyIzmd2emI8iMqMQwcBteA==
X-Received: by 2002:a05:6402:686:b0:43b:b985:68d5 with SMTP id f6-20020a056402068600b0043bb98568d5mr12868978edy.129.1658752758709;
        Mon, 25 Jul 2022 05:39:18 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id i8-20020a056402054800b0043bb71edd36sm7106398edx.44.2022.07.25.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:18 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 10/20] builtin/bundle.c: let parse-options parse subcommands
Date:   Mon, 25 Jul 2022 14:38:47 +0200
Message-Id: <20220725123857.2773963-11-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git bundle' parses its subcommands with a couple of if-else if
statements.  parse-options has just learned to parse subcommands, so
let's use that facility instead, with the benefits of shorter code,
handling missing or unknown subcommands, and listing subcommands for
Bash completion.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/bundle.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 2adad545a2..e80efce3a4 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -195,30 +195,19 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("create", &fn, cmd_bundle_create),
+		OPT_SUBCOMMAND("verify", &fn, cmd_bundle_verify),
+		OPT_SUBCOMMAND("list-heads", &fn, cmd_bundle_list_heads),
+		OPT_SUBCOMMAND("unbundle", &fn, cmd_bundle_unbundle),
 		OPT_END()
 	};
-	int result;
 
 	argc = parse_options(argc, argv, prefix, options, builtin_bundle_usage,
-		PARSE_OPT_STOP_AT_NON_OPTION);
+			     0);
 
 	packet_trace_identity("bundle");
 
-	if (argc < 2)
-		usage_with_options(builtin_bundle_usage, options);
-
-	else if (!strcmp(argv[0], "create"))
-		result = cmd_bundle_create(argc, argv, prefix);
-	else if (!strcmp(argv[0], "verify"))
-		result = cmd_bundle_verify(argc, argv, prefix);
-	else if (!strcmp(argv[0], "list-heads"))
-		result = cmd_bundle_list_heads(argc, argv, prefix);
-	else if (!strcmp(argv[0], "unbundle"))
-		result = cmd_bundle_unbundle(argc, argv, prefix);
-	else {
-		error(_("Unknown subcommand: %s"), argv[0]);
-		usage_with_options(builtin_bundle_usage, options);
-	}
-	return result ? 1 : 0;
+	return !!fn(argc, argv, prefix);
 }
-- 
2.37.1.633.g6a0fa73e39

