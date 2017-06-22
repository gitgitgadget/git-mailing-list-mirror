Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 746191FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753766AbdFVSpE (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:45:04 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34379 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753658AbdFVSo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:27 -0400
Received: by mail-pg0-f53.google.com with SMTP id e187so11356636pgc.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fph8fU3KrB4MXmCZskxoE6q7Vu0HkAmmFnl0YSnxVkI=;
        b=UBw36DZL6nXH4Xf/tsA9tOlxUmX6Mj6WN0wE2MRtF2fqNpYN/AgiSElCP1uESrEbEb
         51as1L2gQMNjO9S1LWeogMtSQtcudpIgTWUv3gkkWgBJa+JPV9toOd476ZYizyirn6n+
         ziihB+ZhUBSETz54xs2IOpFYjEYlgyQ1i88RkfvP2a9khnspB3K3iryYoPCoC82pDpdP
         VKuqn3ugf3hQ9gF8puu47storS+R2ZS4RFwN3UDhtOOcTQ1HP6Tk4PU2EX1rIBNfhBMo
         Yas/lvO2M1yV9jTHkpZcxmcdfYTZVRuY2xb8nFpguyc+qlDu3eaWKth259x4Vw97IQf4
         M5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fph8fU3KrB4MXmCZskxoE6q7Vu0HkAmmFnl0YSnxVkI=;
        b=Q7FqTu1Ck9spcl/sH3v0Woz0MszoSAMM2Yi/glQNJXc5loBXiLrEaGTvmDoqbqa/oc
         EX0gSaQlgDLeyuCfOOGPKv2BS82rqspAecmE2CkFG1JGB8KLgVNSIidG8Z/Ok6KbeRNm
         YK3ryUMMrOfuJ3Lcqe4jaBQkTF5LqjfMZH3hRQ5HJmJt7OaUd7l+KbWNnaBKUBKuLhpw
         UUekR1G9Z3CFNA1N63Ynfmcf6ovzCAnOU2Kbz8mBgLrLe3X9kn5BCDQaOs2LKaWfb4QY
         6U09xMP/z8cMfNR2lsVWj8Wd2uOd151OiDA5M/mq/o57STD5iePZCHER+NnFnBEBt7nf
         p3Pw==
X-Gm-Message-State: AKS2vOzxawUDPOW+UYwhpWq5VNH1T+r+tXLsxQ9Zn7OwoKzl9z4M+zJz
        fnc6OlMgkf2nodLGFJ/KwQ==
X-Received: by 10.84.218.198 with SMTP id g6mr4447639plm.132.1498157066648;
        Thu, 22 Jun 2017 11:44:26 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:25 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 15/20] repository: add index_state to struct repo
Date:   Thu, 22 Jun 2017 11:43:43 -0700
Message-Id: <20170622184348.56497-16-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repository.c | 16 ++++++++++++++++
 repository.h |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/repository.c b/repository.c
index 686a964ad..6f6f4d91e 100644
--- a/repository.c
+++ b/repository.c
@@ -163,4 +163,20 @@ void repo_clear(struct repository *repo)
 		free(repo->config);
 		repo->config = NULL;
 	}
+
+	if (repo->index) {
+		discard_index(repo->index);
+		free(repo->index);
+		repo->index = NULL;
+	}
+}
+
+int repo_read_index(struct repository *repo)
+{
+	if (!repo->index)
+		repo->index = xcalloc(1, sizeof(*repo->index));
+	else
+		discard_index(repo->index);
+
+	return read_index_from(repo->index, repo->index_file);
 }
diff --git a/repository.h b/repository.h
index 8ae5e8653..3a41568aa 100644
--- a/repository.h
+++ b/repository.h
@@ -2,6 +2,7 @@
 #define REPOSITORY_H
 
 struct config_set;
+struct index_state;
 
 struct repository {
 	/* Environment */
@@ -49,6 +50,12 @@ struct repository {
 	 */
 	struct config_set *config;
 
+	/*
+	 * Repository's in-memory index.
+	 * 'repo_read_index()' can be used to populate 'index'.
+	 */
+	struct index_state *index;
+
 	/* Configurations */
 	/*
 	 * Bit used during initialization to indicate if repository state (like
@@ -71,4 +78,6 @@ extern void repo_set_worktree(struct repository *repo, const char *path);
 extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
 extern void repo_clear(struct repository *repo);
 
+extern int repo_read_index(struct repository *repo);
+
 #endif /* REPOSITORY_H */
-- 
2.13.1.704.gde00cce3c-goog

