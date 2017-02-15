Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8F72013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbdBOAfO (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:14 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:33097 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdBOAfM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:12 -0500
Received: by mail-it0-f50.google.com with SMTP id d9so22204507itc.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S+cF/ed77RJRj8gLjH4FQCDXDatfDelT403SI0vwGNo=;
        b=Ckc/NhJViovKRco1xWcRPRJQiaB2DZJXeka+5GW5/ChevQl5FDmykaWZnscjuhV6Rf
         QJn7EwyBpIEk4tiieMzVKrp1qnnGYl6ogkYENeUOoho0ZdrlcR57FK4ILBUfZRBlJSyY
         jX+Dx+wvV7czGkuaE89i5kih0o1al4F4n+T8TUt1tyQFRhhLPz+F3Y5B6t09WJRTlG+R
         yYXStbef7/iGedi8BuQtYIIlkZT4cJPLD/89phLiD7o6EJ/xnaxpBjELfTX2KXOPN028
         5B3uK2uFCwo83f57T2vVKbVOnyHCqrDxSy9yRkR5/J5SrOcQ2XqwLOrENexU6XD1DBPo
         E1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S+cF/ed77RJRj8gLjH4FQCDXDatfDelT403SI0vwGNo=;
        b=LvjOTd8AeasoA/SsRijMvYqdplNqBL/7o49lSL1o8aXnEloImJpmiZfyTY4qbqObzp
         m1S+KK8HGlS4mTFSZLXHyvUla2dAZZMpDvQ2lLHMp0VrXB02cr6DAElejoPNi2SbANkc
         Guy+752evHhD1NpSTsJYuJyLuUYGZHodVfAUEPVMkM+LZBhrFiSfQcuenNAUw3+OzcXn
         OtiRSwc7bTJCc2N5u3AxO49PaS9myNO1qcjJ4ekld2vBrgd7tlla046JylYEtBMmVuiO
         ANM0nfDSTNHXvFlMl+6O2JaGCcjnMhs7XW9Oer2oCwK44bqTzxvDJNtllY+1KnlE9SeN
         lRVw==
X-Gm-Message-State: AMke39ndaIad873tkENriSVNrfHAWjkd5FP6xYjq+z6u2vEOXUoPQcYwxy7Q99Zj4KFabry6
X-Received: by 10.99.54.196 with SMTP id d187mr35421930pga.91.1487118911492;
        Tue, 14 Feb 2017 16:35:11 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id m21sm3402864pgh.4.2017.02.14.16.35.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/14] update submodules: add a config option to determine if submodules are updated
Date:   Tue, 14 Feb 2017 16:34:15 -0800
Message-Id: <20170215003423.20245-7-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
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
index 9bbdd3ce7c..c0060c29f2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -17,6 +17,7 @@
 #include "worktree.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+static int config_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int parallel_jobs = 1;
 static struct string_list changed_submodule_paths = STRING_LIST_INIT_NODUP;
 static int initialized_fetch_ref_tips;
@@ -545,6 +546,11 @@ void set_config_fetch_recurse_submodules(int value)
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
index 689033e538..c4e1ac828e 100644
--- a/submodule.h
+++ b/submodule.h
@@ -58,6 +58,7 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
+extern void set_config_update_recurse_submodules(int value);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
2.12.0.rc0.16.gd1691994b4.dirty

