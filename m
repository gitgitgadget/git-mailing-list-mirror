Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A6DC07E99
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30826161F
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhGHPx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhGHPx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 11:53:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B87C06175F
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 08:50:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso4365692wmj.0
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GaryDIQzcg1XIuhjHDlDR7rj0ie2nYaglvsdzy/ivlM=;
        b=FhB4fah9hc0Cw7Cp5twWWtZ6GlsLTdIS3XZTUkWhSv5Sft/hiuJ/aunbbMAqExnKL3
         dZ8nvbGM2zJ6fyPbJWQ+33bbi74TJi8VLb7ho3arUNQza3Y7DjaiC4n2WT1cIdYG/lk4
         F/ct3iK6MSyVdyKzYhfZN8tb3dMqcUg/jivVgARgObPXFpLC2QPddcneNLzUe5luNNgQ
         Andic362bMuU0CpHG5CapYzwh2fdNRA5aNvD14ywz63CdOhgc42IFeMGeQ0Har4lb2im
         hGoq3JX4GslUXbCKrOhqAylimGgOOX8OhtxcfUlyWCtxCuFf1I2VBSWfr4tBdNrYLRek
         mqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GaryDIQzcg1XIuhjHDlDR7rj0ie2nYaglvsdzy/ivlM=;
        b=V5ryhc2Wytw6/hccfgnzCMwzN8xIQjdf1+ZbB22Zm8wD5hiD+jXgSO2/FTXDaYRfbs
         3E2QMgldZ+LHOyT/6ac8Bs4uEXPK9Cohz+RC1eJ427xZVMPKEOn8Qy5695YvuSdiAY+x
         XzhjePpIEFREz3VvI17hUztZ5NIznNJmLBCRhIZFT0mITaE/5p6fP3QZTvnmWt01xv2h
         etWNmN0qOO7qTVJbjERj+yMIQVwBY3AjM3/YbBAj8Vlh1K9/4n7d5o5ShqD91pOWK3U3
         VF04zzYiZjqXWq0W5NxTMI55v4RjNTyMTNKVlOlQNQNQkfVwzlxXrQ7Lak0bmXaa/aC/
         6I8Q==
X-Gm-Message-State: AOAM531eivLLZkwUGQOHMsfTJ0w6CYonka1xn2MZmk7iiLVwKw/dSmlJ
        zn68t8SonJrlUvLdJ/tUej6bP1TbUc4=
X-Google-Smtp-Source: ABdhPJyBZzjWbiPUtvW25nPfM9u63mkqqASTvTmSYiSppzLq9WuaLHJD1Q1ea2rPVgv1vIgwQ/4nig==
X-Received: by 2002:a1c:e3d6:: with SMTP id a205mr15779871wmh.132.1625759444748;
        Thu, 08 Jul 2021 08:50:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3sm2549386wrx.77.2021.07.08.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 08:50:44 -0700 (PDT)
Message-Id: <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
From:   "Stephen Manz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Jul 2021 15:50:40 +0000
Subject: [PATCH v2 0/3] worktree: teach add to accept --reason with --lock
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Stephen Manz <smanz@alum.mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default reason stored in the lock file, "added with --lock", is unlikely
to be what the user would have given in a separate git worktree lock
command. Allowing --reason to be specified along with --lock when adding a
working tree gives the user control over the reason for locking without
needing a second command.

Changes since v1:

 * Split changes into 3 commits. The first commit is removal of git
   rev-parse in the test above the ones I'm adding. The second is wrapping
   the "added with --lock" string with _() to mark it for translation. The
   third commit is the main change.
 * Reworked the if-else-if-else to if-else if-else
 * Added test_when_finished ... command to unlock the working tree
 * Changed test_expect_failure to test_expect_success and embedded
   test_must_fail and test_path_is_missing commands

Note: I don't see how to disambiguate --lock with no --reason from no --lock
at all. I still think that the original keep_locked boolean is needed along
with the new lock_reason char array. If I don't add lock_reason and change
keep_locked to a char array, it will start as NULL. But it will remain NULL
if --lock alone is given or if --lock isn't given at all.

Stephen Manz (3):
  t2400: remove unneeded `git rev-parse` from '"add" worktree with lock'
    test
  worktree: default lock string should be marked with `_()` for
    translation
  worktree: teach `add` to accept --reason <string> with --lock

 Documentation/git-worktree.txt |  4 ++--
 builtin/worktree.c             |  9 ++++++++-
 t/t2400-worktree-add.sh        | 14 +++++++++++++-
 3 files changed, 23 insertions(+), 4 deletions(-)


base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-992%2FSRManz%2Flock_reason-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-992/SRManz/lock_reason-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/992

Range-diff vs v1:

 -:  ----------- > 1:  5459e5bb421 t2400: remove unneeded `git rev-parse` from '"add" worktree with lock' test
 -:  ----------- > 2:  30196cc9369 worktree: default lock string should be marked with `_()` for translation
 1:  233a580b212 ! 3:  4d17b31921a worktree: teach `add` to accept --reason <string> with --lock
     @@ builtin/worktree.c: struct add_opts {
       
       static int show_only;
      @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
     - 	 * after the preparation is over.
     - 	 */
       	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
     --	if (!opts->keep_locked)
     -+	if (!opts->keep_locked) {
     + 	if (!opts->keep_locked)
       		write_file(sb.buf, "initializing");
     --	else
     --		write_file(sb.buf, "added with --lock");
     -+	}
     -+	else {
     -+		if (opts->lock_reason)
     -+			write_file(sb.buf, "%s", opts->lock_reason);
     -+		else
     -+			write_file(sb.buf, _("added with --lock"));
     -+	}
     ++	else if (opts->lock_reason)
     ++		write_file(sb.buf, "%s", opts->lock_reason);
     + 	else
     + 		write_file(sb.buf, _("added with --lock"));
       
     - 	strbuf_addf(&sb_git, "%s/.git", path);
     - 	if (safe_create_leading_directories_const(sb_git.buf))
      @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix)
       		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
       		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
     @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix)
       
      
       ## t/t2400-worktree-add.sh ##
     -@@ t/t2400-worktree-add.sh: test_expect_success '"add" worktree' '
     - '
     - 
     - test_expect_success '"add" worktree with lock' '
     --	git rev-parse HEAD >expect &&
     - 	git worktree add --detach --lock here-with-lock main &&
     +@@ t/t2400-worktree-add.sh: test_expect_success '"add" worktree with lock' '
       	test -f .git/worktrees/here-with-lock/locked
       '
       
      +test_expect_success '"add" worktree with lock and reason' '
      +	git worktree add --detach --lock --reason "why not" here-with-lock-reason main &&
     ++	test_when_finished "git worktree unlock here-with-lock-reason || :" &&
      +	test -f .git/worktrees/here-with-lock-reason/locked &&
      +	echo why not >expect &&
      +	test_cmp expect .git/worktrees/here-with-lock-reason/locked
      +'
      +
     -+test_expect_failure '"add" worktree with reason but no lock' '
     -+	git worktree add --detach --reason "why not" here-with-reason-only main &&
     -+	test -f .git/worktrees/here-with-reason-only/locked
     ++test_expect_success '"add" worktree with reason but no lock' '
     ++	test_must_fail git worktree add --detach --reason "why not" here-with-reason-only main &&
     ++	test_path_is_missing .git/worktrees/here-with-reason-only/locked
      +'
      +
       test_expect_success '"add" worktree from a subdir' '

-- 
gitgitgadget
