Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630A4EE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjHUVeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjHUVet (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:34:49 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09587133
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:34:45 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a812843f0fso2291159b6e.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692653684; x=1693258484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bCMXdNFyiCh4dmsIJPYjqZttwI/hyKg2AP3DgpjyCYg=;
        b=Vf60gQux0cYSxCvnh+AC9vbAgvRSUdbd2LCB2Avr6468uRAXKGkrldnVQ3YtQvzg7l
         a08slo4DM7WPg4nHdCQZXfk6EopQVBDHg9vPeUmAPON7tkAN4HlKHaWetEO373KF0zSY
         KtybG3pkDHhDO26d871Ezxr21tANz7pu2r25BIZxuG1JiKuIRfWryn4BOqL1Gc2Cm1vj
         6DgNpBdHQiJm2w58PRpS0iEjcpLQVio+U9i2IfbhFv1QcTDWGp4ivEhjon52QXIFdODd
         90ogjKqvxOwwkk2nV9EgZC2RLmRO5q7kD6DqJ76oQxtB7OXD2rVx1DtQrTTi6oxE6XOL
         FysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692653684; x=1693258484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCMXdNFyiCh4dmsIJPYjqZttwI/hyKg2AP3DgpjyCYg=;
        b=E55ceaSFgdxP15SRL2MSehk7t/2imfg4le/GKf6iiJ0shLfh0ZDpygrpWxmPgTpTJC
         LX/lKoDBW1TlZ1FutcZxRZHMSpS9f7q8VNthPtbDJjhZ7wOXMgyuOH00/DH/AJmEmIht
         7PTXdkVGHHLDboSCAhyBi8nsFZF5GwUwHJyOYAOxdKDQEQKJvCtPhsctvjqQMOHE0tdi
         O5lh9CsBVrXLybaT+QGNQmDBTSnNt149+1qwxZi1+Do0MySleJJLRF3Ya5FwMQglIDmg
         u1XfPVehQGAfZe2uh2RFLDMxn11WmohKbQIxuo9c8l++gy7xVCsrqzB80SFelS9oXdgZ
         JN0w==
X-Gm-Message-State: AOJu0YyYzxn7/Y3uTcdjWhRKKb1xW9qRzc1zx2DJNG1TMTG5fM3tjUKQ
        gW6g81Mzfzrd2QYySos6mSyQboYtSdAsxprpNEKSRA==
X-Google-Smtp-Source: AGHT+IHWCT9FN13v79hAWWjOAyg86xuHzrgYofMQsuLlH++KodjRvJL9ak6jIGalwRBG4ZrLvuSmPQ==
X-Received: by 2002:a05:6358:70f:b0:134:e63f:a891 with SMTP id e15-20020a056358070f00b00134e63fa891mr3511959rwj.29.1692653684065;
        Mon, 21 Aug 2023 14:34:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v17-20020a814811000000b00583b40d907esm2451150ywa.16.2023.08.21.14.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:34:43 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:34:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v3 4/4] commit-graph: commit-graph: avoid repeated mixed
 generation number warnings
Message-ID: <52b49bb43492f1dad366eb438b0c23e065c37710.1692653671.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1692653671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692653671.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When validating that a commit-graph has either all zero, or all non-zero
generation numbers, we emit a warning on both the rising and falling
edge of transitioning between the two.

So if we are unfortunate enough to see a commit-graph which has a
repeating sequence of zero, then non-zero generation numbers, we'll
generate many warnings that contain more or less the same information.

Avoid this by keeping track of a single example for a commit with zero-
and non-zero generation, and emit a single warning at the end of
verification if both are non-NULL.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c          | 29 +++++++++++++----------------
 t/t5318-commit-graph.sh |  4 ++--
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index acca753ce8..9e6eaa8a46 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2560,9 +2560,6 @@ static void graph_report(const char *fmt, ...)
 	va_end(ap);
 }
 
-#define GENERATION_ZERO_EXISTS 1
-#define GENERATION_NUMBER_EXISTS 2
-
 static int commit_graph_checksum_valid(struct commit_graph *g)
 {
 	return hashfile_checksum_valid(g->data, g->data_len);
@@ -2575,7 +2572,8 @@ static int verify_one_commit_graph(struct repository *r,
 {
 	uint32_t i, cur_fanout_pos = 0;
 	struct object_id prev_oid, cur_oid;
-	int generation_zero = 0;
+	struct commit *seen_gen_zero = NULL;
+	struct commit *seen_gen_non_zero = NULL;
 
 	verify_commit_graph_error = verify_commit_graph_lite(g);
 	if (verify_commit_graph_error)
@@ -2681,19 +2679,12 @@ static int verify_one_commit_graph(struct repository *r,
 			graph_report(_("commit-graph parent list for commit %s terminates early"),
 				     oid_to_hex(&cur_oid));
 
-		if (!commit_graph_generation_from_graph(graph_commit)) {
-			if (generation_zero == GENERATION_NUMBER_EXISTS)
-				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
-					     oid_to_hex(&cur_oid));
-			generation_zero = GENERATION_ZERO_EXISTS;
-		} else {
-			if (generation_zero == GENERATION_ZERO_EXISTS)
-				graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
-					     oid_to_hex(&cur_oid));
-			generation_zero = GENERATION_NUMBER_EXISTS;
-		}
+		if (commit_graph_generation_from_graph(graph_commit))
+			seen_gen_non_zero = graph_commit;
+		else
+			seen_gen_zero = graph_commit;
 
-		if (generation_zero == GENERATION_ZERO_EXISTS)
+		if (seen_gen_zero)
 			continue;
 
 		/*
@@ -2719,6 +2710,12 @@ static int verify_one_commit_graph(struct repository *r,
 				     odb_commit->date);
 	}
 
+	if (seen_gen_zero && seen_gen_non_zero)
+		graph_report(_("commit-graph has both zero and non-zero "
+			       "generations (e.g., commits '%s' and '%s')"),
+			     oid_to_hex(&seen_gen_zero->object.oid),
+			     oid_to_hex(&seen_gen_non_zero->object.oid));
+
 	return verify_commit_graph_error;
 }
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 8e96471b34..ba65f17dd9 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -620,12 +620,12 @@ test_expect_success 'detect incorrect chunk count' '
 
 test_expect_success 'detect mixed generation numbers (non-zero to zero)' '
 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION_LAST "\0\0\0\0" \
-		"but non-zero elsewhere"
+		"both zero and non-zero generations"
 '
 
 test_expect_success 'detect mixed generation numbers (zero to non-zero)' '
 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\0\0\0\0" \
-		"but zero elsewhere"
+		"both zero and non-zero generations"
 '
 
 test_expect_success 'git fsck (checks commit-graph when config set to true)' '
-- 
2.42.0.4.g52b49bb434
