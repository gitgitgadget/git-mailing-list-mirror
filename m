Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938C2C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 14:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4677020748
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 14:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE7zzEwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgHQOEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgHQOEx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 10:04:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A83AC061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 07:04:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g8so13327791wmk.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YbpkcjOXbLq6TThTYDxbUMm+aqdOZrJw0a0EioCQM40=;
        b=QE7zzEwhJNOkZ7SLzRMQqj4fFw+KjvPXcbty3SUz5rQvHAiZRn/+AhKmjsd/ZGnaJs
         72w2aeKSUdx7ch6ozNQrOHnF7Qou41UETw4B4j/xbHCFmSZvs1xguCy5jAMvjJ1u4ecI
         KyDUt58Aq+I5+fLnDbpAxwhZTyZhuNngddu7L3TuIyzR9F8p93/8bRl/NyV0xa5CaLp9
         zmsJ4bdnwVu/oce3GGlxhjxFCQxCxquTliKhhQEUpJ7QKgHlT31i/pjlUWFnBmdQod8A
         uwIY4Syij+/9hLpqsgOkVmSaqkhNpvDwV2gzFUmn3gkfhMv5VcVbfr5gcAEdX+dV3Kvo
         8msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YbpkcjOXbLq6TThTYDxbUMm+aqdOZrJw0a0EioCQM40=;
        b=NW9z2YIpe5bNfPGB0MY6zPlnDEGk0LxwPOJq8WH3Ym3LFtV1+5ITNJyziH8qvH+TJ/
         gV94y29kMp65AxoNFWsVpOGQoFn12sze+iz+M+GtY8uwSd/UmTffPak9yzyHCZVoWZNg
         I19OmCIeON9ObHRSIXNNXyUCAKKkQY2FeohcGLo/AGcL9qO1PRIMtDONSrYowqQdSdl2
         R3ti+661MelCkgLn3ZVN33sfr2PKAR1rIAl7GoekfuonuDicmJ1eU2fL2wcYP18CuNXh
         F6M4vkGSGTmPwWuhmGbEPbbIXdjRERjS4tChVHfshRvatUbinSC+4T27DINpL81/IYdC
         ZFrA==
X-Gm-Message-State: AOAM532sGX3qvo5SmoONhSf5LUDDP3jF1i0S9YRFtjsc2WZibhLXvgiO
        6lMgw/o+g1zHoHkNhkeJlC/80qXuZAM=
X-Google-Smtp-Source: ABdhPJw6pYCrevmGBFJgiveQN7swO+mmIqe+Ut7MudAMqvEMcGssoN3ytk58LgS4ciS2ldC08noOtg==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr15178018wmd.147.1597673090933;
        Mon, 17 Aug 2020 07:04:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14sm29766876wme.16.2020.08.17.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:04:50 -0700 (PDT)
Message-Id: <pull.703.v2.git.1597673089.gitgitgadget@gmail.com>
In-Reply-To: <pull.703.git.1597428440.gitgitgadget@gmail.com>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 14:04:45 +0000
Subject: [PATCH v2 0/3] SHA-256: Update commit-graph and multi-pack-index formats
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, sandals@crustytoothpaste.net,
        me@ttaylorr.com, abhishekkumar8222@gmail.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed [1], there is some concern around binary file formats requiring
the context of the repository config in order to infer hash lengths. Two
formats that were designed with the hash transition in mind (commit-graph
and multi-pack-index) have bytes available to indicate the hash algorithm
used. Let's actually update these formats to be more self-contained with the
two hash algorithms being available.

[1] 
https://lore.kernel.org/git/CAN0heSp024=Kyy7gdQ2VSetk_5iVhj_qdT8CMVPcry_AwWrhHQ@mail.gmail.com/

This merges cleanly with tb/bloom-improvements, but both that branch and
this patch series have merge conflicts with the corrected commit date patch
series [2].

[2] 
https://lore.kernel.org/git/pull.676.v2.git.1596941624.gitgitgadget@gmail.com/

In particular, the following conflict can be resolved in the "obvioius" way:

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< HEAD
    header: 43475048 1 $(test_oid oid_version) 3 $NUM_BASE
================================
    header: 43475048 1 1 4 $NUM_BASE
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> abhishek/corrected_commit_date

Instead use:

    header: 43475048 1 $(test_oid oid_version) 4 $NUM_BASE

But, it also needs the following fix to actually work with this series:

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 211ec625d2..09f133792c 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -464,7 +464,7 @@ test_expect_success 'setup repo for mixed generation commit-graph-chain' '
        GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split=no-merge &&
        test-tool read-graph >output &&
        cat >expect <<-EOF &&
