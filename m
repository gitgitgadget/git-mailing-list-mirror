Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D781C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 17:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbiAER1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiAER1i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 12:27:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A879C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 09:27:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o3so26308852wrh.10
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 09:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tJtUhCESPzvYeQZspPigwSonsYE4EL+q5IkDGNAUvI0=;
        b=SefpTg31BNyRH1kXD6CmOwpMmE3RdXSNw2EMZOsHhk+VOBJ4TiO2HLKB1EkJiiRbMm
         0zssAXRbncgX3cloX/VH24Xm6TIkLAa4xxZRu/dQskVWv3/9IXU93KESQz2SRpi3J7Vs
         vOog0Uqzhsjkp7bL8GWyDOojavSo6vozT7r/VYf3IeDPhSgC7SZApdYZcEdnbcGohUXV
         ZHkjwat4jbhunaz75KzT95fMRBGUZtH6103o2lRqp69tCxgum/wP7oOa+StTPUyPhnyw
         I7yg5ALhYJgJJn2Q0PXpgui3r9IARuzbS4Om3N1+rCSZXUKHFhkFy9Dcz3Aj2z3tvDEE
         JXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tJtUhCESPzvYeQZspPigwSonsYE4EL+q5IkDGNAUvI0=;
        b=aCV0bF0kODfU2nnehhAyJCcZ8WzIBeHOFNToX0P3MU8K5mUWgrfW25/biQw6S8VETJ
         amN711xxElNiNwQCcXj9tV08ikGfpCSOUQ7ayu521jR1ulL1lJyLPbU2TpgfSKGm6BTm
         ftTHGIjYp34GWnrUm7x2clkXtfgH+Zk3C4oa7kli25TWbdbQChfy6glcXhr1OMgHQ4Sf
         lKrIBXRLRcAKBHBz02i8HKTNQK5ZbaJ7vBsTK11FCm1Dp9hJ7cw1k4yNBzw1yn5vbhTd
         GCvHNWCTrbysA1cpR7xbe62IJ+e4TKl0TUxYNcmd5PPI1IxqCGFpbQKALS6Z+WScvDtu
         CxQw==
X-Gm-Message-State: AOAM5337v14+E/+gvjn6iH0BE3+m2g/l9wSwa2C906BHSNh+flet68bY
        mZB746jz77r5kHmT4SSzn3QexvNN7qA=
X-Google-Smtp-Source: ABdhPJwATURzXTnYxA2XljP9j+Z+WnfILAu5m1fuqj4XITPKj5sIE54udHtqKdp8MPm5ejCNL3kMiQ==
X-Received: by 2002:a5d:58d8:: with SMTP id o24mr26506187wrf.467.1641403656672;
        Wed, 05 Jan 2022 09:27:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b5sm11564816wrr.19.2022.01.05.09.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:27:36 -0800 (PST)
Message-Id: <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 17:27:27 +0000
Subject: [PATCH v2 0/8] RFC: Server side merges (no ref updating, no commit creating, no touching
 worktree or index)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(NOTE for Junio: This series has a minor conflict with en/remerge-diff --
this series moves a code block into a new function, but en/remerge-diff adds
a BUG() message to that code block. But this series is just RFC, so you may
want to wait to pick it up.)

Updates since v1:

 * Fixed a bad patch splitting, and a style issue pointed out by Johannes
   Altimanninger
 * Fixed misleading commit messages in new test cases
 * Fixed my comments about how commit-tree could be used to correctly use
   two -p flags

NOTE2: A preliminary version of this series was discussed here:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211147490.56@tvgsbejvaqbjf.bet/

NOTE3: An alternative has been implemented by Christian, over here:
https://lore.kernel.org/git/20220105163324.73369-1-chriscool@tuxfamily.org/

