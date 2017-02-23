Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81632022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdBWXGc (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:06:32 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35058 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdBWXGO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:06:14 -0500
Received: by mail-pg0-f48.google.com with SMTP id b129so2306264pgc.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w1cI2EFWb9lMxcuuzSyOwJyetS/w05jlCg34NcUCfxc=;
        b=oFEyn7oye4P5yDbVMzDaxAAPUiBqenEiF6rDoa6f6Yw1qiN3gM6xuQVUhSSXAt59zW
         8y+eg8lmowmKYuSNPJdI2G4EXbWzL/tBIZVdaz0u/XD9Uiytb3oHSWfxglJoB8NN9rdh
         Tu4nkZV1VPLE889otFa4KTqSX/g0uoWs1sZ7KvvpG3NSts/7SXVKAs0GIW829MmIlZOf
         FG+tTdakt+ZvzdIAlJB57qX6aqSDYrL5wxN4fLXaRD9K0koadDVkUbs1UmrGuw4BoB3G
         Z8rfIY8/lBO8QRvUSwHWtYP6Kh1sbqfuKoSWmzZuD5BUycGY+ZlEU8duuaijyORii0VQ
         z1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w1cI2EFWb9lMxcuuzSyOwJyetS/w05jlCg34NcUCfxc=;
        b=kpxDr/1soHWnWGqrH6fNNZEyaaaFDblACvcHNSMZt+PPifdPzaW+KrxL7Fyph2cSwF
         D3fXr3l9pjJ6Wlik6TXUw4EnEmV0lGYnuTvSN7JmssAe1IUJUmY0A0iz2zbJulNRgF1H
         LeOz7syahgQhSRdTryh5oGV8Reg64uuyC116Agp04mlyaxzlvV9HLbSbLYo83MT8FOQO
         QJx+u0UjglUi3cud7Csm036ytpiNsU+u5ARfO51HoXu97Mz/Zzb+bN/vzgV1Ha325S5W
         gXHoeH8rcFNQn6KxaTBL5jDsS8x1klUuSPlLFiBKuHGNQ6n6xvBIa3yy1le7nOjQByBn
         bhlw==
X-Gm-Message-State: AMke39mXYZny8PTdUlrKsCOUEKTz8kvBo1J19E3p3vpFrHvyjnfVsX2Z+/xjvFsd82ZS66lg
X-Received: by 10.99.60.24 with SMTP id j24mr12291889pga.32.1487890680247;
        Thu, 23 Feb 2017 14:58:00 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:ad75:dfc7:8a6:1152])
        by smtp.gmail.com with ESMTPSA id n79sm11622471pfj.31.2017.02.23.14.57.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 14:57:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
Subject: [PATCH 07/15] update submodules: add a config option to determine if submodules are updated
Date:   Thu, 23 Feb 2017 14:57:27 -0800
Message-Id: <20170223225735.10994-8-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170223225735.10994-1-sbeller@google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
 <20170223225735.10994-1-sbeller@google.com>
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
2.12.0.rc1.16.ge4278d41a0.dirty

