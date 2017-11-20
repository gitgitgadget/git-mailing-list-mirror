Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26665202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbdKTWZk (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:25:40 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:39749 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbdKTWZg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 17:25:36 -0500
Received: by mail-it0-f45.google.com with SMTP id x13so3739426iti.4
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 14:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+QJ7ip7pOCpA3ZD9a8MDSdyUAWzUZ+DOzQWGsRYIRLs=;
        b=dpJEVfGw64BMh7lQOGNG2EbbUOk2df6lS0PDHK2h6cMK09D9/l1u3/ag4+ppy71384
         nik0IYRC2Y0d5I+jZ6xpTmHNX7cDgK1PvOrpKVMLUzQKdjOrpjwkDOY90Re5dkWE1JO3
         HbaQ5Vy7bUKLEBlnQWyaremb9rD5ytNHHAZ8k9vVViiHb3i8rZiBigMmPwNTjisXubW0
         JMyzab8ZuwDFT6jcyTPLZKaYyGvLN/3z8aRGLzI5QjmMzGZLA41PCS09LRWK03/Guwzc
         Vi+eDAQV/Qofj8D036xaMEkqKdVdDwK+5DWqB3H51mKH5ineq+TQWxBYfXn0qqXvXd2L
         3ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+QJ7ip7pOCpA3ZD9a8MDSdyUAWzUZ+DOzQWGsRYIRLs=;
        b=Ojz8NECNonwHRs56z/mWt63E7AqA5pyw7X0vsgXu7vzXnVdwSPGg6GFTZbBI6RzgU5
         RZWF2tz3xksfGhTpbMuQWhxSrLhEPSUkBg5D918PYPsPZF87CASvtYm4veYITpYA1Buz
         3oAM11wjnvVpbu8f+Tlu5LvXvGRWdLd5ayosc0ZTIjg/fSBvUwGkyYFssc/+8Z3GWWge
         kvwSNSsMEEbsOKhOwf0TLnCziXLsABkLLoGVWnKXbqsXvBppKltg+cj1xL4S1NDNRM3j
         5/p/5BaZ9PSOBOls7VA2+LUp+Q7txNeZFbqOTHTVS83Lig9plrXziF3zR+dECJCKAjcj
         RUxA==
X-Gm-Message-State: AJaThX4gUb0WEZP3YlTjG6LPv2xQ9jBMSP6GWWP/5XeG6fLLakJ1RoPe
        l54X/IXu+WQBkfQaL40xcRbgE4Qh12I=
X-Google-Smtp-Source: AGs4zMZonVNeQ5PgV1uxh4XToAJYX9nSdV2BE4o2wcabCunAZWC+KF3F+eCPharfioO1MmIkjPsjbA==
X-Received: by 10.36.217.86 with SMTP id p83mr21445215itg.65.1511216735337;
        Mon, 20 Nov 2017 14:25:35 -0800 (PST)
Received: from localhost ([2620:0:100e:422:d59e:3b74:3df:d3bb])
        by smtp.gmail.com with ESMTPSA id y133sm5603184itf.7.2017.11.20.14.25.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Nov 2017 14:25:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/1] diffcore: add a filter to find a specific blob
Date:   Mon, 20 Nov 2017 14:25:29 -0800
Message-Id: <20171120222529.24995-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171120222529.24995-1-sbeller@google.com>
References: <20171120222529.24995-1-sbeller@google.com>
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

On playing around with this, trying to find more interesting cases, I observed:

    git log --oneline --blobfind=HEAD:COPYING
    703601d678 Update COPYING with GPLv2 with new FSF address
    
    git log --oneline --blobfind=703601d678^:COPYING
    459b8d22e5 tests: do not borrow from COPYING and README from the real source
    703601d678 Update COPYING with GPLv2 with new FSF address
    075b845a85 Add a COPYING notice, making it explicit that the license is GPLv2.

    t/diff-lib/COPYING may need an update of the adress of the FSF,
    #leftoverbits I guess.
    
Another interesting case that I found was
   git log --oneline --blobfind=v2.14.0:Makefile
   3921a0b3c3 perf: add test for writing the index
   36f048c5e4 sha1dc: build git plumbing code more explicitly
   2118805b92 Makefile: add style build rule

all of which were after v2.14, such that the introduction of that blob doesn't
show up; I suspect it came in via a merge as unrelated series may have updated
the Makefile in parallel, though git-log should have told me?

Thanks,
Stefan

 Documentation/diff-options.txt |  4 ++++
 Makefile                       |  1 +
 builtin/log.c                  |  2 +-
 diff.c                         | 20 ++++++++++++++++-
 diff.h                         |  3 +++
 diffcore-blobfind.c            | 51 ++++++++++++++++++++++++++++++++++++++++++
 diffcore.h                     |  1 +
 revision.c                     |  3 ++-
 t/t4064-diff-blobfind.sh       | 35 +++++++++++++++++++++++++++++
 9 files changed, 117 insertions(+), 3 deletions(-)
 create mode 100644 diffcore-blobfind.c
 create mode 100755 t/t4064-diff-blobfind.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index dd0dba5b1d..252a21cc19 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -500,6 +500,10 @@ information.
 --pickaxe-regex::
 	Treat the <string> given to `-S` as an extended POSIX regular
 	expression to match.
+--blobfind=<blob-id>::
+	Restrict the output such that one side of the diff
+	matches the given blob-id.
+
 endif::git-format-patch[]
 
 -O<orderfile>::
