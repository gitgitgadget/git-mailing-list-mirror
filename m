Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29075C10DAA
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 16:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A202166E
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 16:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8BEtZEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbgIIQsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbgIIQHi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 12:07:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91176C061358
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 06:58:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o5so3031069wrn.13
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=I06MO0ZbsWOPC3fEzTJLyszx9h+i+hH2YF8cwgruCxM=;
        b=W8BEtZEWr0Ddind1YaU1U1sY3DYgXb9lnVQP5l7uE/q0x+uTHJoIXqJYqq3f6yO6oe
         /FDbmckfBefyEJeCzsYb67RcNBxZujDWlPbfz2CL5cugNDm36fPWSXbyDAPrNX572m7D
         C5pRGnjhimP/HBO46r8YGO6zGx8Mu0yrTtCvZd3LOrIn2uY87kQrjKz8RBBix5Y/G83n
         j9/fljZc3JL066bcng01wxqJe60pbYB1ELgAv8jxHIyy4N8XjA+K0Hv1iF74BkECJyqP
         MN373IUizFrlOGyAZRGZLQExw+to4sPzn01S4bRfmYO7wY9mZrXDiwGfMrd7I/hXQxJs
         8yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I06MO0ZbsWOPC3fEzTJLyszx9h+i+hH2YF8cwgruCxM=;
        b=m8cXdvUy5sPCMlMwlcPbrPuHje+tlatOKALO6JcRmhfpOwnGSlgtOmawBm8PIY8g9s
         rkqhgfB3sA8eBycZIbNw2nEcnWb1owDO2gzo/sFVDu9zWkMNs1q+G8hGIhHVNw9IcgGx
         /kXW8Xxb+hj/0mQEG8LccGI9aD8oRRCGsFMpz7Os9OFmzizhbcWf55hyZR4CIhwPSq/i
         Q/DgNMFg5sf9dEKxR9C93BangkJgxE0rSigKxt7U9zUCR5t+eghlFZrrmgGOmK3Ugj1D
         KMmX8+2y2nJlqbKJpOro86Qd1kfhy/Np3zZVVLWsie81xuLQujjrsw615S6oQ3zdORqb
         WyEA==
X-Gm-Message-State: AOAM531zZjnmJRy5/XaSLZSwLNVRSBCkFk79ZWEHFmM8cp/Pd0sS+hkg
        dtYN08CqErITGPwFR8L1j0lK86WBs/Q=
X-Google-Smtp-Source: ABdhPJwZHRD3R2CznN+/kJWuCpflTQA5aQ3DhXcOpgt6h26BkTC1FP7qn9gE42rQFfzssO6riMtEgA==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr3971912wrw.325.1599659933641;
        Wed, 09 Sep 2020 06:58:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm4221650wru.88.2020.09.09.06.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 06:58:53 -0700 (PDT)
Message-Id: <pull.731.git.1599659932391.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Sep 2020 13:58:52 +0000
Subject: [PATCH] add -p: fix editing of intent-to-add paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Sullivan <tom@msbit.com.au>,
        "Raymond E. Pasco" <ray@ameretat.dev>,
        Yuchen Ying <ych@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

