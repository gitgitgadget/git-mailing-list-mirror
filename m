Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089351F404
	for <e@80x24.org>; Sun, 25 Mar 2018 13:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeCYNqa (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 09:46:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40327 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbeCYNq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 09:46:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id t6so10897899wmt.5
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SldWW8qq6BflNEneDdDIFlpUq8gZ7PuWTvi29dPTD60=;
        b=JSUq4rbfouAl49K3EQxHSoysoy2iDDfoY3kVnvEHX+WRt2y3vBvc4uXXKmCVcaQP0a
         QpWpuOkAuYIiCb9fO+e8rvhtMTADw21o5nS57KSNM3vV145z32Olz+TJEnj2CvrSxdd9
         WERBJBntEqrSdiNADx3dT2kWtmKT6u0j4OhkspNxtocv7pp7RMrYZiZHvceS4zDygqSE
         oEK/jia6a9stncc7IrDV+OW9pAjwuO5HEwAJpZQ14eTQ+OPC9B3nR+UCpREH9OmIhvke
         jP6cQK6DPdVfVlLvzurePY/xFKCAig+fjkAs6uqSDk5p0lIufvpD5WtdduNn2Oq7uJpX
         gFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SldWW8qq6BflNEneDdDIFlpUq8gZ7PuWTvi29dPTD60=;
        b=WMvSciJVreW9/bTkeu4lwGR74cw438zjELKPJY/gWvvi4rFrzjUIayz672rCfrvGxq
         9JLlQ+VsElxnva5pU7JcstM/obFEWwXsT+tJ5dTHSPkxIoiFI2ys/PPxD3lFEd61moIm
         N3d1pYg7YWp5Qearn7Jvi96eKvUUIrPx7i7y9traTF22YAlDEiyDgb9+1vJEkWWte6x5
         rrU2kpHUa7ZqH9eELFQSsv+bGJK2fbhh7UDe/pn8Oazc0izxfLp+D8YCUtZOyUHhLxRb
         CFglBuwtWCXDji8409qldA8cTGfZfDtRJmYzAnwCZPxqctdcDn8VaIdOz0OqroQTvzAA
         4Z3g==
X-Gm-Message-State: AElRT7FFWPEQG0L3rYH6Zwp4xVicQfOn0JbHvH//Vp6tcvSIvDGY4cqS
        at1lh7M/qlnzC8QkaPexHEcoVMjr
X-Google-Smtp-Source: AIpwx4+8kerOGmOcaaL8JDUswho/DMqrbyzcWe5fjSlJ4S/5MpBLNi/Xq4wV3qAo08c3TuGJIzUBug==
X-Received: by 10.28.46.5 with SMTP id u5mr6312051wmu.139.1521985588289;
        Sun, 25 Mar 2018 06:46:28 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id p29sm17244813wmf.3.2018.03.25.06.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 06:46:27 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 0/6] worktree: teach "add" to check out existing branches
Date:   Sun, 25 Mar 2018 14:49:41 +0100
Message-Id: <20180325134947.25828-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.77.g8685934aa2
In-Reply-To: <20180317222219.4940-1-t.gummerer@gmail.com>
References: <20180317222219.4940-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Eric for the review of the previous round and Duy and Junio for
additional comments.

Previous rounds are at <20180121120208.12760-1-t.gummerer@gmail.com>,
<20180204221305.28300-1-t.gummerer@gmail.com>,
<20180317220830.30963-1-t.gummerer@gmail.com> and
<20180317222219.4940-1-t.gummerer@gmail.com>.

This round should address all of Eric's comments from the previous round.

As explained in more detail in a reply to the review comment directly,
I did not add an enum to 'struct add_opts', for 'force_new_branch' and
'checkout_existing_branch', but instead removed 'force_new_branch'
from the struct as it's not required.

The rest of the updates are mainly in the user facing messages,
documentation and one added test.