diff --git a/Makefile b/Makefile
index ee9d5eb11e..fdfa8f38f6 100644
--- a/Makefile
+++ b/Makefile
@@ -775,6 +775,7 @@ LIB_OBJS += date.o
 LIB_OBJS += decorate.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
+LIB_OBJS += diffcore-blobfind.o
 LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
diff --git a/builtin/log.c b/builtin/log.c
index 6c1fa896ad..7b91f61423 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -181,7 +181,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		init_display_notes(&rev->notes_opt);
 
 	if (rev->diffopt.pickaxe || rev->diffopt.filter ||
-	    rev->diffopt.flags.follow_renames)
+	    rev->diffopt.flags.follow_renames || rev->diffopt.blobfind)
 		rev->always_show_header = 0;
 
 	if (source)
diff --git a/diff.c b/diff.c
index 0763e89263..8861f89ab1 100644
--- a/diff.c
+++ b/diff.c
@@ -4082,6 +4082,7 @@ void diff_setup(struct diff_options *options)
 	options->interhunkcontext = diff_interhunk_context_default;
 	options->ws_error_highlight = ws_error_highlight_default;
 	options->flags.rename_empty = 1;
+	options->blobfind = NULL;
 
 	/* pathchange left =NULL by default */
 	options->change = diff_change;
@@ -4487,6 +4488,19 @@ static int parse_ws_error_highlight_opt(struct diff_options *opt, const char *ar
 	return 1;
 }
 
+static int parse_blobfind_opt(struct diff_options *opt, const char *arg)
+{
+	struct object_id oid;
+
+	if (get_oid_blob(arg, &oid) || sha1_object_info(oid.hash, NULL) != OBJ_BLOB)
+		return error("object '%s' is not a blob", arg);
+
+	if (!opt->blobfind)
+		opt->blobfind = xcalloc(1, sizeof(*opt->blobfind));
+	oidset_insert(opt->blobfind, &oid);
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
+	} else if (skip_prefix(arg, "--blobfind=", &arg))
+		return parse_blobfind_opt(options, arg);
 	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
 		int offending = parse_diff_filter_opt(optarg, options);
 		if (offending)
@@ -5770,6 +5785,9 @@ void diffcore_std(struct diff_options *options)
 		diffcore_skip_stat_unmatch(options);
 	if (!options->found_follow) {
 		/* See try_to_follow_renames() in tree-diff.c */
+
+		if (options->blobfind)
+			diffcore_blobfind(options);
 		if (options->break_opt != -1)
 			diffcore_break(options->break_opt);
 		if (options->detect_rename)
diff --git a/diff.h b/diff.h
index 0fb18dd735..9178e498fa 100644
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
 
+	struct oidset *blobfind;
+
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
 
diff --git a/diffcore-blobfind.c b/diffcore-blobfind.c
new file mode 100644
index 0000000000..5d222fc336
--- /dev/null
+++ b/diffcore-blobfind.c
@@ -0,0 +1,51 @@
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
+	int i, j = 0, c = q->nr;
+
+	if (!options->blobfind)
+		BUG("blobfind oidset not initialized???");
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+
+		if (DIFF_PAIR_UNMERGED(p) ||
+		    (DIFF_FILE_VALID(p->one) &&
+		     oidset_contains(options->blobfind, &p->one->oid)) ||
+		    (DIFF_FILE_VALID(p->two) &&
+		     oidset_contains(options->blobfind, &p->two->oid)))
+			continue;
+
+		diff_free_filepair(p);
+		q->queue[i] = NULL;
+		c--;
+	}
+
+	/* Keep it sorted. */
+	i = 0; j = 0;
+	while (i < c) {
+		while (!q->queue[j])
+			j++;
+		q->queue[i] = q->queue[j];
+		i++; j++;
+	}
+
+	q->nr = c;
+
+	if (!c) {
+		free(q->queue);
+		DIFF_QUEUE_CLEAR(q);
+	}
+}
+
+void diffcore_blobfind(struct diff_options *options)
+{
+	diffcore_filter_blobs(&diff_queued_diff, options);
+}
diff --git a/diffcore.h b/diffcore.h
index a30da161da..431917672f 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -107,6 +107,7 @@ extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
 					struct diff_filespec *);
 extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
+extern void diffcore_blobfind(struct diff_options *);
 extern void diffcore_break(int);
 extern void diffcore_rename(struct diff_options *);
 extern void diffcore_merge_broken(void);
diff --git a/revision.c b/revision.c
index e2e691dd5a..6449619c0a 100644
--- a/revision.c
+++ b/revision.c
@@ -2409,7 +2409,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	/* Pickaxe, diff-filter and rename following need diffs */
 	if (revs->diffopt.pickaxe ||
 	    revs->diffopt.filter ||
-	    revs->diffopt.flags.follow_renames)
+	    revs->diffopt.flags.follow_renames ||
+	    revs->diffopt.blobfind)
 		revs->diff = 1;
 
 	if (revs->topo_order)
diff --git a/t/t4064-diff-blobfind.sh b/t/t4064-diff-blobfind.sh
new file mode 100755
index 0000000000..b2c2964d77
--- /dev/null
+++ b/t/t4064-diff-blobfind.sh
@@ -0,0 +1,35 @@
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
+	git log --abbrev=12 --oneline --blobfind=greeting^{blob} >actual.raw &&
+	cut -c 14- actual.raw >actual &&
+
+	test_cmp expect actual
+'
+
+test_done
-- 
2.15.0.128.gcadd42da22

