Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C32E1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeA3Vkn (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:43 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37756 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbeA3VkV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:21 -0500
Received: by mail-qk0-f193.google.com with SMTP id y80so12126007qkb.4
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N4W61rczhTBNrOjAhVfBpv4DcgbhOMm85okfYIMdwZ8=;
        b=g+wGfSTk9sJf9Dcq1vKM6sgvDB93OnJ96Rbb+kZ/wO82nSY47DHNYKoB0XOlk8J5/i
         b6iDLVrAxhhXStOqlQy2FVwRNQ8Gk+ZTl21vmDGzjLmUGbH9LRv8j8skb/NaU9EM4xjg
         kzhnlPX7feRwgUa6/rmDC3rjEuQnnj+ZS6asD8YjeUCU0PRQRLZzCFGj+vS1i74pvMom
         Lv/JdWYj/trV6DnwCVdQ37+T9ppjSCFhpU3RogUU+uSW0EjNjYpOisHIcrvjctEjzD+K
         +u98NE0+C05+Wv/aRTSACBlh4Hx9k7IPBlT+gtu3thxHcxN3pLXMqYQ7obPVHDb/95AG
         xXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N4W61rczhTBNrOjAhVfBpv4DcgbhOMm85okfYIMdwZ8=;
        b=JrHcAYsKut6Oh4h3qWvhgq0NJ5IgUl5c7lD8Ig8TFVHQKtwK/+/wzQCnrZM1dTQdUn
         UOsY9eMJjgM4W014uWDgzXdy63erHbF4h5S8mvCzUxH7hAzIEg5ZA+2FVTx9PP4fyE5n
         RMJCQB8F66pOE7jsSR+KSzmAaJ4cU5+BRoR06D9qp8G0porRIEmwJ0OGxK8DzRxtAfDT
         Wi5NNRvPfNgBiG3Bnw5itCy1R80A+v+bTG7kn9HG40kUaIL1TnNmiJbqT6jiQVVEOao4
         qfcE114mC48V3Hf6EB4tVPGKaFVKzRJ5JumTXalQjidtd6yOCJP1vO7oq4NHW2RZqS1r
         piIA==
X-Gm-Message-State: AKwxytfPVEY5mTJS+1Yeffd/as5/VHmwXzlp4h4JMq5MntkNT7nG1byn
        Up3Dt+SZHsyBihZ4bBeyIW+5430k
X-Google-Smtp-Source: AH8x224GpxjTdEczmWI2xh/Sva+CDZ2PDurG+04Q5WZDMlg3wEHHdIaDzuC2RUYup8QBh8ndoQjcHQ==
X-Received: by 10.55.195.69 with SMTP id a66mr43576756qkj.83.1517348420898;
        Tue, 30 Jan 2018 13:40:20 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:20 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 10/14] commit-graph: add core.commitgraph setting
Date:   Tue, 30 Jan 2018 16:39:39 -0500
Message-Id: <1517348383-112294-11-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit graph feature is controlled by the new core.commitgraph config
setting. This defaults to 0, so the feature is opt-in.

The intention of core.commitgraph is that a user can always stop checking
for or parsing commit graph files if core.commitgraph=0.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt | 3 +++
 cache.h                  | 1 +
 config.c                 | 5 +++++
 environment.c            | 1 +
 4 files changed, 10 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92b..5b63559a2b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -898,6 +898,9 @@ core.notesRef::
 This setting defaults to "refs/notes/commits", and it can be overridden by
 the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
+core.commitgraph::
+	Enable git commit graph feature. Allows reading from .graph files.
+
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
diff --git a/cache.h b/cache.h
index d8b975a571..e50e447a4f 100644
--- a/cache.h
+++ b/cache.h
@@ -825,6 +825,7 @@ extern char *git_replace_ref_base;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_commitgraph;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
diff --git a/config.c b/config.c
index e617c2018d..99153fcfdb 100644
--- a/config.c
+++ b/config.c
@@ -1223,6 +1223,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.commitgraph")) {
+		core_commitgraph = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.sparsecheckout")) {
 		core_apply_sparse_checkout = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 63ac38a46f..faa4323cc5 100644
--- a/environment.c
+++ b/environment.c
@@ -61,6 +61,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
+int core_commitgraph;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
-- 
2.16.0.15.g9c3cf44.dirty

