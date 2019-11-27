Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46EBC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDFB2073F
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc2+w8NQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfK0QnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:43:17 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39671 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfK0QnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 11:43:16 -0500
Received: by mail-wm1-f49.google.com with SMTP id s14so1507433wmh.4
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 08:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vYMZZrAA8gSnK0xocnJOdw8ushEIXxcOsNHiNiWxEm8=;
        b=cc2+w8NQrMkTjzVCrVDCSp9yi/7QdWd7oO9F+JOhq2hcNK706CeNTnzxvqHZMt6X8o
         YDrDQ4IkZC8Ry7qS2420ehmJRqWIOnR7e74v1J9nePLJUwDANNHIbrR3Z+zcwJnTZtU6
         lQXKrP4q9h1aFEdPLoux6R+8Sfp7btl4xoVgbQ3NaJchBnsdh5w+JxOXp23MUFLAhGE/
         uTL2BBBxaEB04T9Iis1uZ0DTacEm8g5GDSueDOYnW4HsTwWIfJqeO10A4ZEJsus9WOXm
         2NoBXcTFQBTpv8QIAVffbLrKyWAVZ0mpZ8qxMeJTCuKWb8rpSTextlZM8nJkG9s2xs0U
         gCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vYMZZrAA8gSnK0xocnJOdw8ushEIXxcOsNHiNiWxEm8=;
        b=nUi4f06vfDF6Fs5TTyboz+tGpOcRYjiAOVZ4iG/rs+onJXqRlPRQI9ZGcq5fom6xDt
         EkYOCW9obvtdFpYTKikRBg/MLAi5AgJAa+v1vOUGZiQHgZnFPBa/w7aF3suGfCjhvJlg
         KKsDl0FdwkULVXhvvlpCtXE2chEnyJ7Cy4ssV56qIAoxiCHW+nGj/MZ/8uuikkJIXE9A
         0oJ0hr3GEeEk7h5pfWfEC725jDDh1XeS0Jp55Y2xVWlY6btXDl414SvmuVVH/4vAbZI/
         G1yW48Fi23CykBn0IdkvVtfY8sOk64OOajGrZfEKRwZG7nMRAJQVpoJA2f9JDuCi9mnR
         8dnQ==
X-Gm-Message-State: APjAAAWKWgEwp9/Han2JhsNAPPjuxPmheo/lcMyoUKXcGosJQCIjtSeZ
        1TDeANoEXy6qGdKRLcySdIQrw4VG
X-Google-Smtp-Source: APXvYqyN5SOjXIvtxfgBDFW48kAxFuXpKOu41zZ7mAuxZS3WfGpSL9BD4ZdfAqYDRjH2veGimFkrhw==
X-Received: by 2002:a1c:3c86:: with SMTP id j128mr5242096wma.137.1574872993768;
        Wed, 27 Nov 2019 08:43:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t187sm7241195wma.16.2019.11.27.08.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 08:43:13 -0800 (PST)
Message-Id: <575eeb97bac2b1f5864aeb3c195547398f00db15.1574872991.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.477.v2.git.1574872991.gitgitgadget@gmail.com>
References: <pull.477.git.1574848137.gitgitgadget@gmail.com>
        <pull.477.v2.git.1574872991.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Nov 2019 16:43:10 +0000
Subject: [PATCH v2 2/2] checkout: die() on ambiguous tracking branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Before this patch, when there were multiple DWIM candidates for remote
branch, git decided to try the argument as pathspec instead. I believe
that such behavior is a surprise: adding another remote suddenly causes
git to discard file contents, because it was unsure which branch to
pick. There was an incomplete attempt to prevent that in [3].

I understand that this was never intended:

  [1] introduces the unexpected behavior. Before, there was fallback
  from not-a-ref to pathspec. This is reasonable DWIM. After, there is
  another fallback from ambiguous-remote to pathspec. I understand that
  it was kind of copy&paste oversight.

  [2] noticed the unexpected behavior but chose to semi-document it
  instead of forbidding, because the goal of the patch series was
  focused on something else.

  [3] adds `die()` when there is ambiguity between branch and file. The
  case of multiple tracking branches is seemingly overlooked.

Change to complain about ambiguity instead of doing unexpected things.

