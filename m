Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5251AC432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2368D21775
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGRkmnYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfK1Tc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:32:26 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33218 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfK1TcY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 14:32:24 -0500
Received: by mail-wr1-f44.google.com with SMTP id b6so2767038wrq.0
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 11:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n4kSQZRXiNjSmumdTbm6VA+QlEvnicZ1QQS9bp8Noi8=;
        b=TGRkmnYXGHSx5a09vSOVCOCbUUZTHHLMCrnzBV4nHP1G+58EDjDELdZCrzK07dgW1r
         MuWeW7C+Wx9Yx0Rld60OSIAbde7qPpwrOLN2LMxR2vKtvKvDkUFpoCv/jwqnPEXQdu2N
         mfMl/CAav97hC6bGGJnevwLkeDuglguuj8glyqD4kBlEH87FaCXXNXBRLzRJbNQyIqBB
         6J+dsiRgNlbpnbRCqVm3AA4AgiuZgFDah6/8iwry7k7SFgECA/yxbuU9A9tQTwWjAdD+
         XwJyz44EWomU7x4yCfebIo+tqQtlwYPh7tk/BxMDn6KO/sR6dZO8l2eyRi2wpKC2Cint
         mvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n4kSQZRXiNjSmumdTbm6VA+QlEvnicZ1QQS9bp8Noi8=;
        b=dCVj2eo4EvcPjqLsYaIA5+eR0UhPErF/Oj1KW4BwHQPb8IhggjrKaXkAV+an+MkXXH
         dFdN3atpoy3eCLlQeXl9ov17g5rsqRQrziYvCz59DEPRmDMwHS6Q4dMy0d6v20Xzja54
         +TrDGqAREIIzVZ8+pxh8OaI03mxtnap9H7zMwDcAG32IHKRih1PQl7n0sEgWS+J2CjTE
         YJkA6xJr02uScWQmJWKQfMKQcWF7PFrmKGdB80uUsUBp5LLJ6dbsb67LmnAnJScfATbH
         zoxUfyV5F6+/EcaY9Gwm8kTIlJ2c+c2Qongyy57mr/OulYXir+Da+nsMzzJduMo3tqE6
         /jhg==
X-Gm-Message-State: APjAAAUt/D8L013EBq38IfkdvlhupysSOf2O5wPFGzGARmogV5tqAldu
        j4pf8kNvZS20LmXnxPaq8rnYrflO
X-Google-Smtp-Source: APXvYqyYDhSJamgFEpx7NZcg8fNwHJ3R/WOhKwMeYA4klGyepF80lCpOMwCgZxdqHhceXCifom3/rg==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr39548991wrr.172.1574969541883;
        Thu, 28 Nov 2019 11:32:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm9101229wmf.47.2019.11.28.11.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 11:32:21 -0800 (PST)
Message-Id: <3918aafdbd6ae63ddb9b4ea7328b9ec2e0f76fe9.1574969538.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.479.git.1574969538.gitgitgadget@gmail.com>
References: <pull.479.git.1574969538.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Nov 2019 19:32:16 +0000
Subject: [PATCH 3/5] parse_branchname_arg(): update code comments
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
index 5c6131dbe6..723aaca0ef 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1127,45 +1127,21 @@ static int parse_branchname_arg(int argc, const char **argv,
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
@@ -1187,9 +1163,9 @@ static int parse_branchname_arg(int argc, const char **argv,
 
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
@@ -1203,14 +1179,6 @@ static int parse_branchname_arg(int argc, const char **argv,
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
@@ -1219,10 +1187,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 		if (!expect_commit_only && !no_wildcard(arg))
 			recover_with_dwim = 0;
 
-		/*
-		 * Accept "git checkout foo", "git checkout foo --"
-		 * and "git switch foo" as candidates for dwim.
-		 */
 		if (!(argc == 1 && !has_dash_dash) &&
 		    !(argc == 2 && has_dash_dash) &&
 		    opts->accept_pathspec)
@@ -1238,7 +1202,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 					    arg);
 				*new_branch = arg;
 				arg = remote;
-				/* DWIMmed to create local branch, case (3).(b) */
+				/* DWIMmed to create local branch */
 			} else {
 				recover_with_dwim = 0;
 			}
@@ -1253,19 +1217,11 @@ static int parse_branchname_arg(int argc, const char **argv,
 
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

