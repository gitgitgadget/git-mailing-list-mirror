Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E33E201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 01:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbdBYBTR (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 20:19:17 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34709 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbdBYBTO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 20:19:14 -0500
Received: by mail-pg0-f43.google.com with SMTP id 1so18002088pgi.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 17:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6pSfZJyX2cmEfPKG/ga6iKXtkwq5H4tjTHD7PQ4XZBo=;
        b=Dz/zykPNw2XGdpyy1JdgI57efpCRkEleTUvmh8V+MYgvuFcAdgRF4tujVccJ9CztPx
         lwhzTiPPYCTLV2W7SoZdUo9oUWQILbBBY4EVppiQnPCQ3pNA33q4mZltfVrzTpoUSKXp
         cqe28lQsTgu3Cz//1IVSwOURfP9XflVc15ZDpD/U9D41r0kHfA/5x6hs9CTdyULoVLW7
         dKRWu6Yo/22KXFcQcqdcTSVPrTouEGErXAb7TvlDlDvdSjpohIrNuOO+JEaZGcnroTjD
         1oRiIu23MUUfi+smczp9ElvZX3azbsB3GnQJXviRote/1Jbd5cCXOWxLDDDJ7r8lq0Kv
         DVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6pSfZJyX2cmEfPKG/ga6iKXtkwq5H4tjTHD7PQ4XZBo=;
        b=dupRotI1QCc/eOH+YSu6+FuD5sYmXNClN5QDRXeMO6j55y8hX3XL19HGKbqrPwh0V6
         DBhy06jck/zz4FCbMoaxF6+hkgTxHKJG/OV8qerScSpZg8tjjvR12cYd4yk43v/qs48g
         sozk3jy8HUCUTO8m1SbfP7whyEhnzo6b405s39UmXJHHHCkXDqN25kjpPcmr/Qjn56QS
         qm87IcxKkehWXzyM2NI0y73Gld1cnFqrDh7pW9yL0WVmaWO+LT/vyPUZ4gpWlhCtMWI9
         c3P7G6pvu0iNOBaH4yKzFQ7gARncdBNs+fP+7qPqLxJqkdCMOKP1jeA0Rdx8uDOHPeUe
         7Uww==
X-Gm-Message-State: AMke39n3rWaRObA3QHS82QnprTJQRDBSErA69/BXwiirxXTOAKJy4PyKqBG+b1WP88ryLSoi
X-Received: by 10.98.141.82 with SMTP id z79mr7145042pfd.36.1487985524350;
        Fri, 24 Feb 2017 17:18:44 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id 67sm17082280pfd.120.2017.02.24.17.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 17:18:43 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, peartben@gmail.com, benpeart@microsoft.com
Subject: [PATCH 2/3] revision: exclude trees/blobs given commit
Date:   Fri, 24 Feb 2017 17:18:37 -0800
Message-Id: <7082d91f30663b2e6d7fb1795c5ea37d3fe3446c.1487984670.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1487984670.git.jonathantanmy@google.com>
References: <cover.1487984670.git.jonathantanmy@google.com>
In-Reply-To: <cover.1487984670.git.jonathantanmy@google.com>
References: <cover.1487984670.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the --objects argument is given to rev-list, an argument of the
form "^$tree" can be given to exclude all blobs and trees reachable from
that tree, but an argument of the form "^$commit" only excludes that
commit, not any blob or tree reachable from it. Make "^$commit" behave
consistent to "^$tree".

Also, formalize this behavior in unit tests. (Some of the added tests
would already pass even before this commit, but are included
nevertheless for completeness.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 revision.c               |  2 ++
 t/t6000-rev-list-misc.sh | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/revision.c b/revision.c
index 5e49d9e0e..e6a62da98 100644
--- a/revision.c
+++ b/revision.c
@@ -254,6 +254,8 @@ static struct commit *handle_commit(struct rev_info *revs,
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
+			if (revs->tree_and_blob_objects)
+				mark_tree_uninteresting(commit->tree);
 			revs->limited = 1;
 		}
 		if (revs->show_source && !commit->util)
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 969e4e9e5..c04a9582b 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -114,4 +114,92 @@ test_expect_success '--header shows a NUL after each commit' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup tree-granularity and blob-granularity tests' '
+	echo 0 >file &&
+
+	mkdir subdir &&
+	echo 1 >subdir/file &&
+	git add file subdir/file &&
+	git commit -m one &&
+
+	echo 2 >subdir/file &&
+	git add subdir/file &&
+	git commit -m two &&
+
+	commit1=$(git rev-parse HEAD^1) &&
+	commit2=$(git rev-parse HEAD) &&
+	tree1=$(git rev-parse $commit1^{tree}) &&
+	tree2=$(git rev-parse $commit2^{tree}) &&
+	subtree1=$(git cat-file -p $tree1 | grep "subdir" | cut -c13-52) &&
+	subtree2=$(git cat-file -p $tree2 | grep "subdir" | cut -c13-52) &&
+	blob0=$(echo 0 | git hash-object --stdin) &&
+	blob1=$(echo 1 | git hash-object --stdin) &&
+	blob2=$(echo 2 | git hash-object --stdin)
+'
+
+test_expect_success 'include commit, exclude blob' '
+	git rev-list --objects $commit2 >out &&
+	grep "$blob1" out &&
+	grep "$blob2" out &&
+
+	git rev-list --objects $commit2 "^$blob2" >out &&
+	grep "$blob1" out &&
+	! grep "$blob2" out
+'
+
+test_expect_success 'include commit, exclude tree (also excludes nested trees/blobs)' '
+	git rev-list --objects $commit2 "^$tree2" >out &&
+	grep "$tree1" out &&
+	grep "$subtree1" out &&
+	grep "$blob1" out &&
+	! grep "$tree2" out &&
+	! grep "$subtree2" out &&
+	! grep "$blob2" out &&
+
+	git rev-list --objects $commit2 "^$subtree2" >out &&
+	grep "$tree1" out &&
+	grep "$subtree1" out &&
+	grep "$blob1" out &&
+	grep "$tree2" out &&
+	! grep "$subtree2" out &&
+	! grep "$blob2" out
+'
+
+test_expect_success 'include tree, exclude commit' '
+	git rev-list --objects "$tree1" "^$commit2" >out &&
+	! grep "$blob0" out &&  # common to both
+	grep "$blob1" out &&    # only in tree
+	! grep "$blob2" out     # only in commit
+'
+
+test_expect_success 'include tree, exclude tree' '
+	git rev-list --objects "$tree1" "^$tree2" >out &&
+	! grep "$blob0" out &&  # common to both
+	grep "$blob1" out &&    # only in tree1
+	! grep "$blob2" out     # only in tree2
+'
+
+test_expect_success 'include tree, exclude blob' '
+	git rev-list --objects "$tree1" "^$blob2" >out &&
+	grep "$blob0" out &&
+	grep "$blob1" out &&
+	! grep "$blob2" out
+'
+
+test_expect_success 'include blob, exclude commit' '
+	git rev-list --objects "$blob2" "^$commit1" >out &&
+	grep "$blob2" out &&
+
+	git rev-list --objects "$blob2" "^$commit2" >out &&
+	! grep "$blob2" out
+'
+
+test_expect_success 'include blob, exclude tree' '
+	git rev-list --objects "$blob2" "^$tree1" >out &&
+	grep "$blob2" out &&
+
+	git rev-list --objects "$blob2" "^$tree2" >out &&
+	! grep "$blob2" out
+'
+
 test_done
-- 
2.11.0.483.g087da7b7c-goog

