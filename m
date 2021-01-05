Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960EFC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 11:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57FFD229CA
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 11:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbhAELDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 06:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbhAELDG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 06:03:06 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7086EC061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 03:02:25 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q75so2651282wme.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 03:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=CHH/MPzqpL+d1MJjBmu5kKq3pSr+ymlJxhFEtAnuQkk=;
        b=N4QyWedidgQ8by0iSoyIhBAYG8xad99A05cgxfpupTYV7e8jElFARCE22COaaFcjNs
         AyniDYoqoB3gnIuKNflfCHm/PcqnszChWKdNiL7eZGTeLiAGkLyVGID+XILrJHd8Q+n7
         44VwRrd/RUw1hOPyE9gv38CdepJli8ztEhVo8cOOTSu093ytrywaQ3SyanZlT92FQk3R
         b72Hgov+1Oj582e8qQUmQenxwXsiBlG9rb87kJQjv3YqHs1x3XOpHXk0AbiVNepHfcmI
         h6MDDI158LMx5JaZXFra0YOr+lm7nHRAOz3WjvJom2XI5a8dt+selRpfk0Rbcdf7qZy1
         pNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=CHH/MPzqpL+d1MJjBmu5kKq3pSr+ymlJxhFEtAnuQkk=;
        b=QaHTr2o0OTu2v0CGmdDWZ2n9/3YpK2+nkWXkcLYERASt76/rfHxPzrITvjwO5+0Tkt
         P2+hxZ86rDv16JIsKdf44CRI/WTLT+wuPITfp1ihE1vLuFxGF82xcC+pNC6aytMum3gP
         XgI9cvEjDCsPJFyyXvZWoEZXP71ZFFGocmF0obYQB4BFp8xSihW9NhhvfPT+MQOzKQ3q
         G53HMmQEHdthJyyQAor4vwP2Rst7r8Z4eJmFViRTmKg6dQ9ALZXlmkCy1+1O4PPfvI1j
         n7d3IavfaKP5c2NrDcxxdJ5ckwGpLlhvUDykE88q9fzi4WCMTb8ereVa4NdqwoqXcfgp
         pXRg==
X-Gm-Message-State: AOAM532KmSPKC+X+oIPXtQ9jLcQf7NH/Cx0FpHMr/IZYHj3uNglX08Xh
        dgTW7uiGHMPrZ2UIUVwdzD7y5cZ+Jok=
X-Google-Smtp-Source: ABdhPJytnUyAfo++J8OGvC7uFb0PoRZmPKH+q8NQonCk/XwX8Tj2/79YbrPk/lg4pxfiG87MYnc19A==
X-Received: by 2002:a1c:61c3:: with SMTP id v186mr2937513wmb.146.1609844543908;
        Tue, 05 Jan 2021 03:02:23 -0800 (PST)
Received: from localhost.localdomain (183.252.189.80.dyn.plus.net. [80.189.252.183])
        by smtp.gmail.com with ESMTPSA id o83sm3716608wme.21.2021.01.05.03.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 03:02:23 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] worktree: add -z option for list subcommand
Date:   Tue,  5 Jan 2021 11:02:19 +0000
Message-Id: <20210105110219.99610-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <428d16e8-fdb8-a587-6a0b-39c6c50eba99@gmail.com>
References: <428d16e8-fdb8-a587-6a0b-39c6c50eba99@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add a -z option to be used in conjunction with --porcelain that gives
NUL-terminated output. This enables 'worktree list --porcelain' to
handle worktree paths that contain newlines.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
I found an old patch that added NUL termination. I've rebased it
but the new test fails as there seems to be another worktree thats
been added since I wrote this, anyway I thought it might be a useful
start for adding a `-z` option.

 Documentation/git-worktree.txt | 13 +++++++++---
 builtin/worktree.c             | 36 ++++++++++++++++++++++------------
 t/t2402-worktree-list.sh       | 22 +++++++++++++++++++++
 3 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index af06128cc9..a07b593cc3 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
-'git worktree list' [--porcelain]
+'git worktree list' [--porcelain [-z]]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
@@ -217,7 +217,13 @@ This can also be set up as the default behaviour by using the
 --porcelain::
 	With `list`, output in an easy-to-parse format for scripts.
 	This format will remain stable across Git versions and regardless of user
