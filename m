Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BD0C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023D020B1F
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="y18UTKWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgD2Rgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2Rgl (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 13:36:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37FC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:36:41 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x2so1401497pfx.7
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/WYttUJ0umih4dO0BAnYosSFo7WinEBFWQGBp3/i4O4=;
        b=y18UTKWj9gIB14otSlqvv8KtP6F7YXuHf3kGwBvKwmuIKhaXdVKWz+lXOvLpSsnOtd
         Z24WCG1eX+Q5HxCEHJcxzs1Ri/BLIFvnf2hfuTWwKvbeNa5dqp/dhJV4nhbue30EKO2U
         /X6WnTvY+GMotWTh1gdf5bp8jeDL40cE/+fkfCt6sWCdxwI+T2YsfQql+Bnz2EP4gINZ
         xBkNfYlIeVMbzwynlgpBbju4pnrZrQBg7uV+lEbS6R7woQpHmsOZMRTiFW9FnXo1ByMu
         wRuZmX2XQxbaYSU2ve/PInk3iAQodfkfZnyssowjnzjvI+zOezsC0cHqh52QYLiDyfGG
         lyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/WYttUJ0umih4dO0BAnYosSFo7WinEBFWQGBp3/i4O4=;
        b=e2AkEZarn1m3rUIwvvYAea2a6YIsQuWq2doBsGEk5v9mO3MPNKNyJfPv8VyzVi2+zs
         xyr+AwT9hkXTu/ODAUYNKDgLc/53EA27xTtS13ZRXhCG/uH25yOla1BM+Lrtzr9SMqxI
         8BdzQqcmkL4ngAgw+n20zj/gvMV9NRogNgX3KsdNlGsTctezJP73Zk2/LBxhk2+L93Ry
         9oX75OAShaxx958hF3qWERXXwTGA6FHrEX2QZLcvMBAq5dpBECZx/hObTNsHJKeWCfWw
         hienLTfhQEZ4PcFFajLbTh9Ye+dU0e/BEOeWoOvESecfoopXq8enmAJE8js95knUEp0/
         tWtQ==
X-Gm-Message-State: AGi0PuYrhV6anuN3VUAp+vSyxDoYlWMnJgfTJO78gS+CJ6bnQ8hmX2W/
        sNpDmqwUb6yHL2vfveVq7OkpUrir7UDcng==
X-Google-Smtp-Source: APiQypJeJFhRRzxYbxLI+RHQqA9cTluRTC5IZGVYp0O045ADo69KMzWsS4urT8K1xarTJRIHUhTNcw==
X-Received: by 2002:aa7:9d90:: with SMTP id f16mr20771237pfq.48.1588181800863;
        Wed, 29 Apr 2020 10:36:40 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i10sm1525782pfa.166.2020.04.29.10.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:36:40 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:36:38 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        mhagger@alum.mit.edu
Subject: [PATCH v3 3/5] commit-graph.c: write non-split graphs as read-only
Message-ID: <8d5503d2e6723ed5c31a047a28cdc43f7b718cca.1588181626.git.me@ttaylorr.com>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588181626.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588181626.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous commit, Git learned 'hold_lock_file_for_update_mode' to
allow the caller to specify the permission bits (prior to further
adjustment by the umask and shared repository permissions) used when
acquiring a temporary file.

Use this in the commit-graph machinery for writing a non-split graph to
acquire an opened temporary file with permissions read-only permissions
to match the split behavior. (In the split case, Git uses
git_mkstemp_mode' for each of the commit-graph layers with permission
bits '0444').

One can notice this discrepancy when moving a non-split graph to be part
of a new chain. This causes a commit-graph chain where all layers have
read-only permission bits, except for the base layer, which is writable
for the current user.

Resolve this discrepancy by using the new
'hold_lock_file_for_update_mode' and passing the desired permission
bits.

Doing so causes some test fallout in t5318 and t6600. In t5318, this
occurs in tests that corrupt a commit-graph file by writing into it. For
these, 'chmod u+w'-ing the file beforehand resolves the issue. The
additional spot in 'corrupt_graph_verify' is necessary because of the
extra 'git commit-graph write' beforehand (which *does* rewrite the
commit-graph file). In t6600, this is caused by copying a read-only
commit-graph file into place and then trying to replace it. For these,
make these files writable.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c          |  3 ++-
 t/t5318-commit-graph.sh | 15 ++++++++++++++-
 t/t6600-test-reach.sh   |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f013a84e29..5b5047a7dd 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1388,7 +1388,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 		f = hashfd(fd, ctx->graph_name);
 	} else {
-		hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
+		hold_lock_file_for_update_mode(&lk, ctx->graph_name,
+					       LOCK_DIE_ON_ERROR, 0444);
 		fd = lk.tempfile->fd;
 		f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	}
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 9bf920ae17..901eb3ecfb 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -12,6 +12,10 @@ test_expect_success 'setup full repo' '
 	test_oid_init
 '
 
+test_expect_success POSIXPERM 'tweak umask for modebit tests' '
+	umask 022
+'
+
 test_expect_success 'verify graph with no graph file' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph verify
@@ -96,6 +100,13 @@ test_expect_success 'write graph' '
 	graph_read_expect "3"
 '
 
+test_expect_success POSIXPERM 'write graph has correct permissions' '
+	test_path_is_file $objdir/info/commit-graph &&
+	echo "-r--r--r--" >expect &&
+	test_modebits $objdir/info/commit-graph >actual &&
+	test_cmp expect actual
+'
+
 graph_git_behavior 'graph exists' full commits/3 commits/1
 
 test_expect_success 'Add more commits' '
@@ -421,7 +432,8 @@ GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
 corrupt_graph_setup() {
 	cd "$TRASH_DIRECTORY/full" &&
 	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
-	cp $objdir/info/commit-graph commit-graph-backup
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	chmod u+w $objdir/info/commit-graph
 }
 
 corrupt_graph_verify() {
@@ -435,6 +447,7 @@ corrupt_graph_verify() {
 	fi &&
 	git status --short &&
 	GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD=true git commit-graph write &&
+	chmod u+w $objdir/info/commit-graph &&
 	git commit-graph verify
 }
 
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index b24d850036..475564bee7 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -51,8 +51,10 @@ test_expect_success 'setup' '
 	done &&
 	git commit-graph write --reachable &&
 	mv .git/objects/info/commit-graph commit-graph-full &&
+	chmod u+w commit-graph-full &&
 	git show-ref -s commit-5-5 | git commit-graph write --stdin-commits &&
 	mv .git/objects/info/commit-graph commit-graph-half &&
+	chmod u+w commit-graph-half &&
 	git config core.commitGraph true
 '
 
-- 
2.26.0.113.ge9739cdccc

