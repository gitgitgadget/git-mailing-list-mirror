Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4161220D21
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751041AbdFTTUj (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:39 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34687 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbdFTTUg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:36 -0400
Received: by mail-pf0-f173.google.com with SMTP id s66so73671811pfs.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gbflv1S1+qFgq3dMtmNYURZpYNNa+UTJJNe9QLKAfP4=;
        b=kBgtzbU5mU/w/AEQYaIiyrEDiimZWCF9D6hIA69rHAvb1oRQWt6y71y+cRKOrl0K/H
         y3dlnGjILXkhth+VYxFfoMFpJxdZt/kljFEP6rYJMPrSyFhok1ELmhls9uX3G5Z2+Smt
         dxRxu8N6l7I6DzRBJT7e+UvuAXzWp5lsCKrsBK4t7H7bSN4tVkJCCOdEFM/Ue+AxKs2s
         sqaM/5LdC3FtdSLRv9duk40LATOjHnp+fpwNFunclabKmWe7KID3kgM2K3mceCY9EE4Y
         tqMg2+J7Jrs/OSeLSrdmJ8jXrxDJoCmkU28BzGi4amjyhL2LJGp2ajedCd061XdVytTA
         5H3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gbflv1S1+qFgq3dMtmNYURZpYNNa+UTJJNe9QLKAfP4=;
        b=RQ3RCK40WgVcAI1Dwqjd8LihuKZYDQDH5+gg+NSLhHC/qTn13is1KVoIaAzAgL6NeS
         /8UZ4PZz8lPNLRMa0hRbOfhLiQOGg/ZFoSbFKIpEBlkGeFhkgV9QQQ6BSuarVBPU6mIa
         UQ7Gfrz2Nce2CdhmIP+qGjxGAkxVn6DRSTMLw4ttcz2HOUE4zZuC/F1y96KUs/GaT7n+
         591xLxI3aNrDG4anMsPiQZch4+D0DyE0Z70VOQ3L64vwyxgNmZtEV1T34mbcyQiAs1M0
         t31d9k6EwjhuDnPeIZCzTVRlJeG/bxtyKSSok8V8ei4AuddmvsmHVi72263VmKV9JCa4
         1hwg==
X-Gm-Message-State: AKS2vOwcdB6baAOWbKhRjmKLJe/4XlFhiLKqJx4vv60RvsoUqAwjlijU
        ikfFuR5Cv3zjTfmO1YhDCA==
X-Received: by 10.98.102.151 with SMTP id s23mr32442429pfj.22.1497986435605;
        Tue, 20 Jun 2017 12:20:35 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:34 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 15/20] repository: add index_state to struct repo
Date:   Tue, 20 Jun 2017 12:19:46 -0700
Message-Id: <20170620191951.84791-16-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repository.c | 16 ++++++++++++++++
 repository.h |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/repository.c b/repository.c
index 3dcfec3b8..883e6e9e9 100644
--- a/repository.c
+++ b/repository.c
@@ -175,5 +175,21 @@ void repo_clear(struct repository *repo)
 		repo->config = NULL;
 	}
 
+	if (repo->index) {
+		discard_index(repo->index);
+		free(repo->index);
+		repo->index = NULL;
+	}
+
 	memset(repo, 0, sizeof(*repo));
 }
+
+int repo_read_index(struct repository *repo)
+{
+	if (!repo->index)
+		repo->index = xcalloc(1, sizeof(struct index_state));
+	else
+		discard_index(repo->index);
+
+	return read_index_from(repo->index, repo->index_file);
+}
diff --git a/repository.h b/repository.h
index 379b64170..1fa65c42f 100644
--- a/repository.h
+++ b/repository.h
@@ -2,6 +2,7 @@
 #define REPOSITORY_H
 
 struct config_set;
+struct index_state;
 
 struct repository {
 	/* Environment */
@@ -31,6 +32,9 @@ struct repository {
 	 */
 	struct config_set *config;
 
+	/* Repository's in-memory index */
+	struct index_state *index;
+
 	/* Configurations */
 	/*
 	 * Bit used during initialization to indicate if repository state (like
@@ -53,4 +57,6 @@ extern void repo_set_worktree(struct repository *repo, const char *path);
 extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
 extern void repo_clear(struct repository *repo);
 
+extern int repo_read_index(struct repository *repo);
+
 #endif /* REPOSITORY_H */
-- 
2.13.1.611.g7e3b11ae1-goog

