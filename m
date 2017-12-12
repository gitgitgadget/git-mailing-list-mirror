Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848151F404
	for <e@80x24.org>; Tue, 12 Dec 2017 01:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbdLLBY2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 20:24:28 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:45043 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdLLBY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 20:24:27 -0500
Received: by mail-it0-f41.google.com with SMTP id b5so20603611itc.3
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 17:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T7Pth6Dizp0xUlE4BYwESNAYkYyFiN1fFuruoQKpT10=;
        b=OV/ELDrBi58EirgcCoosz6LBReoQT9v9h5exVDGD8dckZoJB+wazNTJPpAcCKOlMWX
         fBITHSINbd/ossxKPMmz7VJJV+ZQibJP0x9kULvwkYAYpAgBPJbnM7I/VitZJZANBTrj
         857DN3jTkhj8Jb3+FZY1dU0KxJJfYyly4twH6RjB6lyEGxPzfZQqgBpXBdSAZn1mq5/G
         054w/Bkx/NZoOYgFc39uQiX0Zgi1vdYDFBXHWvRIU4p6ZZZ+OHWDk1i0x2b42NvKaCJZ
         KP4A3n6gimhkX6uuaWVtuHAw9Wfh7Qo5lapv4WFmtbsNEAxj5ON7qJkNETTXIrpzkt5q
         fkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T7Pth6Dizp0xUlE4BYwESNAYkYyFiN1fFuruoQKpT10=;
        b=jbvlg8aYwgooNmsPvrg1Q94lnRrHecRziJ1V+5vmYx9OregztbCyjs928Qaca7B+AQ
         aOX7dqOzXAJOh0hs+ahSFTR91roN/cIvo8ZklwcpXUE6a3nLRZg8mnXDKpnl8q7XJzvu
         ghBIVq3Xm3N+FNARhosRrI7IKpD0ynxX3tTzTrz636KqHIs4TsXQ4uZPVPxnwSu8v/vr
         7F33sLlw1FjJ5qSp8KvIHrhoWvSDRVpglXRUscnkXnLeu2AkzdtpQEQfpy//7wOU1C4k
         XwRoYN5VeeHxvEoMIbApE5eOp4KZF5wxHS4WLRg++p+Iq3dDNUB28OFk6Pt7Y8IlWZwr
         33gA==
X-Gm-Message-State: AKGB3mLPjjoMkSDHCz3If4LEkhIRsWfGUz37fsTXdq3t4Eq2VITqbkHX
        950WEsn+ns27QZvj7zohUFZqUQ==
X-Google-Smtp-Source: ACJfBosnKSbku9F/OB8jN/TnAS9YWDFUJ/vcx9K1ylsKcOLG/7Gm7gDs8Y2mpBoyFZzb9Nz7AFbVzA==
X-Received: by 10.36.115.79 with SMTP id y76mr402067itb.144.1513041866045;
        Mon, 11 Dec 2017 17:24:26 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id s2sm297493ioa.45.2017.12.11.17.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Dec 2017 17:24:25 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH] diffcore: add a filter to find a specific blob
Date:   Mon, 11 Dec 2017 17:24:22 -0800
Message-Id: <20171212012422.123332-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.504.g5279b80103-goog
In-Reply-To: <CAGZ79kaJgCchQKcRMkW-cjRmx_7eYQDqLs5GgDOgLEb1H=w-0g@mail.gmail.com>
References: <CAGZ79kaJgCchQKcRMkW-cjRmx_7eYQDqLs5GgDOgLEb1H=w-0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes users are given a hash of an object and they want to
identify it further (ex.: Use verify-pack to find the largest blobs,
but what are these? or [1])

One might be tempted to extend git-describe to also work with blobs,
such that `git describe <blob-id>` gives a description as
'<commit-ish>:<path>'.  This was implemented at [2]; as seen by the sheer
number of responses (>110), it turns out this is tricky to get right.
The hard part to get right is picking the correct 'commit-ish' as that
could be the commit that (re-)introduced the blob or the blob that
removed the blob; the blob could exist in different branches.

Junio hinted at a different approach of solving this problem, which this
patch implements. Teach the diff machinery another flag for restricting
the information to what is shown. For example:

  $ ./git log --oneline --find-object=v2.0.0:Makefile
  b2feb64309 Revert the whole "ask curl-config" topic for now
  47fbfded53 i18n: only extract comments marked with "TRANSLATORS:"

we observe that the Makefile as shipped with 2.0 was appeared in
v1.9.2-471-g47fbfded53 and in v2.0.0-rc1-5-gb2feb6430b.  The
reason why these commits both occur prior to v2.0.0 are evil
merges that are not found using this new mechanism.

