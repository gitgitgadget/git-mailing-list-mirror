Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED3C61FAED
	for <e@80x24.org>; Tue, 31 Oct 2017 00:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbdJaAeU (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 20:34:20 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:54516 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753751AbdJaAeK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 20:34:10 -0400
Received: by mail-io0-f169.google.com with SMTP id e89so31281370ioi.11
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 17:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2baO7KcVr1mdz+8v2/ctXIMeDZx8x1pRqp937LabIrg=;
        b=cYIuuxZTU7orkT5KPpSsPYwy8w6MOQfa3PW3908mZHxL0l5XEiqbPzqSvlq6GFqd4I
         1rOWgx8wa5lJg+RR9QJnGuB4CwSFR5B04XbbUC3KB+oO91zF8DcNVcERdlPePncZZUx1
         mqb5dkHvJwiYmvKhKa9i60VZ/v3kRz+jvsU81jJM8KQqsNwDYW+umLkHYOaYzaAVxr4t
         Waj2DVUf7F5YQ3NtGGjXjp+ECksIKhM3dPGFzrQOmFu8jyK1NlumQw1x09cw02qyuSbc
         uQN5hJS/Crx+4Bi0X6rbkcSjU+NSxJ1cW0NCMqONa6+AkW6nIrtq0rpgPygqetu73D4S
         ri/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2baO7KcVr1mdz+8v2/ctXIMeDZx8x1pRqp937LabIrg=;
        b=Oegn/7E+cIxalxyXa0YntowaEYHxf7PATQux1cR0WiYH+xy8WERd6mbqSj85WTll4b
         zzUqu2GCEvagRDMFjeg3Pesv4MmYZpUY3nPjmv6+XqsDGFGDBh+yF8vbvIuxTkWFEkcG
         S5nmm8vzfnagpZ9A2zPi3hHMpL4yWHjueAkJxkbgxRv7DutLNFzgZ6I7YfLWu8F5qZCo
         xU7Wz8OhxKD8umKKHrTiBgBEMM74YR5NPjuHBdQg2k8sjN4MHm5hoP61fuFU3hVRqL8K
         sYZr/5PAtQF03LQkWhsbYe5hd6DCa+U5ecCCzwOa0HxIX1gP4e9F/c86m0X2CUzthHpP
         0JZQ==
X-Gm-Message-State: AMCzsaUYg+Xuuho3qqB+l6P5bRbflcSqQrjc9pF1x1t/abyfgqLHl1CV
        JV5iC3BGAly1AoflUqFCGuZGFw==
X-Google-Smtp-Source: ABhQp+Tna/97XEmkbLVpYSsMR7M6AhskoWMLq8IZ82Pqryv/0N7wlE3Yc8ejAZWpftTPJD2ZkjVzig==
X-Received: by 10.36.69.203 with SMTP id c72mr755959itd.134.1509410049294;
        Mon, 30 Oct 2017 17:34:09 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:58cb:1473:3cb:a95f])
        by smtp.gmail.com with ESMTPSA id i71sm91019iod.59.2017.10.30.17.34.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 17:34:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH 6/7] builtin/describe.c: describe a blob
Date:   Mon, 30 Oct 2017 17:33:50 -0700
Message-Id: <20171031003351.22341-7-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171031003351.22341-1-sbeller@google.com>
References: <20171028004419.10139-1-sbeller@google.com>
 <20171031003351.22341-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes users are given a hash of an object and they want to
identify it further (ex.: Use verify-pack to find the largest blobs,
but what are these? or [1])

"This is an interesting endeavor, because describing things is hard."
  -- me, upon writing this patch.

When describing commits, we try to anchor them to tags or refs, as these
are conceptually on a higher level than the commit. And if there is no ref
or tag that matches exactly, we're out of luck.  So we employ a heuristic
to make up a name for the commit. These names are ambivalent, there might
be different tags or refs to anchor to, and there might be different
path in the DAG to travel to arrive at the commit precisely.

When describing a blob, we want to describe the blob from a higher layer
as well, which is a tuple of (commit, deep/path) as the tree objects
involved are rather uninteresting.  The same blob can be referenced by
multiple commits, so how we decide which commit to use?  This patch
implements a rather naive approach on this: As there are no back pointers
from blobs to commits in which the blob occurs, we'll start walking from
any tips available, listing the blobs in-order of the commit and once we
found the blob, we'll take the first commit that listed the blob.  For
source code this is likely not the first commit that introduced the blob,
but rather the latest commit that contained the blob.  For example:

  git describe v0.99:Makefile
  v0.99-5-gab6625e06a:Makefile

tells us the latest commit that contained the Makefile as it was in tag
v0.99 is commit v0.99-5-gab6625e06a (and at the same path), as the next
commit on top v0.99-6-gb1de9de2b9 ([PATCH] Bootstrap "make dist",
2005-07-11) touches the Makefile.

Let's see how this description turns out, if it is useful in day-to-day
use as I have the intuition that we'd rather want to see the *first*
commit that this blob was introduced to the repository (which can be
achieved easily by giving the `--reverse` flag in the describe_blob rev
walk).

