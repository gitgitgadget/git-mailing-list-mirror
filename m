Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3470C433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EB2207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaJRg7bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgE2IvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgE2IvI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEACC08C5C9
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l11so2624480wru.0
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8xepLZo0NYKdTng3WvBSyk5T9wPMicb/k259/cHwj0=;
        b=jaJRg7buOkHVR5s9RA0PW6fCc3M4WqJj+dVq2uSdZnURttFzvHI+4THxr96CHckbLS
         hNrfCazuCALOdKKUcJSh9uFV3DLvOfL4+M51gVZjuydQgRp4HKGw/nLyKd0jne9a8tJw
         dKRi5DsmhrtuFnZSOvoa1Ru+VBQMOkl1AG7H0IUTBi60K2kQy+6iTCCW1JwIoi7v7K8l
         XKAFUXWfZ8uasealGmsb7JUfGv3EWxy4SYBkF60u/mu9LlWy89Yr5H2elY9wPsx/XZv0
         vSVvmzYsgB+1hoK5MgVeMpb+1knhSxyzIdvsrvqzY8dB+9Ba8Ukl6/2HKW0A+BWdgS7k
         0D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8xepLZo0NYKdTng3WvBSyk5T9wPMicb/k259/cHwj0=;
        b=dbDByqNGJjSubBpd+wBlTvnN4jtr/10dQLTDB6hvhjvPfHbx8iaxatRQeK64PpD/Ku
         ZK797taLup/oRZOj3o2bsad6MUsmmAqkL2K1CtLJ/R2vTPQN37n5HoP6g4NHcQuDlTXs
         X3JanmLO+zhBbMsAZC+Q/+yHJwrRT3EghU0QkTxeLxZGiJbcz9kK5Fs5mId/UmNJjVKB
         5lHJsYP9bXQfYB+CL+yYGj06YOBnQBTO2k9Q4I6aqKym3c5/5H+4T8+1dE0sgDJgX2A8
         mBt1sn1iWVgaIJMsH9q89Qnh70p0sV9g5WwQqnEZucvqK5X9ZIIffMHeQlgJOYAXiAzp
         K+Jw==
X-Gm-Message-State: AOAM530yFGbs8gPJ3YtbVLwlIS+U4cRPTZnuvG59ZhCy7P88sth6WD8I
        z768n/bCRdb1l81SHleVeEsf1/ep
X-Google-Smtp-Source: ABdhPJwo29LvCTWEATIF/4rQDoc9llgurlv7v3RaO/VfzkWdzSK7pk2UjfucM2B31BSeZGK5RXsUng==
X-Received: by 2002:adf:aa42:: with SMTP id q2mr4921190wrd.360.1590742266987;
        Fri, 29 May 2020 01:51:06 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:06 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 07/34] commit-graph: simplify parse_commit_graph() #1
Date:   Fri, 29 May 2020 10:50:11 +0200
Message-Id: <20200529085038.26008-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While we iterate over all entries of the Chunk Lookup table we make
sure that we don't attempt to read past the end of the mmap-ed
commit-graph file, and check in each iteration that the chunk ID and
offset we are about to read is still within the mmap-ed memory region.
However, these checks in each iteration are not really necessary,
because the number of chunks in the commit-graph file is already known
before this loop from the just parsed commit-graph header.

So let's check that the commit-graph file is large enough for all
entries in the Chunk Lookup table before we start iterating over those
entries, and drop those per-iteration checks.  While at it, take into
account the size of everything that is necessary to have a valid
commit-graph file, i.e. the size of the header, the size of the
mandatory OID Fanout chunk, and the size of the signature in the
trailer as well.

Note that this necessitates the change of the error message as well,
and, consequently, have to update the 'detect incorrect chunk count'
test in 't5318-commit-graph.sh' as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c          | 16 +++++++++-------
 t/t5318-commit-graph.sh |  3 ++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f5ba8a9578..69facf3bf5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -217,6 +217,15 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	graph->data = graph_map;
 	graph->data_len = graph_size;
 
+	if (graph_size < GRAPH_HEADER_SIZE +
+			 (graph->num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH +
+			 GRAPH_FANOUT_SIZE + the_hash_algo->rawsz) {
+		error(_("commit-graph file is too small to hold %u chunks"),
+		      graph->num_chunks);
+		free(graph);
+		return NULL;
+	}
+
 	last_chunk_id = 0;
 	last_chunk_offset = 8;
 	chunk_lookup = data + 8;
@@ -225,13 +234,6 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		uint64_t chunk_offset;
 		int chunk_repeated = 0;
 
-		if (data + graph_size - chunk_lookup <
-		    GRAPH_CHUNKLOOKUP_WIDTH) {
-			error(_("commit-graph chunk lookup table entry missing; file may be incomplete"));
-			free(graph);
-			return NULL;
-		}
-
 		chunk_id = get_be32(chunk_lookup + 0);
 		chunk_offset = get_be64(chunk_lookup + 4);
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3f03de6018..b9a5101c09 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -572,7 +572,8 @@ test_expect_success 'detect invalid checksum hash' '
 
 test_expect_success 'detect incorrect chunk count' '
 	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\377" \
-		"chunk lookup table entry missing" $GRAPH_CHUNK_LOOKUP_OFFSET
+		"commit-graph file is too small to hold [0-9]* chunks" \
+		$GRAPH_CHUNK_LOOKUP_OFFSET
 '
 
 test_expect_success 'git fsck (checks commit-graph)' '
-- 
2.27.0.rc1.431.g5c813f95dc

