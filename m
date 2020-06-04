Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184E8C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 08:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCCED207D3
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 08:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah4ulS0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFDIRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgFDIRk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 04:17:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BE7C03E96D
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 01:17:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so5025231wru.12
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 01:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yGFOHnKfKRbCRfWDcQ2weNeGPvC7T+qbd27mGLR5jiA=;
        b=ah4ulS0By3A4rfrbxkzRu8AKvcmOwwEX4tNyAWEwO8E+vrgyPN5NlpLq9/RgBlg6W/
         x/Ph452uYd8mue2fQ1y6VYYP2OROQ6iT5x2Mi1YbAR9a7AvmEJTUe2DcdUtb9q3Rabeq
         p+1giAwgvS4eWqMKuEFajiIOrNae0nF6oPoOKV707SQWrV3VSFEjHT8NTL4P+9fp0OqW
         L7OBJmJ126xxE/Gkaxmgve7DfFQZjp9cT69JN7ExMrIAErgSEPhjaIac8RvbJ4wgsOfY
         ZxlHtlv03npMWcrY6qmibf3XlUF8lqVbxH2GXuPYf8QIJe5aOMmAJLXgFl8DefEbIbk3
         izRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yGFOHnKfKRbCRfWDcQ2weNeGPvC7T+qbd27mGLR5jiA=;
        b=makvIAGupT0OMFYr1ib8XiyGwMn+o5l7DOXLYn6SahVoi8yivZ1QzL8sTHSlrNjWU1
         W1XX/zD9dr9H+RTcPv0nj9pMm9irF3/uF4IkACgTN88t0imeiXjh6JKAZgRv/A10QdMG
         vVoD1djhqjL44MI+fsIIG8geqzoLhabuy77/bJTQL5EKU05FIeukoVbLMog8j0YQzh5X
         zFns3WpPpkbLEecggedJdYd7hKJt3drhx6YaijcRyWsk0T/7TwsJ+CBNGta7rw3zQ94I
         ea0eGjMXDp6SGLBIpPx1IDauATFRX8V1+8IQb/aIpfNq4u3bgVb6xivj3+xkV4eJyJ39
         rVdg==
X-Gm-Message-State: AOAM532tlCWeRRQeystGYsuaDuVR9cwtkGmbibN5lDitETsmxq1ElD/W
        EYId0K1Y5wGz2tNyE6do+uaJpmWU
X-Google-Smtp-Source: ABdhPJxA1FkgbBrb3G2dmpzE3q/S2ifzCAjUozpLqbh+XLU7P7xR9Z1U6yVmlK9zIDPxi9dr9SddSg==
X-Received: by 2002:adf:ed01:: with SMTP id a1mr3438684wro.271.1591258659002;
        Thu, 04 Jun 2020 01:17:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm7004541wrm.96.2020.06.04.01.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:17:38 -0700 (PDT)
Message-Id: <pull.801.git.git.1591258657818.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Jun 2020 08:17:37 +0000
Subject: [PATCH] sparse-checkout: avoid staging deletions of all files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     warmsocks@gmail.com, stolee@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

sparse-checkout's purpose is to update the working tree to have it
reflect a subset of the tracked files.  As such, it shouldn't be
switching branches, making commits, downloading or uploading data, or
staging or unstaging changes.  Other than updating the worktree, the
only thing sparse-checkout should touch is the SKIP_WORKTREE bit of the
index.  In particular, this sets up a nice invariant: running
sparse-checkout will never change the status of any file in `git status`
(reflecting the fact that we only set the SKIP_WORKTREE bit if the file
is safe to delete, i.e. if the file is unmodified).

Traditionally, we did a _really_ bad job with this goal.  The
predecessor to sparse-checkout involved manual editing of
.git/info/sparse-checkout and running `git read-tree -mu HEAD`.  That
command would stage and unstage changes and overwrite dirty changes in
the working tree.

The initial implementation of the sparse-checkout command was no better;
it simply invoked `git read-tree -mu HEAD` as a subprocess and had the
same caveats, though this issue came up repeatedly in review comments
and workarounds for the problems were put in place before the feature
was merged[1, 2, 3, 4, 5, 6; especially see 4 & 6].

[1] https://lore.kernel.org/git/CABPp-BFT9A5n=_bx5LsjCvbogqwSjiwgr5amcjgbU1iAk4KLJg@mail.gmail.com/
[2] https://lore.kernel.org/git/CABPp-BEmwSwg4tgJg6nVG8a3Hpn_g-=ZjApZF4EiJO+qVgu4uw@mail.gmail.com/
[3] https://lore.kernel.org/git/CABPp-BFV7TA0qwZCQpHCqx9N+JifyRyuBQ-pZ_oGfe-NOgyh7A@mail.gmail.com/
[4] https://lore.kernel.org/git/CABPp-BHYCCD+Vx5fq35jH82eHc1-P53Lz_aGNpHJNcx9kg2K-A@mail.gmail.com/
[5] https://lore.kernel.org/git/CABPp-BF+JWYZfDqp2Tn4AEKVp4b0YMA=Mbz4Nz62D-gGgiduYQ@mail.gmail.com/
[6] https://lore.kernel.org/git/20191121163706.GV23183@szeder.dev/

