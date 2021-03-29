Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A089C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 14:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CED261932
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 14:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhC2OuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 10:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhC2OuC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 10:50:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A83C061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 07:49:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w18so14625900edc.0
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7hoUJSE3jfWQCLwI1KJ69ItbYNlW1jJbZ8b0a27eNi0=;
        b=J71EkMFpqbqbIE6u0sBzDL4uyprytciD5FEhvrj5x+9t01GPDMIKZoYpcfK2e/4xNe
         nvyPBmEza+o0DExueryekY0h/+meNkFSCSpzE1khgKxxUEz+Y9kmzmRqzeIGkGaqfaow
         KFQn0owKCGOvrc0GEeSzCIzKOAQ0NZiTd8GP+znluDxBXlVY8AZbIz0Y2ZCLD+bSddcM
         EDFtvxygtNcVLJaQnvEed1Y7qm+cKX7j/KiL07fEWBSI+DDvlakLVTUTk2bDO2LFisIy
         tahn2a66S7mJFdtCxOteo1kGVtgAxhhMU/u7asjdsn0B31WXy52+HLzBfR1aYG6IgaR6
         n/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7hoUJSE3jfWQCLwI1KJ69ItbYNlW1jJbZ8b0a27eNi0=;
        b=Fy9/Z63AJsFWVM3KeYjwWnfKiv2xyPGLmUwgcTNgMv+GURk8gVmLgc0gDGD1R36kY2
         dgropSUoTAIe7V2XD+JkGvWtSEtGxfiNh9kHrNaYmA5bivKDepeyE7DRaaIMxDuc7d63
         Uo+sfLRZDVOY2FNCZ80CSOGgoAZ7v4uceLt5/7A4BdfmPoqP7MiNOwehuCvri3Afpbfl
         sOlRLqfq2zjVkIifJ6HR6BvhwU7A7mAsTTJ5oEQTJrNLb8cmzNp8mqo4p6HazqlKOkDw
         B2gIHoVFc8aY08fIww6nivGjaVUkhsXlmS/o+C+TheOWr/I5kRTs2qNPw3FPIZdP08Jb
         HopQ==
X-Gm-Message-State: AOAM530JfHRWjseqGuyisCZeh7UKSTPZxI3PehC31/PYGNmodxpC0yOE
        FGlbVVn6h23b8OWcmCMBnVQ=
X-Google-Smtp-Source: ABdhPJzmb8NnfVc0UdVdqnigOoatkvB+tG48Bms6jKoYgPtoxImf4/b+S4E0S4NcVuErTjkcsW07NA==
X-Received: by 2002:aa7:d287:: with SMTP id w7mr28524428edq.23.1617029397740;
        Mon, 29 Mar 2021 07:49:57 -0700 (PDT)
Received: from [192.168.1.240] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.gmail.com with ESMTPSA id y2sm8374905ejf.30.2021.03.29.07.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 07:49:57 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] rebase: don't override --no-reschedule-failed-exec
 with config
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <873d1fda948855510b07f9cb75d374c03d60a94e.1544468695.git.gitgitgadget@gmail.com>
 <cover.1616411973.git.avarab@gmail.com>
 <e00300d58d4de4a6b440446a0054d34ad5a092f3.1616411973.git.avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <fc7e3d13-8761-6d79-0fc9-734d6942a8e6@gmail.com>
Date:   Mon, 29 Mar 2021 15:49:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <e00300d58d4de4a6b440446a0054d34ad5a092f3.1616411973.git.avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 22/03/2021 11:48, Ævar Arnfjörð Bjarmason wrote:
> Fix a bug in how --no-reschedule-failed-exec interacts with
> rebase.rescheduleFailedExec=true being set in the config. Before this
> change the --no-reschedule-failed-exec config option would be
> overridden by the config.
> 
> This bug happened because of the particulars of how "rebase" works
> v.s. most other git commands when it comes to parsing options and
> config:
> 
> When we read the config and parse the CLI options we correctly prefer
> the --no-reschedule-failed-exec option over
> rebase.rescheduleFailedExec=true in the config. So far so good.
> 
> However the --reschedule-failed-exec option doesn't take effect when
> the rebase starts (we'd just create a
> ".git/rebase-merge/reschedule-failed-exec" file if it was true). It
> only takes effect when the exec command fails, and the user wants to
> run "rebase --continue".

The exec command is rescheduled in the todo file as soon as it fails, we 
do not wait for the user to run 'rebase --continue' to reschedule it. 
However if it still fails after restarting or a later exec fails we have 
the problem you describe.

> At that point we'll have forgotten that we asked for
> --no-reschedule-failed-exec at the start, and will happily re-read the
> config.
> 
> We'll then see that rebase.rescheduleFailedExec=true is set. At that
> point we have no record of having set --no-reschedule-failed-exec
> earlier. So the config will effectively override the user having
> explicitly disabled the option on the command-line.
> 
> Even more confusingly: Since rebase accepts different options based on
> its state there wasn't even a way to get around this with "rebase
> --continue --no-reschedule-failed-exec" (but you could of course set
> the config with "rebase -c ...").
> 
> I think the least bad way out of this is to declare that for such
> options and config whatever we decide at the beginning of the rebase
> goes. So we'll now always create either a "reschedule-failed-exec" or
> a "no-reschedule-failed-exec file at the start, not just the former if
> we decided we wanted the feature.