[1] Commit 70c9ac2f ("DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"" 2009-10-18)
    https://public-inbox.org/git/7vaazpxha4.fsf_-_@alter.siamese.dyndns.org/
[2] Commit ad8d5104 ("checkout: add advice for ambiguous "checkout <branch>"", 2018-06-05)
    https://public-inbox.org/git/20180502105452.17583-1-avarab@gmail.com/
[3] Commit be4908f1 ("checkout: disambiguate dwim tracking branches and local files", 2018-11-13)
    https://public-inbox.org/git/20181110120707.25846-1-pclouds@gmail.com/

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c       | 56 ++++++++++++++++++----------------------
 t/t2024-checkout-dwim.sh | 28 ++++++++++++++++++--
 2 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e1b9df1543..b847695d2b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1115,10 +1115,10 @@ static void setup_new_branch_info_and_source_tree(
 
 static const char *parse_remote_branch(const char *arg,
 				       struct object_id *rev,
-				       int could_be_checkout_paths,
-				       int *dwim_remotes_matched)
+				       int could_be_checkout_paths)
 {
-	const char *remote = unique_tracking_name(arg, rev, dwim_remotes_matched);
+	int num_matches = 0;
+	const char *remote = unique_tracking_name(arg, rev, &num_matches);
 	
 	if (remote && could_be_checkout_paths) {
 		die(_("'%s' could be both a local file and a tracking branch.\n"
@@ -1126,6 +1126,22 @@ static const char *parse_remote_branch(const char *arg,
 		    arg);
 	}
 
+	if (!remote && num_matches > 1) {
+	    if (advice_checkout_ambiguous_remote_branch_name) {
+		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
+			     "you can do so by fully qualifying the name with the --track option:\n"
+			     "\n"
+			     "    git checkout --track origin/<name>\n"
+			     "\n"
+			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
+			     "one remote, e.g. the 'origin' remote, consider setting\n"
+			     "checkout.defaultRemote=origin in your config."));
+	    }
+
+	    die(_("'%s' matched multiple (%d) remote tracking branches"),
+		arg, num_matches);
+	}
+
 	return remote;
 }
 
@@ -1133,8 +1149,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new_branch_info,
 				struct checkout_opts *opts,
-				struct object_id *rev,
-				int *dwim_remotes_matched)
+				struct object_id *rev)
 {
 	const char **new_branch = &opts->new_branch;
 	int argcount = 0;
@@ -1240,8 +1255,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 
 		if (recover_with_dwim) {
 			const char *remote = parse_remote_branch(arg, rev,
-								 could_be_checkout_paths,
-								 dwim_remotes_matched);
+								 could_be_checkout_paths);
 			if (remote) {
 				*new_branch = arg;
 				arg = remote;
@@ -1505,7 +1519,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			 const char * const usagestr[])
 {
 	struct branch_info new_branch_info;
-	int dwim_remotes_matched = 0;
 	int parseopt_flags = 0;
 
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
@@ -1613,8 +1626,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
-					     &new_branch_info, opts, &rev,
-					     &dwim_remotes_matched);
+					     &new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
@@ -1672,28 +1684,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 
 	UNLEAK(opts);
-	if (opts->patch_mode || opts->pathspec.nr) {
-		int ret = checkout_paths(opts, new_branch_info.name);
-		if (ret && dwim_remotes_matched > 1 &&
-		    advice_checkout_ambiguous_remote_branch_name)
-			advise(_("'%s' matched more than one remote tracking branch.\n"
-				 "We found %d remotes with a reference that matched. So we fell back\n"
-				 "on trying to resolve the argument as a path, but failed there too!\n"
-				 "\n"
-				 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
-				 "you can do so by fully qualifying the name with the --track option:\n"
-				 "\n"
-				 "    git checkout --track origin/<name>\n"
-				 "\n"
-				 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
-				 "one remote, e.g. the 'origin' remote, consider setting\n"
-				 "checkout.defaultRemote=origin in your config."),
-			       argv[0],
-			       dwim_remotes_matched);
-		return ret;
-	} else {
+	if (opts->patch_mode || opts->pathspec.nr)
+		return checkout_paths(opts, new_branch_info.name);
+	else
 		return checkout_branch(opts, &new_branch_info);
-	}
 }
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index fa0718c730..c35d67b697 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -37,7 +37,9 @@ test_expect_success 'setup' '
 		git checkout -b foo &&
 		test_commit a_foo &&
 		git checkout -b bar &&
-		test_commit a_bar
+		test_commit a_bar &&
+		git checkout -b ambiguous_branch_and_file &&
+		test_commit a_ambiguous_branch_and_file
 	) &&
 	git init repo_b &&
 	(
@@ -46,7 +48,9 @@ test_expect_success 'setup' '
 		git checkout -b foo &&
 		test_commit b_foo &&
 		git checkout -b baz &&
-		test_commit b_baz
+		test_commit b_baz &&
+		git checkout -b ambiguous_branch_and_file &&
+		test_commit b_ambiguous_branch_and_file
 	) &&
 	git remote add repo_a repo_a &&
 	git remote add repo_b repo_b &&
@@ -75,6 +79,26 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
 	test_branch master
 '
 
+test_expect_success 'when arg matches multiple remotes, do not fallback to interpreting as pathspec' '
+	# create a file with name matching remote branch name
+	git checkout -b t_ambiguous_branch_and_file &&
+	>ambiguous_branch_and_file &&
+	git add ambiguous_branch_and_file &&
+	git commit -m "ambiguous_branch_and_file" &&
+
+	# modify file to verify that it will not be touched by checkout
+	test_when_finished "git checkout -- ambiguous_branch_and_file" &&
+	echo "file contents" >ambiguous_branch_and_file &&
+	cp ambiguous_branch_and_file expect &&
+
+	test_must_fail git checkout ambiguous_branch_and_file 2>err &&
+
+	test_i18ngrep "matched multiple (2) remote tracking branches" err &&
+	
+	# file must not be altered
+	test_cmp expect ambiguous_branch_and_file
+'
+
 test_expect_success 'checkout of branch from multiple remotes fails with advice' '
 	git checkout -B master &&
 	test_might_fail git branch -D foo &&
-- 
gitgitgadget