-       header: 43475048 1 1 4 1
+       header: 43475048 1 $(test_oid oid_version) 4 1
        num_commits: 2
        chunks: oid_fanout oid_lookup commit_metadata
        EOF
@@ -482,7 +482,7 @@ test_expect_success 'does not write generation data chunk if not present on exis
        git commit-graph write --reachable --split=no-merge &&
        test-tool read-graph >output &&
        cat >expect <<-EOF &&
-       header: 43475048 1 1 4 2
+       header: 43475048 1 $(test_oid oid_version) 4 2
        num_commits: 3
        chunks: oid_fanout oid_lookup commit_metadata
        EOF

If this is the way we want to go with the formats, then I'll assist
coordinating these textual and semantic merge conflicts.

UPDATES IN V2
=============

 * Documentation is updated, thanks to Eric's suggestion.
 * The implementation of oid_version() and the way we access it in the test
   scripts is improved, thanks to Brian's suggestion.
 * I use "mv" instead of "cp" in the cross-version tests because of a
   subtlety on macOS when overwriting these files.

Thanks, -Stolee

Derrick Stolee (3):
  t/README: document GIT_TEST_DEFAULT_HASH
  commit-graph: use the "hash version" byte
  multi-pack-index: use hash version byte

 .../technical/commit-graph-format.txt         |  9 +++-
 Documentation/technical/pack-format.txt       |  7 ++-
 commit-graph.c                                |  9 +++-
 midx.c                                        | 35 ++++++++++++---
 t/README                                      |  4 ++
 t/helper/test-read-midx.c                     |  8 +++-
 t/t4216-log-bloom.sh                          |  9 +++-
 t/t5318-commit-graph.sh                       | 38 +++++++++++++++-
 t/t5319-multi-pack-index.sh                   | 43 +++++++++++++++++--
 t/t5324-split-commit-graph.sh                 |  5 ++-
 10 files changed, 146 insertions(+), 21 deletions(-)


base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-703%2Fderrickstolee%2Fcommit-graph-256-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-703/derrickstolee/commit-graph-256-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/703

