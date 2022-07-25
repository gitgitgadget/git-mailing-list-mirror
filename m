Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF650C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbiGYMjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbiGYMja (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DEA1AF3A
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ss3so20223889ejc.11
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aNfMgmOKKl4wheEVAcuo1W4X2MDpG+jP3VJEpIYod+0=;
        b=aUlTIQXLq0eeF5F+h2uss7FQNZo26vGNmefciJalkIFKOjiU0KXHbzr0YVvDneOBo5
         jvIQpuGqveWyHxOpjjIjTzqz1ARxI5MsuearMk/J6YWPUsY9MS9Hnm7s6rB3y3ADflXa
         wFahOcmyVOdSq/5eU0dulKpPjylbo2JgQUWM0dY5aW4XfqRReJj5A6RDCTDEtoOqMOce
         H9vREvYA1pTAirpsSwipfBk+gIsCeOzhHkxVD+Evgi1P+/zHSj418BWXh8NGccQAyTvV
         eN/x52Y+ubuEbXvYhwyqaoacUOP9Du5Zq2WXhXltL3To0JoW+yPujxzCbhNe2Rj8rAaJ
         8TXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNfMgmOKKl4wheEVAcuo1W4X2MDpG+jP3VJEpIYod+0=;
        b=Qb6B+chC8RrW9E8xOp5vqN8GyLtRVRmNuqcBcmYoyCd6zzYN4xBOp1RDfQkupJkGCo
         6K+559uwe+TkHt5IMCrMSwxPiqXOOhClzrnnd41DCRQbd/+CPwHKfNNwHhU+ZWR6eGZ3
         zWwXXG1M5abM2Fdq6ogTu03B1GnnGETJhvD6gQUCsIuZI0bZX+OASzgUuqfLJMGFlMWr
         m6WcF6+RVrEF1bxVa5reFb8fSlD5YQIrKXDh251kchYXqYNMqeUwDnr8y2gy7Awa7hsy
         jP/vH3FKWOB1RDMqkRGzEQh3FzR8j3G6jQVolHrB6eyFzNl5pY2IwlZZzVUBDLUeRVKF
         e+Xw==
X-Gm-Message-State: AJIora/1vLWH5o3+QLV2CiM6pHwEtOi2LJupCZv1LQPFsC8StVqm0vuk
        SwRyqcJg4dPQs900+JMFy1CSv46whrA=
X-Google-Smtp-Source: AGRyM1v4uzhzqVWUxpCHv0JpQyx2X1X/SO7lotCdxEraXzVnS6AztMTvheLFsPezYKdgM2ZQGRD34w==
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id nb13-20020a1709071c8d00b006f20eb21cd6mr9781234ejc.568.1658752763674;
        Mon, 25 Jul 2022 05:39:23 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id q5-20020aa7cc05000000b0043bc8677926sm6577126edt.96.2022.07.25.05.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:23 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 13/20] builtin/hook.c: let parse-option parse subcommands
Date:   Mon, 25 Jul 2022 14:38:50 +0200
Message-Id: <20220725123857.2773963-14-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git hook' parses its currently only subcommand with an if statement.
parse-options has just learned to parse subcommands, so let's use that
facility instead, with the benefits of shorter code, handling missing
or unknown subcommands, and listing subcommands for Bash completion.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/hook.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index 54e5c6ec93..b6530d189a 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -67,18 +67,14 @@ static int run(int argc, const char **argv, const char *prefix)
 
 int cmd_hook(int argc, const char **argv, const char *prefix)
 {
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_hook_options[] = {
+		OPT_SUBCOMMAND("run", &fn, run),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, NULL, builtin_hook_options,
-			     builtin_hook_usage, PARSE_OPT_STOP_AT_NON_OPTION);
-	if (!argc)
-		goto usage;
+			     builtin_hook_usage, 0);
 
-	if (!strcmp(argv[0], "run"))
-		return run(argc, argv, prefix);
-
-usage:
-	usage_with_options(builtin_hook_usage, builtin_hook_options);
+	return fn(argc, argv, prefix);
 }
-- 
2.37.1.633.g6a0fa73e39

