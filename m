Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26848C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 06:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiGLGvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 02:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiGLGvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 02:51:04 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D395A2ED
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 23:51:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e16so6693849pfm.11
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHYPRQDdl7xuOuMfqf3Fk2QUDHK1+i2URpsG24YPCyM=;
        b=l9pRI4Z3RfjK9OzxXYjOQ0/KILWGIzAe1bhnmSzquFgZiiFqeMMlOahpct2vR1Ih2d
         OgdSfpaWMyYXkA8MHkFG+fLTzFCRHQBPsMYS59mL7cVbUWZFhTEBZdPLbWfP7ytjCsrS
         lCJ9HMR9PWuZ8C26b4phhOTRo+DjBD5OdgCljhsM8X8QVircRJIwzaffA3o2kvFyc4O2
         RuV/84Old+NPEOI8zz8OcYHMvYIS8uNYMWtIcWg31/aoGU/yReK+qqn1bsRNk3k6QvpT
         M4GTpUFywMgamy0S6IIKJ30URSNbbEpGM3oaTb+K6MufckW/5ys3pGDVSP+wk4QNGl/b
         2VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NHYPRQDdl7xuOuMfqf3Fk2QUDHK1+i2URpsG24YPCyM=;
        b=OtvGmk+CuPy1wGIUmFJm10LSOTLNDLEuIxvBKzs0kEsuig3SAzaC0b55Mse00WDJZK
         BEA4q6dfaIwUoWLtEd4g4vDj35YzAgjtXctMCzyXwiZOcEx32BW5Xrt61hWK8Mv99JXz
         Y+n5qajNFTrysvfVVNziLbjzclZg75PxgKPoPvggvU7Px3nVFqbhr2ltsLhDabBd3Y7I
         289JRBybEDxO/YiARy7i5CXiA8aGZGk/IpIX4MyOS6gUJirBuZGgc0Xn+D47dy5CmRum
         t7pbQI371ymFSNp5kZzHcTUMwGU3poJryOuCKPTrxNy7xog/7DwcFw5b0MPAoR6rrFE0
         7+3A==
X-Gm-Message-State: AJIora97fBkSF971Tt+Rmb1bVcFmYRfN5YgkqBg6/X2XRZdB9XfqyOb1
        SqkJoevEDB2lS1aFQdU3Zqq7Pg==
X-Google-Smtp-Source: AGRyM1tCSFzjrX6YWU3/tgmPzgfwnB87KDVZNRUrUZav5y1K2r1SHpSCf0r+8flm8bttaHNxdULXiA==
X-Received: by 2002:a65:6a55:0:b0:411:fbda:1e6b with SMTP id o21-20020a656a55000000b00411fbda1e6bmr19128738pgu.225.1657608662918;
        Mon, 11 Jul 2022 23:51:02 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b0016c5b2a16ffsm781054plb.142.2022.07.11.23.50.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Jul 2022 23:51:02 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     hanxin.hx@bytedance.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, peff@peff.net, git@grubix.eu,
        me@ttaylorr.com, Junio C Hamano <gitster@pobox.com>, ps@pks.im
Subject: [PATCH v5 1/1] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
Date:   Tue, 12 Jul 2022 14:50:47 +0800
Message-Id: <3ffeed50deb2d292cef0a518085d60d22c5dd79b.1657604799.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657604799.git.hanxin.hx@bytedance.com>
References: <cover.1656593279.git.hanxin.hx@bytedance.com> <cover.1657604799.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph is used to opportunistically optimize accesses to
certain pieces of information on commit objects, and
lookup_commit_in_graph() tries to say "no" when the requested commit
does not locally exist by returning NULL, in which case the caller
can ask for (which may result in on-demand fetching from a promisor
remote) and parse the commit object itself.

However, it uses a wrong helper, repo_has_object_file(), to do so.
This helper not only checks if an object is mmediately available in
the local object store, but also tries to fetch from a promisor remote.
But the fetch machinery calls lookup_commit_in_graph(), thus causing an
infinite loop.

We should make lookup_commit_in_graph() expect that a commit given to it
can be legitimately missing from the local object store, by using the
has_object_file() helper instead.

Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
---
 commit-graph.c                             |  2 +-
 t/t5330-no-lazy-fetch-with-commit-graph.sh | 47 ++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100755 t/t5330-no-lazy-fetch-with-commit-graph.sh

diff --git a/commit-graph.c b/commit-graph.c
index 92d4503336..2b04ef072d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -898,7 +898,7 @@ struct commit *lookup_commit_in_graph(struct repository *repo, const struct obje
 		return NULL;
 	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
 		return NULL;
-	if (!repo_has_object_file(repo, id))
+	if (!has_object(repo, id, 0))
 		return NULL;
 
 	commit = lookup_commit(repo, id);
diff --git a/t/t5330-no-lazy-fetch-with-commit-graph.sh b/t/t5330-no-lazy-fetch-with-commit-graph.sh
new file mode 100755
index 0000000000..2cc7fd7a47
--- /dev/null
+++ b/t/t5330-no-lazy-fetch-with-commit-graph.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='test for no lazy fetch with the commit-graph'
+
+. ./test-lib.sh
+
+test_expect_success 'setup: prepare a repository with a commit' '
+	git init with-commit &&
+	test_commit -C with-commit the-commit &&
+	oid=$(git -C with-commit rev-parse HEAD)
+'
+
+test_expect_success 'setup: prepare a repository with commit-graph contains the commit' '
+	git init with-commit-graph &&
+	echo "$(pwd)/with-commit/.git/objects" \
+		>with-commit-graph/.git/objects/info/alternates &&
+	# create a ref that points to the commit in alternates
+	git -C with-commit-graph update-ref refs/ref_to_the_commit "$oid" &&
+	# prepare some other objects to commit-graph
+	test_commit -C with-commit-graph something &&
+	git -c gc.writeCommitGraph=true -C with-commit-graph gc &&
+	test_path_is_file with-commit-graph/.git/objects/info/commit-graph
+'
+
+test_expect_success 'setup: change the alternates to what without the commit' '
+	git init --bare without-commit &&
+	git -C with-commit-graph cat-file -e $oid &&
+	echo "$(pwd)/without-commit/objects" \
+		>with-commit-graph/.git/objects/info/alternates &&
+	test_must_fail git -C with-commit-graph cat-file -e $oid
+'
+
+test_expect_success 'fetch any commit from promisor with the usage of the commit graph' '
+	# setup promisor and prepare any commit to fetch
+	git -C with-commit-graph remote add origin "$(pwd)/with-commit" &&
+	git -C with-commit-graph config remote.origin.promisor true &&
+	git -C with-commit-graph config remote.origin.partialclonefilter blob:none &&
+	test_commit -C with-commit any-commit &&
+	anycommit=$(git -C with-commit rev-parse HEAD) &&
+	GIT_TRACE="$(pwd)/trace.txt" \
+		git -C with-commit-graph fetch origin $anycommit 2>err &&
+	! grep "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
+	grep "git fetch origin" trace.txt >actual &&
+	test_line_count = 1 actual
+'
+
+test_done
-- 
2.36.1

