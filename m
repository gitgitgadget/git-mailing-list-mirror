Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5700D20D22
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbdFTTUp (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:45 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34206 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdFTTUk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:40 -0400
Received: by mail-pg0-f51.google.com with SMTP id e187so14380207pgc.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/qrqR9Aro4XbSQKma9b6zFMKdocJ//u5gB6C4+lrxIs=;
        b=W/UA24SkZ3d0WXJ3hYtD2oNnxR39vt7z08DEp8brBqCYbbBv5uhYZoJ8WW6/tmwZoL
         eRXd8MzfM63DjqYn8vqPnMj3E1w2BVF8k6u5bLS374xJqnYUCBdP7RusrzSC6i+2vA7u
         Aj7SBR6kaeep11/0lrkJa/Utanwsl3nsqaXc92hiVJwD9yVQlub0SE7T5ZhwE/Gc1+rx
         cgTY6xJ7qGANiVC/1rReXcdXHtPeP2zCRiLKlQmQdCFfbisZ78qnj0Bt++7mFeMC4aY7
         BUwWGCbbzapHeRC1qtHiAKzlqgcfipQS32mt5KE+hlxAF3m+9uPwbYcdjKcOibyhTtaD
         jC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/qrqR9Aro4XbSQKma9b6zFMKdocJ//u5gB6C4+lrxIs=;
        b=VDu0CdZKAw63Jz0Zz9DY1G7vN3zaqRoTm5OnAk6nF425a93LCoS8BdYuC1+/O7hswx
         to7PQFT6Fz7A/DgfrlSg/bzkp78XWeJemFgk4S6ox/BXVcJzMStmoRoOIY/GLqdyMfeb
         JmnrmcAVxu3hybJNBtnzAlKChMx/CmtrxKvhTBLZ/knXjV9ut+F2PdRtTiFMr5TSQcva
         3gXsSpcGKk2pn1sl19I6XvnXJmEeGA5iJEdXhykLdHeClF5NHibMDoMQZTfIs7Q3na/S
         FufakCcpkYLgcjyR2f4UFh1qUM9/NMD4IlsZ2B549vhqR3Xpncp96iNDEu/1EKVzT4rY
         2ySA==
X-Gm-Message-State: AKS2vOz5LP5l5+bAppDYvZmNyI1CqpNCr2t70J623w/J0pVxQVFSwdZn
        z7wdGDoTc3mwkgO6x0rtnA==
X-Received: by 10.101.86.11 with SMTP id l11mr32432849pgs.202.1497986439039;
        Tue, 20 Jun 2017 12:20:39 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:38 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 17/20] submodule: add repo_read_gitmodules
Date:   Tue, 20 Jun 2017 12:19:48 -0700
Message-Id: <20170620191951.84791-18-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
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
2.13.1.611.g7e3b11ae1-goog

