Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9A0C2D0CD
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F54206E0
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkOOSafJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfLPPs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52835 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbfLPPsU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so7281287wmc.2
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pl1TpHYzXwy6qo5ZtDysRDq+srYsDkMx0RzC+6DqdnM=;
        b=XkOOSafJOqwUhhPM6UqhslfLCK7gUR30AZ3IxmCZHe2dCK+3xUm7vYDeflNXl54V6z
         fC6EG+ukynxfEhro9tzXGn5HSgbqQKTEIcZu00LhhCe0CxIcbL72KMN4eevwGhG+sifP
         fW/sfHeZLodRgeB+W5AfTMV3KYgGs/ir/ZsNJLLfPqmmdMgLpJcI29tWoD5eHLwzMxGA
         6YzIvITj268ocJuKwcBRvmQOU+MxCvKDc7qxgI0Lm3i2AzRQDQ0MseyF87gGeFIHFjfj
         7tmDiXCr0aOaMPD0pueFveE2DkwmpKLZS9TpjFOuiwUSn86iQOlzvnXC+h8FzFPolpLp
         aLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pl1TpHYzXwy6qo5ZtDysRDq+srYsDkMx0RzC+6DqdnM=;
        b=YgLi4ddL3BX3+HEcYv5ynHeeImpuWjPo6Ohyf7hCAKDOxXivU/CJM4ckaQlIq7J8NF
         2/3ekFeUjjEEjlqjVT6xnBYaZ9c30aUyijnv9At5ePGc1lqLWqNHVa0KKBWC3jGGS3+z
         KccV/XOWOeeqCPZNRvaOYj5pnHkS/UPKoZjMOF1MnEv1FbMNkoYFRlFjLAtZsrxn52vM
         2iJ5BQ+kfCSGcEV6ip2rHx/dm+bU7aQgooq2eMjj6DpqEK/rNga/vapGv2n2DjwU2XoI
         PD7hKAKbVHCkG6t+PeDdDsjBVXR9qGbVZt91ase2Jql+htQ52voo6X+vLYwKmkk/0rXZ
         7Zxw==
X-Gm-Message-State: APjAAAXtGSHEqX7H8qSxAQrKBD8JNKjJAp7wbf9Un6Cz+UA9SA0KDeGg
        FYHEe8E/xKu0yal8J4JqK8xren/J
X-Google-Smtp-Source: APXvYqyby5vSY14aOM0s9665A4UaniqkUzapz7zSeG4sVa4B2u2sxfzZ/J1QrvMDNxgghOaWSSt/vw==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr32973155wmc.78.1576511298990;
        Mon, 16 Dec 2019 07:48:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm21885057wru.44.2019.12.16.07.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:18 -0800 (PST)
Message-Id: <319151e4e978298ae2a5b8321207ef53a60689d8.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:48:04 +0000
Subject: [PATCH v2 16/18] parse_branchname_arg(): refactor the decision making
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

Make it easier to understand which branches handle which cases.

Drop obfuscated variable `has_dash_dash` which also took
`opts->accept_pathspec` into account, making it pretty hard to reason
about code, especially when used together with `argc` and
`opts->accept_pathspec` here:

	if (!(argc == 1 && !has_dash_dash) &&
		!(argc == 2 && has_dash_dash) &&
		opts->accept_pathspec)
		recover_with_dwim = 0;

