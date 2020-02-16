Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E06C2BA83
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 15:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8358E2084E
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 15:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKWTqyzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgBPPB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 10:01:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34699 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgBPPB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 10:01:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id n10so14645126wrm.1
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 07:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q4EyapXwjqqot3NGwbUyockuC3FCqj+2czyoiOF7Bjs=;
        b=FKWTqyzL/LFmVeLriL6PVQeJiNVh4cIJ0B9+IqTyFyUg/ylN47i53X2L4vN0bIWhYK
         zZzQCCIhGjPsZn4sxDumRzM8OAdaIMK64aNcp0yeql3cvSipSVFeB6Yug2joCuYQCiKS
         ukBQl5yefVw0/wRE5znZNTl9o7+w7Z0BWTNE6OtfwEfjYvPTxc74ljASfySMzaH1dzq+
         gAkyFKexdrakmqsMvfUjHojvKU1KAUWz3a7dVlJMmUOKQmsAmUiyMfO85hBKplyER/xE
         OBBXb1+yJ5ITz/gb9P4flZKHoBZVTwXw6paDSU3UFHlhDLJC2IPF8D3lnLKBEKrw8cWI
         D94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Q4EyapXwjqqot3NGwbUyockuC3FCqj+2czyoiOF7Bjs=;
        b=kp+3hUMPL6vt613gPtrqlkD3YIR1iFhAoikzix1RAX8rMhn2f3netq9cEfl4/+3D4X
         Swc74v8zOjbfhu6L2615c4uOrQrK3ZIcZOkLkkygoXK2/EYhnuV1WR5ia0K7PHGPg5XW
         nHU+uQF8P2v/0Y2OMD2ZLUG+LPxhN37O3Kb6ii+l3CmHXJeOGAtX3stT8LMYJiAvGqQJ
         OsvTfu9Xvfvt1gN0h3ZrHGpHufyCQ+MbqZAL5Qjyn/pqSB+BvxnOSEGLyzzso5cDtlIy
         UNhjl2NAKjXD0LL8piGo73chgo/tG6NmxVgzdlkW2e++S/ETKNGNvQJnGWE4WDDJ+U2+
         5/og==
X-Gm-Message-State: APjAAAXiIw1pSNZPG6CPYdV7C0BbfXaXJqQzoq5fh61ofsep5EwVTtZm
        nZC9mwT+N35OvqxNl43OcoA=
X-Google-Smtp-Source: APXvYqxteWL4lOkNU78rYd64qgyCNxII8TAfvgSFz62txb9ScCOwexh/WWZGeqdOqmsp77nHWa5gjw==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr15636890wrq.137.1581865313385;
        Sun, 16 Feb 2020 07:01:53 -0800 (PST)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id n3sm16672668wmc.27.2020.02.16.07.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 07:01:52 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 00/20] rebase: make the default backend configurable
 and change the default
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e2863381-174c-a55c-bb22-0c7aec9cabf4@gmail.com>
Date:   Sun, 16 Feb 2020 15:01:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 15/02/2020 21:36, Elijah Newren via GitGitGadget wrote:
> This is v5 of en/rebase-backend based on v2.25.0. This series does a lot of
> work around making the default rebase backend configurable, and switches the
> default from the apply backend to the merge one.
> 
> Changes since v4:
> 
>   * Added a note about an unfortunately-timed Ctrl-C to the docs, as
>     suggested by SZEDER.

That's a good idea - I don't know why builtin/rebase.c only calls 
rebase_write_basic_state() which writes head-name after it has run 
format-patch and am. We write the patches to the state directory so it's 
not like it saves us from having to clean up.

>   * Addressed feedback from Phillip
>   * Added a new patch at the end renaming the two backends. PLEASE take a
>     look at its commit message for rationale and let me know if you agree
>     with it.

I had a look and I think it is a good idea - merge and apply make much 
more sense that interactive and am