[1] https://stackoverflow.com/questions/223678/which-commit-has-this-blob
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-describe.txt | 12 +++++++-
 builtin/describe.c             | 65 ++++++++++++++++++++++++++++++++++++++----
 t/t6120-describe.sh            | 15 ++++++++++
 3 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index c924c945ba..3d618b2445 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -3,7 +3,7 @@ git-describe(1)
 
 NAME
 ----
-git-describe - Describe a commit using the most recent tag reachable from it
+git-describe - Describe a commit or blob using the most recent tag reachable from it
 
 
 SYNOPSIS
@@ -24,6 +24,16 @@ By default (without --all or --tags) `git describe` only shows
 annotated tags.  For more information about creating annotated tags
 see the -a and -s options to linkgit:git-tag[1].
 
+If the given `<commit-ish>` refers to a blob, it will be described
+as `<commit-description>:<path>`, such that the blob can be found
+at `<path>` in the `<commit-ish`. Note, that the commit is likely
+not the commit that introduced the blob, but the one that was found
+first; to find the commit that introduced the blob, you need to find
+the commit that last touched the path, e.g.
+`git log <commit-description> -- <path>`.
+As blobs do not point at the commits they are contained in,
+describing blobs is slow as we have to walk the whole graph.
+
 OPTIONS
 -------
 <commit-ish>...::
diff --git a/builtin/describe.c b/builtin/describe.c
index 9e9a5ed5d4..382cbae908 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -3,6 +3,7 @@
 #include "lockfile.h"
 #include "commit.h"
 #include "tag.h"
+#include "blob.h"
 #include "refs.h"
 #include "builtin.h"
 #include "exec_cmd.h"
@@ -11,8 +12,9 @@
 #include "hashmap.h"
 #include "argv-array.h"
 #include "run-command.h"
+#include "revision.h"
+#include "list-objects.h"
 
-#define SEEN		(1u << 0)
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
@@ -434,6 +436,54 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		strbuf_addstr(dst, suffix);
 }
 
+struct process_commit_data {
+	struct object_id current_commit;
+	struct object_id looking_for;
+	struct strbuf *dst;
+};
+
+static void process_commit(struct commit *commit, void *data)
+{
+	struct process_commit_data *pcd = data;
+	pcd->current_commit = commit->object.oid;
+}
+
+static void process_object(struct object *obj, const char *path, void *data)
+{
+	struct process_commit_data *pcd = data;
+
+	if (!oidcmp(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
+		reset_revision_walk();
+		describe_commit(&pcd->current_commit, pcd->dst);
+		strbuf_addf(pcd->dst, ":%s", path);
+	}
+}
+
+static void describe_blob(struct object_id oid, struct strbuf *dst)
+{
+	struct rev_info revs;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct process_commit_data pcd = { null_oid, oid, dst};
+
+	argv_array_pushl(&args, "internal: The first arg is not parsed",
+		"--all", "--reflog", /* as many starting points as possible */
+		/* NEEDSWORK: --all is incompatible with worktrees for now: */
+		"--single-worktree",
+		"--objects",
+		"--in-commit-order",
+		NULL);
+
+	init_revisions(&revs, NULL);
+	if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
+		BUG("setup_revisions could not handle all args?");
+
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+
+	traverse_commit_list(&revs, process_commit, process_object, &pcd);
+	reset_revision_walk();
+}
+
 static void describe(const char *arg, int last_one)
 {
 	struct object_id oid;
@@ -445,11 +495,16 @@ static void describe(const char *arg, int last_one)
 
 	if (get_oid(arg, &oid))
 		die(_("Not a valid object name %s"), arg);
-	cmit = lookup_commit_reference(&oid);
-	if (!cmit)
-		die(_("%s is not a valid '%s' object"), arg, commit_type);
+	cmit = lookup_commit_reference_gently(&oid, 1);
 
-	describe_commit(&oid, &sb);
+	if (cmit) {
+		describe_commit(&oid, &sb);
+	} else {
+		if (lookup_blob(&oid))
+			describe_blob(oid, &sb);
+		else
+			die(_("%s is neither a commit nor blob"), arg);
+	}
 
 	puts(sb.buf);
 
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 1c0e8659d9..3be01316e8 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -310,6 +310,21 @@ test_expect_success 'describe ignoring a borken submodule' '
 	grep broken out
 '
 
+test_expect_success 'describe a blob at a tag' '
+	echo "make it a unique blob" >file &&
+	git add file && git commit -m "content in file" &&
+	git tag -a -m "latest annotated tag" unique-file &&
+	git describe HEAD:file >actual &&
+	echo "unique-file:file" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'describe a surviving blob' '
+	git commit --allow-empty -m "empty commit" &&
+	git describe HEAD:file >actual &&
+	grep unique-file-1-g actual
+'
+
 test_expect_failure ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
 	i=1 &&
 	while test $i -lt 8000
-- 
2.15.0.rc2.443.gfcc3b81c0a

