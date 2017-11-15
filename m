Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C481202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 00:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756654AbdKOAbX (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 19:31:23 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:51778 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755106AbdKOAbD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 19:31:03 -0500
Received: by mail-io0-f172.google.com with SMTP id g73so10786058ioj.8
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 16:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9kgPDtib2S4SokN0XgUK336XOYHkgvO4PVk734rVQmU=;
        b=rgiWIHjIFSy/PQvctG5jfJUyNyo2SCCck6OaY5cVU2pBDvSmSdB1huA6jstP4UGfit
         PYynWd3+4Nu6Jw+CVzELzVAUw5oTaqRD+sFKz9w9wEI/JLn75mcEHqVvOiFzqdCp/C4A
         9FRqhMtdLqL0K0ICVY7atoMhNjquUyP2QhCplzCYgfBWk+Q0n37v8ddL7NqwXDbhUziZ
         vHDep8aQTw0GeETfpzM/MOzgRL2Ya5KVIjKEFJBSjyocgSQY7FxxC/4U1e+iM8nAGK+x
         3WobcEA+l7kuEUqkkVEFRi8uHeE1jEIY/CEVF0at1MmFB4bWrLgUjKw1Hb4+2pbxGo7O
         nGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9kgPDtib2S4SokN0XgUK336XOYHkgvO4PVk734rVQmU=;
        b=BoD0kDFHHlHcNDgDfER/HwPuihvzAHFd4owN37cxJsAtgOXGUhZaK4WIz6d4f8mYmL
         HcackOS6kL5SttKlaS0P1dptqFGB1EKm+RJ46vS7G/gARUiH/xeYaV0uk1L/2qjZAKRF
         KTABlBqoH18PvZrxYmkYoYeAoKmWNQVdniU0Xkd/tHfbj/ERlLuh1nPo4OHymrnxBv17
         6wkyYOpwU91gj+KtMdXSM53zKXySTOI/XiBaiv0ofBzCWuPTlAtueqGSHbrwmz9KsUES
         iIwcXJesbdXNcxse9/ZfV9PmB8VgFKZ8Z//l+6rCrHZIdICgfE7PeYvLhtIk06RBLQt5
         Gt4A==
X-Gm-Message-State: AJaThX61IIitfr8je76SEpd/LVYg5YXq+K8MHm+/1p6UgU6gXAZ2ySo0
        Hl9R890VJyb3KZwcZ2OEEAkeDXokGUs=
X-Google-Smtp-Source: AGs4zMaK3Su3Jt9EUTWofgIJrjec5vPNBZk0byMZFNbDQD7Xo2WNEoYqwPEfn6EKsCSMmPKRf8mh4g==
X-Received: by 10.107.10.69 with SMTP id u66mr734686ioi.230.1510705861005;
        Tue, 14 Nov 2017 16:31:01 -0800 (PST)
Received: from localhost ([2620:0:100e:422:c9fb:9110:c737:8943])
        by smtp.gmail.com with ESMTPSA id h95sm8983541ioi.36.2017.11.14.16.30.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Nov 2017 16:31:00 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 7/7] builtin/describe.c: describe a blob
Date:   Tue, 14 Nov 2017 16:30:43 -0800
Message-Id: <20171115003043.24080-8-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171115003043.24080-1-sbeller@google.com>
References: <20171115003043.24080-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes users are given a hash of an object and they want to
identify it further (ex.: Use verify-pack to find the largest blobs,
but what are these? or [1])

When describing commits, we try to anchor them to tags or refs, as these
are conceptually on a higher level than the commit. And if there is no ref
or tag that matches exactly, we're out of luck.  So we employ a heuristic
to make up a name for the commit. These names are ambiguous, there might
be different tags or refs to anchor to, and there might be different
path in the DAG to travel to arrive at the commit precisely.

