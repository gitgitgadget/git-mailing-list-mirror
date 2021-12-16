Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63C5C4332F
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 16:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbhLPQXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbhLPQXN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 11:23:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933E3C06173E
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 08:23:12 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so1673083wmb.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 08:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PrSRsHx6Dl2jORNxCp7ProIyhCq/sbaFdwM4lKjJ7OM=;
        b=hRAYyQy3xHFWX5FXX5e1uU4i7GLRDh6Nr1mANuIrruTzdG6yqMcfm3JSsmw3IeKc/k
         xritFq7ywJGZgE7xOCLr3EPQKwqk3Lj2k4MjDFOwkd2mZODFrZZkkUvI4yY7tUTwLT7M
         ZVdea4eQbA5ptylnuyN3oX1PcNE4/J/5T0Kt8JU83ZE/gpZgCf8yGJ4cZMVRUqdqpfQb
         3LBFNzpZNbU6Upb+aIvmR349xZhOUODAbTj5XIuLPwM1qe+sBhLm2NyzJ0sypnXQXQuy
         1D17zi/kNMt73XY4OcH1cEAq2QxYRlE7c18ENQGMXQH90/atjtGsaRdI6xy16y7SuQkg
         zVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PrSRsHx6Dl2jORNxCp7ProIyhCq/sbaFdwM4lKjJ7OM=;
        b=27z39ayDF3zYd0NyYkdnW78gKO5+DVvVwZ1hKGAzKGD75TosJ3lytacKc/e/iwULDC
         23T3H8x3DJ4yZb9z5VGQpXr5xfDcmE7ld3VV4wjj4jR2dtez11cAFp4jIYo/rMOYZTxG
         /KgQDkY33lukyrW3kbHuoqftqJIlowTbV90cHSY+L7BstI51vt/DrlMxJidXND4GuEtV
         yt0gOry20HP3SI8YSW+PXZsXQidrYtB19q2T8TAojvh5YePasiZgkXAFs/x/wN5iMNsP
         6h2M1DEddbzMsxNxhMxZ6BLBf0G6FXqQejErG0rQZvfa6pkkkkinG4bqNyIAHT71w+Xh
         Pdig==
X-Gm-Message-State: AOAM530VYc/Cxs3JKYIPjLhPJjHGpNVmkI0YWyKj+E2g40YJ+q5MLv0M
        33SyFOkknnS5s9Yfz7CGalVD0GwHjwY=
X-Google-Smtp-Source: ABdhPJyAKbO5KYfUo3ySYRSfhNRFN6vDCOsL0NuWSR3vzKHnxY8A3wh2C8/fiBSGgEXnrQbwBfekaw==
X-Received: by 2002:a7b:cf0a:: with SMTP id l10mr3886093wmg.36.1639671790610;
        Thu, 16 Dec 2021 08:23:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm5099194wrb.2.2021.12.16.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:23:09 -0800 (PST)
Message-Id: <pull.1084.v3.git.1639671789279.gitgitgadget@gmail.com>
In-Reply-To: <pull.1084.v2.git.1639037637231.gitgitgadget@gmail.com>
References: <pull.1084.v2.git.1639037637231.gitgitgadget@gmail.com>
From:   "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Dec 2021 16:23:09 +0000
Subject: [PATCH v3] fast-export: fix surprising behavior with --first-parent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>,
        William Sprent <williams@unity3d.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Sprent <williams@unity3d.com>

The revision traversal machinery typically processes and returns all
children before any parent.  fast-export needs to operate in the
reverse fashion, handling parents before any of their children in
order to build up the history starting from the root commit(s).  This
would be a clear case where we could just use the revision traversal
machinery's "reverse" option to achieve this desired affect.

However, this wasn't what the code did.  It added its own array for
queuing.  The obvious hand-rolled solution would be to just push all
the commits into the array and then traverse afterwards, but it didn't
quite do that either.  It instead attempted to process anything it
could as soon as it could, and once it could, check whether it could
process anything that had been queued.  As far as I can tell, this was
an effort to save a little memory in the case of multiple root commits
since it could process some commits before queueing all of them.  This
involved some helper functions named has_unshown_parent() and
handle_tail().  For typical invocations of fast-export, this
alternative essentially amounted to a hand-rolled method of reversing
the commits -- it was a bunch of work to duplicate the revision
traversal machinery's "reverse" option.

