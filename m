Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5F31FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757397AbcLCAbE (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:31:04 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32968 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754661AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pg0-f46.google.com with SMTP id 3so112882735pgd.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MlejUiDpCmMveY1L9gMMh0IaDB1d71K39/pfynPoaSc=;
        b=cJaB/a8WsDsvmb8hghWv50YVajm0eHkpp7Rkw87vV07OjuaklfYbqWJS8jkhoEpToS
         IDznUgyHuVR6sNDzkXFbDYqpcM8H99B2serF3I8oBjADXi9+Ousb6B8cFSm+Gm6SwYSG
         ysLGPAbRY6ZNO5ryEJjK/xH5dpfIa8vz7HUO2l2RHDlEYDArR3NFPnNEE8i5Cw3nIElU
         OkfZrijWwB5Oy/HNWXujAVXXH0j3NAyasdTubKAqUMNd7VHj5M6tHvxKcA6zKD+Xm19X
         DE06BOpXTqzaHrZhRjJLlnKLqNdc5ZNZ10/oJ2nEfjADRVs99qn4PVaU0vDzMiI7s0mz
         tKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MlejUiDpCmMveY1L9gMMh0IaDB1d71K39/pfynPoaSc=;
        b=d/SotMUAIawq1Y3UmxuiAjZR6VgZ18LHW80vceks+NtjEo5nUmq40pBN/6yl7RrXxc
         bplAuTzLSA+zpSNA2VJfxCeVYP5z4SWiTogkgUujq1Pad4BJ9t4yeihgNUgUqsLO5zD+
         G2qRrXp2WS4S0+C8265LyvBu/ivj7NLUKy/7/wNArBxBlxs/6AA0YiPGzRqfNg6Vp5ug
         pHxLzZCTxEcVz8sl1EU8YL/XOnON/5jh02G3synuTA2vUlQn/ba+4nnR1ByERzpJH5Ms
         9vjB+Gy2qouqVEaVPhfuWqQfon9Eku3gPGaMfxZdLRGFswQVXkJKN/F8DJXbJUodiRsa
         snWw==
X-Gm-Message-State: AKaTC03O8pr3L3xidGVPnMbF39nzOGV2pdQmVW5T9CYlw68QyTrjpXLW11rZB0J9zfb80TY4
X-Received: by 10.99.234.21 with SMTP id c21mr84779184pgi.166.1480725040397;
        Fri, 02 Dec 2016 16:30:40 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id p79sm10248043pfj.51.2016.12.02.16.30.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:40 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 06/17] update submodules: add a config option to determine if submodules are updated
Date:   Fri,  2 Dec 2016 16:30:11 -0800
Message-Id: <20161203003022.29797-7-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
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
index c29153e9ff..1ba398ba3b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -16,6 +16,7 @@
 #include "quote.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+static int config_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int parallel_jobs = 1;
 static struct string_list changed_submodule_paths = STRING_LIST_INIT_NODUP;
 static int initialized_fetch_ref_tips;
@@ -510,6 +511,11 @@ void set_config_fetch_recurse_submodules(int value)
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
index a9eabcc3d0..21236b095c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -53,6 +53,7 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
+extern void set_config_update_recurse_submodules(int value);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
2.11.0.rc2.28.g2673dad

