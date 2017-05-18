Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CACA201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932653AbdERXXE (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:23:04 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:32778 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755198AbdERXWk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:40 -0400
Received: by mail-pg0-f52.google.com with SMTP id u187so29512986pgb.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e4hlHKeNfLSYi8RCorrj5ROrf+AgIXeAM7OP2ipIvjQ=;
        b=IvhjUm7Lqgm/wdEXSvdtyTBUwMRglK3lKGeTkwU1Dde09fs0FYGt8SfqOi9sEKy60k
         CPbCv82CapiVlIA5uc7qTf2YLA2gSIQNG/VVtqd9SNuQRM4X+393lmSfPfzJvTfcxF5J
         1fEh9cViBWQ8e/OnMPH3TvOij3qTsfWJEsJjzL/SvOhxSzKIZiipLf3/9imeIi8H+xV5
         /zntwXhd7Yr8FlGLKEYy0xsKM2ypuKQDLJWG+MwoGEkbHpOuwXI3GDO3OmMCAGqamIq4
         oyusDgudE5atRkaia6UFaAsfuEEBxBfwgccNmlsmtY2jN9IBqqgdfiuWtRuNVRgcA7zw
         o7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e4hlHKeNfLSYi8RCorrj5ROrf+AgIXeAM7OP2ipIvjQ=;
        b=Nfwa+3FhaCV0OC/ba/GJ5TZrdq73rM5NpPPZB3cjxfdocO08o55RSs1+cdWxZNPHB4
         6m0ekccJOl12hVSJ6gYrBBYUcmehJkibVCOQKZZFQSFy7VTnLABUSo9W11l7MRdvtY5X
         scPXkpnCD8p58h2UfBU/OHi2vysKjNjqvOw1czXIotHUIFPjWRDPuuvpzuzVfemcrhVT
         0g40htM5LtnqNoA9OF8TgGt+4adGwLUHiPFKeB06jJa25SCL8rm4gBjbADXUvF/YJN6z
         HqAxlACCcZ0sAYEz+EsH3L4737HSMx8Ws5EK/lNdqJdGT4Y8knNFEPwX3geZ1zJk08Bo
         mHAw==
X-Gm-Message-State: AODbwcAxfX605VngvwHyQ1BiiOzgDwqA89SnpNycy5V9WmicTOjFhuEg
        7OU6L9LJ08+r0Fam
X-Received: by 10.84.224.135 with SMTP id s7mr7769769plj.66.1495149759226;
        Thu, 18 May 2017 16:22:39 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:38 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 22/23] submodule: add is_submodule_active
Date:   Thu, 18 May 2017 16:21:33 -0700
Message-Id: <20170518232134.163059-23-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add method which checks if a submodule is active given the provided
repository object.

NOTE: this is almost a copy-paste of is_submodule_initialized.  I tried
to convert is_submodule_initialized to take a submodule_cache and
config_set parameters but that turned out to break some other code paths
which I didn't want to change yet.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/submodule.c b/submodule.c
index 80851d044..9a9c52292 100644
--- a/submodule.c
+++ b/submodule.c
@@ -16,6 +16,7 @@
 #include "quote.h"
 #include "remote.h"
 #include "worktree.h"
+#include "repo.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
@@ -270,6 +271,56 @@ int is_submodule_initialized(const char *path)
 	return ret;
 }
 
+int is_submodule_active(struct repo *repo, const char *path)
+{
+	int ret = 0;
+	char *key = NULL;
+	char *value = NULL;
+	const struct string_list *sl;
+	const struct submodule *module;
+
+	module = submodule_from_cache(repo->submodule_cache, null_sha1, path);
+
+	/* early return if there isn't a path->module mapping */
+	if (!module)
+		return 0;
+
+	/* submodule.<name>.active is set */
+	key = xstrfmt("submodule.%s.active", module->name);
+	if (!git_configset_get_bool(repo->config, key, &ret)) {
+		free(key);
+		return ret;
+	}
+	free(key);
+
+	/* submodule.active is set */
+	sl = git_configset_get_value_multi(repo->config, "submodule.active");
+	if (sl) {
+		struct pathspec ps;
+		struct argv_array args = ARGV_ARRAY_INIT;
+		const struct string_list_item *item;
+
+		for_each_string_list_item(item, sl) {
+			argv_array_push(&args, item->string);
+		}
+
+		parse_pathspec(&ps, 0, 0, NULL, args.argv);
+		ret = match_pathspec(&ps, path, strlen(path), 0, NULL, 1);
+
+		argv_array_clear(&args);
+		clear_pathspec(&ps);
+		return ret;
+	}
+
+	/* fallback to checking if the URL is set */
+	key = xstrfmt("submodule.%s.url", module->name);
+	ret = !git_configset_get_string(repo->config, key, &value);
+
+	free(value);
+	free(key);
+	return ret;
+}
+
 int is_submodule_populated_gently(const char *path, int *return_error_code)
 {
 	int ret = 0;
diff --git a/submodule.h b/submodule.h
index 266d81f1c..083f16ce5 100644
--- a/submodule.h
+++ b/submodule.h
@@ -5,6 +5,7 @@ struct diff_options;
 struct argv_array;
 struct oid_array;
 struct remote;
+struct repo;
 
 enum {
 	RECURSE_SUBMODULES_ONLY = -5,
@@ -42,6 +43,7 @@ extern int submodule_config(const char *var, const char *value, void *cb);
 extern void gitmodules_config(void);
 extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
 extern int is_submodule_initialized(const char *path);
+extern int is_submodule_active(struct repo *repo, const char *path);
 /*
  * Determine if a submodule has been populated at a given 'path' by checking if
  * the <path>/.git resolves to a valid git repository.
-- 
2.13.0.303.g4ebf302169-goog

