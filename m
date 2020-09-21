Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF511C4346D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 17:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BD320B1F
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 17:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6KRGvHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgIUR1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 13:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgIUR1o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 13:27:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756FBC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 10:27:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o25so4692368pgm.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YPTnC7j47MiJZeL5DOTKYhcrzel9mMshkfUW+ZRK4jc=;
        b=C6KRGvHXE5wvwzhFT+yPVqwzsBkcoTscyhhcHge9iWdcszB7b9+v+zf3gbkcBIYAH5
         QQv/NKNsw10zvhR6t86vhXdfoRA34WNaJGz8jRTl8H5+8Mc2ZHVU6mhZm/TygwIdgRYb
         MoKDx4kYzWGJAWq8DB2mu1iPtMyz2A4YWZXw1ew5e9Fh3fIaH5HDpxtHSJt6P1Dm+CaZ
         ALVGzeMAem7f9Fd+xESjaejMn268VWslRziTA04/JrWCw3CKQIVEA1gQJAGD5w7Sg6Gm
         w2wfQKiR4YKcEj5kS1YEpp4M3F9EzQzaejiVcLucxZenhD17y4b4sZvegZwXDIQ4jZmn
         Q1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YPTnC7j47MiJZeL5DOTKYhcrzel9mMshkfUW+ZRK4jc=;
        b=CBKdAot/1Br5nnJe+H0NsbfjrcxtsG+4QicA0P7+vWL4yeEp/e5mjuDPg4mKVBDDyp
         GigydSY40w5vc6zU7BRy3v7qklw6Pw4EdecTvgCx59f2ZHYcenR7sQcYmMpk01P1VbKe
         55vhoWt3qBL49ViwFCMASGa5yK1pU7OyDBg4VfIejGW7M5ixQpEeGBJ+fbuWiKRycfcd
         sU/d9q2964S1q0yxK/n+7wisNXU/MMPNflBLX2ZBBANQhIDzkMzPA8ppy08uJI8GzBbX
         lMGJ5CR4Gn2JXQGNl//3old2Athum5ijfYOFFbI0cFMU45oD2H6lbcRiqhXShtCoDa2P
         bm+Q==
X-Gm-Message-State: AOAM5313e0mouCIHZ//GVUSr/hAc4yyOieVMed4aNuzU//667LtLLAz2
        yd1j+XDF5gwflxP8WQfTk10=
X-Google-Smtp-Source: ABdhPJylMIyFUNZ4s0srIEAGd+juLdAJsSDs13rCUmHpGchSvKNBDmkYYk4p+ibnm2rgSUHkPyb6YQ==
X-Received: by 2002:aa7:9ad6:0:b029:142:2501:3975 with SMTP id x22-20020aa79ad60000b029014225013975mr810834pfp.58.1600709263670;
        Mon, 21 Sep 2020 10:27:43 -0700 (PDT)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e19sm13531234pfl.135.2020.09.21.10.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 10:27:42 -0700 (PDT)
Date:   Mon, 21 Sep 2020 10:27:40 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
Message-ID: <20200921172740.GA946178@generichostname>
References: <cover.1599723087.git.liu.denton@gmail.com>
 <cover.1600328335.git.liu.denton@gmail.com>
 <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
 <xmqq363gs1mt.fsf@gitster.c.googlers.com>
 <20200918104833.GB1874074@generichostname>
 <xmqqy2l7m3hk.fsf@gitster.c.googlers.com>
 <20200920110148.GA227771@generichostname>
 <xmqqzh5jf73t.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzh5jf73t.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Sep 21, 2020 at 09:05:26AM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Hi Junio,
