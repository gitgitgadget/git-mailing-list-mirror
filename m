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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC823C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 650A161040
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbhHEHmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbhHEHmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:42:16 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DDBC061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:42:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so9597600pji.5
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7PeTlolYUUEdH50YFM+tYWul3tHUIpiVifHEE94XnWs=;
        b=JnivifsYZUEUV/2feaQTrBMAa6DgmCeb9JnrRpCzlWpy+CLtFParqfPDcxWkw1RTqe
         itFJYHCVaTGZrbw+MwhmRi4KVN5IkpSTndLyi4aEFS+ZW6/zSFIqvGFX/GmS3GTvNnNy
         Vw8vlDjujhYF79ArSH0FmySJ2CgT7WooiRB5D2be4cvJ7pO+rRSQ4C70E3YSaI9fxf8M
         LGvmqjkCFOjjTV0ysOCT6VPCm6M50bFtDn7m1iFNSd/7i/iJSTSLoKG0I67DprcaY06M
         pYN3h6hJzUioITvF1RacbLkdERWjicWoWrxskM979L1M0H+s160rcypNGLotEczIreB6
         KjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PeTlolYUUEdH50YFM+tYWul3tHUIpiVifHEE94XnWs=;
        b=fz6tCLs+j/6P3mlJC9DMhNevKpughqegbPsmzkIP6WzGWhB5CLryghg8iEqMoDt1Si
         2zxwVaYHOeD4Ej8038xLC1Sb+gi8s9wPvCEgb2lZhvjlxgMaOFlcOAH8M92/eyF2KgZE
         US3rroKDdt6OImAgtUBEjvWA3FZk97vk+mnVziQ7WUQr5+cdR6vIYytjGe0TVxOxQlGn
         XXGME+5QNL/hAAS6ISxJo8ScPJ0YtIqCp7mqwbi6j3fIIBxQhip2SQJDHEnHEa9v06GR
         nRO3gEMNZAUw7KfRXs2rMHvbUISSG00jQwIW9WqabgAEoDW1aULJguBLjld20HO0py0P
         HmAw==
X-Gm-Message-State: AOAM533YdSbB3zFS4tyouNUTykbP3uGjkKtrvahOwXm6xAqKqv9mmeYJ
        OySYMsZ8JhcYLuhkgZ8njJM=
X-Google-Smtp-Source: ABdhPJwgOmY+oTxtadJdUo0QBiU5pZ7tZjR6kdsUWTw99pcetIzF/3QBNVnY4hE9OB9eNhKlV5D4pw==
X-Received: by 2002:a17:90b:80c:: with SMTP id bk12mr3471778pjb.69.1628149321582;
        Thu, 05 Aug 2021 00:42:01 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b2sm4885153pjh.18.2021.08.05.00.41.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:42:01 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v2 8/9] submodule--helper: remove add-config subcommand
Date:   Thu,  5 Aug 2021 13:10:53 +0530
Message-Id: <20210805074054.29916-9-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805074054.29916-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805074054.29916-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also no longer needed is this subcommand, as all of its functionality is
being called by the newly-introduced `module_add()` directly within C.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 49 -------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 700cc8bbeb..da83e8e2a5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2939,54 +2939,6 @@ static void configure_added_submodule(struct add_data *add_data)
 	}
 }
 
-static int add_config(int argc, const char **argv, const char *prefix)
-{
-	int force = 0;
-	struct add_data add_data = ADD_DATA_INIT;
-
-	struct option options[] = {
-		OPT_STRING('b', "branch", &add_data.branch,
-			   N_("branch"),
-			   N_("branch of repository to store in "
-			      "the submodule configuration")),
-		OPT_STRING(0, "url", &add_data.repo,
-			   N_("string"),
-			   N_("url to clone submodule from")),
-		OPT_STRING(0, "resolved-url", &add_data.realrepo,
-			   N_("string"),
-			   N_("url to clone the submodule from, after it has "
-			      "been dereferenced relative to parent's url, "
-			      "in the case where <url> is a relative url")),
-		OPT_STRING(0, "path", &add_data.sm_path,
-			   N_("path"),
-			   N_("where the new submodule will be cloned to")),
-		OPT_STRING(0, "name", &add_data.sm_name,
-			   N_("string"),
-			   N_("name of the new submodule")),
-		OPT__FORCE(&force, N_("allow adding an otherwise ignored submodule path"),
-			   PARSE_OPT_NOCOMPLETE),
-		OPT_END()
-	};
-
-	const char *const usage[] = {
-		N_("git submodule--helper add-config "
-		   "[--force|-f] [--branch|-b <branch>] "
-		   "--url <url> --resolved-url <resolved-url> "
-		   "--path <path> --name <name>"),
-		NULL
-	};
-
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
-
-	if (argc)
-		usage_with_options(usage, options);
-
-	add_data.force = !!force;
-	configure_added_submodule(&add_data);
-
-	return 0;
-}
-
 static void die_on_index_match(const char *path, int force)
 {
 	struct pathspec ps;
@@ -3158,7 +3110,6 @@ static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
-	{"add-config", add_config, 0},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
 	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
-- 
2.32.0

