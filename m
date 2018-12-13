Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43FE620A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 19:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeLMToJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:44:09 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:53630 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbeLMToI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:44:08 -0500
Received: by mail-qk1-f201.google.com with SMTP id s19so2597319qke.20
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 11:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nVbv1lz3leX5EAHbS5APbNLPmjoTEIwaX6THLkX9P9k=;
        b=NLoJV/VEIMC6kmBbko5cnWnHVe3fkaBKIzHijg7IBtmeEfWzWNYIE3rNu/8KO2lW9V
         A5m3vLBXGc3oAKLn0pXCkqizUg9snwn+VzCDCAPQ14ED3spzgGUB55Oz6xiAceXyb2ge
         wPwnYPYSShRCQiSS4ctgVTHL1RcDQSZ4DbHYjxQtClzXJD+PNtJfLaXkpOqiSu10UVxi
         SjhYuzGoo8jRy6IRRszdA+Q4WdBaxMChNI5lZM0vhExkSsOIULI1CmerlKZOLfUTbdAu
         R7NFZ0VdfLWyNUdmlKi6KrAcP/PR5m3sH9wj44uaM831sJAfahgOyEZMAEyNKSfwUOmh
         z7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nVbv1lz3leX5EAHbS5APbNLPmjoTEIwaX6THLkX9P9k=;
        b=e2/XSr4czTG7yIOlZBUY1dvm8zIevj7UnBoTdh4hFywawEmYH5dFtuiokHDzifZ3qU
         IYouhf9mcFalxWQfZZ7bmcX3wnk6z82piGaKurlQKc0MXOEDniw5XexO16kaqK+Nd/RR
         AKmpRIW373BSy8XCt9d2Z0K9ZQtuK+EeHUQcr/zZBCA7lWcnmG8eTBxGkAUYcmx6JB1l
         9NX6e4pSnwDVw4e5I9YScOdYLT0otSsIsw/ySPEAv166mnfga3P+8APOB1kmBSNPAFI0
         QxZqoF20EZ0Msg5UX7IJOBFd3633qmKxIRfNRTySgTNZExK93hpl76Np7+YZhR99+2Lq
         +QAQ==
X-Gm-Message-State: AA+aEWYSSeo0ODE0FXu1Hzdbixw3h/ApvxRd4/kNncmSKGLub6egwwO6
        nEbNTS5L6RY+BkAQmWAOkpomTZaK5wvOf/0V89vyOtY5qbP5TJjWnXPDL/un+lhbXn7sQT4YEfq
        FsyS0T6p2eIe77oDK1WDaHxDIkxobpk/pMcF9U5zM0zmglrQLUEW5YxjFMMMSbLs=
X-Google-Smtp-Source: AFSGD/UG6XPaJLuV9PyZ9C/m2PsHURYEwoJAdwExjD4u0xnV/MnVvwp2CHTGtiOX5TPvztYZMmVgCuz9pG3nSA==
X-Received: by 2002:a0c:8709:: with SMTP id 9mr114677qvh.6.1544730247507; Thu,
 13 Dec 2018 11:44:07 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:43:57 -0800
In-Reply-To: <cover.1544729841.git.steadmon@google.com>
Message-Id: <80b5662f30cb87210385a6bd26e037ce39e46b6d.1544729841.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com> <cover.1544729841.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v4 2/3] commit-graph: fix buffer read-overflow
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
index 5fe21db99f..a1b5a75882 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -366,21 +366,26 @@ GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
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
+	orig_size=$(wc -c < $objdir/info/commit-graph) &&
+	zero_pos=${4:-${orig_size}} &&
 	cd "$TRASH_DIRECTORY/full" &&
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
2.20.0.rc2.10.g21101b961a

