Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5BD11F404
	for <e@80x24.org>; Thu, 28 Dec 2017 00:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbdL1AAP (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 19:00:15 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:39085 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbdL1AAN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 19:00:13 -0500
Received: by mail-io0-f174.google.com with SMTP id g70so24222991ioj.6
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 16:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r6kqtPVy4c2dM2bxS5jY+h7yscRtMDd2GfA0yNKXCUo=;
        b=JIfP9Ga8jfbuOu+/Dn5jd39XpRlnuEjUSYv2nZmgvqGuQdkLVa+bENZZ5yDS7+rEsJ
         sZBHr0GfMdWuz/DSd2RzDN3+GbkfzDZwhbV9UUuRBGGayZWNiY537wHwhLfvA3omDkYc
         09UvwTJBSb9/94GT+ZGJDMgi05JvEosL3/A1SiXUeTSYUufkBITco04/rSJXoMicJoB3
         aVzKRCyioPuF14BcTdCOP9AuzvBLV3WY/nI/3wn66EC7U71D4wE9d0WJOZdoZIDPOsC+
         bBv9aZ5yP7ps/pZ31F1YDC/F/hXjqpsY4ddlwJIvV22UfPYJ+MbhRak/iOcHim7qy2we
         B4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r6kqtPVy4c2dM2bxS5jY+h7yscRtMDd2GfA0yNKXCUo=;
        b=gIrWlNUbcMiuLskErQ3ehwU7UgiTM4PxZjB/9cINGN8mgLI3stpGZOIXwIYJ5Ps6Ca
         YI41jNtU6hhJDTl1EQCZ5YwgY2zqZ65Ni2GUxJDtl2uKZhbJZ8XFzefXjz67YaXRT5jv
         dqYBd2r0TYLOJWhDSwdvJg+2G132CKd4d4QPTprA9EBrmDYj+h6/FzDPL9GTrc3O8uIy
         b45bCFUzshbDtTSfMxDPSnZh9j9/HHT+mWayDRbfd/yaqNDPAaLBCLxwMkyde4vIpTI7
         Bc8RFlzAvJOyxRJv2Sg6PxuID05ZCJmtAV0EBwXL/fSjK/ex/lnUwHFh8sQjx36QZxjk
         OXfA==
X-Gm-Message-State: AKGB3mIlA0iHDP9PRNnx+FbYXcLH11xF4jUyzieiTgrljbU1vo9BNker
        l5Xdd+NlG0tJHg3oCtmj8gTLzG0WnfE=
X-Google-Smtp-Source: ACJfBosGK8IML3W3oOHAplWycVi4nchwS2P/lfAoRDlBnyZRWY6Y48eF8lZ/qvkLzarYnhbFgQ/i6A==
X-Received: by 10.107.114.23 with SMTP id n23mr22235719ioc.38.1514419212624;
        Wed, 27 Dec 2017 16:00:12 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 125sm17580383ioo.68.2017.12.27.16.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 16:00:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/1] diffcore: add a pickaxe option to find a specific blob
Date:   Wed, 27 Dec 2017 16:00:03 -0800
Message-Id: <20171228000003.34539-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171228000003.34539-1-sbeller@google.com>
References: <20171228000003.34539-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt | 10 +++++++
 diff.c                         | 21 ++++++++++++-
 diff.h                         |  3 ++
 diffcore-pickaxe.c             | 14 +++++++--
 revision.c                     |  3 ++
 t/t4064-diff-oidfind.sh        | 68 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 115 insertions(+), 4 deletions(-)
 create mode 100755 t/t4064-diff-oidfind.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index dd0dba5b1d..f9cf85db05 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -492,6 +492,15 @@ occurrences of that string did not change).
 See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
 information.
 
+--find-object=<object-id>::
+	Look for differences that change the number of occurrences of
+	the specified object. Similar to `-S`, just the argument is different
+	in that it doesn't search for a specific string but for a specific
+	object id.
++
+The object can be a blob or a submodule commit. It implies the `-t` option in
+`git-log` to also find trees.
+
 --pickaxe-all::
 	When `-S` or `-G` finds a change, show all the changes in that
 	changeset, not just the files that contain the change
@@ -500,6 +509,7 @@ information.
 --pickaxe-regex::
 	Treat the <string> given to `-S` as an extended POSIX regular
 	expression to match.
+
 endif::git-format-patch[]
 
 -O<orderfile>::
diff --git a/diff.c b/diff.c
index 0763e89263..7acddaaee7 100644
--- a/diff.c
+++ b/diff.c
@@ -4082,6 +4082,7 @@ void diff_setup(struct diff_options *options)
 	options->interhunkcontext = diff_interhunk_context_default;
 	options->ws_error_highlight = ws_error_highlight_default;
 	options->flags.rename_empty = 1;
+	options->objfind = NULL;
 
 	/* pathchange left =NULL by default */
 	options->change = diff_change;
@@ -4487,6 +4488,23 @@ static int parse_ws_error_highlight_opt(struct diff_options *opt, const char *ar
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
+
+	opt->pickaxe = ""; /* trigger pickaxe */
+	opt->flags.recursive = 1;
+	opt->flags.tree_in_recursive = 1;
+	oidset_insert(opt->objfind, &oid);
+	return 1;
+}
+
 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
@@ -4736,7 +4754,8 @@ int diff_opt_parse(struct diff_options *options,
 	else if ((argcount = short_opt('O', av, &optarg))) {
 		options->orderfile = prefix_filename(prefix, optarg);
 		return argcount;
-	}
+	} else if (skip_prefix(arg, "--find-object=", &arg))
+		return parse_objfind_opt(options, arg);
 	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
 		int offending = parse_diff_filter_opt(optarg, options);
 		if (offending)
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
 
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 9476bd2108..0d0c697ae7 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -124,13 +124,21 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	mmfile_t mf1, mf2;
 	int ret;
 
-	if (!o->pickaxe[0])
-		return 0;
-
 	/* ignore unmerged */
 	if (!DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two))
 		return 0;
 
+	if (o->objfind) {
+		if ((DIFF_FILE_VALID(p->one) &&
+		     oidset_contains(o->objfind, &p->one->oid)) ||
+		    (DIFF_FILE_VALID(p->two) &&
+		     oidset_contains(o->objfind, &p->two->oid)))
+			return 1;
+	}
+
+	if (!o->pickaxe[0])
+		return 0;
+
 	if (o->flags.allow_textconv) {
 		textconv_one = get_textconv(p->one);
 		textconv_two = get_textconv(p->two);
diff --git a/revision.c b/revision.c
index e2e691dd5a..43bb6265cd 100644
--- a/revision.c
+++ b/revision.c
@@ -2412,6 +2412,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	    revs->diffopt.flags.follow_renames)
 		revs->diff = 1;
 
+	if (revs->diffopt.objfind)
+		revs->simplify_history = 0;
+
 	if (revs->topo_order)
 		revs->limited = 1;
 
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
2.15.1.620.gb9897f4670-goog

