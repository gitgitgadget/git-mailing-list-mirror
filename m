Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F2C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbiBBHep (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiBBHep (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:34:45 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D643BC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i82so369283wma.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5LhbciZBflnwT3qd7PQL8lMzD+LHbwHpnR7jZrMCJ3Y=;
        b=YYpxPHNd4h44ALsSd/iB2fmqe/aaiJCXJlTpcnB9DxEhN8GxqP+Wg1Hrk2t1g0qHkM
         3pP12jU9DNajXn563M0Ry4wA/FDAiQv52+m6xpjTVkUBb4xxOegJInKzb2R/iDxvxL2t
         9Nz4FHcXoDR2Qfdy8Rj6t0boxsAeDTrI4W0PJ2XfuiwA+lRd6rBzpbUygn23l1HJWHnH
         1eI7gMODMbeLsLr2qFMWgdMqjiKA63r4joqS6fRKwUIItWWoct+rz0+UswU3TXMZeEvc
         n+rg/uD66iqX40S4zFYNfSwzs++kmaJNOyrgn2t9XdVzlknMO1sVNNGmSQDrfEcGU0uk
         F8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5LhbciZBflnwT3qd7PQL8lMzD+LHbwHpnR7jZrMCJ3Y=;
        b=7ZH/3XWsu2Ls97KVki/wtZLIG0ZPQoe1t2fKPTFWM+wjOU1p113HvrmiR8tw++6zqR
         zmcfxnWDiwgE3E/4M57uNIYk79gOmt668173Zq2MlKdECtr/9Hx2/rSaTUqa+6soj9WE
         fyBA7Q96Awnl27zHn33HF1FBqnkIrnO/JUkUiltrKpWTujcXDJlfyqWypVFJeDUEM8To
         xr7RnlRDwH4FsGMNggKM+kN0PFbw5UXWtBE4g8TgMVzkRIgmym9khyUPUXxgvGgZKlLP
         CDtZbe+mXSNkHtO2OacV0bGSeL0fzPjyhGgGM1NscCT2YMo1IOPDD6sBRe3xxMAvZd7Y
         GGZw==
X-Gm-Message-State: AOAM532CPOOoDsUgIbj4W2HaAhi3/UtBm/XwUWuqCovcsFZglh6oVE+D
        ByNvKB2o4YQDxQ76VmRzzhR9o2lpGHE=
X-Google-Smtp-Source: ABdhPJyMAp+FGWaizF7ML6lww0YN2ockGSBMwiY/PiJnUn04NIc/aA9zmpM1swbb2Xo4DBr7LxmIFQ==
X-Received: by 2002:a05:600c:20d3:: with SMTP id y19mr4869678wmm.27.1643787283115;
        Tue, 01 Feb 2022 23:34:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m187sm3853116wme.25.2022.02.01.23.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:42 -0800 (PST)
Message-Id: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:26 +0000
Subject: [PATCH v3 00/15] In-core git merge-tree ("Server side merges")
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
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: Depends on en/remerge-diff (to avoid a small textual conflict). Still
under heavy discussion, though, so no need to pick up yet.

== Basic Summary ==

This series introduces a new mode to git merge-tree allowing it to perform
real merges (three-way text content merges, recursive ancestor
consolidation, rename detection, proper directory/file conflict handling,
etc.) and write the result as a toplevel tree. It doesn't touch the working
tree or index, and doesn't create any commits or update any refs.

== Quick Overview ==

 * Patches 1-2: preparatory cleanups
 * Patches 3-4: implement basic real merges
 * Patches 5-9: include informational messages ("CONFLICT" messages and
   such) in output
   * to be honest, patches 5, 6, & 8 may be less relevant since we're now
     including these messages on stdout anyway...
 * Patches 10-13: add ability to include ls-files -u style of info in the
   output
 * Patch 14: support --allow-unrelated-histories
 * Patch 15: augment the manual with potential usage mistakes

== Updates Log ==

Updates since v2 (or v4, if you include the rounds at
https://lore.kernel.org/git/pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com/):

 * Improved patches from Dscho for the diff_warn_rename_limit() handling
 * Add a -z option for NUL-terminated conflict info lines (so that filenames
   do not have to be quoted)

Stuff NOT included that reviewers brought up in earlier rounds:

 * Very generic (mode, oid, stage, filename) printing formatting[1]
 * Always printing 3 stages for each filename with conflicts[2] [1]
   https://lore.kernel.org/git/CABPp-BGnOes7J_piDyBUeuLVm274w4-9G3k0vR-0it3z7TPn_w@mail.gmail.com/
   [2]
   https://lore.kernel.org/git/CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com/

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

Elijah Newren (13):
  merge-tree: rename merge_trees() to trivial_merge_trees()
  merge-tree: move logic for existing merge into new function
  merge-tree: add option parsing and initial shell for real merge
    function
  merge-tree: implement real merges
  merge-ort: split out a separate display_update_messages() function
  merge-ort: allow update messages to be written to different file
    stream
  merge-tree: support including merge messages in output
  merge-ort: provide a merge_get_conflicted_files() helper function
  merge-tree: provide a list of which files have conflicts
  merge-tree: provide easy access to `ls-files -u` style info
  merge-tree: allow `ls-files -u` style info to be NUL terminated
  merge-tree: add a --allow-unrelated-histories flag
  git-merge-tree.txt: add a section on potentional usage mistakes

Johannes Schindelin (2):
  Introduce a variant of the `warning()` function that takes a `FILE *`
  diff: allow diff_warn_rename_limit to write somewhere besides stderr

 Documentation/git-merge-tree.txt | 192 +++++++++++++++++++++++++++--
 builtin/merge-tree.c             | 164 +++++++++++++++++++++++--
 diff.c                           |  13 +-
 diff.h                           |   3 +-
 git-compat-util.h                |   1 +
 git.c                            |   2 +-
 merge-ort.c                      | 109 +++++++++++------
 merge-ort.h                      |  30 +++++
 merge-recursive.c                |   3 +-
 t/t4301-merge-tree-write-tree.sh | 204 +++++++++++++++++++++++++++++++
 usage.c                          |  14 +++
 11 files changed, 667 insertions(+), 68 deletions(-)
 create mode 100755 t/t4301-merge-tree-write-tree.sh


base-commit: ea5df61cf358d3c831189e2f04863abc2157e3e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1122%2Fnewren%2Fin-core-merge-tree-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1122/newren/in-core-merge-tree-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1122

Range-diff vs v2:

  1:  4a7cd5542bb =  1:  4a7cd5542bb merge-tree: rename merge_trees() to trivial_merge_trees()
  2:  4780ff6784d =  2:  4780ff6784d merge-tree: move logic for existing merge into new function
  3:  63f42df21ae =  3:  63f42df21ae merge-tree: add option parsing and initial shell for real merge function
  4:  02c29f920d0 =  4:  02c29f920d0 merge-tree: implement real merges
  -:  ----------- >  5:  290b42846b5 Introduce a variant of the `warning()` function that takes a `FILE *`
  5:  6fb4f4580a5 !  6:  2083fbe9b2e diff: allow diff_warn_rename_limit to write somewhere besides stdout
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    diff: allow diff_warn_rename_limit to write somewhere besides stdout
     +    diff: allow diff_warn_rename_limit to write somewhere besides stderr
      
     -    diff_warn_rename_limit() is hardcoded to write to stdout.  Make it
     -    accept an output location parameter to make it more flexible.
     +    diff_warn_rename_limit() is hardcoded to write to stderr.  Make it
     +    accept a file stream parameter to make it more flexible.
      
          Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Elijah Newren <newren@gmail.com>
     @@ diff.c: static const char rename_limit_advice[] =
      +void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc,
      +			    FILE *out)
       {
     --	fflush(stdout);
     -+	const char *fmt = NULL;
     -+
     + 	fflush(stdout);
       	if (degraded_cc)
      -		warning(_(degrade_cc_to_c_warning));
     -+		fmt = _(degrade_cc_to_c_warning);
     ++		warning_fp(out, _(degrade_cc_to_c_warning));
       	else if (needed)
      -		warning(_(rename_limit_warning));
     -+		fmt = _(rename_limit_warning);
     ++		warning_fp(out, _(rename_limit_warning));
       	else
       		return;
     ++
     ++
       	if (0 < needed)
      -		warning(_(rename_limit_advice), varname, needed);
     -+		fmt = _(rename_limit_advice);
     -+
     -+	fflush(out);
     -+	if (out == stdout)
     -+		warning(fmt, varname, needed);
     -+	else
     -+		fprintf(out, fmt, varname, needed);
     ++		warning_fp(out, _(rename_limit_advice), varname, needed);
       }
       
       static void create_filepairs_for_header_only_notifications(struct diff_options *o)
     @@ diff.c: int diff_result_code(struct diff_options *opt, int status)
       	diff_warn_rename_limit("diff.renameLimit",
       			       opt->needed_rename_limit,
      -			       opt->degraded_cc_to_c);
     -+			       opt->degraded_cc_to_c, stdout);
     ++			       opt->degraded_cc_to_c, stderr);
       	if (!opt->flags.exit_with_status &&
       	    !(opt->output_format & DIFF_FORMAT_CHECKDIFF))
       		return status;
     @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
       		/* Also include needed rename limit adjustment now */
       		diff_warn_rename_limit("merge.renamelimit",
      -				       opti->renames.needed_limit, 0);
     -+				       opti->renames.needed_limit, 0, stdout);
     ++				       opti->renames.needed_limit, 0, stderr);
       
       		trace2_region_leave("merge", "display messages", opt->repo);
       	}
     @@ merge-recursive.c: static void merge_finalize(struct merge_options *opt)
       		diff_warn_rename_limit("merge.renamelimit",
      -				       opt->priv->needed_rename_limit, 0);
      +				       opt->priv->needed_rename_limit, 0,
     -+				       stdout);
     ++				       stderr);
       	FREE_AND_NULL(opt->priv);
       }
       
  6:  28368c03898 !  7:  1be858e6aa6 merge-ort: split out a separate display_update_messages() function
     @@ merge-ort.c: static int record_conflicted_index_entries(struct merge_options *op
      +
      +	/* Also include needed rename limit adjustment now */
      +	diff_warn_rename_limit("merge.renamelimit",
     -+			       opti->renames.needed_limit, 0, stdout);
     ++			       opti->renames.needed_limit, 0, stderr);
      +
      +	trace2_region_leave("merge", "display messages", opt->repo);
      +}
     @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
      -
      -		/* Also include needed rename limit adjustment now */
      -		diff_warn_rename_limit("merge.renamelimit",
     --				       opti->renames.needed_limit, 0, stdout);
     +-				       opti->renames.needed_limit, 0, stderr);
      -
      -		trace2_region_leave("merge", "display messages", opt->repo);
      -	}
  7:  593d0c00b57 !  8:  04c3bdc44d2 merge-ort: allow update messages to be written to different file stream
     @@ Commit message
          merge-ort: allow update messages to be written to different file stream
      
          This modifies the new display_update_messages() function to allow
     -    printing to somewhere other than stdout.
     +    printing to somewhere other than stdout.  It also consolidates the
     +    location of the diff_warn_rename_limit() message with the rest of the
     +    CONFLICT and other update messages to all go to the same stream.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ merge-ort.c: void merge_display_update_messages(struct merge_options *opt,
       
       	/* Also include needed rename limit adjustment now */
       	diff_warn_rename_limit("merge.renamelimit",
     --			       opti->renames.needed_limit, 0, stdout);
     +-			       opti->renames.needed_limit, 0, stderr);
      +			       opti->renames.needed_limit, 0, stream);
       
       	trace2_region_leave("merge", "display messages", opt->repo);
  8:  d0d30e92ecd =  9:  c8ed002408d merge-tree: support including merge messages in output
  9:  9c2334ae9f2 = 10:  1c2a3f5ef63 merge-ort: provide a merge_get_conflicted_files() helper function
 10:  243134dc247 = 11:  9c2389eef0e merge-tree: provide a list of which files have conflicts
 11:  c322e4c6938 = 12:  2188a8ca1e7 merge-tree: provide easy access to `ls-files -u` style info
  -:  ----------- > 13:  52339b396fa merge-tree: allow `ls-files -u` style info to be NUL terminated
 12:  25677d5038c ! 14:  c854ecb5f4a merge-tree: add a --allow-unrelated-histories flag
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
       '
       
       test_expect_success 'Content merge and a few conflicts' '
     -@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Check conflicted oids and modes without messages' '
     - 	test_cmp conflicted-file-info actual
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'NUL terminated conflicted file "lines"' '
     + 	test_cmp expect actual
       '
       
      +test_expect_success 'error out by default for unrelated histories' '
 13:  e7c63425a0e = 15:  bc8591bbb63 git-merge-tree.txt: add a section on potentional usage mistakes

-- 
gitgitgadget