Thanks for working on this and for the detailed commit message. I'm not 
entirely convinced we want yet another state file in .git/rebase-merge. 
We could we start writing the setting to the file rather than having 
different files for whether the option is on or off. If we use the 
contents of the file it could be -1 for 'use config', 0 'off', 1 'on'. 
The downside is that starting 'rebase --no-reschedule-failed-exec' with 
a new version of git and then continuing with an old version would do 
the wrong thing.

Best Wishes

Phillip

> With this new worldview you can no longer change the setting once a
> rebase has started except by manually removing the state files
> discussed above. I think making it work like that is the the least
> confusing thing we can do.
> 
> In the future we might want to learn to change the setting in the
> middle by combining "--edit-todo" with
> "--[no-]reschedule-failed-exec", we currently don't support combining
> those options, or any other way to change the state in the middle of
> the rebase short of manually editing the files in
> ".git/rebase-merge/*".
> 
> The bug being fixed here originally came about because of a
> combination of the behavior of the code added in d421afa0c66 (rebase:
> introduce --reschedule-failed-exec, 2018-12-10) and the addition of
> the config variable in 969de3ff0e0 (rebase: add a config option to
> default to --reschedule-failed-exec, 2018-12-10).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   Documentation/git-rebase.txt |  8 ++++++++
>   sequencer.c                  |  5 +++++
>   t/t3418-rebase-continue.sh   | 25 +++++++++++++++++++++++++
>   3 files changed, 38 insertions(+)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index a0487b5cc58..b48e6225769 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -622,6 +622,14 @@ See also INCOMPATIBLE OPTIONS below.
>   --no-reschedule-failed-exec::
>   	Automatically reschedule `exec` commands that failed. This only makes
>   	sense in interactive mode (or when an `--exec` option was provided).
> ++
> +Even though this option applies once a rebase is started, it's set for
> +the whole rebase at the start based on either the
> +`rebase.rescheduleFailedExec` configuration (see linkgit:git-config[1]
> +or "CONFIGURATION" below) or whether this option is
> +provided. Otherwise an explicit `--no-reschedule-failed-exec` at the
> +start would be overridden by the presence of
> +`rebase.rescheduleFailedExec=true` configuration.
>   
>   INCOMPATIBLE OPTIONS
>   --------------------
> diff --git a/sequencer.c b/sequencer.c
> index 848204d3dc3..59735fdff62 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -164,6 +164,7 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
>   static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
>   static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
>   static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
> +static GIT_PATH_FUNC(rebase_path_no_reschedule_failed_exec, "rebase-merge/no-reschedule-failed-exec")
>   static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
>   static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
>   
> @@ -2672,6 +2673,8 @@ static int read_populate_opts(struct replay_opts *opts)
>   
>   		if (file_exists(rebase_path_reschedule_failed_exec()))
>   			opts->reschedule_failed_exec = 1;
> +		else if (file_exists(rebase_path_no_reschedule_failed_exec()))
> +			opts->reschedule_failed_exec = 0;
>   
>   		if (file_exists(rebase_path_drop_redundant_commits()))
>   			opts->drop_redundant_commits = 1;
> @@ -2772,6 +2775,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>   		write_file(rebase_path_ignore_date(), "%s", "");
>   	if (opts->reschedule_failed_exec)
>   		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
> +	else
> +		write_file(rebase_path_no_reschedule_failed_exec(), "%s", "");
>   
>   	return 0;
>   }
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index ea14ef496cb..9553d969646 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -291,4 +291,29 @@ test_expect_success 'rebase.rescheduleFailedExec only affects `rebase -i`' '
>   	git rebase HEAD^
>   '
>   
> +test_expect_success 'rebase.rescheduleFailedExec=true & --no-reschedule-failed-exec' '
> +	test_when_finished "git rebase --abort" &&
> +	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&
> +	test_config rebase.rescheduleFailedExec true &&
> +	test_must_fail git rebase -x false --no-reschedule-failed-exec HEAD~2 &&
> +	test_must_fail git rebase --continue 2>err &&
> +	! grep "has been rescheduled" err
> +'
> +
> +test_expect_success 'new rebase.rescheduleFailedExec=true setting in an ongoing rebase is ignored' '
> +	test_when_finished "git rebase --abort" &&
> +	test_must_fail git rebase -x false HEAD~2 &&
> +	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&
> +	test_config rebase.rescheduleFailedExec true &&
> +	test_must_fail git rebase --continue 2>err &&
> +	! grep "has been rescheduled" err
> +'
> +
> +test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebase' '
> +	test_when_finished "git rebase --abort" &&
> +	test_must_fail git rebase -x false HEAD~2 &&
> +	test_expect_code 129 git rebase --continue --no-reschedule-failed-exec &&
> +	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
> +'
> +
>   test_done
> 
