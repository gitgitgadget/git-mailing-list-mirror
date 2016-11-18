Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833E21FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 19:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbcKRT7H (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 14:59:07 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35046 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbcKRT7F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 14:59:05 -0500
Received: by mail-pg0-f49.google.com with SMTP id p66so106074057pga.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R2rBK9CKRsdwJ41e18rIS96hyzAk82anGDpS5dTXuAE=;
        b=T5h7d5YNu0XQMGAKZ/z03ndXyfaL043PlGGJKh3nV7yHk59tnHpHjwsI5/CKmhOxpT
         sjOyKKJPnnkoGio4a22ki3w+JXySethlT8wtj6L/+6+6tqrOQAbRGC8VAXjmpkau6MsX
         kTQHJaOuY1v+0ASYeefaGZSsANR5QWiWyzWwVVFpIKzR/aquwUeWXXQGpfAiktvbDiCZ
         RIshL1Gvqc4sGhUj3Z2GFNwZgC2wSnt418ElPD7ehWdrH2GUMNPZQopxbUzYZIW09oSY
         zQPUPym400pMovTGc3fros4/4VhEPE3tgO6am+nJOSozxa7akSrs+vmNDud1Ks1+zcF8
         8BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R2rBK9CKRsdwJ41e18rIS96hyzAk82anGDpS5dTXuAE=;
        b=Xp9cLfjeH3iJmr4PLfRWkNIPxIfh69aQbcW74HB1oMgLkgd12E8p6n/3U2ekX3ReIF
         HiE/xoRPMlhMCf9NkDDVmp1F6AZ7g1nT3q0pDP46B+wvwznQdLkhlHnaOVkEpUcVaGxK
         pq3o6Z9TVEKUtVr4dDvnOXbXFjsFv9H8ZbR1G4GKp82fboKnV05GeH6sACTG6/N3ed8M
         xgDjgXUcJbhoesTiHWzHG6lpUmfHtAdz71CudvB44+cp3S1kUjJL4IGmS/lF7kdA6zRT
         lcoP5RJMWB2nxLstDNFxC4cN1Q+7lBHdG1JjyMaiS9f91/oBU2ksEbP4wbefVLzbDt1G
         RBdA==
X-Gm-Message-State: AKaTC02S0VteGMcuc28St5QUFtoUBdHFHk2M0gMiZsWUCLN4EqSwIC2bF7AdY0lpQRPaibcx
X-Received: by 10.99.164.9 with SMTP id c9mr2874640pgf.141.1479499144851;
        Fri, 18 Nov 2016 11:59:04 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm19850441pfb.42.2016.11.18.11.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Nov 2016 11:59:03 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v4 1/6] submodules: add helper functions to determine presence of submodules
Date:   Fri, 18 Nov 2016 11:58:50 -0800
Message-Id: <1479499135-64269-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479499135-64269-1-git-send-email-bmwill@google.com>
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1479499135-64269-1-git-send-email-bmwill@google.com>
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

