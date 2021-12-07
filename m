Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AE7C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 05:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhLGFFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 00:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLGFFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 00:05:09 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3368AC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 21:01:39 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a18so26915742wrn.6
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 21:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=bFXntcva+GN4P4K9zdFRBc1YZuftO+t5Beu2Ss/dLLQ=;
        b=P8bQqydVX62e60sWO51m5FBZ1PRBbYhCcSFehWxqegDTFXYHHkYa9KmZXI8ycF+QOw
         tjbuZDFi8eHuUJEnlDZbNI0h/t/6x+FZgIAf3M4llc3ecbJ/NKzO/biw/MZgD2GRcnQQ
         YZaGB+nHpPdNEzf2vLcI91W4SAEUZ7dqMMFV5Iw3qlJf/TQ7EyBYib4SGgb6jIfgUkFA
         KNSb+/dHDQlKSq3UjpoCREZ5lrGCxxQxx9yxIbYZs8GWQ+yJgtfLzZTjF3Fhhv0tW14H
         2ts/PQ+NF29wfe/fGk7nZxqI7yXixDgkG1wJK4iWLRTDElf2zEhEGOCVptwZ9iNfZamF
         zHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=bFXntcva+GN4P4K9zdFRBc1YZuftO+t5Beu2Ss/dLLQ=;
        b=S+fterMd26ejdVzqPc2g2LNwCIJqiN15pitqbUogKV46slX1rM3/LqZVXez30DP0yr
         ouXAoRan0dSawGhCybEXhmVU0JU493uvoQBs2bastcIwYB/7oF9W8HgkRcTqG+JcFYEC
         /mv+6w0DVRm0dOVOlJCgJ8hT1O1FPYdaJ7Z5ohZdXNnjfJB8RQ1vJ0CXCO4Ulcx+8Nx5
         ohY0wejSvaGoTM8WfOv9prJTysqyMM0xy4YzOnAgexk+Sp/+PxQUioqUjRpUrnY5uM/S
         moUcOe7yeK5NV+BVjx/9XwzFpscju+KPf/P+UKCluY+XXXKySKJoJQKbPzh1BWLu4tEz
         jGTA==
X-Gm-Message-State: AOAM533mOSRYkt/Y96LdKOrCgdNqVpXfdwztO4SMAKNLWMiZAiIQLwwn
        T40nmZWuLBTk5Jgq57PIlvieSXEreTw=
X-Google-Smtp-Source: ABdhPJxdqTvx77KW3IrBB3k2j9V0BzUnhoUKz6ojQWO5sBWCqpFuDlDnVMuAGIgwS4IVOSj6WLPETw==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr50385985wrt.22.1638853297319;
        Mon, 06 Dec 2021 21:01:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm1457525wmq.32.2021.12.06.21.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 21:01:36 -0800 (PST)
Message-Id: <pull.1076.v16.git.1638853295.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v15.git.1638783690.gitgitgadget@gmail.com>
References: <pull.1076.v15.git.1638783690.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 05:01:32 +0000
Subject: [PATCH v16 0/3] am: support --empty=(die|drop|keep) option and --allow-empty option to
 handle empty patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option.
 2. rename the --always option to --allow-empty.

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit.
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Changes since v3:

 1. generate the missed file for test cases.
 2. grep -f cannot be used under Mac OS.

----------------------------------------------------------------------------

Changes since v4:

 1. rename the --empty-commit option to --empty.
 2. rename three different strategies (die|skip|asis) to die, drop and keep
    correspondingly.

----------------------------------------------------------------------------

Changes since v5:

 1. throw an error when passing --empty option without value.

----------------------------------------------------------------------------

Changes since v6:

 1. add i18n resources.

----------------------------------------------------------------------------

Changes since v7:

 1. update code according to the seen branch.
 2. fix the wrong document of git-am.
 3. sign off commits by a real name.

----------------------------------------------------------------------------

Changes since v8:

 1. update the committer's name with my real name to fix DCO of GGG.

----------------------------------------------------------------------------

Changes since v9:

 1. imitate the signed name format of
    https://lore.kernel.org/git/pull.1143.git.git.1637347813367.gitgitgadget@gmail.com
    .

----------------------------------------------------------------------------

Changes since v11:

 1. introduce an interactive option --allow-empty for git-am to record empty
    patches in the middle of an am session.

----------------------------------------------------------------------------

