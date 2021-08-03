Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F44C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 01:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0AF60EFF
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 01:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhHCBQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 21:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhHCBQg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 21:16:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C10C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 18:16:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b13so12577794wrs.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 18:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oxmjZgED4AzcjtlSPhG8ik+o7rtZY5UeYkgbkFoZjdg=;
        b=rPJs2x75aU+6zuzY69RIdPtrA/igpDfhytSinBhUK82BkbSaPQztju6b+pqCoFiUNb
         e6VERHwuc+HX4Wu6FrdrPMubyASAV/JLiaLA6EOnTthp4dPgkAQngkVkLMKthZN/Wuup
         hf+02X0+Ztc/VaaGvAo8WOYWEQMrVunk07B9WmwX5/57F+qeHIPTdlPN9ZurYVRjKFnc
         AQCs7FJW0fnhJQ5BSFD6IsDqeYFSN5+1+7vtS6LjCy4rBozNGhILGkkYpQ4sqe7B6z9e
         V6L6RktX1Qj+yKbyE443XPGF82ckHYaYPckAiEuuESXIdr03ST3ITW6LG4ZhCAF2mhRE
         l82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oxmjZgED4AzcjtlSPhG8ik+o7rtZY5UeYkgbkFoZjdg=;
        b=PClq8KEylB5WNo+8eQnx/zamvVL+1TT4hq1UgXYbhA1ht5ZvX23yKSa8TYkRjLPQpB
         1E4ULVFrkqLMF+aRZr8COhzuJRmbGJbvBoOECdOx71lqgXuBm0ZC0mD4XNrt/+ZbNVvD
         S5MOpWoEOhv51sNhwwfsWsVC1yBw3VfMqB/EZZdKfTr/tg+Ih5ekND0qroG4t/vyAEVL
         yvQqtIIZujjAVvlWo9i2qin33X/OSRM/6db2YxMB+m+Yoa7ryobrdO5FzjvprPQFR7eh
         eikqa/cL1RRggLQa2Px3JFklbMoTnCl63IYx0kw+xfv9DOXEtGYgLIXDuv327weO9Ux0
         2YLA==
X-Gm-Message-State: AOAM531a6I1nEylnOEjVGCqrf9LYu/Y1jF3JZzWcoD4ZVzoQIan1A1Zk
        Xu2Tf9iCmwW2fUHbJSuBL33ZOm3wnTY=
X-Google-Smtp-Source: ABdhPJxEHCnEmvKOVLnEDmOK6VEZUDvyRNdIbzHY+GkTTdD5GYbwZ5NbGQ/Xhvt0/JUzMdULR1Vp/w==
X-Received: by 2002:a05:6000:1c4:: with SMTP id t4mr19593750wrx.79.1627953384404;
        Mon, 02 Aug 2021 18:16:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm13522528wrv.65.2021.08.02.18.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 18:16:23 -0700 (PDT)
