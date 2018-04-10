Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32BCB1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeDJM5M (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:57:12 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44428 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753135AbeDJM5K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:57:10 -0400
Received: by mail-pl0-f67.google.com with SMTP id b6-v6so7448519pla.11
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 05:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ooi/5aLrlq5eLvpLYuLVRsYyHkGE5oZz0/6aS5O5uSM=;
        b=i+A14QBCSDYhSZImJtynKSjTvw9bjywLmXDb/opGWOwg7mPsB0nsjknHuAP0PSgSs9
         fLPEEhF82hj2/nyrPGZYov8G2grGhczn53iAb2cKMCqW00Km/F4CciBEchKSsGlpUKwK
         bBNlM+kWI4WsHleUtOVAapD8lnVMgbQC/WgKlRJkfETtE+ooJOoMjyqYkp2e7qT9l1JA
         YiFUUkKmj6tbAAFJWJGhh2xpljy71a4CN5tP61rSbuBpNAjadnmttBgCEFyJ4+IZxwf3
         ccEC+xjz0TMWb1dZMTmpZAAn6aTODyvTA2n3irl78QKQ5yzCnw+2qbkUqECfN2rgfbHG
         jP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ooi/5aLrlq5eLvpLYuLVRsYyHkGE5oZz0/6aS5O5uSM=;
        b=hKX81YCGS1m5UJ6GBAwPNGbfsRThfOsIzLQJVgPqN8+qSfy4mZHbw4OSUIy8LKcQf1
         VJxVD10N07gWw2FsSmMJsDTyj6uvf8REPb3nlGHnV1UVgcy7/1J848pluliZwwaKDq03
         LQg+mhr0AW0N2VAojxj73LfCG8sH7RKA5oL3l89vPjV8qbQJLXx/+89GYeOEuFZIVvs3
         AQcc0WtYycByMq9XzlYvs2oVebUjE92IrdPbR+Q8uTQKUSTmjOI0+BtQhCGgG2RdeIX4
         oyz+LjRARiPPsiEuc5h5OHgOaasaaLQ5bNtDdGoBxx9hLZ1CyiHjTN4SQh3WRfGFmXD4
         EhBA==
X-Gm-Message-State: ALQs6tBUh0o2mUHEcZBypDxlHW6kOUCu4NnY4ot2d7alJJHGHxTbelz/
        IBG605lKSosOD605NegIwtEww/NGORY=
X-Google-Smtp-Source: AIpwx48Pzy1GfOyiJ5W5Cn+IqIdkcQPQB6klTAdUfEIamONirwVZH3DvGYsmBk/HMiU71r294/9XDA==
X-Received: by 2002:a17:902:6e01:: with SMTP id u1-v6mr346058plk.96.1523365029591;
        Tue, 10 Apr 2018 05:57:09 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id l10sm4421666pgp.35.2018.04.10.05.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 05:57:09 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v8 09/14] commit-graph: add core.commitGraph setting
Date:   Tue, 10 Apr 2018 08:56:03 -0400
Message-Id: <20180410125608.39443-10-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410125608.39443-1-dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit graph feature is controlled by the new core.commitGraph config
setting. This defaults to 0, so the feature is opt-in.

The intention of core.commitGraph is that a user can always stop checking
for or parsing commit graph files if core.commitGraph=0.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt | 4 ++++
 cache.h                  | 1 +
 config.c                 | 5 +++++
 environment.c            | 1 +
 4 files changed, 11 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4e0cff87f6..e5c7013fb0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -898,6 +898,10 @@ core.notesRef::
 This setting defaults to "refs/notes/commits", and it can be overridden by
 the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
+core.commitGraph::
+	Enable git commit graph feature. Allows reading from the
+	commit-graph file.
+
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
diff --git a/cache.h b/cache.h
index a61b2d3f0d..8bdbcbbbf7 100644
--- a/cache.h
+++ b/cache.h
@@ -805,6 +805,7 @@ extern char *git_replace_ref_base;
 
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int core_commit_graph;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/config.c b/config.c
index b0c20e6cb8..25ee4a676c 100644
--- a/config.c
+++ b/config.c
@@ -1226,6 +1226,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.commitgraph")) {
+		core_commit_graph = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.sparsecheckout")) {
 		core_apply_sparse_checkout = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index d6dd64662c..8853e2f0dd 100644
--- a/environment.c
+++ b/environment.c
@@ -62,6 +62,7 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
+int core_commit_graph;
 int core_apply_sparse_checkout;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
-- 
2.17.0

