Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2141E20281
	for <e@80x24.org>; Thu,  2 Nov 2017 19:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964786AbdKBTmE (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 15:42:04 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:55249 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934345AbdKBTmC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 15:42:02 -0400
Received: by mail-io0-f196.google.com with SMTP id e89so1445842ioi.11
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 12:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hl0+Zb/texquj9BHFW0mcm/coTuxAB6WF5vARA6U47E=;
        b=UmkHu4srBQYcxlBZm/yRCSo7h3NwlEBwvQct4oJzE4SuXJkdxoHBv4S04lew58BYR+
         3fo+Ns9RRme8xIdmejj0imaI9R0mfrh9pLJo9YrIJAQw5vfCvb0dPKDyIRZ8F0FDf1w9
         dIlVkJ0V6crc/TPtPFlrCqd53Ery8SY3EMjZvdjF2A0FhoV93PMV7r4O0YBz6/bfTeqf
         3cZ5e/bkKQggjGfIlXo7JiIBMuICBoHanPX/hQjTlJo7lwy9fZMDFUVKl0QFK/lk590x
         +BpUmj6Zr4phbvD9+ue0Q8i2jDkr9HSv4zOk7F3cD+RY2Ok1sKrBqfYFq4mKHCwOKpum
         gw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hl0+Zb/texquj9BHFW0mcm/coTuxAB6WF5vARA6U47E=;
        b=k2c34QFaK3FN5iIWdkB4WC6PhtkyOhkXCbHl23feCW95TuBu8xOnulB8gIQDGKrbrj
         AM26pqQeUeed27RHeyuerekFqWNWgAjMUMhTWyat8lcd7CZjmwMND94X5ETFiQRxHlhJ
         llm7KiZfDk4mhE4UI2lhldTTX5VsajYLonBxObnYsW6xsOj01aqxdiHQUL2ox5C7xpjN
         2tKEyPxfwmM65g0hJ6C/KAq+hBk1XJHpqKClmIwycgIucA91NypwA98f8dKSKykNuJ/C
         toQNVySMDZMpQwHw6Nek1isK4are722wYjDxC29tVsJSxBSjwtXqYhSInKnXfidXdp15
         B+OA==
X-Gm-Message-State: AMCzsaW3HE+fJuaa69LF7IG3GZUwgezy+qHyHU+ko0M/ouUbiRp3YSY5
        uiW2PFIiLC/4cK7V3NO467pk9A==
X-Google-Smtp-Source: ABhQp+SgTOA+x19EQP0yVc0ORHpeFNlheUbhlOmIjdB7o03ttCvnPynW2AyMH9+kn0j8NNo4iXAraw==
X-Received: by 10.107.97.1 with SMTP id v1mr5769253iob.263.1509651720878;
        Thu, 02 Nov 2017 12:42:00 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1093:e9fc:3ec5:201d])
        by smtp.gmail.com with ESMTPSA id w8sm1861259iod.26.2017.11.02.12.41.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Nov 2017 12:42:00 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info, schwab@linux-m68k.org
Subject: [PATCHv3 3/7] revision.h: introduce blob/tree walking in order of the commits
Date:   Thu,  2 Nov 2017 12:41:44 -0700
Message-Id: <20171102194148.2124-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.7.g980e40477f
In-Reply-To: <20171102194148.2124-1-sbeller@google.com>
References: <20171031211852.13001-1-sbeller@google.com>
 <20171102194148.2124-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The functionality to list tree objects in the order they were seen
while traversing the commits will be used in the next commit,
where we teach `git describe` to describe not only commits, but
trees and blobs, too.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/rev-list-options.txt |  5 ++++
 list-objects.c                     |  2 ++
 revision.c                         |  2 ++
 revision.h                         |  3 ++-
 t/t6100-rev-list-in-order.sh       | 47 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100755 t/t6100-rev-list-in-order.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 13501e1556..9066e0c777 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -686,6 +686,11 @@ ifdef::git-rev-list[]
 	all object IDs which I need to download if I have the commit
 	object _bar_ but not _foo_''.
 
+--in-commit-order::
+	Print tree and blob ids in order of the commits. The tree
+	and blob ids are printed after they are first referenced
+	by a commit.
+
 --objects-edge::
 	Similar to `--objects`, but also print the IDs of excluded
 	commits prefixed with a ``-'' character.  This is used by
diff --git a/list-objects.c b/list-objects.c
index 7c2ce9c4bd..07a92f35fe 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -239,6 +239,8 @@ void traverse_commit_list(struct rev_info *revs,
 		if (commit->tree)
 			add_pending_tree(revs, commit->tree);
 		show_commit(commit, data);
+		if (revs->tree_blobs_in_commit_order)
+			traverse_trees_and_blobs(revs, &csp, show_object, data);
 	}
 	traverse_trees_and_blobs(revs, &csp, show_object, data);
 
diff --git a/revision.c b/revision.c
index d167223e69..9329d4ebbf 100644
--- a/revision.c
+++ b/revision.c
@@ -1845,6 +1845,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->dense = 0;
 	} else if (!strcmp(arg, "--show-all")) {
 		revs->show_all = 1;
+	} else if (!strcmp(arg, "--in-commit-order")) {
+		revs->tree_blobs_in_commit_order = 1;
 	} else if (!strcmp(arg, "--remove-empty")) {
 		revs->remove_empty_trees = 1;
 	} else if (!strcmp(arg, "--merges")) {
diff --git a/revision.h b/revision.h
index 54761200ad..86985d68aa 100644
--- a/revision.h
+++ b/revision.h
@@ -121,7 +121,8 @@ struct rev_info {
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1,
-			line_level_traverse:1;
+			line_level_traverse:1,
+			tree_blobs_in_commit_order:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
diff --git a/t/t6100-rev-list-in-order.sh b/t/t6100-rev-list-in-order.sh
new file mode 100755
index 0000000000..d4d539b0da
--- /dev/null
+++ b/t/t6100-rev-list-in-order.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='rev-list testing in-commit-order'
+
+. ./test-lib.sh
+
+test_expect_success 'rev-list --in-commit-order' '
+	for x in one two three four
+	do
+		echo $x >$x &&
+		git add $x &&
+		git commit -m "add file $x" ||
+		return 1
+	done &&
+	for x in four three
+	do
+		git rm $x &&
+		git commit -m "remove $x" ||
+		return 1
+	done &&
+	git rev-list --in-commit-order --objects HEAD >actual.raw &&
+	cut -c 1-40 >actual <actual.raw &&
+
+	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
+		HEAD^{commit}
+		HEAD^{tree}
+		HEAD^{tree}:one
+		HEAD^{tree}:two
+		HEAD~1^{commit}
+		HEAD~1^{tree}
+		HEAD~1^{tree}:three
+		HEAD~2^{commit}
+		HEAD~2^{tree}
+		HEAD~2^{tree}:four
+		HEAD~3^{commit}
+		# HEAD~3^{tree} skipped, same as HEAD~1^{tree}
+		HEAD~4^{commit}
+		# HEAD~4^{tree} skipped, same as HEAD^{tree}
+		HEAD~5^{commit}
+		HEAD~5^{tree}
+	EOF
+	grep -v "#" >expect <expect.raw &&
+
+	test_cmp expect actual
+'
+
+test_done
-- 
2.15.0.7.g980e40477f

