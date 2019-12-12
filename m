Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C3EC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA26214AF
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGUVhDIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfLLOgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:43 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:40495 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729799AbfLLOgh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:37 -0500
Received: by mail-wr1-f42.google.com with SMTP id c14so2974684wrn.7
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SEvM9l4GbW6LoBOlkeiKGv4JC4UZf/Wgwu3ZxcbPHbg=;
        b=rGUVhDIpwA1Jh6vLx+Fg80mmxKiolH26z7WhS9i9E8JsIn+x437dSPokjzDtvQkPO9
         +QX3UmhfdWg5wywaRug9f84d2PFPKfYt3IJfDh+Xnx8ENswTJJ0KJT14do0HLI7XD+Ib
         7/dgGcWDjl552j83OgXWB0JqCWnfIDnHpwpuEUQQEgqPfvACHhlQhdL1/ojF9N+peVNm
         RYxM3A3Ns+/9wyGLx5W8oT4+D4xp48y939OcjpK5e6/EgkHi1WuvqIiTXPTI3rIOS7+G
         3igIHQ7JqAlAjmw2CdArzqmMRLOOFkg0OzrhEyOEoHJRkjyB5ejEb8oFNpN4sWddYGde
         O6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SEvM9l4GbW6LoBOlkeiKGv4JC4UZf/Wgwu3ZxcbPHbg=;
        b=OTtE53989NvFwyhA4fopIQRYxchyIg8NbQWUSh+3aAKJNLHlZP4Aj0lv4vv0tfVeML
         o7RY80ZezgDVvrAybMh7HaS9oqcxGpu34128+Hg5HV6fiLWXH3JYuThOfnJre9mXX669
         8EUTUVUmocmqUgcjwk8cepdvF08Z2gokbwX5+c/w6eyRd1Ovam45eKH3UkoZDk5YJtCZ
         RkUo+Pu6Fr9fnoaGazKgtwl3mkJRQ0+yxafQoJ9UpBgEC/BMwX8LuDEjL6+rsWIBjZe2
         wUx8YyOf3CIWvqddLGqBXbDtrwiownCOW1XwowkMw3FeEwV44m5KDXGMOWXXaS19WhTM
         R7DQ==
X-Gm-Message-State: APjAAAW4SG8iFZ1P18XYiH32a7Uk964NhyjbchStNltYMCBZ6oBg3dIV
        sU4vIU5svtsVSjOgjEsAWvomSbUJ
X-Google-Smtp-Source: APXvYqzPH7S7yCCPquGpvg8d9TW10AX0k5OyAypCVO3zoslx3fnduF9ScHcz9Mngb0BKP/l7EaTgHw==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr6889288wrq.196.1576161395923;
        Thu, 12 Dec 2019 06:36:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n129sm9124423wmb.1.2019.12.12.06.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:35 -0800 (PST)
Message-Id: <4e2bb6663cdce7fe18e07a5a3713d9ee0c7a7c70.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:22 +0000
Subject: [PATCH 13/16] parse_branchname_arg(): update code comments
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

