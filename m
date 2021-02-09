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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF6DC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8247C64DED
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBIH37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhBIH3w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 02:29:52 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC0BC061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 23:29:12 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id my11so1076935pjb.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 23:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJSjok5nhccvFRHdctgozFLsIm5fa/KjSTgxcBYsgus=;
        b=IecFnScjfhEiOctxTbL6tXxKcM8MxzMG5xMtRqxcUoHMBVjfM4MyXtQd0gnn0RrbAA
         brO3BzISK1OuK6bVfn401OB10TSen1T0yJ874NMibu9h1w05JvPMPrTL9pqyIf+NZpwD
         VVM7z28gqsVRwRv+vgsXlsJJsgk49bPg1ZzBKvREC4hTvERwvquS2K8m5wVCuPTKNc5s
         2zjIXi4Gguo+XzQRwMYGaSkcXxn2Xind6Low5udgTYMUO+eFBTLs4VTJk0ppbZGOwD81
         zUSYEPX4cjXfnf4by5Z8awq7Kf/+S9kVFwFXoDWSSjBF/q8W1gSYbo6sckKs9cYUDjOG
         PU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJSjok5nhccvFRHdctgozFLsIm5fa/KjSTgxcBYsgus=;
        b=aNYVyBs5OXfqNTtbJehFGNBK5sBYY5qDejOezOU8dUZtdbA+tOMPLW0VkQYOhnuB8U
         D1OD4UqSjDCMlx5hrOLkpFyt144Wu0mCAk5bN/IIHj1xYVBJSq8DvltguybbD1QzXcPq
         OmfcMimaWx3Y6CusppSPX/exu3+W4LEejl0pqfFINhFrQK1eUdM6ryRgH4zjcmLKS8Hd
         1YMECUJHY6tkTwd6jZ8BnW7AqPA9O4W2bPhgFRRJ88J8ugiIJr6/MAyDNnI5D1PyBdTD
         jxfuaQX84RfqO0OzEixXFpPwTkrOkSWfA/04Dg4Q8sX7kHAIZw5qFK25HqNBKv2PL2Xm
         7YpQ==
X-Gm-Message-State: AOAM532abuv5BmUqEPEa5v27PllEWDplLN9kc6qTuM7Bu7JvhD5htKwl
        2j8ZgUEZpO1wubpx52EWuW2x73noeaY=
X-Google-Smtp-Source: ABdhPJwLn/CsHJRVtt8nqcfhVBInrFzAjlNmH7Q1lErYVB+BGhKVkH8Kk2Y6diFvCedvNCOTX5fO2A==
X-Received: by 2002:a17:902:ee44:b029:e2:bb4a:9ffb with SMTP id 4-20020a170902ee44b02900e2bb4a9ffbmr16339580plo.39.1612855751842;
        Mon, 08 Feb 2021 23:29:11 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id w4sm5670443pfn.45.2021.02.08.23.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 23:29:11 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/9] stash show: learn --include-untracked and --only-untracked
Date:   Mon,  8 Feb 2021 23:28:46 -0800
Message-Id: <cover.1612855690.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612258145.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com>
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

The first seven patches of this series are just some clean up that I've
done prior to working (because it bothers me). The remaining two patches
should be the meat of the change.

Changes since v1:

* Add a dash for <log-options> and <diff-options>

* Fix the misspelling of --include-untracked in a commit message

* Change the approach from concatenating diffs to using `git read-tree`

Denton Liu (9):
  git-stash.txt: be explicit about subcommand options
  t3905: remove spaces after redirect operators
  t3905: move all commands into test cases
  t3905: remove nested git in command substitution
  t3905: replace test -s with test_file_not_empty
  t3905: use test_cmp() to check file contents
  stash: declare ref_stash as an array
  stash show: teach --include-untracked and --only-untracked
  stash show: learn stash.showIncludeUntracked

 Documentation/config/stash.txt         |   5 +
 Documentation/git-stash.txt            |  22 +-
 builtin/stash.c                        |  87 +++++++-
 contrib/completion/git-completion.bash |   2 +-
 t/t3905-stash-include-untracked.sh     | 278 +++++++++++++++++--------
 5 files changed, 292 insertions(+), 102 deletions(-)

