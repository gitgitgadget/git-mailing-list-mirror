Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A700CD8CB4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjJJUdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJJUdY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:33:24 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E751691
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:19 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d0169cf43so2878456d6.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696969999; x=1697574799; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t9VZ90NPnGn9DcgX7NoYdFYCukQetWbgiZMgeKkRXSE=;
        b=om4IEPui5QbbILC5VS3QMr/aqN1ThOKwng2VGdT+INXGHBjZOswGzX+v8g95k6S0GG
         xWdNQTpQ6YdTmt/30gJ4suT8VxKlSEvnrqpkDETrAG8QJqSQJibm/rs4/oqZJzMFpJjQ
         +zPLAF8eXsSwFO6deqBCAC5rcu4dMhkMHw1KcnXBoM1mx3dNYiSy+ZCM7Wq+LsWrS6Dz
         +ACd4oXTrUcNuBTDgMCKjoZoQP2ekjYoqWWueE7neyKk1zjLWmKNnqd7gPcMBF4KBZZ5
         Sc+Q+fJTmy1l61SqU9IoAO5Genu3NHn0VyQc+yG91uN/L08Ex79a+0SzWgrHXJSY3b+y
         nNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969999; x=1697574799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9VZ90NPnGn9DcgX7NoYdFYCukQetWbgiZMgeKkRXSE=;
        b=xLRYPR7gLaIaqhi1kMbumuEZzivp4E9OdkwqCQGC7Jza10WIc0SBy1F3by3c2XN+Ys
         kkipKlUoTr7XeomMJj4FqIOj11tQO5uhE8NFCq6iRDdvQ+bi3CGeQFhS7qsamE9xvVSe
         GNk/tiWVLBpHHcZxM/ZSozHAVHgY+SXO2EdUhP6vLCNMwyxgkVk+DB1wf34dH9qQlWUY
         hOKiSnISxL75wqWXpPpzEHXktJaQF2rnpj/vZUlyqIuwPbsL0htw9yTWzk0MfjiBX9MY
         ZFdeJGrM0vdvdtRhLGkHeJ5lqiVZmuEW9uuFHcWn5EsChs86ZntfmBUhjEQNnoWWmIs6
         wnEw==
X-Gm-Message-State: AOJu0YyAeyYxPlPMKq3q6scZNJGmmKVzb+UIu00VwIhG2zDcePM35LyO
        QHr7r3cDyfXnF19kgE4NglSnzSMqPePzghTGt8EKrg==
X-Google-Smtp-Source: AGHT+IHrl8AiAMveRy77VEw1+EppyixlScQYjvomDtzmguh3OGuIwIBjraN0DL7ksmzMZ5hOS2KTQQ==
X-Received: by 2002:a0c:e30d:0:b0:66d:343:3512 with SMTP id s13-20020a0ce30d000000b0066d03433512mr632539qvl.63.1696969998756;
        Tue, 10 Oct 2023 13:33:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bu7-20020ad455e7000000b0066cf48df24dsm799851qvb.13.2023.10.10.13.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:33:18 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:33:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 00/17] bloom: changed-path Bloom filters v2 (& sundries)
Message-ID: <cover.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Rebased onto the tip of 'master', which is 3a06386e31 (The fifteenth
batch, 2023-10-04), at the time of writing).

This series is a reroll of the combined efforts of [1] and [2] to
introduce the v2 changed-path Bloom filters, which fixes a bug in our
existing implementation of murmur3 paths with non-ASCII characters (when
the "char" type is signed).

In large part, this is the same as the previous round. But this round
includes some extra bits that address issues pointed out by SZEDER
Gábor, which are:

  - not reading Bloom filters for root commits
  - corrupting Bloom filter reads by tweaking the filter settings
    between layers.

These issues were discussed in (among other places) [3], and [4],
respectively.

Thanks to Jonathan, Peff, and SZEDER who have helped a great deal in
assembling these patches. As usual, a range-diff is included below.
Thanks in advance for your
review!

[1]: https://lore.kernel.org/git/cover.1684790529.git.jonathantanmy@google.com/
[2]: https://lore.kernel.org/git/cover.1691426160.git.me@ttaylorr.com/
[3]: https://public-inbox.org/git/20201015132147.GB24954@szeder.dev/
[4]: https://lore.kernel.org/git/20230830200218.GA5147@szeder.dev/

Jonathan Tan (4):
  gitformat-commit-graph: describe version 2 of BDAT
  t4216: test changed path filters with high bit paths
  repo-settings: introduce commitgraph.changedPathsVersion
  commit-graph: new filter ver. that fixes murmur3

