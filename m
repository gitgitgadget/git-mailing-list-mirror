Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788A2C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 09:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbhK3J6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 04:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbhK3J6h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 04:58:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E8C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 01:55:18 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a18so43125028wrn.6
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 01:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=bmsliC5ESBWii1OQo62NEhUYVVUvYzGUUGoKxXEY+u8=;
        b=n3QoqE/zq8oN9cSAXkMTOawEWVjhB31QYueWNiVDFuA6aZos+rouwsXbOMbW7yE7O6
         mvyR/1n4v3k6Cwyt8ZI4EvBfmT3MXG0MsrAI+KU1Nx8WLpHb0ew8wjD7qcf0P3Y9WBBa
         wt4usYb/wwxvtwIKXWGb8FOiiQTLWJXPk9hJM29EZPL+8Yd9Exj1kpLSI9A+MdJRwENI
         O2EsCCKfwns8ed/xB9c8Ga4iph6MvYiFtyEPlMCvW8EvDSj1UsIUnL9AngTdkeoflnfx
         5y8sBj/pjmCb6HTy6lDAO6Octd2+0VGUFSayl1IuLS0GdYIGX+qYEez9zpuUIdic2LsL
         lNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=bmsliC5ESBWii1OQo62NEhUYVVUvYzGUUGoKxXEY+u8=;
        b=Uf4j+DtCrH3QzYs7JIAabZThHWptekdXYzdwzPS1Z6659U18wjWFD/MulGSnPRi9lA
         50bWjQV4Yxzu47QEIiMMM551hvxvuhcZ3kmVwmlRdMlxPL/hTfo/ZYf7+bBXTwWMhVte
         /siTED7ugdHRlJ30atXMmfL608HVPXyy8ek/RKDAEtMRBskfRlxEMZNgnnYXuDZ2Z04/
         hFH5dFGxxd/BCafa3YXdM4cNy36OxQOLPZN7sPl4XxGfQPsp6Ri8CyS0FiL43YPjQW7P
         5ZODwpXHu0mQraqCUTyNyc92gyqo9jKQ1aCqEc5KLV48Z5ubuv5YIZiThYUqctA2463L
         UqYg==
X-Gm-Message-State: AOAM5325WAoDFkaOZ7kwkTwrFTsJxO6NrkTyb4U/4I6vLUiZBLI8yMJd
        ARGjQjkltXyVUvnue6JiGRJtxQgEiXA=
X-Google-Smtp-Source: ABdhPJxpXQD/RxD+9k0AMswnPyyeUV2ktXgzt6E/hmxhsUVAnm6d+C3JFO3UsoRpMUTOD9+ujndfGw==
X-Received: by 2002:adf:f98c:: with SMTP id f12mr39802428wrr.184.1638266116588;
        Tue, 30 Nov 2021 01:55:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm2023096wmf.2.2021.11.30.01.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 01:55:16 -0800 (PST)
Message-Id: <pull.1076.v13.git.1638266115.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v12.git.1638250645.gitgitgadget@gmail.com>
References: <pull.1076.v12.git.1638250645.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 09:55:12 +0000
Subject: [PATCH v13 0/3] am: support --empty=(die|drop|keep) option and --allow-empty option to
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

