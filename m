Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CCCC2D0BF
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBA8206E0
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg5Fw2KE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfLPPsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:20 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38057 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfLPPsT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:19 -0500
Received: by mail-wr1-f47.google.com with SMTP id y17so7868907wrh.5
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vYMZZrAA8gSnK0xocnJOdw8ushEIXxcOsNHiNiWxEm8=;
        b=Zg5Fw2KEjww9578aUlOb+2g+9dL2ucJ2cvpxhGRl9lSCpj/0hmFgtmHfP2cbYdmyV8
         2gxtbpSPbKR4RuiHcNB24YrnHjUvFYJyIRAUU7pYKmEg8C6Lo8A4Mpa69oVTBk1kSIcK
         Vu7nOguHkub+BUKITgkbcUMmtb372QDP+kh75sc9aSxhmLmcncu2PWkiXbDAEdA/Dx1W
         px3uRf0DiBZgR31CojdUILG64ayW99j56oGSSg8AgfpA+sDJ6KKJxoW1gfGmGVabQKaD
         +xKAf0LLuvjjuyjLfcfabCNygUz9vYue3k5MaIJcuXtyv8x5NyaYcKoy5XSeDvifwxpa
         nIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vYMZZrAA8gSnK0xocnJOdw8ushEIXxcOsNHiNiWxEm8=;
        b=othjgrzd3cjqELEZ1U+ZUqEpmY+OoBUuj3s2LS0mFML/r1y+/L0VtS+dbmzEsMy6Xv
         AAO3NzNi2QZ/EHVVirwZX4N+Mx6et8vF8LKjebG9kYWLxVYP9qR2Gr5bOMyNtfR08SaI
         D9e1vNWMjR2wrdiLW5Rytnys0MzBnoLVmRneNeYsr+lXX4cy/PDsmkEGt9P3JzlD/IxS
         RGO4DebPJeiJFic3UYnHRF3k+nzRvXWMPLjfcH6tmq1DXFFlasOQFFtiy5oRpy+R/xmF
         XaQsaoTZLUEvwFpc3J3nizZkQ5AQphBvQOlae7KCbDM0dia3CprkpL1E+7E1riyt36b+
         L79Q==
X-Gm-Message-State: APjAAAXlTTOHL46QY76nWkBPby7QCB1qyDNO0y8wkGTcqUrR/AKAC+1P
        G9wO2x0TvKZwVmH4lTWo2F3sKx+D
X-Google-Smtp-Source: APXvYqwzllwpSy1tlQQfkm/jWQppuzQMG+GyXxGiFmhdZ0Ht7KrNmJdaUD0eDGmOcY5i02NMMrxO4w==
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr27861119wrn.320.1576511296093;
        Mon, 16 Dec 2019 07:48:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm21944925wrt.37.2019.12.16.07.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:15 -0800 (PST)
Message-Id: <efd6876874512d9ded6352c979046dffd19a5a57.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:48:00 +0000
Subject: [PATCH v2 12/18] checkout: die() on ambiguous tracking branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
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

