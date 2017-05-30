Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0AB2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdE3Rbw (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:52 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33077 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbdE3Rbs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:48 -0400
Received: by mail-pf0-f169.google.com with SMTP id e193so78468379pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DmEZB9gRDKIhOhELHCq9xcBPWta6NnOK+n3bDQYZClM=;
        b=NdV5WD7WwBG3ajyu40bJBzI1AVMr4p+Z3hih3ssokpfuW9J5+0xBepmbQQUOCgSxHU
         cIpNyALvF60G0yQigCsLnk+9S98HmouuVUvJIFgCC6SCF39ZFk9iF8e2XhvZTPfanMKH
         GNyKrdrp9Iru7tFfvot+W9JFsfqaCUIaoWwahD2cZfhAJr5eMO9IRc/4CW3kTlsX668V
         iUdxW7P1BGoGUWJeCUhK91VtpWqHSidJn08zu83H5pSmxtMEmcidaf8lQoHnHR0w8YVC
         YyZLJ8UIXW3L3H0Fi/7Rj512pwIxQqCb3T3A+Zrh9BVTu83emucuXbmpqOcmDQ5qt2Im
         Uq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DmEZB9gRDKIhOhELHCq9xcBPWta6NnOK+n3bDQYZClM=;
        b=KZM+Fj7e/iHObI6JBLa9u0Bptl1ltdJpZbclA1lJIyQxXsd+KZh9inEb3ov0H/VsBm
         mNMhx7+wV3IbIsUXAFI8Aq0cVb0UFJv20fsx2dG5OP5MibvoM/pWN7yiSxC8RAshmPmt
         ceHAtZV3sqMcEpvD0miQlW95cuCRnPRbS5BxxumfjwnUqUScmCE06hmijI/x/1oXKlv6
         v5HLzzJs2l67nMZZ4MRvh6CpT8es6z2FhvgrOBuQD1vYg/eZ2nY7vUZ/1BrSri23tyo9
         gFJ1/tbAVZ+IsZchKoTj6LDSaQ3ekWivqhD+1YyZtKqOZu+DG6w/9o7V9g3ldg0mvyyA
         Tglw==
X-Gm-Message-State: AODbwcDGj9bPrFSl+PFsHHfsbMEZfQ0bV9KAokZe96AdeW8cJjO0RaNT
        qSju0JzuTBptN4zTlEIMQQ==
X-Received: by 10.99.123.70 with SMTP id k6mr26142759pgn.135.1496165507261;
        Tue, 30 May 2017 10:31:47 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:46 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 21/33] tree-diff: convert diff_root_tree_sha1 to struct object_id
Date:   Tue, 30 May 2017 10:30:57 -0700
Message-Id: <20170530173109.54904-22-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fast-export.c | 4 ++--
 diff.h                | 4 ++--
 log-tree.c            | 2 +-
 patch-ids.c           | 2 +-
 tree-diff.c           | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 24e29ad7e..e242726f0 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -566,8 +566,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 			       commit->tree->object.oid.hash, "", &rev->diffopt);
 	}
 	else
-		diff_root_tree_sha1(commit->tree->object.oid.hash,
-				    "", &rev->diffopt);
+		diff_root_tree_oid(&commit->tree->object.oid,
+				   "", &rev->diffopt);
 
 	/* Export the referenced blobs, and remember the marks. */
 	for (i = 0; i < diff_queued_diff.nr; i++)
diff --git a/diff.h b/diff.h
index 6aeeda035..8d46a6709 100644
--- a/diff.h
+++ b/diff.h
@@ -215,8 +215,8 @@ extern struct combine_diff_path *diff_tree_paths(
 	struct strbuf *base, struct diff_options *opt);
 extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			  const char *base, struct diff_options *opt);
-extern int diff_root_tree_sha1(const unsigned char *new, const char *base,
-                               struct diff_options *opt);
+extern int diff_root_tree_oid(const struct object_id *new_oid, const char *base,
+			      struct diff_options *opt);
 
 struct combine_diff_path {
 	struct combine_diff_path *next;
diff --git a/log-tree.c b/log-tree.c
index 9c0c64a2d..b40242534 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -803,7 +803,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	parents = get_saved_parents(opt, commit);
 	if (!parents) {
 		if (opt->show_root_diff) {
-			diff_root_tree_sha1(oid->hash, "", &opt->diffopt);
+			diff_root_tree_oid(oid, "", &opt->diffopt);
 			log_tree_diff_flush(opt);
 		}
 		return !opt->loginfo;
diff --git a/patch-ids.c b/patch-ids.c
index a70a291d8..aaf462c03 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -20,7 +20,7 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 		diff_tree_sha1(commit->parents->item->object.oid.hash,
 			       commit->object.oid.hash, "", options);
 	else
-		diff_root_tree_sha1(commit->object.oid.hash, "", options);
+		diff_root_tree_oid(&commit->object.oid, "", options);
 	diffcore_std(options);
 	return diff_flush_patch_id(options, oid, diff_header_only);
 }
diff --git a/tree-diff.c b/tree-diff.c
index 7ae1f10b2..f9bbaf3c4 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -711,7 +711,7 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 	return retval;
 }
 
-int diff_root_tree_sha1(const unsigned char *new, const char *base, struct diff_options *opt)
+int diff_root_tree_oid(const struct object_id *new_oid, const char *base, struct diff_options *opt)
 {
-	return diff_tree_sha1(NULL, new, base, opt);
+	return diff_tree_sha1(NULL, new_oid->hash, base, opt);
 }
-- 
2.13.0.219.gdb65acc882-goog

