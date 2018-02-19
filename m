Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA671F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeBSSxq (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:53:46 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42805 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753542AbeBSSxo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:53:44 -0500
Received: by mail-qt0-f193.google.com with SMTP id k25so13438891qtj.9
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R6cX2aNPbqjcIgw2U9oGLuLNs5moyifxR2n9UYbbB5k=;
        b=jxL6A6sOFcd2WcNVeK55BZZedDVegNwmsB3cdkBgxl7W7/RllLavK4qqVk7G/WHzk9
         oJcsko7BzBkyx6QCfwZDhZgGGsFituS0bLs59SrdiNqHdev39cHd0z2EUv+EkNh9rxZt
         D+J6hy6uVuZnOQt3dIkEftAL6174RY4SxRrdP2h2/G54iak0BCkIhNw45BsWWLUsgUvf
         sIll+3XXTMT7eFQmfYiLJCWHtklF9+iugoXlnNXdfQ0mFuJqCOmEF+SdFCFBnloCEZjg
         1GYySAmCx+47WnTPxJfHpni2ajwfT64zfmgxYsendKL2PZMe63gQ/AJvC/us+Mosfp3N
         boZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R6cX2aNPbqjcIgw2U9oGLuLNs5moyifxR2n9UYbbB5k=;
        b=WcEhOIXkwFc81tNkk5BQl75zTKXCsgksgW/c1IrWWINh9HfttAg4iuJgTl96dGoUhS
         XgxJf8ah4pdCJB2a0NzDF1igh6EUcH9byYWEN1PGtreall2hfhrvfCxXEX1mza3CpNna
         zxd/d98hoJ02Nk4bzRAeYSapkOCsvgkVjb4TZxK0MrVfwqt4qLWLcIYEfWjNvgK+X11X
         AgBK0STPF1xEuwNK7mPJRXSOXuRKuJvk4T7Byxk/j7oujUlQBf/O8P4R+f8Dai3SyCwv
         iZ7ZfejpSW8kBUF1xpChNafjZErx/IAmpjOrmDwPxsp0LGE4EsU02rTz7vSzj9vCKqCO
         lCGA==
X-Gm-Message-State: APf1xPCCF7qTemjnWhBCWIKnkvyi56yc7gEF9r62pbd6hftoFLV1SPXt
        qUBdpnRvZMM4rUk5iHQ3rJ9jRSbRSrw=
X-Google-Smtp-Source: AH8x2276eO8Dv1lzuF4iuSSExElrhg42kbZoS+0NHrNLjeXMXLaZsx4TPiAs866dIvdhAYsMSSgYfA==
X-Received: by 10.200.43.39 with SMTP id 36mr26277550qtu.341.1519066423409;
        Mon, 19 Feb 2018 10:53:43 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id o12sm1672631qke.81.2018.02.19.10.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 10:53:42 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     peff@peff.net, jonathantanmy@google.com, szeder.dev@gmail.com,
        sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 09/13] commit-graph: add core.commitGraph setting
Date:   Mon, 19 Feb 2018 13:53:22 -0500
Message-Id: <1519066406-81663-10-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
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
index 9593bfa..e90d0d1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -883,6 +883,9 @@ core.notesRef::
 This setting defaults to "refs/notes/commits", and it can be overridden by
 the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
+core.commitGraph::
+	Enable git commit graph feature. Allows reading from .graph files.
+
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
diff --git a/cache.h b/cache.h
index 6440e2b..1063873 100644
--- a/cache.h
+++ b/cache.h
@@ -771,6 +771,7 @@ extern char *git_replace_ref_base;
 
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int core_commit_graph;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/config.c b/config.c
index 41862d4..614cf59 100644
--- a/config.c
+++ b/config.c
@@ -1213,6 +1213,11 @@ static int git_default_core_config(const char *var, const char *value)
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
index 8289c25..81fed83 100644
--- a/environment.c
+++ b/environment.c
@@ -60,6 +60,7 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
+int core_commit_graph;
 int core_apply_sparse_checkout;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
-- 
2.7.4

