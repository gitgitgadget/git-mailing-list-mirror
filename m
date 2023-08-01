Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97701C41513
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjHASmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjHASmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:42:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFFC269A
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:41:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d10792c7582so4825817276.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915307; x=1691520107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndyIHuxvMuMAtz6sXsOjsM7Sp/w4P2qr5ACsxHsbZc8=;
        b=lnesFat/E548YDATq2Q/pNkrj+XnZUoXxkMxuK/jYZJ7p9a2IM74CIH4RdhOZlKZGb
         HEtIf30ZyMTtRcGs1NVJATjD5m2YlWUZFSfU1Z7fjqUuj4/aAJztC7DehbRICdCzwon1
         u98YB3JQBKVROuK2y/626M1QmHlfhJZRmsx1tPAe0uudVNru3ljUgFcckmyN7DKWQ3Sd
         cssa75TehDvnORCnlDCDHi9tEeUrqWHL2pxjVUz3b6ya7qy1rkixPW9Ut/0fOYfOXm0T
         FVs6zfsWdn1FEw+GuL1cAPqxjD2cRsEzsO5CQTr2SzEBJdj3jmTO4+udspdq1RWb6mIw
         O8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915307; x=1691520107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndyIHuxvMuMAtz6sXsOjsM7Sp/w4P2qr5ACsxHsbZc8=;
        b=ShJwwd9sFoknEaq6k27P9g+orubdvy7+20U4+2ZNAW7Dq/iH/A2sNC8io+po+4gSxe
         vjcxMPaf3aHZ+tBuXJyYICZ5KRRv1LyrQMDFW/ipvKONngHI7xRRfVqqJ4ybPACfCr3P
         72m2H4ChZ6Og25RzUYGR3ogJHk5AyjtkYWyQCIqtZYiU7a0CSNxCrxlQuLdo7u33z0oR
         pMVeXE9T8xxj4B+Tk/2aid1X7mg61cLDyTclaTg6vPYAXvXg/wicBjE41Milp4yQybnc
         9IUHxF9TGbIJ6WOl2bbDIF+vEPVMAGHAeZdeOBOhIxFjCiqffr6JGrP4EC35FlD+kmBC
         dK1w==
X-Gm-Message-State: ABy/qLZ1b1u8pqoyJSo+0a35RDNyfxRZOL32tTjCSzHQcnuDBIm6K9wm
        8g3+GEEk+hvX5MbVqvsxxJaMGvWxGVB73SjRJ9otOIEmHRrgm9ka//MnLr++QVMI9LX3/zOSrSX
        g0/PUfrFJARdkfmEvsvnAqJPLbzSScGIIa8OT5KAnPwBhehzvPmWkBAHrKglSnmSh41kV6HDYMZ
        GB
X-Google-Smtp-Source: APBJJlHXVijoPZPUH6OjruBIpXtzq6Cpj5cUOMA0e/ED7+pfe9NvA6AuJ+jqyAnAO1hQe2Mynjwrot6YNxWLkdRboBbh
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:a487:6e54:d296:9521])
 (user=jonathantanmy job=sendgmr) by 2002:a25:abe3:0:b0:d22:4059:b2bd with
 SMTP id v90-20020a25abe3000000b00d224059b2bdmr92646ybi.1.1690915307514; Tue,
 01 Aug 2023 11:41:47 -0700 (PDT)
Date:   Tue,  1 Aug 2023 11:41:35 -0700
In-Reply-To: <cover.1684790529.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <cover.1690912539.git.jonathantanmy@google.com>
Subject: [PATCH v7 0/7] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've fixed the bug that Taylor described. It was an issue where the
presence of Bloom filters can be indicated both by the presence of the
chunk and the presence of a bloom_filter_settings, and I've fixed it by
avoiding setting the chunk_bloom_data if we're not using Bloom filters
due to an incompatible version. In the future, we might want to refactor
the code so that there is only one way to indicate whether the Bloom
filters are present.

I've also added sign-offs and changed the indentation of the tests, as
remarked by Taylor [1] [2].

[1] https://lore.kernel.org/git/ZMGruenDbAo22aWV@nand.local/
[2] https://lore.kernel.org/git/ZMGsJTxBXZ94lhMU@nand.local/

Taylor also suggested copying forward Bloom filters whenever possible
in this patch set [3], but also that we could work on this outside this
series [4]. I did not implement this in this series.

[3] https://lore.kernel.org/git/ZMKvsObx+uaKA8zF@nand.local/
[4] https://lore.kernel.org/git/ZMlKMmAs3wKULAOd@nand.local/