However, these workarounds, in addition to disabling the feature in a
number of important cases, also missed one special case.  I'll get back
to it later.

In the 2.27.0 cycle, the disabling of the feature was lifted by finally
replacing the internal equivalent of `git read-tree -mu HEAD` with
something that did what we wanted: the new update_sparsity() function in
unpack-trees.c that only ever updates SKIP_WORKTREE bits in the index
and updates the working tree to match.  This new function handles all
the cases that were problematic for the old implementation, except that
it breaks the same special case that avoided the workarounds of the old
implementation, but broke it in a different way.

So...that brings us to the special case: a git clone performed with
--no-checkout.  As per the meaning of the flag, --no-checkout does not
check out any branch, with the implication that you aren't on one and
need to switch to one after the clone.  Implementationally, HEAD is
still set (so in some sense you are partially on a branch), but
  * the index is "unborn" (non-existent)
  * there are no files in the working tree (other than .git/)
  * the next time git switch (or git checkout) is run it will run
    unpack_trees with `initial_checkout` flag set to true.
It is not until you run, e.g. `git switch <somebranch>` that the index
will be written and files in the working tree populated.

With this special --no-checkout case, the traditional `read-tree -mu
HEAD` behavior would have done the equivalent of acting like checkout --
switch to the default branch (HEAD), write out an index that matches
HEAD, and update the working tree to match.  This special case slipped
through the avoid-making-changes checks in the original sparse-checkout
command and thus continued there.

After update_sparsity() was introduced and used (see commit f56f31af03
("sparse-checkout: use new update_sparsity() function", 2020-03-27)),
the behavior for the --no-checkout case changed:  Due to git's
auto-vivification of an empty in-memory index (see do_read_index() and
note that `must_exist` is false), and due to sparse-checkout's
update_working_directory() code to always write out the index after it
was done, we got a new bug.  That made it so that sparse-checkout would
switch the repository from a clone with an "unborn" index (i.e. still
needing an initial_checkout), to one that had a recorded index with no
entries.  Thus, instead of all the files appearing deleted in `git
status` being known to git as a special artifact of not yet being on a
branch, our recording of an empty index made it suddenly look to git as
though it was definitely on a branch with ALL files staged for deletion!
A subsequent checkout or switch then had to contend with the fact that
it wasn't on an initial_checkout but had a bunch of staged deletions.

Make sure that sparse-checkout changes nothing in the index other than
the SKIP_WORKTREE bit; in particular, when the index is unborn we do not
have any branch checked out so there is no sparsification or
de-sparsification work to do.  Simply return from
update_working_directory() early.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    sparse-checkout: avoid staging deletions of all files

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-801%2Fnewren%2Fsparse-checkout-and-unborn-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-801/newren/sparse-checkout-and-unborn-index-v1
Pull-Request: https://github.com/git/git/pull/801

 builtin/sparse-checkout.c          |  4 ++++
 t/t1091-sparse-checkout-builtin.sh | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 95d08824172..595463be68e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -99,6 +99,10 @@ static int update_working_directory(struct pattern_list *pl)
 	struct lock_file lock_file = LOCK_INIT;
 	struct repository *r = the_repository;
 
+	/* If no branch has been checked out, there are no updates to make. */
+	if (is_index_unborn(r->index))
+		return UPDATE_SPARSITY_SUCCESS;
+
 	memset(&o, 0, sizeof(o));
 	o.verbose_update = isatty(2);
 	o.update = 1;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 88cdde255cd..bc287e5c1fa 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -100,6 +100,25 @@ test_expect_success 'clone --sparse' '
 	check_files clone a
 '
 
+test_expect_success 'interaction with clone --no-checkout (unborn index)' '
+	git clone --no-checkout "file://$(pwd)/repo" clone_no_checkout &&
+	git -C clone_no_checkout sparse-checkout init --cone &&
+	git -C clone_no_checkout sparse-checkout set folder1 &&
+	git -C clone_no_checkout sparse-checkout list >actual &&
+	cat >expect <<-\EOF &&
+	folder1
+	EOF
+	test_cmp expect actual &&
+	ls clone_no_checkout >actual &&
+	test_must_be_empty actual &&
+	test_path_is_missing clone_no_checkout/.git/index &&
+
+	# No branch is checked out until we manually switch to one
+	git -C clone_no_checkout switch master &&
+	test_path_is_file clone_no_checkout/.git/index &&
+	check_files clone_no_checkout a folder1
+'
+
 test_expect_success 'set enables config' '
 	git init empty-config &&
 	(

base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
-- 
gitgitgadget
