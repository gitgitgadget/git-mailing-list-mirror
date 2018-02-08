Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61D881F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeBHUiF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:38:05 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44433 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbeBHUiD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:38:03 -0500
Received: by mail-qt0-f193.google.com with SMTP id f18so7730032qth.11
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XcswhH29kzNqxVt0S2D6Pa1Uzqn29Tzn64EzE8F5tQ4=;
        b=Mz/VSBp0v77/FE/R2Bf+RRWruwhkTHUmUqZVilcVf6QOlBwGpbXjg7chfy9YA9yA0Y
         sKZ7k4TlFEbqYqSoSLZcFGb9rVH13pZVr6OT7Heqd9+rwHdHzT0IMpkTH6w3SfwpMNGS
         L5G4I0TBWVnb6+QHDlOtZhp5EeUkMj97uqKjYYMlejkLoQKACbINM0AIornOfuGl5+/C
         3dABv7Tri6cVrx+jLD8u8mpDoEYyp710y8nUyFCWM4DJSmzjQ6ThPmgQ7x28Rsonb7l+
         0BRPP5hbTRzNGC/TBWf5A4ni8dvgBibcSco9ZOWyf1ViBLCz5Fc4oSYGfA2t4tpKpp9C
         I3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XcswhH29kzNqxVt0S2D6Pa1Uzqn29Tzn64EzE8F5tQ4=;
        b=l41fESWZqe/WfJvhgCcIGVv1baHNPyOjOC2qTo7+gArPJJtoo5qUQQiK6lb31Mw+R1
         anz5EJebVSG9rYrO7md4O9a1MoDelGPpLbOg2+4KFLCxEoSL7ilj4mYjWTp674rFat5n
         o7WGheGSy+m9R5J7ZG5sipST82vvs4Kg0ZNu+vXM3JeBHVOcFADQ/TYfgopBulkHttc7
         +tgYMUZ8SLewYVaE/DI5Cf1mkg1Bm1E1qJR1RpDrAm7V308zvpPdVHe6a01BHsTgdk6P
         +lvbhGYguKp91rZP9KKl7BHl9HEqY7zd3XXIlmn+U+AnqRigchxo//RIEwmS0R5q8A4n
         WkBQ==
X-Gm-Message-State: APf1xPAPnyitJqoJdvc2x4k9iuNcmJjprxJIqAfPyinbtJiXzUd+RhBW
        tO7s6uYFH5ntqEh7KA5a1CKc/Q+Fvyg=
X-Google-Smtp-Source: AH8x2250YeAjVbd7564ElyIERUOqTAylPpx9mmqMG2jbbPmeZ6rAxqNXKEKrqzQSQ5MYla+NRotVgw==
X-Received: by 10.200.49.205 with SMTP id i13mr755734qte.116.1518122282434;
        Thu, 08 Feb 2018 12:38:02 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:38:01 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 10/14] commit-graph: add core.commitGraph setting
Date:   Thu,  8 Feb 2018 15:37:34 -0500
Message-Id: <1518122258-157281-11-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
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
index 9593bfabaa..e90d0d1262 100644
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
index 6440e2bf21..1063873316 100644
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
index 41862d4a32..614cf59ac4 100644
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
index 8289c25b44..81fed83c50 100644
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
2.15.1.45.g9b7079f

