Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFCCC2D0D2
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FFF20717
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuEKqEc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfLPPsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:24 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39985 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbfLPPsV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:21 -0500
Received: by mail-wm1-f41.google.com with SMTP id t14so7224073wmi.5
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SEvM9l4GbW6LoBOlkeiKGv4JC4UZf/Wgwu3ZxcbPHbg=;
        b=QuEKqEc0/r0eai15MDbRnhLj/uTgdnWePs1+TtbPdB7Wo5pQ2Ybsz30jhRkkXFmuMs
         ozivhTuE58I7RT70Wlm0c/4YcuWJ6ImP6oHxsWQm2kVP2ivhX+RHWzN4e8JuuIphFXhA
         2mb0wFmkyBalcifPuKnRB+YNFpc5diavrIh47E2HsPgY/cAlGCtqM2RUBeJxC7U2JzDb
         rnE/m5MzThNC4gtXvwN3ea3R4jzDru6Y8OgBD5dLdZPy+bj14J4jeuBxU7/M5fFS3Xt0
         HxUHjWnmmhYrypK5gBdRK78dg4RAAa7hrN8jdhfxy+5N3Z97c/RJvdVWdhjbBkZsuzjB
         EtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SEvM9l4GbW6LoBOlkeiKGv4JC4UZf/Wgwu3ZxcbPHbg=;
        b=mGA+mookpmZmDlTZ/yiFFRw2t3NCBn3opokEG6pZemSrUd56UK/mAibjCig1NC/wi+
         ylZ56dheTTWKa2V9Ewe0jA90u2Zep0bwk5SyDtYSPthEU5hZr2qyOxLuisKPdKisLwbJ
         lmqOljgB/UqOXYifM9gUfOAmHuoKd/NAn4U1fSwcRgWBga1HMKUZNEjVOy6hlrxYBgo4
         2xglysyoGS0yG47rjFk6YkyGh3rmdfyTzs/oEcS7U4oKKGJ9zb+rhvjWJh0TfT5FkwFj
         o2lvEa/K6pguJ60NMLnJPseh38Nb/3oVL48+ZvRqTm0NDkoogYDmJNfDVUJjEqNMyNPS
         zwrg==
X-Gm-Message-State: APjAAAWAWgH9ItoZCulGs0bjMdJjZmo7bW6xYAl93HdJgfhlX2Gj/FXP
        UjRv4+DvFs631/Mz+/nueOBZYoAB
X-Google-Smtp-Source: APXvYqwR9ChZPnbfFAYttFYHegYagkvfjQyBrD9n7X/pk+2UUbBZ6jO66m3Vg5S8IYUO1wdhwXiO+Q==
X-Received: by 2002:a05:600c:108a:: with SMTP id e10mr29739250wmd.38.1576511298270;
        Mon, 16 Dec 2019 07:48:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6sm22279332wrq.92.2019.12.16.07.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:17 -0800 (PST)
Message-Id: <46f676b8e09a2bfc17e2d3ef6e2202d438284fd7.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:48:03 +0000
Subject: [PATCH v2 15/18] parse_branchname_arg(): update code comments
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

These parts repeat git documentation:
    ... if <something> is A...B <...>
    ... remote named in checkout.defaultRemote ...

Some parts repeat the code below. With next patch, code will be easier
to understand, so this is no longer needed.

