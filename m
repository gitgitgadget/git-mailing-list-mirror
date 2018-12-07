Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A88B20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeLGW1e (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:27:34 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:46346 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGW1d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:27:33 -0500
Received: by mail-vs1-f74.google.com with SMTP id n87so2359872vsi.13
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 14:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T3yI6/FfKnxYgPaPoMsgjKDMp6ZxidATF6ygsXVRuAw=;
        b=I7xSCFPNzZS6HkaueHGVViF/8jNaGWkf7WmQqhtD1rJyHTPSZ3tBrVJTNEcooLo035
         Id0Gb3QmKqCvnpu2NqR3dF/6bge6LnqwU7ph66ckzFt3nBbtZQU2R9//ftcIdWpsZzSk
         UxsaO9wzxcPY8UNsO/jhD51nsJlwcWeuPOgUkvtr/z7L2eppQZBBPXjFOBVQXUR/rsPc
         NucKwDBW6lU6ZO7r9R59PHWDr6JYjrY1PMa5ZO1KwPji/DLHM287ckAS8jxaQBLjVrEZ
         tyU+++8+B5l8mjqLZ1iUsLnLklB+Y3hC3i80HbUaWUA6oRfqwxpwEdQuLrF3Kw4qHGoX
         9WMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T3yI6/FfKnxYgPaPoMsgjKDMp6ZxidATF6ygsXVRuAw=;
        b=iec2l31iPnDDGw9D5Udh+WWwpgpNgB+EkMxFKIoTgw7z/eXdB2YzEDockwGIXVm82P
         P1749zBh6yTOpdfZ585aMmJz8X3kDzfjg6DcspLDT232V2Menpxq5P74okFpz7FWNcWW
         0QqWe12p+f9DNQ4CzHIu1ILo5MfBiIWLms0w110apo+7A88Ig4tb8I4ocWoA3SwFoudC
         8qhfP7/6iFIT31mUukBfGeQd20ayeEkvlXaDQZLY5+1Ogs+EH9D9uwB2ZY9Vbmqx4+we
         Uaiuyku5N0EC5o6wdqCfblFgsqwp6TflOn+vW3+mtOugboM4jGqBiP+ye+mtd3VwNtze
         Jopg==
X-Gm-Message-State: AA+aEWbjHUJac+RwoyVKlnygU745aZe2L8nAlZEoA4gomuJqQXPOHfiS
        tZ42KHvDyHdjC2GI3fb5xYveYv2WKJoCspYKb6vmLbwGiI8dMtOut0RyuFOvo5LwHK/OGlarGgy
        W046GPr+ot63wOSVouTPzi9z83SaAlksyZjI3R/k5GkWSX6ppgfsyXOvgqJsGo6g=
X-Google-Smtp-Source: AFSGD/WFynXkg5YUprD1ZNHLMZ7jXlDmPZkpugHrpEXlHTJUHaDWLXGVx0aiOzwnSdwbkeGjMRQTWsu4sEumhw==
X-Received: by 2002:ab0:6617:: with SMTP id r23mr3352730uam.20.1544221652282;
 Fri, 07 Dec 2018 14:27:32 -0800 (PST)
Date:   Fri,  7 Dec 2018 14:27:23 -0800
In-Reply-To: <cover.1544221121.git.steadmon@google.com>
Message-Id: <675d58ecea2f315bd05d2a21f6a473e9de1105a0.1544221121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544127439.git.steadmon@google.com> <cover.1544221121.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v3 2/3] commit-graph: fix buffer read-overflow
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net
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
 t/t5318-commit-graph.sh | 15 +++++++++++++--
 2 files changed, 25 insertions(+), 4 deletions(-)

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
index 5fe21db99f..5b6b44b78e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -366,24 +366,30 @@ GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
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
 	pos=$1
 	data="${2:-\0}"
 	grepstr=$3
+	orig_size=$(stat --format=%s $objdir/info/commit-graph)
+	zero_pos=${4:-${orig_size}}
 	cd "$TRASH_DIRECTORY/full" &&
 	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
 	cp $objdir/info/commit-graph commit-graph-backup &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
+	truncate --size=$zero_pos $objdir/info/commit-graph &&
+	truncate --size=$orig_size $objdir/info/commit-graph &&
 	test_must_fail git commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err
 	test_i18ngrep "$grepstr" err
 }
 
+
 test_expect_success 'detect bad signature' '
 	corrupt_graph_and_verify 0 "\0" \
 		"graph signature"
@@ -484,6 +490,11 @@ test_expect_success 'detect invalid checksum hash' '
 		"incorrect checksum"
 '
 
+test_expect_success 'detect incorrect chunk count' '
+	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\xff" \
+		"chunk lookup table entry missing" $GRAPH_CHUNK_LOOKUP_OFFSET
+'
+
 test_expect_success 'git fsck (checks commit-graph)' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git fsck &&
-- 
2.20.0.rc2.12.g4c11c11dec

