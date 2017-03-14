Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0659020951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbdCNWLT (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:11:19 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33700 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdCNWLR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:11:17 -0400
Received: by mail-pg0-f50.google.com with SMTP id n190so7845550pga.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 15:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MALlSRztFR/EpOwsB2C0bLTYfTB8hglmJX7sWilPBUo=;
        b=jlgybL+fGlDYLepNJ8bmnZRAJShYUNGKMy7AcK+59ajwu1SfXIH/XwfMkCuUKL0AnU
         uZ8OH31GA03kU5Wz/H9r/YdApmYLLBcSPZj7BeM6GrOKjwsA9FMeOhbIzKwOPbXXLaSc
         C/vJm2W+oDTu1n4VQsbV8GF4OWdtTW2KXkbTEoNgr8d9X6SdMRGI+uHo9KbO1DbGVyz0
         Q7e2im2L/tj6B7ulGnojdnYOe/MetT8wtE2njjfTJPLt6LaUWUw2fyysrQa8CfqPZ/C5
         TQ99saywVinWq4C+CKv9vCxmXA5Ww2foCM/5WK/D9BOhgcrHoMtv7EwRMZvRM9YjzYaB
         2YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MALlSRztFR/EpOwsB2C0bLTYfTB8hglmJX7sWilPBUo=;
        b=Hd36iN5SPNT5lL75U3gWVt6kKmnRUdFc1+CTrVoxmW/ajxO3N9JYNj2Ih8SR2J8dMO
         M7XkjipUmWjZL1ztjo8zlbsKDDfg/jnrQQ58BjshvUbtHFGegXOEpUHiqqOwikQgj2zn
         ILufit2ny35IKss+gGgXpNtPmEmVspt9CUh2V4vvUhkR55AZ9ErCwgmnNcXdiLvD2DMm
         PctQ3klU34bRexaSF0BmZp8CZi4jkrzjYjxEJi5iwj/VZSeHi0utTBTzpMQoP+FpRykG
         V+Vuatr3T4IZm9A/xzIe6RpA15CwxekmtLANeIajIBuiKk6eu2obdHoiIYAHYErD52HT
         d9Lw==
X-Gm-Message-State: AMke39m1F5wgI0d9pFRhUaDrMXNVoij8ngG1O6EgnZ3JE+6LQ2iDARDq1/ebVZX6Z/WeNV5w
X-Received: by 10.84.212.8 with SMTP id d8mr59769540pli.152.1489529475845;
        Tue, 14 Mar 2017 15:11:15 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r12sm40691742pgn.26.2017.03.14.15.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 15:11:15 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de,
        pclouds@gmail.com
Subject: [PATCH v2 2/4] setup: allow for prefix to be passed to git commands
Date:   Tue, 14 Mar 2017 15:10:58 -0700
Message-Id: <20170314221100.24856-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170314221100.24856-1-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
 <20170314221100.24856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch child processes which act on submodules need a little
more context about the original command that was invoked.  This patch
teaches git to use the prefix stored in `GIT_INTERNAL_TOPLEVEL_PREFIX`
if another prefix wasn't found during the git directory setup process.

---
 cache.h | 1 +
 git.c   | 2 --
 setup.c | 6 ++++++
 3 files changed, 7 insertions(+), 2 deletions(-)

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
index 8f64fbdfb..c8492ea8a 100644
--- a/setup.c
+++ b/setup.c
@@ -940,8 +940,14 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	const char *prefix;
+	const char *env_prefix;
 
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

