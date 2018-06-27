Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ED761F721
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965413AbeF0NZg (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:36 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43877 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965111AbeF0NZa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:30 -0400
Received: by mail-qk0-f194.google.com with SMTP id z74-v6so985251qkb.10
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tru1tGtziW0lNh1L5A+/mIL0c91XQrroKsagCmYp7IM=;
        b=qdtpD+lXSlkCfR3CcedNLgjQQQZxxKeU8JS4AUUkfAOVNmtL9ieCJdCVR3OtPtl8a5
         VSvnAg+U4q/y2LCuM8MzinIrD+dYKTHejScr6oMaxUwDfW9KfwgLaDwTBNe4ktTveIQM
         EqAgdDYfJ2View4nVoGla7OjXFSS5Fq/kMIqx3WYKraIZbYaGaNo8wB7AXqRfiGloV7V
         55rtpidtf+ctRSfi0BDbdS4U2b6FZwzlK0NjI86Z0zvi9Ma3sRP9rt2jHM/OAzQkiqFk
         ILZDk8tQCU2VmCI1u2mn0luSBXnrNK8QbMtczqrrMcfhPCfhq0YMbrpiHuTckECBeTHf
         Qv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tru1tGtziW0lNh1L5A+/mIL0c91XQrroKsagCmYp7IM=;
        b=PkQIF/Uvq02c94fG1dvfYTHJDy1G45Ly1O9S7O3hgNs1Da6x8fNDxLfbMgpewsIucT
         drvvEZHrJv72UWwTlI7WO8c75g/CcJxP5zdRcwmE+p/L3hVcwMVfR/IOfB5LBn7T1jZl
         iaV9QzmQllIdOyw/CMxsAuZIc+IuJ8MMNehQNcDdX9aiyKBdLXIW2idkOVM9adfnExh+
         GXncw9eA6EIvkHOOL45oCklSMgQRWKNh1n4Ozsv+s6pv0C9niXmPkzCdkKq92DUgfE7B
         1edIsfVwp/PNgn/s3K7DQfsImc/5iHCFBX+WkT1oKgSE7QoHjFmWcrEENU1V4Dm8jSnW
         ITLA==
X-Gm-Message-State: APt69E2wdxQzgIm0E9PsJKF+X7gb3TLP/UcTGE0LZ/7RiLL0k6bMnkSS
        1ZlMlwZS25uCqM/zQxCMMcwCr3BTvKM=
X-Google-Smtp-Source: AAOMgpfo28LTZgS4FAprmDlyZeFdiSi5/rotPwnU/QAO02BQJ5uEzTKtZ5+q+yUubQbzJPqMZyM6Bw==
X-Received: by 2002:a37:ba47:: with SMTP id k68-v6mr5125285qkf.105.1530105929616;
        Wed, 27 Jun 2018 06:25:29 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:28 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 17/22] commit-graph: verify contents match checksum
Date:   Wed, 27 Jun 2018 09:24:42 -0400
Message-Id: <20180627132447.142473-18-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file ends with a SHA1 hash of the previous contents. If
a commit-graph file has errors but the checksum hash is correct, then we
know that the problem is a bug in Git and not simply file corruption
after-the-fact.

Compute the checksum right away so it is the first error that appears,
and make the message translatable since this error can be "corrected" by
a user by simply deleting the file and recomputing. The rest of the
errors are useful only to developers.

Be sure to continue checking the rest of the file data if the checksum
is wrong. This is important for our tests, as we break the checksum as
we modify bytes of the commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 16 ++++++++++++++--
 t/t5318-commit-graph.sh |  6 ++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6d6c6beff9..d926c4b59f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -833,6 +833,7 @@ void write_commit_graph(const char *obj_dir,
 	oids.nr = 0;
 }
 
+#define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
 static int verify_commit_graph_error;
 
 static void graph_report(const char *fmt, ...)
@@ -852,8 +853,10 @@ static void graph_report(const char *fmt, ...)
 int verify_commit_graph(struct repository *r, struct commit_graph *g)
 {
 	uint32_t i, cur_fanout_pos = 0;
-	struct object_id prev_oid, cur_oid;
+	struct object_id prev_oid, cur_oid, checksum;
 	int generation_zero = 0;
+	struct hashfile *f;
+	int devnull;
 
 	if (!g) {
 		graph_report("no commit-graph file loaded");
@@ -872,6 +875,15 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 	if (verify_commit_graph_error)
 		return verify_commit_graph_error;
 
+	devnull = open("/dev/null", O_WRONLY);
+	f = hashfd(devnull, NULL);
+	hashwrite(f, g->data, g->data_len - g->hash_len);
+	finalize_hashfile(f, checksum.hash, CSUM_CLOSE);
+	if (hashcmp(checksum.hash, g->data + g->data_len - g->hash_len)) {
+		graph_report(_("the commit-graph file has incorrect checksum and is likely corrupt"));
+		verify_commit_graph_error = VERIFY_COMMIT_GRAPH_ERROR_HASH;
+	}
+
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit;
 
@@ -909,7 +921,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		cur_fanout_pos++;
 	}
 
-	if (verify_commit_graph_error)
+	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
 		return verify_commit_graph_error;
 
 	for (i = 0; i < g->num_commits; i++) {
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index a0cf1f66de..fed05e2f12 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -279,6 +279,7 @@ GRAPH_COMMIT_DATA_WIDTH=$(($HASH_LEN + 16))
 GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
 			     $GRAPH_COMMIT_DATA_WIDTH * $NUM_COMMITS))
 GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
+GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
 
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -393,4 +394,9 @@ test_expect_success 'detect incorrect parent for octopus merge' '
 		"invalid parent"
 '
 
+test_expect_success 'detect invalid checksum hash' '
+	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
+		"incorrect checksum"
+'
+
 test_done
-- 
2.18.0.24.g1b579a2ee9

