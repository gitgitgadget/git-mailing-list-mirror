Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952B8C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 08:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhLIIRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhLIIRd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 03:17:33 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE80C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 00:14:00 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 133so3547975wme.0
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 00:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=49q+SFOjE4sFQF3ldIuc9qXN95XLwdsolxdeuGRi8B4=;
        b=ILmvf+6/G8BNTSEIXDKO8KRSCj+Fk+dIPdB7fIJohEUCahY5wGWD9pSIfCgFVltEcU
         RQRpHsB15HZVDNx48v8QNY3OhL1QaqAgagqan3HkOqdXcBtgfK0usfvm7w0tycGmRFK+
         Bv1wCsvPEAzkgdBhkJZykb3cckY5m4O/nU32/UWZFfytj/m/x+1ryHmHWr6hHLKXBc8/
         1qpTw65thdMhSB/XPxvonR3Do8Yi1GYbYHUjoEYGLGsULDljxI72PgQV45cBVIcWoxZy
         H8XsF3nPRY8APn/r9P//rOaO4LkEDSnryRd0oa3xHPj1uhLPz3E9B7xLPjgj4rKsOc5T
         fyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=49q+SFOjE4sFQF3ldIuc9qXN95XLwdsolxdeuGRi8B4=;
        b=UGI2aRYOVthpdN/L2y+kYni20DumL9g5BmTkVE3mLKmM9gWu1ORkWQm1fiVb0xr62J
         ifRNnISZrx/4auY6/SGL7DWjPYgI6TiD3GQMbCRn2aJJ+ErG525Nau4cFen66WFuRpV4
         3gSgnoHGL+BjdmQaHMEYibK8JWtnT/9hQlZ3Ow/WL5EGN+TDAm+e80h90SVPCBZ0RbyE
         8eTLAjcTFLyzmLIh5z758yUXMBCeeMt5O/O8Vzo1hzAgbV9x4Z6GaSFdyi0jWjHFEwvF
         z55+Or4yZtH/uTRbtyTMcs0PwcS7RUVMXHALZCuDY+oWILs6v6g01Trh9WSJ1t8VjMTf
         0UTg==
X-Gm-Message-State: AOAM531Qx92QU3AKWQrC+8HW3s6IjlPSG9HLE7FQn1ItD43cseujztK4
        uQKQbDzkDSTkeoGrKqB6cl9w2qVKEbI=
X-Google-Smtp-Source: ABdhPJw/Es+AYPdTQCvlPzTiF9hQnMCR6dljgFPN6Wt2NtHtKSTbrUgGCPQNAQkNXVKoVUS5VUkgpQ==
X-Received: by 2002:a05:600c:4e91:: with SMTP id f17mr5219759wmq.195.1639037638365;
        Thu, 09 Dec 2021 00:13:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15sm5192122wro.35.2021.12.09.00.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 00:13:57 -0800 (PST)
Message-Id: <pull.1084.v2.git.1639037637231.gitgitgadget@gmail.com>
In-Reply-To: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
References: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
From:   "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 08:13:57 +0000
Subject: [PATCH v2] fast-export: fix surprising behavior with --first-parent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>,
        William Sprent <williams@unity3d.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Sprent <williams@unity3d.com>

When invoking git-fast-export with the --first-parent flag on a branch
with merges, fast-export would early-out on processing the first merge
on the branch. If combined with --reverse, fast-export would instead
output all single parent commits on the branch.

This commit makes fast-export output the same commits as rev-list
--first-parent, and makes --reverse not have an effect on which commits
are output.

The fix involves removing logic within fast-export which was responsible
for ensuring that parents are processed before their children, which was
what was exiting early due to missing second parents. This is replaced
by setting 'reverse = 1' before revision walking, which, in conjuction
with topo_order, allows for delegating the ordering of commits to
revision.c. The reverse flag is set after parsing rev-list arguments to
avoid having it disabled.

Signed-off-by: William Sprent <williams@unity3d.com>
---
    fast-export: fix surprising behavior with --first-parent
    
    Hi,
    
    I've noticed that git fast-export exhibits some odd behavior when passed
    the --first-parent flag. In the repository I was working on, it would
    only output the initial commit before exiting. Moreover, adding the
    --reverse flag causes it to behave differently and instead output all
    commits in the first parent line that only have one parent. My
    expectation is more or less that git fast-export should output the same
    set of commits as git rev-list would output given the same arguments,
    which matches how it acts when given revision ranges.
    
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
    
    cc: Ævar Arnfjörð Bjarmason avarab@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1084%2Fwilliams-unity%2Ffast-export%2Ffirst-parent-issues-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1084/williams-unity/fast-export/first-parent-issues-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1084

