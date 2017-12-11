Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF781F404
	for <e@80x24.org>; Mon, 11 Dec 2017 19:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbdLKT7P (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 14:59:15 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:39957 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdLKT7M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 14:59:12 -0500
Received: by mail-it0-f48.google.com with SMTP id f190so18651359ita.5
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 11:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RFWMVJvLAoeTu9TqNSNIzlMj/liK2rSYStrQSpZHUkA=;
        b=ezHyddv9uVCxrjnd2hJTAuQZGIEZVJapf+eqYpGmB7fkWcHxu0iRzVvCDNbQmqwXae
         4tWoJEHyvQ9ONyPJOHCU6unFyfAGh/Ik3eXyc21npBCrcQ0E3SlsZkL1KAYpQ862aDwK
         HptyMGDmZ3gdJFZYa5QS3D1Zq6f1FhFD04us5RvAuafkgJ4lUhj+kpXAJKcHUbWS0Ttn
         ikKD/Qd5b6EvqMdtk/R+7QCIojXpSSBzhmjiVUcBfJGqpf2shij4WgHkLBngogWElVD3
         Br/19wunz2Z0lvT/mof7/ToUb/WHzfQ4veYcHxEY5mJKgZJZQBcdPoa74DXDipTHpF3o
         0LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RFWMVJvLAoeTu9TqNSNIzlMj/liK2rSYStrQSpZHUkA=;
        b=O7XXn6JejTgj1crH3tJlW3+Njov16TL4JeJA0Ib7nCeb4AlARdQsMeoQWvKEQA2IC5
         iZEd1scrg3tc/8hbXm8oBEihesJoyrvUOTLe8b82iYhqJ45n0wS1KDJ7yjTcjMZSYHy3
         Bv0iTMAIGpmqfE7FzDe5l7vXn3F+mYnvdUxFLh2GN2HASi1wbu/dvBh2BipBHCvKvgbS
         MFKwvZ+JBUtwiGY+CcWPDElVKKSnz0IdSLlrMpaqJZRuMh/iTJs5wKHl8V4ei7JZU/B7
         Id7B9328oCczb9XTVGQOjsypl8Jm0k1+NhhNFfNpW6XysVdU92dvURoPXbdmXNTzcBbL
         wWMQ==
X-Gm-Message-State: AKGB3mKj3SZHQCDA4anlut+VjWTtpsrZNAAyk+7FWrPamPhBWktA/208
        h/KgPMkLeLJEZNks4FmSrL9G+Y48EgA=
X-Google-Smtp-Source: ACJfBou1PpCpfmeMHGyJgtgYz7gLWP35NAXhj7ZKbNhZbkp9w4YjS4/W4JjitI4zUtxv0u6Aj1EhNA==
X-Received: by 10.36.70.195 with SMTP id j186mr2547544itb.32.1513022351665;
        Mon, 11 Dec 2017 11:59:11 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l24sm6904972iod.12.2017.12.11.11.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Dec 2017 11:59:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     peff@peff.net, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/1] diffcore: add a filter to find a specific blob
Date:   Mon, 11 Dec 2017 11:58:35 -0800
Message-Id: <20171211195835.57057-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171211195835.57057-1-sbeller@google.com>
References: <20171208002447.20261-1-sbeller@google.com>
 <20171211195835.57057-1-sbeller@google.com>
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

  $ ./git log --oneline --blobfind=v2.0.0:Makefile
  b2feb64309 Revert the whole "ask curl-config" topic for now
  47fbfded53 i18n: only extract comments marked with "TRANSLATORS:"

we observe that the Makefile as shipped with 2.0 was introduced in
v1.9.2-471-g47fbfded53 and replaced in v2.0.0-rc1-5-gb2feb64309 by
a different blob.

[1] https://stackoverflow.com/questions/223678/which-commit-has-this-blob
[2] https://public-inbox.org/git/20171028004419.10139-1-sbeller@google.com/

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-options.txt |  6 +++++
 Makefile                       |  1 +
 builtin/log.c                  |  2 +-
 diff.c                         | 21 ++++++++++++++++-
 diff.h                         |  3 +++
 diffcore-oidfind.c             | 42 ++++++++++++++++++++++++++++++++++
 diffcore.h                     |  1 +
 revision.c                     |  5 ++++-
 t/t4064-diff-oidfind.sh        | 51 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 129 insertions(+), 3 deletions(-)
 create mode 100644 diffcore-oidfind.c
 create mode 100755 t/t4064-diff-oidfind.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index dd0dba5b1d..67a99e522b 100644
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
+	or gitlink entry.
+
 endif::git-format-patch[]
 
 -O<orderfile>::
diff --git a/Makefile b/Makefile
index ee9d5eb11e..fc2b136694 100644
--- a/Makefile
+++ b/Makefile
@@ -775,6 +775,7 @@ LIB_OBJS += date.o
 LIB_OBJS += decorate.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
+LIB_OBJS += diffcore-oidfind.o
 LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
