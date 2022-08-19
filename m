Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C415DC32772
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353050AbiHSQcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353182AbiHSQbB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:31:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6A211CF0E
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fy5so9671619ejc.3
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=23VpwbQzVwcZx+WDo9+Mt8dpcR0ekaOB/AzbhYLtYt0=;
        b=j7FO0Avb1ySOlEC9xnV6lmOluGUTyL41r7LZ33/Qcuoab2uHJHRN4xKqc7rFqiaCYs
         vX75sldmSSHu53SXhuPMeEZ35B/qYLJqbOsebTe4sUc5IXrFFVPNotCSYdTOsLZk41Ib
         xpLk+wm+8/V2OIOZkZBKrjCEauBwJzpI2+4qmboOz4TEeI68+jzl51Sp9ntnDWz5SHU8
         Cv0x8xvcrRXLymv9pdNUHV2IUazkVjfo5ffAQPdGVD3Wwm0DEA4kCBhh5kC5Dx4J2ppP
         baLEj1UV1aKorumTvMl/tDzPvVNC4/5d2urFSqOizGyDGXDVHZUfmLx7hbV3RFj+ldgM
         es3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=23VpwbQzVwcZx+WDo9+Mt8dpcR0ekaOB/AzbhYLtYt0=;
        b=fF2JNggH2HK6cnNvRNChuBJKrjQlztd4j4V6rFSBtfm+62kYURVojgNmVenOXZqhX7
         w6u8jylrWZwujk5ERoa4EJLpc0gp/L+7M+lfFXplG+fwfWLKoZHs3KHjrPhDI6gncwwt
         KgHORTY/9LTw08Ehc0Sh2RSTubhca6oFX466aILlLTzhwCPTXpgcveXqmsag3NSkvfAG
         vHTP78dE3okqX1r78e7X1h18n6jX47Ku57bV+Dl+ijEzmQOGeXZ+5ppSzPgLV+do0ZnY
         VjczgKfgiOen+izneo+SQADAUdEAjE6n38LGNaQv3/oXNBZ2aVF6waSzMEZagQi7XXXX
         t9JQ==
X-Gm-Message-State: ACgBeo106uO9PycOEIelVKazEezMEgb86w2YThpgvBMCUQhRSpViaURx
        XkXE6N86hTAYZEruvmp3b4EAZr4cnvo=
X-Google-Smtp-Source: AA6agR7QJFNblo3X6x/ofpt3jWIHThbqeyUW/oovibffRgAmf/SsgX63HRJLDdpPKOBb0SQGuAJYiQ==
X-Received: by 2002:a17:907:2da4:b0:731:2772:59d9 with SMTP id gt36-20020a1709072da400b00731277259d9mr5190506ejc.751.1660925102011;
        Fri, 19 Aug 2022 09:05:02 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b0073cf8e0355fsm1184630ejn.208.2022.08.19.09.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:05:01 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 16/20] builtin/reflog.c: let parse-options parse subcommands
Date:   Fri, 19 Aug 2022 18:04:07 +0200
Message-Id: <20220819160411.1791200-17-szeder.dev@gmail.com>
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

'git reflog' parses its subcommands with a couple of if-else if
statements.  parse-options has just learned to parse subcommands, so
let's use that facility instead, with the benefits of shorter code,
and listing subcommands for Bash completion.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/reflog.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index b8b1f4f8ea..d3f6d903fb 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -404,40 +404,21 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("show", &fn, cmd_reflog_show),
+		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
+		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
+		OPT_SUBCOMMAND("exists", &fn, cmd_reflog_exists),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, reflog_usage,
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL |
 			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
-			     PARSE_OPT_KEEP_UNKNOWN_OPT |
-			     PARSE_OPT_NO_INTERNAL_HELP);
-
-	/*
-	 * With "git reflog" we default to showing it. !argc is
-	 * impossible with PARSE_OPT_KEEP_ARGV0.
-	 */
-	if (argc == 1)
-		goto log_reflog;
-
-	if (!strcmp(argv[1], "-h"))
-		usage_with_options(reflog_usage, options);
-	else if (*argv[1] == '-')
-		goto log_reflog;
-
-	if (!strcmp(argv[1], "show"))
-		return cmd_reflog_show(argc - 1, argv + 1, prefix);
-	else if (!strcmp(argv[1], "expire"))
-		return cmd_reflog_expire(argc - 1, argv + 1, prefix);
-	else if (!strcmp(argv[1], "delete"))
-		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
-	else if (!strcmp(argv[1], "exists"))
-		return cmd_reflog_exists(argc - 1, argv + 1, prefix);
-
-	/*
-	 * Fall-through for e.g. "git reflog -1", "git reflog master",
-	 * as well as the plain "git reflog" above goto above.
-	 */
-log_reflog:
-	return cmd_log_reflog(argc, argv, prefix);
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
+	if (fn)
+		return fn(argc - 1, argv + 1, prefix);
+	else
+		return cmd_log_reflog(argc, argv, prefix);
 }
-- 
2.37.2.817.g36f84ce71d

