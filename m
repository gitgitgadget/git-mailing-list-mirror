Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5270D211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 20:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLFUVF (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 15:21:05 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:44993 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeLFUVF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 15:21:05 -0500
Received: by mail-io1-f74.google.com with SMTP id v8so1446495ioh.11
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 12:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=GpOTn8OjOveC8Do/YSKuS56Kg/PX8WL3IGpZp04Wd9Q=;
        b=npKmt3fGNGuNpJpPd4UPN2g+s9dInItOp+K6jf66jq8O8IgJyDYZisufX4wid4oy+P
         Ooy4N2lLgGdelwmk/vKGDEHAJZwNuIbEgALWe0pG6JsIuo20SEE8lPhCpamYSrhhOe/y
         9gm1V4bJDrppemmSc24D+SKjlUPK9eNOrVLCKvlpPytWB/U60EI3Fenr3p60WQWPWkXp
         ahWb8zBNJ/TmVRU+fd2kg+Egd1h6N+Z1ZuT0e+kTpfTGphbThrl5fv3T0HyT11lTUiR+
         ku2sNHzCaW8/tWmZgjoxmnF58F9JYB5cipBV2WAbgTYMnoYmvp0NgwkFT2ReuiW3yETn
         aeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=GpOTn8OjOveC8Do/YSKuS56Kg/PX8WL3IGpZp04Wd9Q=;
        b=T8KEtTPCQsrA/Do0ybEGpzLKefktrpjeizaSi2eZVFxJ89Pizr4Ubr3Q+9OdVncLyl
         sAnHr3+hsUKg2OuzA3Sq8iLP3H7i4u8LHSP/LwLO/wbhQ73Xc29y/AJfxIlqGidWk1ye
         KQF2PjzOa7lvM4DIIGsT9pEyBKaSVeNKikiby0uitr5suul+cl1sM0ZlQEWcOjTCTazp
         xCqK6RlSU8FhoKar0abEEq6/WGy1myKoGvqVz4mQn/RiVbQlNUsZLj4ETTlBXb8jDoLZ
         T4brPmGRzfqKyeBIim2+29uBwoRRP9IrKkB966noxB3qTIFzuMk0mD0tXHaGAsoPSniF
         GxWg==
X-Gm-Message-State: AA+aEWYsoledfXrl7rVNNSzE0pTfSEybeDWKLJv7cgN4ULx/cGyQq7YA
        kAZyQrbl/qFpsDDEDsf3YzUws9weH4AYB8cuX+wccvu9VaHsAm+P+GWb5SD8VE6vmswE9Smep0D
        ViaW4BbZ5wUsqQbK9ULgim2wfJ6sgRa9qBYJR77jy4Ixc457+3KxzEkcVO7iTiro=
X-Google-Smtp-Source: AFSGD/XtkeX2tCaTcQFre+lO7RekGz8UM3E4v5sgkK8TYEmyhGRC9C20RrZsu52vwx6Prvy4q0z7cwyfsWfMjw==
X-Received: by 2002:a24:248d:: with SMTP id f135mr10844255ita.36.1544127663804;
 Thu, 06 Dec 2018 12:21:03 -0800 (PST)
Date:   Thu,  6 Dec 2018 12:20:54 -0800
In-Reply-To: <cover.1544127439.git.steadmon@google.com>
Message-Id: <af45c2337fbe2a59ac95aff3ce90a69d8c30416f.1544127439.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com> <cover.1544127439.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v2 2/3] commit-graph: fix buffer read-overflow
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        avarab@gmail.com
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
 t/t5318-commit-graph.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 07dd410f3c..224a5f161e 100644
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
 
+		if (chunk_lookup + GRAPH_CHUNKLOOKUP_WIDTH >
+		    data + graph_size) {
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
index 5fe21db99f..2503cb0345 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -384,6 +384,29 @@ corrupt_graph_and_verify() {
 	test_i18ngrep "$grepstr" err
 }
 
+
+# usage: corrupt_and_zero_graph_then_verify <corrupt_position> <data> <zero_position> <string>
+# Manipulates the commit-graph file at <corrupt_position> by inserting the data,
+# then zeros the file starting at <zero_position>. Finally, runs
+# 'git commit-graph verify' and places the output in the file 'err'. Tests 'err'
+# for the given string.
+corrupt_and_zero_graph_then_verify() {
+	corrupt_pos=$1
+	data="${2:-\0}"
+	zero_pos=$3
+	grepstr=$4
+	orig_size=$(stat --format=%s $objdir/info/commit-graph)
+	cd "$TRASH_DIRECTORY/full" &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$corrupt_pos" conv=notrunc &&
+	truncate --size=$zero_pos $objdir/info/commit-graph &&
+	truncate --size=$orig_size $objdir/info/commit-graph &&
+	test_must_fail git commit-graph verify 2>test_err &&
+	grep -v "^+" test_err >err &&
+	test_i18ngrep "$grepstr" err
+}
+
 test_expect_success 'detect bad signature' '
 	corrupt_graph_and_verify 0 "\0" \
 		"graph signature"
@@ -484,6 +507,11 @@ test_expect_success 'detect invalid checksum hash' '
 		"incorrect checksum"
 '
 
+test_expect_success 'detect truncated graph' '
+	corrupt_and_zero_graph_then_verify $GRAPH_BYTE_CHUNK_COUNT "\xff" \
+		$GRAPH_CHUNK_LOOKUP_OFFSET "chunk lookup table entry missing"
+'
+
 test_expect_success 'git fsck (checks commit-graph)' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git fsck &&
-- 
2.20.0.rc2.10.g7519fc76df