This series introduces a new option to git-merge-tree: --real (best name I
could come up with). This new option is designed to allow a server-side
"real" merge (or allow folks client-side to do merges with branches they
don't even have checked out). Real merges differ from trivial merges in that
they handle:

 * three way content merges
 * recursive ancestor consolidation
 * renames
 * proper directory/file conflict handling
 * etc.

The reason this is different from merge is that merge-tree does NOT:

 * Read/write/update any working tree (and assumes there probably isn't one)
 * Read/write/update any index (and assumes there probably isn't one)
 * Create a commit object
 * Update any refs

This series attempts to guess what kind of output would be wanted, basically
choosing:

 * clean merge or conflict signalled via exit status
 * stdout consists solely of printing the hash of the resulting tree (though
   that tree may include files that have conflict markers)
 * new optional --messages flag for specifying a file where informational
   messages (e.g. conflict notices and files involved in three-way-content
   merges) can be written; by default, this output is simply discarded
 * new optional --conflicted-list flag for specifying a file where the names
   of conflicted-files can be written in a NUL-character-separated list

This design means it's basically just a low-level tool that other scripts
would use and do additional work with. Perhaps something like this:

   NEWTREE=$(git merge-tree --real $BRANCH1 $BRANCH2)
   test $? -eq 0 || die "There were conflicts..."
   NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
   git update-ref $BRANCH1 $NEWCOMMIT


Elijah Newren (8):
  merge-tree: rename merge_trees() to trivial_merge_trees()
  merge-tree: move logic for existing merge into new function
  merge-tree: add option parsing and initial shell for real merge
    function
  merge-tree: implement real merges
  merge-ort: split out a separate display_update_messages() function
  merge-ort: allow update messages to be written to different file
    stream
  merge-tree: support saving merge messages to a separate file
  merge-tree: provide an easy way to access which files have conflicts

 Documentation/git-merge-tree.txt |  32 +++++--
 builtin/merge-tree.c             | 151 ++++++++++++++++++++++++++++---
 git.c                            |   2 +-
 merge-ort.c                      |  85 ++++++++++-------
 merge-ort.h                      |  12 +++
 t/t4301-merge-tree-real.sh       | 108 ++++++++++++++++++++++
 6 files changed, 333 insertions(+), 57 deletions(-)
 create mode 100755 t/t4301-merge-tree-real.sh


base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1114%2Fnewren%2Fmerge-into-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1114/newren/merge-into-v2
Pull-Request: https://github.com/git/git/pull/1114

Range-diff vs v1:

 1:  a7c7910d834 = 1:  a7c7910d834 merge-tree: rename merge_trees() to trivial_merge_trees()
 2:  9da8e77c1d7 ! 2:  aafe67d7c69 merge-tree: move logic for existing merge into new function
     @@ builtin/merge-tree.c: static void *get_tree_descriptor(struct repository *r,
       }
       
      -int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     --{
     -+static int trivial_merge(int argc, const char **argv) {
     ++static int trivial_merge(int argc, const char **argv)
     + {
       	struct repository *r = the_repository;
       	struct tree_desc t[3];
       	void *buf1, *buf2, *buf3;
 3:  9d03d3f56ab ! 3:  ee21aed0115 merge-tree: add option parsing and initial shell for real merge function
     @@ builtin/merge-tree.c: static void *get_tree_descriptor(struct repository *r,
       	return buf;
       }
       
     --static int trivial_merge(int argc, const char **argv) {
     +-static int trivial_merge(int argc, const char **argv)
      +static int trivial_merge(const char *base,
      +			 const char *branch1,
     -+			 const char *branch2) {
     ++			 const char *branch2)
     + {
       	struct repository *r = the_repository;
       	struct tree_desc t[3];
       	void *buf1, *buf2, *buf3;
     @@ builtin/merge-tree.c: static void *get_tree_descriptor(struct repository *r,
       	trivial_merge_trees(t, "");
       	free(buf1);
       	free(buf2);
     -@@ builtin/merge-tree.c: static int trivial_merge(int argc, const char **argv) {
     +@@ builtin/merge-tree.c: static int trivial_merge(int argc, const char **argv)
       	return 0;
       }
       
 4:  9fc71f4511b ! 4:  1710ba4a9e4 merge-tree: implement real merges
     @@ Commit message
      
             NEWTREE=$(git merge-tree --real $BRANCH1 $BRANCH2)
             test $? -eq 0 || die "There were conflicts..."
     -       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 $BRANCH2)
     +       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
             git update-ref $BRANCH1 $NEWCOMMIT
      
          Note that higher level scripts may also want to access the
     @@ t/t4301-merge-tree-real.sh (new)
      +	echo hi >greeting &&
      +	echo bar >whatever &&
      +	git add numbers greeting whatever &&
     -+	git commit -m rename-and-modify &&
     ++	git commit -m modify-stuff &&
      +
      +	git checkout side2 &&
      +	test_write_lines 0 1 2 3 4 5 >numbers &&
     @@ t/t4301-merge-tree-real.sh (new)
      +	mkdir whatever &&
      +	>whatever/empty &&
      +	git add numbers greeting whatever/empty &&
     -+	git commit -m remove-and-rename
     ++	git commit -m other-modifications
      +'
      +
      +test_expect_success 'Content merge and a few conflicts' '
 5:  aa816e766e9 ! 5:  bc6d01f1a0e merge-ort: split out a separate display_update_messages() function
     @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
      -
      -		trace2_region_leave("merge", "display messages", opt->repo);
      -	}
     ++	if (display_update_msgs)
     ++		merge_display_update_messages(opt, result);
       
       	merge_finalize(opt, result);
       }
 6:  32ad5b5c10d ! 6:  c9e95a70d19 merge-ort: allow update messages to be written to different file stream
     @@ merge-ort.c: void merge_display_update_messages(struct merge_options *opt,
       	string_list_clear(&olist, 0);
       
      @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
     - 		trace2_region_leave("merge", "write_auto_merge", opt->repo);
       	}
       
     -+	if (display_update_msgs)
     + 	if (display_update_msgs)
     +-		merge_display_update_messages(opt, result);
      +		merge_display_update_messages(opt, result, stdout);
       
       	merge_finalize(opt, result);
 7:  777de92d9f1 = 7:  4b513a6d696 merge-tree: support saving merge messages to a separate file
 8:  1d24a4f4070 = 8:  01364bb020e merge-tree: provide an easy way to access which files have conflicts

-- 
gitgitgadget
