Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B03C00454
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A606214AF
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVuebDF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfLLOgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39180 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbfLLOgi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id d5so2762238wmb.4
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pl1TpHYzXwy6qo5ZtDysRDq+srYsDkMx0RzC+6DqdnM=;
        b=WVuebDF5hcpHyaaBVvFn+kn/j2iuNPiUbV1+XteNFA9k4y82r6J/s+wDukFbTY0IaR
         vXCSXH+ukKXFV88JNTC66E93ULOXcFzjdqIPQxBLnFjwHTEUT5QIJEbgbi07FP5bPmL+
         TqCslUYqfEbwlim0QGValwjOLwmwVaAOEfAbFcQJAr6NoBgXFNJHeFz0j9PeBBj05X8L
         IPfaDCya1Xysh5Yopy56a2ityC2x+EIwIY3uUv98HA92P//pF7Wx7tZjYPeDo6Qnqc8Q
         3eX43LFg5qArOWQTlqOMZfLSYbFmE5vdbjG48fBdB3d4ln5Ekp9rfHKQYoLKogV/FkCb
         qtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pl1TpHYzXwy6qo5ZtDysRDq+srYsDkMx0RzC+6DqdnM=;
        b=ggud+PK74LhEUZEuPz647/5WlzgFyoiIIEL//EhW50LYiBwSk0KZVgnwxxBOI0u6Uw
         uXOU13Fb6Hq5tOANQ7nwTaZGGT3cZY8QXTZLejPf5iAWBhTEo86ksHHo00BThg1cA66W
         ZJI9yzG6Y61d+dK3jyOSdFM4RUJCCtdp4cmg2pNqTWHDJmPFcP4h7zp+Qxczo0KwEhUh
         8cSTs1iLjLc8BYN2a+MhYhxJGe2Y8aWtwRrZfaYwDnopHuc2yU6SRtrjVy6PHsOI0pRJ
         ZafOYZRpp93x97/Tidi7t9v2/CuEOJDMVFS6zSO+mryS9yIfUd3rP3UUD13R8UGDT2HO
         rMrg==
X-Gm-Message-State: APjAAAUxwhjavOgDhdw14jw1yMaFl683BzOwt40Q9KY6WhuOSU0DzcsF
        ffJKBx8BVw0K+17BQ4OcO+CX+mSE
X-Google-Smtp-Source: APXvYqyaxhyX1ZBqyIlosgoZBt7wB0xhf5KWyPSJG2k8J/MLmI0IHcb1rwX4b1myWwLQ9qHWKxUHVw==
X-Received: by 2002:a1c:1d16:: with SMTP id d22mr7267639wmd.158.1576161396673;
        Thu, 12 Dec 2019 06:36:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v4sm9780222wml.2.2019.12.12.06.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:36 -0800 (PST)
Message-Id: <010fd76331f9203c22353cebcfefc63c8d97e4f2.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:23 +0000
Subject: [PATCH 14/16] parse_branchname_arg(): refactor the decision making
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano" 
        <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>,
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

