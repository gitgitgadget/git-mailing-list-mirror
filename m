Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9984C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1602611F0
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhIKRFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhIKRFE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 13:05:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60B3C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 10:03:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g74so3427383wmg.5
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=aLAeR6a03ZYM7vQ2kPemYQAdLqZPKprGAHLyLQ3/LKI=;
        b=Ra53uEKef26IRUnz9fl/cVDo/Y3l6+uPZt+bbV+QV8sjc2kVYKDs3ruBO8RgZFurol
         DDQ+BkUBwjNwWvlNPNFcZjQhSfjvcZud8IIEOjgmI5ZbCNw2yOHY5AbFQ6K4MfMQubKo
         JDeOGv0PEHzaTot5a99gbcMKOtCwsenvLhoq4WMQj5FDsJk4yKgxgHjABVm1ZvNc4qb8
         KiLjRfm0PIcQyKur1AjXDu2g89Gn/VFhDc+OtFmdXV6LcCh2xaSo+PjkC9Tf1bz9NnYy
         zoeOQL17jLpK5YSv/Zzi47jbP0WlAZDkeD/NcZ2iLL4D8ZDbLzoVmB7zUzW1yf7lJI8I
         guSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=aLAeR6a03ZYM7vQ2kPemYQAdLqZPKprGAHLyLQ3/LKI=;
        b=VFDniawWLM1TVgoE6wjqCEE5NT4EqjuTJHI88eUwwc/vQ6TAbQExlJL31MQjGOYQmD
         vWdthk/d/5/aF9HQ6zFcxvHVDwWJs+W2AvmaMWUo5deHd9v2BeHHv96MiOfwF8yjGsQO
         XCO67EEGqO9kqkUzrLP+TfMZuQ1/FPnqtFVHlsNRSg3uveMmARnU9+ec17Ps74kgp/Cp
         oGyDR4HWBwMHiJQkJe/gv++kxaomw9NrYOrdzfGlD3m17jlWbRrbaaOlFMmzOkhGhL0x
         /wHt/hY/vOZqJBP6UC2MQINNHenmpLvRcndyQ66sbGxPs6VZz5gSBNDQdMYSh0749bTv
         fs0g==
X-Gm-Message-State: AOAM531NInZd93g8eGJqXR+W0mSwSKcA/XXXTUiDvkqWsxcn45CdeXeT
        B2LWzyJuVRh7eEPWGYIU1swfe1jNZ/g=
X-Google-Smtp-Source: ABdhPJy3x28s0BoiDX7VkaBcXFNEjsRWXBjk2usVjBm8mnDxsxHN/Gv5Rz3HLpdPNtZT1b8pzXxwOg==
X-Received: by 2002:a05:600c:ac9:: with SMTP id c9mr3351562wmr.14.1631379830325;
        Sat, 11 Sep 2021 10:03:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm2526095wrt.63.2021.09.11.10.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 10:03:49 -0700 (PDT)
Message-Id: <pull.1036.v2.git.git.1631379829.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Sep 2021 17:03:47 +0000
Subject: [PATCH v2 0/2] RFC: implement new zdiff3 conflict style
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement a zealous diff3, or "zdiff3". This new mode is identical to
ordinary diff3 except that it allows compaction of common lines between the
two sides of history, if those common lines occur at the beginning or end of
a conflict hunk.

This is still just RFC, because one of the testcases I added fails and
really should be fixed before this series is ready to merge. Also, while
testing I noted one suboptimal merge that I thought I'd be able to easily
reproduce later, but which I wasn't able to reproduce again and for which
I've lost the details. I'd like to keep testing and find it again. Sorry for
the long delay here; been concentrating mostly on merge-ort and sparse-index
and untracked/cwd cleanup things instead.

NOTE: You may want to just eject this topic from seen. It needs more fixes
and while I do plan to eventually get back to it, I'm concentrating more on
other topics.

Changes since v1:

 * Included fixes from Phillip (thanks!)
 * Added some testcases

Elijah Newren (2):
  xdiff: implement a zealous diff3, or "zdiff3"
  update documentation for new zdiff3 conflictStyle

 Documentation/config/merge.txt         |  9 +++-
 Documentation/git-checkout.txt         |  3 +-
 Documentation/git-merge-file.txt       |  3 ++
 Documentation/git-merge.txt            | 32 ++++++++++--
 Documentation/git-rebase.txt           |  6 +--
 Documentation/git-restore.txt          |  3 +-
 Documentation/git-switch.txt           |  3 +-
 Documentation/technical/rerere.txt     | 10 ++--
 builtin/checkout.c                     |  2 +-
 builtin/merge-file.c                   |  2 +
 contrib/completion/git-completion.bash |  6 +--
 t/t6427-diff3-conflict-markers.sh      | 56 +++++++++++++++++++++
 xdiff-interface.c                      |  2 +
 xdiff/xdiff.h                          |  1 +
 xdiff/xmerge.c                         | 68 +++++++++++++++++++++++---
 15 files changed, 176 insertions(+), 30 deletions(-)