This hand-rolled reversing mechanism is actually somewhat difficult to
reason about.  It takes some time to figure out how it ensures in
normal cases that it will actually process all traversed commits
(rather than just dropping some and not printing anything for them).

And it turns out there are some cases where the code does drop commits
without handling them, and not even printing an error or warning for
the user.  Due to the has_unshown_parent() checks, some commits could
be left in the array at the end of the "while...get_revision()" loop
which would be unprocessed.  This could be triggered for example with
    git fast-export main -- --first-parent
or non-sensical traversal rules such as
    git fast-export main -- --grep=Merge --invert-grep

While most traversals that don't include all parents should likely
trigger errors in fast-export (or at least require being used in
combination with --reference-excluded-parents), the --first-parent
traversal is at least reasonable and it'd be nice if it didn't just drop
commits. It'd also be nice for future readers of the code to have a
simpler "reverse traversal" mechanism. Use the "reverse" option of the
revision traversal machinery to achieve both.

Even for the non-sensical traversal flags like the --grep one above,
this would be an improvement. For example, in that case, the code
previously would have silently truncated history to only those commits
that do not have an ancestor containing "Merge" in their commit message.
After this code change, that case would include all commits without
"Merge" in their commit message -- but any commit that previously had a
"Merge"-mentioning parent would lose that parent
(likely resulting in many new root commits). While the new behavior is
still odd, it is at least understandable given that
--reference-excluded-parents is not the default.

