Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC8C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 07:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98CE64DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 07:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBPHM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 02:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhBPHM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 02:12:56 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE859C061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 23:12:15 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id p21so22067pgl.12
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 23:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVD/rogz66fJBRr90lpu0G21P3IvCMpTaBdtBkuln5g=;
        b=r05jfesbAixEvhB8UPGsOJm4rhrZEdL0IUHOzwOcmKCQSwYUW6NdKJF5THWvfcgUHg
         EGuadkjD6Q6O3i/uIlYquSkc5yUwu8YGuvpZekKsryd4R+fon7tp378QmnPQY349SDuG
         VF4XnZsbpTU1a3HVdMKIx3UqrTzm5EH1C9qn0f72ssfNWp7p5T6cybU6UZ1VzbxiICaL
         n9n1G1f7mhbxu5z8bcMGHZTvR2wYn8k+LSz9I2IJzkQbJcObg1z/NwhZ5MvweCUvdGFK
         EXYD3U1w48knpBHpIgy8rnPFazyI4J9qiXhb/InwwI9HkCbgfB8jmfxqVHMXejSBk11D
         DiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVD/rogz66fJBRr90lpu0G21P3IvCMpTaBdtBkuln5g=;
        b=OPViqIeb/Bck2BuaouY8FjQHYOHr0RUg4p4K8DZlh4WhqY1vAZUO3NwFdeuMqH648V
         /FKYAykTr31XDSrMiN3vXLxehxHJNUVDXtngugyvEfGvoKsOk8a4spV6s/ZVt5F8KXH7
         c8IOw7SzODtGLEpZOVqbZPl2+Vfdc39e+HwOr2PZnxvklG95UKBA1uGK7zyH1rC6dk2e
         6BuJGPL8m9RFFvxi/Xv76GJkpiS2Bhobg5J9VbVLPkZkNBm7iCA/to0PO7XtwFb7ubYL
         af8o2YmgaPgNnG+px8CWWfbOmVZnH7fS0quFcOYQh1hN2tPfaKw2X21Dz25FNeG19Qbf
         6hbQ==
X-Gm-Message-State: AOAM531LzVhYO1AdjjRPWFoVoixH3FbnNwJeqHRRz4OzWYzdWPT07k8q
        J12kBOU8xKSrLH33hF6Y4Nacd5UF4uc=
X-Google-Smtp-Source: ABdhPJznfvFLAbqVIs7Q98r5VodQvH2IRVATfDRUgzGkvToDEtI1z0WoAQiWPP0nFrnFvkCRyKlIEA==
X-Received: by 2002:a05:6a00:1a44:b029:1d6:4170:ee0b with SMTP id h4-20020a056a001a44b02901d64170ee0bmr18595850pfv.57.1613459534701;
        Mon, 15 Feb 2021 23:12:14 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id d133sm20025278pfd.6.2021.02.15.23.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 23:12:13 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 0/2] stash show: learn --include-untracked and --only-untracked
Date:   Mon, 15 Feb 2021 23:11:55 -0800
Message-Id: <cover.1613459474.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612855690.git.liu.denton@gmail.com>
References: <cover.1612855690.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A blindspot that I've noticed in git is that it's not possible to
properly view a stash entry that has untracked files via `git stash
show`. Teach `git stash show --include-untracked` which should do this.
In addition, this series also teaches `--only-untracked` and the
`stash.showIncludeUntracked` config option.

This series is based on 'dl/stash-cleanup'.

Changes since v2:

* Base this series on top of 'dl/stash-cleanup'

* Attempt to replicate the read-tree code to merge the untracked tree

Changes since v1:

* Add a dash for <log-options> and <diff-options>

* Fix the misspelling of --include-untracked in a commit message

* Change the approach from concatenating diffs to using `git read-tree`

Denton Liu (2):
  stash show: teach --include-untracked and --only-untracked
  stash show: learn stash.showIncludeUntracked

 Documentation/config/stash.txt         |  5 ++
 Documentation/git-stash.txt            | 22 ++++---
 builtin/stash.c                        | 61 +++++++++++++++++-
 contrib/completion/git-completion.bash |  2 +-
 t/t3905-stash-include-untracked.sh     | 86 ++++++++++++++++++++++++++
 5 files changed, 167 insertions(+), 9 deletions(-)