base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1036%2Fnewren%2Fzdiff3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1036/newren/zdiff3-v2
Pull-Request: https://github.com/git/git/pull/1036

Range-diff vs v1:

 1:  b7561a67c19 ! 1:  06e04c88dea xdiff: implement a zealous diff3, or "zdiff3"
     @@ Commit message
          because zdiff3 shows the base version too and the base version cannot be
          reasonably split.
      
     -    Initial-patch-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     +    Based-on-patch-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/merge-file.c ##
     @@ contrib/completion/git-completion.bash: _git_checkout ()
       		;;
       	--*)
       		__gitcomp_builtin checkout
     +@@ contrib/completion/git-completion.bash: _git_switch ()
     + 
     + 	case "$cur" in
     + 	--conflict=*)
     +-		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
     ++		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
     + 		;;
     + 	--*)
     + 		__gitcomp_builtin switch
     +@@ contrib/completion/git-completion.bash: _git_restore ()
     + 
     + 	case "$cur" in
     + 	--conflict=*)
     +-		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
     ++		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
     + 		;;
     + 	--source=*)
     + 		__git_complete_refs --cur="${cur##--source=}"
     +
     + ## t/t6427-diff3-conflict-markers.sh ##
     +@@ t/t6427-diff3-conflict-markers.sh: test_expect_success 'rebase --apply describes fake ancestor base' '
     + 	)
     + '
     + 
     ++test_setup_zdiff3 () {
     ++	test_create_repo zdiff3 &&
     ++	(
     ++		cd zdiff3 &&
     ++
     ++		test_write_lines 1 2 3 4 5 6 7 8 9 >basic &&
     ++		test_write_lines 1 2 3 AA 4 5 BB 6 7 8 >middle-common &&
     ++		test_write_lines 1 2 3 4 5 6 7 8 9 >interesting &&
     ++
     ++		git add basic middle-common &&
     ++		git commit -m base &&
     ++
     ++		git branch left &&
     ++		git branch right &&
     ++
     ++		git checkout left &&
     ++		test_write_lines 1 2 3 4 A B C D E 7 8 9 >basic &&
     ++		test_write_lines 1 2 3 CC 4 5 DD 6 7 8 >middle-common &&
     ++		test_write_lines 1 2 3 4 A B C D E F G H I J 7 8 9 >interesting &&
     ++		git add -u &&
     ++		git commit -m letters &&
     ++
     ++		git checkout right &&
     ++		test_write_lines 1 2 3 4 A X C Y E 7 8 9 >basic &&
     ++		test_write_lines 1 2 3 EE 4 5 FF 6 7 8 >middle-common &&
     ++		test_write_lines 1 2 3 4 A B C 5 6 G H I J 7 8 9 >interesting &&
     ++		git add -u &&
     ++		git commit -m permuted
     ++	)
     ++}
     ++
     ++test_expect_failure 'check zdiff3 markers' '
     ++	test_setup_zdiff3 &&
     ++	(
     ++		cd zdiff3 &&
     ++
     ++		git checkout left^0 &&
     ++
     ++		test_must_fail git -c merge.conflictstyle=zdiff3 merge -s recursive right^0 &&
     ++
     ++		test_write_lines 1 2 3 4 A "<<<<<<< HEAD" B C D "||||||| $(git rev-parse --short HEAD^1)" 5 6 ======= X C Y ">>>>>>> right^0" E 7 8 9 >expect &&
     ++		test_cmp expect basic &&
     ++
     ++		test_write_lines 1 2 3 "<<<<<<< HEAD" CC "||||||| $(git rev-parse --short HEAD^1)" AA ======= EE ">>>>>>> right^0" 4 5 "<<<<<<< HEAD" DD "||||||| $(git rev-parse --short HEAD^1)" BB ======= FF ">>>>>>> right^0" 6 7 8 >expect &&
     ++		test_cmp expect middle-common &&
     ++
     ++		# Not passing this one yet.  For some reason, after extracting
     ++		# the common lines "A B C" and "G H I J", the remaining part
     ++		# is comparing "5 6" in the base to "5 6" on the left and
     ++		# "D E F" on the right.  And zdiff3 currently picks the side
     ++		# that matches the base as the merge result.  Weird.
     ++		test_write_lines 1 2 3 4 A B C D E F G H I J 7 8 9 >expect &&
     ++		test_cmp expect interesting
     ++	)
     ++'
     ++
     + test_done
      
       ## xdiff-interface.c ##
      @@ xdiff-interface.c: int git_xmerge_config(const char *var, const char *value, void *cb)
     @@ xdiff/xmerge.c: static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xd
       		m->i1 = xscr->i1 + i1;
       		m->chg1 = xscr->chg1;
       		m->i2 = xscr->i2 + i2;
     +@@ xdiff/xmerge.c: static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
     + static void xdl_merge_two_conflicts(xdmerge_t *m)
     + {
     + 	xdmerge_t *next_m = m->next;
     ++	m->chg0 = next_m->i0 + next_m->chg0 - m->i0;
     + 	m->chg1 = next_m->i1 + next_m->chg1 - m->i1;
     + 	m->chg2 = next_m->i2 + next_m->chg2 - m->i2;
     + 	m->next = next_m->next;
     +@@ xdiff/xmerge.c: static void xdl_merge_two_conflicts(xdmerge_t *m)
     +  * it appears simpler -- because it takes up less (or as many) lines --
     +  * if the lines are moved into the conflicts.
     +  */
     +-static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m,
     ++static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m, int style,
     + 				      int simplify_if_no_alnum)
     + {
     + 	int result = 0;
     + 
     +-	if (!m)
     ++	if (!m || style == XDL_MERGE_ZEALOUS_DIFF3)
     + 		return result;
     + 	for (;;) {
     + 		xdmerge_t *next_m = m->next;
      @@ xdiff/xmerge.c: static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
       	int style = xmp->style;
       	int favor = xmp->favor;
     @@ xdiff/xmerge.c: static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
      +	/*
      +	 * XDL_MERGE_DIFF3 does not attempt to refine conflicts by looking
      +	 * at common areas of sides 1 & 2, because the base (side 0) does
     -+	 * not match and is being shown.
     ++	 * not match and is being shown.  Similarly, simplification of
     ++	 * non-conflicts is also skipped due to the skipping of conflict
     ++	 * refinement.
     ++	 *
     ++	 * XDL_MERGE_ZEALOUS_DIFF3, on the other hand, will attempt to
     ++	 * refine conflicts looking for common areas of sides 1 & 2.
     ++	 * However, since the base is being shown and does not match,
     ++	 * it will only look for common areas at the beginning or end
     ++	 * of the conflict block.  Since XDL_MERGE_ZEALOUS_DIFF3's
     ++	 * conflict refinement is much more limited in this fashion, the
     ++	 * conflict simplification will be skipped.
      +	 *
     -+	 * XDL_MERGE_ZEALOUS_DIFF3 will attempt to refine conflicts
     -+	 * looking for common areas of sides 1 & 2, despite the base
     -+	 * not matching and being shown, but will only look for common
     -+	 * areas at the beginning or ending of the conflict block.
     ++	 * See xdl_refine_conflicts() and xdl_simplify_non_conflicts()
     ++	 * for more details, particularly looking for
     ++	 * XDL_MERGE_ZEALOUS_DIFF3.
      +	 */
       	if (style == XDL_MERGE_DIFF3) {
       		/*
     @@ xdiff/xmerge.c: static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
       	/* refine conflicts */
       	if (XDL_MERGE_ZEALOUS <= level &&
      -	    (xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
     +-	     xdl_simplify_non_conflicts(xe1, changes,
      +	    (xdl_refine_conflicts(xe1, xe2, changes, xpp, style) < 0 ||
     - 	     xdl_simplify_non_conflicts(xe1, changes,
     ++	     xdl_simplify_non_conflicts(xe1, changes, style,
       					XDL_MERGE_ZEALOUS < level) < 0)) {
       		xdl_cleanup_merge(changes);
     + 		return -1;
 2:  50e82a7a32c ! 2:  9ce7246c0e9 update documentation for new zdiff3 conflictStyle
     @@ Documentation/config/merge.txt: merge.conflictStyle::
      +	when a subset of lines match on the two sides they are just pulled
      +	out of the conflict region.  Another alternate style, "zdiff3", is
      +	similar to diff3 but removes matching lines on the two sides from
     -+	the conflict region when those matching lines appear near the
     -+	beginning or ending of a conflict region.
     ++	the conflict region when those matching lines appear near either
     ++	the beginning or end of a conflict region.
       
       merge.defaultToUpstream::
       	If merge is called without any commit argument, merge the upstream
     @@ builtin/checkout.c: static struct option *add_common_options(struct checkout_opt
       		OPT_END()
       	};
       	struct option *newopts = parse_options_concat(prevopts, options);
     -
     - ## contrib/completion/git-completion.bash ##
     -@@ contrib/completion/git-completion.bash: _git_switch ()
     - 
     - 	case "$cur" in
     - 	--conflict=*)
     --		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
     -+		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
     - 		;;
     - 	--*)
     - 		__gitcomp_builtin switch
     -@@ contrib/completion/git-completion.bash: _git_restore ()
     - 
     - 	case "$cur" in
     - 	--conflict=*)
     --		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
     -+		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
     - 		;;
     - 	--source=*)
     - 		__git_complete_refs --cur="${cur##--source=}"

-- 
gitgitgadget
