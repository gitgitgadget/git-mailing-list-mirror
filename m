Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6BDC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F7F1206A4
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtRyvkaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgFKPPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgFKPPO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 11:15:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB6DC08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 08:15:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so6584145wru.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=STLiZmhSz9PLQdo4or7zJoxpByf1Mzc+eV/f3LXUvGk=;
        b=mtRyvkaDzO8lp4VfWMlpE0s6BGNm0ApTcMiX3gpyA2VORBy1QulY8k82oCDjYH+fRB
         j6F3QS4F01/8FUu+CT2xKkL04C5d1LaE8QRnVL6DGtVPm8sjfHw5muW8jys/cPS05sX3
         NnQ3p7VtvjVJ8A5J20JFIc0k0+d3vG/ZdkKwho4H75USyVGObyVJKcKi13d6t01Usvqe
         IQ0JA5fwtvOPUB10ZgD42ZXa0unjTuzPOBPhZw0j+evLJV84GHcd/C5XSURAyZRJfRBH
         6kF7AgKIjfNyipuLEFGKrYeMjQiTlxdFYLaBh6Jru6tV0zPsFl7uDeYMZ6NWfam0V2ZP
         qF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=STLiZmhSz9PLQdo4or7zJoxpByf1Mzc+eV/f3LXUvGk=;
        b=dH8KczzOJRTocjO1sAk7tN49WIIHUJ8Nw/nfCoqyrAJFW1LcbQOHLt4piuwkXgKTFd
         EZIi8bXEHOq+BHxcZyPSe5jbNX9ODDvcZ6xECEYMXCjA/ZrbjdP3BXzAX381lczvEtLf
         Jnfc/T8jM7YDmU9UI12IEad73FsFnC+oeinOnPKIA+v14SkqCRA5mJTuUG7tgrDvgRGd
         U+MsZQqv1IIRr5M1HWbauA2A0tDJD/cNx+YB/NTykQzIYHjLas1ZwYb0JMYR8pXwzKJ5
         pdnKK3V+oQRWFnn4nImEWfMrMVUhxo8csCvo+TXscF7YatVMy9bBAzv2vygnma6ySzAN
         eHbA==
X-Gm-Message-State: AOAM531iwIkhba7wVBHze0Kz9TAdXBDg7BjBQqE5igHuqAsYijWLTGaR
        wRrTyHJx3CHP0Xhzru44iEL5FuWz
X-Google-Smtp-Source: ABdhPJyaKGaBTAa+38HBzCHKsodJ5Xx/09TLbKjAncalQou7kin58VSY+E82k8I2SB4UGsSwehVe0Q==
X-Received: by 2002:a5d:6391:: with SMTP id p17mr10667092wru.118.1591888512862;
        Thu, 11 Jun 2020 08:15:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10sm5334852wrj.37.2020.06.11.08.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 08:15:12 -0700 (PDT)
Message-Id: <pull.804.v3.git.git.1591888511.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
References: <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Jun 2020 15:15:07 +0000
Subject: [PATCH v3 0/3] improve git-diff documentation and A...B handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git diff -h help is succinct, but perhaps too much so.

The symmetric-diff syntax, git diff A...B, is defined by the documentation
to compare the merge base of A and B to commit B. It does so just fine when
there is a merge base. It compares A and B directly if there is no merge
base, and it is overly forgiving of bad arguments after which it can produce
nonsensical diffs. It also behaves badly with other odd/incorrect usages,
such as git diff A..B C..D.

The first patch simply adjusts a test that will fail if the second patch is
accepted. The second patch adds special handling for the symmetric diff
syntax so that the option parsing works, plus a small test suite. The third
patch updates the documentation, including adding a section for combined
commits, and makes the help output more verbose (to match the SYNOPSIS and
provide common diff options like git-diff-files, for instance).

Changes since v1:

 * updated commit messages
 * rewrote prepare function
 * added tests to reject bad two-dot usage as well
 * removed A..B syntax from usage (and fixed typo)
 * fixed up three-dot synopsis text