A popular way of partially staging a new file is to run `git add -N
<path>` and then use the hunk editing of `git add -p` to select the
part of the file that the user wishes to stage. Since
85953a3187 ("diff-files --raw: show correct post-image of
intent-to-add files", 2020-07-01) this has stopped working as
intent-to-add paths are now show as new files rather than changes to
an empty blob and `git apply` refused to apply a creation patch for a
path that was marked as intent-to-add. 7cfde3fa0f ("apply: allow "new
file" patches on i-t-a entries", 2020-08-06) fixed the problem with
apply but it still wasn't possible to edit the added hunk properly.

2c8bd8471a ("checkout -p: handle new files correctly", 2020-05-27)
had previously changed `add -p` to handle new files but it did not
implement patch editing correctly. The perl version simply forbade
editing and the C version opened the editor with the full diff rather
that just the hunk which meant that the user had to edit the hunk
header manually to get it to work.

The root cause of the problem is that added files store the diff header
with the hunk data rather than separating the two as we do for other
changes. Changing added files to store the diff header separately
fixes the editing problem at the expense of having to special case
empty additions as they no longer have any hunks associated with them,
only the diff header.

The changes move some existing code into a conditional changing the
indentation, they are best viewed with
--color-moved-ws=allow-indentation-change (or --ignore-space-change
works well to get an overview of the changes)

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reported-by: Thomas Sullivan <tom@msbit.com.au>
Reported-by: Yuchen Ying <ych@google.com>
---
    add -p: fix editing of intent-to-add paths
    
    While working on this I realized that we should probably disallow 'a'
    and 'd' when there is no next undecided hunk as they just act like 'y'
    and 'n' in that case and give the misleading impression that there are
    more hunks to come. Doing so would make these changes slightly simpler
    but as we've had two bug reports about this regression already I decided
    to focus on just fixing this for now.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-731%2Fphillipwood%2Fwip%2Fadd-p-fix-editing-added-files-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-731/phillipwood/wip/add-p-fix-editing-added-files-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/731

 add-patch.c                | 140 +++++++++++++++++++++----------------
 git-add--interactive.perl  |  89 ++++++++++++++---------
 t/t3701-add-interactive.sh |  38 ++++++++++
 3 files changed, 173 insertions(+), 94 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 457b8c550e..867720a7c6 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -451,7 +451,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	pend = p + plain->len;
 	while (p != pend) {
 		char *eol = memchr(p, '\n', pend - p);
-		const char *deleted = NULL, *added = NULL, *mode_change = NULL;
+		const char *deleted = NULL, *mode_change = NULL;
 
 		if (!eol)
 			eol = pend;
@@ -468,12 +468,11 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		} else if (p == plain->buf)
 			BUG("diff starts with unexpected line:\n"
 			    "%.*s\n", (int)(eol - p), p);
-		else if (file_diff->deleted || file_diff->added)
+		else if (file_diff->deleted)
 			; /* keep the rest of the file in a single "hunk" */
 		else if (starts_with(p, "@@ ") ||
 			 (hunk == &file_diff->head &&
-			  (skip_prefix(p, "deleted file", &deleted) ||
-			   skip_prefix(p, "new file", &added)))) {
+			  (skip_prefix(p, "deleted file", &deleted)))) {
 			if (marker == '-' || marker == '+')
 				/*
 				 * Should not happen; previous hunk did not end
@@ -491,8 +490,6 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 
 			if (deleted)
 				file_diff->deleted = 1;
-			else if (added)
-				file_diff->added = 1;
 			else if (parse_hunk_header(s, hunk) < 0)
 				return -1;
 
@@ -501,6 +498,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			 * split
 			 */
 			marker = *p;
+		} else if (hunk == &file_diff->head &&
+			   starts_with(p, "new file")) {
+			file_diff->added = 1;
 		} else if (hunk == &file_diff->head &&
 			   skip_prefix(p, "old mode ", &mode_change) &&
 			   is_octal(mode_change, eol - mode_change)) {
@@ -1362,7 +1362,8 @@ static int patch_update_file(struct add_p_state *s,
 		ALLOW_EDIT = 1 << 6
 	} permitted = 0;
 
-	if (!file_diff->hunk_nr)
+	/* Empty added files have no hunks */
+	if (!file_diff->hunk_nr && !file_diff->added)
 		return 0;
 
 	strbuf_reset(&s->buf);
@@ -1371,21 +1372,25 @@ static int patch_update_file(struct add_p_state *s,
 	for (;;) {
 		if (hunk_index >= file_diff->hunk_nr)
 			hunk_index = 0;
-		hunk = file_diff->hunk + hunk_index;
-
+		hunk = file_diff->hunk_nr
+				? file_diff->hunk + hunk_index
+				: &file_diff->head;
 		undecided_previous = -1;
-		for (i = hunk_index - 1; i >= 0; i--)
-			if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
-				undecided_previous = i;
-				break;
-			}
-
 		undecided_next = -1;
-		for (i = hunk_index + 1; i < file_diff->hunk_nr; i++)
-			if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
-				undecided_next = i;
-				break;
-			}
+
+		if (file_diff->hunk_nr) {
+			for (i = hunk_index - 1; i >= 0; i--)
+				if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
+					undecided_previous = i;
+					break;
+				}
+
+			for (i = hunk_index + 1; i < file_diff->hunk_nr; i++)
+				if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
+					undecided_next = i;
+					break;
+				}
+		}
 
 		/* Everything decided? */
 		if (undecided_previous < 0 && undecided_next < 0 &&
@@ -1393,38 +1398,40 @@ static int patch_update_file(struct add_p_state *s,
 			break;
 
 		strbuf_reset(&s->buf);
-		render_hunk(s, hunk, 0, colored, &s->buf);
-		fputs(s->buf.buf, stdout);
+		if (file_diff->hunk_nr) {
+			render_hunk(s, hunk, 0, colored, &s->buf);
+			fputs(s->buf.buf, stdout);
 
-		strbuf_reset(&s->buf);
-		if (undecided_previous >= 0) {
-			permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
-			strbuf_addstr(&s->buf, ",k");
-		}
-		if (hunk_index) {
-			permitted |= ALLOW_GOTO_PREVIOUS_HUNK;
-			strbuf_addstr(&s->buf, ",K");
-		}
-		if (undecided_next >= 0) {
-			permitted |= ALLOW_GOTO_NEXT_UNDECIDED_HUNK;
-			strbuf_addstr(&s->buf, ",j");
-		}
-		if (hunk_index + 1 < file_diff->hunk_nr) {
-			permitted |= ALLOW_GOTO_NEXT_HUNK;
-			strbuf_addstr(&s->buf, ",J");
-		}
-		if (file_diff->hunk_nr > 1) {
-			permitted |= ALLOW_SEARCH_AND_GOTO;
-			strbuf_addstr(&s->buf, ",g,/");
-		}
-		if (hunk->splittable_into > 1) {
-			permitted |= ALLOW_SPLIT;
-			strbuf_addstr(&s->buf, ",s");
-		}
-		if (hunk_index + 1 > file_diff->mode_change &&
-		    !file_diff->deleted) {
-			permitted |= ALLOW_EDIT;
-			strbuf_addstr(&s->buf, ",e");
+			strbuf_reset(&s->buf);
+			if (undecided_previous >= 0) {
+				permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
+				strbuf_addstr(&s->buf, ",k");
+			}
+			if (hunk_index) {
+				permitted |= ALLOW_GOTO_PREVIOUS_HUNK;
+				strbuf_addstr(&s->buf, ",K");
+			}
+			if (undecided_next >= 0) {
+				permitted |= ALLOW_GOTO_NEXT_UNDECIDED_HUNK;
+				strbuf_addstr(&s->buf, ",j");
+			}
+			if (hunk_index + 1 < file_diff->hunk_nr) {
+				permitted |= ALLOW_GOTO_NEXT_HUNK;
+				strbuf_addstr(&s->buf, ",J");
+			}
+			if (file_diff->hunk_nr > 1) {
+				permitted |= ALLOW_SEARCH_AND_GOTO;
+				strbuf_addstr(&s->buf, ",g,/");
+			}
+			if (hunk->splittable_into > 1) {
+				permitted |= ALLOW_SPLIT;
+				strbuf_addstr(&s->buf, ",s");
+			}
+			if (hunk_index + 1 > file_diff->mode_change &&
+			    !file_diff->deleted) {
+				permitted |= ALLOW_EDIT;
+				strbuf_addstr(&s->buf, ",e");
+			}
 		}
 		if (file_diff->deleted)
 			prompt_mode_type = PROMPT_DELETION;
@@ -1438,7 +1445,9 @@ static int patch_update_file(struct add_p_state *s,
 		color_fprintf(stdout, s->s.prompt_color,
 			      "(%"PRIuMAX"/%"PRIuMAX") ",
 			      (uintmax_t)hunk_index + 1,
-			      (uintmax_t)file_diff->hunk_nr);
+			      (uintmax_t)(file_diff->hunk_nr
+						? file_diff->hunk_nr
+						: 1));
 		color_fprintf(stdout, s->s.prompt_color,
 			      _(s->mode->prompt_mode[prompt_mode_type]),
 			      s->buf.buf);
@@ -1458,16 +1467,24 @@ static int patch_update_file(struct add_p_state *s,
 			hunk->use = SKIP_HUNK;
 			goto soft_increment;
 		} else if (ch == 'a') {
-			for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
-				hunk = file_diff->hunk + hunk_index;
-				if (hunk->use == UNDECIDED_HUNK)
-					hunk->use = USE_HUNK;
+			if (file_diff->hunk_nr) {
+				for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
+					hunk = file_diff->hunk + hunk_index;
+					if (hunk->use == UNDECIDED_HUNK)
+						hunk->use = USE_HUNK;
+				}
+			} else if (hunk->use == UNDECIDED_HUNK) {
+				hunk->use = USE_HUNK;
 			}
 		} else if (ch == 'd' || ch == 'q') {
-			for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
-				hunk = file_diff->hunk + hunk_index;
-				if (hunk->use == UNDECIDED_HUNK)
-					hunk->use = SKIP_HUNK;
+			if (file_diff->hunk_nr) {
+				for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
+					hunk = file_diff->hunk + hunk_index;
+					if (hunk->use == UNDECIDED_HUNK)
+						hunk->use = SKIP_HUNK;
+				}
+			} else if (hunk->use == UNDECIDED_HUNK) {
+				hunk->use = SKIP_HUNK;
 			}
 			if (ch == 'q') {
 				quit = 1;
@@ -1625,7 +1642,8 @@ static int patch_update_file(struct add_p_state *s,
 		if (file_diff->hunk[i].use == USE_HUNK)
 			break;
 
-	if (i < file_diff->hunk_nr) {
+	if (i < file_diff->hunk_nr ||
+	    (!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
 		/* At least one hunk selected: apply */
 		strbuf_reset(&s->buf);
 		reassemble_patch(s, file_diff, 0, &s->buf);
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index f36c0078ac..6771c0a026 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -754,13 +754,16 @@ sub parse_diff_header {
 	my $head = { TEXT => [], DISPLAY => [], TYPE => 'header' };
 	my $mode = { TEXT => [], DISPLAY => [], TYPE => 'mode' };
 	my $deletion = { TEXT => [], DISPLAY => [], TYPE => 'deletion' };
-	my $addition = { TEXT => [], DISPLAY => [], TYPE => 'addition' };
+	my $addition;
 
 	for (my $i = 0; $i < @{$src->{TEXT}}; $i++) {
+		if ($src->{TEXT}->[$i] =~ /^new file/) {
+			$addition = 1;
+			$head->{TYPE} = 'addition';
+		}
 		my $dest =
 		   $src->{TEXT}->[$i] =~ /^(old|new) mode (\d+)$/ ? $mode :
 		   $src->{TEXT}->[$i] =~ /^deleted file/ ? $deletion :
-		   $src->{TEXT}->[$i] =~ /^new file/ ? $addition :
 		   $head;
 		push @{$dest->{TEXT}}, $src->{TEXT}->[$i];
 		push @{$dest->{DISPLAY}}, $src->{DISPLAY}->[$i];
@@ -1501,12 +1504,6 @@ sub patch_update_file {
 			push @{$deletion->{DISPLAY}}, @{$hunk->{DISPLAY}};
 		}
 		@hunk = ($deletion);
-	} elsif (@{$addition->{TEXT}}) {
-		foreach my $hunk (@hunk) {
-			push @{$addition->{TEXT}}, @{$hunk->{TEXT}};
-			push @{$addition->{DISPLAY}}, @{$hunk->{DISPLAY}};
-		}
-		@hunk = ($addition);
 	}
 
 	$num = scalar @hunk;
@@ -1516,6 +1513,7 @@ sub patch_update_file {
 		my ($prev, $next, $other, $undecided, $i);
 		$other = '';
 
+		last if ($ix and !$num);
 		if ($num <= $ix) {
 			$ix = 0;
 		}
@@ -1548,35 +1546,51 @@ sub patch_update_file {
 				last;
 			}
 		}
-		last if (!$undecided);
+		last if (!$undecided && ($num || !$addition));
 
-		if ($hunk[$ix]{TYPE} eq 'hunk' &&
-		    hunk_splittable($hunk[$ix]{TEXT})) {
-			$other .= ',s';
-		}
-		if ($hunk[$ix]{TYPE} eq 'hunk') {
-			$other .= ',e';
-		}
-		for (@{$hunk[$ix]{DISPLAY}}) {
-			print;
+		if ($num) {
+			if ($hunk[$ix]{TYPE} eq 'hunk' &&
+			    hunk_splittable($hunk[$ix]{TEXT})) {
+				$other .= ',s';
+			}
+			if ($hunk[$ix]{TYPE} eq 'hunk') {
+				$other .= ',e';
+			}
+			for (@{$hunk[$ix]{DISPLAY}}) {
+				print;
+			}
 		}
-		print colored $prompt_color, "(", ($ix+1), "/$num) ",
-			sprintf(__($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}), $other);
+		my $type = $num ? $hunk[$ix]{TYPE} : $head->{TYPE};
+		print colored $prompt_color, "(", ($ix+1), "/", ($num ? $num : 1), ") ",
+			sprintf(__($patch_update_prompt_modes{$patch_mode}{$type}), $other);
 
 		my $line = prompt_single_character;
 		last unless defined $line;
 		if ($line) {
 			if ($line =~ /^y/i) {
-				$hunk[$ix]{USE} = 1;
+				if ($num) {
+					$hunk[$ix]{USE} = 1;
+				} else {
+					$head->{USE} = 1;
+				}
 			}
 			elsif ($line =~ /^n/i) {
-				$hunk[$ix]{USE} = 0;
+				if ($num) {
+					$hunk[$ix]{USE} = 0;
+				} else {
+					$head->{USE} = 0;
+				}
 			}
 			elsif ($line =~ /^a/i) {
-				while ($ix < $num) {
-					if (!defined $hunk[$ix]{USE}) {
-						$hunk[$ix]{USE} = 1;
+				if ($num) {
+					while ($ix < $num) {
+						if (!defined $hunk[$ix]{USE}) {
+							$hunk[$ix]{USE} = 1;
+						}
+						$ix++;
 					}
+				} else {
+					$head->{USE} = 1;
 					$ix++;
 				}
 				next;
@@ -1613,19 +1627,28 @@ sub patch_update_file {
 				next;
 			}
 			elsif ($line =~ /^d/i) {
-				while ($ix < $num) {
-					if (!defined $hunk[$ix]{USE}) {
-						$hunk[$ix]{USE} = 0;
+				if ($num) {
+					while ($ix < $num) {
+						if (!defined $hunk[$ix]{USE}) {
+							$hunk[$ix]{USE} = 0;
+						}
+						$ix++;
 					}
+				} else {
+					$head->{USE} = 0;
 					$ix++;
 				}
 				next;
 			}
 			elsif ($line =~ /^q/i) {
-				for ($i = 0; $i < $num; $i++) {
-					if (!defined $hunk[$i]{USE}) {
-						$hunk[$i]{USE} = 0;
+				if ($num) {
+					for ($i = 0; $i < $num; $i++) {
+						if (!defined $hunk[$i]{USE}) {
+							$hunk[$i]{USE} = 0;
+						}
 					}
+				} elsif (!defined $head->{USE}) {
+					$head->{USE} = 0;
 				}
 				$quit = 1;
 				last;
@@ -1743,7 +1766,7 @@ sub patch_update_file {
 		}
 	}
 
-	@hunk = coalesce_overlapping_hunks(@hunk);
+	@hunk = coalesce_overlapping_hunks(@hunk) if ($num);
 
 	my $n_lofs = 0;
 	my @result = ();
@@ -1753,7 +1776,7 @@ sub patch_update_file {
 		}
 	}
 
-	if (@result) {
+	if (@result or $head->{USE}) {
 		my @patch = reassemble_patch($head->{TEXT}, @result);
 		my $apply_routine = $patch_mode_flavour{APPLY};
 		&$apply_routine(@patch);
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index fb73a847cb..ebe84a6353 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -814,6 +814,44 @@ test_expect_success 'checkout -p works with pathological context lines' '
 	test_cmp expect a
 '
 
+# This should be called from a subshell as it sets a temporary editor
+setup_new_file() {
+	write_script new-file-editor.sh <<-\EOF &&
+	sed /^#/d "$1" >patch &&
+	sed /^+c/d patch >"$1"
+	EOF
+	test_set_editor "$(pwd)/new-file-editor.sh" &&
+	test_write_lines a b c d e f >new-file &&
+	test_write_lines a b d e f >new-file-expect &&
+	test_write_lines "@@ -0,0 +1,6 @@" +a +b +c +d +e +f >patch-expect
+}
+
+test_expect_success 'add -N followed by add -p patch editing' '
+	git reset --hard &&
+	(
+		setup_new_file &&
+		git add -N new-file &&
+		test_write_lines e n q | git add -p &&
+		git cat-file blob :new-file >actual &&
+		test_cmp new-file-expect actual &&
+		test_cmp patch-expect patch
+	)
+'
+
+test_expect_success 'checkout -p patch editing of added file' '
+	git reset --hard &&
+	(
+		setup_new_file &&
+		git add new-file &&
+		git commit -m "add new file" &&
+		git rm new-file &&
+		git commit -m "remove new file" &&
+		test_write_lines e n q | git checkout -p HEAD^ &&
+		test_cmp new-file-expect new-file &&
+		test_cmp patch-expect patch
+	)
+'
+
 test_expect_success 'show help from add--helper' '
 	git reset --hard &&
 	cat >expect <<-EOF &&

base-commit: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a
-- 
gitgitgadget
