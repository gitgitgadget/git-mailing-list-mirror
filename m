Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ADF42BE7
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="l57vRbOq"
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5847F11A
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:29 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d0169cf43so45631066d6.3
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653948; x=1698258748; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NnawPX1cUNqKIUDGmMG8hqTuA6w5A7JU0lhnd+7QiFI=;
        b=l57vRbOq0/OP5edtS3lvdboLjj8ux6VUK2H3SiSj5DjAhecMUsl34fxx01tKmogp/j
         K3V775GsEFjN+01WSO210AHFKtViBnMHpn913hUfAAfIpRcdimkPDA2Ig+1KV8Hyvvav
         5kAg0du8TaetZavMWBPaNNX1kuYFTssOkWvWvFN08rRgwT+/5qtj6AkLOfcakJGEZP55
         v8r+U9XPXLIGlOkT+E3FtmqU75i9FZvX98IKX2AuKP3znJVLnPAEapJVt2OFr7nfYxv6
         +hJQkCfpL4Y/kPOt5Desgk2DUuDuFnTr9V2UgHRv7Hf0D/wmMXWfVQTF83SUsBc7TRRE
         xG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653948; x=1698258748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnawPX1cUNqKIUDGmMG8hqTuA6w5A7JU0lhnd+7QiFI=;
        b=b66m4LwNNcMoTrQ0R/yR1n+KTqhEm11XMAhcbvqz5aStQ6cfNK0l25QLB26jwe8nBK
         S5QbNcmxMssOkRi2XwkL4tV/I+MFOXMlbHc0VoUgBFew07zTWmFfbPwp0IYWYPHykN3U
         UK0m/tE96rMtaA1tLnOuKXW/sbEUh46QC560OD0fsZgq6GrHuPqTih43NksUrG20suPz
         ZGLWJtH4zwLav6qdMibPaT6hV434Pu6myd0QJaiyfidua57gFqO7njYdPLquHDPyw4uP
         7ApPW6pxEhgQ4FLT8gEe0u9hBBThSAE1ETNlEURIhM7uB1w0/XiWc9AFk9FDgYwcUfak
         8yKw==
X-Gm-Message-State: AOJu0YzJsU5hBJnFS55Yh6fgs924qv6wMClEspSNTeJM6ZQaXqkoXyE9
	1vlcV2wwpB3Eqysl555k7OjTOWwfC0hbI2z1IUtExA==
X-Google-Smtp-Source: AGHT+IH04x5B0WJvM/btmqKtR+lYqAxqPfLeAc5W0vaRSNnh5kUF0MQEHZwPoNkKJIlA+lFvGgILkQ==
X-Received: by 2002:a05:6214:5085:b0:668:7b47:dc96 with SMTP id kk5-20020a056214508500b006687b47dc96mr70343qvb.42.1697653947922;
        Wed, 18 Oct 2023 11:32:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e13-20020ad450cd000000b0065cffe12ae9sm151510qvq.36.2023.10.18.11.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:32:27 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:32:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/17] bloom: changed-path Bloom filters v2 (& sundries)
Message-ID: <cover.1697653929.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696629697.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 bloom.h                                  |  38 ++-
 commit-graph.c                           |  61 ++++-
 object.h                                 |   3 +-
 oss-fuzz/fuzz-commit-graph.c             |   2 +-
 repo-settings.c                          |   6 +-
 repository.h                             |   2 +-
 revision.c                               |  26 ++-
 t/helper/test-bloom.c                    |   9 +-
 t/helper/test-read-graph.c               |  67 ++++--
 t/t0095-bloom.sh                         |   8 +
 t/t4216-log-bloom.sh                     | 282 ++++++++++++++++++++++-
 14 files changed, 692 insertions(+), 55 deletions(-)

