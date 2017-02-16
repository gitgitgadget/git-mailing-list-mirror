Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D0F2013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756260AbdBPAiq (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:38:46 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35308 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756252AbdBPAim (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:38:42 -0500
Received: by mail-pf0-f173.google.com with SMTP id 202so795989pfx.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BJNtJ4379q9YzgTsCPyRzLzBBnH08QCM+ABbViGiGjw=;
        b=bfZsuv72XxySQggJO/nSEfkuYj1l+p9kegHrepiKsf5vviE0Y87pSe+8uYt0e9NPcG
         3QNU+PzEeQjnvY6JFmezGAweUiThZNVzf3riFdOpviYDJwTcF3fOZgkJulN2kDnOx/H6
         c3OAm8KLB1ab1Or64tsolmJkhFykckuzLUoaPV27VsNBudVbVjp/Af1w5Gbshtb+SG7R
         aG0oeIxfYkjdkpzrw07nggvILHsSxTteMvhAUXJvpsm5YVebVEBeFd3pJTVoJcg+HzaX
         KUmb2PJZvIDiokp+oq9OGzTn5th4gfMqqaonZd13ArwppIRpvX/Mvrk4upDEbNjFaF5C
         dJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BJNtJ4379q9YzgTsCPyRzLzBBnH08QCM+ABbViGiGjw=;
        b=jn2qaaYocANz+kHJ22Ze7Xa28wzGTPJ8VzESvSizTDbw9jmJhIrjEdNNp731zJ9jaz
         z2ZB1KY4CRAxQl8YgUvwlR2PPTyaS/JkF3qTUrlwpqwsgxwfZmar67XH6sPvUK+FY3Vz
         Ojae7b97wt//HzXfBRhQM6ca8m0JCYrarXI3ZbeUu24nmiXxQ71fjTo4EUCOTOm6LfJ2
         HBCxbFMWB0pAtrXwtemQwy+toRG2o2ONcMKdrhlPXposgXEJmWesT0rj2L61Y2POgiWr
         mNxFbHqHZwBWBAADv0WdIEYxO175a4eoAmA4yGg17uSJGiSFEQwkQbm4aRLmXcWUIDk4
         t/Uw==
X-Gm-Message-State: AMke39nmU15uSeYnilOLTb0rZLLqvljZ0+VOUocRWBPnuZdoLoOoP1pN8ETQcbO/rpdRLU5Z
X-Received: by 10.84.176.131 with SMTP id v3mr47632340plb.20.1487205510975;
        Wed, 15 Feb 2017 16:38:30 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2ca1:506:4965:89ed])
        by smtp.gmail.com with ESMTPSA id u124sm9656425pgb.6.2017.02.15.16.38.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:38:30 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/15] update submodules: move up prepare_submodule_repo_env
Date:   Wed, 15 Feb 2017 16:38:05 -0800
Message-Id: <20170216003811.18273-10-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170216003811.18273-1-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
 <20170216003811.18273-1-sbeller@google.com>
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
index 2a37e03420..b262c5b0ad 100644
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
@@ -1401,18 +1418,6 @@ int parallel_submodules(void)
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