Signed-off-by: William Sprent <williams@unity3d.com>
---
    fast-export: fix surprising behavior with --first-parent
    
    Hi,
    
    Here's a revised version of my previously submitted patch regarding
    fast-export and how it reacts to the --first-parent flag.
    
    Changes since v2:
    
     * Changed commit message to include the detailed description of the
       problem area as suggested by Elijah. I went back and forth with my
       self about whether the message needs some "lead in", but it ended up
       getting long without adding much.
     * Cleaned up test such that the comparison with the --reverse output is
       just below where it is generated.
     * In test, moved all usages of --no-ff to just after 'git merge' .
     * In test, replaced long 'git rev-list' incantation with simpler 'git
       log' format.
    
    Changes since v1:
    
     * Moved revs.reverse assignment down to similar assignments below.
     * Removed braces around single statement while loop.
     * The test now only changes directory inside a sub-shell.
     * Applied stylistic feedback on test such as: making redirections be on
       the form >FILE etc.
    
    There were questions raised about whether it makes sense at all for
    fast-export to simply accept all git rev-list arguments whether they
    have an effect or not - in particular for a flag like --reverse. I think
    I agree that it is questionable behavior, or at least questionably
    documented, but I also think it is out of scope for this change.
    
    I did consider teaching fast-export to complain if given --reverse, but
    it seemed inconsistent to me as it will gladly accept every other
    rev-list argument (for example, "git fast-export HEAD --show-signature
    --graph" works just fine).
    
    Original Message: I've noticed that git fast-export exhibits some odd
    behavior when passed the --first-parent flag. In the repository I was
    working on, it would only output the initial commit before exiting.
    Moreover, adding the --reverse flag causes it to behave differently and
    instead output all commits in the first parent line that only have one
    parent. My expectation is more or less that git fast-export should
    output the same set of commits as git rev-list would output given the
    same arguments, which matches how it acts when given revision ranges.
    
    It seems like this behavior comes from the fact that has_unshown_parents
    will never be false for any merge commits encountered when fast-export
    is called with --first-parent. This causes the while loop to follow the
    pattern of pushing all commits into the "commits" queue until the
    initial commit is encountered, at which point it calls handle_tail which
    falls through on the first merge commit, causing most of the commits to
    be unhandled.
    
    My impression is that this logic only serves to ensure that parents are
    processed before their children, so in my patch I've opted to fix the
    issue by delegating that responsibility to revision.c by adding the
    reverse flag before performing the revision walk. From what I can see,
    this should be equivalent to what the previous logic is trying to
    achieve, but I can also see that there could be risk in these changes.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1084%2Fwilliams-unity%2Ffast-export%2Ffirst-parent-issues-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1084/williams-unity/fast-export/first-parent-issues-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1084

Range-diff vs v2:

 1:  af552f37dbe ! 1:  312255260b1 fast-export: fix surprising behavior with --first-parent
     @@ Metadata
       ## Commit message ##
          fast-export: fix surprising behavior with --first-parent
      
     -    When invoking git-fast-export with the --first-parent flag on a branch
     -    with merges, fast-export would early-out on processing the first merge
     -    on the branch. If combined with --reverse, fast-export would instead
     -    output all single parent commits on the branch.
     +    The revision traversal machinery typically processes and returns all
     +    children before any parent.  fast-export needs to operate in the
     +    reverse fashion, handling parents before any of their children in
     +    order to build up the history starting from the root commit(s).  This
     +    would be a clear case where we could just use the revision traversal
     +    machinery's "reverse" option to achieve this desired affect.
      
     -    This commit makes fast-export output the same commits as rev-list
     -    --first-parent, and makes --reverse not have an effect on which commits
     -    are output.
     +    However, this wasn't what the code did.  It added its own array for
     +    queuing.  The obvious hand-rolled solution would be to just push all
     +    the commits into the array and then traverse afterwards, but it didn't
     +    quite do that either.  It instead attempted to process anything it
     +    could as soon as it could, and once it could, check whether it could
     +    process anything that had been queued.  As far as I can tell, this was
     +    an effort to save a little memory in the case of multiple root commits
     +    since it could process some commits before queueing all of them.  This
     +    involved some helper functions named has_unshown_parent() and
     +    handle_tail().  For typical invocations of fast-export, this
     +    alternative essentially amounted to a hand-rolled method of reversing
     +    the commits -- it was a bunch of work to duplicate the revision
     +    traversal machinery's "reverse" option.
      
     -    The fix involves removing logic within fast-export which was responsible
     -    for ensuring that parents are processed before their children, which was
     -    what was exiting early due to missing second parents. This is replaced
     -    by setting 'reverse = 1' before revision walking, which, in conjuction
     -    with topo_order, allows for delegating the ordering of commits to
     -    revision.c. The reverse flag is set after parsing rev-list arguments to
     -    avoid having it disabled.
     +    This hand-rolled reversing mechanism is actually somewhat difficult to
     +    reason about.  It takes some time to figure out how it ensures in
     +    normal cases that it will actually process all traversed commits
     +    (rather than just dropping some and not printing anything for them).
     +
     +    And it turns out there are some cases where the code does drop commits
     +    without handling them, and not even printing an error or warning for
     +    the user.  Due to the has_unshown_parent() checks, some commits could
     +    be left in the array at the end of the "while...get_revision()" loop
     +    which would be unprocessed.  This could be triggered for example with
     +        git fast-export main -- --first-parent
     +    or non-sensical traversal rules such as
     +        git fast-export main -- --grep=Merge --invert-grep
     +
     +    While most traversals that don't include all parents should likely
     +    trigger errors in fast-export (or at least require being used in
     +    combination with --reference-excluded-parents), the --first-parent
     +    traversal is at least reasonable and it'd be nice if it didn't just drop
     +    commits. It'd also be nice for future readers of the code to have a
     +    simpler "reverse traversal" mechanism. Use the "reverse" option of the
     +    revision traversal machinery to achieve both.
     +
     +    Even for the non-sensical traversal flags like the --grep one above,
     +    this would be an improvement. For example, in that case, the code
     +    previously would have silently truncated history to only those commits
     +    that do not have an ancestor containing "Merge" in their commit message.
     +    After this code change, that case would include all commits without
     +    "Merge" in their commit message -- but any commit that previously had a
     +    "Merge"-mentioning parent would lose that parent
     +    (likely resulting in many new root commits). While the new behavior is
     +    still odd, it is at least understandable given that
     +    --reference-excluded-parents is not the default.
      
          Signed-off-by: William Sprent <williams@unity3d.com>
      
     @@ t/t9350-fast-export.sh: test_expect_success 'merge commit gets exported with --i
      +		git checkout -b topic1 &&
      +		test_commit B &&
      +		git checkout main &&
     -+		git merge topic1 --no-ff &&
     ++		git merge --no-ff topic1 &&
      +
      +		git checkout -b topic2 &&
      +		test_commit C &&
      +		git checkout main &&
     -+		git merge topic2 --no-ff &&
     ++		git merge --no-ff topic2 &&
      +
      +		test_commit D &&
      +
     -+		git rev-list --format="%ad%B" --first-parent --topo-order --no-commit-header main >expected &&
     -+
      +		git fast-export main -- --first-parent >first-parent-export &&
      +		git fast-export main -- --first-parent --reverse >first-parent-reverse-export &&
     ++		test_cmp first-parent-export first-parent-reverse-export &&
      +
      +		git init import &&
      +		git -C import fast-import <first-parent-export &&
      +
     -+		git -C import rev-list --format="%ad%B" --topo-order --all --no-commit-header >actual &&
     -+		git -C import rev-list --all >tmp &&
     -+
     -+		test_line_count = 4 tmp &&
     ++		git log --format="%ad %s" --first-parent main >expected &&
     ++		git -C import log --format="%ad %s" --all >actual &&
      +		test_cmp expected actual &&
     -+		test_cmp first-parent-export first-parent-reverse-export
     ++		test_line_count = 4 actual
      +	)
      +'
      +


 builtin/fast-export.c  | 40 ++++------------------------------------
 t/t9350-fast-export.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 8e2caf72819..cb1d6473f12 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -107,18 +107,6 @@ static int parse_opt_reencode_mode(const struct option *opt,
 
 static struct decoration idnums;
 static uint32_t last_idnum;
-
-static int has_unshown_parent(struct commit *commit)
-{
-	struct commit_list *parent;
-
-	for (parent = commit->parents; parent; parent = parent->next)
-		if (!(parent->item->object.flags & SHOWN) &&
-		    !(parent->item->object.flags & UNINTERESTING))
-			return 1;
-	return 0;
-}
-
 struct anonymized_entry {
 	struct hashmap_entry hash;
 	const char *anon;
@@ -752,20 +740,6 @@ static char *anonymize_tag(void *data)
 	return strbuf_detach(&out, NULL);
 }
 
-static void handle_tail(struct object_array *commits, struct rev_info *revs,
-			struct string_list *paths_of_changed_objects)
-{
-	struct commit *commit;
-	while (commits->nr) {
-		commit = (struct commit *)object_array_pop(commits);
-		if (has_unshown_parent(commit)) {
-			/* Queue again, to be handled later */
-			add_object_array(&commit->object, NULL, commits);
-			return;
-		}
-		handle_commit(commit, revs, paths_of_changed_objects);
-	}
-}
 
 static void handle_tag(const char *name, struct tag *tag)
 {
@@ -1185,7 +1159,6 @@ static int parse_opt_anonymize_map(const struct option *opt,
 int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
-	struct object_array commits = OBJECT_ARRAY_INIT;
 	struct commit *commit;
 	char *export_filename = NULL,
 	     *import_filename = NULL,
@@ -1283,18 +1256,13 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
+
+	revs.reverse = 1;
 	revs.diffopt.format_callback = show_filemodify;
 	revs.diffopt.format_callback_data = &paths_of_changed_objects;
 	revs.diffopt.flags.recursive = 1;
-	while ((commit = get_revision(&revs))) {
-		if (has_unshown_parent(commit)) {
-			add_object_array(&commit->object, NULL, &commits);
-		}
-		else {
-			handle_commit(commit, &revs, &paths_of_changed_objects);
-			handle_tail(&commits, &revs, &paths_of_changed_objects);
-		}
-	}
+	while ((commit = get_revision(&revs)))
+		handle_commit(commit, &revs, &paths_of_changed_objects);
 
 	handle_tags_and_duplicates(&extra_refs);
 	handle_tags_and_duplicates(&tag_refs);
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 409b48e2442..7b7a18dd2c1 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -750,4 +750,36 @@ test_expect_success 'merge commit gets exported with --import-marks' '
 	)
 '
 
+
+test_expect_success 'fast-export --first-parent outputs all revisions output by revision walk' '
+	git init first-parent &&
+	(
+		cd first-parent &&
+		test_commit A &&
+		git checkout -b topic1 &&
+		test_commit B &&
+		git checkout main &&
+		git merge --no-ff topic1 &&
+
+		git checkout -b topic2 &&
+		test_commit C &&
+		git checkout main &&
+		git merge --no-ff topic2 &&
+
+		test_commit D &&
+
+		git fast-export main -- --first-parent >first-parent-export &&
+		git fast-export main -- --first-parent --reverse >first-parent-reverse-export &&
+		test_cmp first-parent-export first-parent-reverse-export &&
+
+		git init import &&
+		git -C import fast-import <first-parent-export &&
+
+		git log --format="%ad %s" --first-parent main >expected &&
+		git -C import log --format="%ad %s" --all >actual &&
+		test_cmp expected actual &&
+		test_line_count = 4 actual
+	)
+'
+
 test_done

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
gitgitgadget
