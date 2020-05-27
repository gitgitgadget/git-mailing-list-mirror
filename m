Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320E8C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A8E207E8
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEz3vBUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgE0VJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 17:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgE0VJK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 17:09:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F91C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 14:09:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j198so3090001wmj.0
        for <git@vger.kernel.org>; Wed, 27 May 2020 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=6GmFEkM8k2+J6lIcLPzcxY/5+XG7kpS/LdARGJwQlBQ=;
        b=iEz3vBUpcALoT92s2277pX1xhxBgPjQAcO9jj7YBd9WTjiEI6m+dF/02oQnxjffvEA
         SMWBBJf+ND2xAAjeehSY/oo/TqwxaKbm7+Tx6ybSPQRr/nrkY/OXyj9wJS9H3DNAaoxE
         Y++GuG3Fncm0I0e5wn8zh27lr5FpSEBE+nurW5dnePainereS4X9dxCDvdsAx2i6Z9Tw
         XSc9S1LRIB9rTqv8VSVxK1/y/qa8y1pzjA23OYF9rmv5x4SlUo8k3xUlbwA5SRXxUUrM
         PzhaTqCV8HOe7rd85UgSgCFBhqPpe4bk+e9U6QfcIgaZ0b2bx+qxalMQ9z1RNSfAOPy+
         /sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=6GmFEkM8k2+J6lIcLPzcxY/5+XG7kpS/LdARGJwQlBQ=;
        b=RE9Gmxzs3tKuuOttOlUHr8i/N79YdgfWUxnltjbKNZ7R/etF7dMzJVknc8wr44x3DP
         9TEQUfI01XHxHU17NTN89dcgBqCPjEDpjR7TLBnJVLcOtQ8681GPg+PNFcoJn8mbpceK
         +PHwqhlJYlOduPtHGtBGdVFUgm62J3vPOJt8OlUDKqnLDhE7H2QVIGKNa/vQSJWIs+c9
         ahnwhHbXGUcTaRjZ+sR/MDZRijn40SNUJgd9u1+YeFPsg4/VVlnC2rtGjwAdJauN1uBC
         pSvKKuG9HeZHtzFfJI2dgmxxQqHuixNBlTWBL8BZdv4unjAPxNQSJmYBXVY8fIwMlbs5
         o7dg==
X-Gm-Message-State: AOAM5326OO52MKW/PsdKcwtgnk5qDfCGWT9MzILOcaoP/9TNTonAtABo
        oZgnGviw4iEM62or3UEcKkCbB/3i
X-Google-Smtp-Source: ABdhPJzWo89YpqpiBrxdyTqHbeYB3GceNvxWokHbHJ4oC3uiE/veDbCzFnJtyZO/T0lWV2aMMGpEjA==
X-Received: by 2002:a1c:b654:: with SMTP id g81mr51468wmf.128.1590613747864;
        Wed, 27 May 2020 14:09:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z206sm4190938wmg.30.2020.05.27.14.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 14:09:07 -0700 (PDT)
Message-Id: <pull.646.git.1590613746507.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 May 2020 21:09:06 +0000
Subject: [PATCH] checkout -p: handle new files correctly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Merlin =?UTF-8?Q?B=C3=BCge?= <toni@bluenox07.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The original patch selection code was written for `git add -p`, and the
fundamental unit on which it works is a hunk.

We hacked around that to handle deletions back in 24ab81ae4d
(add-interactive: handle deletion of empty files, 2009-10-27). But `git
add -p` would never see a new file, since we only consider the set of
tracked files in the index.

However, since the same machinery was used for `git checkout -p` &
friends, we can see new files.

Handle this case specifically, adding a new prompt for it that is
modeled after the `deleted file` case.

This also fixes the problem where added _empty_ files could not be
staged via `git checkout -p`.

