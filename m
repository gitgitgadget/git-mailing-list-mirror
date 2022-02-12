Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546B7C433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiBLUfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:35:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiBLUfC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:35:02 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE97606E4
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:34:56 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j26so9821485wrb.7
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/6EGKuDjtdBL5JyI9b8jQHgalZ8r5nKnsJtFWhjWCIM=;
        b=PA1KfEjSqvd1tbDMOXQ++GyCvlvAlkKjsfpAB5Ep9MAvsxhOsyrb7Bsd/KSb+pDVuK
         LkYO5h/wISONy1piusdV5hzdr1ET7/fJK0ZMIrxONS4NLXgIFY6dupP35nvfu0wgBEm9
         6MTBeCadSPEZeus06AqvZ0hYbVScT/9KHkQbrjNcwrmyBSBtz69Rzrbs8ZKXAZq20pu+
         ghjboqUy+ciLIfqHSpq5jC7IsJt02ZnTQzyoQueFOPYhYI2bG9B894GPQ1UvYSj+z7z8
         9NdDbOkGLd4dqV43eeBIUjWkcq3rsUWX0EwfVaBf5Mg8+ve5gofc1upjApCvggHSoKnf
         66DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/6EGKuDjtdBL5JyI9b8jQHgalZ8r5nKnsJtFWhjWCIM=;
        b=QlALMyuCac9odEQ9/MepiKvrCuBaU6QoCCWiTa0zSuW+O/OjyhU8x7HTVppRpd84uP
         zoS89vnUxCrg0i48tMOS3KnWeMssI5eqKZaBYGeWX6mgkh5jpfoff4Srye1yXEj7SlRy
         KCFlyOE7vhQ2EnKf4LTX0p5gWxXcqOIznMJ2R1Xe2IzmFGfXufep4CgrmghQ4XzxdfNx
         PVZR3B63EhVLVMjGluZxQXMk/zNPCNwLJa385v8uU5tfLsNNo+7EfTNgewmKMjU/6wdp
         Lq7/7bzEu+b4+V7h/CwAEroRJnDd1Ly8bEyUHxCXzg22Z+qzWwvyQzeckxiqSfyT1MWr
         bfOw==
X-Gm-Message-State: AOAM532YRUGgMJROnQ5IcaguDajGs+AYxoOEI+723YiPPc74riaR7iA+
        Cp20tq7oYKpSmdTnaBZpaxqJI31/fPc=
X-Google-Smtp-Source: ABdhPJymRg5NK+Hg4MVfSPiM+zf0O/cslimYI0c1uQBy6tkj4KK5BBs4bP1OIqSSQMu9GhiEjpvDBg==
X-Received: by 2002:adf:eb04:: with SMTP id s4mr5639775wrn.20.1644698094607;
        Sat, 12 Feb 2022 12:34:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm7052269wmp.31.2022.02.12.12.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:34:53 -0800 (PST)
Message-Id: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Feb 2022 20:34:41 +0000
Subject: [PATCH v4 00/12] In-core git merge-tree ("Server side merges")
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: Depends on en/remerge-diff (to avoid a small textual conflict)

== Basic Summary ==

This series introduces a new mode to git merge-tree allowing it to perform
real merges (three-way text content merges, recursive ancestor
consolidation, rename detection, proper directory/file conflict handling,
etc.) and write the result as a toplevel tree. It doesn't touch the working
tree or index, and doesn't create any commits or update any refs. It could
be used to do merges when in a bare repository (thus potentially making it
of interest to Git hosting sites, i.e. "Server side merges"), or for doing a
merge of branches that aren't checked out.

It does not handle similar functionality for cherry-picks, rebases, or
reverts; that is also of interest, but is being deferred for a future
series.

== Quick Overview ==

 * Patches 1-2: preparatory cleanups
 * Patches 3-4: implement basic real merges
 * Patches 5-6: include informational messages ("CONFLICT" messages and
   such) in output
 * Patches 7-10: add ability to include ls-files -u style of info in the
   output
 * Patch 11: support --allow-unrelated-histories
 * Patch 12: augment the manual with potential usage mistakes

== Updates Log ==

Many thanks to the many reviewers who provided good feedback on the most
recent round -- Junio, Ævar, Josh, Emily, and perhaps some others I've
forgotten from review club.