> Note that in particular, the last patch at the end could have been partially
> squashed into other patches, but if people objected to the patch in general
> I wanted Junio to be able to take the rest of the series and just drop that
> patch.
> 
> As with v4, there are some things mentioned earlier that are not addressed:
> 
>   * I did not remove the --am (now --apply) option as suggested by Phillip,
>     since Junio and Phillip were still discussing whether it is
>     wanted/needed. I kind of like having it, but have no strong opinion.
>   * I noted the post-commit hook in the differences between backends. Emily
>     is investigating what changes need to happen there, so I merely
>     documented the existing differences.
>   * I did not address the last two items Jonathan brought up as I couldn't
>     find enough information to reproduce or understand the problems.
> 
> Elijah Newren (20):
>    git-rebase.txt: update description of --allow-empty-message
>    t3404: directly test the behavior of interest
>    rebase (interactive-backend): make --keep-empty the default
>    rebase (interactive-backend): fix handling of commits that become
>      empty
>    t3406: simplify an already simple test
>    rebase, sequencer: remove the broken GIT_QUIET handling
>    rebase: make sure to pass along the quiet flag to the sequencer
>    rebase: fix handling of restrict_revision
>    t3432: make these tests work with either am or merge backends
>    rebase: allow more types of rebases to fast-forward
>    git-rebase.txt: add more details about behavioral differences of
>      backends
>    rebase: move incompatibility checks between backend options a bit
>      earlier
>    rebase: add an --am option
>    git-prompt: change the prompt for interactive-based rebases
>    rebase: drop '-i' from the reflog for interactive-based rebases
>    rebase tests: mark tests specific to the am-backend with --am
>    rebase tests: repeat some tests using the merge backend instead of am
>    rebase: make the backend configurable via config setting
>    rebase: change the default backend from "am" to "merge"
>    rebase: rename the two primary rebase backends
> 
>   Documentation/config/rebase.txt        |   6 +
>   Documentation/git-rebase.txt           | 170 +++++++++++++---
>   builtin/rebase.c                       | 257 +++++++++++++++++--------
>   contrib/completion/git-prompt.sh       |   6 +-
>   rebase-interactive.c                   |   7 +-
>   rebase-interactive.h                   |   2 +-
>   sequencer.c                            |  82 +++++---
>   sequencer.h                            |   3 +-
>   t/t3400-rebase.sh                      |  40 +++-
>   t/t3401-rebase-and-am-rename.sh        |   4 +-
>   t/t3404-rebase-interactive.sh          |  19 +-
>   t/t3406-rebase-message.sh              |  19 +-
>   t/t3407-rebase-abort.sh                |   6 +-
>   t/t3420-rebase-autostash.sh            |  22 +--
>   t/t3421-rebase-topology-linear.sh      |  48 ++---
>   t/t3424-rebase-empty.sh                | 126 ++++++++++++
>   t/t3425-rebase-topology-merges.sh      |   8 +-
>   t/t3427-rebase-subtree.sh              |  12 +-
>   t/t3432-rebase-fast-forward.sh         |  54 +++---
>   t/t5407-post-rewrite-hook.sh           |  16 +-
>   t/t5520-pull.sh                        |  27 ++-
>   t/t6047-diff3-conflict-markers.sh      |  13 +-
>   t/t7512-status-help.sh                 |  12 +-
>   t/t9106-git-svn-commit-diff-clobber.sh |   3 +-
>   t/t9903-bash-prompt.sh                 |   8 +-
>   25 files changed, 693 insertions(+), 277 deletions(-)
>   create mode 100755 t/t3424-rebase-empty.sh
> 
> 
> base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-679%2Fnewren%2Frebase-fixes-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-679/newren/rebase-fixes-v5
> Pull-Request: https://github.com/git/git/pull/679
> 
> Range-diff vs v4:
> 
>    1:  3ea48d53940 =  1:  3ea48d53940 git-rebase.txt: update description of --allow-empty-message
>    2:  10fdd162a05 =  2:  10fdd162a05 t3404: directly test the behavior of interest
>    3:  179f82ab83e !  3:  74cab9a32b3 rebase (interactive-backend): make --keep-empty the default
>       @@ -4,13 +4,13 @@
>        
>            Different rebase backends have different treatment for commits which
>            start empty (i.e. have no changes relative to their parent), and the
>       -    --keep-empty option was added at some point to allow adjusting behavior
>       -    for the interactive backend.  The handling of commits which start empty
>       -    is actually quite similar to commit b00bf1c9a8dd (git-rebase: make
>       -    --allow-empty-message the default, 2018-06-27), which pointed out that
>       -    the behavior for various backends is often more happenstance than
>       -    design.  The specific change made in that commit is actually quite
>       -    relevant as well and much of the logic there directly applies here.
>       +    --keep-empty option was added at some point to allow adjusting behavior.
>       +    The handling of commits which start empty is actually quite similar to
>       +    commit b00bf1c9a8dd (git-rebase: make --allow-empty-message the default,
>       +    2018-06-27), which pointed out that the behavior for various backends is
>       +    often more happenstance than design.  The specific change made in that
>       +    commit is actually quite relevant as well and much of the logic there
>       +    directly applies here.