Range-diff against v3:
 1:  fe671d616c =  1:  e0fc51c3fb t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
 2:  7d0fa93543 =  2:  87b09e6266 revision.c: consult Bloom filters for root commits
 3:  2ecc0a2d58 !  3:  46d8a41005 commit-graph: ensure Bloom filters are read with consistent settings
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills empty comm
     +	done
     +'
     +
    -+test_expect_success 'split' '
    ++test_expect_success 'ensure incompatible Bloom filters are ignored' '
     +	# Compute Bloom filters with "unusual" settings.
     +	git -C $repo rev-parse one >in &&
     +	GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=3 git -C $repo commit-graph write \
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills empty comm
     +
     +test_expect_success 'merge graph layers with incompatible Bloom settings' '
     +	# Ensure that incompatible Bloom filters are ignored when
    -+	# generating new layers.
    ++	# merging existing layers.
     +	git -C $repo commit-graph write --reachable --changed-paths 2>err &&
     +	grep "disabling Bloom filters for commit-graph layer .$layer." err &&
     +
     +	test_path_is_file $repo/$graph &&
     +	test_dir_is_empty $repo/$graphdir &&
     +
    -+	# ...and merging existing ones.
    -+	git -C $repo -c core.commitGraph=false log --oneline --no-decorate -- file \
    -+		>expect 2>err &&
    -+	GIT_TRACE2_PERF="$(pwd)/trace.perf" \
    ++	git -C $repo -c core.commitGraph=false log --oneline --no-decorate -- \
    ++		file >expect &&
    ++	trace_out="$(pwd)/trace.perf" &&
    ++	GIT_TRACE2_PERF="$trace_out" \
     +		git -C $repo log --oneline --no-decorate -- file >actual 2>err &&
     +
    -+	test_cmp expect actual && cat err &&
    -+	grep "statistics:{\"filter_not_present\":0" trace.perf &&
    -+	! grep "disabling Bloom filters" err
    ++	test_cmp expect actual &&
    ++	grep "statistics:{\"filter_not_present\":0," trace.perf &&
    ++	test_must_be_empty err
     +'
     +
      test_done
 4:  17703ed89a =  4:  4d0190a992 gitformat-commit-graph: describe version 2 of BDAT
 5:  94552abf45 =  5:  3c2057c11c t/helper/test-read-graph.c: extract `dump_graph_info()`
 6:  3d81efa27b =  6:  e002e35004 bloom.h: make `load_bloom_filter_from_graph()` public
 7:  d23cd89037 =  7:  c7016f51cd t/helper/test-read-graph: implement `bloom-filters` mode
 8:  cba766f224 !  8:  cef2aac8ba t4216: test changed path filters with high bit paths
    @@ Commit message
     
      ## t/t4216-log-bloom.sh ##
     @@ t/t4216-log-bloom.sh: test_expect_success 'merge graph layers with incompatible Bloom settings' '
    - 	! grep "disabling Bloom filters" err
    + 	test_must_be_empty err
      '
      
     +get_first_changed_path_filter () {
    @@ t/t4216-log-bloom.sh: test_expect_success 'merge graph layers with incompatible
     +	(
     +		cd highbit1 &&
     +		echo "52a9" >expect &&
    -+		get_first_changed_path_filter >actual &&
    -+		test_cmp expect actual
    ++		get_first_changed_path_filter >actual
     +	)
     +'
     +
 9:  a08a961f41 =  9:  36d4e2202e repo-settings: introduce commitgraph.changedPathsVersion
10:  61d44519a5 ! 10:  f6ab427ead commit-graph: new filter ver. that fixes murmur3
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +	test_commit -C doublewrite c "$CENT" &&
     +	git -C doublewrite config --add commitgraph.changedPathsVersion 1 &&
     +	git -C doublewrite commit-graph write --reachable --changed-paths &&
    ++	for v in -2 3
    ++	do
    ++		git -C doublewrite config --add commitgraph.changedPathsVersion $v &&
    ++		git -C doublewrite commit-graph write --reachable --changed-paths 2>err &&
    ++		cat >expect <<-EOF &&
    ++		warning: attempting to write a commit-graph, but ${SQ}commitgraph.changedPathsVersion${SQ} ($v) is not supported
    ++		EOF
    ++		test_cmp expect err || return 1
    ++	done &&
     +	git -C doublewrite config --add commitgraph.changedPathsVersion 2 &&
     +	git -C doublewrite commit-graph write --reachable --changed-paths &&
     +	(
11:  a8c10f8de8 = 11:  dc69b28329 bloom: annotate filters with hash version
12:  2ba10a4b4b = 12:  85dbdc4ed2 bloom: prepare to discard incompatible Bloom filters
13:  09d8669c3a = 13:  3ff669a622 commit-graph.c: unconditionally load Bloom filters
14:  0d4f9dc4ee = 14:  1c78e3d178 commit-graph: drop unnecessary `graph_read_bloom_data_context`
15:  1f7f27bc47 = 15:  a289514faa object.h: fix mis-aligned flag bits table
16:  abbef95ae8 ! 16:  6a12e39e7f commit-graph: reuse existing Bloom filters where possible
    @@ t/t4216-log-bloom.sh: test_expect_success 'when writing another commit graph, pr
      	test_commit -C doublewrite c "$CENT" &&
     +
      	git -C doublewrite config --add commitgraph.changedPathsVersion 1 &&
    --	git -C doublewrite commit-graph write --reachable --changed-paths &&
     +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
     +		git -C doublewrite commit-graph write --reachable --changed-paths &&
     +	test_filter_computed 1 trace2.txt &&
     +	test_filter_upgraded 0 trace2.txt &&
    ++
    + 	git -C doublewrite commit-graph write --reachable --changed-paths &&
    + 	for v in -2 3
    + 	do
    +@@ t/t4216-log-bloom.sh: test_expect_success 'when writing commit graph, do not reuse changed-path of ano
    + 		EOF
    + 		test_cmp expect err || return 1
    + 	done &&
     +
      	git -C doublewrite config --add commitgraph.changedPathsVersion 2 &&
     -	git -C doublewrite commit-graph write --reachable --changed-paths &&
17:  ca362408d5 ! 17:  8942f205c8 bloom: introduce `deinit_bloom_filters()`
    @@ bloom.h: void add_key_to_filter(const struct bloom_key *key,
      	BLOOM_NOT_COMPUTED = (1 << 0),
     
      ## commit-graph.c ##
    -@@ commit-graph.c: static void close_commit_graph_one(struct commit_graph *g)
    +@@ commit-graph.c: struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
      void close_commit_graph(struct raw_object_store *o)
      {
    - 	close_commit_graph_one(o->commit_graph);
    + 	clear_commit_graph_data_slab(&commit_graph_data_slab);
     +	deinit_bloom_filters();
    + 	free_commit_graph(o->commit_graph);
      	o->commit_graph = NULL;
      }
    - 
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      
      	res = write_commit_graph_file(ctx);
-- 
2.42.0.415.g8942f205c8
