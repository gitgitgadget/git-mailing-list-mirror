Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DB6C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353027AbiHSQcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353144AbiHSQam (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C0211CF2A
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b16so6210007edd.4
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=e9H1tv2P+phYaJKhrNjiftFzRXBvXphF+vbvev9O9T8=;
        b=dKUXQpAOT5HDm+eDzKmcOMTHj+cgMV/HF2YehLZSr/+UZvzICvAK1SLW+yOkgC+E7P
         dapbXIbj5TSKzEPUuOz0ENMbfyu2dysRKKwjWf2EBObdcRcrDDdz23rj+1+hLkNNr6L1
         Soq7QRwUOThPjwcCD1n2Ijh8sVhAHdWzxzzAPJHqGv+gMLT1Zpy7nkGqAJb95ALEqhR3
         80aXL3Tf1c4th9nWV0mg5cvgYyrdwVIPSxwUdPMg1Ccw7MlF6KDIYSHu7v1JfgA6YoG7
         7VD2XyGdD286s84S6rr/a9pXJl8MptU7mtNb9k4WeiNsF51jwQ6uIMHoPesQJjizcBJ2
         1Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=e9H1tv2P+phYaJKhrNjiftFzRXBvXphF+vbvev9O9T8=;
        b=Mpsj6B9k5UDUSE1xZGa+ssmuJb8wQdJIv43123oBMjRLw2vUjKWzIzOjPeMlROArUx
         yAFR7XoATk4HtdhhkUwos/hLLH204GKUPQOJB9zQ9zBnFZIogpxHkDPjyJHBYookuPKT
         2ZCA+mprXy2Rb06D4+dtGTNzkFIqlRsGuwQnt4i9MPv/7o4l6HsAzJLOcH+apaAFnBWG
         hifjMWT7ez61PwIBJc23lnQcI580Fvzxed5uD92ehicl3A6Jx21DqGjBO3OsLpmrZrF7
         4OSb9B+5EJfMYVdGjweQc2q7jYqR0o3homWJYyq4IlDSrNpUOvsk4ppwhUvKggEcgWA3
         1hcw==
X-Gm-Message-State: ACgBeo3AhcpqmBw2RSp4es9XN89WEeuVwZcdBlidcW6iPc9WAWn9f2g3
        Zil6FmUdWAF6anvomtHEf2pBt0Au4Bw=
X-Google-Smtp-Source: AA6agR4vOShRCRrygL7zx0szVSKSUVoy/4z0l62+UoW3RGC0DPICYznbPECKMQdAh8UldC17hE7dhQ==
X-Received: by 2002:a05:6402:3206:b0:43d:4e0e:b693 with SMTP id g6-20020a056402320600b0043d4e0eb693mr6455693eda.316.1660925096389;
        Fri, 19 Aug 2022 09:04:56 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b0073087140945sm2465583ejk.123.2022.08.19.09.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:56 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 13/20] builtin/hook.c: let parse-options parse subcommands
Date:   Fri, 19 Aug 2022 18:04:04 +0200
Message-Id: <20220819160411.1791200-14-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
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
2.37.2.817.g36f84ce71d