Jonathan Tan (4):
  gitformat-commit-graph: describe version 2 of BDAT
  t4216: test changed path filters with high bit paths
  repo-settings: introduce commitgraph.changedPathsVersion
  commit-graph: new filter ver. that fixes murmur3

Taylor Blau (3):
  t/helper/test-read-graph.c: extract `dump_graph_info()`
  bloom.h: make `load_bloom_filter_from_graph()` public
  t/helper/test-read-graph: implement `bloom-filters` mode

 Documentation/config/commitgraph.txt     |  26 ++++-
 Documentation/gitformat-commit-graph.txt |   9 +-
 bloom.c                                  |  75 +++++++++++-
 bloom.h                                  |  13 ++-
 commit-graph.c                           |  35 ++++--
 oss-fuzz/fuzz-commit-graph.c             |   2 +-
 repo-settings.c                          |   6 +-
 repository.h                             |   2 +-
 t/helper/test-bloom.c                    |   9 +-
 t/helper/test-read-graph.c               |  67 ++++++++---
 t/t0095-bloom.sh                         |   8 ++
 t/t4216-log-bloom.sh                     | 139 +++++++++++++++++++++++
 12 files changed, 351 insertions(+), 40 deletions(-)

Range-diff against v6:
1:  3ce6090a4d = 1:  3ce6090a4d gitformat-commit-graph: describe version 2 of BDAT
2:  1955734d1f ! 2:  fc6346c039 t/helper/test-read-graph.c: extract `dump_graph_info()`
    @@ Commit message
         main routine into a separate function.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    +    Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## t/helper/test-read-graph.c ##
     @@
3:  4cf7c2f634 ! 3:  f144dc4b15 bloom.h: make `load_bloom_filter_from_graph()` public
    @@ Commit message
         for manual inspection (to be used during tests).
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    +    Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## bloom.c ##
     @@ bloom.c: static inline unsigned char get_bitmask(uint32_t pos)
4:  47b55758e6 ! 4:  2ade832a23 t/helper/test-read-graph: implement `bloom-filters` mode
    @@ Commit message
         hexadecimal contents of the Bloom filter(s) contained in a commit-graph.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    +    Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## t/helper/test-read-graph.c ##
     @@ t/helper/test-read-graph.c: static void dump_graph_info(struct commit_graph *graph)
5:  5276e6a90e ! 5:  74863c11e5 t4216: test changed path filters with high bit paths
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills empty comm
     +'
     +
     +test_expect_success 'setup check value of version 1 changed-path' '
    -+	(cd highbit1 &&
    ++	(
    ++		cd highbit1 &&
     +		echo "52a9" >expect &&
     +		get_first_changed_path_filter >actual &&
    -+		test_cmp expect actual)
    ++		test_cmp expect actual
    ++	)
     +'
     +
     +# expect will not match actual if char is unsigned by default. Write the test
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills empty comm
     +'
     +
     +test_expect_success 'version 1 changed-path used when version 1 requested' '
    -+	(cd highbit1 &&
    -+		test_bloom_filters_used "-- $CENT")
    ++	(
    ++		cd highbit1 &&
    ++		test_bloom_filters_used "-- $CENT"
    ++	)
     +'
     +
      test_done
