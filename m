Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E219C433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E973206C3
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXoTySvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389108AbgFITAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgFITA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 15:00:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5319C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 12:00:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so3852380wmj.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OaneMZ7PIPhQ2Z2Jz+S8AY9apy5gj+WTgf2xx4XopDU=;
        b=sXoTySvfVF6GUgO3WRP+dRufmqyK0gJpQyEYkxu5FYhmVwj1ZBumcUjyhUAXbVHA8b
         3MG+Sjuv9aMDDoD2Ey1uAsH6m2mfcfge8Ex19c8JbZMS9ISQIUMAFH9BIHRuOeD0z23r
         Al9FHV36xLbEyFrC8tF8UOOTkR/b0qQ9YNEc0pE4o6RcP1IS2sBDslsUEQuBMlDgpe2M
         QwXOQgqJNlO4IxrrGb/BTaeBpHrNkyydyD2no/BfNNdtZbCfxYGwFWsZCeQT73rwHdFM
         dF7m2jKSZFqpTE/8Hen3nwfPcyNA9v53hbmZqPD7gzxFULRZyMrV0YQNRFuJ2s66b/lS
         FRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OaneMZ7PIPhQ2Z2Jz+S8AY9apy5gj+WTgf2xx4XopDU=;
        b=nM7VmVevdFESX7qoqQuVpl2x/g6gOll8TO0m4VEUu2sZUXpzDIUm4iYkUBFSl/VX2a
         NG6t0nzIAq2JRP7S3KZQZnkdP65nVp7TeU9dY9tHg3OYrVlcDvFrehAa8D3/PhjA72za
         THEY1cjV0zJfMiJC6z470ZAAJSvXQwilpfZWsFg9EQfTXPNDROMsd2ZLPRlu8i74qk+U
         otMabFmn2MUBnU481xwXiJ6BiI31kgMutu59ndXsFCMfajDgVCWFQuqCvMyJgAlJZdkF
         NpPskoIZ352VH9WcFqaiMEB4w3gqgBFZzD690WcOPL3JUMLKkeX5zHK3SwuECE1dU5DA
         8nfw==
X-Gm-Message-State: AOAM530c0qFZyI7eCqKGcs2Uk74jHerrCCjwdd9gwlWxV1icvNt5JK1Q
        upx0GkAynF2T0sf/SSrHxLGzDORO
X-Google-Smtp-Source: ABdhPJxy9APTF5putucTiCguCVx/JD/XfNt4XgPh+0bCkIi2qWcyMoDJUHGiabEv01Fm4D0PZmDZEg==
X-Received: by 2002:a1c:7e49:: with SMTP id z70mr4292593wmc.24.1591729225773;
        Tue, 09 Jun 2020 12:00:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y132sm3990616wmb.11.2020.06.09.12.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:00:25 -0700 (PDT)
Message-Id: <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
References: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Jun 2020 19:00:20 +0000
Subject: [PATCH v2 0/3] improve git-diff documentation and A...B handling
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
nonsensical diffs.

The first patch simply adjusts a test that will fail if the second patch is
accepted. The second patch adds special handling for the symmetric diff
syntax so that the option parsing works, plus a small test suite. The third
patch updates the documentation, including adding a section for combined
commits, and makes the help output more verbose (to match the SYNOPSIS and
provide common diff options like git-diff-files, for instance).

Changes since v1: 

 * shortened first commit's message 
 * renamed prepare function 
 * removed A..B syntax from usage (and fixed typo) 
 * added combined diff syntax to main documentation 

Note: I looked into adding special handling for rev^! syntax and
it seems a bit messy. prepare_symdiff() could do this with its
other analysis, and slide the decoded revisions around. Perhaps
better, revision.c could insert the parent refs after the child,
under control of a flag in the diff flags section of a rev_info.

Chris Torek (3):
  t/t3430: avoid undefined git diff behavior
  git diff: improve A...B merge-base handling
  Documentation: tweak git diff help slightly

 Documentation/git-diff.txt |  21 ++++--
 builtin/diff.c             | 137 ++++++++++++++++++++++++++++++++-----
 t/t3430-rebase-merges.sh   |   2 +-
 t/t4068-diff-symmetric.sh  |  81 ++++++++++++++++++++++
 4 files changed, 220 insertions(+), 21 deletions(-)
 create mode 100755 t/t4068-diff-symmetric.sh


base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-804%2Fchris3torek%2Fcleanup-diff-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-804/chris3torek/cleanup-diff-v2
Pull-Request: https://github.com/git/git/pull/804

