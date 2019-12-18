Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDA1C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 14:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E1121582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 14:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ5J0XHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLROgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:36:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38476 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfLROgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 09:36:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so2150375wmc.3
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 06:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j/aLrt1BCEnBOWega63JZv2j2jD7VzBCGZvw08yw2oQ=;
        b=bZ5J0XHCSaDOnHyWR6IRH/V4d4Qdskaj2NYBBbwCb8NgS3X3pBlCq6vWh59IR+vDU1
         7X7y7MxgJBib8gmf+E3omwXKTeprSRkOicz1iOh9IIbyrvKxMftIxA8Znb3LnB71rBCZ
         AjoxBhAzzHBDvCNlT6n2AGZy+/kth1uvrigcBccvvCEYcBnKMT4S0YpgogiKBonInwex
         k4oIpJg2i/bslyyHSeuN+o5JtJS+5+1wU4HGwnxn7G8kRtAOOt1YoPcUtspA7u5c4vHD
         Hjk4KfLkqpFoAG1ASCpm/X6cHqrlVSSJwiAuwS9R0Dl5LtoD+/UosJPKDMPl+4BxJwKA
         6knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=j/aLrt1BCEnBOWega63JZv2j2jD7VzBCGZvw08yw2oQ=;
        b=kppTMtQ+fJYxRSgSsD2T6SpDffahSmhqctHJoJiT+Fh7sy7osqxxcltu8HkRG5yI+2
         8vtwkm3IDOHxZA10UcLKwyr3F3FoAbfpm+IbnkI2H+207crDHCXEczV1l/oSBr1af8zr
         kg5hI4Ey8i58TGbXhrmj0XAEvMq61v/p6rW3/DqH1Gi/Vo7VbLLI6PRDrPhN5IDWUlZw
         5QGlX1GPLclvSFd7k9opSJO4LvVANyl12wji03vbLyoZCii5M11PNz/VmWeP/rgmthl8
         v4b9x7hyxo0Mvxg2uxSLS8h8hXoD9GqTgwtQF75KQOtvYPeRssdKcr33eYlP1QiUF2hp
         /gxA==
X-Gm-Message-State: APjAAAV6yzIQIAqk1VR13hFg6d0UgNBdZsSysDc3WxMG1ZUta/Hpgsqk
        rPvNzcFvzM8NKuOpomNQmY8=
X-Google-Smtp-Source: APXvYqzLd8C9lESzRA9VNIXawKDVY+eILSxOQRuwE6zAQ8NFlx2TZd7KcNlHMLw3ImPqGt4l7Dla/Q==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr3454081wma.121.1576679760037;
        Wed, 18 Dec 2019 06:36:00 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id s10sm2745025wrw.12.2019.12.18.06.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 06:35:59 -0800 (PST)
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 9/9] [RFC] rebase -i: leave CHERRY_PICK_HEAD when there
 are conflicts
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
 <20191206160614.631724-1-phillip.wood123@gmail.com>
 <20191206160614.631724-10-phillip.wood123@gmail.com>
