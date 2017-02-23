Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50F022022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbdBWXEP (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:04:15 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33522 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdBWXEO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:04:14 -0500
Received: by mail-pf0-f176.google.com with SMTP id 2so417061pfz.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DSb5z/jnePkfXf90hb26YVD5EK/9D7nil42nEbqvCg0=;
        b=X90A8NvGUP6fheq+oTTjLrtOJty/5/7TG9JSzFkUIECZh9XBU/UyIGSZMDPlDU9wDi
         PvDJeqf0BivFvgFEwn7/u8qONz4bc41veHZl2KJyrHJX8VLYoTb79z/4bp2qz2ECCTDF
         9Ka8FYoRRhvbGRJdHNZCEPMRlz1mMW42FqPXYcNiMV8oufhTZTLDnNfFDoN74SfoGN/U
         WBRqLCtZ36GuPf6Q75RQRfG//DqopSNOcrjRQtO5NZVSmrUGf7QNmv+ZtFutGF9wselc
         7w157XbEHS40g6cUzIYYgHeRKCl6e3UUynGRulpYEJM1/hKOsBKTMPFKzvmk5GyhwEb3
         Ylhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DSb5z/jnePkfXf90hb26YVD5EK/9D7nil42nEbqvCg0=;
        b=TwHUbXdWv9a3hJ2RGPPsp0+uX0WCSrGJ8NwXukiNmYrxKtr/0hLvLQc069JW7CtEC3
         qiOK4aBH7lv+QhfDiJUJtUj93vPTlXrd/vRbCKNdGteNq/BZTPpjov8UdRNGAWCfDT+W
         cBNyDre8davcO/xQVylBKyhb4iIEUwRW9bZ4tozT8X1KuTngrfsnlZn+dUJ4hp8R5ulT
         7wpHC5CYtf5HhzRXuYF3c73POMRdav6AJFNpIWNWhnzwh9sl/Fz9qXL86U078n8ax9Dz
         JFsJyHqJ8ElPsa40GBdbxa3w5KJZMxCAqj21HR7MfnHScDVhYSl9RgM5RVMhdpOO1H9t
         gLsw==
X-Gm-Message-State: AMke39nMPr9mQFv6B2Hv2wBr8fgz/ZM+VVVMq6y4mrIXrsml7s4RP/urKumC0qqs5df22TfG
X-Received: by 10.99.127.89 with SMTP id p25mr31286063pgn.101.1487890682707;
        Thu, 23 Feb 2017 14:58:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:ad75:dfc7:8a6:1152])
        by smtp.gmail.com with ESMTPSA id s5sm11631315pgc.57.2017.02.23.14.58.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 14:58:02 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
Subject: [PATCH 09/15] update submodules: move up prepare_submodule_repo_env
Date:   Thu, 23 Feb 2017 14:57:29 -0800
Message-Id: <20170223225735.10994-10-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170223225735.10994-1-sbeller@google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
 <20170223225735.10994-1-sbeller@google.com>
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
2.12.0.rc1.16.ge4278d41a0.dirty

