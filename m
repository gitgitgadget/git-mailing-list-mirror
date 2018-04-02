Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB981F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932502AbeDBUfg (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:35:36 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41245 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932471AbeDBUfI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:35:08 -0400
Received: by mail-qk0-f196.google.com with SMTP id s78so16377736qkl.8
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wXvTEFa6DzRWlM3AybnVZRMTijz5sh3rmWXXMX8cX3c=;
        b=Axzhh8jAnZ0tcd1R44wSnvPVCIKn/QlNxhVDZ0yezyRLOBahq3gpLHghgEHOGWvlmP
         0CKRIVecbZjTu+lU8CSsKd1ao0Xucnun7yl+TfAEJOCLGNk3cgrQs9h7mMHPvYGpWT/h
         5UGGfeOK4eUCgeDpVuXJ2FqtcwR7Fh5rDmEs0TuxHn9ICLkNgNuIvYjzewYxKw/pacH+
         8qfUk0aEl/uRWUj2VJE5/uSvl38v4JQzpjXGvONAB5aqCdbjJEjBG1nAd34UjoICKZFm
         PGJ32LpIzKxSebz+U4yzrx1EFd9B1d41ha0p5VRFgibJxThSJNLvqqJVVNUuM35fz4yH
         hvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wXvTEFa6DzRWlM3AybnVZRMTijz5sh3rmWXXMX8cX3c=;
        b=FqsqV08pgZdpNZ1SrUDxXjU5chatHN2cNtXXh6gkLvQWUg+V3y+8U0/420qJnPUpEo
         Kru5U6FzKiY1BLwSsa9zUtazFBxRvNvyC0Zmq9PGG4wKKUIKWq8fS3D0Gil4AFNlusOv
         WnECKJkO57zlG/MyReZbuL+/trqlMQ5sWVk9L6PWEPs6ck70rKjehlPEPxZt3pLRMlw4
         fjH9OTLWyHfo+60NkeyzCzghyfH5wbe9fJYfT7+tehZYWgyfODPmIQnI0Dgux+3CPUNf
         1YFF13UVTRxFEgSfMbB9uqz1s4RD89jYfFc7X3o+aqmCZ7EtXRK1Hw1r2ANvrXmPuRxR
         MTgg==
X-Gm-Message-State: ALQs6tCMj3qHzaI8gvHJLoJTr8Bi4sfZ4N/Dmac0tIqSFapZNU0RpjDC
        og0z3sl7Bl+ifpg52SqH4Tf7LQoqvS4=
X-Google-Smtp-Source: AIpwx48POpyrpn9uY1bhAm7ig6Ku4zxeWRlRmpRrZDqIUR6k9mM9474Uvae/aCEYRw6hH40M1jwTeA==
X-Received: by 10.55.164.136 with SMTP id n130mr14939732qke.13.1522701306900;
        Mon, 02 Apr 2018 13:35:06 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id n30sm998611qtb.93.2018.04.02.13.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 13:35:06 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 09/14] commit-graph: add core.commitGraph setting
Date:   Mon,  2 Apr 2018 16:34:22 -0400
Message-Id: <20180402203427.170177-10-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180402203427.170177-1-dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com>
 <20180402203427.170177-1-dstolee@microsoft.com>
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
2.17.0.14.gba1221a8ce

