Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8EAF1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeACAqh (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:46:37 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:39937 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbeACAqf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:46:35 -0500
Received: by mail-io0-f180.google.com with SMTP id v30so514979iov.7
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gfboAdFh7ADQzoWVfZkSRXX556IRJWaBZ3+XQXd9I7w=;
        b=UON9QpkDMiE9RDazcYG8NrwkbsJ7pP4fZ0m1nwS/fGZEOi3Ccyv/FtSIevfikPybNg
         rBKLP4iXAQlYYfgYOefV1B6sRmo3dZdHU45R08s3KxqSBsw/qZl0GYm6gKe3azHncTDp
         iwtxAfMyrV1kGJtrqThpr8HDmc+1oi0jlLkVUq0o3vpkx1L9Qulyc4VFgxXxlxH0ELAW
         6iyM0QPqbvwaGMpXg4O6psFX0j+bIYsyu4Ul++2s17evVMgOnaA9/bFjww9kNoOecY8Y
         /xo4k/7kDItr9Tm3SDSRU/tMOtWLxlH0Gj9P/iEJtn1wT+p7sRLCcLcdW1nBDfkpMR8R
         agdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gfboAdFh7ADQzoWVfZkSRXX556IRJWaBZ3+XQXd9I7w=;
        b=OBy62ikDwMBVciKo9OBoHwlHcLIhc+F7OPU30aX2qeS5eB/naO6b08VXVO+z63b6yv
         ei2S129z+h4UOk4XlND2LsLA6SUsd/uyoGEekmWsl4Z+2En2fSTQSlFDoAfxsmKzDfLX
         60SfwIHPeQZa81yP+qiD52nDzmKh35BgtHt6dldzsmrIcsr1PmnudDXi42lkM/ytPDYH
         feUnagpwt7fhCY5Gup1CROyFtgb4kgCcaP7+0IA+WgptZrr4voW01WUGpKse+qRx89oG
         6X/2snR1tPVEOwHdFWQC6muoWbzWQ4dRStQk3fRyBDzSZlTDZ1KkUj1C+oqEqtioZctw
         XZnQ==
X-Gm-Message-State: AKGB3mKry9rHcp5V3q7h9G4eylji/4Rx5Ye6RsLsSITiMVTYQhU0bjrB
        QU2cSGavTOMZiV3NovRpdUA6C0scpig=
X-Google-Smtp-Source: ACJfBotfLt55JxsRsxBI+BdrP61Pfcqaz3JA1WwMl85rfvHbSI+oSQMyy9O1I/AO561qiclG6IajNQ==
X-Received: by 10.107.69.1 with SMTP id s1mr36360562ioa.75.1514940394658;
        Tue, 02 Jan 2018 16:46:34 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id x82sm27514itb.36.2018.01.02.16.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 16:46:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/5] diffcore: add a pickaxe option to find a specific blob
Date:   Tue,  2 Jan 2018 16:46:23 -0800
Message-Id: <20180103004624.222528-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103004624.222528-1-sbeller@google.com>
References: <20180103004624.222528-1-sbeller@google.com>
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
 Documentation/diff-options.txt | 10 ++++++++++
 diff.c                         | 21 +++++++++++++++++++-
 diff.h                         |  8 +++++++-
 diffcore-pickaxe.c             | 45 +++++++++++++++++++++++++-----------------
 revision.c                     |  3 +++
 5 files changed, 67 insertions(+), 20 deletions(-)

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
 
-- 
2.15.1.620.gb9897f4670-goog