Taylor Blau (13):
  t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
  revision.c: consult Bloom filters for root commits
  commit-graph: ensure Bloom filters are read with consistent settings
  t/helper/test-read-graph.c: extract `dump_graph_info()`
  bloom.h: make `load_bloom_filter_from_graph()` public
  t/helper/test-read-graph: implement `bloom-filters` mode
  bloom: annotate filters with hash version
  bloom: prepare to discard incompatible Bloom filters
  commit-graph.c: unconditionally load Bloom filters
  commit-graph: drop unnecessary `graph_read_bloom_data_context`
  object.h: fix mis-aligned flag bits table
  commit-graph: reuse existing Bloom filters where possible
  bloom: introduce `deinit_bloom_filters()`

 Documentation/config/commitgraph.txt     |  26 ++-
 Documentation/gitformat-commit-graph.txt |   9 +-
 bloom.c                                  | 208 ++++++++++++++++-
 bloom.h                                  |  38 +++-
 commit-graph.c                           |  61 ++++-
 object.h                                 |   3 +-
 oss-fuzz/fuzz-commit-graph.c             |   2 +-
 repo-settings.c                          |   6 +-
 repository.h                             |   2 +-
 revision.c                               |  26 ++-
 t/helper/test-bloom.c                    |   9 +-
 t/helper/test-read-graph.c               |  67 ++++--
 t/t0095-bloom.sh                         |   8 +
 t/t4216-log-bloom.sh                     | 272 ++++++++++++++++++++++-
 14 files changed, 682 insertions(+), 55 deletions(-)

Range-diff against v2:
10:  002a06d1e9 !  1:  fe671d616c t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
    @@ Commit message
         indicating that no filters were used.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## t/t4216-log-bloom.sh ##
     @@ t/t4216-log-bloom.sh: test_bloom_filters_used () {
 -:  ---------- >  2:  7d0fa93543 revision.c: consult Bloom filters for root commits
 -:  ---------- >  3:  2ecc0a2d58 commit-graph: ensure Bloom filters are read with consistent settings
 1:  5fa681b58e !  4:  17703ed89a gitformat-commit-graph: describe version 2 of BDAT
    @@ Commit message
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## Documentation/gitformat-commit-graph.txt ##
     @@ Documentation/gitformat-commit-graph.txt: All multi-byte numbers are in network byte order.
 2:  623d840575 !  5:  94552abf45 t/helper/test-read-graph.c: extract `dump_graph_info()`
    @@ Commit message
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## t/helper/test-read-graph.c ##
     @@
 3:  bc9d77ae60 !  6:  3d81efa27b bloom.h: make `load_bloom_filter_from_graph()` public
    @@ Commit message
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## bloom.c ##
     @@ bloom.c: static inline unsigned char get_bitmask(uint32_t pos)
 4:  ac7008aed3 !  7:  d23cd89037 t/helper/test-read-graph: implement `bloom-filters` mode
    @@ Commit message
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## t/helper/test-read-graph.c ##
     @@ t/helper/test-read-graph.c: static void dump_graph_info(struct commit_graph *graph)
    @@ t/helper/test-read-graph.c: int cmd__read_graph(int argc UNUSED, const char **ar
     -	return 0;
     +	return ret;
      }
    ++
    ++
 5:  71755ba856 !  8:  cba766f224 t4216: test changed path filters with high bit paths
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## t/t4216-log-bloom.sh ##
    -@@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills empty commits' '
    - 	)
    +@@ t/t4216-log-bloom.sh: test_expect_success 'merge graph layers with incompatible Bloom settings' '
    + 	! grep "disabling Bloom filters" err
      '
      
     +get_first_changed_path_filter () {
 6:  9768d92c0f !  9:  a08a961f41 repo-settings: introduce commitgraph.changedPathsVersion
    @@ Commit message
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## Documentation/config/commitgraph.txt ##
     @@ Documentation/config/commitgraph.txt: commitGraph.maxNewFilters::
 7:  f911b4bfab = 10:  61d44519a5 commit-graph: new filter ver. that fixes murmur3
 8:  35009900df ! 11:  a8c10f8de8 bloom: annotate filters with hash version
    @@ Commit message
         Bloom filter.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## bloom.c ##
     @@ bloom.c: int load_bloom_filter_from_graph(struct commit_graph *g,
 9:  138bc16905 ! 12:  2ba10a4b4b bloom: prepare to discard incompatible Bloom filters
    @@ Commit message
         `get_or_compute_bloom_filter()`.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## bloom.c ##
     @@ bloom.c: static void init_truncated_large_filter(struct bloom_filter *filter,
11:  2437e62813 ! 13:  09d8669c3a commit-graph.c: unconditionally load Bloom filters
    @@ Commit message
         either "1" or "2".
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## commit-graph.c ##
     @@ commit-graph.c: static int graph_read_bloom_data(const unsigned char *chunk_start,
12:  fe8fb2f5fe ! 14:  0d4f9dc4ee commit-graph: drop unnecessary `graph_read_bloom_data_context`
    @@ Commit message
     
         Noticed-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## commit-graph.c ##
     @@ commit-graph.c: static int graph_read_oid_lookup(const unsigned char *chunk_start,
13:  825af91e11 ! 15:  1f7f27bc47 object.h: fix mis-aligned flag bits table
    @@ Commit message
         Bit position 23 is one column too far to the left.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## object.h ##
     @@ object.h: void object_array_init(struct object_array *array);
14:  593b317192 ! 16:  abbef95ae8 commit-graph: reuse existing Bloom filters where possible
    @@ Commit message
           commits by their generation number.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## bloom.c ##
     @@
15:  8bf2c9cf98 = 17:  ca362408d5 bloom: introduce `deinit_bloom_filters()`
-- 
2.42.0.342.g8bb3a896ee