Range-diff vs v1:

 1:  e2824193a8f ! 1:  af552f37dbe fast-export: fix surprising behavior with --first-parent
     @@ builtin/fast-export.c: static int parse_opt_anonymize_map(const struct option *o
       	     *import_filename = NULL,
      @@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const char *prefix)
       
     - 	get_tags_and_duplicates(&revs.cmdline);
     - 
     -+	revs.reverse = 1;
       	if (prepare_revision_walk(&revs))
       		die("revision walk setup failed");
     ++
     ++	revs.reverse = 1;
       	revs.diffopt.format_callback = show_filemodify;
       	revs.diffopt.format_callback_data = &paths_of_changed_objects;
       	revs.diffopt.flags.recursive = 1;
     - 	while ((commit = get_revision(&revs))) {
     +-	while ((commit = get_revision(&revs))) {
      -		if (has_unshown_parent(commit)) {
      -			add_object_array(&commit->object, NULL, &commits);
      -		}
     @@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const ch
      -			handle_commit(commit, &revs, &paths_of_changed_objects);
      -			handle_tail(&commits, &revs, &paths_of_changed_objects);
      -		}
     +-	}
     ++	while ((commit = get_revision(&revs)))
      +		handle_commit(commit, &revs, &paths_of_changed_objects);
     - 	}
       
       	handle_tags_and_duplicates(&extra_refs);
     + 	handle_tags_and_duplicates(&tag_refs);
      
       ## t/t9350-fast-export.sh ##
      @@ t/t9350-fast-export.sh: test_expect_success 'merge commit gets exported with --import-marks' '
     @@ t/t9350-fast-export.sh: test_expect_success 'merge commit gets exported with --i
      +
      +test_expect_success 'fast-export --first-parent outputs all revisions output by revision walk' '
      +	git init first-parent &&
     -+	cd first-parent &&
     -+	test_commit init &&
     -+	git checkout -b topic1 &&
     -+	test_commit file2 file2.txt &&
     -+	git checkout main &&
     -+	git merge topic1 --no-ff &&
     ++	(
     ++		cd first-parent &&
     ++		test_commit A &&
     ++		git checkout -b topic1 &&
     ++		test_commit B &&
     ++		git checkout main &&
     ++		git merge topic1 --no-ff &&
     ++
     ++		git checkout -b topic2 &&
     ++		test_commit C &&
     ++		git checkout main &&
     ++		git merge topic2 --no-ff &&
     ++
     ++		test_commit D &&
      +
     -+	git checkout -b topic2 &&
     -+	test_commit file3 file3.txt &&
     -+	git checkout main &&
     -+	git merge topic2 --no-ff &&
     ++		git rev-list --format="%ad%B" --first-parent --topo-order --no-commit-header main >expected &&
      +
     -+	test_commit branch-head &&
     ++		git fast-export main -- --first-parent >first-parent-export &&
     ++		git fast-export main -- --first-parent --reverse >first-parent-reverse-export &&
      +
     -+	git rev-list --format="%ad%B" --first-parent --topo-order --no-commit-header main > expected &&
     ++		git init import &&
     ++		git -C import fast-import <first-parent-export &&
      +
     -+	git fast-export main -- --first-parent > first-parent-export &&
     -+	git fast-export main -- --first-parent --reverse > first-parent-reverse-export &&
     -+	git init import && cd import &&
     -+	cat ../first-parent-export | git fast-import &&
     ++		git -C import rev-list --format="%ad%B" --topo-order --all --no-commit-header >actual &&
     ++		git -C import rev-list --all >tmp &&
      +
     -+	git rev-list --format="%ad%B" --topo-order --all --no-commit-header > actual &&
     -+	test $(git rev-list --all | wc -l) -eq 4 &&
     -+	test_cmp ../expected actual &&
     -+	test_cmp ../first-parent-export ../first-parent-reverse-export
     ++		test_line_count = 4 tmp &&
     ++		test_cmp expected actual &&
     ++		test_cmp first-parent-export first-parent-reverse-export
     ++	)
      +'
      +
       test_done


 builtin/fast-export.c  | 40 ++++------------------------------------
 t/t9350-fast-export.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 36 deletions(-)

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
index 409b48e2442..df1a5b1013a 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -750,4 +750,39 @@ test_expect_success 'merge commit gets exported with --import-marks' '
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
+		git merge topic1 --no-ff &&
+
+		git checkout -b topic2 &&
+		test_commit C &&
+		git checkout main &&
+		git merge topic2 --no-ff &&
+
+		test_commit D &&
+
+		git rev-list --format="%ad%B" --first-parent --topo-order --no-commit-header main >expected &&
+
+		git fast-export main -- --first-parent >first-parent-export &&
+		git fast-export main -- --first-parent --reverse >first-parent-reverse-export &&
+
+		git init import &&
+		git -C import fast-import <first-parent-export &&
+
+		git -C import rev-list --format="%ad%B" --topo-order --all --no-commit-header >actual &&
+		git -C import rev-list --all >tmp &&
+
+		test_line_count = 4 tmp &&
+		test_cmp expected actual &&
+		test_cmp first-parent-export first-parent-reverse-export
+	)
+'
+
 test_done

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
gitgitgadget
