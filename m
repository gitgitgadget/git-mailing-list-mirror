Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 880491FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753728AbdFVSon (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:43 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35581 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753718AbdFVSol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:41 -0400
Received: by mail-pf0-f173.google.com with SMTP id c73so12563888pfk.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qhs4lrU3JgQg/fo29ikV+C7dncC+QyYbXs6OEzVF5rk=;
        b=JUPirVApqWBRPwL6S5XRjPN8rN7kip16zk0dOy6i3jmPAT6n/QVMbO83xukoBb4tR5
         JsMbBdDIvUF5wMUztwiGCr5wGSXsMajDiOX41eKXLZaVHbXhm+VU9WDfc65yoWGaUlgz
         PBziN7HBEPaazpzS/qnaQTPsw5VJUeZ0IHHY0/xcTXKGGQBDU0XTQ/Dw3MRcx9t6sRbM
         0HZBZSGWHGCLM5OhkW0tzqmgKU58clXoYvlgyikOyf6RA2UV9LyvCgx5ubfVrbwvILOJ
         NZItYRGctO/hi2RyV+q9vX1C08BZrdHDxYFucP4jonVJMza+yDpSMBemLtenyBUidP77
         N8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qhs4lrU3JgQg/fo29ikV+C7dncC+QyYbXs6OEzVF5rk=;
        b=pAhUsgXOdQ5H2N4iIZaLGmwtnraQePgr6FdtERbfBiK1s1DY+x27xkHsBfx7N5MKbB
         0J2k1UsUOeaQdkN73KQVrD0cCkAhgKDFoNBNJeJNhEGCandhC+EFuINHfZbF2SC5NXwB
         ozkNtQnT+c5ULPZcNC95YMw9vFYZnkq6hxrg5KInGJAJsH3iQBBEFH4QQ5qxJcTSxjik
         rEnKu9WWPmliDYqcotogJLbJjqxlMCQwZymxpDMPqrq8+AHPW2Qm9Odplxiyr/Geisxf
         c/PsX1jxTZjYTOb59KXJcsiM+GukhlPYlqIBTRIylC7lmKOKjI0aYQy5eMTlPqVvnYEA
         JDbg==
X-Gm-Message-State: AKS2vOx/hMdPWgpVZZyxRqXkI99m4kG3H8OUiIEE1syI1ZnpiudiBqgN
        ar/S7K1j1BInZ0y6w/6Frg==
X-Received: by 10.84.164.193 with SMTP id l1mr4357072plg.243.1498157070478;
        Thu, 22 Jun 2017 11:44:30 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:29 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 17/20] submodule: add repo_read_gitmodules
Date:   Thu, 22 Jun 2017 11:43:45 -0700
Message-Id: <20170622184348.56497-18-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach the repo object to be able to populate the submodule_cache by
reading the repository's gitmodules file.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 15 +++++++++++++++
 submodule.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/submodule.c b/submodule.c
index da0b80549..d0b894772 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "submodule-config.h"
 #include "submodule.h"
@@ -255,6 +256,20 @@ void gitmodules_config(void)
 	}
 }
 
+static int gitmodules_cb(const char *var, const char *value, void *data)
+{
+	struct repository *repo = data;
+	return submodule_config_option(repo, var, value);
+}
+
+void repo_read_gitmodules(struct repository *repo)
+{
+	char *gitmodules_path = repo_worktree_path(repo, ".gitmodules");
+
+	git_config_from_file(gitmodules_cb, gitmodules_path, repo);
+	free(gitmodules_path);
+}
+
 void gitmodules_config_sha1(const unsigned char *commit_sha1)
 {
 	struct strbuf rev = STRBUF_INIT;
diff --git a/submodule.h b/submodule.h
index cbe5c1726..8a3771ec6 100644
--- a/submodule.h
+++ b/submodule.h
@@ -1,6 +1,7 @@
 #ifndef SUBMODULE_H
 #define SUBMODULE_H
 
+struct repository;
 struct diff_options;
 struct argv_array;
 struct oid_array;
@@ -46,6 +47,7 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 						     const char *arg, int unset);
 void load_submodule_cache(void);
 extern void gitmodules_config(void);
+extern void repo_read_gitmodules(struct repository *repo);
 extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
 extern int is_submodule_initialized(const char *path);
 /*
-- 
2.13.1.704.gde00cce3c-goog

