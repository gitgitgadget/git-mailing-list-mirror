Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49388202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbdCIWQh (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:16:37 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36807 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753766AbdCIWQV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:16:21 -0500
Received: by mail-pg0-f49.google.com with SMTP id g2so13778253pge.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uq3uoY4f37iM6Q99vnvYI4P64nZfzvlMMRRrfQ2O9Ik=;
        b=qz7e086IQ8dReBHtI/kxARgNnDE4mc4XNoNUagEoshwxf8torABZXPD1zUxeKsmb7J
         wmV93qR5Tjas07hqtALCWq5DFD2DslSY3el+z1UNZKmllSyzL7/yh/JH6MJdN0tCKJ+y
         o9zW6sfahd5agj4MOVF/VltQM9EqEutO0mTMaWO2zKCVsWHcbGCqvGuD1+uLpdrufZHq
         TsNHiyJnbr61soznfpgRjXnGIisudD7sabkG0QKWVqth0kuHpgvrj4q6++/kAzruogBl
         6VJ5G5zxnWi/FqmNjFY8a/QABxL8aFLoRZmmPUXdAVdbQXkqW2RU4SNhVlF3DJvgy5Ae
         oQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uq3uoY4f37iM6Q99vnvYI4P64nZfzvlMMRRrfQ2O9Ik=;
        b=Bx0NeMe2nLZiQqTHsyju8DtBHTrzX6axexVThI0z7ka6kIkxTuM1rbTVt+z+0r7UhQ
         rhyt5n5niIT04rreckrM1xFRmu/yJBerUF20tmv0H8PgY50f+Fq1XOPZKD00dw1jgYEj
         DAmc3X+XjHKjkvtpHopNZg5ywv54MKFEEtajJ0j+BM9POdk+6L/TeEuEDSsOApnqbpwn
         wNx0hQtNl2Ip21X+6bARNbuKN7Bsl4gYgIpyPPviWwywKv36x2HaafaL8UD0OrMO+2Yo
         wz02z/TX0Zeg+ooNoLQHEntZTT+nouGv97G3Wlg9zv6ZmdI9D7r4IEBALmHDHyT9umUj
         ddbQ==
X-Gm-Message-State: AMke39nInKP6X+6gsPPtLOpWyMKu9U+3ig6t2V3quYkwBVDN+MQnKxWfNPVDEDtwFUzCb0Pg
X-Received: by 10.99.55.85 with SMTP id g21mr16673455pgn.65.1489097769658;
        Thu, 09 Mar 2017 14:16:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id l72sm14305852pfi.93.2017.03.09.14.16.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:16:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 11/17] update submodules: move up prepare_submodule_repo_env
Date:   Thu,  9 Mar 2017 14:15:37 -0800
Message-Id: <20170309221543.15897-12-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.45.gf291f29c2e
In-Reply-To: <20170309221543.15897-1-sbeller@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
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
2.12.0.rc1.45.g207f5fbb2b