6:  dc3f6d2d4f = 6:  60f4faeff9 repo-settings: introduce commitgraph.changedPathsVersion
7:  6e2d797406 ! 7:  68258cfd04 commit-graph: new filter ver. that fixes murmur3
    @@ commit-graph.c: static int graph_read_oid_lookup(const unsigned char *chunk_star
     +	struct graph_read_bloom_data_context *c = data;
     +	struct commit_graph *g = c->g;
      	uint32_t hash_version;
    - 	g->chunk_bloom_data = chunk_start;
    +-	g->chunk_bloom_data = chunk_start;
      	hash_version = get_be32(chunk_start);
      
     -	if (hash_version != 1)
    @@ commit-graph.c: static int graph_read_oid_lookup(const unsigned char *chunk_star
     + 		return 0;
     +	}
      
    ++	g->chunk_bloom_data = chunk_start;
      	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
      	g->bloom_filter_settings->hash_version = hash_version;
    + 	g->bloom_filter_settings->num_hashes = get_be32(chunk_start + 4);
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
      	}
      
    @@ t/t0095-bloom.sh: test_expect_success 'compute unseeded murmur3 hash for test st
      	Hashes:0x5615800c|0x5b966560|0x61174ab4|0x66983008|0x6c19155c|0x7199fab0|0x771ae004|
     
      ## t/t4216-log-bloom.sh ##
    -@@ t/t4216-log-bloom.sh: test_expect_success 'set up repo with high bit path, version 1 changed-path' '
    - 	git -C highbit1 commit-graph write --reachable --changed-paths
    - '
    - 
    --test_expect_success 'setup check value of version 1 changed-path' '
    -+test_expect_success 'check value of version 1 changed-path' '
    - 	(cd highbit1 &&
    - 		echo "52a9" >expect &&
    - 		get_first_changed_path_filter >actual &&
     @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when version 1 requested' '
    - 		test_bloom_filters_used "-- $CENT")
    + 	)
      '
      
     +test_expect_success 'version 1 changed-path not used when version 2 requested' '
    -+	(cd highbit1 &&
    ++	(
    ++		cd highbit1 &&
     +		git config --add commitgraph.changedPathsVersion 2 &&
    -+		test_bloom_filters_not_used "-- $CENT")
    ++		test_bloom_filters_not_used "-- $CENT"
    ++	)
     +'
     +
     +test_expect_success 'version 1 changed-path used when autodetect requested' '
    -+	(cd highbit1 &&
    ++	(
    ++		cd highbit1 &&
     +		git config --add commitgraph.changedPathsVersion -1 &&
    -+		test_bloom_filters_used "-- $CENT")
    ++		test_bloom_filters_used "-- $CENT"
    ++	)
     +'
     +
     +test_expect_success 'when writing another commit graph, preserve existing version 1 of changed-path' '
     +	test_commit -C highbit1 c1double "$CENT$CENT" &&
     +	git -C highbit1 commit-graph write --reachable --changed-paths &&
    -+	(cd highbit1 &&
    ++	(
    ++		cd highbit1 &&
     +		git config --add commitgraph.changedPathsVersion -1 &&
     +		echo "options: bloom(1,10,7) read_generation_data" >expect &&
     +		test-tool read-graph >full &&
     +		grep options full >actual &&
    -+		test_cmp expect actual)
    ++		test_cmp expect actual
    ++	)
     +'
     +
     +test_expect_success 'set up repo with high bit path, version 2 changed-path' '
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +'
     +
     +test_expect_success 'check value of version 2 changed-path' '
    -+	(cd highbit2 &&
    ++	(
    ++		cd highbit2 &&
     +		echo "c01f" >expect &&
     +		get_first_changed_path_filter >actual &&
    -+		test_cmp expect actual)
    ++		test_cmp expect actual
    ++	)
     +'
     +
     +test_expect_success 'version 2 changed-path used when version 2 requested' '
    -+	(cd highbit2 &&
    -+		test_bloom_filters_used "-- $CENT")
    ++	(
    ++		cd highbit2 &&
    ++		test_bloom_filters_used "-- $CENT"
    ++	)
     +'
     +
     +test_expect_success 'version 2 changed-path not used when version 1 requested' '
    -+	(cd highbit2 &&
    ++	(
    ++		cd highbit2 &&
     +		git config --add commitgraph.changedPathsVersion 1 &&
    -+		test_bloom_filters_not_used "-- $CENT")
    ++		test_bloom_filters_not_used "-- $CENT"
    ++	)
     +'
     +
     +test_expect_success 'version 2 changed-path used when autodetect requested' '
    -+	(cd highbit2 &&
    ++	(
    ++		cd highbit2 &&
     +		git config --add commitgraph.changedPathsVersion -1 &&
    -+		test_bloom_filters_used "-- $CENT")
    ++		test_bloom_filters_used "-- $CENT"
    ++	)
     +'
     +
     +test_expect_success 'when writing another commit graph, preserve existing version 2 of changed-path' '
     +	test_commit -C highbit2 c2double "$CENT$CENT" &&
     +	git -C highbit2 commit-graph write --reachable --changed-paths &&
    -+	(cd highbit2 &&
    ++	(
    ++		cd highbit2 &&
     +		git config --add commitgraph.changedPathsVersion -1 &&
     +		echo "options: bloom(2,10,7) read_generation_data" >expect &&
     +		test-tool read-graph >full &&
     +		grep options full >actual &&
    -+		test_cmp expect actual)
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success 'when writing commit graph, do not reuse changed-path of another version' '
    ++	git init doublewrite &&
    ++	test_commit -C doublewrite c "$CENT" &&
    ++	git -C doublewrite config --add commitgraph.changedPathsVersion 1 &&
    ++	git -C doublewrite commit-graph write --reachable --changed-paths &&
    ++	git -C doublewrite config --add commitgraph.changedPathsVersion 2 &&
    ++	git -C doublewrite commit-graph write --reachable --changed-paths &&
    ++	(
    ++		cd doublewrite &&
    ++		echo "c01f" >expect &&
    ++		get_first_changed_path_filter >actual &&
    ++		test_cmp expect actual
    ++	)
     +'
     +
      test_done
-- 
2.41.0.585.gd2178a4bd4-goog

