Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBE411F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeCNT2W (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:28:22 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35265 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbeCNT2F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 15:28:05 -0400
Received: by mail-qt0-f196.google.com with SMTP id z14so4734401qti.2
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9/O+wWPMfP91Vz2+4hhJC32kou5ta5DhsTgo5fAmaD0=;
        b=ZpFR9WGh4IkRHSdShPnF7hLsBjPIuntPzOAtPv2hgt0jS8bKgaXNjfVIl8oX6hn5Yv
         GxAJJJVFRAoBV/RrzEww+aXDQYeEEVJ8WPjvVt9yilp+97PJN1ldzAuhmXJ8+QnLId9a
         3duWYq5QqWIyLjT/3CkcmwXAuAhwFmtRz6iWlRDWKfpV/uGn/mqUzoT0AV7dzp8i0kgw
         36MmGS9jqPp5XND5kL+GTmQM3vJG454JdY4QEpcECaxurfK1io5q8Qzs7T1EPfqy6bGB
         sbXjMyrAxN5LvLoCXKbdaLWiR3xvGhOfD5BWFITVUv3JtS0nxHa8ZLiQXvcUd8A4fMkC
         /gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9/O+wWPMfP91Vz2+4hhJC32kou5ta5DhsTgo5fAmaD0=;
        b=kve7iqL1eg2G2AVa4uW4NhBMZO9l+G8VN02kL/vbO3AHxnd3j9GVB06Rz9yZ/biONS
         e+/ZKtw5haTwMPZV6bpy604apseu4XeBBWC2UTG73VmlTLKlyWgg2HZh9r2L9prtd89h
         Lqn6iREVwrfMqbLNyyNGdgOvE/IPABk47JBulkDh81cuPAgXrCojbJWYynDegRTtdb39
         /6cLZW7p6rE9fmjK2eiMe4C1ozBCTH/4eIbHQHH2ErAEo/4UiMTdE4I2jD5X7+L/iKdQ
         Cv2Sjg44fFmEeLwTaqSqQAoaGZnyOuwMKejdnSSUm143q/4GkdhYOMPg1ONoD5sNW5EX
         Bvhg==
X-Gm-Message-State: AElRT7G5BVhjHZLq1EMhKd/LbfxeEHyo+Wv1garvpkDk4JSFDzsff6M1
        tmQ1y0jBdOELGpHfHItUhg2y0AOTz8M=
X-Google-Smtp-Source: AG47ELtS4LhKDcyRhDUI6haRtZQuGFcm6eT9+YY5yaGIUY9UMWoF31klMIbieSnp2zLVppNgBpaUmA==
X-Received: by 10.200.27.99 with SMTP id p32mr8921426qtk.254.1521055684511;
        Wed, 14 Mar 2018 12:28:04 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id q30sm2847395qte.10.2018.03.14.12.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 12:28:03 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 09/14] commit-graph: add core.commitGraph setting
Date:   Wed, 14 Mar 2018 15:27:31 -0400
Message-Id: <20180314192736.70602-10-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314192736.70602-1-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
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
 Documentation/config.txt | 3 +++
 cache.h                  | 1 +
 config.c                 | 5 +++++
 environment.c            | 1 +
 4 files changed, 10 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce9102cea8..9e3da629b8 100644
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
index d06932ed0b..e62569fbb1 100644
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
2.14.1

