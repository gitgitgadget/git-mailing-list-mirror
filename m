Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0291D1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeB0Cdr (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:33:47 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38632 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeB0CdX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 21:33:23 -0500
Received: by mail-qt0-f196.google.com with SMTP id n12so2032057qtl.5
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 18:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uRB9JcEJ/fZAup7GxvFLOtziMQRaC2k+Xz5AerDBYxY=;
        b=bAgz/Q3qWB36sPN+Q4BT+tawBukEGmUOI7pS7hMohO01CclvLPQ1H2/U8934kzMT7t
         40ovtLjF+zmSGN31pztDfRYhtlxPRuQ3k2prI4c3ndfs7/PFA7kgNTRW+bhbShqw+xZb
         RQlo+WA0PRK1wmd6Q3i/BH0tiDyh35poQPlIPwLU27L1F8M7zeyeJqEQa2S3s65xVEN/
         CW92V5BkslqFlJM52YXh3aMoXNAgvVMSMtuh606LYyVfzYtZU4wjIBqBRavobxQc7EKQ
         Pb0P0KpLV+aLMp1tl5xSp1EZzLYG/a8nq5pZh8w4ONWHKYMPvLKgAUTCRZBNSAiQv7qu
         HXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uRB9JcEJ/fZAup7GxvFLOtziMQRaC2k+Xz5AerDBYxY=;
        b=fRpZ1wJ5pgoT1Xk5vQ5m9bRZofIByYOQpNkMTrDj75PEAVUH5D3YlcXbSkAsLaZG/h
         xFDhmj7iGwlqlSKEBN1P8peL+Kr2D20N7962hbtaVV5ohGlGN28uiflOzHan9S0XwbjT
         yWgS5PIddAAgIysl0U0yUWbM4tqneSqUSmC7vwSlgj4tPSjgEdxQxYDoeV0x+n2YLX8O
         bp6v9PQk0Ps7vWGwBm2aWDoFFBXwRjDU8o9C/zlrFF3px3Z2J6TT4k0/pDWLR/QJcwTZ
         /VdmWIvxeDEIDXt99d3lGeCRXsV8nmSipi0jmToxOWyPAIQFl1lm+miCaW8tVylimS7T
         YVew==
X-Gm-Message-State: APf1xPB4x1NPfGG345XvE3vHVTmJ4EObrUzKqWbB2P9MwVt/7h3XoSAv
        bt7iLlhlBcjT1/mQDv/f4w+xznDZ/O4=
X-Google-Smtp-Source: AG47ELuTylW+s4U1v9q6UYVgUdwvKKO426/FfOiPWJZq4ibIhgzEL+phxozn6KdanCEvodZgw8XjtA==
X-Received: by 10.237.39.38 with SMTP id n35mr21536526qtd.327.1519698802750;
        Mon, 26 Feb 2018 18:33:22 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 94sm5566530qtb.2.2018.02.26.18.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 18:33:22 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 08/13] commit-graph: add core.commitGraph setting
Date:   Mon, 26 Feb 2018 21:33:02 -0500
Message-Id: <1519698787-190494-9-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit graph feature is controlled by the new core.commitGraph config
setting. This defaults to 0, so the feature is opt-in.

The intention of core.commitGraph is that a user can always stop checking
for or parsing commit graph files if core.commitGraph=0.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt | 3 +++
 cache.h                  | 1 +
 config.c                 | 5 +++++
 environment.c            | 1 +
 4 files changed, 10 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f57e9cf..77fcd53 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -898,6 +898,9 @@ core.notesRef::
 This setting defaults to "refs/notes/commits", and it can be overridden by
 the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
+core.commitGraph::
+	Enable git commit graph feature. Allows reading from .graph files.
+
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
diff --git a/cache.h b/cache.h
index 21fbcc2..3a18a02 100644
--- a/cache.h
+++ b/cache.h
@@ -801,6 +801,7 @@ extern char *git_replace_ref_base;
 
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int core_commit_graph;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/config.c b/config.c
index b0c20e6..25ee4a6 100644
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
index de8431e..0e96be3 100644
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
2.7.4

