Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573211F406
	for <e@80x24.org>; Sun, 13 May 2018 02:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeEMCYK (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:24:10 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:44559 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbeEMCYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 22:24:09 -0400
Received: by mail-vk0-f68.google.com with SMTP id x66-v6so5516669vka.11
        for <git@vger.kernel.org>; Sat, 12 May 2018 19:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BnxjWdH0zR8aYwKz2u+/8+qlHib/QOss8rw3bFf2VCQ=;
        b=oQKaVMmcKiR3nL5SDUcVONutuRzVho62qNs4LXlYzvvb9PEL8dS7Vl5kQkZETt35+b
         IRhDZMGlrPB+vvBJyvI2N3/wEuzNNGk+pK4Qw2sWxV1fTmJxpeQXGDFr4/cSEQDPss9s
         Z6cacxts0cT80ukoUdpWkAfHYfGSTvHRfOx0pmceANAf7lmrkp1ZvXqHQIdT/oDOcAn0
         2R2kjY4Z5hHMhpLLimMRQeqlRaBsPcjIhymFvOdPfrZacAU7NfZSyMdTif34S8kPm0Jm
         sVbv81Pa2yQrhiuH6+4gLSfPYuRDiu9FYuBGMpffDu5tTXd/FuZGf8rEfLmojArjZNCa
         ZLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BnxjWdH0zR8aYwKz2u+/8+qlHib/QOss8rw3bFf2VCQ=;
        b=EWgLsZxkrVxWBPz+s1lAYAHrn95Uso9MppM+ieWZw4moq9ZotgTW25zxjyJexBSsbd
         WUvO4rB78EATzoZ/XHBBoBMQ8wv6O3QLAlQjUm0K4rrts/6qj1tfktlh41rDO+ljdXy2
         eoF3FwQFLcFT4Z+1IDy7ca11uxawvTpXrOsIEu2erLTQ6xGJ1tVfsrlN8745lHyZAcrT
         FSHk+CqL1Rfn74N58vdQL1yyVb4nfSz2V35Paq6kE13Y8qUDs40SvW5fxwqo4BGdAT5Y
         aZXQs4K6g2MVV6a48+43Dnir25/AknuRMH7ZYPbd31Lkxnfha7KoLNpGFQ97BeMq/dwk
         rE2g==
X-Gm-Message-State: ALKqPwcQ3lP6QF1KMM0mdORSOq89IudiX4PbfRV0as7SC6PypfV45cqx
        Lggxo4jN49KV3duwPoxBZr6ZnWU=
X-Google-Smtp-Source: AB8JxZpEAF0DeLxg7j6WMZpZRYT3Rol++qSeMov1CY8+9baOmLf5C21nLCSilQ5BjxC3FanFEVxW3Q==
X-Received: by 2002:a1f:a193:: with SMTP id k141-v6mr6549864vke.27.1526178247136;
        Sat, 12 May 2018 19:24:07 -0700 (PDT)
Received: from localhost.localdomain (ip177-101-15-186.ct.co.cr. [186.15.101.177])
        by smtp.gmail.com with ESMTPSA id o24-v6sm1541308vki.33.2018.05.12.19.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 May 2018 19:24:06 -0700 (PDT)
From:   Dannier Castro L <danniercl@gmail.com>
To:     git@vger.kernel.org
Cc:     Dannier Castro L <danniercl@gmail.com>, gitster@pobox.com,
        Matthieu.Moy@imag.fr, jrnieder@gmail.com, bmwill@google.com
Subject: [PATCH 1/3] checkout.c: add strict usage of -- before file_path
Date:   Sat, 12 May 2018 20:23:32 -0600
Message-Id: <1526178214-30956-1-git-send-email-danniercl@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, <checkout> is a complex command able to handle both
branches and files without any distintion other than their names,
taking into account that depending on the type (branch or file),
the functionality is completely different, the easier example:

$ git checkout <branch>  # Switch from current branch to <branch>.
$ git checkout <file>    # Restore <file> from HEAD, discarding
                         # changes if it's necessary.
$ git checkout -- <file> # The same as the last one, only with an
                         # useless '--'.

For GIT new users, this complicated versatility of <checkout> could
be very confused, also considering that actually the flag '--' is
completely useless (added or not, there is not any difference for
this command), when the same program messages promote the use of
this flag.

Regarding the <checkout>'s power to overwrite any file, discarding
changes if they exist without some way of recovering them, the
solution propuses that the usage of '--' is strict before to
specify the file(s) path(s) for any <checkout> command (including
all types of flags), as a "defense barrier" to make sure about
user's knowledge and intension running <checkout>.

The solution consists in detect '--' into command args, allowing
the discard of changes and considering the following names as
file paths, otherwise, they are branch names.

Signed-off-by: Dannier Castro L <danniercl@gmail.com>
---
 builtin/checkout.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d76e13c..ec577b3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -40,6 +40,7 @@ struct checkout_opts {
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
 	int show_progress;
+	int discard_changes;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -885,8 +886,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 	/*
 	 * case 1: git checkout <ref> -- [<paths>]
 	 *
-	 *   <ref> must be a valid tree, everything after the '--' must be
-	 *   a path.
+	 *   <ref> must be a valid tree. '--' must always be before any path,
+	 *   it means, everything after the '--' must be a path.
 	 *
 	 * case 2: git checkout -- [<paths>]
 	 *
@@ -900,26 +901,28 @@ static int parse_branchname_arg(int argc, const char **argv,
 	 *       omit at most one side), and if there is a unique merge base
 	 *       between A and B, A...B names that merge base.
 	 *
-	 *   (b) If <something> is _not_ a commit, either "--" is present
-	 *       or <something> is not a path, no -t or -b was given, and
-	 *       and there is a tracking branch whose name is <something>
-	 *       in one and only one remote, then this is a short-hand to
-	 *       fork local <something> from that remote-tracking branch.
+	 *   (b) If <something> is _not_ a commit, either "--" is present,
+	 *       no -t or -b was given, and there is a tracking branch
+	 *       whose name is <something> in one and only one remote,
+	 *       then this is a short-hand to fork local <something> from
+	 *       that remote-tracking branch.
 	 *
 	 *   (c) Otherwise, if "--" is present, treat it like case (1).
 	 *
 	 *   (d) Otherwise :
 	 *       - if it's a reference, treat it like case (1)
-	 *       - else if it's a path, treat it like case (2)
 	 *       - else: fail.
 	 *
-	 * case 4: git checkout <something> <paths>
+	 *   <something> can never be a path (at least without '--' before).
+	 *
+	 * case 4: git checkout <something> -- <paths>
 	 *
 	 *   The first argument must not be ambiguous.
 	 *   - If it's *only* a reference, treat it like case (1).
-	 *   - If it's only a path, treat it like case (2).
 	 *   - else: fail.
 	 *
+	 *   <something> can never be a path (at least without '--' before).
+	 *
 	 */
 	if (!argc)
 		return 0;
@@ -928,6 +931,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	dash_dash_pos = -1;
 	for (i = 0; i < argc; i++) {
 		if (!strcmp(argv[i], "--")) {
+			opts->discard_changes = 1;
 			dash_dash_pos = i;
 			break;
 		}
@@ -957,8 +961,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 		    (check_filename(opts->prefix, arg) || !no_wildcard(arg)))
 			recover_with_dwim = 0;
 		/*
-		 * Accept "git checkout foo" and "git checkout foo --"
-		 * as candidates for dwim.
+		 * Accept "git checkout foo_branch" and
+		 * "git checkout foo_branch --" as candidates for dwim.
 		 */
 		if (!(argc == 1 && !has_dash_dash) &&
 		    !(argc == 2 && has_dash_dash))
@@ -1254,7 +1258,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	}
 
 	UNLEAK(opts);
-	if (opts.patch_mode || opts.pathspec.nr)
+	if (opts.patch_mode || (opts.pathspec.nr && opts.discard_changes))
 		return checkout_paths(&opts, new_branch_info.name);
 	else
 		return checkout_branch(&opts, &new_branch_info);
-- 
2.7.4

