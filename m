Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 910431FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 18:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756023AbcKVSrp (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 13:47:45 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33508 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755770AbcKVSro (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 13:47:44 -0500
Received: by mail-pg0-f48.google.com with SMTP id 3so10249611pgd.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 10:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R2rBK9CKRsdwJ41e18rIS96hyzAk82anGDpS5dTXuAE=;
        b=kfKL53ztDVz9nzMb+SZUfTkELYlrTzfZKXWLd4qf4RwTXN5NSgvwPsE6zDAp7RoKbo
         CZkieBzNWgHLeitXUb6+i62Eq+m+7pEUrlm48gEkr+XePAMnlvKaBNCjsXaOtaxj8ZdJ
         RDa4tx+XYOn5gzWsIcareMiQvuSL3KM1iD3xUe1lVmXtgy1d+sAdCNBcgbPkqs9L+0ii
         nCeLVJIMpIIO1j0i4W6XGjLZ4KokqAJ8phf7YY2QqtvGqUPjh130KsbSaqzQx0sil5C9
         p5Pp9ptQHXdeWx/jyreMbgWQd3qjNDgUmGPYCUI4TA/zWnLOjYsaUdKRid0U+bOi1t9H
         Y4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R2rBK9CKRsdwJ41e18rIS96hyzAk82anGDpS5dTXuAE=;
        b=VtzW/AX7H/t0YOdOkMr/JlrJMK7jOoR9BY6NXIUjpGcg0R32QP1k+n2hrOC3cfXNeB
         lGT+cUzVQR414hXwG2FjFt+grokbzzjyi5M9cyKPZd6vYYw4EnK620f6Wp0xJcytncwm
         9KwCYDAZeeC73r9v6+2S0SgJIFXhcmdTfWxC5dzYtLKbx+XxbQdnVzMfR37HntC9oPQp
         0Xet1dUEcYO1t8KRIegI/eufextVodt80RZGSQZ3VjCj9Qp+SWWCsqxKquhDdGfTdoWq
         kWteoZYdj26m8EMHHJJLXfiewUNy8gokz5dBNJZotNke32Mp3C16s8opftTfsrhUe0ld
         MkDA==
X-Gm-Message-State: AKaTC00+fGCAgWbOkWycB1NAtvHVOILDKQ/L/E+NVeBgEi/t8yfGo8Ht5v4lAnEPDOxExzrL
X-Received: by 10.98.102.197 with SMTP id s66mr26742834pfj.146.1479840407769;
        Tue, 22 Nov 2016 10:46:47 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id w5sm46932072pfl.31.2016.11.22.10.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 10:46:46 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v5 1/6] submodules: add helper functions to determine presence of submodules
Date:   Tue, 22 Nov 2016 10:46:32 -0800
Message-Id: <1479840397-68264-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479840397-68264-1-git-send-email-bmwill@google.com>
References: <1479499135-64269-1-git-send-email-bmwill@google.com>
 <1479840397-68264-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add two helper functions to submodules.c.
`is_submodule_initialized()` checks if a submodule has been initialized
at a given path and `is_submodule_populated()` check if a submodule
has been checked out at a given path.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 38 ++++++++++++++++++++++++++++++++++++++
 submodule.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/submodule.c b/submodule.c
index 6f7d883..f5107f0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -198,6 +198,44 @@ void gitmodules_config(void)
 	}
 }
 
+/*
+ * Determine if a submodule has been initialized at a given 'path'
+ */
+int is_submodule_initialized(const char *path)
+{
+	int ret = 0;
+	const struct submodule *module = NULL;
+
+	module = submodule_from_path(null_sha1, path);
+
+	if (module) {
+		char *key = xstrfmt("submodule.%s.url", module->name);
+		char *value = NULL;
+
+		ret = !git_config_get_string(key, &value);
+
+		free(value);
+		free(key);
+	}
+
+	return ret;
+}
+
+/*
+ * Determine if a submodule has been populated at a given 'path'
+ */
+int is_submodule_populated(const char *path)
+{
+	int ret = 0;
+	char *gitdir = xstrfmt("%s/.git", path);
+
+	if (resolve_gitdir(gitdir))
+		ret = 1;
+
+	free(gitdir);
+	return ret;
+}
+
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst)
 {
diff --git a/submodule.h b/submodule.h
index d9e197a..6ec5f2f 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,6 +37,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
+extern int is_submodule_initialized(const char *path);
+extern int is_submodule_populated(const char *path);
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
-- 
2.8.0.rc3.226.g39d4020

