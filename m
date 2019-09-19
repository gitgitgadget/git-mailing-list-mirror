Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631841F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbfISVrk (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34968 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404911AbfISVrg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so4697966wrt.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aidfjjIqtjD1071Nx/P+hBoOv9Atqlj27rjHxi4imrY=;
        b=fN3PeI3jQrqLa010QNOPekHDSUpY9c2Xbtf4R4VPLemtBOmIBS99GqGYnmkJV3yZgC
         LsTSVfMCIJx+0jMM9vq9+ncOXyI2ZWGMWvKECICs90ACysAn7AdkN0j+wIlbf0WL1Zpd
         Y3sX+K9ROfPyXGfmzvN/IZFh14/h2gMmvs0hVUvUkscXQZB+J3WDg5DbtOY97IOFQ28N
         kn9hNuQjcsZg0oi5LP8rK0/GRiSbeRxL55Q0Pu9swJ60hPoycL24WXlIx5FJW9rUVNr9
         tWUQAVHqvTBYWgD8USOIaNISH4OEB9pyZ8oGpyu+9ozBUH8ExxJ3VcjHGaFu9FsDBbjn
         sLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aidfjjIqtjD1071Nx/P+hBoOv9Atqlj27rjHxi4imrY=;
        b=KNiqbeINk548CiSEnD/QS1w5Rd7SiulFpPx0wcIG8gAFIA2OOeYbnW26P1b9NZ775F
         /ipAt7ROgQ6NFzMz369CPVPBornJlW+ZY3IeJFRUJqwoZuSWFc+XC+I1scJ8cEnrfOTM
         1W6XGcsuMx1mGo6DEU7kxnmXZycM+TR6I6F1foH+jQq6dX7PJ8JRq3ZQB/0VeDOIje8r
         aLM5TCkAFZ2N7GB7NnhYYx1rd6M/1vevg0zsF//LrSGhh+Nk1yC7UugHLpk88c24ZzgY
         CtFu2sOD5O4z5Iu76zyysGuU+h+OxJnxpj5/VdmWvtvH3X9+8zk2t/ugoQmBb8pNa0sW
         1JPQ==
X-Gm-Message-State: APjAAAVWZhJ//XTtFjSo46YjZB6ywr8z+9PTc3QGzhTATB8zPPT/Y5zm
        IQyWgPu8NwPe6LGtLWOywGA=
X-Google-Smtp-Source: APXvYqz6zSXhimMHR5vUxjpHtH996CSIzsLL/3ut47jxNmt3yvWQ9DUyEGGVJhrZeKsaVcmt3U5BMQ==
X-Received: by 2002:adf:f606:: with SMTP id t6mr8651520wrp.197.1568929652199;
        Thu, 19 Sep 2019 14:47:32 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:31 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 12/15] name-rev: eliminate recursion in name_rev()
Date:   Thu, 19 Sep 2019 23:47:07 +0200
Message-Id: <20190919214712.7348-13-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name_rev() function calls itself recursively for each interesting
parent of the commit it got as parameter, and, consequently, it can
segfault when processing a deep history if it exhausts the available
stack space.  E.g. running 'git name-rev --all' and 'git name-rev
HEAD~100000' in the gcc, gecko-dev, llvm, and WebKit repositories
results in segfaults on my machine.

Eliminate the recursion by inserting the interesting parents into a
'commit_list' and iteratating until the list becomes empty.

Note that the order in which the parent commits are added to that list
is important: they must be inserted at the beginning of the list, and
their relative order must be kept as well, because otherwise
performance suffers.

The stacksize-limited test 'name-rev works in a deep repo' in
't6120-describe.sh' demonstrated this issue and expected failure.  Now
the recursion is gone, so flip it to expect success.

Also gone are the dmesg entries logging the segfault of the git
process on every execution of the test suite.

Unfortunately, eliminating the recursion comes with a performance
penaly: 'git name-rev --all' tends to be between 15-20% slower than
before.

Note that this slightly changes the order of lines in the output of
'git name-rev --all', usually swapping two lines every 35 lines in
git.git or every 150 lines in linux.git.  This shouldn't matter in
practice, because the output has always been unordered anyway.

This patch is best viewed with '--ignore-all-space'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c  | 85 ++++++++++++++++++++++++++-------------------
 t/t6120-describe.sh |  2 +-
 2 files changed, 51 insertions(+), 36 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index f2198a8bc3..b6fa495340 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -100,48 +100,63 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 		return NULL;
 }
 
-static void name_rev(struct commit *commit,
+static void name_rev(struct commit *start_commit,
 		const char *tip_name, timestamp_t taggerdate,
 		int from_tag)
 {
-	struct rev_name *name = get_commit_rev_name(commit);
-	struct commit_list *parents;
-	int parent_number = 1;
-
-	for (parents = commit->parents;
-			parents;
-			parents = parents->next, parent_number++) {
-		struct commit *parent = parents->item;
-		const char *new_name;
-		int generation, distance;
-
-		parse_commit(parent);
-		if (parent->date < cutoff)
-			continue;
+	struct commit_list *list = NULL;
+
+	commit_list_insert(start_commit, &list);
+
+	while (list) {
+		struct commit *commit = pop_commit(&list);
+		struct rev_name *name = get_commit_rev_name(commit);
+		struct commit_list *parents, *new_parents = NULL;
+		struct commit_list **last_new_parent = &new_parents;
+		int parent_number = 1;
+
+		for (parents = commit->parents;
+				parents;
+				parents = parents->next, parent_number++) {
+			struct commit *parent = parents->item;
+			const char *new_name;
+			int generation, distance;
+
+			parse_commit(parent);
+			if (parent->date < cutoff)
+				continue;
 
-		if (parent_number > 1) {
-			size_t len;
+			if (parent_number > 1) {
+				size_t len;
+
+				strip_suffix(name->tip_name, "^0", &len);
+				if (name->generation > 0)
+					new_name = xstrfmt("%.*s~%d^%d",
+							   (int)len,
+							   name->tip_name,
+							   name->generation,
+							   parent_number);
+				else
+					new_name = xstrfmt("%.*s^%d", (int)len,
+							   name->tip_name,
+							   parent_number);
+				generation = 0;
+				distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
+			} else {
+				new_name = name->tip_name;
+				generation = name->generation + 1;
+				distance = name->distance + 1;
+			}
 
-			strip_suffix(tip_name, "^0", &len);
-			if (name->generation > 0)
-				new_name = xstrfmt("%.*s~%d^%d", (int)len, tip_name,
-						   name->generation,
-						   parent_number);
-			else
-				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
-						   parent_number);
-			generation = 0;
-			distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
-		} else {
-			new_name = tip_name;
-			generation = name->generation + 1;
-			distance = name->distance + 1;
+			if (create_or_update_name(parent, new_name, taggerdate,
+						  generation, distance,
+						  from_tag))
+				last_new_parent = commit_list_append(parent,
+						  last_new_parent);
 		}
 
-		if (create_or_update_name(parent, new_name, taggerdate,
-					  generation, distance,
-					  from_tag))
-			name_rev(parent, new_name, taggerdate, from_tag);
+		*last_new_parent = list;
+		list = new_parents;
 	}
 }
 
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 2a0f2204c4..e37f02d21c 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -379,7 +379,7 @@ test_expect_success 'describe tag object' '
 	test_i18ngrep "fatal: test-blob-1 is neither a commit nor blob" actual
 '
 
-test_expect_failure ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
+test_expect_success ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
 	i=1 &&
 	while test $i -lt 8000
 	do
-- 
2.23.0.331.g4e51dcdf11