Message-ID: <7e1b92f5-48df-e202-ebcc-5b15987a7d63@gmail.com>
Date:   Wed, 18 Dec 2019 14:35:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191206160614.631724-10-phillip.wood123@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12/2019 16:06, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Since the inception of CHERRY_PICK_HEAD in d7e5c0cbfb ("Introduce
> CHERRY_PICK_HEAD", 2011-02-19) 'rebase -i' has removed it when there are
> conflicts. The rationale for this was that the rebase wanted to handle
> the conflicts itself. However sometimes (e.g. after an edit command) the
> user wants to commit the conflict resolution before making some other
> changes or running some tests. Without CHERRY_PICK_HEAD the authorship
> information is lost when the user makes the commit. Fix this by leaving
> CHERRY_PICK_HEAD when we're not amending.

I'm not so sure about this approach as it wont work with 'merge' 
commands when rebasing. I wonder if it would be better to add a new file 
COMMIT_AUTHOR (or maybe MERGE_AUTHOR) that can be parsed by 
split_ident() and sets the authorship for a commit. The file would 
override $GIT_AUTHOR_NAME/EMAIL/DATE but could be overridden on the 
commandline by --author/date/reset-author

Best Wishes

Phillip

> Note that this changes the output of `git status`. The advice to run
> `git reset` is not appropriate for rebase as we do not allow partial
> commits.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> 
> Notes:
>      This has semantic conflicts with ra/rebase-i-more-options as it does not
>      respect the options passed to rebase when the user commits
>      
>      I haven't checked how this affects the shell prompt in contrib yet, I
>      suspect it may need changing to cope the presence of CHERRY_PICK_HEAD
>      during a rebase.
>      
>      I'd like to change the existing authorship tests to rely on the "Original
>      Author" changes here, but they are a web of hidden interdependencies which is
>      hard to untangle.
> 
>   sequencer.c                   |  12 ++--
>   t/t3404-rebase-interactive.sh | 104 +++++++++++++++++++++++++---------
>   t/t7512-status-help.sh        |   2 -
>   3 files changed, 85 insertions(+), 33 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 64242f4ce7..624e96c930 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -372,11 +372,15 @@ static void print_advice(struct repository *r, int show_hint,
>   	if (msg) {
>   		fprintf(stderr, "%s\n", msg);
>   		/*
> -		 * A conflict has occurred but the porcelain
> -		 * (typically rebase --interactive) wants to take care
> -		 * of the commit itself so remove CHERRY_PICK_HEAD
> +		 * A conflict has occurred but the porcelain wants to take care
> +		 * of the commit itself so remove CHERRY_PICK_HEAD. Note that we
> +		 * do not do this for interactive rebases anymore in order to
> +		 * preserve the author identity when the user runs 'git commit'
> +		 * to commit the conflict resolution rather than relying on
> +		 * 'rebase --continue' to do it for them.
>   		 */
> -		unlink(git_path_cherry_pick_head(r));
> +		if (!is_rebase_i(opts))
> +			unlink(git_path_cherry_pick_head(r));
>   		return;
>   	}
>   
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 5afa6f28cd..5cd7db18f8 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -33,31 +33,35 @@ Initial setup:
>   # in the expect2 file for the 'stop on conflicting pick' test.
>   
>   test_expect_success 'setup' '
> -	test_commit A file1 &&
> -	test_commit B file1 &&
> -	test_commit C file2 &&
> -	test_commit D file1 &&
> -	test_commit E file3 &&
> -	git checkout -b branch1 A &&
> -	test_commit F file4 &&
> -	test_commit G file1 &&
> -	test_commit H file5 &&
> -	git checkout -b branch2 F &&
> -	test_commit I file6 &&
> -	git checkout -b conflict-branch A &&
> -	test_commit one conflict &&
> -	test_commit two conflict &&
> -	test_commit three conflict &&
> -	test_commit four conflict &&
> -	git checkout -b no-conflict-branch A &&
> -	test_commit J fileJ &&
> -	test_commit K fileK &&
> -	test_commit L fileL &&
> -	test_commit M fileM &&
> -	git checkout -b no-ff-branch A &&
> -	test_commit N fileN &&
> -	test_commit O fileO &&
> -	test_commit P fileP
> +	(
> +		GIT_AUTHOR_NAME="Original Author" &&
> +		GIT_AUTHOR_EMAIL="original.author@example.com" &&
> +		test_commit A file1 &&
> +		test_commit B file1 &&
> +		test_commit C file2 &&
> +		test_commit D file1 &&
> +		test_commit E file3 &&
> +		git checkout -b branch1 A &&
> +		test_commit F file4 &&
> +		test_commit G file1 &&
> +		test_commit H file5 &&
> +		git checkout -b branch2 F &&
> +		test_commit I file6 &&
> +		git checkout -b conflict-branch A &&
> +		test_commit one conflict &&
> +		test_commit two conflict &&
> +		test_commit three conflict &&
> +		test_commit four conflict &&
> +		git checkout -b no-conflict-branch A &&
> +		test_commit J fileJ &&
> +		test_commit K fileK &&
> +		test_commit L fileL &&
> +		test_commit M fileM &&
> +		git checkout -b no-ff-branch A &&
> +		test_commit N fileN &&
> +		test_commit O fileO &&
> +		test_commit P fileP
> +	)
>   '
>   
>   # "exec" commands are run with the user shell by default, but this may
> @@ -252,12 +256,12 @@ test_expect_success 'stop on conflicting pick' '
>   	-A
>   	+G
>   	EOF
> -	cat >expect2 <<-\EOF &&
> +	cat >expect2 <<-EOF &&
>   	<<<<<<< HEAD
>   	D
>   	=======
>   	G
> -	>>>>>>> 5d18e54... G
> +	>>>>>>> $(git rev-parse --short HEAD)... G
>   	EOF
>   	git tag new-branch1 &&
>   	test_must_fail git rebase -i master &&
> @@ -1628,6 +1632,52 @@ test_expect_success 'correct error message for commit --amend after empty pick'
>   	test_i18ngrep "middle of a rebase -- cannot amend." err
>   '
>   
> +test_expect_success 'correct error message for partial commit after confilct' '
> +	test_when_finished "git rebase --abort" &&
> +	git checkout D &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="2 3" &&
> +		export FAKE_LINES &&
> +		test_must_fail git rebase -i A
> +	) &&
> +	echo x >file1 &&
> +	echo y >file2 &&
> +	git add file1 file2 &&
> +	test_must_fail git commit file1 2>err &&
> +	test_i18ngrep "cannot do a partial commit during a rebase." err
> +'
> +
> +test_expect_success 'correct error message for commit --amend after conflict' '
> +	test_when_finished "git rebase --abort" &&
> +	git checkout D &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES=3 &&
> +		export FAKE_LINES &&
> +		test_must_fail git rebase -i A
> +	) &&
> +	echo x>file1 &&
> +	test_must_fail git commit -a --amend 2>err &&
> +	test_i18ngrep "middle of a rebase -- cannot amend." err
> +'
> +
> +test_expect_success 'correct authorship and message after conflict' '
> +	git checkout D &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES=3 &&
> +		export FAKE_LINES &&
> +		test_must_fail git rebase -i A
> +	) &&
> +	echo x >file1 &&
> +	git commit -a &&
> +	git log --pretty=format:"%an <%ae>%n%ad%n%B" -1 D >expect &&
> +	git log --pretty=format:"%an <%ae>%n%ad%n%B" -1 HEAD >actual &&
> +	test_cmp expect actual &&
> +	git rebase --continue
> +'
> +
>   # This must be the last test in this file
>   test_expect_success '$EDITOR and friends are unchanged' '
>   	test_editor_unchanged
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index c1eb72555d..2adceb35e2 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -148,7 +148,6 @@ You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO
>     (use "git rebase --abort" to check out the original branch)
>   
>   Unmerged paths:
> -  (use "git reset HEAD <file>..." to unstage)
>     (use "git add <file>..." to mark resolution)
>   
>   	both modified:   main.txt
> @@ -176,7 +175,6 @@ You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO
>     (all conflicts fixed: run "git rebase --continue")
>   
>   Changes to be committed:
> -  (use "git reset HEAD <file>..." to unstage)
>   
>   	modified:   main.txt
>   
> 
