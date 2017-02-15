Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CCC82013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbdBOAfi (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:38 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:34984 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdBOAfT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:19 -0500
Received: by mail-it0-f43.google.com with SMTP id 203so56275695ith.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9YcyJ8n69b11NfBBwfyGKV5Y1v1QAhe70h397KiYY3w=;
        b=TMcn7hiuffEtYUApLvEs+z/DFsk9qtiDHxZvwVE9cdSox5O4FfJGSrx5Mi7bDPM2/j
         p+IjBrNGpdNlSxAgKO65NeVjZbrpRMQz+mflMnnbygombzM7HlxGApFpRJmccGUtvAUN
         +JuouMKfpGGLrvjwbCwmZEwkwOIZXKLi1Xhx0lkPzGdmS/5cM4Oz4wyOpsUn3UvKBobm
         TEHMhkOfUlbiCFzEVXdjU8Y/SJ7ondXxO7FShAdvVwk2vzzafxymZKRJ3A3JCGQnZBCw
         4DBwrlvlvkSLZKr173oW3SOKlEXPBF23E+UP73EvYJSPU3rW/zLa7YcAxIMgLd0e4YiP
         6KVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9YcyJ8n69b11NfBBwfyGKV5Y1v1QAhe70h397KiYY3w=;
        b=awWtrIsUe3dr9Vx2uAgGZ3mYLQ6SsbP5+FV8D4FcE/5XXQHWTcPktjFp+go/EYCxl2
         2+IYAJUuFtPFts4VUaAUvjr/mXPWpL252i9iBOWLvwerPR9G76KnHnnlb0FBpvMIFXpQ
         qJvpV4hG68Q2o7KaPXfAVVyJ4BUqTXtLnAVk2FVE7l1meYYEJyLI3RmZLmC+QfnYxPmv
         A64ecjo6+O3NI3Brrl9+BtDJ1O9wZL2cBUW/mKDoLPh56QaPzWHve65hcdh2Wst7tbN+
         50TJgDw+P9HmUsf/HfkGssWeR42zGNOVoMnLcwgeZg9hdj2kzTG4KHojsP+3I9TS8mVR
         nO2Q==
X-Gm-Message-State: AMke39n4qO2dC5V1ZxPS0g7NJwFNxhOSrbyQzGKtef1V1EI0YTAxENmX3QYN9XNey3j4uuaQ
X-Received: by 10.99.213.81 with SMTP id v17mr35145549pgi.130.1487118913866;
        Tue, 14 Feb 2017 16:35:13 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id v8sm3370586pgo.14.2017.02.14.16.35.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:13 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/14] update submodules: move up prepare_submodule_repo_env
Date:   Tue, 14 Feb 2017 16:34:17 -0800
Message-Id: <20170215003423.20245-9-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we need to prepare the submodule environment with
another git directory, so split up the function.

Also move it up in the file such that we do not need to declare the
function later before using it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/submodule.c b/submodule.c
index 4c33374ae8..d3fc6c2a75 100644
--- a/submodule.c
+++ b/submodule.c
@@ -359,6 +359,23 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	strbuf_release(&sb);
 }
 
+static void prepare_submodule_repo_env_no_git_dir(struct argv_array *out)
+{
+	const char * const *var;
+
+	for (var = local_repo_env; *var; var++) {
+		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
+			argv_array_push(out, *var);
+	}
+}
+
+void prepare_submodule_repo_env(struct argv_array *out)
+{
+	prepare_submodule_repo_env_no_git_dir(out);
+	argv_array_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
+			 DEFAULT_GIT_DIR_ENVIRONMENT);
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
@@ -1403,18 +1420,6 @@ int parallel_submodules(void)
 	return parallel_jobs;
 }
 
-void prepare_submodule_repo_env(struct argv_array *out)
-{
-	const char * const *var;
-
-	for (var = local_repo_env; *var; var++) {
-		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
-			argv_array_push(out, *var);
-	}
-	argv_array_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
-			 DEFAULT_GIT_DIR_ENVIRONMENT);
-}
-
 /*
  * Embeds a single submodules git directory into the superprojects git dir,
  * non recursively.
-- 
2.12.0.rc0.16.gd1691994b4.dirty