Range-diff against v2:
1:  88d4791259 ! 1:  85b81f2f06 stash show: teach --include-untracked and --only-untracked
    @@ Commit message
         stash entry itself, running `git stash show` does not include the
         untracked files as part of the diff.
     
    -    Teach stash the --include-untracked option, which also displays the
    -    untracked files in a stash entry from the third parent (if it exists).
    -    Do this via something like
    +    With --include-untracked, untracked paths, which are recorded in the
    +    third-parent if it exists, are shown in addition to the paths that have
    +    modifications between the stash base and the working tree in the stash.
     
    -            GIT_INDEX_FILE=... git read-tree stash stash^3
    -
    -    and diffing the resulting tree object against the stash base.
    -
    -    One improvement that this could use for the future is performing the
    -    action without writing anything to disk as one would expect this to be a
    -    read-only operation. This can be fixed in the future, however.
    -
    -    Another limitation of this is that it would be possible to manually
    -    craft a stash entry where duplicate untracked files in the stash entry
    -    will mask tracked files. This seems like an instance of "Doctor, it
    -    hurts when I do this! So don't do that!" so this can be written off.
    +    One limitation of this is that it would be possible to manually craft a
    +    stash entry where duplicate untracked files in the stash entry will mask
    +    tracked files. This seems like an instance of "Doctor, it hurts when I
    +    do this! So don't do that!" so this can be written off.
     
         Also, teach stash the --only-untracked option which only shows the
         untracked files of a stash entry. This is similar to `git show stash^3`
         but it is nice to provide a convenient abstraction for it so that users
         do not have to think about the underlying implementation.
     
    +
    + ## Notes ##
    +    I am not familiar with the read-tree code so this attempt at replicating
    +    the read-tree code may in diff_include_untracked() may be incorrect
    +    (particularly the use of the_index?).
    +
    +    Also, I could not figure out how to make unpack_trees() error out in the
    +    case where untracked tree entry contains duplicate entries with the
    +    worktree entry.
    +
      ## Documentation/git-stash.txt ##
    +@@ Documentation/git-stash.txt: SYNOPSIS
    + --------
    + [verse]
    + 'git stash' list [<log-options>]
    +-'git stash' show [<diff-options>] [<stash>]
    ++'git stash' show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]
    + 'git stash' drop [-q|--quiet] [<stash>]
    + 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    + 'git stash' branch <branchname> [<stash>]
     @@ Documentation/git-stash.txt: stash@{1}: On master: 9cc0589... Add git-stash
      The command takes options applicable to the 'git log'
      command to control what is shown and how. See linkgit:git-log[1].
    @@ builtin/stash.c: static int git_stash_config(const char *var, const char *value,
      	return git_diff_basic_config(var, value, cb);
      }
      
    -+static int merge_track_untracked(struct object_id *result, const struct stash_info *info)
    ++static void diff_include_untracked(const struct stash_info *info, struct diff_options *diff_opt)
     +{
    -+	int ret = 0;
    -+	struct index_state istate = { NULL };
    -+	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
    ++	const struct object_id *oid[] = { &info->w_commit, &info->u_tree };
    ++	struct tree *tree[ARRAY_SIZE(oid)];
    ++	struct tree_desc tree_desc[ARRAY_SIZE(oid)];
    ++	struct unpack_trees_options unpack_tree_opt = { 0 };
    ++	int i;
     +
    -+	if (!info->has_u) {
    -+		oidcpy(result, &info->w_commit);
    -+		return 0;
    ++	for (i = 0; i < ARRAY_SIZE(oid); i++) {
    ++		tree[i] = parse_tree_indirect(oid[i]);
    ++		if (parse_tree(tree[i]) < 0)
    ++			die(_("failed to parse tree"));
    ++		init_tree_desc(&tree_desc[i], tree[i]->buffer, tree[i]->size);
     +	}
     +
    -+	/*
    -+	 * TODO: is there a way of doing this all in-memory without writing
    -+	 * anything to disk?
    -+	 */
    -+	remove_path(stash_index_path.buf);
    ++	unpack_tree_opt.head_idx = -1;
    ++	unpack_tree_opt.src_index = &the_index;
    ++	unpack_tree_opt.dst_index = &the_index;
    ++	unpack_tree_opt.fn = twoway_merge;
     +
    -+	cp_read_tree.git_cmd = 1;
    -+	strvec_push(&cp_read_tree.args, "read-tree");
    -+	strvec_push(&cp_read_tree.args, oid_to_hex(&info->w_commit));
    -+	strvec_push(&cp_read_tree.args, oid_to_hex(&info->u_tree));
    -+	strvec_pushf(&cp_read_tree.env_array, "GIT_INDEX_FILE=%s",
    -+		     stash_index_path.buf);
    ++	if (unpack_trees(ARRAY_SIZE(tree_desc), tree_desc, &unpack_tree_opt))
    ++		die(_("failed to unpack trees"));
     +
    -+	if (run_command(&cp_read_tree)) {
    -+		ret = -1;
    -+		goto done;
    -+	}
    -+
    -+	if (write_index_as_tree(result, &istate, stash_index_path.buf, 0,
    -+				NULL)) {
    -+		ret = -1;
    -+		goto done;
    -+	}
    -+
    -+done:
    -+	discard_index(&istate);
    -+	remove_path(stash_index_path.buf);
    -+	return ret;
    ++	do_diff_cache(&info->b_commit, diff_opt);
     +}
     +
      static int show_stash(int argc, const char **argv, const char *prefix)
    @@ builtin/stash.c: static int show_stash(int argc, const char **argv, const char *
      	struct rev_info rev;
      	struct strvec stash_args = STRVEC_INIT;
      	struct strvec revision_args = STRVEC_INIT;
    -+	struct object_id *before = NULL;
    -+	struct object_id *after = NULL;
    -+	struct object_id untracked_merged_tree;
     +	enum {
     +		UNTRACKED_NONE,
     +		UNTRACKED_INCLUDE,
    @@ builtin/stash.c: static int show_stash(int argc, const char **argv, const char *
     -	diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
     +	switch (show_untracked) {
     +	case UNTRACKED_NONE:
    -+		before = &info.b_commit;
    -+		after = &info.w_commit;
    ++		diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
     +		break;
     +	case UNTRACKED_ONLY:
    -+		before = NULL;
    -+		after = &info.u_tree;
    ++		diff_root_tree_oid(&info.u_tree, "", &rev.diffopt);
     +		break;
     +	case UNTRACKED_INCLUDE:
    -+		if (merge_track_untracked(&untracked_merged_tree, &info) < 0)
    -+			die(_("unable merge stash index with untracked files index"));
    -+		before = &info.b_commit;
    -+		after = &untracked_merged_tree;
    ++		diff_include_untracked(&info, &rev.diffopt);
     +		break;
     +	}
    -+	diff_tree_oid(before, after, "", &rev.diffopt);
      	log_tree_diff_flush(&rev);
      
      	free_stash_info(&info);
2:  ac4019f47e = 2:  d19d07ec27 stash show: learn stash.showIncludeUntracked
-- 
2.30.0.478.g8a0d178c01

