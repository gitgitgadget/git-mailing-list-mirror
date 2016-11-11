Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C134020798
	for <e@80x24.org>; Fri, 11 Nov 2016 23:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965003AbcKKX4q (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 18:56:46 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35997 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbcKKX4p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 18:56:45 -0500
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Nov 2016 18:56:45 EST
Received: by mail-pg0-f45.google.com with SMTP id f188so18395732pgc.3
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 15:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R2rBK9CKRsdwJ41e18rIS96hyzAk82anGDpS5dTXuAE=;
        b=FN0T3fcSBP+GxiUlRF1POUXjghK2WPfkVTAg/NQ0a9GhlP8Y3MYbGNFCDK6g05Wzd+
         /f1F6aPMoOZyadZnBtaMlSzbmTFdsQSP5/xcUE5gQ9VCVM88esOK0TZmEFVMZg0nqTOK
         NI9Cp2bvuCXSNTneYMw4tPApWkRQPIBsfH8GcOOs46uNSQqjzQGiZqskQE2gNKVqqxvw
         XicuNVAPISvByV1qvnUmbVZc2otqYcP2aIuIv2SnU6F+mpWWelXRED7B0X4cZ8Pd3Cs5
         B8ZO/ASwUj+fiwBF75M2N5m1+9dwQVMqHbtah2KV1N317RaX2oxgfRd87DvAoUYhDqw5
         AjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R2rBK9CKRsdwJ41e18rIS96hyzAk82anGDpS5dTXuAE=;
        b=Cocz7k/oTpK2dQ4gC1CEM0aoLyuRucSgfwjeiXRmOPRuHyeJM3bI8Uxjtb6nn8vZzS
         3a7Ey16tVk6noQFcYyxsX3PGLJ+6SuMtOgvI0ZHQwm+8Eg3XkmsnM5GiGO9EJloF3ucq
         DmvCQDTmqC9qGAAItjsd22Mc2nXyd5Djqw6aW4C2UuLvpr/xF1RI7d2Ah7z0i+8HAAKK
         OxZXrFzOhdCVoBVfktx4l4EFq27tKDzCzPL7F8vRl1Yvt/uKMLX+g2Z4cidMbYNoKLbP
         /xm85akqzLU3ez6khrjHtJPwVbaE95J4+seoavwgqA++3IjCGk6QS1gFo68u9nmCLPDt
         vbIw==
X-Gm-Message-State: ABUngve6PUbF5/TNibdWxX6k+wk0gOpNFfpkxhhup2WmXn6JVrlhK7nyZvkXmdKMNIxlu+HP
X-Received: by 10.99.251.5 with SMTP id o5mr8721595pgh.160.1478908291991;
        Fri, 11 Nov 2016 15:51:31 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id r74sm17568314pfl.79.2016.11.11.15.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Nov 2016 15:51:31 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v3 1/6] submodules: add helper functions to determine presence of submodules
Date:   Fri, 11 Nov 2016 15:51:08 -0800
Message-Id: <1478908273-190166-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1478908273-190166-1-git-send-email-bmwill@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com>
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

