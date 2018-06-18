Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C922C1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 16:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754237AbeFRQJJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 12:09:09 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:45241 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeFRQJI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 12:09:08 -0400
Received: from [192.168.2.240] ([92.22.19.223])
        by smtp.talktalk.net with SMTP
        id UwiIfSl6bVlGZUwiIfS8si; Mon, 18 Jun 2018 17:09:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1529338147;
        bh=eDQdDr6551enEc0ixXpEQ8s9ws+MvR7R5W3A1hja42k=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fXTtg14GdLVbiD2NuGhc8eaEoc+el/yfn5CSzllD6mMMRylfK73GIj/FPWvmmr9uU
         GSG75RGon0A5UTIKwhd/dEKzapCztQ9OjRSAdNWJxyriZTcK1xO1FlBs/71sDrlxLo
         nXLwI2AMhrTufAmTSrPUFy2btbPk8sY8qIyu5VM4=
X-Originating-IP: [92.22.19.223]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=DH/r9e32v+C519lOzZJhbw==:117
 a=DH/r9e32v+C519lOzZJhbw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=yXi8ZgYoWqRF_78uBIsA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH 3/3] rebase -i: rewrite checkout_onto() in C
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
 <20180618131844.13408-4-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <290d8b7c-3d82-e914-0399-e8dd5a6e1513@talktalk.net>
Date:   Mon, 18 Jun 2018 17:09:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618131844.13408-4-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFtYggvQ2h7R63A+I3a+bK4sXoDoRfDWccExhC20Wj3U21nHnrFhOu5057hAuGgTqpGu14D9lto6o49dWp6GTX+82aeenIR5388QAgonXge7WCQ7ZiHu
 NrCbIqubhwZG2lrgtEDrxC9W4pIOQygADqQ0Z+sZOV6QXXRNAYVHUs6LQ8Hl+f0HBQ6/PXcVK7XKzYbgX4M5l2Sx/o4LTUssXj11UW3hhc04mNRKmT2g79kf
 pon6TsyseDjk2YCGyCcUxOS75hoUjM3wCfls0blPfDpCBwwu2kVgLgHm0VSXcnCrJYd37jy/kgXWpHkcgmQxYWQY8MRN0jCqdXd+Kgg1LAssLD7nk1KHVan3
 sIXGgNs06Kiug0JYHVd261G7BeN76znoGZMbdy5TMNccjudsOR1KdogwwNQCf/KPblLTfXpj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 18/06/18 14:18, Alban Gruin wrote:
> This rewrites checkout_onto() from shell to C.
> 
> A new command (“checkout-onto”) is added to rebase--helper.c. The shell
> version is then stripped.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   builtin/rebase--helper.c   |  7 ++++++-
>   git-rebase--interactive.sh | 25 ++++---------------------
>   sequencer.c                | 19 +++++++++++++++++++
>   sequencer.h                |  3 +++
>   4 files changed, 32 insertions(+), 22 deletions(-)
> 
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index d677fb663..f9fffba96 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -17,7 +17,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>   	enum {
>   		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
>   		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
> -		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, SETUP_REFLOG
> +		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, SETUP_REFLOG,
> +		CHECKOUT_ONTO
>   	} command = 0;
>   	struct option options[] = {
>   		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
> @@ -53,6 +54,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>   			    EDIT_TODO),
>   		OPT_CMDMODE(0, "setup-reflog", &command,
>   			    N_("setup the reflog action"), SETUP_REFLOG),
> +		OPT_CMDMODE(0, "checkout-onto", &command,
> +			    N_("checkout a commit"), CHECKOUT_ONTO),
>   		OPT_END()
>   	};
>   
> @@ -98,5 +101,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>   		return !!edit_todo_list(flags);
>   	if (command == SETUP_REFLOG && argc == 2)
>   		return !!setup_reflog_action(&opts, argv[1], verbose);
> +	if (command == CHECKOUT_ONTO && argc == 4)
> +		return !!checkout_onto(&opts, argv[1], argv[2], argv[3], verbose);
>   	usage_with_options(builtin_rebase_helper_usage, options);
>   }
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 048bbf041..0ae053291 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -28,17 +28,6 @@ case "$comment_char" in
>   	;;
>   esac
>   
> -orig_reflog_action="$GIT_REFLOG_ACTION"
> -
> -comment_for_reflog () {
> -	case "$orig_reflog_action" in
> -	''|rebase*)
> -		GIT_REFLOG_ACTION="rebase -i ($1)"
> -		export GIT_REFLOG_ACTION
> -		;;
> -	esac
> -}
> -
>   die_abort () {
>   	apply_autostash
>   	rm -rf "$state_dir"
> @@ -70,14 +59,6 @@ collapse_todo_ids() {
>   	git rebase--helper --shorten-ids
>   }
>   
> -# Switch to the branch in $into and notify it in the reflog
> -checkout_onto () {
> -	comment_for_reflog start
> -	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
> -	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
> -	git update-ref ORIG_HEAD $orig_head
> -}
> -
>   get_missing_commit_check_level () {
>   	check_level=$(git config --get rebase.missingCommitsCheck)
>   	check_level=${check_level:-ignore}
> @@ -176,7 +157,8 @@ EOF
>   
>   	git rebase--helper --check-todo-list || {
>   		ret=$?
> -		checkout_onto
> +		git rebase--helper --checkout-onto "$onto_name" "$onto" \
> +		    "$orig_head" ${verbose:+--verbose}
>   		exit $ret
>   	}
>   
> @@ -186,7 +168,8 @@ EOF
>   	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
>   	die "Could not skip unnecessary pick commands"
>   
> -	checkout_onto
> +	git rebase--helper --checkout-onto "$onto_name" "$onto" "$orig_head" \
> +	    ${verbose:+--verbose}
>   	require_clean_work_tree "rebase"
>   	exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
>   	     --continue
> diff --git a/sequencer.c b/sequencer.c
> index 4bfe29c7b..d149cbf92 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3162,6 +3162,25 @@ int setup_reflog_action(struct replay_opts *opts, const char *commit,
>   	return 0;
>   }
>   
> +int checkout_onto(struct replay_opts *opts,
> +		  const char *onto_name, const char *onto,
> +		  const char *orig_head, unsigned verbose)
> +{
> +	struct object_id oid;
> +	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
> +
> +	if (get_oid(orig_head, &oid))
> +		die(_("%s: not a valid OID"), orig_head);

If this code is going to live long-term in sequencer.c then it would be 
better not to die, but return an error instead as it's part of libgit.

Best Wishes

Phillip

> +
> +	if (checkout_base_commit(opts, onto, verbose, action)) {
> +		apply_autostash(opts);
> +		sequencer_remove_state(opts);
> +		die(_("could not detach HEAD"));
> +	}
> +
> +	return update_ref(NULL, "ORIG_HEAD", &oid, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> +}
> +
>   static const char rescheduled_advice[] =
>   N_("Could not execute the todo command\n"
>   "\n"
> diff --git a/sequencer.h b/sequencer.h
> index 55e4057d8..9899d90fc 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -102,6 +102,9 @@ void commit_post_rewrite(const struct commit *current_head,
>   
>   int setup_reflog_action(struct replay_opts *opts, const char *commit,
>   			int verbose);
> +int checkout_onto(struct replay_opts *opts,
> +		  const char *onto_name, const char *onto,
> +		  const char *orig_head, unsigned verbose);
>   
>   #define SUMMARY_INITIAL_COMMIT   (1 << 0)
>   #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
> 

