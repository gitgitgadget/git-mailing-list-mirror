Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC75620966
	for <e@80x24.org>; Wed,  5 Apr 2017 17:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755354AbdDERtQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 13:49:16 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33013 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754199AbdDERrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 13:47:32 -0400
Received: by mail-pf0-f175.google.com with SMTP id s16so10719058pfs.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Sk9fvmoQrooSR3to++AyEyR38cuF0T7gmdeGyLS8+w=;
        b=LviZsD07nK/mI1AEQrOxdWPBXgN8sOlCUg0+LuItcONdhAghnOomE3hI3JVUiIZgU5
         BD6MLwrY3uBfOmYmb6+8VBw6whnamP0WPlxkFtB8zq9MqcV+fQ8HS56HkxU4aB2JH2F4
         u9dfJBUlaJeOqOjeEto7yszDyDcDlWyihYq6TI15BpAnFiOeTvIJVrloiED1nfjzN/0D
         nxBDHKY8D5FLqSnmhyusXvn/Rq3I7oiVvtXK6TbcdT+1uUB5WNorJ4IIEYvgXdmdb6qD
         8F5BRCgem7mQyCTEdtDwAfd0Z3f80843QGic6UaX/yjnTBKB4nvWC4WZEmYuE1SSGjyH
         xbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Sk9fvmoQrooSR3to++AyEyR38cuF0T7gmdeGyLS8+w=;
        b=d88RTefPxSodi+2unzKUs25KXJFNU2UNB3sg0r9aik+go1zZ1wEsR78u4qjsaYRaLr
         SpHfi9ZgPCGPi7F2h77pHy125ZgbuO+7ceUTKuUi9eUzbtRuIPaTvthotdBC9UilQg48
         D8sD6yPUxKlYMrsli+7OD3dMhF0+ZBWs05sxQsxDJO+WOAKjmdTkuw0CjKAVBmtUmZXT
         Y1kRuBKBgfc3GVrpOc0HK5WrJ9YJ6IeIE4xUJO8huFWsql1eEiyXtMFmvtzgeGTkCC+W
         MSPrgoTXaMqp/k5K0GZd82fz3S7MlkDlgkXhTb9o+GOYxBKoYjQhCCe6F3V+GZd7oVMG
         N42w==
X-Gm-Message-State: AFeK/H2JqwJOia4TZF7S6tLsTcmh0rXA9cd0CI3QJxV13Nvd8JX30opueveyqZleUdmbBoM8
X-Received: by 10.98.156.23 with SMTP id f23mr30319876pfe.3.1491414452064;
        Wed, 05 Apr 2017 10:47:32 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id m69sm38726623pfc.33.2017.04.05.10.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 10:47:30 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com
Subject: [PATCH v3 4/5] submodule--helper: add push-check subcommand
Date:   Wed,  5 Apr 2017 10:47:18 -0700
Message-Id: <20170405174719.1297-5-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <20170405174719.1297-1-bmwill@google.com>
References: <20170331235623.166408-1-bmwill@google.com>
 <20170405174719.1297-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the 'push-check' subcommand to submodule--helper which is used to
check if the provided remote and refspec can be used as part of a push
operation in the submodule.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 85aafe46a..6ee962207 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1105,6 +1105,50 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
 	return 0;
 }
 
+static int push_check(int argc, const char **argv, const char *prefix)
+{
+	struct remote *remote;
+
+	if (argc < 2)
+		die("submodule--helper push-check requires at least 1 argument");
+
+	/*
+	 * The remote must be configured.
+	 * This is to avoid pushing to the exact same URL as the parent.
+	 */
+	remote = pushremote_get(argv[1]);
+	if (!remote || remote->origin == REMOTE_UNCONFIGURED)
+		die("remote '%s' not configured", argv[1]);
+
+	/* Check the refspec */
+	if (argc > 2) {
+		int i, refspec_nr = argc - 2;
+		struct ref *local_refs = get_local_heads();
+		struct refspec *refspec = parse_push_refspec(refspec_nr,
+							     argv + 2);
+
+		for (i = 0; i < refspec_nr; i++) {
+			struct refspec *rs = refspec + i;
+
+			if (rs->pattern || rs->matching)
+				continue;
+
+			/*
+			 * LHS must match a single ref
+			 * NEEDSWORK: add logic to special case 'HEAD' once
+			 * working with submodules in a detached head state
+			 * ceases to be the norm.
+			 */
+			if (count_refspec_match(rs->src, local_refs, NULL) != 1)
+				die("src refspec '%s' must name a ref",
+				    rs->src);
+		}
+		free_refspec(refspec_nr, refspec);
+	}
+
+	return 0;
+}
+
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -1170,6 +1214,7 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
+	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 	{"is-active", is_active, 0},
 };
-- 
2.12.2.715.g7642488e1d-goog

