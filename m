Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C361F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965462AbeF0N0A (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:26:00 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35445 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965405AbeF0NZO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:14 -0400
Received: by mail-qt0-f196.google.com with SMTP id z6-v6so1584339qti.2
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NgkUYoWU9hoyNJBf6oWYsvj2f+MmN8Sq0+kpqoEWfw8=;
        b=oN6g5F0V4/Xw3gqAIVZvO26+6s6gz9aVTZoUMTidU9NBMcKAn/UlnaiPBvInUxRlD5
         7Jfw1N0myofUyJdIqCwJoo+S+cd6jBl9kruAC/S6W7JzSKRUG80ULcdm+f/rmUxITa7+
         mAiBZ1EN1T9iT2bXW/4pHLVfT8Ewk9FCfRwDODsu13G92PpWqilcJyaVvrjIVpCtsJho
         cUBNry4zurnVKJEfeSlhp/vHOvGpPDGnKqTZ7asCC0C5F6av93bTIaIbjKdnAn2YNU6V
         p6ccYZT/k0nuN1ylKrf5iihHph3PldZv7dlnENn2HwxIkr1UsNx1M7gjl1FdoqjVw91b
         o7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NgkUYoWU9hoyNJBf6oWYsvj2f+MmN8Sq0+kpqoEWfw8=;
        b=Z1DPyrRMu89ySo1/TVi9mrNIw2AbOS3qRxp4FTI/ffT7km6TLqMtYsB/PzGr3REirI
         lbTBTjs8DNlWdhDgY9vPQS0szbJJnEgSX8mOK+GjXW4qOogHaFHfWJc9FnpnQliMS9ab
         +UZIDFASrMgykj6JS9yTaNIDnI6ipKdvba2baM6amkeMbxYXIbo7xTLzYlZbBlXclCa0
         C6pHwOq8C+eXndSwC94z6EPJQ6znVc5NsUQmltsc1MVF0Wwo5Rb+CReVZHk1adwaNIAP
         J7ogEA787Gq3RCTAphtr6uEFVOyfQ3hi3/skWODwaJrCvRfb5ONf+Nr4w6wlRRrRrc8a
         jZ/g==
X-Gm-Message-State: APt69E39N4W4zOFTYD9NUWRQhZ/eRh80iOAw+pAHeY/ZLpfQ3yPdmCEf
        bXaYn8hb+8uSYvC0hZdQ7RCISV3fnL0=
X-Google-Smtp-Source: AAOMgpfBiIMK5ftjrdHVDKd4KOP4cMZBea/T/62IhygEfU0cNG3wPX26UVf+Jh0GsWaNpEJslmTxZg==
X-Received: by 2002:ac8:172c:: with SMTP id w41-v6mr5363020qtj.32.1530105913955;
        Wed, 27 Jun 2018 06:25:13 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:13 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 09/22] commit-graph: verify required chunks are present
Date:   Wed, 27 Jun 2018 09:24:34 -0400
Message-Id: <20180627132447.142473-10-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file requires the following three chunks:

* OID Fanout
* OID Lookup
* Commit Data

If any of these are missing, then the 'verify' subcommand should
report a failure. This includes the chunk IDs malformed or the
chunk count is truncated.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          |  9 +++++++++
 t/t5318-commit-graph.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 22ef696e18..f30b4ccee9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -848,5 +848,14 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		return 1;
 	}
 
+	verify_commit_graph_error = 0;
+
+	if (!g->chunk_oid_fanout)
+		graph_report("commit-graph is missing the OID Fanout chunk");
+	if (!g->chunk_oid_lookup)
+		graph_report("commit-graph is missing the OID Lookup chunk");
+	if (!g->chunk_commit_data)
+		graph_report("commit-graph is missing the Commit Data chunk");
+
 	return verify_commit_graph_error;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index c0c1ff09b9..dc16849ddd 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -249,6 +249,15 @@ test_expect_success 'git commit-graph verify' '
 
 GRAPH_BYTE_VERSION=4
 GRAPH_BYTE_HASH=5
+GRAPH_BYTE_CHUNK_COUNT=6
+GRAPH_CHUNK_LOOKUP_OFFSET=8
+GRAPH_CHUNK_LOOKUP_WIDTH=12
+GRAPH_CHUNK_LOOKUP_ROWS=5
+GRAPH_BYTE_OID_FANOUT_ID=$GRAPH_CHUNK_LOOKUP_OFFSET
+GRAPH_BYTE_OID_LOOKUP_ID=$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
+			    1 * $GRAPH_CHUNK_LOOKUP_WIDTH))
+GRAPH_BYTE_COMMIT_DATA_ID=$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
+			     2 * $GRAPH_CHUNK_LOOKUP_WIDTH))
 
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -283,4 +292,24 @@ test_expect_success 'detect bad hash version' '
 		"hash version"
 '
 
+test_expect_success 'detect low chunk count' '
+	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\02" \
+		"missing the .* chunk"
+'
+
+test_expect_success 'detect missing OID fanout chunk' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OID_FANOUT_ID "\0" \
+		"missing the OID Fanout chunk"
+'
+
+test_expect_success 'detect missing OID lookup chunk' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_ID "\0" \
+		"missing the OID Lookup chunk"
+'
+
+test_expect_success 'detect missing commit data chunk' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATA_ID "\0" \
+		"missing the Commit Data chunk"
+'
+
 test_done
-- 
2.18.0.24.g1b579a2ee9