diff --git a/builtin/log.c b/builtin/log.c
index 6c1fa896ad..2ab7f338e6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -181,7 +181,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		init_display_notes(&rev->notes_opt);
 
 	if (rev->diffopt.pickaxe || rev->diffopt.filter ||
-	    rev->diffopt.flags.follow_renames)
+	    rev->diffopt.flags.follow_renames || rev->diffopt.oidfind)
 		rev->always_show_header = 0;
 
 	if (source)
diff --git a/diff.c b/diff.c
index 0763e89263..cb35934634 100644
--- a/diff.c
+++ b/diff.c
@@ -4082,6 +4082,7 @@ void diff_setup(struct diff_options *options)
 	options->interhunkcontext = diff_interhunk_context_default;
 	options->ws_error_highlight = ws_error_highlight_default;
 	options->flags.rename_empty = 1;
+	options->oidfind = NULL;
 
 	/* pathchange left =NULL by default */
 	options->change = diff_change;
@@ -4487,6 +4488,20 @@ static int parse_ws_error_highlight_opt(struct diff_options *opt, const char *ar
 	return 1;
 }
 
+static int parse_oidfind_opt(struct diff_options *opt, const char *arg)
+{
+	struct object_id oid;
+
+	/* We don't even need to have the object, any oid works. */
+	if (get_oid_blob(arg, &oid))
+		return error("unable to resolve '%s'", arg);
+
+	if (!opt->oidfind)
+		opt->oidfind = xcalloc(1, sizeof(*opt->oidfind));
+	oidset_insert(opt->oidfind, &oid);
+	return 1;
+}
+
 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
@@ -4736,7 +4751,8 @@ int diff_opt_parse(struct diff_options *options,
 	else if ((argcount = short_opt('O', av, &optarg))) {
 		options->orderfile = prefix_filename(prefix, optarg);
 		return argcount;
-	}
+	} else if (skip_prefix(arg, "--find-object=", &arg))
+		return parse_oidfind_opt(options, arg);
 	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
 		int offending = parse_diff_filter_opt(optarg, options);
 		if (offending)
@@ -5770,6 +5786,9 @@ void diffcore_std(struct diff_options *options)
 		diffcore_skip_stat_unmatch(options);
 	if (!options->found_follow) {
 		/* See try_to_follow_renames() in tree-diff.c */
+
+		if (options->oidfind)
+			diffcore_oidfind(options);
 		if (options->break_opt != -1)
 			diffcore_break(options->break_opt);
 		if (options->detect_rename)
diff --git a/diff.h b/diff.h
index 0fb18dd735..d2badb29a1 100644
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
 
+	struct oidset *oidfind;
+
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
 
diff --git a/diffcore-oidfind.c b/diffcore-oidfind.c
new file mode 100644
index 0000000000..39a0b5390f
--- /dev/null
+++ b/diffcore-oidfind.c
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
+	if (!options->oidfind)
+		BUG("oidfind oidset not initialized???");
+
+	for (src = dst = 0; src < q->nr; src++) {
+		struct diff_filepair *p = q->queue[src];
+
+		if (!DIFF_PAIR_UNMERGED(p) &&
+		    ((DIFF_FILE_VALID(p->one) &&
+		     oidset_contains(options->oidfind, &p->one->oid)) ||
+		    (DIFF_FILE_VALID(p->two) &&
+		     oidset_contains(options->oidfind, &p->two->oid)))) {
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
+void diffcore_oidfind(struct diff_options *options)
+{
+	diffcore_filter_blobs(&diff_queued_diff, options);
+}
diff --git a/diffcore.h b/diffcore.h
index a30da161da..6bb1d76b1a 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -107,6 +107,7 @@ extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
 					struct diff_filespec *);
 extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
+extern void diffcore_oidfind(struct diff_options *);
 extern void diffcore_break(int);
 extern void diffcore_rename(struct diff_options *);
 extern void diffcore_merge_broken(void);
diff --git a/revision.c b/revision.c
index e2e691dd5a..e4611054b9 100644
--- a/revision.c
+++ b/revision.c
@@ -2409,7 +2409,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	/* Pickaxe, diff-filter and rename following need diffs */
 	if (revs->diffopt.pickaxe ||
 	    revs->diffopt.filter ||
-	    revs->diffopt.flags.follow_renames)
+	    revs->diffopt.flags.follow_renames ||
+	    revs->diffopt.oidfind)
 		revs->diff = 1;
 
 	if (revs->topo_order)
@@ -2883,6 +2884,8 @@ int prepare_revision_walk(struct rev_info *revs)
 		simplify_merges(revs);
 	if (revs->children.name)
 		set_children(revs);
+	if (revs->diffopt.oidfind)
+		revs->simplify_history = 0;
 	return 0;
 }
 
diff --git a/t/t4064-diff-oidfind.sh b/t/t4064-diff-oidfind.sh
new file mode 100755
index 0000000000..7afe62df87
--- /dev/null
+++ b/t/t4064-diff-oidfind.sh
@@ -0,0 +1,51 @@
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
2.15.1.424.g9478a66081-goog