Chris Torek (3):
  t/t3430: avoid undefined git diff behavior
  git diff: improve range handling
  Documentation: usage for diff combined commits

 Documentation/git-diff.txt |  20 ++++--
 builtin/diff.c             | 132 +++++++++++++++++++++++++++++++++----
 t/t3430-rebase-merges.sh   |   2 +-
 t/t4068-diff-symmetric.sh  |  91 +++++++++++++++++++++++++
 4 files changed, 226 insertions(+), 19 deletions(-)
 create mode 100755 t/t4068-diff-symmetric.sh


base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-804%2Fchris3torek%2Fcleanup-diff-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-804/chris3torek/cleanup-diff-v3
Pull-Request: https://github.com/git/git/pull/804

Range-diff vs v2:

 1:  2ccaad645ff = 1:  2ccaad645ff t/t3430: avoid undefined git diff behavior
 2:  100fa403477 ! 2:  60aed3f9d65 git diff: improve A...B merge-base handling
     @@ Metadata
      Author: Chris Torek <chris.torek@gmail.com>
      
       ## Commit message ##
     -    git diff: improve A...B merge-base handling
     +    git diff: improve range handling
      
          When git diff is given a symmetric difference A...B, it chooses
          some merge base from the two specified commits (as documented).
     @@ Commit message
             lost.  We will produce a combined diff instead.
      
          Similar weirdness occurs if you use, e.g., "git diff C A...B D".
     +    Likewise, using multiple two-dot ranges, or tossing extra
     +    revision specifiers into the command line with two-dot ranges,
     +    or mixing two and three dot ranges, all produce nonsense.
      
     -    To avoid all this, add a routine to catch the A...B case and verify that
     -    there is at least one merge base, and that the arguments make sense.
     -    As a side effect, produce a warning showing *which* merge base is being
     -    used when there are multiple choices; die if there is no merge base.
     +    To avoid all this, add a routine to catch the range cases and
     +    verify that that the arguments make sense.  As a side effect,
     +    produce a warning showing *which* merge base is being used when
     +    there are multiple choices; die if there is no merge base.
      
          Signed-off-by: Chris Torek <chris.torek@gmail.com>
      
     @@ builtin/diff.c: static int builtin_diff_files(struct rev_info *revs, int argc, c
       }
       
      +struct symdiff {
     -+	struct bitmap *skip;	/* bitmap of commit indices to skip, or NULL */
     -+	int warn;		/* true if there were multiple merge bases */
     -+	int base, left, right;	/* index of chosen merge base and left&right */
     ++	struct bitmap *skip;
     ++	int warn;
     ++	const char *base, *left, *right;
      +};
      +
      +/*
      + * Check for symmetric-difference arguments, and if present, arrange
     -+ * everything we need to know to handle them correctly.
     ++ * everything we need to know to handle them correctly.  As a bonus,
     ++ * weed out all bogus range-based revision specifications, e.g.,
     ++ * "git diff A..B C..D" or "git diff A..B C" get rejected.
      + *
      + * For an actual symmetric diff, *symdiff is set this way:
      + *
     @@ builtin/diff.c: static int builtin_diff_files(struct rev_info *revs, int argc, c
      + *    which there might be many, and A in A...B).  Note that the
      + *    chosen merge base and right side are NOT marked.
      + *  - warn is set if there are multiple merge bases.
     -+ *  - base, left, and right hold the merge base and left and
     -+ *    right side indices, for warnings or errors.
     ++ *  - base, left, and right point to the names to use in a
     ++ *    warning about multiple merge bases.
      + *
      + * If there is no symmetric diff argument, sym->skip is NULL and
      + * sym->warn is cleared.  The remaining fields are not set.
     -+ *
     -+ * If the user provides a symmetric diff with no merge base, or
     -+ * more than one range, we do a usage-exit.
      + */
      +static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
      +{
     -+	int i, lcount = 0, rcount = 0, basecount = 0;
     ++	int i, is_symdiff = 0, basecount = 0, othercount = 0;
      +	int lpos = -1, rpos = -1, basepos = -1;
      +	struct bitmap *map = NULL;
      +
     @@ builtin/diff.c: static int builtin_diff_files(struct rev_info *revs, int argc, c
      +			basecount++;
      +			break;		/* do mark all bases */
      +		case REV_CMD_LEFT:
     ++			if (lpos > 0)
     ++				usage(builtin_diff_usage);
     ++			lpos = i;
      +			if (obj->flags & SYMMETRIC_LEFT) {
     -+				lpos = i;
     -+				lcount++;
     ++				is_symdiff = 1;
      +				break;	/* do mark A */
      +			}
      +			continue;
      +		case REV_CMD_RIGHT:
     ++			if (rpos > 0)
     ++				usage(builtin_diff_usage);
      +			rpos = i;
     -+			rcount++;
      +			continue;	/* don't mark B */
     -+		default:
     ++		case REV_CMD_PARENTS_ONLY:
     ++		case REV_CMD_REF:
     ++		case REV_CMD_REV:
     ++			othercount++;
      +			continue;
      +		}
      +		if (map == NULL)
     @@ builtin/diff.c: static int builtin_diff_files(struct rev_info *revs, int argc, c
      +		bitmap_set(map, i);
      +	}
      +
     -+	if (lcount == 0) {	/* not a symmetric difference */
     ++	/*
     ++	 * Forbid any additional revs for both A...B and A..B.
     ++	 */
     ++	if (lpos >= 0 && othercount > 0)
     ++		usage(builtin_diff_usage);
     ++
     ++	if (!is_symdiff) {
      +		bitmap_free(map);
      +		sym->warn = 0;
      +		sym->skip = NULL;
      +		return;
      +	}
      +
     -+	if (lcount != 1)
     -+		die(_("cannot use more than one symmetric difference"));
     -+
     -+	if (basecount == 0) {
     -+		const char *lname = rev->pending.objects[lpos].name;
     -+		const char *rname = rev->pending.objects[rpos].name;
     -+		die(_("%s...%s: no merge base"), lname, rname);
     -+	}
     ++	sym->left = rev->pending.objects[lpos].name;
     ++	sym->right = rev->pending.objects[rpos].name;
     ++	sym->base = rev->pending.objects[basepos].name;
     ++	if (basecount == 0)
     ++		die(_("%s...%s: no merge base"), sym->left, sym->right);
      +	bitmap_unset(map, basepos);	/* unmark the base we want */
     -+	sym->base = basepos;
     -+	sym->left = lpos;
     -+	sym->right = rpos;
      +	sym->warn = basecount > 1;
      +	sym->skip = map;
      +}
     @@ builtin/diff.c: int cmd_diff(int argc, const char **argv, const char *prefix)
       		struct object_array_entry *entry = &rev.pending.objects[i];
       		struct object *obj = entry->item;
      @@ builtin/diff.c: int cmd_diff(int argc, const char **argv, const char *prefix)
     - 			die(_("invalid object '%s' given."), name);
     - 		if (obj->type == OBJ_COMMIT)
       			obj = &get_commit_tree(((struct commit *)obj))->object;
     --
     + 
       		if (obj->type == OBJ_TREE) {
      +			if (sdiff.skip && bitmap_get(sdiff.skip, i))
      +				continue;
     @@ builtin/diff.c: int cmd_diff(int argc, const char **argv, const char *prefix)
       		result = builtin_diff_index(&rev, argc, argv);
      -	else if (ent.nr == 2)
      +	else if (ent.nr == 2) {
     -+		if (sdiff.warn) {
     -+			const char *lname = rev.pending.objects[sdiff.left].name;
     -+			const char *rname = rev.pending.objects[sdiff.right].name;
     -+			const char *basename = rev.pending.objects[sdiff.base].name;
     ++		if (sdiff.warn)
      +			warning(_("%s...%s: multiple merge bases, using %s"),
     -+				lname, rname, basename);
     -+		}
     ++				sdiff.left, sdiff.right, sdiff.base);
       		result = builtin_diff_tree(&rev, argc, argv,
       					   &ent.objects[0], &ent.objects[1]);
      -	else if (ent.objects[0].item->flags & UNINTERESTING) {
     @@ builtin/diff.c: int cmd_diff(int argc, const char **argv, const char *prefix)
      -		result = builtin_diff_tree(&rev, argc, argv,
      -					   &ent.objects[0],
      -					   &ent.objects[ent.nr-1]);
     --	} else
     -+	} else {
     -+		if (sdiff.skip)
     -+			usage(builtin_diff_usage);
     + 	} else
       		result = builtin_diff_combined(&rev, argc, argv,
       					       ent.objects, ent.nr);
     -+	}
     - 	result = diff_result_code(&rev.diffopt, result);
     - 	if (1 < rev.diffopt.skip_stat_unmatch)
     - 		refresh_index_quietly();
      
       ## t/t4068-diff-symmetric.sh (new) ##
      @@
     @@ t/t4068-diff-symmetric.sh (new)
      +
      +test_expect_success 'diff with one merge base' '
      +	git diff commit-D...br1 >tmp &&
     -+	tail -1 tmp >actual &&
     ++	tail -n 1 tmp >actual &&
      +	echo +f >expect &&
      +	test_cmp expect actual
      +'
     @@ t/t4068-diff-symmetric.sh (new)
      +
      +test_expect_success 'diff with too many symmetric differences' '
      +	test_must_fail git diff br1...master br2...br3 >tmp 2>err &&
     -+	test_i18ngrep "fatal: cannot use more than one symmetric difference" err
     ++	test_i18ngrep "usage" err
      +'
      +
      +test_expect_success 'diff with symmetric difference and extraneous arg' '
     @@ t/t4068-diff-symmetric.sh (new)
      +	test_i18ngrep "usage" err
      +'
      +
     ++test_expect_success 'diff with two ranges' '
     ++	test_must_fail git diff master br1..master br2..br3 >tmp 2>err &&
     ++	test_i18ngrep "usage" err
     ++'
     ++
     ++test_expect_success 'diff with ranges and extra arg' '
     ++	test_must_fail git diff master br1..master commit-D >tmp 2>err &&
     ++	test_i18ngrep "usage" err
     ++'
     ++
      +test_done
 3:  b9b4c6f113d ! 3:  a7da92cd635 Documentation: tweak git diff help slightly
     @@ Metadata
      Author: Chris Torek <chris.torek@gmail.com>
      
       ## Commit message ##
     -    Documentation: tweak git diff help slightly
     +    Documentation: usage for diff combined commits
      
     -    Update the manual page synopsis to include the three-dot notation
     -    and the combined-diff option
     +    Document the usage for producing combined commits with "git diff".
     +    This includes updating the synopsis section.
     +
     +    While here, add the three-dot notation to the synopsis.
      
          Make "git diff -h" print the same usage summary as the manual
          page synopsis, minus the "A..B" form, which is now discouraged.
      
     -    Document the usage for producing combined commits.
     -
          Signed-off-by: Chris Torek <chris.torek@gmail.com>
      
       ## Documentation/git-diff.txt ##
     @@ Documentation/git-diff.txt: two blob objects, or changes between two files on di
      +	This form is to view the results of a merge commit.  The first
      +	listed <commit> must be the merge itself; the remaining two or
      +	more commits should be its parents.  A convenient way to produce
     -+	the desired set of revisions is to use the {caret}@ suffix, i.e.,
     -+	"git diff master master^@".  This is equivalent to running "git
     -+	show --format=" on the merge commit, e.g., "git show --format=
     -+	master".
     ++	the desired set of revisions is to use the {caret}@ suffix.
     ++	For instance, if `master` names a merge commit, `git diff master
     ++	master^@` gives the same combined diff as `git show master`.
      +
       'git diff' [<options>] <commit>\...<commit> [--] [<path>...]::
       

-- 
gitgitgadget
