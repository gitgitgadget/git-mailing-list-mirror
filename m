Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83BDC54FCC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C37C12145D
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="1tPOIXA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDTWvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDTWvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 18:51:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7200EC061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 15:51:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 145so3417217pfw.13
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gnSWNBy6IVep98dI2wKXHl4EvBAZZ9WFf+1ofWO7Ioc=;
        b=1tPOIXA2yErq52egBCIR7/F8/4sGVMehvE4OL6XvRjsnuBS4Fp3HtkbyBcpijKITM8
         AcnjR402/Gqme8oa2W980br9xmnrHsvEX/QRrXSQpPFFlESvaFXizMhLmyoIuvGHpr1v
         8wfZ9lcLiVsA0WVv7Xiq/2h5Bm6Uo3MU9okilYUcA5UyOpDp34FbeUDkCLoRmZ9AEp6O
         nSV8ueZ6T/3wXaFMDjo5r7xg+ZJxRgZY5kDcKkvN3d8TOPF1QpaClO/C+lx2Ye/G1Nu4
         RIWOJJ64gwk9ypeU1ou5OJRfLS8RDbHsXeVVCVx/2NZZSKd1c72vRnCRpj7UuJDPRF3W
         aeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gnSWNBy6IVep98dI2wKXHl4EvBAZZ9WFf+1ofWO7Ioc=;
        b=fcwvZPVGCEfc5fz0OU7uvKck09u9ZmFBkjgHRdOpMMor66fKaWphBG0pz+0oNyeHr/
         HQ+f6sF7zppzYHisbVMINqqG/G/bmKSMzZotcPhO4uUOhZj+pU0rafeM0yFEuf6J39jL
         /zFBoal+LsuQ/RqIO5lg6vcutfcWAPjAGbQp6gJQ7ARkTf1HpI2cJkdQEKUEYVhFnyb/
         N8dhehMod5XaETmpSwEX6i72UHLxP2klrD816yJmPUSxdP5qKDqkSNqFiCQ8UKiglSuf
         i2L++FcfyvDFMMt28OIqdOAIVH8d1+B+rcAaKWHmCrtnb8E+jFIZffiI/Fx6TGkV0FpS
         VtHg==
X-Gm-Message-State: AGi0PuYrpUozu/DNHJ1WJkxJrjHNM68jE38EWocgvvehJiGAxRUfrUFK
        i842ScJEKvc+hQH/OkZo8AjmDX8TE18RmA==
X-Google-Smtp-Source: APiQypKjCUXiEZ/f8ShOrbyDGtefiDnxOnPdm9Ple2/TJ0/QLAOqHrHUQdyBuuxdYvtchkTmyC062A==
X-Received: by 2002:a62:808d:: with SMTP id j135mr2343255pfd.53.1587423071546;
        Mon, 20 Apr 2020 15:51:11 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 22sm534415pfb.132.2020.04.20.15.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:51:10 -0700 (PDT)
Date:   Mon, 20 Apr 2020 16:51:10 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, mhagger@alum.mit.edu, peff@peff.net
Subject: [PATCH 3/3] commit-graph.c: write non-split graphs as read-only
Message-ID: <622fd92cee7ccf035c348f64599cdc487b34717b.1587422630.git.me@ttaylorr.com>
References: <cover.1587422630.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587422630.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous commit, Git learned 'hold_lock_file_for_update_mode' to
allow the caller to specify the permission bits used when acquiring a
temporary file.

Use this in the commit-graph machinery for writing a non-split graph to
acquire an opened temporary file with permissions read-only permissions
to match the split behavior. (In the split case, Git uses
'git_mkstemp_mode' for each of the commit-graph layers with permission
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

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c          |  3 ++-
 t/t5318-commit-graph.sh | 11 ++++++++++-
 t/t6600-test-reach.sh   |  2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

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
index 9bf920ae17..fb0aae61c3 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -96,6 +96,13 @@ test_expect_success 'write graph' '
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
@@ -421,7 +428,8 @@ GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
 corrupt_graph_setup() {
 	cd "$TRASH_DIRECTORY/full" &&
 	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
-	cp $objdir/info/commit-graph commit-graph-backup
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	chmod u+w $objdir/info/commit-graph
 }
 
 corrupt_graph_verify() {
@@ -435,6 +443,7 @@ corrupt_graph_verify() {
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
2.26.1.108.gadb95c98e4