Range-diff against v1:
 1:  17675b9e4c !  1:  5697f14f1c git-stash.txt: be explicit about subcommand options
    @@ Documentation/git-stash.txt: save [-p|--patch] [-k|--[no-]keep-index] [-u|--incl
      	message.
      
     -list [<options>]::
    -+list [<log options>]::
    ++list [<log-options>]::
      
      	List the stash entries that you currently have.  Each 'stash entry' is
      	listed with its name (e.g. `stash@{0}` is the latest entry, `stash@{1}` is
    @@ Documentation/git-stash.txt: stash@{1}: On master: 9cc0589... Add git-stash
      command to control what is shown and how. See linkgit:git-log[1].
      
     -show [<options>] [<stash>]::
    -+show [<diff options>] [<stash>]::
    ++show [<diff-options>] [<stash>]::
      
      	Show the changes recorded in the stash entry as a diff between the
      	stashed contents and the commit back when the stash entry was first
 2:  0de324e3bc =  2:  45ed17bfe2 t3905: remove spaces after redirect operators
 3:  519840b1a2 =  3:  5bda09b4bd t3905: move all commands into test cases
 4:  4b72d39e01 =  4:  57c21e2461 t3905: remove nested git in command substitution
 5:  7fe27ab620 =  5:  2530883b6c t3905: replace test -s with test_file_not_empty
 6:  4a5dd83ff4 =  6:  80194bcfa5 t3905: use test_cmp() to check file contents
 7:  b5f22de3fc =  7:  2f03d38b36 stash: declare ref_stash as an array
 8:  c2375d1fc6 !  8:  88d4791259 stash show: teach --include-tracked and --only-untracked
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    stash show: teach --include-tracked and --only-untracked
    +    stash show: teach --include-untracked and --only-untracked
     
         Stash entries can be made with untracked files via
         `git stash push --include-untracked`. However, because the untracked
    @@ Commit message
         stash entry itself, running `git stash show` does not include the
         untracked files as part of the diff.
     
    -    Teach stash the --include-tracked option, which also displays the
    +    Teach stash the --include-untracked option, which also displays the
         untracked files in a stash entry from the third parent (if it exists).
    -    Do this by just concatenating the diff of the third parent against an
    -    empty tree. One limitation of this is that it would be possible to
    -    manually craft a stash entry which would present duplicate entries in
    -    the diff by duplicating a file in the stash and in the third parent.
    -    This seems like an instance of "Doctor, it hurts when I do this! So
    -    don't do that!" so this can be written off.
    +    Do this via something like
    +
    +            GIT_INDEX_FILE=... git read-tree stash stash^3
    +
    +    and diffing the resulting tree object against the stash base.
    +
    +    One improvement that this could use for the future is performing the
    +    action without writing anything to disk as one would expect this to be a
    +    read-only operation. This can be fixed in the future, however.
    +
    +    Another limitation of this is that it would be possible to manually
    +    craft a stash entry where duplicate untracked files in the stash entry
    +    will mask tracked files. This seems like an instance of "Doctor, it
    +    hurts when I do this! So don't do that!" so this can be written off.
     
         Also, teach stash the --only-untracked option which only shows the
         untracked files of a stash entry. This is similar to `git show stash^3`
    @@ Documentation/git-stash.txt: stash@{1}: On master: 9cc0589... Add git-stash
      The command takes options applicable to the 'git log'
      command to control what is shown and how. See linkgit:git-log[1].
      
    --show [<diff options>] [<stash>]::
    -+show [-u|--include-untracked|--only-untracked] [<diff options>] [<stash>]::
    +-show [<diff-options>] [<stash>]::
    ++show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]::
      
      	Show the changes recorded in the stash entry as a diff between the
      	stashed contents and the commit back when the stash entry was first
    @@ Documentation/git-stash.txt: up with `git clean`.
      	This option is only valid for `pop` and `apply` commands.
     
      ## builtin/stash.c ##
    +@@ builtin/stash.c: static int git_stash_config(const char *var, const char *value, void *cb)
    + 	return git_diff_basic_config(var, value, cb);
    + }
    + 
    ++static int merge_track_untracked(struct object_id *result, const struct stash_info *info)
    ++{
    ++	int ret = 0;
    ++	struct index_state istate = { NULL };
    ++	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
    ++
    ++	if (!info->has_u) {
    ++		oidcpy(result, &info->w_commit);
    ++		return 0;
    ++	}
    ++
    ++	/*
    ++	 * TODO: is there a way of doing this all in-memory without writing
    ++	 * anything to disk?
    ++	 */
    ++	remove_path(stash_index_path.buf);
    ++
    ++	cp_read_tree.git_cmd = 1;
    ++	strvec_push(&cp_read_tree.args, "read-tree");
    ++	strvec_push(&cp_read_tree.args, oid_to_hex(&info->w_commit));
    ++	strvec_push(&cp_read_tree.args, oid_to_hex(&info->u_tree));
    ++	strvec_pushf(&cp_read_tree.env_array, "GIT_INDEX_FILE=%s",
    ++		     stash_index_path.buf);
    ++
    ++	if (run_command(&cp_read_tree)) {
    ++		ret = -1;
    ++		goto done;
    ++	}
    ++
    ++	if (write_index_as_tree(result, &istate, stash_index_path.buf, 0,
    ++				NULL)) {
    ++		ret = -1;
    ++		goto done;
    ++	}
    ++
    ++done:
    ++	discard_index(&istate);
    ++	remove_path(stash_index_path.buf);
    ++	return ret;
    ++}
    ++
    + static int show_stash(int argc, const char **argv, const char *prefix)
    + {
    + 	int i;
     @@ builtin/stash.c: static int show_stash(int argc, const char **argv, const char *prefix)
      	struct rev_info rev;
      	struct strvec stash_args = STRVEC_INIT;
      	struct strvec revision_args = STRVEC_INIT;
    ++	struct object_id *before = NULL;
    ++	struct object_id *after = NULL;
    ++	struct object_id untracked_merged_tree;
     +	enum {
     +		UNTRACKED_NONE,
     +		UNTRACKED_INCLUDE,
    @@ builtin/stash.c: static int show_stash(int argc, const char **argv, const char *
      	rev.diffopt.flags.recursive = 1;
      	setup_diff_pager(&rev.diffopt);
     -	diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
    -+	if (show_untracked != UNTRACKED_ONLY)
    -+		diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
    -+	if (show_untracked != UNTRACKED_NONE && info.has_u)
    -+		diff_root_tree_oid(&info.u_tree, "", &rev.diffopt);
    ++	switch (show_untracked) {
    ++	case UNTRACKED_NONE:
    ++		before = &info.b_commit;
    ++		after = &info.w_commit;
    ++		break;
    ++	case UNTRACKED_ONLY:
    ++		before = NULL;
    ++		after = &info.u_tree;
    ++		break;
    ++	case UNTRACKED_INCLUDE:
    ++		if (merge_track_untracked(&untracked_merged_tree, &info) < 0)
    ++			die(_("unable merge stash index with untracked files index"));
    ++		before = &info.b_commit;
    ++		after = &untracked_merged_tree;
    ++		break;
    ++	}
    ++	diff_tree_oid(before, after, "", &rev.diffopt);
      	log_tree_diff_flush(&rev);
      
      	free_stash_info(&info);
 9:  2c5d5d9dd4 !  9:  ac4019f47e stash show: learn stash.showIncludeUntracked
    @@ Documentation/config/stash.txt: stash.useBuiltin::
      	option will show the stash entry in patch form.  Defaults to false.
     
      ## Documentation/git-stash.txt ##
    -@@ Documentation/git-stash.txt: show [-u|--include-untracked|--only-untracked] [<diff options>] [<stash>]::
    +@@ Documentation/git-stash.txt: show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]::
      	By default, the command shows the diffstat, but it will accept any
      	format known to 'git diff' (e.g., `git stash show -p stash@{1}`
      	to view the second most recent entry in patch form).
-- 
2.30.0.478.g8a0d178c01