Range-diff vs v1:

 1:  414163bbc3c ! 1:  2ccaad645ff t/t3430: avoid undocumented git diff behavior
     @@ Metadata
      Author: Chris Torek <chris.torek@gmail.com>
      
       ## Commit message ##
     -    t/t3430: avoid undocumented git diff behavior
     +    t/t3430: avoid undefined git diff behavior
      
     -    According to the documentation, "git diff" takes at most two commit-ish,
     -    or an A..B style range, or an A...B style symmetric difference range.
     -    The autosquash-and-exec test relied on "git diff HEAD^!", which works
     -    fine for ordinary commits as the revision parse produces two commit-ish,
     -    namely ^HEAD^ and HEAD.
     -
     -    For merge commits, however, this test makes use of an undocumented
     -    feature: the resulting revision parse has all the parents as UNINTERESTING
     -    followed by the HEAD commit.  This looks identical to a symmetric
     -    diff parse, which lists the merge bases as UNINTERESTING, followed by
     -    the A (UNINTERESTING) and B revs.  So the diff winds up treating it
     -    as one, using the first oid (i.e., HEAD^) and the last (i.e., HEAD).
     -    The documentation, however, says nothing about this usage.
     -
     -    Since diff actually just uses HEAD^ and HEAD, call for these directly
     -    here.  That makes it possible to improve the diff code's handling of
     -    symmetric difference arguments.
     +    The autosquash-and-exec test used "git diff HEAD^!" to mean
     +    "git diff HEAD^ HEAD".  Use these directly instead of relying
     +    on the undefined but actual-current behavior of "HEAD^!".
      
          Signed-off-by: Chris Torek <chris.torek@gmail.com>
      
 2:  f7c8f094e02 ! 2:  100fa403477 git diff: improve A...B merge-base handling
     @@ builtin/diff.c: static int builtin_diff_files(struct rev_info *revs, int argc, c
      + * If the user provides a symmetric diff with no merge base, or
      + * more than one range, we do a usage-exit.
      + */
     -+static void builtin_diff_symdiff(struct rev_info *rev, struct symdiff *sym)
     ++static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
      +{
      +	int i, lcount = 0, rcount = 0, basecount = 0;
      +	int lpos = -1, rpos = -1, basepos = -1;
     @@ builtin/diff.c: int cmd_diff(int argc, const char **argv, const char *prefix)
       		}
       	}
       
     -+	builtin_diff_symdiff(&rev, &sdiff);
     ++	symdiff_prepare(&rev, &sdiff);
       	for (i = 0; i < rev.pending.nr; i++) {
       		struct object_array_entry *entry = &rev.pending.objects[i];
       		struct object *obj = entry->item;
 3:  9318365915c ! 3:  b9b4c6f113d Documentation: tweak git diff help slightly
     @@ Metadata
       ## Commit message ##
          Documentation: tweak git diff help slightly
      
     -    Update the manual page synopsis to include the two and three
     -    dot notation.
     +    Update the manual page synopsis to include the three-dot notation
     +    and the combined-diff option
      
          Make "git diff -h" print the same usage summary as the manual
     -    page synopsis.
     +    page synopsis, minus the "A..B" form, which is now discouraged.
     +
     +    Document the usage for producing combined commits.
      
          Signed-off-by: Chris Torek <chris.torek@gmail.com>
      
       ## Documentation/git-diff.txt ##
      @@ Documentation/git-diff.txt: SYNOPSIS
     + [verse]
       'git diff' [<options>] [<commit>] [--] [<path>...]
       'git diff' [<options>] --cached [<commit>] [--] [<path>...]
     - 'git diff' [<options>] <commit> <commit> [--] [<path>...]
     -+'git diff' [<options>] <commit>..<commit> [--] [<path>...]
     +-'git diff' [<options>] <commit> <commit> [--] [<path>...]
     ++'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]
      +'git diff' [<options>] <commit>...<commit> [--] [<path>...]
       'git diff' [<options>] <blob> <blob>
       'git diff' [<options>] --no-index [--] <path> <path>
       
     + DESCRIPTION
     + -----------
     + Show changes between the working tree and the index or a tree, changes
     +-between the index and a tree, changes between two trees, changes between
     +-two blob objects, or changes between two files on disk.
     ++between the index and a tree, changes between two trees, changes resulting
     ++from a merge, changes between two blob objects, or changes between two
     ++files on disk.
     + 
     + 'git diff' [<options>] [--] [<path>...]::
     + 
     +@@ Documentation/git-diff.txt: two blob objects, or changes between two files on disk.
     + 	one side is omitted, it will have the same effect as
     + 	using HEAD instead.
     + 
     ++'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]::
     ++
     ++	This form is to view the results of a merge commit.  The first
     ++	listed <commit> must be the merge itself; the remaining two or
     ++	more commits should be its parents.  A convenient way to produce
     ++	the desired set of revisions is to use the {caret}@ suffix, i.e.,
     ++	"git diff master master^@".  This is equivalent to running "git
     ++	show --format=" on the merge commit, e.g., "git show --format=
     ++	master".
     ++
     + 'git diff' [<options>] <commit>\...<commit> [--] [<path>...]::
     + 
     + 	This form is to view the changes on the branch containing
     +@@ Documentation/git-diff.txt: linkgit:git-difftool[1],
     + linkgit:git-log[1],
     + linkgit:gitdiffcore[7],
     + linkgit:git-format-patch[1],
     +-linkgit:git-apply[1]
     ++linkgit:git-apply[1],
     ++linkgit:git-show[1]
     + 
     + GIT
     + ---
      
       ## builtin/diff.c ##
      @@
     @@ builtin/diff.c
      -"git diff [<options>] [<commit> [<commit>]] [--] [<path>...]";
      +"git diff [<options>] [<commit>] [--] [<path>...]\n"
      +"   or: git diff [<options>] --cached [<commit>] [--] [<path>...]\n"
     -+"   or: git diff [<options>] <commit> <commit>] [--] [<path>...]\n"
     -+"   or: git diff [<options>] <commit>..<commit>] [--] [<path>...]\n"
     ++"   or: git diff [<options>] <commit> [<commit>...] <commit> [--] [<path>...]\n"
      +"   or: git diff [<options>] <commit>...<commit>] [--] [<path>...]\n"
      +"   or: git diff [<options>] <blob> <blob>]\n"
      +"   or: git diff [<options>] --no-index [--] <path> <path>]\n"

-- 
gitgitgadget
