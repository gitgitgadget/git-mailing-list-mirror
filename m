Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077E1C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiGYMj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiGYMjl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0D31BE89
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id va17so20381972ejb.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMQQHR9U74wjDUmLHRIKyc5sZ32sGEkKFxXteNqcOzM=;
        b=f03vYMepjc9eL22OvbCoqLxPJ09LGQpghQp3JXAkBw01oNi5foxl8TqXm7aO5O0rCK
         b+VSN0w1aac5h277cUri8C7bmRzCatuqtwMf8ARJGcOw8SVxvnub7ciU1Ze4OkiWmzE6
         BX45FdcwQYsQBSN34dORP4EtZ9Wd4880wutcmajMwhbz8bcvmaW9oXiq1oRu8CCP/InD
         qAHLPSP/SraEwbBNR0bszCR7j9EJi7YE8QySJVPk8nJ2sEnYCQF1J5dVNbIizgFYJ5eB
         h+O1YMyP35OjHT9sG6b8ErI/n1YJNiI7PDojAVRqAZL7MbDLtvzHvuDimCsTtOh4n/kM
         WcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMQQHR9U74wjDUmLHRIKyc5sZ32sGEkKFxXteNqcOzM=;
        b=bzyyVaARajfOMNsCtTe0eFgLV4J1i1mV2v+7doWCpO9OhbXx3efZDRgN706mUVmGac
         XFHwdA83EQvDfh6sgxrWTeFAOUwrzlz+wjm6RGN+WrPjD3ZFaGM62cFz5okNCyqMzf7E
         vKJOynSy0MUykIOruD0txeWjWZCKsG/HdLCZ5bLoz57OrwcgHLmKl7Hv6zcoPuhfpyGu
         8/p6lWng3Ho1oPRxlVnfgr0zWq+3ug6AipEzrb/R7AXeXim+ms7xqkBMqJWHKskVKnlu
         T90kM8I7cu0peFzfHB5r88QJAkalc+lLeJT42lrxhXYAS1Aa2GCmqwnUaeaWEoPOi3G+
         xRdg==
X-Gm-Message-State: AJIora9mnmkHKozrzTnLtRyT5MHW5hy6FAjqCBfsTmTQMg4WKwFvrfGb
        UN426dvHx0GPx+rlOYeZKQA/qlkXmIw=
X-Google-Smtp-Source: AGRyM1vKCGQboJic7rxZAo1cTp49oBIuoGx6kjkcuTSBbAdUd+CkN33uPQ9OH9ySCmsCzjj2AgztOg==
X-Received: by 2002:a17:907:6e0f:b0:72e:d066:dfe5 with SMTP id sd15-20020a1709076e0f00b0072ed066dfe5mr10111460ejc.558.1658752768284;
        Mon, 25 Jul 2022 05:39:28 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id t6-20020a170906608600b0072ecef772acsm5263551ejj.2.2022.07.25.05.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:27 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 16/20] builtin/reflog.c: let parse-options parse subcommands
Date:   Mon, 25 Jul 2022 14:38:53 +0200
Message-Id: <20220725123857.2773963-17-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
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
2.37.1.633.g6a0fa73e39