This is a separate patch to reduce the amount of diffs in next patch.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c | 86 +++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 65 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index bd0efa9140..6072f7cef7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1158,45 +1158,21 @@ static int parse_branchname_arg(int argc, const char **argv,
 	int i;
 
 	/*
-	 * case 1: git checkout <ref> -- [<paths>]
-	 *
-	 *   <ref> must be a valid tree, everything after the '--' must be
-	 *   a path.
-	 *
-	 * case 2: git checkout -- [<paths>]
-	 *
-	 *   everything after the '--' must be paths.
-	 *
-	 * case 3: git checkout <something> [--]
-	 *
-	 *   (a) If <something> is a commit, that is to
-	 *       switch to the branch or detach HEAD at it.  As a special case,
-	 *       if <something> is A...B (missing A or B means HEAD but you can
-	 *       omit at most one side), and if there is a unique merge base
-	 *       between A and B, A...B names that merge base.
-	 *
-	 *   (b) If <something> is _not_ a commit, either "--" is present
-	 *       or <something> is not a path, no -t or -b was given, and
-	 *       and there is a tracking branch whose name is <something>
-	 *       in one and only one remote (or if the branch exists on the
-	 *       remote named in checkout.defaultRemote), then this is a
-	 *       short-hand to fork local <something> from that
-	 *       remote-tracking branch.
-	 *
-	 *   (c) Otherwise, if "--" is present, treat it like case (1).
-	 *
-	 *   (d) Otherwise :
-	 *       - if it's a reference, treat it like case (1)
-	 *       - else if it's a path, treat it like case (2)
-	 *       - else: fail.
-	 *
-	 * case 4: git checkout <something> <paths>
-	 *
-	 *   The first argument must not be ambiguous.
-	 *   - If it's *only* a reference, treat it like case (1).
-	 *   - If it's only a path, treat it like case (2).
-	 *   - else: fail.
-	 *
+	 * Resolve ambiguity where argv[0] may be <pathspec> or <commit>.
+	 * High-level approach is:
+	 * 1) Use various things to reduce ambiguity, examples:
+	 *    * '--' is present
+	 *    * command doesn't accept <pathspec>
+	 *    * additional options like '-b' were given
+	 * 2) If ambiguous and matches both existing <commit> and existing
+	 *    file, complain. However, in 1-argument 'git checkout <arg>'
+	 *    treat as <commit> to avoid annoying users.
+	 * 3) Otherwise, if it matches some existing <commit>, treat as
+	 *    <commit>.
+	 * 4) Otherwise, if it matches a remote branch, and it's considered
+	 *    reasonable to DWIM to create a local branch from remote branch,
+	 *    do that and proceed with (2)(3).
+	 * 5) Otherwise, let caller proceed with <pathspec> interpretation.
 	 */
 	if (!argc)
 		return 0;
@@ -1218,9 +1194,9 @@ static int parse_branchname_arg(int argc, const char **argv,
 
 	if (opts->accept_pathspec) {
 	    if (dash_dash_pos == 0)
-		    return 1; /* case (2) */
+		    return 1;
 	    else if (dash_dash_pos == 1)
-		    has_dash_dash = 1; /* case (3) or (1) */
+		    has_dash_dash = 1;
 	    else if (dash_dash_pos >= 2)
 		    die(_("only one reference expected, %d given."), dash_dash_pos);
 	}
@@ -1234,14 +1210,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 		arg = "@{-1}";
 
 	if (get_oid_mb(arg, rev)) {
-		/*
-		 * Either case (3) or (4), with <something> not being
-		 * a commit, or an attempt to use case (1) with an
-		 * invalid ref.
-		 *
-		 * It's likely an error, but we need to find out if
-		 * we should auto-create the branch, case (3).(b).
-		 */
 		int recover_with_dwim = dwim_new_local_branch_ok;
 
 		int could_be_checkout_paths = !expect_commit_only &&
@@ -1250,10 +1218,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 		if (!expect_commit_only && !no_wildcard(arg))
 			recover_with_dwim = 0;
 
-		/*
-		 * Accept "git checkout foo", "git checkout foo --"
-		 * and "git switch foo" as candidates for dwim.
-		 */
 		if (!(argc == 1 && !has_dash_dash) &&
 		    !(argc == 2 && has_dash_dash) &&
 		    opts->accept_pathspec)
@@ -1265,7 +1229,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 			if (remote) {
 				*new_branch = arg;
 				arg = remote;
-				/* DWIMmed to create local branch, case (3).(b) */
+				/* DWIMmed to create local branch */
 			} else {
 				recover_with_dwim = 0;
 			}
@@ -1280,19 +1244,11 @@ static int parse_branchname_arg(int argc, const char **argv,
 
 	setup_new_branch_info_and_source_tree(new_branch_info, opts, rev, arg);
 
-	if (!opts->source_tree)                   /* case (1): want a tree */
+	if (!opts->source_tree)
 		die(_("reference is not a tree: %s"), arg);
 
-	if (!expect_commit_only) {	/* case (3).(d) -> (1) */
-		/*
-		 * Do not complain the most common case
-		 *	git checkout branch
-		 * even if there happen to be a file called 'branch';
-		 * it would be extremely annoying.
-		 */
-		if (argc > 1)
-			verify_non_filename(opts->prefix, arg);
-	}
+	if (!expect_commit_only && argc > 1)
+		verify_non_filename(opts->prefix, arg);
 
 	return (dash_dash_pos == 1) ? 2 : 1;
 }
-- 
gitgitgadget

