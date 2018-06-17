Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242361F403
	for <e@80x24.org>; Sun, 17 Jun 2018 15:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933766AbeFQPbE (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 11:31:04 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:6790 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933509AbeFQPbD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 11:31:03 -0400
Received: from [192.168.2.240] ([92.22.19.223])
        by smtp.talktalk.net with SMTP
        id UZdsf2VgnoI6LUZdtfSyuo; Sun, 17 Jun 2018 16:31:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1529249462;
        bh=RMVLtEVgrNSnN4ZuXwbqB7ugLfZRrouMUTYHFBZyhxA=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Vpla+OxvtD+sOJ7f5gXvAfVz0cUAV0ichq4XNBEfg2qwWB6SeUHuumZzj0rfm6PJf
         CljcfXP8ZvcYxOa+qCchp/bizGZL6XopHhKnl09zl0kiTcMiVmYV0/XewMdRhVgCVz
         0ArFnmI0cfVBAq9dDaTeUEBjuJafFVvkOdLnv5rk=
X-Originating-IP: [92.22.19.223]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=DH/r9e32v+C519lOzZJhbw==:117
 a=DH/r9e32v+C519lOzZJhbw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=kw3rfq6PZt_8Kzazmw8A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 7/7] git-rebase: make --allow-empty-message the
 default
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        phillip.wood@dunelm.org.uk
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com
References: <20180607050654.19663-1-newren@gmail.com>
 <20180617055856.22838-1-newren@gmail.com>
 <20180617055856.22838-8-newren@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <e8a6f54e-4361-dc66-c833-6047f8ea2058@talktalk.net>
Date:   Sun, 17 Jun 2018 16:30:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617055856.22838-8-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMqDzkTl0PDduhk6Krm1jjB9bzchGcll21VRSY2FJvPmegwUaJq1ioleinnQeJh1+/I1miVmJWJItKVQHKa0nN9OZHiWRtMT/X17UneOWS+O8wH6X0qW
 ctgkJfNJC0vzX06h7aEAC2adYI6pX7TeiAfuwR413kCgSD5HwsZA+UuerXEPDCPRjSAVt3pqWeCfGyMEzBFQEON/XaEP45M+YZifkklDgvX3kJt8d28aeSw4
 bf7woFLH4VO1YOzMk23ecEYXJw3lT2YL/P6gONzWwC2PRZSXu0lzpOEscjI9dOnNuheIXpjt+K+7D5zT4I731g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 17/06/18 06:58, Elijah Newren wrote:
> am-based rebases already apply commits with an empty commit message
> without requiring the user to specify an extra flag.  Make merge-based and
> interactive-based rebases behave the same.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   Documentation/git-rebase.txt  | 10 ----------
>   git-rebase.sh                 |  2 +-
>   t/t3404-rebase-interactive.sh |  7 ++++---
>   t/t3405-rebase-malformed.sh   | 11 +++--------
>   4 files changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 7a2ed9efdc..a5608f481f 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -562,16 +562,6 @@ BEHAVIORAL INCONSISTENCIES
>       The --keep-empty option exists for interactive rebases to allow
>       it to keep commits that started empty.
>   
> -  * empty commit messages:
> -
> -    am-based rebase will silently apply commits with empty commit
> -    messages.
> -
> -    merge-based and interactive-based rebases will by default halt
> -    on any such commits.  The --allow-empty-message option exists to
> -    allow interactive-based rebases to apply such commits without
> -    halting.
> -
>     * directory rename detection:
>   
>       merge-based and interactive-based rebases work fine with
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 5f891214fa..bf033da4e5 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -95,7 +95,7 @@ rebase_cousins=
>   preserve_merges=
>   autosquash=
>   keep_empty=
> -allow_empty_message=
> +allow_empty_message=--allow-empty-message

Looking at the option parsing in git-rebase.sh it appears that it does 
not check for --no-allow-empty-message so there's no way to turn off the 
default for those modes that support it. I'm not sure what to think of 
this change, I'm slightly uneasy with changing to default to be 
different from cherry-pick, though one could argue rebasing is a 
different operation and just keeping the existing messages even if they 
are empty is more appropriate and having all the rebase modes do the 
default to the same behaviour is definitely an improvement.

Best Wishes

Phillip

>   signoff=
>   test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
>   case "$(git config --bool commit.gpgsign)" in
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index c65826ddac..f84fa63b15 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -553,15 +553,16 @@ test_expect_success '--continue tries to commit, even for "edit"' '
>   '
>   
>   test_expect_success 'aborted --continue does not squash commits after "edit"' '
> +	test_when_finished "git rebase --abort" &&
>   	old=$(git rev-parse HEAD) &&
>   	test_tick &&
>   	set_fake_editor &&
>   	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
>   	echo "edited again" > file7 &&
>   	git add file7 &&
> -	test_must_fail env FAKE_COMMIT_MESSAGE=" " git rebase --continue &&
> -	test $old = $(git rev-parse HEAD) &&
> -	git rebase --abort
> +	echo all the things >>conflict &&
> +	test_must_fail git rebase --continue &&
> +	test $old = $(git rev-parse HEAD)
>   '
>   
>   test_expect_success 'auto-amend only edited commits after "edit"' '
> diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
> index cb7c6de84a..da94dddc86 100755
> --- a/t/t3405-rebase-malformed.sh
> +++ b/t/t3405-rebase-malformed.sh
> @@ -77,19 +77,14 @@ test_expect_success 'rebase commit with diff in message' '
>   '
>   
>   test_expect_success 'rebase -m commit with empty message' '
> -	test_must_fail git rebase -m master empty-message-merge &&
> -	git rebase --abort &&
> -	git rebase -m --allow-empty-message master empty-message-merge
> +	git rebase -m master empty-message-merge
>   '
>   
>   test_expect_success 'rebase -i commit with empty message' '
>   	git checkout diff-in-message &&
>   	set_fake_editor &&
> -	test_must_fail env FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
> -		git rebase -i HEAD^ &&
> -	git rebase --abort &&
> -	FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
> -		git rebase -i --allow-empty-message HEAD^
> +	env FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
> +		git rebase -i HEAD^
>   '
>   
>   test_done
> 

