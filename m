Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969D0C41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42107207EA
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNbwK3NK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgJGH42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 03:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgJGH41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 03:56:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FCAC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 00:56:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id x5so643992pjv.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 00:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IEBOZbXX6goiKh3UqhsWJVdxvu/ESMP4O+77qY0N2D8=;
        b=LNbwK3NKfxst5uYNLJzX/qYICwRycdSUfOf56lrqnGvAiedgur81ZquYrixs4aN8Ca
         ZHImVFO4dg+6ALnDa92jRT+2zmImabReDfeusmS+uLcHgBi0qtbitI0EjfBh1jFx8v/q
         Q6/c+4iW/ZlJFDODwId+EY+2iltpkHW4Quf4lTPeuXG2xLANKvaP8/5csWVzySm0AShw
         HcjzjDeJphfxIJsp1bOtK4QJGe0+8lq9YQip+8wtry7tHdCKsc+HGHMrx1WusPtW3XN2
         lo3dqYo806fTgdrdaUsLywB4lvovOBIUJO/rMrhSl9nADVcz9tky/wCejz6gIyf/9K2A
         a/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEBOZbXX6goiKh3UqhsWJVdxvu/ESMP4O+77qY0N2D8=;
        b=UUb0drvilUQsQxrtUAdnlOy9IiYsawY60WFmnbY3QTSnZ2koNu59lcNH9jHACnug1y
         tfyEtXRM6C7yJqPUCtMXHxMrjJZUXTHR6u6OnlpJQdLcYUGyMyvAxuWAqR5M+uw4P1zS
         1r1mCZgpaPzWchZ09Z5irAge7mYlDDmAaAKACxgA04kcXxAVlj9/izvWKDZSenB4/DSE
         Re2QYRXAbLwgn7xRYv7Yw8NRlGCgqXhV9iZfl+v1BBsiOQvGYVXKJf1tp8jg5cfu6aCz
         q5UEfCFsAhPmcFiHBXZ5nSvx+vb19Px5NkSx3fxQpSBmPqviU+2V7aQFa9THcrX3P/UK
         ZSog==
X-Gm-Message-State: AOAM530EBj96FP1ia1hZQkpOgCfW+paZgS4yPia6fk9zBWxJotg5BY5j
        M7zuzJy1KU/DTTBCDgUUXqNnuJ7S+Eg=
X-Google-Smtp-Source: ABdhPJwqdsM2MLnx46Il6SzBoqh5hsh6tLElXZEQau4h5f297NuuAtLxoEYchAfuH1jRzP5ebjT+rQ==
X-Received: by 2002:a17:90b:902:: with SMTP id bo2mr1778662pjb.169.1602057386609;
        Wed, 07 Oct 2020 00:56:26 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id n9sm1909950pgi.2.2020.10.07.00.56.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:56:25 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 1/4] builtin/checkout: fix `git checkout -p HEAD...` bug
Date:   Wed,  7 Oct 2020 00:56:15 -0700
Message-Id: <723d74febe967ab0142ab1d931e1cac7b6e34461.1602057332.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1602057332.git.liu.denton@gmail.com>
References: <cover.1601814601.git.liu.denton@gmail.com> <cover.1602057332.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running `git checkout -p` with a merge-base rev results in an error:

	$ git checkout -p HEAD...
	usage: git diff-index [-m] [--cached] [<common-diff-options>] <tree-ish> [<path>...]
	common diff options:
	  -z            output diff-raw with lines terminated with NUL.
	  -p            output patch format.
	  -u            synonym for -p.
	  --patch-with-raw
			output both a patch and the diff-raw format.
	  --stat        show diffstat instead of patch.
	  --numstat     show numeric diffstat instead of patch.
	  --patch-with-stat
			output a patch and prepend its diffstat.
	  --name-only   show only names of changed files.
	  --name-status show names and status of changed files.
	  --full-index  show full object name on index lines.
	  --abbrev=<n>  abbreviate object names in diff-tree header and diff-raw.
	  -R            swap input file pairs.
	  -B            detect complete rewrites.
	  -M            detect renames.
	  -C            detect copies.
	  --find-copies-harder
			try unchanged files as candidate for copy detection.
	  -l<n>         limit rename attempts up to <n> paths.
	  -O<file>      reorder diffs according to the <file>.
	  -S<string>    find filepair whose only one side contains the string.
	  --pickaxe-all
			show all files diff when -S is used and hit is found.
	  -a  --text    treat all files as text.

	Cannot close git diff-index --cached --numstat --summary HEAD... -- () at <redacted>/libexec/git-core/git-add--interactive line 183.

