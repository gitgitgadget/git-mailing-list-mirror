Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF93C10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608F520753
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 17:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h12Rb3Mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgCRRa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:30:56 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:55597 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgCRRaz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 13:30:55 -0400
Received: by mail-pl1-f202.google.com with SMTP id w11so15374237plp.22
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eBzSy9HInmt0E0DwDRpQjl9pz1lYq2AjkuSFZSnoq/o=;
        b=h12Rb3MzYq1UUEgh4qU2OQxn2ux+TwtxBAuld5R6pFMbM4h3d79mjalYd7KsPE1I9j
         BX6kDYSE3mpZ0eYHW/tPAKZiZYNsN2xQujLxUxnSJse3ulTFFeAvgp4kH5ZMh4mekvc4
         9rzuc/b6xZcEabeW5Gf3DlzIk2S13dMKX2gxLsAbfnW6OsMRVTQ0FkAMAVsIqHsmq/xE
         ymHe/vkCLUrZ7xpEspdyTPq965OIN826JrQZ29xgtHpr6vggTEqkkNZ7P0K8OM3RWaZx
         rmN3Z2Ry8lpcXxWD6h9NbPuTeLz5nfI6wawr+UmEZ76GzbilYWM6PTcZ03wLaULNx2iR
         OYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eBzSy9HInmt0E0DwDRpQjl9pz1lYq2AjkuSFZSnoq/o=;
        b=WEx+WubCOqiAOHuF4uIDbvKOqpCgwVEA+ObogDNaPHfKlwMmpJ0cubk1gQdoDkGImD
         p6nDlr8jB2IoWYt1k5GQKPaGXsYQyAORo3cAEaZirfPSKbjhdVc4nIYGVNIzYEBpdvP9
         4AeNekqWMqc6UvdsiXusAoamfKrIOpwYOjyjA2zk0BJkDNQTeuFfuYj/nfXuqqphJu3R
         jh1MCRQuGUfjkUN4chhGwZGm60GnAFi/WwOkcGz5169umBK+6ug+8v8IYSOcuSok2zIw
         6heDaYL28n1iIU4uzjxoARNHysrPOhGizfBTuW5wtcew5tDzmUpalzPvEbkoyBWo+sys
         iB6Q==
X-Gm-Message-State: ANhLgQ2a+aDwCqtiSGIHLandZDWt/gur9sLxb9b8+reJWtWZqCzRETyS
        qIhh4skNEhd7JlFjWHgo1vufMA0j6e+uD8pReBMTHJdAnXtgNz8x2mubka8eJTtykB61PCr5nwL
        xQSxSXsYGUd1hEThlad/gBTBamy2fXjIeUQGp8w6aModpFiWBgDVjFRScxkj+OvZDDQyqeCNiO+
        68
X-Google-Smtp-Source: ADFU+vuD4Wg+el1zII7S3O+VhRK3q090lZUr1r8R19X0z8l9p75eIYdPzjgSVpG0oyjhVFHH1q66Rm8ND4F3hm91oIY9
X-Received: by 2002:a17:90b:1954:: with SMTP id nk20mr5681615pjb.69.1584552653748;
 Wed, 18 Mar 2020 10:30:53 -0700 (PDT)
Date:   Wed, 18 Mar 2020 10:30:51 -0700
In-Reply-To: <20200309205523.121319-1-jonathantanmy@google.com>
Message-Id: <20200318173051.25875-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200309205523.121319-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v2] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com,
        Johannes.Schindelin@gmx.de, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebasing against an upstream that has had many commits since the
original branch was created:

 O -- O -- ... -- O -- O (upstream)
  \
   -- O (my-dev-branch)

it must read the contents of every novel upstream commit, in addition to
the tip of the upstream and the merge base, because "git rebase"
attempts to exclude commits that are duplicates of upstream ones. This
can be a significant performance hit, especially in a partial clone,
wherein a read of an object may end up being a fetch.

Add a flag to "git rebase" to allow suppression of this feature. This
flag only works when using the "merge" backend.