Range-diff vs v1:

 1:  242a44b63c ! 1:  62e7247bad t/README: document GIT_TEST_DEFAULT_HASH
     @@ Metadata
       ## Commit message ##
          t/README: document GIT_TEST_DEFAULT_HASH
      
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## t/README ##
     @@ t/README: GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true (which is
       the default when running tests), errors out when an abbreviated option
       is used.
       
     -+GIT_TEST_DEFAULT_HASH=<sha1|sha256> specifies which hash algorithm to use
     -+in the test scripts.
     ++GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
     ++use in the test scripts. Recognized values for <hash-algo> are "sha1"
     ++and "sha256".
      +
       Naming Tests
       ------------
 2:  4bbfd345d1 ! 2:  8d481f3b22 commit-graph: use the hash version byte
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    commit-graph: use the hash version byte
     +    commit-graph: use the "hash version" byte
      
          The commit-graph format reserved a byte among the header of the file to
          store a "hash version". During the SHA-256 work, this was not modified
     @@ Commit message
          each type then swaps the commit-graph files. The important value here is
          that the "git log" command succeeds while writing a message to stderr.
      
     +    Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/technical/commit-graph-format.txt ##
     @@ commit-graph.c: static char *get_chain_filename(struct object_directory *odb)
       static uint8_t oid_version(void)
       {
      -	return 1;
     -+	if (the_hash_algo->rawsz == GIT_SHA1_RAWSZ)
     ++	switch (hash_algo_by_ptr(the_hash_algo)) {
     ++	case GIT_HASH_SHA1:
      +		return 1;
     -+	if (the_hash_algo->rawsz == GIT_SHA256_RAWSZ)
     ++	case GIT_HASH_SHA256:
      +		return 2;
     -+	die(_("invalid hash version"));
     ++	default:
     ++		die(_("invalid hash version"));
     ++	}
       }
       
       static struct commit_graph *alloc_commit_graph(void)
      
       ## t/t4216-log-bloom.sh ##
     -@@ t/t4216-log-bloom.sh: test_description='git log for a path with Bloom filters'
     - GIT_TEST_COMMIT_GRAPH=0
     - GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
     - 
     -+OID_VERSION=1
     -+if [ "$GIT_DEFAULT_HASH" = "sha256" ]
     -+then
     -+	OID_VERSION=2
     -+fi
     -+
     - test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
     - 	git init &&
     - 	mkdir A A/B A/B/C &&
      @@ t/t4216-log-bloom.sh: test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
     + 	rm file_to_be_deleted &&
     + 	git add . &&
     + 	git commit -m "file removed" &&
     +-	git commit-graph write --reachable --changed-paths
     ++	git commit-graph write --reachable --changed-paths &&
     ++
     ++	test_oid_cache <<-EOF
     ++	oid_version sha1:1
     ++	oid_version sha256:2
     ++	EOF
     + '
       graph_read_expect () {
       	NUM_CHUNKS=5
       	cat >expect <<- EOF
      -	header: 43475048 1 1 $NUM_CHUNKS 0
     -+	header: 43475048 1 $OID_VERSION $NUM_CHUNKS 0
     ++	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
       	num_commits: $1
       	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
       	EOF
      
       ## t/t5318-commit-graph.sh ##
     -@@ t/t5318-commit-graph.sh: test_description='commit graph'
     - 
     - GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
     - 
     -+OID_VERSION=1
     -+if [ "$GIT_DEFAULT_HASH" = "sha256" ]
     -+then
     -+	OID_VERSION=2
     -+fi
     -+
     - test_expect_success 'setup full repo' '
     - 	mkdir full &&
     +@@ t/t5318-commit-graph.sh: test_expect_success 'setup full repo' '
       	cd "$TRASH_DIRECTORY/full" &&
     + 	git init &&
     + 	git config core.commitGraph true &&
     +-	objdir=".git/objects"
     ++	objdir=".git/objects" &&
     ++
     ++	test_oid_cache <<-EOF
     ++	oid_version sha1:1
     ++	oid_version sha256:2
     ++	EOF
     + '
     + 
     + test_expect_success POSIXPERM 'tweak umask for modebit tests' '
      @@ t/t5318-commit-graph.sh: graph_read_expect() {
       		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
       	fi
       	cat >expect <<- EOF
      -	header: 43475048 1 1 $NUM_CHUNKS 0
     -+	header: 43475048 1 $OID_VERSION $NUM_CHUNKS 0
     ++	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
       	num_commits: $1
       	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
       	EOF
     @@ t/t5318-commit-graph.sh: test_expect_success 'replace-objects invalidates commit
       # If the file changes the set of commits in the list, then the
      
       ## t/t5324-split-commit-graph.sh ##
     -@@ t/t5324-split-commit-graph.sh: test_description='split commit graph'
     - GIT_TEST_COMMIT_GRAPH=0
     - GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
     +@@ t/t5324-split-commit-graph.sh: test_expect_success 'setup repo' '
       
     -+OID_VERSION=1
     -+if [ "$GIT_DEFAULT_HASH" = "sha256" ]
     -+then
     -+	OID_VERSION=2
     -+fi
     + 	base sha1:1376
     + 	base sha256:1496
      +
     - test_expect_success 'setup repo' '
     - 	git init &&
     - 	git config core.commitGraph true &&
     ++	oid_version sha1:1
     ++	oid_version sha256:2
     + 	EOM
     + '
     + 
      @@ t/t5324-split-commit-graph.sh: graph_read_expect() {
       		NUM_BASE=$2
       	fi
       	cat >expect <<- EOF
      -	header: 43475048 1 1 3 $NUM_BASE
     -+	header: 43475048 1 $OID_VERSION 3 $NUM_BASE
     ++	header: 43475048 1 $(test_oid oid_version) 3 $NUM_BASE
       	num_commits: $1
       	chunks: oid_fanout oid_lookup commit_metadata
       	EOF
 3:  b4645789ad ! 3:  822e46868f multi-pack-index: use hash version byte
     @@ Commit message
          matches, we change the corrupted byte from "2" to "3" to ensure the test
          fails for both hash algorithms.
      
     +    Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/technical/pack-format.txt ##
     @@ midx.c
       
      +static uint8_t oid_version(void)
      +{
     -+	if (the_hash_algo->rawsz == GIT_SHA1_RAWSZ)
     ++	switch (hash_algo_by_ptr(the_hash_algo)) {
     ++	case GIT_HASH_SHA1:
      +		return 1;
     -+	if (the_hash_algo->rawsz == GIT_SHA256_RAWSZ)
     ++	case GIT_HASH_SHA256:
      +		return 2;
     -+	die(_("invalid hash version"));
     ++	default:
     ++		die(_("invalid hash version"));
     ++	}
      +}
      +
       static char *get_midx_filename(const char *object_dir)

-- 
gitgitgadget
