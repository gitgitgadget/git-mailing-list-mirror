Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3AD201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 02:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758309AbdKPCAu (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 21:00:50 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:39041 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753507AbdKPCAs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 21:00:48 -0500
Received: by mail-it0-f66.google.com with SMTP id y15so4120748ita.4
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 18:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pQUJ/6tGIR3uF8mN5lWW1eE1Pipxexk3CzYkTldljYY=;
        b=JD4VW+MlZvq4KbjDKvOZOLLf7lL4cw0ZQDtZ7Hs0WRXYOH1RNxiNkUr7vSXi8IQb3q
         KGMOFURhM8gmobd829qpWMW7DQ1QPRm0a5236e+gIX1l0sC311iNkT7jJuQeC381TtVx
         d5i//pXvn/2upfHTpgHMFLf63+BYCEcZdyqcnd2ELAcfELjOQIoxkr0SXAy0ZtR6WL0Q
         uCsY92UmCGhD6+B31Ev6VCjDVR+I/Aj07Ul+Ehn2vk+AOuJN/aixT8zFR8rVTEhU5/zQ
         alVxGB4a6byExo+rSFccHnUrCtJk5iPcpO1s3GdTElDHX3s3vwE6o/dj5vxIEaT0Yl4Q
         vBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pQUJ/6tGIR3uF8mN5lWW1eE1Pipxexk3CzYkTldljYY=;
        b=tBnaZf8aarEc43AjQW9G/syqemSmyhxV+u+Reg9KYohtwsYfCRRRB4RflaXd5KCsxd
         YKzhdCS/r3zgQE6DU1qXoUi4qHHQ9O460NDEmoeTwXeo6vDzVN6rp+sQ64EY/tXp4hAq
         ADcw0CdZeOzJcM7rH2yoy647G8uKF9Jug/wqIJgGbC0cj1K76bSso6eay4iVH4x7X+uO
         7qVKCnGK1yatapSNzZvIaK0U6SMp3dU16s+StSek+knrSha3WRa6sPJSMo+CWKABmM5Y
         z98egW81/T6vh6hAPgJzmZHC9+hs2/R4MOkq9+TtDTtisu5pQGjoNSQAY9f+1HjYvePm
         yt8g==
X-Gm-Message-State: AJaThX497xxMjBO5+1gyOBW7i/53sa9cYr6H8l3DAbjldQeE90jlOGn/
        c1dU7DjcabauDhbNUCaCPpoiSpOCWws=
X-Google-Smtp-Source: AGs4zMbWdGJtEuYbpDCkE/QEBn1zO2k/KaUzhrzWHxosXVeTz0IcbSCtp9PNrMuP7XumuLLOXq90Lw==
X-Received: by 10.36.74.135 with SMTP id k129mr538752itb.147.1510797647704;
        Wed, 15 Nov 2017 18:00:47 -0800 (PST)
Received: from localhost ([2620:0:100e:422:34c9:3de6:9af7:a340])
        by smtp.gmail.com with ESMTPSA id c132sm11626ioc.5.2017.11.15.18.00.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Nov 2017 18:00:46 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 0/7] describe blob
Date:   Wed, 15 Nov 2017 18:00:32 -0800
Message-Id: <20171116020039.17810-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jonathan and Junio for the patient review!

