Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B1E2023D
	for <e@80x24.org>; Thu,  2 Mar 2017 01:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbdCBB6w (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 20:58:52 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35910 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753743AbdCBB6u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 20:58:50 -0500
Received: by mail-pf0-f181.google.com with SMTP id x66so16682197pfb.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 17:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+stxkB16UR0WhZMnDeVOrviOq/1N4LpAnz4kQUUDuKM=;
        b=vn4mqqhE5tS3j8nT+AYaYUHEIz7jejiN7bXyuX6xhyQWAS68Zn96jn0nPhdeMK/wLz
         f6rAmAPUQfgTDzON/7cGZgh1mvF8PmmdhRvQzvjmiWxZH0ZyV7S931S/unxy1j6Ov/bh
         aHKuDny4YlNI2YQEOninAS6pH4SCJb404ZMY+GKaFMn2mKE/NQF09yWn6Bmgh04j9tEg
         JXkWQ2KU2L5QLEBW2c1JxMvn5f0dUIdXVbS9fumZsmFy5UzBmUtHfl+K+uncMtX2ai/+
         bGhQ+Wt0IK3T5gAemyX+YsxroXjOwGXV1Arem9LzIFVzijohtuWK9bsADt8bc7AqvDSX
         5ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+stxkB16UR0WhZMnDeVOrviOq/1N4LpAnz4kQUUDuKM=;
        b=E/1dDakP3zI02wNuN+nBuG5DUqyHkaXq6s6zUGefWTuhQuAPGdoq/xEkHRExlFHakq
         PqCmLqBviQLqpzspAikXz9IbNQXfKvpDriaTf+94AwvRnzkLNY1P6n1X2GePpSW6pyml
         eNeai/XMEtYxUJFBzBFtTuhZfqKRg1jh87qOg19gzci6BySlC+4SHNOcOHLCEdq2SOoz
         BddKmgrlzWp6yHrpPHZSLP9NdVHeTe5oS5jg1h5RNYovW3aPColLwoXfxqyUoxTphOv6
         GrDZUQbI4HHP0TECYy8Ck33BsEeUunsKip0FktaWwjjfQM0nsZ8L9O7/9+qQCIUb2zlG
         u6Aw==
X-Gm-Message-State: AMke39mGH60rs4ECJrg4JcLBwIgOJ5pkx42xy9VJYpYobVYgPsCA+oQB6vkgszk+P6oFzTZO
X-Received: by 10.99.24.88 with SMTP id 24mr12338300pgy.54.1488415697983;
        Wed, 01 Mar 2017 16:48:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id w123sm12777250pfb.44.2017.03.01.16.48.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:17 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 11/18] update submodules: move up prepare_submodule_repo_env
Date:   Wed,  1 Mar 2017 16:47:52 -0800
Message-Id: <20170302004759.27852-12-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
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
2.12.0.rc1.52.ge239d7e709.dirty