Message-Id: <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
In-Reply-To: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
References: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 01:16:20 +0000
Subject: [PATCH v2 0/2] [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch fixes the bug when git cherry-pick is used with environment
variable GIT_CHERRY_PICK_HELP, and makes git chery-pick advice message
better.

v4:
https://lore.kernel.org/git/pull.1010.git.1627714877.gitgitgadget@gmail.com/

v4-->v5:

 1. Delete struct rebase_options member delete_cherry_pick_head, and set the
    delete_cherry_pick_head in struct replay_opts replay to 1 in
    get_replay_opts().
 2. Avoid too long line length of advice of cherry-pick, split "git
    cherry-pick --continue" in advice to new line.

ZheNing Hu (2):
  [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
  [GSOC] cherry-pick: use better advice message

 builtin/rebase.c                |  1 +
 builtin/revert.c                |  2 ++
 git-rebase--preserve-merges.sh  |  2 +-
 sequencer.c                     | 38 +++++++++++++++-----------
 sequencer.h                     |  1 +
 t/t3507-cherry-pick-conflict.sh | 48 ++++++++++++++++++++++-----------
 6 files changed, 60 insertions(+), 32 deletions(-)


base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1010%2Fadlternative%2Fcherry-pick-help-fix-3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1010/adlternative/cherry-pick-help-fix-3-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1010

Range-diff vs v1:

 1:  0d0a55bd9c4 ! 1:  5d2fd55c580 [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
     @@ Commit message
          conflict occurs, which provided for some porcelain commands of git like
          `git-rebase--preserve-merges.sh`. After `git rebase -p` completely
          abolished, this option should be removed. At the same time, add the flag
     -    `delete_cherry_pick_head` to `struct rebase_options` and
     -    `struct replay_opts`, We can decide whether to delete CHERRY_PICK_HEAD
     -    by setting, passing, and checking this flag bit.
     +    `delete_cherry_pick_head` to `struct replay_opts`, We can decide whether
     +    to delete CHERRY_PICK_HEAD by setting and checking this flag bit.
      
          Then we split print_advice() into two part: Firstly, print_advice()
          will only be responsible for outputting content; Secondly, check if
     @@ Commit message
          In this way, the steps of printing advice and deleting CHERRY_PICK_HEAD
          are decoupled. Finally, let `git-rebase--preserve-merges.sh` use the
          `--delete-cherry-pick-head` option when it executes git cherry-pick, and
     -    set the `delete_cherry_pick_head` flag in run_specific_rebase() when we
     +    set the `delete_cherry_pick_head` flag in get_replay_opts() when we
          are using `git rebase --merge`, which can fix this breakage.
      
     +    It is worth mentioning that now we use advice() to print the content
     +    of GIT_CHERRY_PICK_HELP in print_advice(), each line of output will
     +    start with "hint: ".
     +
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by Hariom Verma <hariom18599@gmail.com>:
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     @@ Commit message
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## builtin/rebase.c ##
     -@@ builtin/rebase.c: struct rebase_options {
     - 		REBASE_FORCE = 1<<3,
     - 		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
     - 	} flags;
     -+	int delete_cherry_pick_head;
     - 	struct strvec git_am_opts;
     - 	const char *action;
     - 	int signoff;
      @@ builtin/rebase.c: static struct replay_opts get_replay_opts(const struct rebase_options *opts)
       		oidcpy(&replay.squash_onto, opts->squash_onto);
       		replay.have_squash_onto = 1;
       	}
     -+	replay.delete_cherry_pick_head = opts->delete_cherry_pick_head;
     ++	replay.delete_cherry_pick_head = 1;
       
       	return replay;
       }
     -@@ builtin/rebase.c: static int run_specific_rebase(struct rebase_options *opts, enum action action)
     - 	if (opts->type == REBASE_MERGE) {
     - 		/* Run sequencer-based rebase */
     - 		setenv("GIT_CHERRY_PICK_HELP", resolvemsg, 1);
     -+		opts->delete_cherry_pick_head = 1;
     - 		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
     - 			setenv("GIT_SEQUENCE_EDITOR", ":", 1);
     - 			opts->autosquash = 0;
      
       ## builtin/revert.c ##
      @@ builtin/revert.c: static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
     @@ t/t3507-cherry-pick-conflict.sh: test_expect_success 'advice from failed cherry-
       test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
       	pristine_detach initial &&
       	test_must_fail git cherry-pick picked &&
     + 	test_cmp_rev picked CHERRY_PICK_HEAD
     + '
     + 
     ++test_expect_success 'failed cherry-pick with --delete-cherry-pick-head does not set CHERRY_PICK_HEAD' '
     ++	pristine_detach initial &&
     ++	test_must_fail git cherry-pick --delete-cherry-pick-head picked &&
     ++	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
     ++'
     ++
     + test_expect_success 'successful cherry-pick does not set CHERRY_PICK_HEAD' '
     + 	pristine_detach initial &&
     + 	git cherry-pick base &&
      @@ t/t3507-cherry-pick-conflict.sh: test_expect_success \
       	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
       '
 2:  7e1ed49728d ! 2:  5279bca7a79 [GSOC] cherry-pick: use better advice message
     @@ Commit message
          This is the improved advice:
      
          hint: Resolve all conflicts manually, mark them as resolved with
     -    hint: "git add/rm <conflicted_files>", then run "git cherry-pick \
     -    --continue".
     +    hint: "git add/rm <conflicted_files>", then run
     +    hint: "git cherry-pick --continue".
          hint: You can instead skip this commit: run "git cherry-pick --skip".
          hint: To abort and get back to the state before "git cherry-pick",
          hint: run "git cherry-pick --abort".
     @@ sequencer.c: static void print_advice(struct replay_opts *opts, int show_hint)
      -		if (opts->no_commit)
      +		if (opts->action == REPLAY_PICK) {
      +			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
     -+				 "\"git add/rm <conflicted_files>\", then run \"git cherry-pick --continue\".\n"
     ++				 "\"git add/rm <conflicted_files>\", then run\n"
     ++				 "\"git cherry-pick --continue\".\n"
      +				 "You can instead skip this commit: run \"git cherry-pick --skip\".\n"
      +				 "To abort and get back to the state before \"git cherry-pick\",\n"
      +				 "run \"git cherry-pick --abort\"."));
     @@ t/t3507-cherry-pick-conflict.sh: test_expect_success 'advice from failed cherry-
      -	hint: with 'git add <paths>' or 'git rm <paths>'
      -	hint: and commit the result with 'git commit'
      +	hint: Resolve all conflicts manually, mark them as resolved with
     -+	hint: \"git add/rm <conflicted_files>\", then run \"git cherry-pick --continue\".
     ++	hint: \"git add/rm <conflicted_files>\", then run
     ++	hint: \"git cherry-pick --continue\".
      +	hint: You can instead skip this commit: run \"git cherry-pick --skip\".
      +	hint: To abort and get back to the state before \"git cherry-pick\",
      +	hint: run \"git cherry-pick --abort\".
     @@ t/t3507-cherry-pick-conflict.sh: test_expect_success 'advice from failed cherry-
      -	hint: after resolving the conflicts, mark the corrected paths
      -	hint: with 'git add <paths>' or 'git rm <paths>'
      +	hint: Resolve all conflicts manually, mark them as resolved with
     -+	hint: \"git add/rm <conflicted_files>\", then run \"git cherry-pick --continue\".
     ++	hint: \"git add/rm <conflicted_files>\", then run
     ++	hint: \"git cherry-pick --continue\".
      +	hint: You can instead skip this commit: run \"git cherry-pick --skip\".
      +	hint: To abort and get back to the state before \"git cherry-pick\",
      +	hint: run \"git cherry-pick --abort\".

-- 
gitgitgadget