When describing a blob, we want to describe the blob from a higher layer
as well, which is a tuple of (commit, deep/path) as the tree objects
involved are rather uninteresting.  The same blob can be referenced by
multiple commits, so how we decide which commit to use?  This patch
implements a rather naive approach on this: As there are no back pointers
from blobs to commits in which the blob occurs, we'll start walking from
any tips available, listing the blobs in-order of the commit and once we
found the blob, we'll take the first commit that listed the blob. For
example

  git describe --tags v0.99:Makefile
  conversion-901-g7672db20c2:Makefile

tells us the Makefile as it was in v0.99 was introduced in commit 7672db20.

The walking is performed in reverse order to show the introduction of a
blob rather than its last occurrence.

[1] https://stackoverflow.com/questions/223678/which-commit-has-this-blob

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-describe.txt | 13 ++++++++-
 builtin/describe.c             | 66 ++++++++++++++++++++++++++++++++++++++----
 t/t6120-describe.sh            | 19 ++++++++++++
 3 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index c924c945ba..a25443ca91 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -3,7 +3,7 @@ git-describe(1)
 
 NAME
 ----
-git-describe - Describe a commit using the most recent tag reachable from it
+git-describe - Describe a commit or blob using the graph relations
 
 
 SYNOPSIS
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
 'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
+'git describe' <blob>
 
 DESCRIPTION
 -----------
@@ -24,6 +25,16 @@ By default (without --all or --tags) `git describe` only shows
 annotated tags.  For more information about creating annotated tags
 see the -a and -s options to linkgit:git-tag[1].
 
+If the given object refers to a blob, it will be described
+as `<commit-ish>:<path>`, such that the blob can be found
+at `<path>` in the `<commit-ish>`. Note, that the commit is likely
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
index 9e9a5ed5d4..a2a5fdc48d 100644
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
@@ -434,6 +436,57 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		strbuf_addstr(dst, suffix);
 }
 
+struct process_commit_data {
+	struct object_id current_commit;
+	struct object_id looking_for;
+	struct strbuf *dst;
+	struct rev_info *revs;
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
+		pcd->revs->max_count = 0;
+	}
+}
+
+static void describe_blob(struct object_id oid, struct strbuf *dst)
+{
+	struct rev_info revs;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct process_commit_data pcd = { null_oid, oid, dst, &revs};
+
+	argv_array_pushl(&args, "internal: The first arg is not parsed",
+		"--all", "--reflog", /* as many starting points as possible */
+		/* NEEDSWORK: --all is incompatible with worktrees for now: */
+		"--single-worktree",
+		"--objects",
+		"--in-commit-order",
+		"--reverse",
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
@@ -445,11 +498,14 @@ static void describe(const char *arg, int last_one)
 
 	if (get_oid(arg, &oid))
 		die(_("Not a valid object name %s"), arg);
-	cmit = lookup_commit_reference(&oid);
-	if (!cmit)
-		die(_("%s is not a valid '%s' object"), arg, commit_type);
+	cmit = lookup_commit_reference_gently(&oid, 1);
 
-	describe_commit(&oid, &sb);
+	if (cmit)
+		describe_commit(&oid, &sb);
+	else if (lookup_blob(&oid))
+		describe_blob(oid, &sb);
+	else
+		die(_("%s is neither a commit nor blob"), arg);
 
 	puts(sb.buf);
 
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index c8b7ed82d9..ec4f25d009 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -310,6 +310,25 @@ test_expect_success 'describe ignoring a broken submodule' '
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
+test_expect_success 'describe a blob with its last introduction' '
+	git commit --allow-empty -m "empty commit" &&
+	git rm file &&
+	git commit -m "delete blob" &&
+	git revert HEAD &&
+	git commit --allow-empty -m "empty commit" &&
+	git describe HEAD:file >actual &&
+	grep unique-file-3-g actual
+'
+
 test_expect_failure ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
 	i=1 &&
 	while test $i -lt 8000
-- 
2.15.0.128.gcadd42da22