Avoid double-negation in the code mentioned above ("it is not OK to
proceed if it's not one of those cases").

Avoid hard-to-understand condition `opts->accept_pathspec` in the code
mentioned above.

There are some minor die() message changes for:
`git switch <commit> <unexpected>`
`git switch <commit> -- <unexpected>`

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c | 74 ++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 29 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6072f7cef7..aa4ff14ec2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1153,9 +1153,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 {
 	const char **new_branch = &opts->new_branch;
 	const char *arg;
-	int dash_dash_pos;
-	int has_dash_dash = 0, expect_commit_only = 0;
-	int i;
+	int dash_dash_pos, i;
+	int recover_with_dwim, expect_commit_only;
 
 	/*
 	 * Resolve ambiguity where argv[0] may be <pathspec> or <commit>.
@@ -1174,15 +1173,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	 *    do that and proceed with (2)(3).
 	 * 5) Otherwise, let caller proceed with <pathspec> interpretation.
 	 */
-	if (!argc)
-		return 0;
-
-	if (!opts->accept_pathspec) {
-		if (argc > 1)
-			die(_("only one reference expected"));
-		has_dash_dash = 1; /* helps disambiguate */
-	}
-
+	 
 	arg = argv[0];
 	dash_dash_pos = -1;
 	for (i = 0; i < argc; i++) {
@@ -1192,17 +1183,49 @@ static int parse_branchname_arg(int argc, const char **argv,
 		}
 	}
 
-	if (opts->accept_pathspec) {
-	    if (dash_dash_pos == 0)
-		    return 1;
-	    else if (dash_dash_pos == 1)
-		    has_dash_dash = 1;
-	    else if (dash_dash_pos >= 2)
-		    die(_("only one reference expected, %d given."), dash_dash_pos);
-	}
+	if (dash_dash_pos == -1) {
+		if (argc == 0) {
+			/* 'git checkout/switch/restore' */
+			return 0;
+		} else if (argc == 1) {
+			/* 'git checkout/switch/restore <something>' */
+			recover_with_dwim = dwim_new_local_branch_ok;
+		} else if (!opts->accept_pathspec) {
+			/* 'git switch <commit> <unexpected> [...]' */
+			die(_("only one reference expected, %d given."), argc);
+		} else {
+			/* 'git checkout/restore <something> <pathspec> [...]' */
+			recover_with_dwim = 0;
+		}
+
+		/*
+		 * Absence of '--' leaves <pathspec>/<commit> ambiguity.
+		 * Try to resolve it with additional knowledge about pathspec args.
+		 */
+		expect_commit_only = !opts->accept_pathspec;
+	} else if (dash_dash_pos == 0) {
+		/* 'git checkout/switch/restore -- [...]' */
+		return 1;  /* Eat '--' */
+	} else if (dash_dash_pos == 1) {
+		if (!opts->accept_pathspec) {
+			/* 'git switch <commit> -- [...]' */
+			die(_("incompatible with pathspec arguments"));
+		}
+
+		if (argc == 2) {
+			/* 'git checkout/restore <commit> --' */
+			recover_with_dwim = dwim_new_local_branch_ok;
+		} else {
+			/* 'git checkout/restore <commit> -- <pathspec> [...]' */
+			recover_with_dwim = 0;
+		}
 
-	if (has_dash_dash)
-	    expect_commit_only = 1;
+		/* Presence of '--' makes it certain that arg is <commit> */
+		expect_commit_only = 1;
+	} else {
+		/* 'git checkout/switch/restore <commit> <unxpected> [...] -- [...]' */
+		die(_("only one reference expected, %d given."), dash_dash_pos);
+	}
 
 	opts->count_checkout_paths = !opts->quiet && !expect_commit_only;
 
@@ -1210,19 +1233,12 @@ static int parse_branchname_arg(int argc, const char **argv,
 		arg = "@{-1}";
 
 	if (get_oid_mb(arg, rev)) {
-		int recover_with_dwim = dwim_new_local_branch_ok;
-
 		int could_be_checkout_paths = !expect_commit_only &&
 			check_filename(opts->prefix, arg);
 
 		if (!expect_commit_only && !no_wildcard(arg))
 			recover_with_dwim = 0;
 
-		if (!(argc == 1 && !has_dash_dash) &&
-		    !(argc == 2 && has_dash_dash) &&
-		    opts->accept_pathspec)
-			recover_with_dwim = 0;
-
 		if (recover_with_dwim) {
 			const char *remote = parse_remote_branch(arg, rev,
 								 could_be_checkout_paths);
-- 
gitgitgadget

