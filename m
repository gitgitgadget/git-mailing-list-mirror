Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49761C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 11:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348916AbhLAL1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 06:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbhLAL1u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 06:27:50 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F011C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 03:24:29 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso652468wmh.0
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 03:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p/xPiqWhxxgdXDObOSC6xQBfU7VliRtBqFTVMHluMTs=;
        b=VsmHM4bZKPhJ3000p8b5xkA+02GyC5VHSzyxuAn1WQtf8cgguWuTQuQSHHmrCYFnaO
         ZLsq5iybFQcW3Nsj2t1EPrkkLuV7BZvaxD7m5+pwfr98YU7zLh4XDuTP/l8po0dgCluu
         Vb85R15pta0NSgpn8tgekoxFIqWsLblLBFHlDv0wnOE9+HI6NqDtTfOz3AHoh9yVJQLE
         PJ8NN+cV6Uq+fauU9uIm1uXZdsCMezyWlMJGHF7QEdFT8gJRqsitUrz2679fp+PH/ivq
         nZh3Q64ddmJLGnXL6JySGNqM8hpgZHTwxICjDCr0he0CDnQlM4oPwVpry6ZxwjYQz62h
         HtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p/xPiqWhxxgdXDObOSC6xQBfU7VliRtBqFTVMHluMTs=;
        b=T46KoU66sppqlNh3lB+97if9+D5JNG/Ju6aOu5c5jaxrTVntHrE+KuKytupi2rvVjq
         +vjSRa9xufjturiXLVFPsS2YL0wQT8VP4X0kxYHGDRiB5e2ooEELkRIKSgmtD5/t/46w
         Zn0Tf8mJ9KN/n+Ub4Cll+dcb+h4SOMtwneynAynsgpntC6ogrMLCLET06y/tQUNxcRU4
         6e7hnlsEnfzCJT/E6PnJc3IN0E8Ve519KgTtylWLJuFjSDGX9lsfVdXWkXArATW4LfOA
         QqbjoJwt3rFoTDOfL9K7JjdJJk9Vg6HRrMWwAaAcHMe+vGrV8sPcUOCiQHrtpoA6N7rz
         IOIw==
X-Gm-Message-State: AOAM532HSWzWTuJI4xwB+zDDtP3/DY+Ij5M3hUPCByLCNx2mIo7ASVzx
        P6OkFoiFtgCzM7kEJIvpRhY=
X-Google-Smtp-Source: ABdhPJyWJc06OVbW9DZA71PSS+coOoxARECD5h98ef3O8ii6dU8U8QbwRYDD3BuwMKoWz4/VABadcQ==
X-Received: by 2002:a05:600c:1c07:: with SMTP id j7mr6365540wms.12.1638357867852;
        Wed, 01 Dec 2021 03:24:27 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id l15sm693447wme.47.2021.12.01.03.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 03:24:27 -0800 (PST)
Message-ID: <4fa55654-1e7a-aa8e-7e8d-a8512c55447d@gmail.com>
Date:   Wed, 1 Dec 2021 11:24:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: avoid adding exec commands for non-commit
 creating commands
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1149.git.git.1638244719381.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1149.git.git.1638244719381.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 30/11/2021 03:58, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The `--exec <cmd>` is documented as
> 
>      Append "exec <cmd>" after each line creating a commit in the final
>      history.
>      ...
>      If --autosquash is used, "exec" lines will not be appended for the
>      intermediate commits, and will only appear at the end of each
>      squash/fixup series.
> 
> Unfortunately, it would also add exec commands after non-pick
> operations, such as 'no-op', which could be seen for example with
>      git rebase -i --exec true HEAD
> 
> todo_list_add_exec_commands() intent was to insert exec commands after
> each logical pick, while trying to consider a chains of fixup and squash
> commits to be part of the pick before it.  So it would keep an 'insert'
> boolean tracking if it had seen a pick or merge, but not write the exec
> command until it saw the next non-fixup/squash command.  Since that
> would make it miss the final exec command, it had some code that would
> check whether it still needed to insert one at the end, but instead of a
> simple
> 
>      if (insert)
> 
> it had a
> 
>      if (insert || <condition that is always true>)
> 
> That's buggy; as per the docs, we should only add exec commands for
> lines that create commits, i.e. only if insert is true.  Fix the
> conditional.
> 
> There was one testcase in the testsuite that we tweak for this change;
> it was introduced in 54fd3243da ("rebase -i: reread the todo list if
> `exec` touched it", 2017-04-26), and was merely testing that after an
> exec had fired that the todo list would be re-read.  The test at the
> time would have worked given any revision at all, though it would only
> work with 'HEAD' as a side-effect of this bug.  Since we're fixing this
> bug, choose something other than 'HEAD' for that test.
> 
> Finally, add a testcase that verifies when we have no commits to pick,
> that we get no exec lines in the generated todo list.

Thanks for fixing this, the patch looks good and the commit message is 
excellent. I did see Ævar's concerns in another thread but I think this 
is the least surprising approach - if we're not actually rebasing 
anything it seems odd to run the exec command.

Best Wishes

Phillip

> Reported-by: Nikita Bobko <nikitabobko@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>      sequencer: avoid adding exec commands for non-commit creating commands
>      
>      Original report over at
>      https://lore.kernel.org/git/YaVzufpKcC0t+q+L@nand.local/T/#m13fbd7b054c06ba1f98ae66e6d1b9fcc51bb875e
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1149%2Fnewren%2Frebase-exec-empty-bug-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1149/newren/rebase-exec-empty-bug-v1
> Pull-Request: https://github.com/git/git/pull/1149
> 
>   sequencer.c                 | 2 +-
>   t/t3429-rebase-edit-todo.sh | 7 ++++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index ea96837cde3..aa790f0bba8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5496,7 +5496,7 @@ static void todo_list_add_exec_commands(struct todo_list *todo_list,
>   	}
>   
>   	/* insert or append final <commands> */
> -	if (insert || nr == todo_list->nr) {
> +	if (insert) {
>   		ALLOC_GROW(items, nr + commands->nr, alloc);
>   		COPY_ARRAY(items + nr, base_items, commands->nr);
>   		nr += commands->nr;
> diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
> index 7024d49ae7b..abd66f36021 100755
> --- a/t/t3429-rebase-edit-todo.sh
> +++ b/t/t3429-rebase-edit-todo.sh
> @@ -13,10 +13,15 @@ test_expect_success 'setup' '
>   
>   test_expect_success 'rebase exec modifies rebase-todo' '
>   	todo=.git/rebase-merge/git-rebase-todo &&
> -	git rebase HEAD -x "echo exec touch F >>$todo" &&
> +	git rebase HEAD~1 -x "echo exec touch F >>$todo" &&
>   	test -e F
>   '
>   
> +test_expect_success 'rebase exec with an empty list does not exec anything' '
> +	git rebase HEAD -x "true" 2>output &&
> +	! grep "Executing: true" output
> +'
> +
>   test_expect_success 'loose object cache vs re-reading todo list' '
>   	GIT_REBASE_TODO=.git/rebase-merge/git-rebase-todo &&
>   	export GIT_REBASE_TODO &&
> 
> base-commit: 35151cf0720460a897cde9b8039af364743240e7
> 

