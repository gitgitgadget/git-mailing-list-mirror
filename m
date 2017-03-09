Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481CE202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753830AbdCIWQd (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:16:33 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36469 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753792AbdCIWQY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:16:24 -0500
Received: by mail-pf0-f178.google.com with SMTP id o126so33730447pfb.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jK+PxNMlvXZMVeXn1fjRElpFWXtPWZU5BayKnogJHXs=;
        b=EojsTmwP1NQIptD2m6ZPjmsMU5WZIGn0sn+2+junUodjRpXX3Ywd0HBsd+2ACp8o/q
         2l5n7sYocuErSTgITnr7Gr8YiBVPzOJaisgphLBJN7sQS1r6aVi9s+Jwob1IDMeXdveU
         /xHw3sP21c1oZX9gHXUkn46VQnoDLSf1NAqoGhYJfsPSpEoXy4MsbEwp6pYlDtE3IhMu
         6bkPx9ZxTdfK1JTB4jUV1Zu72uCtnD82BT7RcRiv6XEA7zVWsH7juNf3hodq6fQpe2fr
         U5CKGX+LHptrhYg9qzg5LTzbbpAgL3i5mTUhYAf7C2n9tkGxsbhfCCnW1wADQlhzm6ut
         UjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jK+PxNMlvXZMVeXn1fjRElpFWXtPWZU5BayKnogJHXs=;
        b=OwKpgEEV/sWSM5tZgzraFS1415W9vwEEkSMsGcMlzaCY698iIlSKrc2tiNWfS9/H6s
         cujV1WGJVr66xolt1M8mRjfLBSS0MAe4DW+Kgb/VaQW6c60lZnBUakkmI5s3+ymwqfTP
         fVVz4AlYmZeGtHFR3DlIy76SMDN5HbMaHrZml+HLC0w+gmy94ikLMjkuWjThOnHSWEBz
         4EbFd1S1V1aDSHRsdET4+inEsnf6T8CWoIwEbA7/QMb3LESeBUIg7CWpbjz4yAYcX/R6
         QmfQL/WzGTpoT9+gW/E82bzqbIExV0SfCEMb7aWNHKcCfFq31/PefyQuZc/FxttlCNTf
         w55A==
X-Gm-Message-State: AMke39ljl4EfpLWK25J6rj/CX3jeVPdGeuBcIY2TSteDPX/pbjYPG+lWUIdsVg44Vc9b/H0v
X-Received: by 10.99.64.70 with SMTP id n67mr16266468pga.53.1489097767367;
        Thu, 09 Mar 2017 14:16:07 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id s13sm14366512pfk.26.2017.03.09.14.16.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:16:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 09/17] update submodules: add a config option to determine if submodules are updated
Date:   Thu,  9 Mar 2017 14:15:35 -0800
Message-Id: <20170309221543.15897-10-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.45.gf291f29c2e
In-Reply-To: <20170309221543.15897-1-sbeller@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
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
2.12.0.rc1.45.g207f5fbb2b

