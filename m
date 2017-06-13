Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5F471FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754026AbdFMVDm (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:03:42 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34946 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbdFMVDi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:03:38 -0400
Received: by mail-pf0-f170.google.com with SMTP id l89so73438578pfi.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/C5EvoUxg8LqVKXX8YE7s/o6EMgfqjVR73iQ1oqJFqU=;
        b=n8AhNfkruBnCyjmqE9j581mwck38+h0y5gNjk1nxhIrB3Id99RUYb7GgsGMXNYKDMb
         hep0+SMh7N/2OUrAT9lQMh7n7f9ZZbTyPwm/4Vae5a2oENRBFE0ml8cQ7SbE/sZOcabb
         55XJGGSXc2sREgy3ytcx/lJ7oV8DIPOIcAwkDGCGFVb/R1bFSAo9nW17eb63L1F2ZgMn
         T2rUAAurmZ6YVfv6eYQTjK8RjE6rn/8XbdsPmZRVj/tHzJJQL89KNvE2D1dfvh0B9MhI
         QBKxSI59ioEVwZn6C/h4Pz8N8ayIoAsk3bPjL4HFZgd5jXVQTuM3trjHPM8/Z2Dhnxr0
         Wu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/C5EvoUxg8LqVKXX8YE7s/o6EMgfqjVR73iQ1oqJFqU=;
        b=tnluMXZ8hjT10I4lF67sVzTflZkYM1pR0sgR87A1oySul4xNnZCkvw01bs+z5x+z/F
         yD1zg3SlAGm2nOwaLqI97y76xWfN155cLJxbybvT/ZDMvEn0CrcH2YXvNppu3sZbnoNh
         00jdQCcvlS5lcGISCrjFBmJg3VPSa2RLHnIPLJU06LsZNalR0x7LqgoIRjrLvc4IvUSA
         mVPDbDkvewClsquPBurpFce+VHj4/KFWofB42TFGubh5YrfPU8ES378FR6vQ8+o6GQqR
         3TovXk4q3a1pT32bWELL4MSltO8izox2rTrNAbQGGQMjqlioc11NDxVHRkw0ViDjlNbo
         EKsQ==
X-Gm-Message-State: AKS2vOxO7swAZBr7fxpELmPTI3GMqap2ziqnmNG0UwPRofiBQbMNKsgK
        Gy6RslJ47pXoE29XTRLPaQ==
X-Received: by 10.98.207.68 with SMTP id b65mr1318603pfg.6.1497387812000;
        Tue, 13 Jun 2017 14:03:32 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b65sm29154065pfm.29.2017.06.13.14.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:03:30 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, peff@peff.net,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 4/6] config: don't implicitly use gitdir
Date:   Tue, 13 Jun 2017 14:03:19 -0700
Message-Id: <20170613210321.152978-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170613210321.152978-1-bmwill@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
not set up) added a 'git_dir' field to the config_options struct.  Let's
use this option field explicitly all the time instead of occasionally
falling back to calling 'git_pathdup("config")' to get the path to the
local repository configuration.  This allows 'do_git_config_sequence()'
to not implicitly rely on global repository state.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/config.c | 2 ++
 config.c         | 6 ++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 753c40a5c..f06a8dff2 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -539,6 +539,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		config_options.respect_includes = !given_config_source.file;
 	else
 		config_options.respect_includes = respect_includes_opt;
+	if (!nongit)
+		config_options.git_dir = get_git_common_dir();
 
 	if (end_null) {
 		term = '\0';
diff --git a/config.c b/config.c
index 2390f98e3..4e2842689 100644
--- a/config.c
+++ b/config.c
@@ -219,8 +219,6 @@ static int include_by_gitdir(const struct config_options *opts,
 
 	if (opts->git_dir)
 		git_dir = opts->git_dir;
-	else if (have_git_dir())
-		git_dir = get_git_dir();
 	else
 		goto done;
 
@@ -1548,8 +1546,6 @@ static int do_git_config_sequence(const struct config_options *opts,
 
 	if (opts->git_dir)
 		repo_config = mkpathdup("%s/config", opts->git_dir);
-	else if (have_git_dir())
-		repo_config = git_pathdup("config");
 	else
 		repo_config = NULL;
 
@@ -1613,6 +1609,8 @@ static void git_config_raw(config_fn_t fn, void *data)
 	struct config_options opts = {0};
 
 	opts.respect_includes = 1;
+	if (have_git_dir())
+		opts.git_dir = get_git_common_dir();
 	if (git_config_with_options(fn, data, NULL, &opts) < 0)
 		/*
 		 * git_config_with_options() normally returns only
-- 
2.13.1.518.g3df882009-goog