This happens because checkout passes the literal argument (in the
example, `HEAD...`) to diff-index which does not recognise merge-base
revs.

Fix this by using the hex of the found commit instead of the given name.
Note that "HEAD" is handled specially in run_add_interactive() so it's
explicitly not changed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/checkout.c        | 15 ++++++++++++++-
 t/t2016-checkout-patch.sh |  7 +++++++
 t/t2071-restore-patch.sh  |  8 ++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0951f8fee5..2e69ed24f2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -471,6 +471,19 @@ static int checkout_paths(const struct checkout_opts *opts,
 
 	if (opts->patch_mode) {
 		const char *patch_mode;
+		const char *rev = new_branch_info->name;
+		char rev_oid[GIT_MAX_HEXSZ + 1];
+
+		/*
+		 * Since rev can be in the form of `<a>...<b>` (which is not
+		 * recognized by diff-index), we will always replace the name
+		 * with the hex of the commit (whether it's in `...` form or
+		 * not) for the run_add_interactive() machinery to work
+		 * properly. However, there is special logic for the HEAD case
+		 * so we mustn't replace that.
+		 */
+		if (rev && strcmp(rev, "HEAD"))
+			rev = oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);
 
 		if (opts->checkout_index && opts->checkout_worktree)
 			patch_mode = "--patch=checkout";
@@ -481,7 +494,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		else
 			BUG("either flag must have been set, worktree=%d, index=%d",
 			    opts->checkout_worktree, opts->checkout_index);
-		return run_add_interactive(new_branch_info->name, patch_mode, &opts->pathspec);
+		return run_add_interactive(rev, patch_mode, &opts->pathspec);
 	}
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 47aeb0b167..999620e507 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -59,6 +59,13 @@ test_expect_success PERL 'git checkout -p HEAD with change already staged' '
 	verify_state dir/foo head head
 '
 
+test_expect_success PERL 'git checkout -p HEAD^...' '
+	# the third n is to get out in case it mistakenly does not apply
+	test_write_lines n y n | git checkout -p HEAD^... &&
+	verify_saved_state bar &&
+	verify_state dir/foo parent parent
+'
+
 test_expect_success PERL 'git checkout -p HEAD^' '
 	# the third n is to get out in case it mistakenly does not apply
 	test_write_lines n y n | git checkout -p HEAD^ &&
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index 98b2476e7c..b5c5c0ff7e 100755
--- a/t/t2071-restore-patch.sh
+++ b/t/t2071-restore-patch.sh
@@ -60,6 +60,14 @@ test_expect_success PERL 'git restore -p --source=HEAD^' '
 	verify_state dir/foo parent index
 '
 
+test_expect_success PERL 'git restore -p --source=HEAD^...' '
+	set_state dir/foo work index &&
+	# the third n is to get out in case it mistakenly does not apply
+	test_write_lines n y n | git restore -p --source=HEAD^... &&
+	verify_saved_state bar &&
+	verify_state dir/foo parent index
+'
+
 test_expect_success PERL 'git restore -p handles deletion' '
 	set_state dir/foo work index &&
 	rm dir/foo &&
-- 
2.28.0.942.g77c4c6094c

