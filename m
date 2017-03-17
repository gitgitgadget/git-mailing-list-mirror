Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9BC20951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdCQRXN (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:23:13 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36043 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdCQRXL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:23:11 -0400
Received: by mail-pg0-f54.google.com with SMTP id g2so46064087pge.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0mHBHsUECPAZzUZYTpg9t/FX0Smd96CUV6tZAR3pgBw=;
        b=v5d0VmriwOmu6WBKmMwzFv45+zEnbUbMqv4DsIkuqLn92CfQCPHKVwpHP6NRDjOFX9
         BEM//Caj2mGAEZIsxUJ/ZwnRvQBYh9mnMt0kaMajQ1+HAU8/0refgrfkyfI1XZ99VVB6
         mE9HAt/Iwbniw7w2vZYu2HqC88C/110ZZPPaRNg/qAXI+Uz/KLG03kJQI4t3Y7+xCGl3
         VyXIfT8588GgKqvlEsR94xx6EeP0bE/QOe7ubK0Se8qEWNlPopnbtXOs6khqpPEiw7wh
         dahif5tvS8TnM7JLRLicrNvj/T1OrMaQFgxVACfgEUskEe2XcjVftvY7yZkJr/ckQctq
         502Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0mHBHsUECPAZzUZYTpg9t/FX0Smd96CUV6tZAR3pgBw=;
        b=py0/W63+9cRWb7y6//TzM/mdEMXJSudTLDmbIOK90wbYj5jVn3NcWwvL7W6nDEsnze
         GUWCO5k1gzwAgsFvXGICpSvgiCLFzO2o81+glu7sjlX+9qSWDf0ovNzYI/HUPW1z8Nr9
         omxpZF6WEq9QBxqXo+5IuNPMMvayTSIo9Lttc45wP8NQTU+42nAxAM2ZQWtMHRezIlG/
         HJK7LCxQz7Y2yn1MHBLLG9pK47+B4nx2HUJs6qfnu0CvmoGTupNoL+7KcQ3OS1u9bGM9
         Bdhtg4Lm9qqGJBClid8b3ZxKKoHgeNAHHEpGxfcoSz6+6qiObLNupWMrZADT5Hyk43gK
         /nZQ==
X-Gm-Message-State: AFeK/H3JxbEXM6c7dGgwNFtEMlh84owBhIxYzPgLdFJHthB5cS36nzUn58/DL5I+UbpMjB/p
X-Received: by 10.84.192.107 with SMTP id b98mr21558615pld.160.1489771385257;
        Fri, 17 Mar 2017 10:23:05 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 197sm17978861pfv.19.2017.03.17.10.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 10:23:04 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de,
        pclouds@gmail.com
Subject: [PATCH v3 2/5] setup: allow for prefix to be passed to git commands
Date:   Fri, 17 Mar 2017 10:22:54 -0700
Message-Id: <20170317172257.4690-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170317172257.4690-1-bmwill@google.com>
References: <20170314221100.24856-1-bmwill@google.com>
 <20170317172257.4690-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch child processes which act on submodules need a little
more context about the original command that was invoked.  This patch
teaches git to use the prefix stored in `GIT_INTERNAL_TOPLEVEL_PREFIX`
instead of the prefix that was potentally found during the git directory
setup process.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h | 1 +
 git.c   | 2 --
 setup.c | 7 ++++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 8c0e64420..7d253a078 100644
--- a/cache.h
+++ b/cache.h
@@ -410,6 +410,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
 #define GIT_SUPER_PREFIX_ENVIRONMENT "GIT_INTERNAL_SUPER_PREFIX"
+#define GIT_TOPLEVEL_PREFIX_ENVIRONMENT "GIT_INTERNAL_TOPLEVEL_PREFIX"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
diff --git a/git.c b/git.c
index 33f52acbc..8ff44f081 100644
--- a/git.c
+++ b/git.c
@@ -361,8 +361,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	if (!help && get_super_prefix()) {
 		if (!(p->option & SUPPORT_SUPER_PREFIX))
 			die("%s doesn't support --super-prefix", p->cmd);
-		if (prefix)
-			die("can't use --super-prefix from a subdirectory");
 	}
 
 	if (!help && p->option & NEED_WORK_TREE)
diff --git a/setup.c b/setup.c
index 8f64fbdfb..0d76b9828 100644
--- a/setup.c
+++ b/setup.c
@@ -939,9 +939,14 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 
 const char *setup_git_directory_gently(int *nongit_ok)
 {
-	const char *prefix;
+	const char *prefix, *env_prefix;
 
 	prefix = setup_git_directory_gently_1(nongit_ok);
+	env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
+
+	if (env_prefix)
+		prefix = env_prefix;
+
 	if (prefix)
 		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
 	else
-- 
2.12.0.367.g23dc2f6d3c-goog

