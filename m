Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1675BC4363C
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 12:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1EF3206A1
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 12:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKCqieZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgJDMan (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 08:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgJDMan (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 08:30:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4940BC0613CF
        for <git@vger.kernel.org>; Sun,  4 Oct 2020 05:30:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i3so3621847pjz.4
        for <git@vger.kernel.org>; Sun, 04 Oct 2020 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fN5l12+kdSKZyCyuR8yXGqq9L2nadVq/bC3AyoOTG6A=;
        b=jKCqieZAni9LuawLQ2xbjSc8F1uytzgLR7+dj/ESxu+6/+6n/1DrgNDtomZ381o2uJ
         /Rbjd6DVuUCIJZ4iAccwyRGvU8eY6OJ7kvsxylXIGDSIMEmnb1+meP0TxXw+05Hr75ch
         PH3MJn3wlOIYSX5SEigioY9M08czEfAWTxzLB079m5zepmX9HA92hyj9H42Dk9pUVaR6
         t0sy3JYvm9cWr+pX9rZa7Mo+15M7wltlccUA7fDu6fr3XMe7GdkOOrAZCN6YNGl9Tyqn
         QLWLqaG1N9Hep/WFJTx6PMKPz08sK5fyIozYC90XrXjAb2qfxhGKjZ5TTcdY9jTkYECr
         bIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fN5l12+kdSKZyCyuR8yXGqq9L2nadVq/bC3AyoOTG6A=;
        b=r90RbXxWS9GpSnlTJQ8kakKUQHkcsjGj2WbCddhPM1n6vAiRIrclAtRAs6aaNLj7Qd
         ICa6W7MX+F1dshxYWYQ84t3sXXTm8ipaY3zw+IktoCY22IGdf2htbxKh609I1E0NfrPH
         +eDo2AFbL69FRNmdQih0US7zmZP+xtwhuv5FtMRdYQ8F6zP6eaBFwpgktL5SrQEocYp6
         l5CqIbhdqwHvht9VvLD0gC16qJKbU7Jo7ydK26ouVO2DYeCM5jEjacLJ4oDFTbr2+bVF
         b+JL1z7Og/MtMtrLhHr+6pyE1TefM534ByHwQ99l0D7iEKKdtlDeP+4k+n/wKQzNO8I9
         +TaA==
X-Gm-Message-State: AOAM5330iF4yOa7Gx6OLbk7SKJP1jjxmfsZFhczYduCjZ7eQW2OtNTj1
        L8EjlHdosjIXZJO66VAHyJdoizka5eI=
X-Google-Smtp-Source: ABdhPJyXHNa14B+LnrfB5TwGWRpayKJ4jo4FDXtm6noJn8r98HUFTwq6dnOF3qumnQ7C9lO2c5dYFw==
X-Received: by 2002:a17:90a:a58d:: with SMTP id b13mr11580868pjq.196.1601814642359;
        Sun, 04 Oct 2020 05:30:42 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e8sm7372299pgj.8.2020.10.04.05.30.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 05:30:41 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/2] builtin/checkout: fix `git checkout -p HEAD...` bug
Date:   Sun,  4 Oct 2020 05:30:33 -0700
Message-Id: <54f221411f4ec60a88521c376a1c77fa0a3e7553.1601814601.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1601814601.git.liu.denton@gmail.com>
References: <cover.1601814601.git.liu.denton@gmail.com>
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
 builtin/checkout.c        | 14 +++++++++++++-
 t/t2016-checkout-patch.sh |  7 +++++++
 t/t2071-restore-patch.sh  |  8 ++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0951f8fee5..95122e16ed 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -471,6 +471,18 @@ static int checkout_paths(const struct checkout_opts *opts,
 
 	if (opts->patch_mode) {
 		const char *patch_mode;
+		const char *rev = new_branch_info->name;
+		char rev_oid[GIT_MAX_HEXSZ + 1];
+
+		/*
+		 * Since rev can be in the form of `<a>...<b>`, we must replace
+		 * the name with the hex of the commit for the
+		 * run_add_interactive() machinery to work properly. However,
+		 * there is special logic for the HEAD case so we mustn't
+		 * replace that.
+		 */
+		if (rev && strcmp(rev, "HEAD"))
+			rev = oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);
 
 		if (opts->checkout_index && opts->checkout_worktree)
 			patch_mode = "--patch=checkout";
@@ -481,7 +493,7 @@ static int checkout_paths(const struct checkout_opts *opts,
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

