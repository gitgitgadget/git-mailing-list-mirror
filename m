Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C6C2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbdE3RcA (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:00 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34633 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbdE3Rb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:57 -0400
Received: by mail-pf0-f173.google.com with SMTP id 9so78328307pfj.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aOn/O2FlLyz00vEPeVIQB8FZODpVh/XJ5BmQ2Uqoo4M=;
        b=T2tk7BTVoRXlpRb3cQ1ArmmGEiZfvuMsxHGCLpr2ehby/x7fn2R8OwIBI6Zgp3HD/Q
         HNc2FY6t/l8Xb8xCyotsR1/RoDza21uXzszWli19CVnkgiL1MviQI/aGh7PswyBWioe6
         dzG/gzJDG6iyuNGg5Cnluh2PLuDlgYs3EUVe4anYok45EW6IVaJ7YBmdhae9Ngf9zlxU
         jszTgIzEEmHZpJ2yixp8oFzOAH7PMIj3Uzb89IyrMWOAF2B97pjigJHgosZklyiy+2Dh
         24iT0tNYVNopZ+//FXp3Mn/7DsQyXhWdKQiyQvkfknx5nrVXg1+sRapKvbssw+fQLaJm
         3KHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aOn/O2FlLyz00vEPeVIQB8FZODpVh/XJ5BmQ2Uqoo4M=;
        b=nE6mqoj8iaC2ibcK8eZjyM41rlGzDxqThppPBGoLYHY7VtXtwFQ8tTSabZDj7GEmTb
         JDTELIgU08wCQFd+j1ZglGUJpz6NE7Hv9mfk5PZL97GF9vQTjGZeHP54W5QntbG1O945
         mRqA/H8m+BS0L5uoR7tYls9xu/362Xu8NtxIURSdk9zz8Q/vUnUBG8Ft0R2NSwoJDcKY
         Zbu1UuEa2x45LUrYt73cg+9RCYyp8kKAak03DNxWfZdWOdkRuNbAUoKvfB7OgLJoMUkP
         7rU2ItblV8Lhz+xgmlbO+Yk0m0amSBCAONCpwHaj530v7pa+3IgAQIxpPZ9v70ijxNIm
         iIxg==
X-Gm-Message-State: AODbwcAUMWERkBGNxDt0hvVFTYoT00ZC4k6IzGlkeZyfjxPw5878Vcw0
        byxCt3DivSqiC3+I0lmo1Q==
X-Received: by 10.98.159.135 with SMTP id v7mr24822103pfk.57.1496165510950;
        Tue, 30 May 2017 10:31:50 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:49 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 23/33] notes-merge: convert merge_from_diffs to struct object_id
Date:   Tue, 30 May 2017 10:30:59 -0700
Message-Id: <20170530173109.54904-24-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Brandon Williams <bmwill@google.com>
---
 notes-merge.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 9dbf7f6a3..be78f1954 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -114,8 +114,8 @@ static struct object_id uninitialized = {
 };
 
 static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
-						 const unsigned char *base,
-						 const unsigned char *remote,
+						 const struct object_id *base,
+						 const struct object_id *remote,
 						 int *num_changes)
 {
 	struct diff_options opt;
@@ -123,13 +123,13 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 	int i, len = 0;
 
 	trace_printf("\tdiff_tree_remote(base = %.7s, remote = %.7s)\n",
-	       sha1_to_hex(base), sha1_to_hex(remote));
+	       oid_to_hex(base), oid_to_hex(remote));
 
 	diff_setup(&opt);
 	DIFF_OPT_SET(&opt, RECURSIVE);
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
-	diff_tree_sha1(base, remote, "", &opt);
+	diff_tree_sha1(base->hash, remote->hash, "", &opt);
 	diffcore_std(&opt);
 
 	changes = xcalloc(diff_queued_diff.nr, sizeof(struct notes_merge_pair));
@@ -179,20 +179,20 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 
 static void diff_tree_local(struct notes_merge_options *o,
 			    struct notes_merge_pair *changes, int len,
-			    const unsigned char *base,
-			    const unsigned char *local)
+			    const struct object_id *base,
+			    const struct object_id *local)
 {
 	struct diff_options opt;
 	int i;
 
 	trace_printf("\tdiff_tree_local(len = %i, base = %.7s, local = %.7s)\n",
-	       len, sha1_to_hex(base), sha1_to_hex(local));
+	       len, oid_to_hex(base), oid_to_hex(local));
 
 	diff_setup(&opt);
 	DIFF_OPT_SET(&opt, RECURSIVE);
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
-	diff_tree_sha1(base, local, "", &opt);
+	diff_tree_sha1(base->hash, local->hash, "", &opt);
 	diffcore_std(&opt);
 
 	for (i = 0; i < diff_queued_diff.nr; i++) {
@@ -505,16 +505,17 @@ static int merge_changes(struct notes_merge_options *o,
 }
 
 static int merge_from_diffs(struct notes_merge_options *o,
-			    const unsigned char *base,
-			    const unsigned char *local,
-			    const unsigned char *remote, struct notes_tree *t)
+			    const struct object_id *base,
+			    const struct object_id *local,
+			    const struct object_id *remote,
+			    struct notes_tree *t)
 {
 	struct notes_merge_pair *changes;
 	int num_changes, conflicts;
 
 	trace_printf("\tmerge_from_diffs(base = %.7s, local = %.7s, "
-	       "remote = %.7s)\n", sha1_to_hex(base), sha1_to_hex(local),
-	       sha1_to_hex(remote));
+	       "remote = %.7s)\n", oid_to_hex(base), oid_to_hex(local),
+	       oid_to_hex(remote));
 
 	changes = diff_tree_remote(o, base, remote, &num_changes);
 	diff_tree_local(o, changes, num_changes, base, local);
@@ -636,8 +637,8 @@ int notes_merge(struct notes_merge_options *o,
 		goto found_result;
 	}
 
-	result = merge_from_diffs(o, base_tree_oid->hash, local->tree->object.oid.hash,
-				  remote->tree->object.oid.hash, local_tree);
+	result = merge_from_diffs(o, base_tree_oid, &local->tree->object.oid,
+				  &remote->tree->object.oid, local_tree);
 
 	if (result != 0) { /* non-trivial merge (with or without conflicts) */
 		/* Commit (partial) result */
-- 
2.13.0.219.gdb65acc882-goog

