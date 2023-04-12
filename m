Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B98C77B6C
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 22:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDLWUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 18:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjDLWUm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 18:20:42 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F3F4C1F
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:32 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54f64b29207so138893007b3.8
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681338032; x=1683930032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PZjs8syBbXW9mbGiXsnmClVcRhYNSEc8yV+7PpNIur0=;
        b=3sChyL6NSX9ECuGX8k7s6CeUgdAGgeb5ZmSUx6O1NYWuXQ3Qrx/nYx9ULC3qBUceZ/
         muakWfnL83/n7b6B+QUFoxDZpEdBVp2kH8WBP2f45gpEczDW9KdWE7qfa4uxnnqzKsy5
         ebrhP9nk45mczF/9kxrEkXvZTpwf01RuaYKC2+g7brzUdMoCkfNgAabejtIwSibyvOyq
         yBwt2RQtdzUGbJuZRYw3TKu6cSJv+ACk39NDFblWCCETqAoJfv/fMUhQUIRtwNrgWg3r
         hEs0XdeUIzorY4Cjca8ewQKew21HxGr/SqyIoaQLkfdnl9E5B50RiYFGKSRtQ8khw9vc
         LbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681338032; x=1683930032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZjs8syBbXW9mbGiXsnmClVcRhYNSEc8yV+7PpNIur0=;
        b=WmEC5UEtd/JwAczr35q1OXLBILKXY9TXJl/lEhNLm1VYC1x7OKpwUttSFJtAZ3fyU4
         967KPoVE61r89LovLtLFolhISwPAoBBCcsv2r8qkFh4vgi+cR6IFdfPdKGcWTTmppfz6
         IXdWxn1RiunLd2YZi7mSyrL5YSimos3JZ7ETRK3vzNh7J2nqC7Zssy0l9zMIsRlyTsBt
         u2x5jVSrnkRMCMPalicR0tf7wz6+zEfPjCxPXw5g0DXS5Ujg9S0MhSz7kbAaDSjWDN/J
         dyob+e+0N+72924S5MxnvhGNGCGEvnJJJHTwc/11wkLsZyBunOCcvQd/9eeg9hmEUoH4
         c2SA==
X-Gm-Message-State: AAQBX9de5olhAtiqYcZ6dVTQ4GrGfI+RZhKdffleZBm8EGwxxhY+wgAA
        uzXl6OfOL22LIwFSx2iQqkD4ctE2hM7dzN5xn+cEBw==
X-Google-Smtp-Source: AKy350bGFN7FvOYSEk21Bssj4IpN+66IIzEf0DzN0shR4bzxpXygaz8Gv0qhKFnmHQ1PFFZQbgx1rg==
X-Received: by 2002:a0d:e843:0:b0:544:77f1:a0f3 with SMTP id r64-20020a0de843000000b0054477f1a0f3mr67986ywe.37.1681338031692;
        Wed, 12 Apr 2023 15:20:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ce1-20020a05690c098100b0054fa9e39be0sm18637ywb.56.2023.04.12.15.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:20:31 -0700 (PDT)
Date:   Wed, 12 Apr 2023 18:20:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/7] pack-revindex: introduce `pack.readReverseIndex`
Message-ID: <a62fc3e4ec1aca773b6c3e47828db235df53c747.1681338013.git.me@ttaylorr.com>
References: <cover.1681166596.git.me@ttaylorr.com>
 <cover.1681338013.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1681338013.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 1615c567b8 (Documentation/config/pack.txt: advertise
'pack.writeReverseIndex', 2021-01-25), we have had the
`pack.writeReverseIndex` configuration option, which tells Git whether
or not it is allowed to write a ".rev" file when indexing a pack.

Introduce a complementary configuration knob, `pack.readReverseIndex` to
control whether or not Git will read any ".rev" file(s) that may be
available on disk.

This option is useful for debugging, as well as disabling the effect of
".rev" files in certain instances.

This is useful because of the trade-off[^1] between the time it takes to
generate a reverse index (slow from scratch, fast when reading an
existing ".rev" file), and the time it takes to access a record (the
opposite).

For example, even though it is faster to use the on-disk reverse index
when computing the on-disk size of a packed object, it is slower to
enumerate the same value for all objects.

Here are a couple of examples from linux.git. When computing the above
for a single object, using the on-disk reverse index is significantly
faster:

    $ git rev-parse HEAD >in
    $ hyperfine -L v false,true 'git.compile -c pack.readReverseIndex={v} cat-file --batch-check="%(objectsize:disk)" <in'
    Benchmark 1: git.compile -c pack.readReverseIndex=false cat-file --batch-check="%(objectsize:disk)" <in
      Time (mean ± σ):     302.5 ms ±  12.5 ms    [User: 258.7 ms, System: 43.6 ms]
      Range (min … max):   291.1 ms … 328.1 ms    10 runs

    Benchmark 2: git.compile -c pack.readReverseIndex=true cat-file --batch-check="%(objectsize:disk)" <in
      Time (mean ± σ):       3.9 ms ±   0.3 ms    [User: 1.6 ms, System: 2.4 ms]
      Range (min … max):     2.0 ms …   4.4 ms    801 runs

    Summary
      'git.compile -c pack.readReverseIndex=true cat-file --batch-check="%(objectsize:disk)" <in' ran
       77.29 ± 7.14 times faster than 'git.compile -c pack.readReverseIndex=false cat-file --batch-check="%(objectsize:disk)" <in'

