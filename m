Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B0E2023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753553AbdCBAyk (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:54:40 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33467 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbdCBAyj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:54:39 -0500
Received: by mail-pg0-f53.google.com with SMTP id 25so25846304pgy.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 16:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vmtEzzwUJhB8IaIzHUBIaneBclOWZcruGGKqiRrLPIc=;
        b=tlGP2BxXrCCdAQ+oqmcIQjY/ukKBPStV7O9/Rrjovgdu+wriLADEasemqlne+8qxAg
         H9rgZqIeVTK9tuphkvqrzopInS+RpR/dtE7a+gQz/S6ZG40zqcyNoApACuxOfwf/PP1k
         jP5TJZqzWgCPkLW+TuJUaZsF/BIF8iVCp/9GtenSxBcHc7eagW7FW5eo71Cy8Tv9TiVe
         kTYJDuCW7a5HMNgknY91RzM59KNQF141qHoPetQdCQpu3hLJD+dq7Nl5QgQ8egIfbXl6
         FYsSEle9/++voBUqRAXS32VB9El19zpko1WDlxSjVlpqowRGuewDrrXDA+L5ZL3GqUao
         TDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vmtEzzwUJhB8IaIzHUBIaneBclOWZcruGGKqiRrLPIc=;
        b=jqGtDEBTP3qIWnutOHnBjVsIH6/Odc42O2GnVQg9I++AGzJ78mtqgVNWP4NO+iCxsh
         QUe9+aHbTFTl/tvEsF4cwRwH0cfP+wxDQE6j+MwynZSMsh8V3PowKq+lVq0D+fQGsr/M
         scW4U9O1YTgWfvTnD1Tev9ziLRsyJfgPUxip1bekU/BkYrIdgfX1iJxyw5aRXIZmmZ6p
         LJNKyiTCasUPuPJsR2KwLTjUfAG/lHzQEUCkpzW32pGw5okadfI8P4xWaTVOVVKHOpWw
         fHYKiaMy0BGzfrVf9ZnRd2mhHYmvDlgwyQhT6lmeNoalZS3FYR6OY2Kid4QJuWyYjNvL
         rLnQ==
X-Gm-Message-State: AMke39mOf42S5vrnOp15POrze5gfnVu9HoAm6sX9V3ROmaNuedhumxdUUvwpRI71Mt60OFg+
X-Received: by 10.84.229.151 with SMTP id c23mr14564097plk.27.1488415695541;
        Wed, 01 Mar 2017 16:48:15 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id 73sm5182744pfj.31.2017.03.01.16.48.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:14 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 09/18] update submodules: add a config option to determine if submodules are updated
Date:   Wed,  1 Mar 2017 16:47:50 -0800
Message-Id: <20170302004759.27852-10-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
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