This flag changes the behavior of sequencer_make_script(), called from
do_interactive_rebase() <- run_rebase_interactive() <-
run_specific_rebase() <- cmd_rebase(). With this flag, limit_list()
(indirectly called from sequencer_make_script() through
prepare_revision_walk()) will no longer call cherry_pick_list(), and
thus PATCHSAME is no longer set. Refraining from setting PATCHSAME both
means that the intermediate commits in upstream are no longer read (as
shown by the test) and means that no PATCHSAME-caused skipping of
commits is done by sequencer_make_script(), either directly or through
make_script_with_merges().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
New in V2: changed parameter name, used Taylor's commit message
suggestions, and used Elijah's documentation suggestions.
---
 Documentation/git-rebase.txt | 20 +++++++++-
 builtin/rebase.c             |  7 ++++
 sequencer.c                  |  3 +-
 sequencer.h                  |  2 +-
 t/t3402-rebase-merge.sh      | 77 ++++++++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0c4f038dd6..4629eb573f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -318,6 +318,20 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--skip-cherry-pick-detection::
+--no-skip-cherry-pick-detection::
+	Whether rebase tries to determine if commits are already present
+	upstream, i.e. if there are commits which are cherry-picks.  If such
+	detection is done, any commits being rebased which are cherry-picks
+	will be dropped, since those commits are already found upstream.  If
+	such detection is not done, those commits will be re-applied, which
+	most likely will result in no new changes (as the changes are already
+	upstream) and result in the commit being dropped anyway.  cherry-pick
+	detection is the default, but can be expensive in repos with a large
+	number of upstream commits that need to be read.
++
+See also INCOMPATIBLE OPTIONS below.
+
 --rerere-autoupdate::
 --no-rerere-autoupdate::
 	Allow the rerere mechanism to update the index with the
@@ -568,6 +582,9 @@ In addition, the following pairs of options are incompatible:
  * --keep-base and --onto
  * --keep-base and --root
 
+Also, the --skip-cherry-pick-detection option requires the use of the merge
+backend (e.g., through --merge).
+
 BEHAVIORAL DIFFERENCES
 -----------------------
 
@@ -866,7 +883,8 @@ Only works if the changes (patch IDs based on the diff contents) on
 'subsystem' did.
 
 In that case, the fix is easy because 'git rebase' knows to skip
-changes that are already present in the new upstream.  So if you say
+changes that are already present in the new upstream (unless
+`--skip-cherry-pick-detection` is given). So if you say
 (assuming you're on 'topic')
 ------------
     $ git rebase subsystem
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6154ad8fa5..100b8872af 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -88,6 +88,7 @@ struct rebase_options {
 	struct strbuf git_format_patch_opt;
 	int reschedule_failed_exec;
 	int use_legacy_rebase;
+	int skip_cherry_pick_detection;
 };
 
 #define REBASE_OPTIONS_INIT {			  	\
@@ -373,6 +374,7 @@ static int run_rebase_interactive(struct rebase_options *opts,
 	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
 	flags |= opts->root_with_onto ? TODO_LIST_ROOT_WITH_ONTO : 0;
 	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
+	flags |= opts->skip_cherry_pick_detection ? TODO_LIST_SKIP_CHERRY_PICK_DETECTION : 0;
 
 	switch (command) {
 	case ACTION_NONE: {
@@ -1507,6 +1509,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "reschedule-failed-exec",
 			 &reschedule_failed_exec,
 			 N_("automatically re-schedule any `exec` that fails")),
+		OPT_BOOL(0, "skip-cherry-pick-detection", &options.skip_cherry_pick_detection,
+			 N_("skip changes that are already present in the new upstream")),
 		OPT_END(),
 	};
 	int i;
@@ -1840,6 +1844,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			      "interactive or merge options"));
 	}
 