Updates since v3 (or v5, if you include the rounds at
https://lore.kernel.org/git/pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com/):

 * Dropped previous patches 5, 6, and 8 of the old series; they weren't
   being used and opened a can of worms[1]
 * [Patch 3] Restructured argument checking, including using an enum
 * [Patch 4] Restored the extended paragraph about the deprecated form of
   git-merge-tree, mentioned write-tree in plumbing commands, and a few
   other small fixups to the documentation
 * [Patch 4] Also provide an example of a clean merge rather than just a
   conflicted one
 * [Patch 6] Fix the incompatible arguments check and add some tests for it
 * [Patch 6] Introduce an anonymize_hash() shell function to make tests
   easier to read (less repeated sed)
 * [Patch 9] Rename --exclude-modes-oids-stages to --name-only; no short
   option for now
 * [Patch 10] When -z passed, the tree in the first section should have a
   trailing NUL rather than trailing newline [1]
   https://lore.kernel.org/git/CABPp-BEKuXHELVx4=5JJTj5HVOKZ=Y-4G4BK47BCZYYRSrkFsQ@mail.gmail.com/

Stuff NOT included that reviewers brought up in earlier rounds:

 * Very generic (mode, oid, stage, filename) printing formatting[2]
 * Always printing 3 stages for each filename with conflicts[3]
 * Attempting to group conflict stages by logical conflict rather than by
   affected target filepath[4]
 * Providing similar functionality for doing cherry-picks/rebases/reverts,
   i.e. a scheme for three-way merges with a specified merge-base[5]. That's
   being deferred to a future series. [2]
   https://lore.kernel.org/git/CABPp-BGnOes7J_piDyBUeuLVm274w4-9G3k0vR-0it3z7TPn_w@mail.gmail.com/
   [3]
   https://lore.kernel.org/git/CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com/
   [4]
   https://lore.kernel.org/git/CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com/
   [5]
   https://lore.kernel.org/git/CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com/

Updates since v2:

 * Improved patches from Dscho for the diff_warn_rename_limit() handling
 * Add a -z option for NUL-terminated conflict info lines (so that filenames
   do not have to be quoted)

Updates since v1 (or v3 depending on how you count; thanks to René, Ævar,
Christian, Dscho for very helpful feedback):

 * New patch from Dscho allowing diff_warn_rename_limit() to print somewhere
   other than stdout (I hope he's okay with me including his Signed-off-by)
 * Now prints filenames relative to prefix, much like ls-files
 * Renamed --exclude-oids-and-modes to --exclude-modes-oids-stages and gave
   it a -l shorthand; I'm wondering if I should just drop this option,
   though.
 * And numerous cleanups, in lots of areas:
   * Multiple parse-options cleanups
   * Lots of commit message cleanups
   * Wording tweaks to the "Description" section of the manual
   * Several small code cleanups
 * I dropped the RFC label

Updates since original submission v2 (thanks to Christian, Dscho, Ramsay,
and René for suggestions and comments):

 * Significant changes to output format:
   * Flags no longer take a filename for additional output; they write to
     stdout instead.
   * More information included by default when there are conflicts (no need
     to request it with additional flags, instead flags can be used to
     suppress it).
   * Provide (mode, oid, stage, file) tuples -- i.e. ls-files -u style of
     information -- when there are conflicts. Add a flag to only list
     conflicted files if that's preferred.
 * Much more thorough manual for git-merge-tree.txt
 * Renamed option from --real to --write-tree
 * Accept an optional --trivial-merge option to get old style merge-tree
   behavior
 * Allow both --write-tree and --trivial-merge to be omitted since we can
   deduce which from number of arguments
 * Document exit code when the merge cannot be run (so we can distinguish
   other error cases from conflicts)
 * testcase cleanups: test_tick, early skip of test when using recursive
   backend, variable renames, etc.
 * various minor code cleanups
 * Add a new --allow-unrelated-histories option (with same meaning as the
   one used in git merge)
 * Rebased on top of en/remerge-diff to avoid a small conflict

Updates since original submission v1 (thanks to Johannes Altmanninger and
Fabian for suggestions):

 * Fixed a bad patch splitting, and a style issue pointed out by Johannes
   Altimanninger
 * Fixed misleading commit messages in new test cases
 * Fixed my comments about how commit-tree could be used to correctly use
   two -p flags

Elijah Newren (12):
  merge-tree: rename merge_trees() to trivial_merge_trees()
  merge-tree: move logic for existing merge into new function
  merge-tree: add option parsing and initial shell for real merge
    function
  merge-tree: implement real merges
  merge-ort: split out a separate display_update_messages() function
  merge-tree: support including merge messages in output
  merge-ort: provide a merge_get_conflicted_files() helper function
  merge-tree: provide a list of which files have conflicts
  merge-tree: provide easy access to `ls-files -u` style info
  merge-tree: allow `ls-files -u` style info to be NUL terminated
  merge-tree: add a --allow-unrelated-histories flag
  git-merge-tree.txt: add a section on potentional usage mistakes

 Documentation/git-merge-tree.txt | 204 ++++++++++++++++++++++++--
 builtin/merge-tree.c             | 189 ++++++++++++++++++++++--
 git.c                            |   2 +-
 merge-ort.c                      | 109 +++++++++-----
 merge-ort.h                      |  29 ++++
 t/t4301-merge-tree-write-tree.sh | 238 +++++++++++++++++++++++++++++++
 6 files changed, 709 insertions(+), 62 deletions(-)
 create mode 100755 t/t4301-merge-tree-write-tree.sh


base-commit: ea5df61cf358d3c831189e2f04863abc2157e3e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1122%2Fnewren%2Fin-core-merge-tree-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1122/newren/in-core-merge-tree-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1122

Range-diff vs v3:

  1:  4a7cd5542bb =  1:  4a7cd5542bb merge-tree: rename merge_trees() to trivial_merge_trees()
  2:  4780ff6784d =  2:  4780ff6784d merge-tree: move logic for existing merge into new function
  3:  63f42df21ae !  3:  60253745f5c merge-tree: add option parsing and initial shell for real merge function
     @@ builtin/merge-tree.c: static int trivial_merge(int argc, const char **argv)
       	return 0;
       }
       
     ++enum mode {
     ++	MODE_UNKNOWN,
     ++	MODE_TRIVIAL,
     ++	MODE_REAL,
     ++};
     ++
      +struct merge_tree_options {
      +	int mode;
      +};
     @@ builtin/merge-tree.c: static int trivial_merge(int argc, const char **argv)
      +	struct option mt_options[] = {
      +		OPT_CMDMODE(0, "write-tree", &o.mode,
      +			    N_("do a real merge instead of a trivial merge"),
     -+			    'w'),
     ++			    MODE_REAL),
      +		OPT_CMDMODE(0, "trivial-merge", &o.mode,
     -+			    N_("do a trivial merge only"), 't'),
     ++			    N_("do a trivial merge only"), MODE_TRIVIAL),
      +		OPT_END()
      +	};
      +
      +	/* Parse arguments */
      +	argc = parse_options(argc, argv, prefix, mt_options,
      +			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
     -+	if (o.mode) {
     -+		expected_remaining_argc = (o.mode == 'w' ? 2 : 3);
     -+		if (argc != expected_remaining_argc)
     ++	switch (o.mode) {
     ++	default:
     ++		BUG("unexpected command mode %d", o.mode);
     ++	case MODE_UNKNOWN:
     ++		switch (argc) {
     ++		default:
      +			usage_with_options(merge_tree_usage, mt_options);
     -+	} else {
     -+		if (argc < 2 || argc > 3)
     -+			usage_with_options(merge_tree_usage, mt_options);
     -+		o.mode = (argc == 2 ? 'w' : 't');
     ++		case 2:
     ++			o.mode = MODE_REAL;
     ++			break;
     ++		case 3:
     ++			o.mode = MODE_TRIVIAL;
     ++			break;
     ++		}
     ++		expected_remaining_argc = argc;
     ++		break;
     ++	case MODE_REAL:
     ++		expected_remaining_argc = 2;
     ++		break;
     ++	case MODE_TRIVIAL:
     ++		expected_remaining_argc = 3;
     ++		break;
      +	}
      +
     ++	if (argc != expected_remaining_argc)
     ++		usage_with_options(merge_tree_usage, mt_options);
     ++
      +	/* Do the relevant type of merge */
     -+	if (o.mode == 'w')
     ++	if (o.mode == MODE_REAL)
      +		return real_merge(&o, argv[0], argv[1]);
      +	else
      +		return trivial_merge(argv[0], argv[1], argv[2]);
  4:  02c29f920d0 !  4:  d7b51da94e6 merge-tree: implement real merges
     @@ Commit message
          conflict/warning messages normally output during a merge, or have quick
          access to a list of files with conflicts.  That is not available in this
          preliminary implementation, but subsequent commits will add that
     -    ability.
     +    ability (meaning that NEWTREE would be a lot more than a tree in the
     +    case of conflicts).
      
          This also marks the traditional trivial merge of merge-tree as
          deprecated.  The trivial merge not only had limited applicability, the
     @@ Documentation/git-merge-tree.txt: git-merge-tree(1)
      +Performs a merge, but does not make any new commits and does not read
      +from or write to either the working tree or index.
      +
     -+The second form is deprecated and supported only for backward
     -+compatibility.  It will likely be removed in the future, and will not
     -+be discussed further in this manual.
     -+
      +The first form will merge the two branches, doing a real merge.  A real
      +merge is distinguished from a trivial merge in that it includes:
      +
     @@ Documentation/git-merge-tree.txt: git-merge-tree(1)
      +    merge base, creating a virtual merge base by merging the merge bases)
      +  * etc.
      +
     -+After the merge completes, it will create a new toplevel tree object.
     -+See `OUTPUT` below for details.
     ++After the merge completes, the first form will create a new toplevel
     ++tree object.  See `OUTPUT` below for details.
     ++
     ++The second form is deprecated; it is kept for backward compatibility
     ++reasons but may be deleted in the future.  Other than the optional
     ++`--trivial-merge`, it accepts no options.  It can only do a trivial
     ++merge.  It reads three tree-ish, and outputs trivial merge results and
     ++conflicting stages to the standard output in a semi-diff format.
     ++Since this was designed for higher level scripts to consume and merge
     ++the results back into the index, it omits entries that match
     ++<branch1>.  The result of this second form is is similar to what
     ++three-way 'git read-tree -m' does, but instead of storing the results
     ++in the index, the command outputs the entries to the standard output.
     ++This form not only has limited applicability, the output format is
     ++also difficult to work with, and it will generally be less performant
     ++than the first form even on successful merges (especially if working
     ++in large repositories).  The remainder of this manual will only
     ++discuss the first form.
      +
      +OUTPUT
      +------
     @@ Documentation/git-merge-tree.txt: git-merge-tree(1)
      +For a successful, non-conflicted merge, the exit status is 0.  When the
      +merge has conflicts, the exit status is 1.  If the merge is not able to
      +complete (or start) due to some kind of error, the exit status is
     -+something other than 0 or 1.
     ++something other than 0 or 1 (and the output is unspecified).
      +
      +USAGE NOTES
      +-----------
      +
      +git-merge-tree was written to be low-level plumbing, similar to
     -+hash-object, mktree, commit-tree, update-ref, and mktag.  Thus, it could
     -+be used as a part of a series of steps such as
     ++hash-object, mktree, commit-tree, write-tree, update-ref, and mktag.
     ++Thus, it could be used as a part of a series of steps such as
      +
      +       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
      +       test $? -eq 0 || die "There were conflicts..."
      +       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
      +       git update-ref $BRANCH1 $NEWCOMMIT
     -+
     -+However, it does not quite fit into the same category of low-level
     -+plumbing commands since the possibility of merge conflicts give it a
     -+much higher chance of the command not succeeding.
       
       GIT
       ---
     @@ t/t4301-merge-tree-write-tree.sh (new)
      +
      +	git branch side1 &&
      +	git branch side2 &&
     ++	git branch side3 &&
      +
      +	git checkout side1 &&
      +	test_write_lines 1 2 3 4 5 6 >numbers &&
     @@ t/t4301-merge-tree-write-tree.sh (new)
      +	>whatever/empty &&
      +	git add numbers greeting whatever/empty &&
      +	test_tick &&
     -+	git commit -m other-modifications
     ++	git commit -m other-modifications &&
     ++
     ++	git checkout side3 &&
     ++	git mv numbers sequence &&
     ++	test_tick &&
     ++	git commit -m rename-numbers
     ++'
     ++
     ++test_expect_success 'Clean merge' '
     ++	git merge-tree --write-tree side1 side3 >RESULT &&
     ++	q_to_tab <<-EOF >expect &&
     ++	100644 blob $(git rev-parse side1:greeting)Qgreeting
     ++	100644 blob $(git rev-parse side1:numbers)Qsequence
     ++	100644 blob $(git rev-parse side1:whatever)Qwhatever
     ++	EOF
     ++
     ++	git ls-tree $(cat RESULT) >actual &&
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success 'Content merge and a few conflicts' '
     @@ t/t4301-merge-tree-write-tree.sh (new)
      +'
      +
      +test_expect_success 'Barf on too many arguments' '
     -+	test_expect_code 129 git merge-tree --write-tree side1 side2 side3 2>expect &&
     ++	test_expect_code 129 git merge-tree --write-tree side1 side2 invalid 2>expect &&
      +
      +	grep "^usage: git merge-tree" expect
      +'
  5:  290b42846b5 <  -:  ----------- Introduce a variant of the `warning()` function that takes a `FILE *`
  6:  2083fbe9b2e <  -:  ----------- diff: allow diff_warn_rename_limit to write somewhere besides stderr
  7:  1be858e6aa6 !  5:  58a5594aeb6 merge-ort: split out a separate display_update_messages() function
     @@ merge-ort.c: static int record_conflicted_index_entries(struct merge_options *op
      +
      +	/* Also include needed rename limit adjustment now */
      +	diff_warn_rename_limit("merge.renamelimit",
     -+			       opti->renames.needed_limit, 0, stderr);
     ++			       opti->renames.needed_limit, 0);
      +
      +	trace2_region_leave("merge", "display messages", opt->repo);
      +}
     @@ merge-ort.c: static int record_conflicted_index_entries(struct merge_options *op
       			    struct tree *head,
       			    struct merge_result *result,
      @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
     + 		fclose(fp);
       		trace2_region_leave("merge", "write_auto_merge", opt->repo);
       	}
     - 
     +-
      -	if (display_update_msgs) {
      -		struct merge_options_internal *opti = result->priv;
      -		struct hashmap_iter iter;
     @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
      -
      -		/* Also include needed rename limit adjustment now */
      -		diff_warn_rename_limit("merge.renamelimit",
     --				       opti->renames.needed_limit, 0, stderr);
     +-				       opti->renames.needed_limit, 0);
      -
      -		trace2_region_leave("merge", "display messages", opt->repo);
      -	}
  8:  04c3bdc44d2 <  -:  ----------- merge-ort: allow update messages to be written to different file stream
  9:  c8ed002408d !  6:  fa55cb4d644 merge-tree: support including merge messages in output
     @@ Documentation/git-merge-tree.txt: git-merge-tree - Perform merge without touchin
       'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (deprecated)
       
       DESCRIPTION
     -@@ Documentation/git-merge-tree.txt: merge is distinguished from a trivial merge in that it includes:
     - After the merge completes, it will create a new toplevel tree object.
     - See `OUTPUT` below for details.
     +@@ Documentation/git-merge-tree.txt: than the first form even on successful merges (especially if working
     + in large repositories).  The remainder of this manual will only
     + discuss the first form.
       
      +OPTIONS
      +-------
     @@ Documentation/git-merge-tree.txt: merge is distinguished from a trivial merge in
      +	<Informational messages>
      +
      +These are discussed individually below.
     -+
     + 
     +-The printed tree object corresponds to what would be checked out in
     +-the working tree at the end of `git merge`, and thus may have files
     +-with conflict markers in them.
      +OID of toplevel tree
      +~~~~~~~~~~~~~~~~~~~~
      +
     @@ Documentation/git-merge-tree.txt: merge is distinguished from a trivial merge in
      +
      +This always starts with a blank line to separate it from the previous
      +section, and then has free-form messages about the merge, such as:
     - 
     --The printed tree object corresponds to what would be checked out in
     --the working tree at the end of `git merge`, and thus may have files
     --with conflict markers in them.
     ++
      +  * "Auto-merging <file>"
      +  * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
      +  * "Failed to merge submodule <submodule> (<reason>)"
     @@ Documentation/git-merge-tree.txt: merge is distinguished from a trivial merge in
       
       EXIT STATUS
       -----------
     -@@ Documentation/git-merge-tree.txt: be used as a part of a series of steps such as
     - 
     - However, it does not quite fit into the same category of low-level
     - plumbing commands since the possibility of merge conflicts give it a
     --much higher chance of the command not succeeding.
     -+much higher chance of the command not succeeding (and NEWTREE containing
     -+a bunch of stuff other than just a toplevel tree).
     +@@ Documentation/git-merge-tree.txt: Thus, it could be used as a part of a series of steps such as
     +        NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
     +        git update-ref $BRANCH1 $NEWCOMMIT
       
     ++Note that when the exit status is non-zero, NEWTREE in this sequence
     ++will contain a lot more output than just a tree.
     ++
       GIT
       ---
     + Part of the linkgit:git[1] suite
      
       ## builtin/merge-tree.c ##
     -@@ builtin/merge-tree.c: static int trivial_merge(const char *base,
     +@@ builtin/merge-tree.c: enum mode {
       
       struct merge_tree_options {
       	int mode;
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       	puts(oid_to_hex(&result.tree->object.oid));
      +	if (o->show_messages) {
      +		printf("\n");
     -+		merge_display_update_messages(&opt, &result, stdout);
     ++		merge_display_update_messages(&opt, &result);
      +	}
       	merge_finalize(&opt, &result);
       	return !result.clean; /* result.clean < 0 handled above */
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       		NULL
       	};
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     - 			    'w'),
     + 			    MODE_REAL),
       		OPT_CMDMODE(0, "trivial-merge", &o.mode,
     - 			    N_("do a trivial merge only"), 't'),
     + 			    N_("do a trivial merge only"), MODE_TRIVIAL),
      +		OPT_BOOL(0, "messages", &o.show_messages,
      +			 N_("also show informational/conflict messages")),
       		OPT_END()
       	};
       
       	/* Parse arguments */
     -+	original_argc = argc;
     ++	original_argc = argc - 1; /* ignoring argv[0] */
       	argc = parse_options(argc, argv, prefix, mt_options,
       			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
     - 	if (o.mode) {
     + 	switch (o.mode) {
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     - 			usage_with_options(merge_tree_usage, mt_options);
     - 		o.mode = (argc == 2 ? 'w' : 't');
     + 		break;
     + 	case MODE_TRIVIAL:
     + 		expected_remaining_argc = 3;
     ++		/* Removal of `--trivial-merge` is expected */
     ++		original_argc--;
     + 		break;
       	}
     -+	if (o.mode == 't' && original_argc < argc)
     ++	if (o.mode == MODE_TRIVIAL && argc < original_argc)
      +		die(_("--trivial-merge is incompatible with all other options"));
       
     - 	/* Do the relevant type of merge */
     - 	if (o.mode == 'w')
     + 	if (argc != expected_remaining_argc)
     + 		usage_with_options(merge_tree_usage, mt_options);
      
       ## t/t4301-merge-tree-write-tree.sh ##
      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Barf on too many arguments' '
       	grep "^usage: git merge-tree" expect
       '
       
     ++anonymize_hash() {
     ++	sed -e "s/[0-9a-f]\{40,\}/HASH/g" "$@"
     ++}
     ++
      +test_expect_success 'test conflict notices and such' '
      +	test_expect_code 1 git merge-tree --write-tree side1 side2 >out &&
     -+	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
     ++	anonymize_hash out >actual &&
      +
      +	# Expected results:
      +	#   "greeting" should merge with conflicts
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Barf on too many argument
      +
      +	test_cmp expect actual
      +'
     ++
     ++for opt in $(git merge-tree --git-completion-helper-all)
     ++do
     ++	if test $opt = "--trivial-merge" || test $opt = "--write-tree"
     ++	then
     ++		continue
     ++	fi
     ++
     ++	test_expect_success "usage: --trivial-merge is incompatible with $opt" '
     ++		test_expect_code 128 git merge-tree --trivial-merge $opt side1 side2 side3
     ++	'
     ++done
      +
       test_done
 10:  1c2a3f5ef63 !  7:  f3ad7add515 merge-ort: provide a merge_get_conflicted_files() helper function
     @@ merge-ort.h
       
       struct commit;
       struct tree;
     -@@ merge-ort.h: void merge_display_update_messages(struct merge_options *opt,
     - 				   struct merge_result *result,
     - 				   FILE *stream);
     +@@ merge-ort.h: void merge_switch_to_result(struct merge_options *opt,
     + void merge_display_update_messages(struct merge_options *opt,
     + 				   struct merge_result *result);
       
      +struct stage_info {
      +	struct object_id oid;
 11:  9c2389eef0e !  8:  6058190d1b1 merge-tree: provide a list of which files have conflicts
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
      +	}
       	if (o->show_messages) {
       		printf("\n");
     - 		merge_display_update_messages(&opt, &result, stdout);
     + 		merge_display_update_messages(&opt, &result);
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
       
       	/* Do the relevant type of merge */
     - 	if (o.mode == 'w')
     + 	if (o.mode == MODE_REAL)
      -		return real_merge(&o, argv[0], argv[1]);
      +		return real_merge(&o, argv[0], argv[1], prefix);
       	else
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'test conflict notices and
       
       	Auto-merging greeting
       	CONFLICT (content): Merge conflict in greeting
     -@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'test conflict notices and such' '
     - 	test_cmp expect actual
     - '
     +@@ t/t4301-merge-tree-write-tree.sh: do
     + 	'
     + done
       
      +test_expect_success 'Just the conflicted files without the messages' '
      +	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
     -+	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
     ++	anonymize_hash out >actual &&
      +
      +	test_write_lines HASH greeting whatever~side1 >expect &&
      +
 12:  2188a8ca1e7 !  9:  435f66ea699 merge-tree: provide easy access to `ls-files -u` style info
     @@ Commit message
          Much like `git merge` updates the index with information of the form
              (mode, oid, stage, name)
          provide this output for conflicted files for merge-tree as well.
     -    Provide an --exclude-modes-oids-stages/-l option for users to exclude
     -    the mode, oid, and stage and only get the list of conflicted filenames.
     +    Provide a --name-only option for users to exclude the mode, oid, and
     +    stage and only get the list of conflicted filenames.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-merge-tree.txt ##
     -@@ Documentation/git-merge-tree.txt: See `OUTPUT` below for details.
     +@@ Documentation/git-merge-tree.txt: discuss the first form.
       OPTIONS
       -------
       
     -+--exclude-oids-and-modes::
     -+	Instead of writing a list of (mode, oid, stage, path) tuples
     -+	to output for conflicted files, just provide a list of
     -+	filenames with conflicts.
     ++--name-only::
     ++	In the Conflicted file info section, instead of writing a list
     ++	of (mode, oid, stage, path) tuples to output for conflicted
     ++	files, just provide a list of filenames with conflicts (and
     ++	do not list filenames multiple times if they have multiple
     ++	conflicting stages).
      +
       --[no-]messages::
       	Write any informational messages such as "Auto-merging <path>"
     @@ Documentation/git-merge-tree.txt: This is a tree object that represents what wou
      +
      +The filename will be quoted as explained for the configuration
      +variable `core.quotePath` (see linkgit:git-config[1]).  However, if
     -+the `--exclude-oids-and-modes` option is passed, the mode, object, and
     -+stage will be omitted.
     ++the `--name-only` option is passed, the mode, object, and stage will
     ++be omitted.
       
       Informational messages
       ~~~~~~~~~~~~~~~~~~~~~~
     @@ Documentation/git-merge-tree.txt: This is a tree object that represents what wou
       
         * "Auto-merging <file>"
         * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
     -@@ Documentation/git-merge-tree.txt: plumbing commands since the possibility of merge conflicts give it a
     - much higher chance of the command not succeeding (and NEWTREE containing
     - a bunch of stuff other than just a toplevel tree).
     +@@ Documentation/git-merge-tree.txt: Thus, it could be used as a part of a series of steps such as
     + Note that when the exit status is non-zero, NEWTREE in this sequence
     + will contain a lot more output than just a tree.
       
      +git-merge-tree was written to provide users with the same information
      +that they'd have access to if using `git merge`:
     @@ Documentation/git-merge-tree.txt: plumbing commands since the possibility of mer
       Part of the linkgit:git[1] suite
      
       ## builtin/merge-tree.c ##
     -@@ builtin/merge-tree.c: static int trivial_merge(const char *base,
     +@@ builtin/merge-tree.c: enum mode {
       struct merge_tree_options {
       	int mode;
       	int show_messages;
     -+	int exclude_modes_oids_stages;
     ++	int name_only;
       };
       
       static int real_merge(struct merge_tree_options *o,
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       			const char *name = conflicted_files.items[i].string;
      -			if (last && !strcmp(last, name))
      +			struct stage_info *c = conflicted_files.items[i].util;
     -+			if (!o->exclude_modes_oids_stages)
     ++			if (!o->name_only)
      +				printf("%06o %s %d\t",
      +				       c->mode, oid_to_hex(&c->oid), c->stage);
      +			else if (last && !strcmp(last, name))
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       			write_name_quoted_relative(
       				name, prefix, stdout, line_termination);
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     - 			    N_("do a trivial merge only"), 't'),
     + 			    N_("do a trivial merge only"), MODE_TRIVIAL),
       		OPT_BOOL(0, "messages", &o.show_messages,
       			 N_("also show informational/conflict messages")),
     -+		OPT_BOOL_F('l', "exclude-modes-oids-stages",
     -+			   &o.exclude_modes_oids_stages,
     -+			   N_("list conflicted files without modes/oids/stages"),
     ++		OPT_BOOL_F(0, "name-only",
     ++			   &o.name_only,
     ++			   N_("list filenames without modes/oids/stages"),
      +			   PARSE_OPT_NONEG),
       		OPT_END()
       	};
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Content merge and a few c
       	test_when_finished "git reset --hard" &&
       
       	test_expect_code 1 git merge-tree --write-tree side1 side2 >RESULT &&
     -@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Barf on too many arguments' '
     - '
     +@@ t/t4301-merge-tree-write-tree.sh: anonymize_hash() {
     + }
       
       test_expect_success 'test conflict notices and such' '
      -	test_expect_code 1 git merge-tree --write-tree side1 side2 >out &&
     -+	test_expect_code 1 git merge-tree --write-tree --exclude-modes-oids-stages side1 side2 >out &&
     - 	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
     ++	test_expect_code 1 git merge-tree --write-tree --name-only side1 side2 >out &&
     + 	anonymize_hash out >actual &&
       
       	# Expected results:
     -@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'test conflict notices and such' '
     - '
     +@@ t/t4301-merge-tree-write-tree.sh: do
     + done
       
       test_expect_success 'Just the conflicted files without the messages' '
      -	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
     -+	test_expect_code 1 git merge-tree --write-tree --no-messages --exclude-modes-oids-stages side1 side2 >out &&
     - 	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
     ++	test_expect_code 1 git merge-tree --write-tree --no-messages --name-only side1 side2 >out &&
     + 	anonymize_hash out >actual &&
       
       	test_write_lines HASH greeting whatever~side1 >expect &&
      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Just the conflicted files without the messages' '
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Just the conflicted files
       
      +test_expect_success 'Check conflicted oids and modes without messages' '
      +	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
     -+	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
     ++	anonymize_hash out >actual &&
      +
      +	# Compare the basic output format
      +	q_to_tab >expect <<-\EOF &&
 13:  52339b396fa ! 10:  5f253e298b3 merge-tree: allow `ls-files -u` style info to be NUL terminated
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-merge-tree.txt ##
     -@@ Documentation/git-merge-tree.txt: See `OUTPUT` below for details.
     +@@ Documentation/git-merge-tree.txt: discuss the first form.
       OPTIONS
       -------
       
     @@ Documentation/git-merge-tree.txt: See `OUTPUT` below for details.
      +	newline.  Also begin the messages section with a NUL character
      +	instead of a newline.  See OUTPUT below for more information.
      +
     - --exclude-oids-and-modes::
     - 	Instead of writing a list of (mode, oid, stage, path) tuples
     - 	to output for conflicted files, just provide a list of
     + --name-only::
     + 	In the Conflicted file info section, instead of writing a list
     + 	of (mode, oid, stage, path) tuples to output for conflicted
      @@ Documentation/git-merge-tree.txt: OID of toplevel tree
       
       This is a tree object that represents what would be checked out in the
       working tree at the end of `git merge`.  If there were conflicts, then
      -files within this tree may have embedded conflict markers.
      +files within this tree may have embedded conflict markers.  This section
     -+is always followed by a newline.
     ++is always followed by a newline (or NUL if `-z` is passed).
       
       Conflicted file info
       ~~~~~~~~~~~~~~~~~~~~
      @@ Documentation/git-merge-tree.txt: This is a sequence of lines with the format
       The filename will be quoted as explained for the configuration
       variable `core.quotePath` (see linkgit:git-config[1]).  However, if
     - the `--exclude-oids-and-modes` option is passed, the mode, object, and
     --stage will be omitted.
     -+stage will be omitted.  If `-z` is passed, the "lines" are terminated
     -+by a NUL character instead of a newline character.
     + the `--name-only` option is passed, the mode, object, and stage will
     +-be omitted.
     ++be omitted.  If `-z` is passed, the "lines" are terminated by a NUL
     ++character instead of a newline character.
       
       Informational messages
       ~~~~~~~~~~~~~~~~~~~~~~
     @@ Documentation/git-merge-tree.txt: This is a sequence of lines with the format
       
      
       ## builtin/merge-tree.c ##
     +@@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
     + 	if (o->show_messages == -1)
     + 		o->show_messages = !result.clean;
     + 
     +-	puts(oid_to_hex(&result.tree->object.oid));
     ++	printf("%s%c", oid_to_hex(&result.tree->object.oid), line_termination);
     + 	if (!result.clean) {
     + 		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
     + 		const char *last = NULL;
      @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       		string_list_clear(&conflicted_files, 1);
       	}
       	if (o->show_messages) {
      -		printf("\n");
      +		putchar(line_termination);
     - 		merge_display_update_messages(&opt, &result, stdout);
     + 		merge_display_update_messages(&opt, &result);
       	}
       	merge_finalize(&opt, &result);
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     - 			    N_("do a trivial merge only"), 't'),
     + 			    N_("do a trivial merge only"), MODE_TRIVIAL),
       		OPT_BOOL(0, "messages", &o.show_messages,
       			 N_("also show informational/conflict messages")),
      +		OPT_SET_INT('z', NULL, &line_termination,
      +			    N_("separate paths with the NUL character"), '\0'),
     - 		OPT_BOOL_F('l', "exclude-modes-oids-stages",
     - 			   &o.exclude_modes_oids_stages,
     - 			   N_("list conflicted files without modes/oids/stages"),
     + 		OPT_BOOL_F(0, "name-only",
     + 			   &o.name_only,
     + 			   N_("list filenames without modes/oids/stages"),
      
       ## t/t4301-merge-tree-write-tree.sh ##
      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Check conflicted oids and modes without messages' '
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Check conflicted oids and
      +	git commit -m "Renamed numbers" &&
      +
      +	test_expect_code 1 git merge-tree --write-tree -z tweak1 side2 >out &&
     -+	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
     ++	anonymize_hash out >actual &&
      +
      +	# Expected results:
      +	#   "greeting" should merge with conflicts
      +	#   "whatever" has *both* a modify/delete and a file/directory conflict
      +	#   "Αυτά μου φαίνονται κινέζικα" should have a conflict
     -+	echo HASH >expect &&
     ++	echo HASH | lf_to_nul >expect &&
      +
      +	q_to_tab <<-EOF | lf_to_nul >>expect &&
      +	100644 HASH 1Qgreeting
 14:  c854ecb5f4a ! 11:  e706cf31c6e merge-tree: add a --allow-unrelated-histories flag
     @@ Documentation/git-merge-tree.txt: OPTIONS
       
      
       ## builtin/merge-tree.c ##
     -@@ builtin/merge-tree.c: static int trivial_merge(const char *base,
     +@@ builtin/merge-tree.c: enum mode {
       
       struct merge_tree_options {
       	int mode;
      +	int allow_unrelated_histories;
       	int show_messages;
     - 	int exclude_modes_oids_stages;
     + 	int name_only;
       };
      @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       	 * merge_incore_recursive in merge-ort.h
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       	for (j = common; j; j = j->next)
       		commit_list_insert(j->item, &merge_bases);
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     - 			   &o.exclude_modes_oids_stages,
     - 			   N_("list conflicted files without modes/oids/stages"),
     + 			   &o.name_only,
     + 			   N_("list filenames without modes/oids/stages"),
       			   PARSE_OPT_NONEG),
      +		OPT_BOOL_F(0, "allow-unrelated-histories",
      +			   &o.allow_unrelated_histories,
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char
      
       ## t/t4301-merge-tree-write-tree.sh ##
      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
     - 	>whatever/empty &&
     - 	git add numbers greeting whatever/empty &&
     + 	git checkout side3 &&
     + 	git mv numbers sequence &&
       	test_tick &&
     --	git commit -m other-modifications
     -+	git commit -m other-modifications &&
     +-	git commit -m rename-numbers
     ++	git commit -m rename-numbers &&
      +
      +	git switch --orphan unrelated &&
      +	>something-else &&
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
      +	git commit -m first-commit
       '
       
     - test_expect_success 'Content merge and a few conflicts' '
     + test_expect_success 'Clean merge' '
      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'NUL terminated conflicted file "lines"' '
       	test_cmp expect actual
       '
 15:  bc8591bbb63 = 12:  c279236ab65 git-merge-tree.txt: add a section on potentional usage mistakes

-- 
gitgitgadget