, but when instead trying to compute the on-disk object size for all
objects in the repository, using the ".rev" file is a disadvantage over
creating the reverse index from scratch:

    $ hyperfine -L v false,true 'git.compile -c pack.readReverseIndex={v} cat-file --batch-check="%(objectsize:disk)" --batch-all-objects'
    Benchmark 1: git.compile -c pack.readReverseIndex=false cat-file --batch-check="%(objectsize:disk)" --batch-all-objects
      Time (mean ± σ):      8.258 s ±  0.035 s    [User: 7.949 s, System: 0.308 s]
      Range (min … max):    8.199 s …  8.293 s    10 runs

    Benchmark 2: git.compile -c pack.readReverseIndex=true cat-file --batch-check="%(objectsize:disk)" --batch-all-objects
      Time (mean ± σ):     16.976 s ±  0.107 s    [User: 16.706 s, System: 0.268 s]
      Range (min … max):   16.839 s … 17.105 s    10 runs

    Summary
      'git.compile -c pack.readReverseIndex=false cat-file --batch-check="%(objectsize:disk)" --batch-all-objects' ran
	2.06 ± 0.02 times faster than 'git.compile -c pack.readReverseIndex=true cat-file --batch-check="%(objectsize:disk)" --batch-all-objects'

Luckily, the results when running `git cat-file` with `--unordered` are
closer together:

    $ hyperfine -L v false,true 'git.compile -c pack.readReverseIndex={v} cat-file --unordered --batch-check="%(objectsize:disk)" --batch-all-objects'
    Benchmark 1: git.compile -c pack.readReverseIndex=false cat-file --unordered --batch-check="%(objectsize:disk)" --batch-all-objects
      Time (mean ± σ):      5.066 s ±  0.105 s    [User: 4.792 s, System: 0.274 s]
      Range (min … max):    4.943 s …  5.220 s    10 runs

    Benchmark 2: git.compile -c pack.readReverseIndex=true cat-file --unordered --batch-check="%(objectsize:disk)" --batch-all-objects
      Time (mean ± σ):      6.193 s ±  0.069 s    [User: 5.937 s, System: 0.255 s]
      Range (min … max):    6.145 s …  6.356 s    10 runs

    Summary
      'git.compile -c pack.readReverseIndex=false cat-file --unordered --batch-check="%(objectsize:disk)" --batch-all-objects' ran
        1.22 ± 0.03 times faster than 'git.compile -c pack.readReverseIndex=true cat-file --unordered --batch-check="%(objectsize:disk)" --batch-all-objects'

Because the equilibrium point between these two is highly machine- and
repository-dependent, allow users to configure whether or not they will
read any ".rev" file(s) with this configuration knob.

[^1]: Generating a reverse index in memory takes O(N) time (where N is
  the number of objects in the repository), since we use a radix sort.
  Reading an entry from an on-disk ".rev" file is slower since each
  operation is bound by disk I/O instead of memory I/O.

  In order to compute the on-disk size of a packed object, we need to
  find the offset of our object, and the adjacent object (the on-disk
  size difference of these two). Finding the first offset requires a
  binary search. Finding the latter involves a single .rev lookup.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/pack.txt |  6 ++++++
 pack-revindex.c               |  5 ++++-
 repo-settings.c               |  1 +
 repository.h                  |  1 +
 t/t5325-reverse-index.sh      | 11 +++++++++++
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 53093d99969..7db7fed4667 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -171,6 +171,12 @@ pack.writeBitmapLookupTable::
 	beneficial in repositories that have relatively large bitmap
 	indexes. Defaults to false.
 
+pack.readReverseIndex::
+	When true, git will read any .rev file(s) that may be available
+	(see: linkgit:gitformat-pack[5]). When false, the reverse index
+	will be generated from scratch and stored in memory. Defaults to
+	true.
+
 pack.writeReverseIndex::
 	When true, git will write a corresponding .rev file (see:
 	linkgit:gitformat-pack[5])
diff --git a/pack-revindex.c b/pack-revindex.c
index 44e1b3fed95..29f5358b256 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -291,7 +291,10 @@ int load_pack_revindex(struct repository *r, struct packed_git *p)
 	if (p->revindex || p->revindex_data)
 		return 0;
 
-	if (!load_pack_revindex_from_disk(p))
+	prepare_repo_settings(r);
+
+	if (r->settings.pack_read_reverse_index &&
+	    !load_pack_revindex_from_disk(p))
 		return 0;
 	else if (!create_pack_revindex_in_memory(p))
 		return 0;
diff --git a/repo-settings.c b/repo-settings.c
index 0a6c0b381fe..bdd7640ab0b 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -63,6 +63,7 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
 	repo_cfg_bool(r, "index.skiphash", &r->settings.index_skip_hash, r->settings.index_skip_hash);
+	repo_cfg_bool(r, "pack.readreverseindex", &r->settings.pack_read_reverse_index, 1);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
diff --git a/repository.h b/repository.h
index 15a8afc5fb5..ed73e799b61 100644
--- a/repository.h
+++ b/repository.h
@@ -37,6 +37,7 @@ struct repo_settings {
 	int fetch_write_commit_graph;
 	int command_requires_full_index;
 	int sparse_index;
+	int pack_read_reverse_index;
 
 	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
 
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 48c14d85764..66171c1d67b 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -96,6 +96,17 @@ test_expect_success 'reverse index is not generated when available on disk' '
 		--batch-check="%(objectsize:disk)" <tip
 '
 
+test_expect_success 'reverse index is ignored when pack.readReverseIndex is false' '
+	test_index_pack true &&
+	test_path_is_file $rev &&
+
+	test_config pack.readReverseIndex false &&
+
+	git rev-parse HEAD >tip &&
+	GIT_TEST_REV_INDEX_DIE_ON_DISK=1 git cat-file \
+		--batch-check="%(objectsize:disk)" <tip
+'
+
 test_expect_success 'revindex in-memory vs on-disk' '
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
-- 
2.40.0.323.gedff6a80c63