-	configuration.  See below for details.
+	configuration.  It is recommended to combine this with `-z`.
+	See below for details.
+
+-z::
+	When `--porcelain` is specified with `list` terminate each line with a
+	NUL rather than a newline. This makes it possible to parse the output
+	when a worktree path contains a newline character.
 
 -q::
 --quiet::
@@ -369,7 +375,8 @@ $ git worktree list
 
 Porcelain Format
 ~~~~~~~~~~~~~~~~
-The porcelain format has a line per attribute.  Attributes are listed with a
+The porcelain format has a line per attribute.  If `-z` is given then the lines
+are terminated with NUL rather than a newline.  Attributes are listed with a
 label and value separated by a single space.  Boolean attributes (like `bare`
 and `detached`) are listed as a label only, and are present only
 if the value is true.  The first attribute of a working tree is always
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 197fd24a55..0cd331873c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -640,19 +640,25 @@ static int add(int ac, const char **av, const char *prefix)
 	return add_worktree(path, branch, &opts);
 }
 
-static void show_worktree_porcelain(struct worktree *wt)
+static void show_worktree_porcelain(struct worktree *wt, int line_terminator)
 {
-	printf("worktree %s\n", wt->path);
-	if (wt->is_bare)
-		printf("bare\n");
-	else {
-		printf("HEAD %s\n", oid_to_hex(&wt->head_oid));
-		if (wt->is_detached)
-			printf("detached\n");
-		else if (wt->head_ref)
-			printf("branch %s\n", wt->head_ref);
+	printf("worktree %s", wt->path);
+	fputc(line_terminator, stdout);
+	if (wt->is_bare) {
+		printf("bare");
+		fputc(line_terminator, stdout);
+	} else {
+		printf("HEAD %s", oid_to_hex(&wt->head_oid));
+		fputc(line_terminator, stdout);
+		if (wt->is_detached) {
+			printf("detached");
+			fputc(line_terminator, stdout);
+		} else if (wt->head_ref) {
+			printf("branch %s", wt->head_ref);
+			fputc(line_terminator, stdout);
+		}
 	}
-	printf("\n");
+	fputc(line_terminator, stdout);
 }
 
 static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
@@ -720,15 +726,20 @@ static void pathsort(struct worktree **wt)
 static int list(int ac, const char **av, const char *prefix)
 {
 	int porcelain = 0;
+	int line_terminator = '\n';
 
 	struct option options[] = {
 		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
+		OPT_SET_INT('z', NULL, &line_terminator,
+			    N_("fields are separated with NUL character"), '\0'),
 		OPT_END()
 	};
 
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (ac)
 		usage_with_options(worktree_usage, options);
+	else if (!line_terminator && !porcelain)
+		die(_("'-z' requires '--porcelain'"));
 	else {
 		struct worktree **worktrees = get_worktrees();
 		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
@@ -741,7 +752,8 @@ static int list(int ac, const char **av, const char *prefix)
 
 		for (i = 0; worktrees[i]; i++) {
 			if (porcelain)
-				show_worktree_porcelain(worktrees[i]);
+				show_worktree_porcelain(worktrees[i],
+							line_terminator);
 			else
 				show_worktree(worktrees[i], path_maxlen, abbrev);
 		}
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 795ddca2e4..acd9f8ab84 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -71,6 +71,28 @@ test_expect_success '"list" all worktrees with locked annotation' '
 	! grep "/unlocked  *[0-9a-f].* locked$" out
 '
 
+test_expect_success '"list" all worktrees --porcelain -z' '
+	test_when_finished "rm -rf here _actual actual expect &&
+				git worktree prune" &&
+	printf "worktree %sQHEAD %sQbranch %sQQ" \
+		"$(git rev-parse --show-toplevel)" \
+		"$(git rev-parse HEAD)" \
+		"$(git symbolic-ref HEAD)" >expect &&
+	git worktree add --detach here master &&
+	printf "worktree %sQHEAD %sQdetachedQQ" \
+		"$(git -C here rev-parse --show-toplevel)" \
+		"$(git rev-parse HEAD)" >>expect &&
+	git worktree list --porcelain -z >_actual &&
+	cat _actual | tr "\0" Q >actual	&&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" -z fails without --porcelain' '
+	test_when_finished "rm -rf here && git worktree prune" &&
+	git worktree add --detach here master &&
+	test_must_fail git worktree list -z
+'
+
 test_expect_success 'bare repo setup' '
 	git init --bare bare1 &&
 	echo "data" >file1 &&
-- 
2.30.0

