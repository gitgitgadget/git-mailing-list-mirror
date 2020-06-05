Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA68C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACB7206DB
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwkdcyKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgFENAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgFENAp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 09:00:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AC0C08C5C5
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 06:00:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t18so9675411wru.6
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=IOcRA5L6IF9PmXs61Ssx85ulJSbqtIkMPU2nhQvE9xA=;
        b=DwkdcyKDWL2Ieq45GcpUgmQhLVhHfR91eOE7viv7d9crekBgk/wCt2G2G9esMGGClJ
         G7ZFvzZPjvXBF9ncTbCa4y2derGSJVCgGzfJuXWB7EBJFtYr7QIOfIkZBOnEMzsZYMd0
         UNKOkpvJvaEcp8jFDTt4V5vyNwodeweilDeXvC3Rx+QI4St1V/pLibdsCgt9893+Y4yd
         k8EBAwUybXaCj1NmHyB7CAsJQYXXfWfczEwp/9Brplpn5jncgme6BAtCWP+nUoj574v4
         O3akVv7OF24VFiJTd1pop71ex1tIk1UkoPR1fKAwqIzGy7EnLVQRJ57/HG5hII9XNava
         DjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=IOcRA5L6IF9PmXs61Ssx85ulJSbqtIkMPU2nhQvE9xA=;
        b=gqzH5wvj6GzxoY/n1ciWx53NSoQPqU9yIwuqLtoL6qNOkJdJlv/rVOSEPfAjJYxME7
         lz1uSX+Tt5S1VA3ZlDPQW/BzCHPl/uwqtFsKd5Ki68oU8Xv05VHRz945FAnc7JukB6+m
         Rtn/pUcEvrBnn77HE4WMysI+58z+E8YsWAllzEWv1sp8ctMn4cyiCszTLZjBaOZ2j5bx
         bBNFeL4i6qP+TdJqItuWCb277SEADF8VAQtqVeo95thla+P75LDow9Uepaxt0fuZ2Tk+
         r57/r72oy1jZGkCseFSwoMmGs0JkHfPoUE1acbbBKdOQlTF80VmOaAGakd/rXwgNwBcU
         qLfg==
X-Gm-Message-State: AOAM531p/RTvYHJOgNg9l+C9SUtPZJi8x8N2Kg4yveziqYvwb6jqMRIV
        NQexJVErvGDTkHLKqxLuKSh65vyh
X-Google-Smtp-Source: ABdhPJwLvT6m7rlaVZMb3ndjWkmnEkrFtD5tJBY9lQIYuPeX9IdoqVmnk9RwMJ9iikuj7bvoBuDqmA==
X-Received: by 2002:a05:6000:1ce:: with SMTP id t14mr9535074wrx.300.1591362042594;
        Fri, 05 Jun 2020 06:00:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10sm12112954wrp.16.2020.06.05.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:00:42 -0700 (PDT)
Message-Id: <cd9e033d1b1b4cfb0d5fe485b8b37608c2227ec2.1591362033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.650.git.1591362032.gitgitgadget@gmail.com>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 13:00:29 +0000
Subject: [PATCH 07/10] commit-graph: simplify parse_commit_graph() #1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, jnareb@gmail.com,
        peff@peff.net, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

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
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 16 +++++++++-------
 t/t5318-commit-graph.sh |  3 ++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6ed649388d6..9927762f18c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -272,6 +272,15 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
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
@@ -280,13 +289,6 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
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
index 79e7fbcd40e..1073f9e3cf2 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -574,7 +574,8 @@ test_expect_success 'detect invalid checksum hash' '
 
 test_expect_success 'detect incorrect chunk count' '
 	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\377" \
-		"chunk lookup table entry missing" $GRAPH_CHUNK_LOOKUP_OFFSET
+		"commit-graph file is too small to hold [0-9]* chunks" \
+		$GRAPH_CHUNK_LOOKUP_OFFSET
 '
 
 test_expect_success 'git fsck (checks commit-graph)' '
-- 
gitgitgadget