Thanks for rewording this I think the new version is better for omitting 
the reference to the interactive backend. The interdiff for this patch 
and the next look good.

Thanks for working on this - it's turned into quite a large series

Best Wishes

Phillip

>            It makes a lot of sense in 'git commit' to error out on the creation of
>            empty commits, unless an override flag is provided.  However, once
>       @@ -405,8 +405,6 @@
>        +	test_cmp expect actual
>        +'
>        +
>       -+GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
>       -+
>        +test_expect_success 'rebase --interactive with a variety of empty commits' '
>        +	git checkout -B testing localmods &&
>        +	test_must_fail git rebase --interactive upstream &&
>    4:  c9542a2abe0 !  4:  54b745c4ab5 rebase (interactive-backend): fix handling of commits that become empty
>       @@ -98,6 +98,8 @@
>        +	With ask (implied by --interactive), the rebase will halt when
>        +	an empty commit is applied allowing you to choose whether to
>        +	drop it, edit files more, or just commit the empty changes.
>       ++	Other options, like --exec, will use the default of drop unless
>       ++	-i/--interactive is explicitly specified.
>        ++
>        +Note that commits which start empty are kept, and commits which are
>        +clean cherry-picks (as determined by `git log --cherry-mark ...`) are
>       @@ -224,7 +226,7 @@
>         			      REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
>         		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
>        +		OPT_CALLBACK_F(0, "empty", &options, N_("{drop,keep,ask}"),
>       -+			       N_("how to handle empty commits"),
>       ++			       N_("how to handle commits that become empty"),
>        +			       PARSE_OPT_NONEG, parse_opt_empty),
>         		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
>         			N_("(DEPRECATED) keep empty commits"),
>       @@ -342,8 +344,10 @@
>        -	if (!opts->no_commit) {
>        +	} else if (allow == 2) {
>        +		drop_commit = 1;
>       -+		fprintf(stderr, _("No changes -- Patch already applied.\n"));
>       -+	} // else allow == 0 and there's nothing special to do
>       ++		fprintf(stderr,
>       ++			_("dropping %s %s -- patch contents already upstream\n"),
>       ++			oid_to_hex(&commit->object.oid), msg.subject);
>       ++	} /* else allow == 0 and there's nothing special to do */
>        +	if (!opts->no_commit && !drop_commit) {
>         		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
>         			res = do_commit(r, msg_file, author, opts, flags);
>       @@ -404,9 +408,7 @@
>        -test_expect_failure 'rebase --merge with a variety of empty commits' '
>        -	test_when_finished "git rebase --abort" &&
>        +test_expect_success 'rebase --merge --empty=drop' '
>       - 	git checkout -B testing localmods &&
>       --	# rebase --merge should not halt on the commit that becomes empty
>       --	git rebase --merge upstream &&
>       ++	git checkout -B testing localmods &&
>        +	git rebase --merge --empty=drop upstream &&
>        +
>        +	test_write_lines D C B A >expect &&
>       @@ -414,6 +416,17 @@
>        +	test_cmp expect actual
>        +'
>        +
>       ++test_expect_success 'rebase --merge uses default of --empty=drop' '
>       + 	git checkout -B testing localmods &&
>       +-	# rebase --merge should not halt on the commit that becomes empty
>       + 	git rebase --merge upstream &&
>       +
>       + 	test_write_lines D C B A >expect &&
>       +@@
>       + 	test_cmp expect actual
>       + '
>       +
>       +-test_expect_success 'rebase --interactive with a variety of empty commits' '
>        +test_expect_success 'rebase --merge --empty=keep' '
>        +	git checkout -B testing localmods &&
>        +	git rebase --merge --empty=keep upstream &&
>       @@ -428,14 +441,12 @@
>        +	test_must_fail git rebase --merge --empty=ask upstream &&
>        +
>        +	git rebase --skip &&
>       -
>       - 	test_write_lines D C B A >expect &&
>       - 	git log --format=%s >actual &&
>       -@@
>       -
>       - GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
>       -
>       --test_expect_success 'rebase --interactive with a variety of empty commits' '
>       ++
>       ++	test_write_lines D C B A >expect &&
>       ++	git log --format=%s >actual &&
>       ++	test_cmp expect actual
>       ++'
>       ++
>        +test_expect_success 'rebase --interactive --empty=drop' '
>        +	git checkout -B testing localmods &&
>        +	git rebase --interactive --empty=drop upstream &&
>       @@ -455,11 +466,19 @@
>        +'
>        +
>        +test_expect_success 'rebase --interactive --empty=ask' '
>       - 	git checkout -B testing localmods &&
>       --	test_must_fail git rebase --interactive upstream &&
>       ++	git checkout -B testing localmods &&
>        +	test_must_fail git rebase --interactive --empty=ask upstream &&
>       -
>       - 	git rebase --skip &&
>       ++
>       ++	git rebase --skip &&
>       ++
>       ++	test_write_lines D C B A >expect &&
>       ++	git log --format=%s >actual &&
>       ++	test_cmp expect actual
>       ++'
>       ++
>       ++test_expect_success 'rebase --interactive uses default of --empty=ask' '
>       + 	git checkout -B testing localmods &&
>       + 	test_must_fail git rebase --interactive upstream &&
>         
>        
>         diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
>    5:  9f66229d5cc =  5:  f5170e71510 t3406: simplify an already simple test
>    6:  8d731fa39c3 =  6:  2791b818c4d rebase, sequencer: remove the broken GIT_QUIET handling
>    7:  b6b6597eef8 =  7:  3dccb58d066 rebase: make sure to pass along the quiet flag to the sequencer
>    8:  0acefa988b1 =  8:  4e6f5ce8c46 rebase: fix handling of restrict_revision
>    9:  8c5b5b51330 =  9:  bcd04ec4ded t3432: make these tests work with either am or merge backends
>   10:  b8c087d6fb1 = 10:  45eb87b36b0 rebase: allow more types of rebases to fast-forward
>   11:  b50a1741e0b = 11:  11e96b9a5fa git-rebase.txt: add more details about behavioral differences of backends
>   12:  58e6e4ffb3f = 12:  0c921919dce rebase: move incompatibility checks between backend options a bit earlier
>   13:  5478c730aca = 13:  de1b0aaca88 rebase: add an --am option
>   14:  db5e29bd818 = 14:  e4c04d3cf8b git-prompt: change the prompt for interactive-based rebases
>   15:  413e190ac9a ! 15:  f0f00c1e7fd rebase: drop '-i' from the reflog for interactive-based rebases
>       @@ -54,17 +54,6 @@
>         		 */
>         		return error(_("%s: Unable to write new index file"),
>         			_(action_name(opts)));
>       -@@
>       - 	int next = todo_list->current, offset, fd;
>       -
>       - 	/*
>       --	 * rebase -i writes "git-rebase-todo" without the currently executing
>       --	 * command, appending it to "done" instead.
>       -+	 * interactive backend writes "git-rebase-todo" without the currently
>       -+	 * executing command, appending it to "done" instead.
>       - 	 */
>       - 	if (is_rebase_i(opts))
>       - 		next++;
>        @@
>         		return error(_("illegal label name: '%.*s'"), len, name);
>         
>   16:  170be283a85 ! 16:  56486d4d694 rebase tests: mark tests specific to the am-backend with --am
>       @@ -173,6 +173,163 @@
>         testrebase " --interactive" .git/rebase-merge
>         
>        
>       + diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
>       + --- a/t/t3421-rebase-topology-linear.sh
>       + +++ b/t/t3421-rebase-topology-linear.sh
>       +@@
>       + 		test_linear_range 'd e' c..
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase success -p
>       +@@
>       + 		test_cmp_rev e HEAD
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase success -p
>       +@@
>       + 		test_linear_range 'd e' b..
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success --fork-point
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       +@@
>       + 		test_linear_range 'd e' branch-b..
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success --fork-point
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       +@@
>       + 		test_cmp_rev e HEAD
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success --fork-point
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       +@@
>       + 		test_linear_range 'd i' h..
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase success -p
>       +@@
>       + 		test_linear_range 'd' h..
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase success -p
>       +@@
>       + 		test_linear_range 'd i' f..
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase success -p
>       +@@
>       + 		test_linear_range 'd gp i' h..
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase success -p
>       +@@
>       + 		test_linear_range 'j d k l' c..
>       + 	"
>       + }
>       +-test_run_rebase failure ''
>       ++test_run_rebase failure --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase failure -p
>       +@@
>       + 		test_linear_range 'd k l' c..
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase success -p
>       +@@
>       + 		test_linear_range 'd k l' j..
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase success -p
>       +@@
>       + 		test_linear_range 'x y' c..
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase success -p
>       +@@
>       + 		test_linear_range 'x y' c..
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase failure -p
>       +@@
>       + 		test_linear_range 'x y' m..
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase success -p
>       +@@
>       + 	"
>       + }
>       +
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase failure -p
>       +@@
>       + 		test_linear_range 'x y' m..
>       + 	"
>       + }
>       +-test_run_rebase success ''
>       ++test_run_rebase success --am
>       + test_run_rebase success -m
>       + test_run_rebase success -i
>       + test_have_prereq !REBASE_P || test_run_rebase failure -p
>       +
>         diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
>         --- a/t/t3425-rebase-topology-merges.sh
>         +++ b/t/t3425-rebase-topology-merges.sh
>   17:  1e3d4066c40 = 17:  dc12574a8b3 rebase tests: repeat some tests using the merge backend instead of am
>   18:  9b4ac83d2d0 = 18:  ba1f2699b39 rebase: make the backend configurable via config setting
>   19:  859a4a94d7f ! 19:  59faaa2f920 rebase: change the default backend from "am" to "merge"
>       @@ -13,6 +13,7 @@
>                patches incorrectly.[2]
>              * lack of access to original commits means that conflict marker
>                annotation has less information available.
>       +      * the am backend has safety problems with an ill-timed interrupt.
>        
>            Also, the merge/interactive backend have far more abilities, appear to
>            currently have a slight performance advantage[3] and have room for more
>       @@ -38,6 +39,24 @@
>         +
>         Note that a rebase merge works by replaying each commit from the working
>         branch on top of the <upstream> branch.  Because of this, when a merge
>       +@@
>       + should have the same behavior, though it is not clear which one is
>       + correct.
>       +
>       ++Interruptability
>       ++~~~~~~~~~~~~~~~~
>       ++
>       ++The am backend has safety problems with an ill-timed interrupt; if the
>       ++user presses Ctrl-C at the wrong time to try to abort the rebase, the
>       ++rebase can enter a state where it cannot be aborted with a subsequent
>       ++`git rebase --abort`.  The interactive backend does not appear to
>       ++suffer from the same shortcoming.  (See
>       ++https://lore.kernel.org/git/20200207132152.GC2868@szeder.dev/ for
>       ++details.)
>       ++
>       + Miscellaneous differences
>       + ~~~~~~~~~~~~~~~~~~~~~~~~~
>       +
>        
>         diff --git a/builtin/rebase.c b/builtin/rebase.c
>         --- a/builtin/rebase.c
>    -:  ----------- > 20:  ad8339aebf2 rebase: rename the two primary rebase backends
> 
