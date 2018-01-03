Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D071F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbeACA40 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:56:26 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:34871 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeACA4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:56:25 -0500
Received: by mail-it0-f42.google.com with SMTP id f143so120379itb.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=imgRrljqJfEeZhdB/MQ9vk2fPRaiDESrKuJ+Bh/uzH8=;
        b=nIyWTNFUZsvAQs0Bs1Dssvc51WPnBoqtAvHd0BOZmKv/j+USBdcUQQBP1sGB48Q5Kh
         4H3NgqWt1sEI5w55W7Xu+SSC3oItFHFLknNRayioADX6jzGZT17pXjNXpaGE6eJBDc+O
         3C8P2hQeGkkygtVCQUFLx4LoO+RdmSvF5SOXehuBLr4SOhjBznfTjw9pzKsMLFk2cn29
         AsPq3OOma+VRyr/mdn26Z3nO8pMrX1h1hEjJ93SGFgyQpwqAebHPaDEfBXBC+VeAOgzB
         n9we0hqunhK/7rVqukPz+ZG8xUFSFKN2joTjJZ9Q+XUSfkxdJ8iObxbC7PoYoiwQiOpZ
         MxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=imgRrljqJfEeZhdB/MQ9vk2fPRaiDESrKuJ+Bh/uzH8=;
        b=jix3gvCGhdmAQMYTp7MsFrQtyDAVNgOpDS9XwqfWra/p12/NKYNyrXBLqPdxBs2S2a
         kykFMb+wQ0rGH4o7bIQMYm/Jy43fuoRWwWGPxn2cfQS+ThTuk595zKUKh10agf0HUCK/
         8eVFFX1lOID5bjJVuJ0Se0Oa6baIW6JKzXOomUbFaFC7Awxve2GprKH/XwGeGNEqexNh
         o1Ojajmx9BAvxTCfJMvTTrpJxY+HdGqJ3DCeiQqvx5sNuZFo8ETgdt7fDkP95vb3q62a
         1nw+lr/V7K+4sRUuzQLV6SS1YMmYcFI7oWMciWt/1PZZ+a3WRAEaltWcPQProktRhtLs
         Jzxg==
X-Gm-Message-State: AKGB3mIyQWdimnXJ0uS5G3IAaM0BZ/4DhNVhzdtdOeAsh/SGg0iyySn5
        plwoBFB2nDGuX/fuhtzZ7yPxsQ==
X-Google-Smtp-Source: ACJfBotYUu0BAGJpw919oAY7W6NMoMNjJewCG4lw3+16SRKa9iPVrB5NZVVPlGF7JAcuusy0OaPS9g==
X-Received: by 10.36.221.216 with SMTP id t207mr83844itf.112.1514940984788;
        Tue, 02 Jan 2018 16:56:24 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id c8sm40873itg.15.2018.01.02.16.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 16:56:24 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCHv2 4/5] diffcore: add a pickaxe option to find a specific blob
Date:   Tue,  2 Jan 2018 16:56:20 -0800
Message-Id: <20180103005620.202940-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103004624.222528-5-sbeller@google.com>
References: <20180103004624.222528-5-sbeller@google.com>
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
---

We lost the tests in the first version, this includes the new file containing
the tests.

Stefan

 Documentation/diff-options.txt | 10 +++++++
 diff.c                         | 21 ++++++++++++-
 diff.h                         |  8 ++++-
 diffcore-pickaxe.c             | 45 +++++++++++++++++-----------
 revision.c                     |  3 ++
 t/t4064-diff-oidfind.sh        | 68 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 135 insertions(+), 20 deletions(-)
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
index 5508745dc8..a872bdcac1 100644
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
+	opt->pickaxe_opts |= DIFF_PICKAXE_KIND_OBJFIND;
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
index 9ec4f824fe..8a56cac2ad 100644
--- a/diff.h
+++ b/diff.h
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "pathspec.h"
 #include "object.h"
+#include "oidset.h"
 
 struct rev_info;
 struct diff_options;
@@ -173,6 +174,8 @@ struct diff_options {
 	enum diff_words_type word_diff;
 	enum diff_submodule_format submodule_format;
 
+	struct oidset *objfind;
+
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
 
@@ -325,8 +328,11 @@ extern void diff_setup_done(struct diff_options *);
 
 #define DIFF_PICKAXE_KIND_S	4 /* traditional plumbing counter */
 #define DIFF_PICKAXE_KIND_G	8 /* grep in the patch */
+#define DIFF_PICKAXE_KIND_OBJFIND	16 /* specific object IDs */
 
-#define DIFF_PICKAXE_KINDS_MASK (DIFF_PICKAXE_KIND_S | DIFF_PICKAXE_KIND_G)
+#define DIFF_PICKAXE_KINDS_MASK (DIFF_PICKAXE_KIND_S | \
+				 DIFF_PICKAXE_KIND_G | \
+				 DIFF_PICKAXE_KIND_OBJFIND)
 
 #define DIFF_PICKAXE_IGNORE_CASE	32
 
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 4b5d88ea46..72bb5a9514 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -124,13 +124,20 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	mmfile_t mf1, mf2;
 	int ret;
 
-	if (!o->pickaxe[0])
-		return 0;
-
 	/* ignore unmerged */
 	if (!DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two))
 		return 0;
 
+	if (o->objfind) {
+		return  (DIFF_FILE_VALID(p->one) &&
+			 oidset_contains(o->objfind, &p->one->oid)) ||
+			(DIFF_FILE_VALID(p->two) &&
+			 oidset_contains(o->objfind, &p->two->oid));
+	}
+
+	if (!o->pickaxe[0])
+		return 0;
+
 	if (o->flags.allow_textconv) {
 		textconv_one = get_textconv(p->one);
 		textconv_two = get_textconv(p->two);
@@ -226,20 +233,22 @@ void diffcore_pickaxe(struct diff_options *o)
 			cflags |= REG_ICASE;
 		regcomp_or_die(&regex, needle, cflags);
 		regexp = &regex;
-	} else if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE &&
-		   has_non_ascii(needle)) {
-		struct strbuf sb = STRBUF_INIT;
-		int cflags = REG_NEWLINE | REG_ICASE;
-
-		basic_regex_quote_buf(&sb, needle);
-		regcomp_or_die(&regex, sb.buf, cflags);
-		strbuf_release(&sb);
-		regexp = &regex;
-	} else {
-		kws = kwsalloc(o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE
-			       ? tolower_trans_tbl : NULL);
-		kwsincr(kws, needle, strlen(needle));
-		kwsprep(kws);
+	} else if (opts & DIFF_PICKAXE_KIND_S) {
+		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE &&
+		    has_non_ascii(needle)) {
+			struct strbuf sb = STRBUF_INIT;
+			int cflags = REG_NEWLINE | REG_ICASE;
+
+			basic_regex_quote_buf(&sb, needle);
+			regcomp_or_die(&regex, sb.buf, cflags);
+			strbuf_release(&sb);
+			regexp = &regex;
+		} else {
+			kws = kwsalloc(o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE
+				       ? tolower_trans_tbl : NULL);
+			kwsincr(kws, needle, strlen(needle));
+			kwsprep(kws);
+		}
 	}
 
 	/* Might want to warn when both S and G are on; I don't care... */
@@ -248,7 +257,7 @@ void diffcore_pickaxe(struct diff_options *o)
 
 	if (regexp)
 		regfree(regexp);
-	else
+	if (kws)
 		kwsfree(kws);
 	return;
 }
diff --git a/revision.c b/revision.c
index 5d11ecaf27..30f65b3bbd 100644
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

