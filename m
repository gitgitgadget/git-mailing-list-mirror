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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25011C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F402660EB9
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhHKE6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 00:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbhHKE54 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 00:57:56 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F724C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:33 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s13so2784403oie.10
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FCi92CAeZOSxGpt5h3IyvgXcT9W7iC2wsJV8iYq4IFI=;
        b=REzagwzoxvJSzRZTWreaSvcEWP1wzL7m36sOFg3xtwm5B+pOaL6PTzdK+XcavV2ZDF
         pEUa2JF3bLonv86n+Ldw7eNAFwG36m88zHchOEI3zdJzUtT7MaXs2jhSNQ0iziosncwx
         +ejObH/9P7yRSi5P8q2S8wc8aHPq0MaQMuRUi+8QKrdU8pqG1SqjjBzukVH9Jom86zI6
         X1J3h9iSgGV8AQw5YZ1A/D03txCKjH6jGwwkdqz/gKVkkGJLbOP7nzmNHvAWiJ+GtFo8
         jf1kGDtBu8R+D5aRarfUHbw+XNHtPmVfFKZ6fVZMJ1ybsQ3hz6+qr2SzNsg3jsUejxH/
         ANeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FCi92CAeZOSxGpt5h3IyvgXcT9W7iC2wsJV8iYq4IFI=;
        b=GOxTBTaIqWFGaHYsJY8O39/AwZDVSubFPlNXqX/OhOVNJBIRBGPlaZTntsixIWRidE
         VnPD71p6FIJUvUkCPpUJsZ48KDdVoM+h33GLETVDdVVZ4Vjsp4a1VKgFE5+eR1aPGgse
         lPrDxTGoPaz21BYtvQKa2JJ6QSQChqxHpsIU73Rhqc49vFDvPXLatPDbwHTJCtL+Oo9i
         V6UjGgdL/RziDGqr6yr12I0U7e+6pc/Sy2mvISx4kzTRltQDdt0gNEuH4OxwYG5kFzmX
         fL2g37TbxOYtjxHhBolBgNuMP8fk4713HLxGAZfMxhHn/fHQm7+XIXLz6nPk3jWcoaR3
         ZKZg==
X-Gm-Message-State: AOAM533x42o+BZPE8Kr6DOSu5FgLGd8zGy8R/GsyH+LveIkovsEa8x1Q
        VqTxWVBzHHuGxRivOchtFRCUhRv/V2gmaw==
X-Google-Smtp-Source: ABdhPJwiRH4BBZvVQoRSfyLh8YBwGp+GiZgwOz6UJtZYtP6xG+ltBcuvezbsI3XFVd6CulDgY9lFWQ==
X-Received: by 2002:a05:6808:7cb:: with SMTP id f11mr10249588oij.56.1628657852415;
        Tue, 10 Aug 2021 21:57:32 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id r1sm3734383ooi.21.2021.08.10.21.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 21:57:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/7] stage: add helper to run commands
Date:   Tue, 10 Aug 2021 23:57:22 -0500
Message-Id: <20210811045727.2381-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.48.g096519100f
In-Reply-To: <20210811045727.2381-1-felipe.contreras@gmail.com>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Will be useful to run other commands.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/stage.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/stage.c b/builtin/stage.c
index 4dcefbedba..49016b0d5f 100644
--- a/builtin/stage.c
+++ b/builtin/stage.c
@@ -4,12 +4,34 @@
 
 #include "builtin.h"
 #include "parse-options.h"
+#include "run-command.h"
 
 static const char *const stage_usage[] = {
 	N_("git stage [options] [--] <paths>..."),
 	NULL
 };
 
+static int rerun(int argc, const char **argv, ...)
+{
+	int ret;
+	struct strvec args = STRVEC_INIT;
+	va_list ap;
+	const char *arg;
+	int i;
+
+	va_start(ap, argv);
+	while ((arg = va_arg(ap, const char *)))
+		strvec_push(&args, arg);
+	va_end(ap);
+
+	for (i = 0; i < argc; i++)
+		strvec_push(&args, argv[i]);
+
+	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
+	strvec_clear(&args);
+	return ret;
+}
+
 int cmd_stage(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
@@ -17,7 +39,7 @@ int cmd_stage(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options, stage_usage,
-		PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
+		PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
 
-	return cmd_add(argc, argv, prefix);
+	return rerun(argc, argv, "add", NULL);
 }
-- 
2.32.0.48.g096519100f