徐沛文 (Aleen) (3):
  doc: git-format-patch: describe the option --always
  am: support --empty=<option> to handle empty patches
  am: support --allow-empty to record specific empty patches

 Documentation/git-am.txt           | 14 ++++-
 Documentation/git-format-patch.txt |  6 ++-
 builtin/am.c                       | 82 +++++++++++++++++++++++++-----
 t/t4150-am.sh                      | 73 ++++++++++++++++++++++++++
 t/t7512-status-help.sh             |  1 +
 wt-status.c                        |  3 ++
 6 files changed, 164 insertions(+), 15 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v13
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v13
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v12:

 1:  a524ca6adfa = 1:  a524ca6adfa doc: git-format-patch: describe the option --always
 2:  a3e850bab7d = 2:  a3e850bab7d am: support --empty=<option> to handle empty patches
 3:  d44dac09c87 ! 3:  08bd397ae7a am: support --allow-empty to record specific empty patches
     @@ Documentation/git-am.txt: default.   You can use `--no-utf8` to override this.
       	Defaults to `raw`.
       
      +--allow-empty::
     -+	Keep recording the empty patch as an empty commit with
     ++	Record the empty patch as an empty commit with
      +	the contents of the e-mail message as its log.
      +
       DISCUSSION
     @@ builtin/am.c: static void am_run(struct am_state *state, int resume)
       			case DIE_EMPTY_COMMIT:
      -				printf_ln(_("Patch is empty."));
      +				printf_ln(_("Patch is empty.\n"
     -+							"If you want to keep recording it, run \"git am --allow-empty\"."));
     ++					    "If you want to record it as an empty commit, run \"git am --allow-empty\"."));
       				die_user_resolve(state);
       				break;
       			}
     @@ builtin/am.c: next:
        * all the hard work, and we do not have to do any patch application. Just
      - * trust and commit what the user has in the index and working tree.
      + * trust and commit what the user has in the index and working tree. If `allow_empty`
     -+ * is true, commit as an empty commit.
     ++ * is true, commit as an empty commit when there is no changes.
        */
      -static void am_resolve(struct am_state *state)
      +static void am_resolve(struct am_state *state, int allow_empty)
       {
     -+	if (allow_empty) {
     -+		goto commit;
     -+	}
     -+
       	validate_resume_state(state);
       
       	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
     -@@ builtin/am.c: static void am_resolve(struct am_state *state)
     - 
     - 	repo_rerere(the_repository, 0);
       
     -+commit:
     - 	do_commit(state);
     + 	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
     +-		printf_ln(_("No changes - did you forget to use 'git add'?\n"
     +-			"If there is nothing left to stage, chances are that something else\n"
     +-			"already introduced the same changes; you might want to skip this patch."));
     +-		die_user_resolve(state);
     ++		if (allow_empty)
     ++			printf_ln(_("No changes - record it as an empty commit."));
     ++		else {
     ++			printf_ln(_("No changes - did you forget to use 'git add'?\n"
     ++				    "If there is nothing left to stage, chances are that something else\n"
     ++				    "already introduced the same changes; you might want to skip this patch."));
     ++			die_user_resolve(state);
     ++		}
     + 	}
       
     - next:
     + 	if (unmerged_cache()) {
      @@ builtin/am.c: enum resume_type {
       	RESUME_SKIP,
       	RESUME_ABORT,
     @@ builtin/am.c: int cmd_am(int argc, const char **argv, const char *prefix)
       		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
       		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
      +		OPT_CMDMODE(0, "allow-empty", &resume.mode,
     -+			N_("keep recording the empty patch as empty commits"),
     ++			N_("record the empty patch as an empty commit"),
      +			RESUME_ALLOW_EMPTY),
       		OPT_BOOL(0, "committer-date-is-author-date",
       			&state.committer_date_is_author_date,
     @@ builtin/am.c: int cmd_am(int argc, const char **argv, const char *prefix)
       		break;
       	case RESUME_RESOLVED:
      -		am_resolve(&state);
     -+		am_resolve(&state, 0);
     -+		break;
      +	case RESUME_ALLOW_EMPTY:
     -+		am_resolve(&state, 1);
     ++		am_resolve(&state, resume.mode == RESUME_ALLOW_EMPTY ? 1 : 0);
       		break;
       	case RESUME_SKIP:
       		am_skip(&state);
     @@ t/t4150-am.sh: test_expect_success 'record as an empty commit when meeting e-mai
       	test_cmp actual expected
       '
       
     ++test_expect_success 'skip an empty patch in the middle of an am session' '
     ++	git checkout empty-commit^ &&
     ++	test_must_fail git am empty-commit.patch >err &&
     ++	grep "Patch is empty." err &&
     ++	grep "If you want to record it as an empty commit, run \"git am --allow-empty\"." err &&
     ++	git am --skip &&
     ++	test_path_is_missing .git/rebase-apply &&
     ++	git rev-parse empty-commit^ >expected &&
     ++	git rev-parse HEAD >actual &&
     ++	test_cmp expected actual
     ++'
      +
     -+test_expect_success 'record as an empty commit in the middle of an am session' '
     ++test_expect_success 'record an empty patch as an empty commit in the middle of an am session' '
      +	git checkout empty-commit^ &&
      +	test_must_fail git am empty-commit.patch >err &&
      +	grep "Patch is empty." err &&
     -+	grep "If you want to keep recording it, run \"git am --allow-empty\"." err &&
     ++	grep "If you want to record it as an empty commit, run \"git am --allow-empty\"." err &&
      +	git am --allow-empty &&
     ++	test_path_is_missing .git/rebase-apply &&
      +	git show empty-commit --format="%s" >expected &&
      +	git show HEAD --format="%s" >actual &&
      +	test_cmp actual expected
     @@ t/t7512-status-help.sh: test_expect_success 'status in an am session: empty patc
       On branch am_empty
       You are in the middle of an am session.
       The current patch is empty.
     -+  (use "git am --allow-empty" to keep recording this empty patch)
     ++  (use "git am --allow-empty" to record this patch as an empty commit)
         (use "git am --skip" to skip this patch)
         (use "git am --abort" to restore the original branch)
       
     @@ wt-status.c: static void show_am_in_progress(struct wt_status *s,
       				_("  (fix conflicts and then run \"git am --continue\")"));
      +		else
      +			status_printf_ln(s, color,
     -+				_("  (use \"git am --allow-empty\" to keep recording this empty patch)"));
     ++				_("  (use \"git am --allow-empty\" to record this patch as an empty commit)"));
       		status_printf_ln(s, color,
       			_("  (use \"git am --skip\" to skip this patch)"));
       		status_printf_ln(s, color,

-- 
gitgitgadget