[1] https://stackoverflow.com/questions/223678/which-commit-has-this-blob
[2] https://public-inbox.org/git/20171028004419.10139-1-sbeller@google.com/

Signed-off-by: Stefan Beller <sbeller@google.com>

asdf

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-options.txt |  6 ++++
 Makefile                       |  1 +
 builtin/log.c                  |  2 +-
 diff.c                         | 20 ++++++++++++-
 diff.h                         |  3 ++
 diffcore-objfind.c             | 42 ++++++++++++++++++++++++++
 diffcore.h                     |  1 +
 revision.c                     |  5 +++-
 t/t4064-diff-oidfind.sh        | 68 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 145 insertions(+), 3 deletions(-)
 create mode 100644 diffcore-objfind.c
 create mode 100755 t/t4064-diff-oidfind.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index dd0dba5b1d..21d1776996 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -500,6 +500,12 @@ information.
 --pickaxe-regex::
 	Treat the <string> given to `-S` as an extended POSIX regular
 	expression to match.
+
+--find-object=<object-id>::
+	Restrict the output such that one side of the diff
+	matches the given object id. The object can be a blob,
+	gitlink entry or tree (when `-t` is given).
+
 endif::git-format-patch[]
 
 -O<orderfile>::
diff --git a/Makefile b/Makefile
index ee9d5eb11e..c26596c30a 100644
--- a/Makefile
+++ b/Makefile
@@ -775,6 +775,7 @@ LIB_OBJS += date.o
 LIB_OBJS += decorate.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
+LIB_OBJS += diffcore-objfind.o
 LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
diff --git a/builtin/log.c b/builtin/log.c
index 6c1fa896ad..08ea82d69f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -181,7 +181,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		init_display_notes(&rev->notes_opt);
 
 	if (rev->diffopt.pickaxe || rev->diffopt.filter ||
-	    rev->diffopt.flags.follow_renames)
+	    rev->diffopt.flags.follow_renames || rev->diffopt.objfind)
 		rev->always_show_header = 0;
 
 	if (source)
diff --git a/diff.c b/diff.c
index 0763e89263..e13b8229d3 100644
--- a/diff.c
+++ b/diff.c
@@ -4082,6 +4082,7 @@ void diff_setup(struct diff_options *options)
 	options->interhunkcontext = diff_interhunk_context_default;
 	options->ws_error_highlight = ws_error_highlight_default;
 	options->flags.rename_empty = 1;
+	options->objfind = NULL;
 
 	/* pathchange left =NULL by default */
 	options->change = diff_change;
@@ -4487,6 +4488,19 @@ static int parse_ws_error_highlight_opt(struct diff_options *opt, const char *ar
 	return 1;
 }
 
+static int parse_objfind_opt(struct diff_options *opt, const char *arg)
+{
+	struct object_id oid;
+
+	if (get_oid(arg, &oid))
+		return error("unable to resolve '%s'", arg);
+
+	if (!opt->objfind)
+		opt->objfind = xcalloc(1, sizeof(*opt->objfind));
+	oidset_insert(opt->objfind, &oid);
+	return 1;
+}
+
 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
@@ -4736,7 +4750,8 @@ int diff_opt_parse(struct diff_options *options,
 	else if ((argcount = short_opt('O', av, &optarg))) {
 		options->orderfile = prefix_filename(prefix, optarg);
 		return argcount;
-	}
+	} else if (skip_prefix(arg, "--find-object=", &arg))
+		return parse_objfind_opt(options, arg);
 	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
 		int offending = parse_diff_filter_opt(optarg, options);
 		if (offending)
