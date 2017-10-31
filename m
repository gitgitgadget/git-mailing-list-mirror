Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC85520437
	for <e@80x24.org>; Tue, 31 Oct 2017 21:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbdJaVTE (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 17:19:04 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:49979 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbdJaVS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 17:18:58 -0400
Received: by mail-io0-f194.google.com with SMTP id n137so1886540iod.6
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 14:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C7Z76F09clbXx+JXFqgPHRlZSmvidO8OXGexe/vORIw=;
        b=IK0DvMTaW0SBVEm753qeuSUjU8vuGD3Mf585JOFuFuQ5d0iE3NQneNwK/4RUNMAWmF
         tJev5UQewFrzSUqY1YQG7FkQgcKdVGasZ9UtlSjdvOFmKBrKrxXMluwLhdaYM1TZcWFl
         c997SSclxLTkJN/2V/D301oQtUsgQ/pqVXZAbYXwJdnkId+LnZN5EQJoPq6ELqgVHylY
         O2hVJSn9OGmeh60wxZIGMtBicfKFRl+TYOwWCsz9x+aWlYsMVCX3MPCNSsmA7LzAsLsX
         YLNqLtHBha2Rz15WUdqaXqoEHveoTd9m9WjHINkK/H7vOe+F2WbtztfPBG8PBKj2fPg7
         rDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C7Z76F09clbXx+JXFqgPHRlZSmvidO8OXGexe/vORIw=;
        b=jyqAroRYgfxbg3n7B1Xk1dzRb4jGPkBvfC48nbHqhmwyOy4XqjGpI2x2Zgct/9Au8d
         UohuYPlDFpo/3Q3OgelqbxCGz/SvE4ZidH1n0sWm6A04FTxJoDSV0R1N4jv2rDaSSe2q
         0wbcGjdIppc8aAEgvXyDzujAsXyJg1OaUY20Nh3izss8FlHYYMN6/aIwQbnkcYP4kjnh
         HMeqC6bGgN2XnrdFtTqx1Oc0b1qv19XHUb6f0ec3QnjAJ6qLqMduQAjVZwfCfJQOqy2A
         7oBOGrmk1MgtJi8YuCD9B4FlYWNDrtX81z48JnUojlqrJKz4xWryHOkGYdaz1XLlEzOQ
         a0vg==
X-Gm-Message-State: AMCzsaUIfbHRO+ufZ4SDjHLQUKuQZsRhTn2mfD0wcbQU1QAtoHcquvrT
        iSb1SQIJDPM0DjN+Amz2PcR6Lw==
X-Google-Smtp-Source: ABhQp+Tni45cNq4T3oSoaNi5tpwELYi7wi3OItONAm7TIPO62VOz63LuaG5ByzFWzRPSC0RGKYzMUQ==
X-Received: by 10.36.43.13 with SMTP id h13mr5144930ita.8.1509484737540;
        Tue, 31 Oct 2017 14:18:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:55a5:57f1:5248:2d32])
        by smtp.gmail.com with ESMTPSA id u187sm1068112iod.22.2017.10.31.14.18.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 14:18:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info
Subject: [PATCHv2 2/7] revision.h: introduce blob/tree walking in order of the commits
Date:   Tue, 31 Oct 2017 14:18:47 -0700
Message-Id: <20171031211852.13001-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171031211852.13001-1-sbeller@google.com>
References: <20171031003351.22341-1-sbeller@google.com>
 <20171031211852.13001-1-sbeller@google.com>
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
 Documentation/rev-list-options.txt |  5 +++++
 list-objects.c                     |  2 ++
 revision.c                         |  2 ++
 revision.h                         |  3 ++-
 t/t6100-rev-list-in-order.sh       | 46 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 1 deletion(-)
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
index ef9dbe8f92..03438e5a8b 100644
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
index 0000000000..651666979b
--- /dev/null
+++ b/t/t6100-rev-list-in-order.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='miscellaneous rev-list tests'
+
+. ./test-lib.sh
+
+
+test_expect_success 'setup' '
+	for x in one two three four
+	do
+		echo $x >$x &&
+		git add $x &&
+		git commit -m "add file $x"
+	done &&
+	for x in four three
+	do
+		git rm $x &&
+		git commit -m "remove $x"
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
+		# HEAD~3^{tree} skipped
+		HEAD~4^{commit}
+		# HEAD~4^{tree} skipped
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
2.15.0.rc2.443.gfcc3b81c0a

