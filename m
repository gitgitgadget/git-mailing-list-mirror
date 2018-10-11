Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15B691F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 09:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeJKQem (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 12:34:42 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:58155 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbeJKQem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 12:34:42 -0400
Received: from [192.168.2.201] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id AWx6gyUt1VlGZAWx6gSUIR; Thu, 11 Oct 2018 10:08:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539248897;
        bh=LIB4X6nipXxqEevHjQMU/2yH+gFsJQA0AyqogWRKINk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ga8uoNqksd7ibDIKjouxHOo8acB9K2Y5g0nxdZN1Qlqm0m3FhwONO/U3WzMWJTXsF
         Sinb+BhcKFzHDEX6anNDNq/BNyGWEb9xEsVYD9WTEo4AGQLF2PJp0chilqUv1GkZW7
         fUH4iN8lZzwt3a4CXgi2jsMbr7dr4Z/Z5ccx/NoU=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8
 a=96hrjbTRVr5MxXcxFoAA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rebase -i: introduce the 'break' command
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.43.git.gitgitgadget@gmail.com>
 <pull.43.v2.git.gitgitgadget@gmail.com>
 <c74e02c4b643652d43108c1a5a675df0fae5f059.1539161632.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <fd14c00f-65d5-f5d6-5f0e-ee0de7593a38@talktalk.net>
Date:   Thu, 11 Oct 2018 10:08:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <c74e02c4b643652d43108c1a5a675df0fae5f059.1539161632.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJAdhJ/5U7ahcK2MNfC88Glo05FTz+ey6XaeVbuhmG9qLxYhCpE/RdRFVh+HtMuRFoskZmTcA6qOX7Fvr4lTpjT94aCC4oPzbRKv38c9D+t8+3rlR5Xr
 zGaKuZmy9gByUYqALWYwv3bhPbcFnjiJvqUEPRVNC/4Q4+Lk+uZt1wh80MZQBoHAdZ00A/cbymq/G6JRORLGUWkY2j10ZLOS9OUxSKC6zdD281IR15eYxkRf
 jgvdp/oQHgz7ahRpoKuke+2ZvLJJSo/if3EXshOXtAcs93XJWsDpReDdzdOXjCriAjNm+FS/Y1IgkjBQMp3Z1Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

I think this would be a useful addition to rebase, there's one small
comment below.

On 10/10/2018 09:53, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The 'edit' command can be used to cherry-pick a commit and then
> immediately drop out of the interactive rebase, with exit code 0, to let
> the user amend the commit, or test it, or look around.
> 
> Sometimes this functionality would come in handy *without*
> cherry-picking a commit, e.g. to interrupt the interactive rebase even
> before cherry-picking a commit, or immediately after an 'exec' or a
> 'merge'.
> 
> This commit introduces that functionality, as the spanking new 'break'
> command.
> 
> Suggested-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-rebase.txt | 3 +++
>  rebase-interactive.c         | 1 +
>  sequencer.c                  | 7 ++++++-
>  t/lib-rebase.sh              | 2 +-
>  t/t3418-rebase-continue.sh   | 9 +++++++++
>  5 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index db2faca73c..5bed1da36b 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -561,6 +561,9 @@ By replacing the command "pick" with the command "edit", you can tell
>  the files and/or the commit message, amend the commit, and continue
>  rebasing.
>  
> +To interrupt the rebase (just like an "edit" command would do, but without
> +cherry-picking any commit first), use the "break" command.
> +
>  If you just want to edit the commit message for a commit, replace the
>  command "pick" with the command "reword".
>  
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 0f4119cbae..78f3263fc1 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -14,6 +14,7 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
>  "s, squash <commit> = use commit, but meld into previous commit\n"
>  "f, fixup <commit> = like \"squash\", but discard this commit's log message\n"
>  "x, exec <command> = run command (the rest of the line) using shell\n"
> +"b, break = stop here (continue rebase later with 'git rebase --continue')\n"
>  "d, drop <commit> = remove commit\n"
>  "l, label <label> = label current HEAD with a name\n"
>  "t, reset <label> = reset HEAD to a label\n"
> diff --git a/sequencer.c b/sequencer.c
> index 8dd6db5a01..b209f8af46 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1416,6 +1416,7 @@ enum todo_command {
>  	TODO_SQUASH,
>  	/* commands that do something else than handling a single commit */
>  	TODO_EXEC,
> +	TODO_BREAK,
>  	TODO_LABEL,
>  	TODO_RESET,
>  	TODO_MERGE,
> @@ -1437,6 +1438,7 @@ static struct {
>  	{ 'f', "fixup" },
>  	{ 's', "squash" },
>  	{ 'x', "exec" },
> +	{ 'b', "break" },
>  	{ 'l', "label" },
>  	{ 't', "reset" },
>  	{ 'm', "merge" },
> @@ -1964,7 +1966,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>  	padding = strspn(bol, " \t");
>  	bol += padding;
>  
> -	if (item->command == TODO_NOOP) {
> +	if (item->command == TODO_NOOP || item->command == TODO_BREAK) {
>  		if (bol != eol)
>  			return error(_("%s does not accept arguments: '%s'"),
>  				     command_to_string(item->command), bol);
> @@ -3293,6 +3295,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  			unlink(rebase_path_stopped_sha());
>  			unlink(rebase_path_amend());
>  			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
> +
> +			if (item->command == TODO_BREAK)
> +				break;

Normally when rebase stops it prints a message to say where it has got
to and how to continue, it might be useful to do the same here

Best Wishes

Phillip

>  		}
>  		if (item->command <= TODO_SQUASH) {
>  			if (is_rebase_i(opts))
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 25a77ee5cb..584604ee63 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -49,7 +49,7 @@ set_fake_editor () {
>  		case $line in
>  		squash|fixup|edit|reword|drop)
>  			action="$line";;
> -		exec*)
> +		exec*|break)
>  			echo "$line" | sed 's/_/ /g' >> "$1";;
>  		"#")
>  			echo '# comment' >> "$1";;
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index c145dbac38..185a491089 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -239,5 +239,14 @@ test_rerere_autoupdate -m
>  GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
>  test_rerere_autoupdate -i
>  test_rerere_autoupdate --preserve-merges
> +unset GIT_SEQUENCE_EDITOR
> +
> +test_expect_success 'the todo command "break" works' '
> +	rm -f execed &&
> +	FAKE_LINES="break exec_>execed" git rebase -i HEAD &&
> +	test_path_is_missing execed &&
> +	git rebase --continue &&
> +	test_path_is_file execed
> +'
>  
>  test_done
> 

