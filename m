Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2200B2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934812AbcKOXHD (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:07:03 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35899 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933793AbcKOXHC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:07:02 -0500
Received: by mail-pg0-f51.google.com with SMTP id f188so71371324pgc.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1NByg9cWD9Hcn+vWCSjk6Lt59JQA2J94zfs8k7iHKj8=;
        b=g24vIHDfl8UkmGWkJrJIEPNSus1OGbFaf8zj3dH0ZByVciFxeVJK7Cfe7kmt/iJaq3
         CxKA6zCacvH8YiWodBPtUqrOD6U+xyfKfUI1nlePJApS6g+eA3oNqcTgz2Qihv9UrV+m
         dEz47yHvYpWFI8d/6PfmesD3zVe6TRlrMh9mLpZrKAoDxmvn+/52WMlHRCqrqiq6ER3Q
         U2aifsa1Jf9acMANGG85uQ+VQLVcDaAfzhpwhA0fxU1Qd5kW8CboJCpm20rn4dYRAVBq
         X/rdG2AI3sKuylX3bx4i6r+JyqX2WQrJkKjq/OpDF/Y5/DnGEQ4kiJOkbAWJEtBpvrbq
         o0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1NByg9cWD9Hcn+vWCSjk6Lt59JQA2J94zfs8k7iHKj8=;
        b=UUGwDdfiiSkTRtaDI+aT2HnQANFmZnD9nn/F8atDhC3uC38IQyFhIWyYmLqz8LCFyK
         TUP38Ql6MxJ50ytfjjCd/x1NvnOe/Tz6Y/Oy/EwEnAyin7+M0TtyvjtuGTVA7e2SlLHi
         F5qzS9DERfzCpIFlRpdJ9oIKP3K/WEryWjWVYz+A8ExzFAOkks+uTwhsA/nTyTnokN/a
         WERQNpWk2Ng/5iqRHZM/UGkKoLw4J0u1/AicietCX3kgHz0lMSR62m1I23yAqXx2RYAy
         wF+OimNnkCwcfffkfpkW/DmBXhq86yeHL9rnpjlPg4pJBnHZpYPuRi0/w8VBR4Wx5WwV
         bMEA==
X-Gm-Message-State: ABUngvc33ytf1OBA6B2/iQhjzo0l1spplrbnqTHh5jjK8vesTu2DSFGSi5AzJyRJ+KQzein/
X-Received: by 10.99.226.83 with SMTP id y19mr1155144pgj.147.1479251221741;
        Tue, 15 Nov 2016 15:07:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id r88sm46269200pfe.93.2016.11.15.15.07.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:07:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/16] update submodules: add a config option to determine if submodules are updated
Date:   Tue, 15 Nov 2016 15:06:41 -0800
Message-Id: <20161115230651.23953-7-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
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
index 97eaf7c..38b0573 100644
--- a/submodule.c
+++ b/submodule.c
@@ -16,6 +16,7 @@
 #include "quote.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+static int config_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int parallel_jobs = 1;
 static struct string_list changed_submodule_paths = STRING_LIST_INIT_NODUP;
 static int initialized_fetch_ref_tips;
@@ -494,6 +495,11 @@ void set_config_fetch_recurse_submodules(int value)
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
index d44b4f1..185ad18 100644
--- a/submodule.h
+++ b/submodule.h
@@ -56,6 +56,7 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
+extern void set_config_update_recurse_submodules(int value);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
2.10.1.469.g00a8914

