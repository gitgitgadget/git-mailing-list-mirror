Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92CC211B4
	for <e@80x24.org>; Tue, 15 Jan 2019 20:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389587AbfAOUAH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 15:00:07 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:36749 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389574AbfAOUAH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 15:00:07 -0500
Received: by mail-qt1-f201.google.com with SMTP id t18so3502612qtj.3
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 12:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6cfjX7Ggbruq9E+yfb0LYt3QVSTgNYC/7OZKcyJ5FdY=;
        b=AafMu8xiyADwwbQIaASyUymKMk69z7ovXY4BM9ZXElVhqNzWPmDAWRKpVltmBsVMmw
         CmXR9rF8RzEduw3R/rNp3lgDYDdUoBAiyKn1aATvRKXARcDYAOLjDD4tryCveiTcXLbr
         Ar9KOKcB+edz2nQXZRfjaLbqZ0WjAHqpYGoZncoLErficJoMuyh5491ftaPIYY5Vgg61
         /UM2qbovLNJsk0Td1/9gHNJRTS6cFZke9WPtYiydmcdebdcn6SVIZZNqGELMMv1j/aNX
         yKnwjtS2noXRRCh35y7/GP88fRWKGbpVb7Cid5QSsYADsDquxwujrws2lpcFgg4KdkKL
         IHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6cfjX7Ggbruq9E+yfb0LYt3QVSTgNYC/7OZKcyJ5FdY=;
        b=nSIU3EgFlWR3pZ+mOLh6GrBhEELLDOkl2VpvmQRZ6W+nceKECfECxHef7bH4N3XGtl
         iJX8dXke10YBA2otvGuE+uf24+kiS/Wrt3asEuDRx7tAwZRbgev//B9y8Mo14VHFHuI5
         eBHudNxGs/5QdUby077XY+1zguEXGID6YTdC00GFUB/P4hiUoJur4eDo5/aTVXv6zy3B
         xAxYjKvb1k5XR6PA+tbHnqCRmYduLk5+tBDp6yIV4wYQOQ7vPFaySX0KtMNqqlHFaqRQ
         0FC195gSGg8i06Wy70AgiO2eFXU51ATDMMdJ71ITQK4VoxfCkKIw6gd9Wc0tT0t/+7uJ
         3s7w==
X-Gm-Message-State: AJcUukePCr7+AEJON3z76jaBQWnOPr0wJaXSxzEnFJXQM+1LCqMBHAP3
        0lG/LDDqaJJwzh4MTfsk8hM8mqsKxqOaGHk4Iha+MCBHTAj5PmUM+/J5XRw9/2FJFMy+n6ciItK
        Lm74BeuPUiz9or0gGxN3FCw04kMy/6UP2ywTVolWahUWXEPBzDPwIvPQ/mwyTbFQ=
X-Google-Smtp-Source: ALg8bN4tdGmG+MXKsAGSumuZfD88zI5lDY23cuCCbW2ZekBMYSM/SIdRJOA3oz+MS5pv0DOWGZMDNQfKvY4UHg==
X-Received: by 2002:a37:d611:: with SMTP id t17mr2879761qki.58.1547582405967;
 Tue, 15 Jan 2019 12:00:05 -0800 (PST)
Date:   Tue, 15 Jan 2019 11:59:54 -0800
In-Reply-To: <cover.1547582104.git.steadmon@google.com>
Message-Id: <a3b5d33c4b4cb3df0c197f85e9e8ce37baf2a4db.1547582104.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com> <cover.1547582104.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v5 2/3] commit-graph: fix buffer read-overflow
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fuzz-commit-graph identified a case where Git will read past the end of
a buffer containing a commit graph if the graph's header has an
incorrect chunk count. A simple bounds check in parse_commit_graph()
prevents this.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 commit-graph.c          | 14 ++++++++++++--
 t/t5318-commit-graph.sh | 16 +++++++++++++---
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 07dd410f3c..836d65a1d3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -165,10 +165,20 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	last_chunk_offset = 8;
 	chunk_lookup = data + 8;
 	for (i = 0; i < graph->num_chunks; i++) {
-		uint32_t chunk_id = get_be32(chunk_lookup + 0);
-		uint64_t chunk_offset = get_be64(chunk_lookup + 4);
+		uint32_t chunk_id;
+		uint64_t chunk_offset;
 		int chunk_repeated = 0;
 
+		if (data + graph_size - chunk_lookup <
+		    GRAPH_CHUNKLOOKUP_WIDTH) {
+			error(_("chunk lookup table entry missing; graph file may be incomplete"));
+			free(graph);
+			return NULL;
+		}
+
+		chunk_id = get_be32(chunk_lookup + 0);
+		chunk_offset = get_be64(chunk_lookup + 4);
+
 		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
 
 		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 5fe21db99f..694f26079f 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -366,9 +366,10 @@ GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
 GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
 GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
 
-# usage: corrupt_graph_and_verify <position> <data> <string>
+# usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
 # Manipulates the commit-graph file at the position
-# by inserting the data, then runs 'git commit-graph verify'
+# by inserting the data, optionally zeroing the file
+# starting at <zero_pos>, then runs 'git commit-graph verify'
 # and places the output in the file 'err'. Test 'err' for
 # the given string.
 corrupt_graph_and_verify() {
@@ -376,11 +377,15 @@ corrupt_graph_and_verify() {
 	data="${2:-\0}"
 	grepstr=$3
 	cd "$TRASH_DIRECTORY/full" &&
+	orig_size=$(wc -c < $objdir/info/commit-graph) &&
+	zero_pos=${4:-${orig_size}} &&
 	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
 	cp $objdir/info/commit-graph commit-graph-backup &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
+	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
+	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
 	test_must_fail git commit-graph verify 2>test_err &&
-	grep -v "^+" test_err >err
+	grep -v "^+" test_err >err &&
 	test_i18ngrep "$grepstr" err
 }
 
@@ -484,6 +489,11 @@ test_expect_success 'detect invalid checksum hash' '
 		"incorrect checksum"
 '
 
+test_expect_success 'detect incorrect chunk count' '
+	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\377" \
+		"chunk lookup table entry missing" $GRAPH_CHUNK_LOOKUP_OFFSET
+'
+
 test_expect_success 'git fsck (checks commit-graph)' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git fsck &&
-- 
2.20.1.97.g81188d93c3-goog