> >
> > On Fri, Sep 18, 2020 at 09:52:39AM -0700, Junio C Hamano wrote:
> >> I wonder if turning the builtin/diff-tree.c to match that structure
> >> make the result easier to understand (and I'll be perfectly happy if
> >> the answer to this question turns out to be "no, the result of the
> >> posted patch is the easiest to follow").
> >
> > git diff-tree does not even recognise ranges so as a result, the else
> > case does not even need to exist there, unlike in git diff.
> 
> (caution: before morning caffeine so what I say may be totally off)
> 
> Do you mean "git diff-tree HEAD^..HEAD" would fail, or something
> else?

Yes, that is what I meant but I can see that what I wrote is totally
wrong. I was reading git-diff-tree.txt and I assumed that ranges were
not supported at all.

Anyway, now that I've realised my mistake, I've rewritten the diff-tree
part so that the structure matches what was written in diff and it
should be easier to follow.

-- >8 --

From: Denton Liu <liu.denton@gmail.com>
Date: Mon, 14 Sep 2020 11:36:52 -0700
Subject: [PATCH] builtin/diff-tree: learn --merge-base

The previous commit introduced ---merge-base a way to take the diff
between the working tree or index and the merge base between an arbitrary
commit and HEAD. It makes sense to extend this option to support the
case where two commits are given too and behave in a manner identical to
`git diff A...B`.

Introduce the --merge-base flag as an alternative to triple-dot
notation. Thus, we would be able to write the above as
`git diff --merge-base A B`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-diff-tree.txt      |  7 ++++-
 Documentation/git-diff.txt           |  8 ++++--
 builtin/diff-tree.c                  | 17 +++++++++++-
 builtin/diff.c                       | 39 +++++++++++++++++++---------
 t/t4068-diff-symmetric-merge-base.sh | 34 ++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 5c8a2a5e97..2fc24c542f 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git diff-tree' [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]
-	      [-t] [-r] [-c | --cc] [--combined-all-paths] [--root]
+	      [-t] [-r] [-c | --cc] [--combined-all-paths] [--root] [--merge-base]
 	      [<common diff options>] <tree-ish> [<tree-ish>] [<path>...]
 
 DESCRIPTION
@@ -43,6 +43,11 @@ include::diff-options.txt[]
 	When `--root` is specified the initial commit will be shown as a big
 	creation event. This is equivalent to a diff against the NULL tree.
 
+--merge-base::
+	Instead of comparing the <tree-ish>s directly, use the merge
+	base between the two <tree-ish>s as the "before" side.  There
+	must be two <tree-ish>s given and they must both be commits.
+
 --stdin::
 	When `--stdin` is specified, the command does not take
 	<tree-ish> arguments from the command line.  Instead, it
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 762ee6d074..7f4c8a8ce7 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git diff' [<options>] [<commit>] [--] [<path>...]
 'git diff' [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
-'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]
+'git diff' [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
 'git diff' [<options>] <commit>...<commit> [--] [<path>...]
 'git diff' [<options>] <blob> <blob>
 'git diff' [<options>] --no-index [--] <path> <path>
@@ -62,10 +62,14 @@ of <commit> and HEAD.  `git diff --merge-base A` is equivalent to
 	branch name to compare with the tip of a different
 	branch.
 
-'git diff' [<options>] <commit> <commit> [--] [<path>...]::
+'git diff' [<options>] [--merge-base] <commit> <commit> [--] [<path>...]::
 
 	This is to view the changes between two arbitrary
 	<commit>.
++
+If --merge-base is given, use the merge base of the two commits for the
+"before" side.  `git diff --merge-base A B` is equivalent to
+`git diff $(git merge-base A B) B`.
 
 'git diff' [<options>] <commit> <commit>... <commit> [--] [<path>...]::
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 802363d0a2..9fc95e959f 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -111,6 +111,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	struct setup_revision_opt s_r_opt;
 	struct userformat_want w;
 	int read_stdin = 0;
+	int merge_base = 0;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(diff_tree_usage);
@@ -143,9 +144,18 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 			read_stdin = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--merge-base")) {
+			merge_base = 1;
+			continue;
+		}
 		usage(diff_tree_usage);
 	}
 
+	if (read_stdin && merge_base)
+		die(_("--stdin and --merge-base are mutually exclusive"));
+	if (merge_base && opt->pending.nr != 2)
+		die(_("--merge-base only works with two commits"));
+
 	/*
 	 * NOTE!  We expect "a..b" to expand to "^a b" but it is
 	 * perfectly valid for revision range parser to yield "b ^a",
@@ -165,7 +175,12 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	case 2:
 		tree1 = opt->pending.objects[0].item;
 		tree2 = opt->pending.objects[1].item;
-		if (tree2->flags & UNINTERESTING) {
+		if (merge_base) {
+			struct object_id oid;
+
+			diff_get_merge_base(opt, &oid);
+			tree1 = lookup_object(the_repository, &oid);
+		} else if (tree2->flags & UNINTERESTING) {
 			SWAP(tree2, tree1);
 		}
 		diff_tree_oid(&tree1->oid, &tree2->oid, "", &opt->diffopt);
diff --git a/builtin/diff.c b/builtin/diff.c
index 1baea18ae0..b50fc68c2a 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -26,7 +26,7 @@
 static const char builtin_diff_usage[] =
 "git diff [<options>] [<commit>] [--] [<path>...]\n"
 "   or: git diff [<options>] --cached [<commit>] [--] [<path>...]\n"
-"   or: git diff [<options>] <commit> [<commit>...] <commit> [--] [<path>...]\n"
+"   or: git diff [<options>] <commit> [--merge-base] [<commit>...] <commit> [--] [<path>...]\n"
 "   or: git diff [<options>] <commit>...<commit>] [--] [<path>...]\n"
 "   or: git diff [<options>] <blob> <blob>]\n"
 "   or: git diff [<options>] --no-index [--] <path> <path>]\n"
@@ -172,19 +172,34 @@ static int builtin_diff_tree(struct rev_info *revs,
 			     struct object_array_entry *ent1)
 {
 	const struct object_id *(oid[2]);
-	int swap = 0;
+	struct object_id mb_oid;
+	int merge_base = 0;
 
-	if (argc > 1)
-		usage(builtin_diff_usage);
+	while (1 < argc) {
+		const char *arg = argv[1];
+		if (!strcmp(arg, "--merge-base"))
+			merge_base = 1;
+		else
+			usage(builtin_diff_usage);
+		argv++; argc--;
+	}
 
-	/*
-	 * We saw two trees, ent0 and ent1.  If ent1 is uninteresting,
-	 * swap them.
-	 */
-	if (ent1->item->flags & UNINTERESTING)
-		swap = 1;
-	oid[swap] = &ent0->item->oid;
-	oid[1 - swap] = &ent1->item->oid;
+	if (merge_base) {
+		diff_get_merge_base(revs, &mb_oid);
+		oid[0] = &mb_oid;
+		oid[1] = &revs->pending.objects[1].item->oid;
+	} else {
+		int swap = 0;
+
+		/*
+		 * We saw two trees, ent0 and ent1.  If ent1 is uninteresting,
+		 * swap them.
+		 */
+		if (ent1->item->flags & UNINTERESTING)
+			swap = 1;
+		oid[swap] = &ent0->item->oid;
+		oid[1 - swap] = &ent1->item->oid;
+	}
 	diff_tree_oid(oid[0], oid[1], "", &revs->diffopt);
 	log_tree_diff_flush(revs);
 	return 0;
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetric-merge-base.sh
index 49432379cb..03487cc945 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -156,4 +156,38 @@ do
 	'
 done
 
+for cmd in diff-tree diff
+do
+	test_expect_success "$cmd --merge-base with two commits" '
+		git $cmd commit-C master >expect &&
+		git $cmd --merge-base br2 master >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$cmd --merge-base commit and non-commit" '
+		test_must_fail git $cmd --merge-base br2 master^{tree} 2>err &&
+		test_i18ngrep "fatal: --merge-base only works with commits" err
+	'
+
+	test_expect_success "$cmd --merge-base with no merge bases and two commits" '
+		test_must_fail git $cmd --merge-base br2 br3 2>err &&
+		test_i18ngrep "fatal: no merge base found" err
+	'
+
+	test_expect_success "$cmd --merge-base with multiple merge bases and two commits" '
+		test_must_fail git $cmd --merge-base master br1 2>err &&
+		test_i18ngrep "fatal: multiple merge bases found" err
+	'
+done
+
+test_expect_success 'diff-tree --merge-base with one commit' '
+	test_must_fail git diff-tree --merge-base master 2>err &&
+	test_i18ngrep "fatal: --merge-base only works with two commits" err
+'
+
+test_expect_success 'diff --merge-base with range' '
+	test_must_fail git diff --merge-base br2..br3 2>err &&
+	test_i18ngrep "fatal: --merge-base does not work with ranges" err
+'
+
 test_done
-- 
2.28.0.760.g8d73e04208