Changes since v12:

 1. record the empty patch as an empty commit only when there are no
    changes.
 2. fix indentation problems.
 3. simplify "to keep recording" to "to record".
 4. add a test case for skipping empty patches via the --skip option.

----------------------------------------------------------------------------

Changes since v13:

 1. add an additional description about the 'die' value.

----------------------------------------------------------------------------

Changes since v14:

 1. reimplement the 'die' value and stop the whole session. (Expected a
    reroll)
 2. the --allow-empty option is a valid resume value only when: (Expected a
    reroll)
    * index has not changed
    * lacking a patch

----------------------------------------------------------------------------

Changes since v15:

 1. rename "die" to "stop".

徐沛文 (Aleen) (3):
  doc: git-format-patch: describe the option --always
  am: support --empty=<option> to handle empty patches
  am: support --allow-empty to record specific empty patches

 Documentation/git-am.txt           |  16 ++++-
 Documentation/git-format-patch.txt |   6 +-
 builtin/am.c                       |  90 +++++++++++++++++++++----
 t/t4150-am.sh                      | 102 +++++++++++++++++++++++++++++
 t/t7512-status-help.sh             |   1 +
 wt-status.c                        |   3 +
 6 files changed, 203 insertions(+), 15 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v16
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v16
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v15:

 1:  a524ca6adfa = 1:  a524ca6adfa doc: git-format-patch: describe the option --always
 2:  8ec8e212672 ! 2:  b9e03f2342b am: support --empty=<option> to handle empty patches
     @@ Commit message
          commits that emit no changes, the 'git-am' command should also
          support an option, named as '--empty', to specify how to handle
          those empty patches. In this commit, we have implemented three
     -    valid options ('die', 'drop' and 'keep').
     +    valid options ('stop', 'drop' and 'keep').
      
          Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
      
     @@ Documentation/git-am.txt: SYNOPSIS
       	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
       	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
       	 [--quoted-cr=<action>]
     -+	 [--empty=(die|drop|keep)]
     ++	 [--empty=(stop|drop|keep)]
       	 [(<mbox> | <Maildir>)...]
       'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
       
     @@ Documentation/git-am.txt: OPTIONS
       --quoted-cr=<action>::
       	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
       
     -+--empty=(die|drop|keep)::
     -+	By default, the command errors out on an input e-mail message
     -+	lacking a patch and stops into the middle of the current am session.
     -+	When this option is set to 'die', the whole session dies with error.
     -+	When this option is set to 'drop', skip such an e-mail message instead.
     ++--empty=(stop|drop|keep)::
     ++	By default, or when the option is set to 'stop', the command
     ++	errors out on an input e-mail message lacking a patch
     ++	and stops into the middle of the current am session. When this
     ++	option is set to 'drop', skip such an e-mail message instead.
      +	When this option is set to 'keep', create an empty commit,
      +	recording the contents of the e-mail message as its log.
      +
     @@ builtin/am.c: enum show_patch_type {
       };
       
      +enum empty_action {
     -+	ERR_EMPTY_COMMIT = 0,  /* output errors and stop in the middle of an am session */
     -+	DIE_EMPTY_COMMIT,      /* output errors and stop the whole am session */
     -+	DROP_EMPTY_COMMIT,     /* skip with a notice message, unless "--quiet" has been passed */
     -+	KEEP_EMPTY_COMMIT      /* keep recording as empty commits */
     ++	STOP_ON_EMPTY_COMMIT = 0,  /* output errors and stop in the middle of an am session */
     ++	DROP_EMPTY_COMMIT,         /* skip with a notice message, unless "--quiet" has been passed */
     ++	KEEP_EMPTY_COMMIT          /* keep recording as empty commits */
      +};
      +
       struct am_state {
     @@ builtin/am.c: static int am_option_parse_quoted_cr(const struct option *opt,
      +
      +	BUG_ON_OPT_NEG(unset);
      +
     -+	if (!strcmp(arg, "die"))
     -+		*opt_value = DIE_EMPTY_COMMIT;
     ++	if (!strcmp(arg, "stop"))
     ++		*opt_value = STOP_ON_EMPTY_COMMIT;
      +	else if (!strcmp(arg, "drop"))
      +		*opt_value = DROP_EMPTY_COMMIT;
      +	else if (!strcmp(arg, "keep"))
     @@ builtin/am.c: static void am_run(struct am_state *state, int resume)
      +			case KEEP_EMPTY_COMMIT:
      +				to_keep = 1;
      +				break;
     -+			case DIE_EMPTY_COMMIT:
     -+				am_destroy(state);
     -+				die(_("Patch is empty."));
     -+				break;
     -+			case ERR_EMPTY_COMMIT:
     ++			case STOP_ON_EMPTY_COMMIT:
      +				printf_ln(_("Patch is empty."));
      +				die_user_resolve(state);
      +				break;
     @@ builtin/am.c: int cmd_am(int argc, const char **argv, const char *prefix)
       		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
       		  N_("GPG-sign commits"),
       		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
     -+		OPT_CALLBACK_F(ERR_EMPTY_COMMIT, "empty", &state.empty_type, "{die,drop,keep}",
     ++		OPT_CALLBACK_F(STOP_ON_EMPTY_COMMIT, "empty", &state.empty_type, "{stop,drop,keep}",
      +		  N_("how to handle empty patches"),
      +		  PARSE_OPT_NONEG, am_option_parse_empty),
       		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
     @@ t/t4150-am.sh: test_expect_success 'apply binary blob in partial clone' '
      +	test_cmp expected err
      +'
      +
     -+test_expect_success 'a message without a patch is an error and stop in the middle of an am session (default)' '
     ++test_expect_success 'a message without a patch is an error (default)' '
      +	test_when_finished "git am --abort || :" &&
      +	test_must_fail git am empty-commit.patch >err &&
     -+	test_path_is_dir .git/rebase-apply &&
      +	grep "Patch is empty" err
      +'
      +
     -+test_expect_success 'a message without a patch is an error and exit where an explicit "--empty=die" is given' '
     -+	test_must_fail git am --empty=die empty-commit.patch 2>err &&
     -+	test_path_is_missing .git/rebase-apply &&
     -+	grep "fatal: Patch is empty." err
     ++test_expect_success 'a message without a patch is an error where an explicit "--empty=stop" is given' '
     ++	test_when_finished "git am --abort || :" &&
     ++	test_must_fail git am --empty=stop empty-commit.patch >err &&
     ++	grep "Patch is empty." err
      +'
      +
      +test_expect_success 'a message without a patch will be skipped when "--empty=drop" is given' '
 3:  d669406a312 ! 3:  abcdfa1b375 am: support --allow-empty to record specific empty patches
     @@ Commit message
       ## Documentation/git-am.txt ##
      @@ Documentation/git-am.txt: SYNOPSIS
       	 [--quoted-cr=<action>]
     - 	 [--empty=(die|drop|keep)]
     + 	 [--empty=(stop|drop|keep)]
       	 [(<mbox> | <Maildir>)...]
      -'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
      +'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)] | --allow-empty)
     @@ Documentation/git-am.txt: default.   You can use `--no-utf8` to override this.
      
       ## builtin/am.c ##
      @@ builtin/am.c: static void am_run(struct am_state *state, int resume)
     - 				die(_("Patch is empty."));
     + 				to_keep = 1;
       				break;
     - 			case ERR_EMPTY_COMMIT:
     + 			case STOP_ON_EMPTY_COMMIT:
      -				printf_ln(_("Patch is empty."));
      +				printf_ln(_("Patch is empty.\n"
      +					    "If you want to record it as an empty commit, run \"git am --allow-empty\"."));
     @@ builtin/am.c: next:
        * all the hard work, and we do not have to do any patch application. Just
      - * trust and commit what the user has in the index and working tree.
      + * trust and commit what the user has in the index and working tree. If `allow_empty`
     -+ * is true, commit as an empty commit when there is no changes.
     ++ * is true, commit as an empty commit when index had not changed and lacking a patch.
        */
      -static void am_resolve(struct am_state *state)
      +static void am_resolve(struct am_state *state, int allow_empty)
     @@ builtin/am.c: next:
      -		printf_ln(_("No changes - did you forget to use 'git add'?\n"
      -			"If there is nothing left to stage, chances are that something else\n"
      -			"already introduced the same changes; you might want to skip this patch."));
     -+	/**
     -+	 * "--allow-empty" is a valid resume value only when:
     -+	 *   1. index has not changed
     -+	 *   2. lacking a patch
     -+	 */
      +	index_changed = repo_index_has_changes(the_repository, NULL, NULL);
      +	if (allow_empty && (index_changed || !is_empty_or_missing_file(am_path(state, "patch")))) {
      +		printf_ln(_("Invalid resume value."));

-- 
gitgitgadget
