Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2171C1FAED
	for <e@80x24.org>; Tue, 31 Oct 2017 00:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753787AbdJaAef (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 20:34:35 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:52098 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbdJaAeD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 20:34:03 -0400
Received: by mail-io0-f195.google.com with SMTP id b186so31329815iof.8
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 17:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aOv4ngxE26tIqN/GrPrEHukNh+faPKmhiWnXlAk6vFQ=;
        b=a7O3fcfiC70rqG+Q76jJXg0PK7hK5eiY7WfZxmxkA0vT4CDZUdnFQqaLMnXqRwqJQB
         yIVCMuCHm1pwf/nfKQOQ1C2zsTWZDDCTDxvkxxW7cZIEBa/izB0WZuFu+YH5T8CSXR8T
         11OFu79rRHo3eJ+1B67txR4QsDpVCj6Cm/SGJGLcAI79MkeB3QfZJuK2tTqNuMph+UyR
         718cetrF1hyOXc5DVH4SE7lxM2KoPfpACCsAfGf4PseF6zkLZL+Yz/HSkuODtroCBG8T
         hqrYtlHrf9amPtiKbPX7CLNTPPpyQR7ezFt5m5JGmXpRiKXEeotPotWQmKzbDL/AZ18V
         Q4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aOv4ngxE26tIqN/GrPrEHukNh+faPKmhiWnXlAk6vFQ=;
        b=dJnUMkrrmERuJtoVIVRFOMgGsj8Q/S5Uharfy/2SRmGODb/19DFANbrX+G2S+2MXnv
         M/Dq726lcljGyDDj0W/dICrYNXKxQ9rzl1ZgMLXYsQMeD2thIrEvmHC+KI6s/xJudTC+
         TAfMeuHzmtPgyGBwx7m2ptzd9jpNhBGgfD24zF5BtKYDIHLbGizqsNdbvYtAvtZ3dATn
         xDbmq/y3g4yIyikj4Y23vuS1cdqV9KYneSlXE7/6FI4O7WlkfjWKBA/0XMQ6urbe6CGs
         DPsAsoQ27tfcNt1tPrxw4x148VuvI81u+9dIV/d2X2mrFSUVFFfUY39GEwvHHeq/Kqn8
         1FeQ==
X-Gm-Message-State: AMCzsaWi493GFdf+QqUzsxZZSuet66ZElkmfveIHk59dGvurhmNqH59k
        VGAriovvgshDNQrWo14nhqVO5Q==
X-Google-Smtp-Source: ABhQp+SYXba9voEf0OggAPUk7VrE8f2pWRWrW7PdR76+KLcu3eX8G4CBCbbnOl+82WljZydT1FT+yA==
X-Received: by 10.107.139.144 with SMTP id n138mr198027iod.173.1509410042911;
        Mon, 30 Oct 2017 17:34:02 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:58cb:1473:3cb:a95f])
        by smtp.gmail.com with ESMTPSA id f16sm94844ioi.30.2017.10.30.17.34.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 17:34:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH 2/7] revision.h: introduce blob/tree walking in order of the commits
Date:   Mon, 30 Oct 2017 17:33:46 -0700
Message-Id: <20171031003351.22341-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171031003351.22341-1-sbeller@google.com>
References: <20171028004419.10139-1-sbeller@google.com>
 <20171031003351.22341-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The functionality to list tree objects in the order they were seen
while traversing the commits will be used in the next commit,
where we teach `git describe` to describe not only commits, but
trees and blobs, too.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 list-objects.c               |  2 ++
 revision.c                   |  2 ++
 revision.h                   |  3 ++-
 t/t6100-rev-list-in-order.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100755 t/t6100-rev-list-in-order.sh

diff --git a/list-objects.c b/list-objects.c
index bf46f80dff..5e114c9a8a 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -237,6 +237,8 @@ void traverse_commit_list(struct rev_info *revs,
 		if (commit->tree)
 			add_pending_tree(revs, commit->tree);
 		show_commit(commit, data);
+		if (revs->tree_blobs_in_commit_order)
+			traverse_trees_and_blobs(revs, &base_path, show_object, data);
 	}
 	traverse_trees_and_blobs(revs, &base_path, show_object, data);
 
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
index 0000000000..67ebe815d2
--- /dev/null
+++ b/t/t6100-rev-list-in-order.sh
@@ -0,0 +1,44 @@
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
+		git rm $x
+		git commit -m "remove $x"
+	done &&
+	git rev-list --in-commit-order --objects HEAD >actual.raw &&
+	cut -c 1-40 > actual < actual.raw &&
+
+	>expect &&
+	git rev-parse HEAD^{commit}       >>expect &&
+	git rev-parse HEAD^{tree}         >>expect &&
+	git rev-parse HEAD^{tree}:one     >>expect &&
+	git rev-parse HEAD^{tree}:two     >>expect &&
+	git rev-parse HEAD~1^{commit}     >>expect &&
+	git rev-parse HEAD~1^{tree}       >>expect &&
+	git rev-parse HEAD~1^{tree}:three >>expect &&
+	git rev-parse HEAD~2^{commit}     >>expect &&
+	git rev-parse HEAD~2^{tree}       >>expect &&
+	git rev-parse HEAD~2^{tree}:four  >>expect &&
+	git rev-parse HEAD~3^{commit}     >>expect &&
+	# skip HEAD~3^{tree}
+	git rev-parse HEAD~4^{commit}     >>expect &&
+	# skip HEAD~4^{tree}
+	git rev-parse HEAD~5^{commit}     >>expect &&
+	git rev-parse HEAD~5^{tree}       >>expect &&
+
+	test_cmp expect actual
+'
+
+test_done
-- 
2.15.0.rc2.443.gfcc3b81c0a

