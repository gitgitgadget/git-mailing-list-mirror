Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D6BC433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 14:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DA620786
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 14:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2m6e7EF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgHQOFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgHQOE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 10:04:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB30C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 07:04:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so15158586wrh.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eSyPRGpdr54hZeIx3MgbzcLSGriiOGrRdkvlFes2oMI=;
        b=o2m6e7EFeqbudB+QPxGYixkx+/oa7RxCCYq37J4w37TjLFrxmD3yMQ9E+EpNGEqhWA
         JAqwPYilMfmOqNEkDC9x26ZeViWRQSCNLTX13t8b8xrGUv/k5ZFeyFmyHfe8HJ+0Pzx8
         fYvaNm8y7SbL/AU1rGue9ZGdiBlUdhUdJOzG6l+EX39w0lkpnprLvNiFrxRmUMLbA7/w
         wQepwlL2lkPAI1rgbm2fhC/4wHtMfGL/LHcdR7oXPS2zyYTAWh5GwuPpJWvmDhgHqMrR
         kGg2epknvCJNkEWzEhyLtmJYPEUkmN0+/FKiwtfsR+wooIX5gmiiu5qgwPtfyUgAdnmI
         iWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eSyPRGpdr54hZeIx3MgbzcLSGriiOGrRdkvlFes2oMI=;
        b=swjo7pMG8UHv7yRBRS2wqP4tCBj4hcatQhxM4QhbkA/bk5QbOSiJb+UOBOD2RD9A70
         rGMV+jDPfxaL7gJcJWqbvBFfv01bv9ZFw2QLKMipbuSHdIi+CUEH/jDrRDSReBGTmdHj
         P1eyDTCa6NRD48IZ/kJ3yvYQEbZff3wMzgBSdB5fFpSMtrjgoW5ryH+fNqVvvOEUCMuW
         /ojgsviqiUiUuZNEC4xCswRjZWFomemdqXO2AXZEG965Ssm9ki0s/pm64yGCFzVQKva5
         oF2ZmMC+30I+tP7uVSqKdEE/dNHAiiYoeDtsyIFhcy3aDV6XGMyx5uN4QL7fvqcEkhyd
         8JTg==
X-Gm-Message-State: AOAM5318CKdaWbylVMnoTYkEQ2NTM5TH+OQDbQmZoinLyECnjRs9c493
        f6C2Ii0rI+tpap41tKFWjQsfe5EuM3I=
X-Google-Smtp-Source: ABdhPJwKfTJsYAK1b3y5LKFhXX0I1MGRXSyf4oYPKQ1IJ7hOWwInisOLWtobUFCk835nLWmgjXPBvA==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr16139083wrt.191.1597673093076;
        Mon, 17 Aug 2020 07:04:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16sm31388626wrx.30.2020.08.17.07.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:04:52 -0700 (PDT)
Message-Id: <8d481f3b223960f2193678929b0a1705222386b7.1597673089.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.703.v2.git.1597673089.gitgitgadget@gmail.com>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
        <pull.703.v2.git.1597673089.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 14:04:47 +0000
Subject: [PATCH v2 2/3] commit-graph: use the "hash version" byte
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, sandals@crustytoothpaste.net,
        me@ttaylorr.com, abhishekkumar8222@gmail.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit-graph format reserved a byte among the header of the file to
store a "hash version". During the SHA-256 work, this was not modified
because file formats are not necessarily intended to work across hash
versions. If a repository has SHA-256 as its hash algorithm, it
automatically up-shifts the lengths of object names in all necessary
formats.

However, since we have this byte available for adjusting the version, we
can make the file formats more obviously incompatible instead of relying
on other context from the repository.

Update the oid_version() method in commit-graph.c to add a new value, 2,
for sha-256. This automatically writes the new value in a SHA-256
repository _and_ verifies the value is correct. This is a breaking
change relative to the current 'master' branch since 092b677 (Merge
branch 'bc/sha-256-cvs-svn-updates', 2020-08-13) but it is not breaking
relative to any released version of Git.

The test impact is relatively minor: the output of 'test-tool
read-graph' lists the header information, so those instances of '1' need
to be replaced with a variable determined by GIT_TEST_DEFAULT_HASH. A
more careful test is added that specifically creates a repository of
each type then swaps the commit-graph files. The important value here is
that the "git log" command succeeds while writing a message to stderr.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .../technical/commit-graph-format.txt         |  9 ++++-
 commit-graph.c                                |  9 ++++-
 t/t4216-log-bloom.sh                          |  9 ++++-
 t/t5318-commit-graph.sh                       | 38 ++++++++++++++++++-
 t/t5324-split-commit-graph.sh                 |  5 ++-
 5 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 440541045d..6ddbceba15 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -42,8 +42,13 @@ HEADER:
   1-byte version number:
       Currently, the only valid version is 1.
 