@@ -5770,6 +5785,9 @@ void diffcore_std(struct diff_options *options)
 		diffcore_skip_stat_unmatch(options);
 	if (!options->found_follow) {
 		/* See try_to_follow_renames() in tree-diff.c */
+
+		if (options->objfind)
+			diffcore_objfind(options);
 		if (options->break_opt != -1)
 			diffcore_break(options->break_opt);
 		if (options->detect_rename)
diff --git a/diff.h b/diff.h
index 0fb18dd735..8fa2ad8e2d 100644
--- a/diff.h
+++ b/diff.h
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "pathspec.h"
 #include "object.h"
+#include "oidset.h"
 
 struct rev_info;
 struct diff_options;
@@ -174,6 +175,8 @@ struct diff_options {
 	enum diff_words_type word_diff;
 	enum diff_submodule_format submodule_format;
 
+	struct oidset *objfind;
+
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
 
diff --git a/diffcore-objfind.c b/diffcore-objfind.c
new file mode 100644
index 0000000000..676bbfff00
--- /dev/null
+++ b/diffcore-objfind.c
@@ -0,0 +1,42 @@
+/*
+ * Copyright (c) 2017 Google Inc.
+ */
+#include "cache.h"
+#include "diff.h"
+#include "diffcore.h"
+
+static void diffcore_filter_blobs(struct diff_queue_struct *q,
+				  struct diff_options *options)
+{
+	int src, dst;
+
+	if (!options->objfind)
+		BUG("objfind oidset not initialized???");
+
+	for (src = dst = 0; src < q->nr; src++) {
+		struct diff_filepair *p = q->queue[src];
+
+		if (!DIFF_PAIR_UNMERGED(p) &&
+		    ((DIFF_FILE_VALID(p->one) &&
+		     oidset_contains(options->objfind, &p->one->oid)) ||
+		    (DIFF_FILE_VALID(p->two) &&
+		     oidset_contains(options->objfind, &p->two->oid)))) {
+			q->queue[dst] = p;
+			dst++;
+		} else {
+			diff_free_filepair(p);
+		}
+	}
+
+	if (!dst) {
+		free(q->queue);
+		DIFF_QUEUE_CLEAR(q);
+	} else {
+		q->nr = dst;
+	}
+}
+
+void diffcore_objfind(struct diff_options *options)
+{
+	diffcore_filter_blobs(&diff_queued_diff, options);
+}
diff --git a/diffcore.h b/diffcore.h
index a30da161da..cbde777bdd 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -107,6 +107,7 @@ extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
 					struct diff_filespec *);
 extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
+extern void diffcore_objfind(struct diff_options *);
 extern void diffcore_break(int);
 extern void diffcore_rename(struct diff_options *);
 extern void diffcore_merge_broken(void);
diff --git a/revision.c b/revision.c
index e2e691dd5a..0a797bdfc7 100644
--- a/revision.c
+++ b/revision.c
@@ -2409,7 +2409,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	/* Pickaxe, diff-filter and rename following need diffs */
 	if (revs->diffopt.pickaxe ||
 	    revs->diffopt.filter ||
-	    revs->diffopt.flags.follow_renames)
+	    revs->diffopt.flags.follow_renames ||
+	    revs->diffopt.objfind)
 		revs->diff = 1;
 
 	if (revs->topo_order)
@@ -2883,6 +2884,8 @@ int prepare_revision_walk(struct rev_info *revs)
 		simplify_merges(revs);
 	if (revs->children.name)
 		set_children(revs);
+	if (revs->diffopt.objfind)
+		revs->simplify_history = 0;
 	return 0;
 }
 
diff --git a/t/t4064-diff-oidfind.sh b/t/t4064-diff-oidfind.sh
new file mode 100755
index 0000000000..3bdf317af8
--- /dev/null
+++ b/t/t4064-diff-oidfind.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description='test finding specific blobs in the revision walking'
+. ./test-lib.sh
+
+test_expect_success 'setup ' '
+	git commit --allow-empty -m "empty initial commit" &&
+
+	echo "Hello, world!" >greeting &&
+	git add greeting &&
+	git commit -m "add the greeting blob" && # borrowed from Git from the Bottom Up
+	git tag -m "the blob" greeting $(git rev-parse HEAD:greeting) &&
+
+	echo asdf >unrelated &&
+	git add unrelated &&
+	git commit -m "unrelated history" &&
+
+	git revert HEAD^ &&
+
+	git commit --allow-empty -m "another unrelated commit"
+'
+
+test_expect_success 'find the greeting blob' '
+	cat >expect <<-EOF &&
+	Revert "add the greeting blob"
+	add the greeting blob
+	EOF
+
+	git log --format=%s --find-object=greeting^{blob} >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'setup a tree' '
+	mkdir a &&
+	echo asdf >a/file &&
+	git add a/file &&
+	git commit -m "add a file in a subdirectory"
+'
+
+test_expect_success 'find a tree' '
+	cat >expect <<-EOF &&
+	add a file in a subdirectory
+	EOF
+
+	git log --format=%s -t --find-object=HEAD:a >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'setup a submodule' '
+	test_create_repo sub &&
+	test_commit -C sub sub &&
+	git submodule add ./sub sub &&
+	git commit -a -m "add sub"
+'
+
+test_expect_success 'find a submodule' '
+	cat >expect <<-EOF &&
+	add sub
+	EOF
+
+	git log --format=%s --find-object=HEAD:sub >actual &&
+
+	test_cmp expect actual
+'
+
+test_done
-- 
2.15.1.504.g5279b80103-goog

