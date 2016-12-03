Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB061FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757491AbcLCAbL (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:31:11 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34009 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753399AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pg0-f54.google.com with SMTP id x23so112892790pgx.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TDiHvl6puvpJ/NaA5MJ0IbRMPKqm33UTYOe7lHwikBE=;
        b=ih/BKBC0gNQvcIKgmeStAkpdu/6V9wxKXtOONkbDdOO/EjcWpTOX/AO4eN80VmRxkZ
         vJcPBBh/0IjyBGE+rfxtGSWBUU6X58niQKeYFJOgyXJ+4vAyT9NE03jwvYpRpZF+O7Op
         HLxUhLNR+OV9mWR7CC9g4/y4emZ4ERl1v7aFkOJoAS251f+YK6Xhso1uBfafSUh/AYS4
         OAXmA8Sw3EU+g5ZXZp9bVWMfS0slFfcrJ6WsV8OR+8Km87mvZlPZ0tVCvHt66rPilVBX
         2CoFVjzR6oDhdIHHi/NtVGlQLM1AYaptjjGUEpFbJ4Vf5+RiWuSeCKnod/2jMSQM0gAO
         Tz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TDiHvl6puvpJ/NaA5MJ0IbRMPKqm33UTYOe7lHwikBE=;
        b=OBCbBCGXPTkVNZrQDAx5I+0pdDum514VH1aeLDgDrALiWyEau8BTotDwszuvx6yNpy
         XE19TqsE107kcnSYV9ZuE6MdPTsrWmiGOYONSCJw3m+OacfoBv9vQthh2tJgKdV3JXAc
         huMkAT7QAI+6NLkbVlSRd4BuISaSzvhsVohMujuA/shqaRyLta2l1AEgUik21QQ97e6j
         pfwRYZqianJeuLzOShfNL1JzR4LlAEgmfmcaGMsHPeEGkMMs9RyaRLt9nDsEZpt3bVGU
         z0GX6iZ2g/VdgOyj3J+Q3bEKIisDC+PV1nf/3fZeVo/8vLhIS2w+iORzlMbesVSQQkgP
         zcRA==
X-Gm-Message-State: AKaTC02gqCls30YytY9kYMjvr0ACgc/BsTQ1XKgXU56CYq2HbRsjaIycigRZqwa5ZCbCetfV
X-Received: by 10.84.135.34 with SMTP id 31mr100238537pli.50.1480725037359;
        Fri, 02 Dec 2016 16:30:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id q2sm10329475pga.8.2016.12.02.16.30.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:36 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 03/17] update submodules: move up prepare_submodule_repo_env
Date:   Fri,  2 Dec 2016 16:30:08 -0800
Message-Id: <20161203003022.29797-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
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
 submodule.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/submodule.c b/submodule.c
index eb80b0c5ad..78b69b5a55 100644
--- a/submodule.c
+++ b/submodule.c
@@ -307,6 +307,22 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
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
+	argv_array_push(out, "GIT_DIR=.git");
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
@@ -1246,14 +1262,3 @@ int parallel_submodules(void)
 {
 	return parallel_jobs;
 }
-
-void prepare_submodule_repo_env(struct argv_array *out)
-{
-	const char * const *var;
-
-	for (var = local_repo_env; *var; var++) {
-		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
-			argv_array_push(out, *var);
-	}
-	argv_array_push(out, "GIT_DIR=.git");
-}
-- 
2.11.0.rc2.28.g2673dad

