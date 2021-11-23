Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A0FC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhKWLb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhKWLb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:31:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA76C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:28:49 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so1955821wme.0
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=u6q3zL/Vh3llWMilSslb8ACi13csFB7Oi/9QDcuvJuA=;
        b=RdfCDon1IE5pm93HTvEhzRI98BSm+8ykCbZzpqnFZRxSeyEjpPO6z18xZuoGQSvjuZ
         QtcVuQHpz+dmFYIj6xvnlvhQBwpy/ZkN2I2BAG2CXZxECBpISe3Syg8DQ3ymtqFN9dTK
         xwVKiOWR6CSgc7tlVX89VymiJd/2qVb0+fHjPq1IrBh66CFo0B2Y3H0r1bE08yLgEtp6
         7rZtApV7Fx06cgnCGDQggeAZovMyEVoGnNimXDJnqbGQ+WP6Et6WW+qtuH6iC+9mZezv
         YZdV6HfrMp171KXdGF7xmoIE/m+dPI/EEHfCbTEEJx7PN2kT5LfuSGDPzCLYm8bi2H8D
         yf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u6q3zL/Vh3llWMilSslb8ACi13csFB7Oi/9QDcuvJuA=;
        b=kjXKvPfy28/jn3H/mvtaS9GTsQZCmtZ6dk4wlL4WhUg4oIbCBQUR+wfLxp33iyOtR7
         5Fcbgs9JJcN2UM6QrJu6Gcg+hPnIYMH8D6FJJAfvduPY9rqBs1O2ZgwI4LKRbbBjzkaZ
         Si5wGMiPruHI2SVhpSSOJwgEU9LDZ5P8oETog21/9f+xz4wuQ+PAnDrVKaGqSwQA1jwC
         dHCS+noM0WHBsTOommVNGnr3BEVl8lDtMbuuDHSuwxHWPgQT+rvDv/xuTwV6KnKuBAhA
         nJYV9Ll1QBtcyxhy47YpyJR8HFSNRMZQtLmjCQ7j7gvM+/befypa0gercBHtUstSqcHT
         GAcQ==
X-Gm-Message-State: AOAM533gk52HzpIX+GPCyc6lTjvbr7h+35qIKAbeFLCpyF5TfCdS+5u5
        jL78xR8gvuVCeXGbJzck5ggjFpPCEs8=
X-Google-Smtp-Source: ABdhPJwVzNOX+vdW04Jftg8lJng7dUqAh9ojSdrvb2YkCh+a6b7ZAPeYNN9OLt4brD9LOMm/rQ+0lQ==
X-Received: by 2002:a05:600c:2f01:: with SMTP id r1mr2147031wmn.153.1637666928021;
        Tue, 23 Nov 2021 03:28:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm14382499wri.41.2021.11.23.03.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:28:47 -0800 (PST)
Message-Id: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
From:   "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 11:28:47 +0000
Subject: [PATCH] fast-export: fix surprising behavior with --first-parent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     William Sprent <williams@unity3d.com>,
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
    
    This is my first time patching git, so I probably need some guidance on
    my approach. :)
    
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1084%2Fwilliams-unity%2Ffast-export%2Ffirst-parent-issues-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1084/williams-unity/fast-export/first-parent-issues-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1084

 builtin/fast-export.c  | 36 ++----------------------------------
 t/t9350-fast-export.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 8e2caf72819..50f8c224b6e 100644
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
@@ -1281,19 +1254,14 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	get_tags_and_duplicates(&revs.cmdline);
 
+	revs.reverse = 1;
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	revs.diffopt.format_callback = show_filemodify;
 	revs.diffopt.format_callback_data = &paths_of_changed_objects;
 	revs.diffopt.flags.recursive = 1;
 	while ((commit = get_revision(&revs))) {
-		if (has_unshown_parent(commit)) {
-			add_object_array(&commit->object, NULL, &commits);
-		}
-		else {
-			handle_commit(commit, &revs, &paths_of_changed_objects);
-			handle_tail(&commits, &revs, &paths_of_changed_objects);
-		}
+		handle_commit(commit, &revs, &paths_of_changed_objects);
 	}
 
 	handle_tags_and_duplicates(&extra_refs);
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 409b48e2442..bd08101b81d 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -750,4 +750,34 @@ test_expect_success 'merge commit gets exported with --import-marks' '
 	)
 '
 
+
+test_expect_success 'fast-export --first-parent outputs all revisions output by revision walk' '
+	git init first-parent &&
+	cd first-parent &&
+	test_commit init &&
+	git checkout -b topic1 &&
+	test_commit file2 file2.txt &&
+	git checkout main &&
+	git merge topic1 --no-ff &&
+
+	git checkout -b topic2 &&
+	test_commit file3 file3.txt &&
+	git checkout main &&
+	git merge topic2 --no-ff &&
+
+	test_commit branch-head &&
+
+	git rev-list --format="%ad%B" --first-parent --topo-order --no-commit-header main > expected &&
+
+	git fast-export main -- --first-parent > first-parent-export &&
+	git fast-export main -- --first-parent --reverse > first-parent-reverse-export &&
+	git init import && cd import &&
+	cat ../first-parent-export | git fast-import &&
+
+	git rev-list --format="%ad%B" --topo-order --all --no-commit-header > actual &&
+	test $(git rev-list --all | wc -l) -eq 4 &&
+	test_cmp ../expected actual &&
+	test_cmp ../first-parent-export ../first-parent-reverse-export
+'
+
 test_done

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
gitgitgadget
