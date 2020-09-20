Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95259C43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A1A21BE5
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDI9b406"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgITLWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgITLWq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 07:22:46 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBEFC061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:46 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s14so5766504pju.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ZYmuow/rpB+xylB4OIHhJ8ndIQZ0NEnmaGcdJruz4g=;
        b=BDI9b406Oqi9vGoAAjQNSPLhiYPsjRGzgFN8/QDdP9WvZKOf1LyuYEwcAHQMjnhguy
         BKYi4sjy1l2u/FUNPf87h68Mk77T/sG1ZDQTXsSVsr/SJ7t5wqGW7CuOrbsPrdLxdGHH
         1jzQIgLE/E6zqRuNp9/pTlTth2hiXpzf/rVm6VIX7U1rvWMzeQMGCZHzAj5agvHo1zSg
         Rn1tXdxQfooQIgQLflf7KK52Cii9qvVyC731Xh+P55OSXRBLxKdgnu9abXKGqPQf0Q2r
         1Z4U9XYSAE5P+8HL3urvMPFCPVLUkx3yXofIMdKElQRVcn52CCKBLlru5lA698sQLM31
         QqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZYmuow/rpB+xylB4OIHhJ8ndIQZ0NEnmaGcdJruz4g=;
        b=BPzUvNiBd8C0tC0IGgaVzAZrsdGUlNteiFNCwiMEGWtJDYlg4cwSSfxSQHOOsbZB7s
         77KJ/HqtOPLtxZyWx6Vk+V7UvQudIIJuJ+L9H2Yg545YtZunIgZXr5x5yzxJCEkC0Ckb
         WAcf4DMTuwrwm2fZZHGTlGjd1+/IWccsVd/Z2e4hzmcDiYSxJYGq/sOMoWHoVHqieTmr
         BuDI+V5P+oBey4bbRhl0tS5Xtqx+0+jJp014WyhqcSP+Xv4TAvxgc2HIrqhyMtpYQRFN
         FBrtDb5tJ8HcibJ8XiI23g3rZHoCrdyFqW9AEh3rfLD7VIVaYArKUlL6soWO2dEIMZ+7
         LDGg==
X-Gm-Message-State: AOAM532RbyfsA5Amf/SWKofGS46UM320/Sd4ER10jzxcMEL+XG74Dm9O
        S6jvtXYYxrOwXjliF0xykWi7bvYzr1c=
X-Google-Smtp-Source: ABdhPJxiWsSz48/mxr3NDWToeHJYDvE8R/pmY05of7W/WNRrKZqeNvPHytfW35Hpw9kWH2JO+a3zbg==
X-Received: by 2002:a17:90a:481:: with SMTP id g1mr20207084pjg.157.1600600965596;
        Sun, 20 Sep 2020 04:22:45 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id y79sm9550737pfb.45.2020.09.20.04.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:22:44 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 09/10] builtin/diff-tree: learn --merge-base
Date:   Sun, 20 Sep 2020 04:22:26 -0700
Message-Id: <4880d21119c8b67ab53db8ce82196855f6e8680f.1600600823.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600600823.git.liu.denton@gmail.com>
References: <cover.1600328335.git.liu.denton@gmail.com> <cover.1600600823.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 builtin/diff-tree.c                  | 18 +++++++++++++
 builtin/diff.c                       | 39 +++++++++++++++++++---------
 t/t4068-diff-symmetric-merge-base.sh | 34 ++++++++++++++++++++++++
 5 files changed, 91 insertions(+), 15 deletions(-)

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
index 802363d0a2..823d6678e5 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -111,6 +111,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	struct setup_revision_opt s_r_opt;
 	struct userformat_want w;
 	int read_stdin = 0;
+	int merge_base = 0;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(diff_tree_usage);
@@ -143,9 +144,26 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
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
+
+	if (merge_base) {
+		struct object_id oid;
+
+		if (opt->pending.nr != 2)
+			die(_("--merge-base only works with two commits"));
+
+		diff_get_merge_base(opt, &oid);
+		opt->pending.objects[0].item = lookup_object(the_repository, &oid);
+	}
+
 	/*
 	 * NOTE!  We expect "a..b" to expand to "^a b" but it is
 	 * perfectly valid for revision range parser to yield "b ^a",
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

