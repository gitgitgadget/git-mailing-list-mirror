Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962C1C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 18:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CD020771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 18:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWTKn/nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgHNSH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgHNSHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 14:07:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E52C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 11:07:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g8so8183750wmk.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+oy4Z3XB4G7URqksSnrBDvki2JQbQosnAaapXz0JFFY=;
        b=PWTKn/nrlVLSl3JTMOoyIqr3JrisRk1U7HI6YJ5XqWaHqGiZTNeUNs6CI0WEhPEtPL
         ZgMihGMrmgdoflwSiMLRfeFFYUSyOeY4xOFMKvFLZEgEXhZYl2VopbXe0mCJcpK/neqY
         aaWlb95VyDy2OguWLgU63mArheTpJjPPfH0IUg+ZH2t2by/CWkbdEYvYAOjxRzoEEysa
         5MWjfHsaz60hjchoDcDk5Br1jwfsHOlUGuKpyqXS4SVyJBn+P1K1tJmcV/pAkHFaYBip
         etg2/ppvsYsScGPPUBAAFR7i8ZKNvtOtWs935iB6Obb+AAL0d+oA7Ay/q88O9nsSFg0T
         148Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+oy4Z3XB4G7URqksSnrBDvki2JQbQosnAaapXz0JFFY=;
        b=G/GPwuq4KJxJVTPf1m/1Ix2VFPEaqKxvxfAFHqK1YwhJzOHnaSSH3dpga/uR3L38xy
         kE2c6bT0YjE8qNj4xDypk+bKoUXOSadRhz7/b4yCtWI6TBYQBCzcxjqVLY+jX6rKhRk4
         LSbcOTG/agpt2t4Xd+xJv2c1Q8ofvrmvIDqVXiZsI135Vh3Ed2JMfzIshukIEuopixjH
         IwftoDOYOmxPF1bW87WYxn82qclc+6EbGQDr72e3Wbvr5qWGH7/zPjR+fI6GhBkmoSaI
         R4hdXPmnp4jXyjDKxstkyNqm1z8mvCS8JFAKOrxIQWc/1xWL5fgRizORmQ1FX1duiMh4
         1anw==
X-Gm-Message-State: AOAM530o94z+YSN1WBF3Lz6r7qZVerV7OowL64N6pCIAx+JFnOztUMXw
        xTg6OygqrAaGJWAW8mo1bNptrWYt/14=
X-Google-Smtp-Source: ABdhPJzK5h9rx6/vxPA8OYyBJjrOffQ/ahg9Z3lFFcu3o8/Yz4cHSNZWq5yVBXHV1LIQfE7zfM+hlQ==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr3481908wmh.23.1597428443833;
        Fri, 14 Aug 2020 11:07:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 15sm15490575wmo.33.2020.08.14.11.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 11:07:23 -0700 (PDT)
Message-Id: <4bbfd345d16da4604dd20decda8ecb12372e4223.1597428440.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.703.git.1597428440.gitgitgadget@gmail.com>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 18:07:19 +0000
Subject: [PATCH 2/3] commit-graph: use the hash version byte
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, sandals@crustytoothpaste.net,
        me@ttaylorr.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .../technical/commit-graph-format.txt         |  9 ++++-
 commit-graph.c                                |  6 ++-
 t/t4216-log-bloom.sh                          |  8 +++-
 t/t5318-commit-graph.sh                       | 37 ++++++++++++++++++-
 t/t5324-split-commit-graph.sh                 |  8 +++-
 5 files changed, 62 insertions(+), 6 deletions(-)

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
index e51c91dd5b..d03328d64c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -179,7 +179,11 @@ static char *get_chain_filename(struct object_directory *odb)
 
 static uint8_t oid_version(void)
 {
-	return 1;
+	if (the_hash_algo->rawsz == GIT_SHA1_RAWSZ)
+		return 1;
+	if (the_hash_algo->rawsz == GIT_SHA256_RAWSZ)
+		return 2;
+	die(_("invalid hash version"));
 }
 
 static struct commit_graph *alloc_commit_graph(void)
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index c21cc160f3..906af2799d 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -6,6 +6,12 @@ test_description='git log for a path with Bloom filters'
 GIT_TEST_COMMIT_GRAPH=0
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
 
+OID_VERSION=1
+if [ "$GIT_DEFAULT_HASH" = "sha256" ]
+then
+	OID_VERSION=2
+fi
+
 test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
 	git init &&
 	mkdir A A/B A/B/C &&
@@ -35,7 +41,7 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
 graph_read_expect () {
 	NUM_CHUNKS=5
 	cat >expect <<- EOF
-	header: 43475048 1 1 $NUM_CHUNKS 0
+	header: 43475048 1 $OID_VERSION $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
 	EOF
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 044cf8a3de..5b65017676 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -5,6 +5,12 @@ test_description='commit graph'
 
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
 
+OID_VERSION=1
+if [ "$GIT_DEFAULT_HASH" = "sha256" ]
+then
+	OID_VERSION=2
+fi
+
 test_expect_success 'setup full repo' '
 	mkdir full &&
 	cd "$TRASH_DIRECTORY/full" &&
@@ -77,7 +83,7 @@ graph_read_expect() {
 		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
 	fi
 	cat >expect <<- EOF
-	header: 43475048 1 1 $NUM_CHUNKS 0
+	header: 43475048 1 $OID_VERSION $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
 	EOF
@@ -412,6 +418,35 @@ test_expect_success 'replace-objects invalidates commit-graph' '
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
index ea28d522b8..6f1a324f4f 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -6,6 +6,12 @@ test_description='split commit graph'
 GIT_TEST_COMMIT_GRAPH=0
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
 
+OID_VERSION=1
+if [ "$GIT_DEFAULT_HASH" = "sha256" ]
+then
+	OID_VERSION=2
+fi
+
 test_expect_success 'setup repo' '
 	git init &&
 	git config core.commitGraph true &&
@@ -28,7 +34,7 @@ graph_read_expect() {
 		NUM_BASE=$2
 	fi
 	cat >expect <<- EOF
-	header: 43475048 1 1 3 $NUM_BASE
+	header: 43475048 1 $OID_VERSION 3 $NUM_BASE
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata
 	EOF
-- 
gitgitgadget

