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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669E6C433E1
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432A0206DB
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu3etRpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgFENAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgFENAj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 09:00:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FEBC08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 06:00:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so9684173wrp.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=A6ucJ0SWUz4kmpDNWvRxCKcVzBHjjvOAnSVMnoTFDtY=;
        b=lu3etRpu7BGJjIy9eH3KvPGEu/TqjexGts+kmnt4qr/LOFoS9nl3ekEh+4has6yzHd
         7+WTn6TM2uzfBaOX91PGY33nVuEVvkb2HEJfdXfK+jpuYKUVrE04KP+6b8fwYe9f51wQ
         r6mNTpfoxz8U3nUf7zz94PUjqfgrAEJzhTMXKppp+J+PE3M3dB9gemDA8vrjILVmjxsJ
         FrjwiwRN6VhRkPoN3vZIatYBIuOReuDebmesdGBtJhJ7y83KfSv/SzTOR25jN1AMUkn8
         9G38bPnPWXtN+eJrhwuuaZ5E80LvTVksDirCTs1Z865ny1K2L09AC55VpR5+4B1IzQVb
         haAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=A6ucJ0SWUz4kmpDNWvRxCKcVzBHjjvOAnSVMnoTFDtY=;
        b=hTLfbsfWqW3VsGt/Ym86O+VWLeoLpd2DoF/91DYQt2/QrgqC6lHtx+8Rh0Rcjuh0b8
         KyZtSXGck+eJdSb4Q77TyZYR7B+aFRYKMVVXWadpGLE8aNGX80WtT0wKBMuL9pjMdFAh
         u71BPcEGQO06ZCI3ttQxoQjn1JmFM1oNBe30n68JGsbqNgIVpoXSjXkVGUN15var+LGH
         JTmsg3obL5aEMDGmYOCNLBG00wMMIqbWgZpiNyzk18EzX2DQvAFcUxkMPktIVntCKmUe
         BP4KpBbZgPBaqJNSAUXP6BJ0If6vRES/07sRnuTnnGsfrlxwGTGJ6YvEgF033dhblelq
         qitg==
X-Gm-Message-State: AOAM531ntTEV2wrxII7f+6FCbLkH7kPtjhOTTWJm9+0I/h1hZJeKHjzx
        vlEpqpHMnIpWfe38Dae6Z5yatDIQ
X-Google-Smtp-Source: ABdhPJwFNnTGstz24D4VZOyMJWSz6gKOx7UshpXUlURSnqAoW0vsr9ywIYZUxUhrLOsqZ6kltzvTiw==
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr9050896wrj.333.1591362037290;
        Fri, 05 Jun 2020 06:00:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm12532436wrs.36.2020.06.05.06.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:00:36 -0700 (PDT)
Message-Id: <1e1671e7c699adf72fcf4ba8f03a7427ff30c9e7.1591362033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.650.git.1591362032.gitgitgadget@gmail.com>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 13:00:24 +0000
Subject: [PATCH 02/10] commit-graph: fix parsing the Chunk Lookup table
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

The commit-graph file format specifies that the chunks may be in any
order.  However, if the OID Lookup chunk happens to be the last one in
the file, then any command attempting to access the commit-graph data
will fail with:

  fatal: invalid commit position. commit-graph is likely corrupt

In this case the error is wrong, the commit-graph file does conform to
the specification, but the parsing of the Chunk Lookup table is a bit
buggy, and leaves the field holding the number of commits in the
commit-graph zero-initialized.

The number of commits in the commit-graph is determined while parsing
the Chunk Lookup table, by dividing the size of the OID Lookup chunk
with the hash size.  However, the Chunk Lookup table doesn't actually
store the size of the chunks, but it stores their starting offset.
Consequently, the size of a chunk can only be calculated by
subtracting the starting offsets of that chunk from the offset of the
subsequent chunk, or in case of the last chunk from the offset
recorded in the terminating label.  This is currenly implemented in a
bit complicated way: as we iterate over the entries of the Chunk
Lookup table, we check the ID of each chunk and store its starting
offset, then we check the ID of the last seen chunk and calculate its
size using its previously saved offset if necessary (at the moment
it's only necessary for the OID Lookup chunk).  Alas, while parsing
the Chunk Lookup table we only interate through the "real" chunks, but
never look at the terminating label, thus don't even check whether
it's necessary to calulate the size of the last chunk.  Consequently,
if the OID Lookup chunk is the last one, then we don't calculate its
size and turn don't run the piece of code determining the number of
commits in the commit graph, leaving the field holding that number
unchanged (i.e. zero-initialized), eventually triggering the sanity
check in load_oid_from_graph().

Fix this by iterating through all entries in the Chunk Lookup table,
including the terminating label.

Note that this is the minimal fix, suitable for the maintenance track.
A better fix would be to simplify how the chunk sizes are calculated,
but that is a more invasive change, less suitable for 'maint', so that
will be done in later patches.

This additional flexibility of scanning more chunks breaks a test for
"git commit-graph verify" so alter that test to mutate the commit-graph
to have an even lower chunk count.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 2 +-
 t/t5318-commit-graph.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 196e817a84c..7807d945626 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -277,7 +277,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	last_chunk_id = 0;
 	last_chunk_offset = 8;
 	chunk_lookup = data + 8;
-	for (i = 0; i < graph->num_chunks; i++) {
+	for (i = 0; i <= graph->num_chunks; i++) {
 		uint32_t chunk_id;
 		uint64_t chunk_offset;
 		int chunk_repeated = 0;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 18304a65e4d..79e7fbcd40e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -488,7 +488,7 @@ test_expect_success 'detect bad hash version' '
 '
 
 test_expect_success 'detect low chunk count' '
-	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\02" \
+	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\01" \
 		"missing the .* chunk"
 '
 
-- 
gitgitgadget

