Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13DB1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeAYOCq (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:02:46 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46765 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeAYOCo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:44 -0500
Received: by mail-qt0-f195.google.com with SMTP id o35so19317792qtj.13
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KtNYwcs3WPF5naIQnSoEKPy/M11Rr/dx1ZLj0dXvkMw=;
        b=Z5ybIbxmoLVgpB0yVGYr1k6JyevavrctANEv3d579IXndSGDvmQf8LpbiZipFX3jP5
         vZPOIIm7Q49LIctd2FY4U6sOJbfzX4Hd1H8UePf8lYgZfWJnBUqgNXyIAAxK4HWBIVb3
         u1cOGOVQBKyHQ1FRfDvqdDINUWKev+e5Xqct5KT6hWSzm9jIgxjMAQFU5eQP+jWx1iRd
         Srq7TfAPcbUCd2lzqFvz+BcSXNYwX81DTI5d+Zd1QHSMuWPyrRIKUBf/ZmJXgro+yeju
         IdjMAt0VCcMJRMpUaaWmAPV6ujGq4Xe6wOdxXDzh71R8Dokcv88ETwBJabAP039IOBMe
         tEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KtNYwcs3WPF5naIQnSoEKPy/M11Rr/dx1ZLj0dXvkMw=;
        b=N4eDxh4qBv9gUbxPk1IG2RRsKhlylc5eabPcW6Wr6NRoJGNIVPjjfEIYB4GifyVzFW
         CYR+fki6I1E1EYce0ENJx5tvZ5h3OhAsT3f10hKedGqt66RrJc18jDDs0hXLhLfHgxcI
         ZR6EtZm0DdLNpI5nZ6LlFj1q9MTcTXfLu6hvWruXRyiy8dmmyAA+LKEhhNN0z0VvwEUH
         biP1EI6Vv/I+X+/EMqGa9iQWdntmJujGfCNs7XT0+OagdFKNvB9Sv8/V3MwL9GbUOOxo
         9hffEHqNjd4OtG0LOF3Ce86q7GEG6h3McahMDyVkAy3u00nZmP8DtWyWy+MA6S+He5N3
         hiQQ==
X-Gm-Message-State: AKwxytdKm9aLV5+sxn5bR7K301vk92VPt4nPt/SveYOGelSWlULOJc39
        JtY66Crgv75nP0ZpTXVNC/+Hfgci
X-Google-Smtp-Source: AH8x227asaAJ35aVa21+b0bgA3cKKSG65Wi/QNaO6LEb1EfAG2sgaBtzs/tfxhN+CCgMRpNou51z/g==
X-Received: by 10.55.40.16 with SMTP id o16mr15086638qkh.216.1516888963252;
        Thu, 25 Jan 2018 06:02:43 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:42 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 02/14] packed-graph: add core.graph setting
Date:   Thu, 25 Jan 2018 09:02:19 -0500
Message-Id: <20180125140231.65604-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180125140231.65604-1-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The packed graph feature is controlled by the new core.graph config
setting. This defaults to 0, so the feature is opt-in.

The intention of core.graph is that a user can always stop checking
for or parsing packed graph files if core.graph=0.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt | 3 +++
 cache.h                  | 1 +
 config.c                 | 5 +++++
 environment.c            | 1 +
 4 files changed, 10 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92b..e7b98fa14f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -898,6 +898,9 @@ core.notesRef::
 This setting defaults to "refs/notes/commits", and it can be overridden by
 the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
+core.graph::
+	Enable git commit graph feature. Allows writing and reading from .graph files.
+
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
diff --git a/cache.h b/cache.h
index d8b975a571..655a81ac90 100644
--- a/cache.h
+++ b/cache.h
@@ -825,6 +825,7 @@ extern char *git_replace_ref_base;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_graph;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
diff --git a/config.c b/config.c
index e617c2018d..fee90912d8 100644
--- a/config.c
+++ b/config.c
@@ -1223,6 +1223,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.graph")) {
+		core_graph = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.sparsecheckout")) {
 		core_apply_sparse_checkout = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 63ac38a46f..0c56a3d869 100644
--- a/environment.c
+++ b/environment.c
@@ -61,6 +61,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
+int core_graph;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
-- 
2.16.0