-  1-byte Hash Version (1 = SHA-1)
-      We infer the hash length (H) from this value.
+  1-byte Hash Version
+      We infer the hash length (H) from this value:
+	1 => SHA-1
+	2 => SHA-256
+      If the hash type does not match the repository's hash algorithm, the
+      commit-graph file should be ignored with a warning presented to the
+      user.
 
   1-byte number (C) of "chunks"
 
diff --git a/commit-graph.c b/commit-graph.c
index e51c91dd5b..0ed003e218 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -179,7 +179,14 @@ static char *get_chain_filename(struct object_directory *odb)
 
 static uint8_t oid_version(void)
 {
-	return 1;
+	switch (hash_algo_by_ptr(the_hash_algo)) {
+	case GIT_HASH_SHA1:
+		return 1;
+	case GIT_HASH_SHA256:
+		return 2;
+	default:
+		die(_("invalid hash version"));
+	}
 }
 
 static struct commit_graph *alloc_commit_graph(void)
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index c21cc160f3..4bb9e9dbe2 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -30,12 +30,17 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
 	rm file_to_be_deleted &&
 	git add . &&
 	git commit -m "file removed" &&
-	git commit-graph write --reachable --changed-paths
+	git commit-graph write --reachable --changed-paths &&
+
+	test_oid_cache <<-EOF
+	oid_version sha1:1
+	oid_version sha256:2
+	EOF
 '
 graph_read_expect () {
 	NUM_CHUNKS=5
 	cat >expect <<- EOF
-	header: 43475048 1 1 $NUM_CHUNKS 0
+	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
 	EOF
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 044cf8a3de..2ed0c1544d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -10,7 +10,12 @@ test_expect_success 'setup full repo' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git init &&
 	git config core.commitGraph true &&
-	objdir=".git/objects"
+	objdir=".git/objects" &&
+
+	test_oid_cache <<-EOF
+	oid_version sha1:1
+	oid_version sha256:2
+	EOF
 '
 
 test_expect_success POSIXPERM 'tweak umask for modebit tests' '
@@ -77,7 +82,7 @@ graph_read_expect() {
 		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
 	fi
 	cat >expect <<- EOF
-	header: 43475048 1 1 $NUM_CHUNKS 0
+	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
 	EOF
@@ -412,6 +417,35 @@ test_expect_success 'replace-objects invalidates commit-graph' '
 	)
 '
 
+test_expect_success 'warn on improper hash version' '
+	git init --object-format=sha1 sha1 &&
+	(
+		cd sha1 &&
+		test_commit 1 &&
+		git commit-graph write --reachable &&
+		mv .git/objects/info/commit-graph ../cg-sha1
+	) &&
+	git init --object-format=sha256 sha256 &&
+	(
+		cd sha256 &&
+		test_commit 1 &&
+		git commit-graph write --reachable &&
+		mv .git/objects/info/commit-graph ../cg-sha256
+	) &&
+	(
+		cd sha1 &&
+		mv ../cg-sha256 .git/objects/info/commit-graph &&
+		git log -1 2>err &&
+		test_i18ngrep "commit-graph hash version 2 does not match version 1" err
+	) &&
+	(
+		cd sha256 &&
+		mv ../cg-sha1 .git/objects/info/commit-graph &&
+		git log -1 2>err &&
+		test_i18ngrep "commit-graph hash version 1 does not match version 2" err
+	)
+'
+
 # the verify tests below expect the commit-graph to contain
 # exactly the commits reachable from the commits/8 branch.
 # If the file changes the set of commits in the list, then the
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index ea28d522b8..18216463c7 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -18,6 +18,9 @@ test_expect_success 'setup repo' '
 
 	base sha1:1376
 	base sha256:1496
+
+	oid_version sha1:1
+	oid_version sha256:2
 	EOM
 '
 
@@ -28,7 +31,7 @@ graph_read_expect() {
 		NUM_BASE=$2
 	fi
 	cat >expect <<- EOF
-	header: 43475048 1 1 3 $NUM_BASE
+	header: 43475048 1 $(test_oid oid_version) 3 $NUM_BASE
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata
 	EOF
-- 
gitgitgadget

