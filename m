Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3CBE20951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbdCNVru (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:50 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35338 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbdCNVrF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:47:05 -0400
Received: by mail-pg0-f52.google.com with SMTP id b129so96370206pgc.2
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nBgA1+UaRdEMk27yLOambNg5lwC9uMQqqX+uY+5Nf70=;
        b=i7VIG69Ow+IQ/5KEBJQShyxdcjC+iWIoO7mfn4zwGpgIcTGK2flu253SRPD7i9Mdg5
         CY2GBu4ORPmv4pYet4hJB7b3iQAQi8tNlYnvkCOQkT9UHBNsZXaUdz4pDcMMHCfEqnaN
         /dcQyElogQdg5yV2FyY7xIlsRiKYo51RpsmS8pDdzfyLwri7rBBzC9BzYwvsCmhS7zzl
         WQ2ydWH/ujqCtawjyKkYAOx1attBSvREPZQddhljWEN4c3MPC9NDZ61ODN0isEFydKDR
         TjbRL2kLYERfgLE7Yjyk5X8mwq64SqvVRHviCRWivJapjGzyfwjV/y1NX1dRfOPL5Fgg
         X7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nBgA1+UaRdEMk27yLOambNg5lwC9uMQqqX+uY+5Nf70=;
        b=rzgXotgN7/rHALzs88EB/Nx4kVXQILgr+fcBXChZh8ynx5DgmFGlNK12EJrPHm1G7A
         acloo8rTdi2u/Bf/j+CK3drJJOxGzn+7XlrVTMuO18QDSso6+kO2+HTU6tfoF7dFe+iE
         LNDD0jf2yKaL4aD4UU8M/Lw+5LxwxmiFlXTDY+u0SEtgG+QoIXUAFkY0AM8tASFhDdet
         hngEKN3m0qku21nzY7IbBXK/xYQw95SmKzam/qlrj/VkL1my5YE/Pn0cdbhLN8/81Ywt
         xKXgrLPJGVQVhBSHMpTODtFpgbIDucWSjxOUTxKk7WKEhszbKjycathMmjR4da62wbl7
         aF+w==
X-Gm-Message-State: AMke39n/o0hWSynbWf41N2ct2g3NWBEWJUMhkw1ZW+mO3utpkFFp7JR37EUHkFeTw7m/9gPV
X-Received: by 10.84.228.201 with SMTP id y9mr58689504pli.42.1489528024101;
        Tue, 14 Mar 2017 14:47:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id p66sm40304450pfb.88.2017.03.14.14.47.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:47:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 12/19] update submodules: move up prepare_submodule_repo_env
Date:   Tue, 14 Mar 2017 14:46:35 -0700
Message-Id: <20170314214642.7701-13-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
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
index 8b2c0212be..0b2596e88a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -356,6 +356,23 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
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
@@ -1390,18 +1407,6 @@ int parallel_submodules(void)
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
2.12.0.rc1.49.g0cfd38c5f6.dirty