+	if (options.skip_cherry_pick_detection && !is_interactive(&options))
+		die(_("--skip-cherry-pick-detection does not work with the 'apply' backend"));
+
 	if (options.signoff) {
 		if (options.type == REBASE_PRESERVE_MERGES)
 			die("cannot combine '--signoff' with "
diff --git a/sequencer.c b/sequencer.c
index ba90a513b9..8b2cae3b69 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4797,12 +4797,13 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
+	int skip_cherry_pick_detection = flags & TODO_LIST_SKIP_CHERRY_PICK_DETECTION;
 
 	repo_init_revisions(r, &revs, NULL);
 	revs.verbose_header = 1;
 	if (!rebase_merges)
 		revs.max_parents = 1;
-	revs.cherry_mark = 1;
+	revs.cherry_mark = !skip_cherry_pick_detection;
 	revs.limited = 1;
 	revs.reverse = 1;
 	revs.right_only = 1;
diff --git a/sequencer.h b/sequencer.h
index 393571e89a..a54ea696c2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -149,7 +149,7 @@ int sequencer_remove_state(struct replay_opts *opts);
  * `--onto`, we do not want to re-generate the root commits.
  */
 #define TODO_LIST_ROOT_WITH_ONTO (1U << 6)
-
+#define TODO_LIST_SKIP_CHERRY_PICK_DETECTION (1U << 7)
 
 int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			  const char **argv, unsigned flags);
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index a1ec501a87..290c79e0f6 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -162,4 +162,81 @@ test_expect_success 'rebase --skip works with two conflicts in a row' '
 	git rebase --skip
 '
 
+test_expect_success '--skip-cherry-pick-detection' '
+	git init repo &&
+
+	# O(1-10) -- O(1-11) -- O(0-10) master
+	#        \
+	#         -- O(1-11) -- O(1-12) otherbranch
+
+	printf "Line %d\n" $(test_seq 1 10) >repo/file.txt &&
+	git -C repo add file.txt &&
+	git -C repo commit -m "base commit" &&
+
+	printf "Line %d\n" $(test_seq 1 11) >repo/file.txt &&
+	git -C repo commit -a -m "add 11" &&
+
+	printf "Line %d\n" $(test_seq 0 10) >repo/file.txt &&
+	git -C repo commit -a -m "add 0 delete 11" &&
+
+	git -C repo checkout -b otherbranch HEAD^^ &&
+	printf "Line %d\n" $(test_seq 1 11) >repo/file.txt &&
+	git -C repo commit -a -m "add 11 in another branch" &&
+
+	printf "Line %d\n" $(test_seq 1 12) >repo/file.txt &&
+	git -C repo commit -a -m "add 12 in another branch" &&
+
+	# Regular rebase fails, because the 1-11 commit is deduplicated
+	test_must_fail git -C repo rebase --merge master 2> err &&
+	test_i18ngrep "error: could not apply.*add 12 in another branch" err &&
+	git -C repo rebase --abort &&
+
+	# With --skip-cherry-pick-detection, it works
+	git -C repo rebase --merge --skip-cherry-pick-detection master
+'
+
+test_expect_success '--skip-cherry-pick-detection refrains from reading unneeded blobs' '
+	git init server &&
+
+	# O(1-10) -- O(1-11) -- O(1-12) master
+	#        \
+	#         -- O(0-10) otherbranch
+
+	printf "Line %d\n" $(test_seq 1 10) >server/file.txt &&
+	git -C server add file.txt &&
+	git -C server commit -m "merge base" &&
+
+	printf "Line %d\n" $(test_seq 1 11) >server/file.txt &&
+	git -C server commit -a -m "add 11" &&
+
+	printf "Line %d\n" $(test_seq 1 12) >server/file.txt &&
+	git -C server commit -a -m "add 12" &&
+
+	git -C server checkout -b otherbranch HEAD^^ &&
+	printf "Line %d\n" $(test_seq 0 10) >server/file.txt &&
+	git -C server commit -a -m "add 0" &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+
+	git clone --filter=blob:none "file://$(pwd)/server" client &&
+	git -C client checkout origin/master &&
+	git -C client checkout origin/otherbranch &&
+
+	# Sanity check to ensure that the blobs from the merge base and "add
+	# 11" are missing
+	git -C client rev-list --objects --all --missing=print >missing_list &&
+	MERGE_BASE_BLOB=$(git -C server rev-parse master^^:file.txt) &&
+	ADD_11_BLOB=$(git -C server rev-parse master^:file.txt) &&
+	grep "\\?$MERGE_BASE_BLOB" missing_list &&
+	grep "\\?$ADD_11_BLOB" missing_list &&
+
+	git -C client rebase --merge --skip-cherry-pick-detection origin/master &&
+
+	# The blob from the merge base had to be fetched, but not "add 11"
+	git -C client rev-list --objects --all --missing=print >missing_list &&
+	! grep "\\?$MERGE_BASE_BLOB" missing_list &&
+	grep "\\?$ADD_11_BLOB" missing_list
+'
+
 test_done
-- 
2.25.1.481.gfbce0eb801-goog

