Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D33820133
	for <e@80x24.org>; Tue,  7 Mar 2017 03:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbdCGDTI (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 22:19:08 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32909 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754299AbdCGDQD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 22:16:03 -0500
Received: by mail-pg0-f46.google.com with SMTP id 25so73524092pgy.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 19:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vmtEzzwUJhB8IaIzHUBIaneBclOWZcruGGKqiRrLPIc=;
        b=JmxCszpyFWJzuDpgUDcH2UjdgiWQQScoDRbZnIL8/1Pv+LBgjzFWW7k0/RTv4eddjj
         VettHY7p6I0bzceMx76c3rcg/B2YollJ2H/G5WAIAXUqzxHMT3E3x2RJ/Ns2HxrBvvIS
         B6yqdcQKAiFQvOUV/g5Ylu0c6oaJwgsA9YCXXAQUMcUbLKtWtCoSNX1w4Atu9owW4J/n
         PaoVfSEIq1jzSkzcqaC8kZessBzj2YD78B3m5t3CBP7zEuIGMMRAcakvbwBdy2yT1Cck
         ddka5iVosBmjqf5JYff4ofUCbvPSHUSv+ehm5vz6QjaqfLmwlr+bhhvZqbt4j/exOMpZ
         rnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vmtEzzwUJhB8IaIzHUBIaneBclOWZcruGGKqiRrLPIc=;
        b=GrfkCkX78/Tm2G/uyK8NilPJqjLDG/KBemTt6Ggb0eYPaNOBdTVTrB/Io3MD1hU3Xw
         c3ZQlnSIJEh39rY8zOo36ugM8TKSOnr2ye5bz2cxtL/3ycdZ8qvVJeTEMn8MAakUaKcu
         xs2Ege3a1DqMTDlBCXzPr8CP6nlC/Nwqm0jhMIYAzRPZ7Vt1ihyiTiPjwhEHIeJyHnV8
         krozVpoINc/L870eXX6YxBKEAQQCrmQ498ORGEvUXePirP6ZBjWxy0jwyT/On02wX5v6
         UtGHqQVMpakrUlOFnNF4OlwQUwZE1sA1DvAQpTOUN/ZL52b2vfl+R2lOA3AbiqEDiQEp
         qQmA==
X-Gm-Message-State: AMke39nRM/jqyF933BbB/vnqd8wv4FMwQqWlb1Qj7cBp0eO8lAcKzvr0ma5Y2cyZEDoY4MVH
X-Received: by 10.99.157.143 with SMTP id i137mr22901396pgd.132.1488833974890;
        Mon, 06 Mar 2017 12:59:34 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id d1sm41282957pfk.20.2017.03.06.12.59.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 09/18] update submodules: add a config option to determine if submodules are updated
Date:   Mon,  6 Mar 2017 12:59:10 -0800
Message-Id: <20170306205919.9713-10-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later patches we introduce the options and flag for commands
that modify the working directory, e.g. git-checkout.

Have a central place to store such settings whether we want to update
a submodule.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 6 ++++++
 submodule.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/submodule.c b/submodule.c
index 04d185738f..591f4a694e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -17,6 +17,7 @@
 #include "worktree.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+static int config_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int parallel_jobs = 1;
 static struct string_list changed_submodule_paths = STRING_LIST_INIT_NODUP;
 static int initialized_fetch_ref_tips;
@@ -542,6 +543,11 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }
 
+void set_config_update_recurse_submodules(int value)
+{
+	config_update_recurse_submodules = value;
+}
+
 static int has_remote(const char *refname, const struct object_id *oid,
 		      int flags, void *cb_data)
 {
diff --git a/submodule.h b/submodule.h
index 0b915bd3ac..b4e60c08d2 100644
--- a/submodule.h
+++ b/submodule.h
@@ -64,6 +64,7 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
+extern void set_config_update_recurse_submodules(int value);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
2.12.0.rc1.52.ge239d7e709.dirty