Reported-by: Merlin Büge <toni@bluenox07.de>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Allow empty, new files to be staged via git checkout -p
    
    For ease of backporting, this patch is based on js/add-p-leftover-bits.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-646%2Fdscho%2Fcheckout-p-empty-file-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-646/dscho/checkout-p-empty-file-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/646

 add-patch.c                | 30 +++++++++++++++++++++++-------
 git-add--interactive.perl  | 21 +++++++++++++++++++--
 t/t3701-add-interactive.sh | 19 +++++++++++++++++++
 3 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index d8dafa8168d..eaace1b824f 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -9,7 +9,7 @@
 #include "compat/terminal.h"
 
 enum prompt_mode_type {
-	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK,
+	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_ADDITION, PROMPT_HUNK,
 	PROMPT_MODE_MAX, /* must be last */
 };
 
@@ -32,6 +32,7 @@ static struct patch_mode patch_mode_add = {
 	.prompt_mode = {
 		N_("Stage mode change [y,n,q,a,d%s,?]? "),
 		N_("Stage deletion [y,n,q,a,d%s,?]? "),
+		N_("Stage addition [y,n,q,a,d%s,?]? "),
 		N_("Stage this hunk [y,n,q,a,d%s,?]? ")
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
@@ -53,6 +54,7 @@ static struct patch_mode patch_mode_stash = {
 	.prompt_mode = {
 		N_("Stash mode change [y,n,q,a,d%s,?]? "),
 		N_("Stash deletion [y,n,q,a,d%s,?]? "),
+		N_("Stash addition [y,n,q,a,d%s,?]? "),
 		N_("Stash this hunk [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
@@ -76,6 +78,7 @@ static struct patch_mode patch_mode_reset_head = {
 	.prompt_mode = {
 		N_("Unstage mode change [y,n,q,a,d%s,?]? "),
 		N_("Unstage deletion [y,n,q,a,d%s,?]? "),
+		N_("Unstage addition [y,n,q,a,d%s,?]? "),
 		N_("Unstage this hunk [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
@@ -98,6 +101,7 @@ static struct patch_mode patch_mode_reset_nothead = {
 	.prompt_mode = {
 		N_("Apply mode change to index [y,n,q,a,d%s,?]? "),
 		N_("Apply deletion to index [y,n,q,a,d%s,?]? "),
+		N_("Apply addition to index [y,n,q,a,d%s,?]? "),
 		N_("Apply this hunk to index [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
@@ -120,6 +124,7 @@ static struct patch_mode patch_mode_checkout_index = {
 	.prompt_mode = {
 		N_("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
 		N_("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard addition from worktree [y,n,q,a,d%s,?]? "),
 		N_("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
@@ -142,6 +147,7 @@ static struct patch_mode patch_mode_checkout_head = {
 	.prompt_mode = {
 		N_("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Discard deletion from index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard addition from index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
@@ -163,6 +169,7 @@ static struct patch_mode patch_mode_checkout_nothead = {
 	.prompt_mode = {
 		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply addition to index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
@@ -185,6 +192,7 @@ static struct patch_mode patch_mode_worktree_head = {
 	.prompt_mode = {
 		N_("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Discard deletion from index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard addition from index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
@@ -206,6 +214,7 @@ static struct patch_mode patch_mode_worktree_nothead = {
 	.prompt_mode = {
 		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply addition to index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
@@ -247,7 +256,7 @@ struct add_p_state {
 		struct hunk head;
 		struct hunk *hunk;
 		size_t hunk_nr, hunk_alloc;
-		unsigned deleted:1, mode_change:1,binary:1;
+		unsigned deleted:1, added:1, mode_change:1,binary:1;
 	} *file_diff;
 	size_t file_diff_nr;
 
@@ -441,7 +450,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	pend = p + plain->len;
 	while (p != pend) {
 		char *eol = memchr(p, '\n', pend - p);
-		const char *deleted = NULL, *mode_change = NULL;
+		const char *deleted = NULL, *added = NULL, *mode_change = NULL;
 
 		if (!eol)
 			eol = pend;
@@ -460,11 +469,12 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		} else if (p == plain->buf)
 			BUG("diff starts with unexpected line:\n"
 			    "%.*s\n", (int)(eol - p), p);
-		else if (file_diff->deleted)
+		else if (file_diff->deleted || file_diff->added)
 			; /* keep the rest of the file in a single "hunk" */
 		else if (starts_with(p, "@@ ") ||
 			 (hunk == &file_diff->head &&
-			  skip_prefix(p, "deleted file", &deleted))) {
+			  (skip_prefix(p, "deleted file", &deleted) ||
+			   skip_prefix(p, "new file", &added)))) {
 			if (marker == '-' || marker == '+')
 				/*
 				 * Should not happen; previous hunk did not end
@@ -484,6 +494,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 
 			if (deleted)
 				file_diff->deleted = 1;
+			else if (added)
+				file_diff->added = 1;
 			else if (parse_hunk_header(s, hunk) < 0)
 				return -1;
 
@@ -536,8 +548,10 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			   starts_with(p, "Binary files "))
 			file_diff->binary = 1;
 
-		if (file_diff->deleted && file_diff->mode_change)
-			BUG("diff contains delete *and* a mode change?!?\n%.*s",
+		if (!!file_diff->deleted + !!file_diff->added +
+		    !!file_diff->mode_change > 1)
+			BUG("diff can only contain delete *or* add *or* a "
+			    "mode change?!?\n%.*s",
 			    (int)(eol - (plain->buf + file_diff->head.start)),
 			    plain->buf + file_diff->head.start);
 
@@ -1397,6 +1411,8 @@ static int patch_update_file(struct add_p_state *s,
 
 		if (file_diff->deleted)
 			prompt_mode_type = PROMPT_DELETION;
+		else if (file_diff->added)
+			prompt_mode_type = PROMPT_ADDITION;
 		else if (file_diff->mode_change && !hunk_index)
 			prompt_mode_type = PROMPT_MODE_CHANGE;
 		else
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 10fd30ae16a..f36c0078ac9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -754,16 +754,18 @@ sub parse_diff_header {
 	my $head = { TEXT => [], DISPLAY => [], TYPE => 'header' };
 	my $mode = { TEXT => [], DISPLAY => [], TYPE => 'mode' };
 	my $deletion = { TEXT => [], DISPLAY => [], TYPE => 'deletion' };
+	my $addition = { TEXT => [], DISPLAY => [], TYPE => 'addition' };
 
 	for (my $i = 0; $i < @{$src->{TEXT}}; $i++) {
 		my $dest =
 		   $src->{TEXT}->[$i] =~ /^(old|new) mode (\d+)$/ ? $mode :
 		   $src->{TEXT}->[$i] =~ /^deleted file/ ? $deletion :
+		   $src->{TEXT}->[$i] =~ /^new file/ ? $addition :
 		   $head;
 		push @{$dest->{TEXT}}, $src->{TEXT}->[$i];
 		push @{$dest->{DISPLAY}}, $src->{DISPLAY}->[$i];
 	}
-	return ($head, $mode, $deletion);
+	return ($head, $mode, $deletion, $addition);
 }
 
 sub hunk_splittable {
@@ -1427,46 +1429,55 @@ sub display_hunks {
 	stage => {
 		mode => N__("Stage mode change [y,n,q,a,d%s,?]? "),
 		deletion => N__("Stage deletion [y,n,q,a,d%s,?]? "),
+		addition => N__("Stage addition [y,n,q,a,d%s,?]? "),
 		hunk => N__("Stage this hunk [y,n,q,a,d%s,?]? "),
 	},
 	stash => {
 		mode => N__("Stash mode change [y,n,q,a,d%s,?]? "),
 		deletion => N__("Stash deletion [y,n,q,a,d%s,?]? "),
+		addition => N__("Stash addition [y,n,q,a,d%s,?]? "),
 		hunk => N__("Stash this hunk [y,n,q,a,d%s,?]? "),
 	},
 	reset_head => {
 		mode => N__("Unstage mode change [y,n,q,a,d%s,?]? "),
 		deletion => N__("Unstage deletion [y,n,q,a,d%s,?]? "),
+		addition => N__("Unstage addition [y,n,q,a,d%s,?]? "),
 		hunk => N__("Unstage this hunk [y,n,q,a,d%s,?]? "),
 	},
 	reset_nothead => {
 		mode => N__("Apply mode change to index [y,n,q,a,d%s,?]? "),
 		deletion => N__("Apply deletion to index [y,n,q,a,d%s,?]? "),
+		addition => N__("Apply addition to index [y,n,q,a,d%s,?]? "),
 		hunk => N__("Apply this hunk to index [y,n,q,a,d%s,?]? "),
 	},
 	checkout_index => {
 		mode => N__("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
 		deletion => N__("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
+		addition => N__("Discard addition from worktree [y,n,q,a,d%s,?]? "),
 		hunk => N__("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
 	},
 	checkout_head => {
 		mode => N__("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
 		deletion => N__("Discard deletion from index and worktree [y,n,q,a,d%s,?]? "),
+		addition => N__("Discard addition from index and worktree [y,n,q,a,d%s,?]? "),
 		hunk => N__("Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "),
 	},
 	checkout_nothead => {
 		mode => N__("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
 		deletion => N__("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
+		addition => N__("Apply addition to index and worktree [y,n,q,a,d%s,?]? "),
 		hunk => N__("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
 	},
 	worktree_head => {
 		mode => N__("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
 		deletion => N__("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
+		addition => N__("Discard addition from worktree [y,n,q,a,d%s,?]? "),
 		hunk => N__("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
 	},
 	worktree_nothead => {
 		mode => N__("Apply mode change to worktree [y,n,q,a,d%s,?]? "),
 		deletion => N__("Apply deletion to worktree [y,n,q,a,d%s,?]? "),
+		addition => N__("Apply addition to worktree [y,n,q,a,d%s,?]? "),
 		hunk => N__("Apply this hunk to worktree [y,n,q,a,d%s,?]? "),
 	},
 );
@@ -1476,7 +1487,7 @@ sub patch_update_file {
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
-	($head, my $mode, my $deletion) = parse_diff_header($head);
+	($head, my $mode, my $deletion, my $addition) = parse_diff_header($head);
 	for (@{$head->{DISPLAY}}) {
 		print;
 	}
@@ -1490,6 +1501,12 @@ sub patch_update_file {
 			push @{$deletion->{DISPLAY}}, @{$hunk->{DISPLAY}};
 		}
 		@hunk = ($deletion);
+	} elsif (@{$addition->{TEXT}}) {
+		foreach my $hunk (@hunk) {
+			push @{$addition->{TEXT}}, @{$hunk->{TEXT}};
+			push @{$addition->{DISPLAY}}, @{$hunk->{DISPLAY}};
+		}
+		@hunk = ($addition);
 	}
 
 	$num = scalar @hunk;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index ac43f835a5b..7bc0c3fe6ef 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -403,6 +403,25 @@ test_expect_success 'deleting an empty file' '
 	diff_cmp expected diff
 '
 
+test_expect_success 'adding an empty file' '
+	git init added &&
+	(
+		cd added &&
+		test_commit initial &&
+		>empty &&
+		git add empty &&
+		test_tick &&
+		git commit -m empty &&
+		git tag added-file &&
+		git reset --hard HEAD^ &&
+		test_path_is_missing empty &&
+
+		echo y | git checkout -p added-file -- >actual &&
+		test_path_is_file empty &&
+		test_i18ngrep "Apply addition to index and worktree" actual
+	)
+'
+
 test_expect_success 'split hunk setup' '
 	git reset --hard &&
 	test_write_lines 10 20 30 40 50 60 >test &&

base-commit: b2627cc3d4be2f8086711097f99d79a32c6a703a
-- 
gitgitgadget
