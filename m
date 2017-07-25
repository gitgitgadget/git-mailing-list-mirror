Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D7E1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbdGYVjw (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:39:52 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33460 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdGYVju (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:39:50 -0400
Received: by mail-pf0-f180.google.com with SMTP id s70so63048289pfs.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IIPA0xRWNOIB//TIpYwL7PDVp2enGZYpPVOw94JUrlY=;
        b=lqWfFZOy4fisV9dQiXyrC4KGuiwGEKJzBYNidbna2GVH4WYKqn6rfkWFFnIyEm0cqw
         v5g4VMD3rZLtD6eZGKWYXFSzaA7Hcoypwt1QKiuLlWzX0jUmVD5crYtHSGyqQAgEHuWt
         wP5RBE9GEk92X5Sv0t53/61D0vwR8UIZwg7rAXOIYQ7f8oR/yqAPDLuRisBiWaBpXAIV
         Q+mkAxcxI2eNk79j7AUKyQ/7aWb//21hZ8f6r002I4kFp1IhDdlpMcgXHdh4sdx9kXuh
         jyWnhj3knkr0KWRX3pwkv+/xiwTRI3pCvfdkYmo6OXmXuec76JJn1lqsrjNDLAejRtqX
         TzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IIPA0xRWNOIB//TIpYwL7PDVp2enGZYpPVOw94JUrlY=;
        b=LJPzdSkTKYpQwHlWowSaTi98TAhfblEjLlbVswAnCT8etXKtMbVSslhkuD9KlYxWXQ
         UlNXTWrbVpNwRS7zq9zJ+y8OM9XyvCHFcC8Cz34L4lrq/YjOaB5ofjLACeUunXBn4qnE
         0+mm2Cq62UKReSEgVBv71TeR55BkY+aJiBbFut+kgSVMok1U0oDFBrnRDYiY0eOnXue3
         Yj27fUYHcyUrrjBAJjnHLo1cu6ymgfw9sJvNnmzU6rxcRs/9p5evlSkB24A5q37CBH/q
         VhMTcRTxYvWWB7oVcu8+n5JxDYGAGKhoyxVuRx85ilJ3PJKX+qf9IKPRUQe4/Fl1Cesy
         Nscw==
X-Gm-Message-State: AIVw111kWl+7WVZeRwp7H1GpuM0B6vrU9F6FPIjTMvKfF9GNlwJV7vL8
        nkreL+a70Yi7rOlR+sRL/g==
X-Received: by 10.99.145.196 with SMTP id l187mr16131110pge.425.1501018789421;
        Tue, 25 Jul 2017 14:39:49 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:39:48 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 06/15] fetch: don't overlay config with submodule-config
Date:   Tue, 25 Jul 2017 14:39:19 -0700
Message-Id: <20170725213928.125998-7-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't rely on overlaying the repository's config on top of the
submodule-config, instead query the repository's config directly for the
fetch_recurse field.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c |  1 -
 submodule.c     | 24 +++++++++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d84c26391..3fe99073d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1362,7 +1362,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
 		gitmodules_config();
-		git_config(submodule_config, NULL);
 	}
 
 	if (all) {
diff --git a/submodule.c b/submodule.c
index 8b9e48a61..c5058a4b8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1210,14 +1210,24 @@ static int get_next_submodule(struct child_process *cp,
 
 		default_argv = "yes";
 		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
-			if (submodule &&
-			    submodule->fetch_recurse !=
-						RECURSE_SUBMODULES_NONE) {
-				if (submodule->fetch_recurse ==
-						RECURSE_SUBMODULES_OFF)
+			int fetch_recurse = RECURSE_SUBMODULES_NONE;
+
+			if (submodule) {
+				char *key;
+				const char *value;
+
+				fetch_recurse = submodule->fetch_recurse;
+				key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
+				if (!repo_config_get_string_const(the_repository, key, &value)) {
+					fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
+				}
+				free(key);
+			}
+
+			if (fetch_recurse != RECURSE_SUBMODULES_NONE) {
+				if (fetch_recurse == RECURSE_SUBMODULES_OFF)
 					continue;
-				if (submodule->fetch_recurse ==
-						RECURSE_SUBMODULES_ON_DEMAND) {
+				if (fetch_recurse == RECURSE_SUBMODULES_ON_DEMAND) {
 					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
 						continue;
 					default_argv = "on-demand";
-- 
2.14.0.rc0.400.g1c36432dff-goog