* fixed issues brought up in the last patch, see interdiff below.
  (I found that walking from so many refs as starting points was
   the source of confusion, hence we only want to walk from HEAD
* reworded commit messages from earlier patches
* added a BUGS section to the man page
* took Junios suggestion for the NAME section.

Stefan Beller (7):
  t6120: fix typo in test name
  list-objects.c: factor out traverse_trees_and_blobs
  revision.h: introduce blob/tree walking in order of the commits
  builtin/describe.c: rename `oid` to avoid variable shadowing
  builtin/describe.c: print debug statements earlier
  builtin/describe.c: factor out describe_commit
  builtin/describe.c: describe a blob

 Documentation/git-describe.txt     |  18 +++++-
 Documentation/rev-list-options.txt |   5 ++
 builtin/describe.c                 | 122 ++++++++++++++++++++++++++++---------
 list-objects.c                     |  58 ++++++++++++------
 revision.c                         |   2 +
 revision.h                         |   3 +-
 t/t6100-rev-list-in-order.sh       |  77 +++++++++++++++++++++++
 t/t6120-describe.sh                |  36 ++++++++++-
 8 files changed, 270 insertions(+), 51 deletions(-)
 create mode 100755 t/t6100-rev-list-in-order.sh

-- 
2.15.0.128.gcadd42da22

diff --git c/Documentation/git-describe.txt w/Documentation/git-describe.txt
index a25443ca91..e027fb8c4b 100644
--- c/Documentation/git-describe.txt
+++ w/Documentation/git-describe.txt
@@ -3,8 +3,7 @@ git-describe(1)
 
 NAME
 ----
-git-describe - Describe a commit or blob using the graph relations
-
+git-describe - Give an object a human readable name based on an available ref
 
 SYNOPSIS
 --------
@@ -27,13 +26,9 @@ see the -a and -s options to linkgit:git-tag[1].
 
 If the given object refers to a blob, it will be described
 as `<commit-ish>:<path>`, such that the blob can be found
-at `<path>` in the `<commit-ish>`. Note, that the commit is likely
-not the commit that introduced the blob, but the one that was found
-first; to find the commit that introduced the blob, you need to find
-the commit that last touched the path, e.g.
-`git log <commit-description> -- <path>`.
-As blobs do not point at the commits they are contained in,
-describing blobs is slow as we have to walk the whole graph.
+at `<path>` in the `<commit-ish>`, which itself describes the
+first commit in which this blob occurs in a reverse revision walk
+from HEAD.
 
 OPTIONS
 -------
@@ -197,6 +192,14 @@ selected and output.  Here fewest commits different is defined as
 the number of commits which would be shown by `git log tag..input`
 will be the smallest number of commits possible.
 
+BUGS
+----
+
+Tree objects as well as tag objects not pointing at commits, cannot be described.
+When describing blobs, the lightweight tags pointing at blobs are ignored,
+but the blob is still described as <committ-ish>:<path> despite the lightweight
+tag being favorable.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git c/builtin/describe.c w/builtin/describe.c
index a2a5fdc48d..5b4bfaba3f 100644
--- c/builtin/describe.c
+++ w/builtin/describe.c
@@ -457,7 +457,8 @@ static void process_object(struct object *obj, const char *path, void *data)
 		reset_revision_walk();
 		describe_commit(&pcd->current_commit, pcd->dst);
 		strbuf_addf(pcd->dst, ":%s", path);
-		pcd->revs->max_count = 0;
+		free_commit_list(pcd->revs->commits);
+		pcd->revs->commits = NULL;
 	}
 }
 
@@ -468,12 +469,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 	struct process_commit_data pcd = { null_oid, oid, dst, &revs};
 
 	argv_array_pushl(&args, "internal: The first arg is not parsed",
-		"--all", "--reflog", /* as many starting points as possible */
-		/* NEEDSWORK: --all is incompatible with worktrees for now: */
-		"--single-worktree",
-		"--objects",
-		"--in-commit-order",
-		"--reverse",
+		"--objects", "--in-commit-order", "--reverse", "HEAD",
 		NULL);
 
 	init_revisions(&revs, NULL);
diff --git c/list-objects.c w/list-objects.c
index 07a92f35fe..4caa6fcb77 100644
--- c/list-objects.c
+++ w/list-objects.c
@@ -239,7 +239,13 @@ void traverse_commit_list(struct rev_info *revs,
 		if (commit->tree)
 			add_pending_tree(revs, commit->tree);
 		show_commit(commit, data);
+
 		if (revs->tree_blobs_in_commit_order)
+			/*
+			 * NEEDSWORK: Adding the tree and then flushing it here
+			 * needs a reallocation for each commit. Can we pass the
+			 * tree directory without allocation churn?
+			 */
 			traverse_trees_and_blobs(revs, &csp, show_object, data);
 	}
 	traverse_trees_and_blobs(revs, &csp, show_object, data);
diff --git c/t/t6120-describe.sh w/t/t6120-describe.sh
index ec4f25d009..4668f0058e 100755
--- c/t/t6120-describe.sh
+++ w/t/t6120-describe.sh
@@ -310,7 +310,7 @@ test_expect_success 'describe ignoring a broken submodule' '
 	grep broken out
 '
 
-test_expect_success 'describe a blob at a tag' '
+test_expect_success 'describe a blob at a directly tagged commit' '
 	echo "make it a unique blob" >file &&
 	git add file && git commit -m "content in file" &&
 	git tag -a -m "latest annotated tag" unique-file &&
@@ -319,14 +319,29 @@ test_expect_success 'describe a blob at a tag' '
 	test_cmp expect actual
 '
 
-test_expect_success 'describe a blob with its last introduction' '
+test_expect_success 'describe a blob with its first introduction' '
 	git commit --allow-empty -m "empty commit" &&
 	git rm file &&
 	git commit -m "delete blob" &&
 	git revert HEAD &&
 	git commit --allow-empty -m "empty commit" &&
 	git describe HEAD:file >actual &&
-	grep unique-file-3-g actual
+	echo "unique-file:file" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'describe directly tagged blob' '
+	git tag test-blob unique-file:file &&
+	git describe test-blob >actual &&
+	echo "unique-file:file" >expect &&
+	# suboptimal: we rather want to see "test-blob"
+	test_cmp expect actual
+'
+
+test_expect_success 'describe tag object' '
+	git tag test-blob-1 -a -m msg unique-file:file &&
+	test_must_fail git describe test-blob-1 2>actual &&
+	grep "fatal: test-blob-1 is neither a commit nor blob" actual
 '
 
 test_expect_failure ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