Interdiff below:

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 98731b71a7..eaa6bf713f 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -67,7 +67,7 @@ doesn't exist, a new branch based on HEAD is automatically created as
 if `-b <branch>` was given.  If `<branch>` exists in the repository,
 it will be checked out in the new worktree, if it's not checked out
 anywhere else, otherwise the command will refuse to create the
-worktree.
+worktree (unless `--force` is used).
 
 list::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index df5c0427ba..895838b943 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -28,7 +28,6 @@ struct add_opts {
 	int checkout;
 	int keep_locked;
 	const char *new_branch;
-	int force_new_branch;
 	int checkout_existing_branch;
 };
 
@@ -320,12 +319,12 @@ static int add_worktree(const char *path, const char *refname,
 		goto done;
 
 	if (opts->checkout_existing_branch)
-		fprintf(stderr, _("checking out branch '%s'"),
-			refname);
+		fprintf_ln(stderr, _("checking out branch '%s'"),
+			   refname);
 	else if (opts->new_branch)
-		fprintf(stderr, _("creating branch '%s'"), opts->new_branch);
+		fprintf_ln(stderr, _("creating branch '%s'"), opts->new_branch);
 
-	fprintf(stderr, _("worktree HEAD is now at %s"),
+	fprintf(stderr, _("new worktree HEAD is now at %s"),
 		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
 
 	strbuf_reset(&sb);
@@ -434,8 +433,7 @@ static int add(int ac, const char **av, const char *prefix)
 	if (!strcmp(branch, "-"))
 		branch = "@{-1}";
 
-	opts.force_new_branch = !!new_branch_force;
-	if (opts.force_new_branch) {
+	if (new_branch_force) {
 		struct strbuf symref = STRBUF_INIT;
 
 		opts.new_branch = new_branch_force;
@@ -472,7 +470,7 @@ static int add(int ac, const char **av, const char *prefix)
 		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
 		argv_array_push(&cp.args, "branch");
-		if (opts.force_new_branch)
+		if (new_branch_force)
 			argv_array_push(&cp.args, "--force");
 		argv_array_push(&cp.args, opts.new_branch);
 		argv_array_push(&cp.args, branch);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 721b0e4c26..fb99f4c46f 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -198,15 +198,15 @@ test_expect_success '"add" with <branch> omitted' '
 	test_cmp_rev HEAD bat
 '
 
-test_expect_success '"add" auto-vivify checks out existing branch' '
+test_expect_success '"add" checks out existing branch of dwimd name' '
 	test_commit c1 &&
 	test_commit c2 &&
-	git branch precious HEAD~1 &&
-	git worktree add precious &&
-	test_cmp_rev HEAD~1 precious &&
+	git branch dwim HEAD~1 &&
+	git worktree add dwim &&
+	test_cmp_rev HEAD~1 dwim &&
 	(
-		cd precious &&
-		test_cmp_rev precious HEAD
+		cd dwim &&
+		test_cmp_rev dwim HEAD
 	)
 '
 
@@ -216,6 +216,10 @@ test_expect_success '"add" auto-vivify fails with checked out branch' '
 	test_path_is_missing test-branch
 '
 
+test_expect_success '"add --force" with existing dwimd name doesnt die' '
+	git worktree add --force test-branch
+'
+
 test_expect_success '"add" no auto-vivify with --detach and <branch> omitted' '
 	git worktree add --detach mish/mash &&
 	test_must_fail git rev-parse mash -- &&

Thomas Gummerer (6):
  worktree: improve message when creating a new worktree
  worktree: be clearer when "add" dwim-ery kicks in
  worktree: remove force_new_branch from struct add_opts
  worktree: factor out dwim_branch function
  worktree: teach "add" to check out existing branches
  t2025: rename now outdated branch name

 Documentation/git-worktree.txt |  9 ++++--
 builtin/worktree.c             | 64 +++++++++++++++++++++++++++++++-----------
 t/t2025-worktree-add.sh        | 23 +++++++++++----
 3 files changed, 72 insertions(+), 24 deletions(-)

-- 
2.16.1.77.g8685934aa2

