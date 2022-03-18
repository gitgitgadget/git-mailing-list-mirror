Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3600C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 00:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiCRAbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 20:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiCRAbg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 20:31:36 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F41A1AAFED
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:30:18 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id gh15so859301qvb.8
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=TS+6+p5XDQGsxk6w/FNbFpt7vH9+qbbfi+0Cgp7MRdA=;
        b=R5SyfqqwWopkcppIkSqmlvRW6KdrKeF2bruxtk8ckDOFZl5a6Cu0NFGnSog1JfveKH
         hKa/DoFSu5czjKl64YJGHouEc+rZl8SoPjpAX7muS6Pxx8cn/ADOD7RJC04plMHWsqJF
         RYWxUgKtV3SFnaG1Tn2BL+SUiNNuNJm/RnKxkfUzygWqOtShhxsW/nFsruwkDoKmlMGK
         0pi7xTATRVtKix+CfrbkTFiZao1BhIl1sBpT3QSCQILRUI9b/RMJXyGMBhzupd9/lwZu
         g86LryyFBSPgiGdpnLip4FAT8NT2FrnS8w2019uwnFfVMVq5KeCLN6v+CjtIsGKIWsua
         3gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=TS+6+p5XDQGsxk6w/FNbFpt7vH9+qbbfi+0Cgp7MRdA=;
        b=KlA4eWb4AU2g9Eiu75J4F2GYsV8e0SM7bF8s1ZUEeRaliFKdPB2ydGbskGu93mro/B
         D5mfaohluqTrawXcGFtkqRhp+BTlZUN9UzGKqr7QKWsInXiXo7vO9pCYWrRhPNA4kVhs
         Qme6qLKXQXWhh3i4yCkG0d4do3WsBF7qP0VwyslHpIKdWFJZE8AttEwmeHK5MNfrJ7Vp
         xA9ffgoLy+C6lT0b1IKcgXtusAwxmWnxE2H1sgLWD2fwpxLqtc+57k2/4QJSE14a7g+1
         acUyF3/DIy4oNJfl/vOIVIKVuNbiG6qWOBGLMkl7k4SUsE4gAdkaW64JtYAj5OtdI0tQ
         mOLg==
X-Gm-Message-State: AOAM531qwzMa99mUetqhjo/Krew1aG8+QoU8OTO2OATp3cjD5aG6HHJZ
        P1wGMa2EcRYQ01pxsUrgCzD7GfJrSFA=
X-Google-Smtp-Source: ABdhPJzNUWVYi0U4F79UQVYvpsrPXeISWHslPIH7eahrrsgsPadd71Ai1mKFdQ4OoEnsYFESWELVkg==
X-Received: by 2002:a05:6214:2409:b0:432:bf34:362f with SMTP id fv9-20020a056214240900b00432bf34362fmr5540488qvb.66.1647563417506;
        Thu, 17 Mar 2022 17:30:17 -0700 (PDT)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87d04000000b002e06b4674a1sm4779396qtb.61.2022.03.17.17.30.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Mar 2022 17:30:17 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 3/3] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
Date:   Thu, 17 Mar 2022 20:30:16 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <C271A4C3-2299-4D9D-BAA8-28968BFBE6C6@gmail.com>
In-Reply-To: <xmqq8rt8dzxr.fsf@gitster.g>
References: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
 <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
 <13c5955c317713bbc6a91b9f44081395880abb67.1647546828.git.gitgitgadget@gmail.com>
 <xmqq8rt8dzxr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 17 Mar 2022, at 17:36, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> Fixes a bug whereby rebase updates the deferenced reference HEAD points
>> to instead of HEAD directly.
>
> Perhaps
>
>     "git rebase A B", where B is not a commit, should behave as if
>     the HEAD got detached at B and then the detached HEAD got
>     rebased on top of A.  A bug however overwrites the current
>     branch to point at B, when B is a descendant of A (i.e. the
>     rebase ends up being a fast-forward).
>
>> ... See [1] for
>> the original bug report.
>
> OK (URL is wrong; see below).
>
> The explanation of how the bug occurs (elided) in the patch looked
> all reasonable.  It read well.
>
>> ...
>> Also add a test to ensure the correct behavior.
>
> Yup.  _Add_ a test to ensure that.  Not replace a misleading test
> that expected to see a wrong behaviour.
>
>> 1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/
>
> This is not the original bug report.  It was an early hint for
> diagnosis.
>
> [1] https://lore.kernel.org/git/YiokTm3GxIZQQUow@newk/
>
> would be a more appropriate pointer.
>
>>  	ropts.oid = &options->orig_head;
>>  	ropts.branch = options->head_name;
>>  	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>> +	if (!ropts.branch)
>> +		ropts.flags |=  RESET_HEAD_DETACH;
>>  	ropts.head_msg = buf.buf;
>
> OK.  If head_name is not set, we do not want to touch the branch
> the HEAD happens to be pointing at, so we want to detach.
>
>> +test_expect_success 'switch to non-branch detaches HEAD' '
>>  	git checkout main &&
>>  	old_main=$(git rev-parse HEAD) &&
>>  	git rebase First Second^0 &&
>> -	test_cmp_rev HEAD main &&
>> -	test_cmp_rev main $(git rev-parse Second) &&
>> -	git symbolic-ref HEAD
>> +	test_cmp_rev HEAD Second &&
>> +	test_cmp_rev main $old_main &&
>> +	test_must_fail git symbolic-ref HEAD
>
> As we want (1) HEAD (detached) is pointing at Second, (2) 'main'
> stayed at $old_main, and (3) HEAD is detched, these three conditions
> look sane.
>
> Thanks.
>
> For reference, I discarded [1/3], queued [2/3] and replaced this
> [3/3] with the following for now.

Sounds good--this is what I was about to do anyways!

>
> ---- >8 ---- ---- >8 ---- ---- >8 ---- ---- >8 ---- ---- >8 ----
> From: John Cai <johncai86@gmail.com>
> Subject: [PATCH] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
>
> "git rebase A B" where B is not a commit should behave as if the
> HEAD got detached at B and then the detached HEAD got rebased on top
> of A.  A bug however overwrites the current branch to point at B,
> when B is a descendant of A (i.e. the rebase ends up being a
> fast-forward).  See [1] for the original bug report.
>
> The callstack from checkout_up_to_date() is the following:
>
> cmd_rebase()
> -> checkout_up_to_date()
>    -> reset_head()
>       -> update_refs()
>          -> update_ref()
>
> When B is not a valid branch but an oid, rebase sets the head_name
> of rebase_options to NULL. This value gets passed down this call
> chain through the branch member of reset_head_opts also getting set
> to NULL all the way to update_refs().
>
> Then update_refs() checks ropts.branch to decide whether or not to switch
> branches. If ropts.branch is NULL, it calls update_ref() to update HEAD.
> At this point however, from rebase's point of view, we want a detached
> HEAD. But, since checkout_up_to_date() does not set the RESET_HEAD_DETACH
> flag, the update_ref() call will deference HEAD and update the branch its
> pointing to. We want the HEAD detached at B instead.
>
> Fix this bug by adding the RESET_HEAD_DETACH flag in
> checkout_up_to_date if B is not a valid branch, so that once
> reset_head() calls update_refs(), it calls update_ref() with
> REF_NO_DEREF which updates HEAD directly intead of deferencing it
> and updating the branch that HEAD points to.
>
> Also add a test to ensure the correct behavior.
>
> [1] https://lore.kernel.org/git/YiokTm3GxIZQQUow@newk/
>
> Reported-by: Michael McClimon <michael@mcclimon.org>
> Signed-off-by: John Cai <johncai86@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/rebase.c  | 2 ++
>  t/t3400-rebase.sh | 9 +++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index b29ad2b65e..27fde7bf28 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -829,6 +829,8 @@ static int checkout_up_to_date(struct rebase_options *options)
>  	ropts.oid = &options->orig_head;
>  	ropts.branch = options->head_name;
>  	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> +	if (!ropts.branch)
> +		ropts.flags |=  RESET_HEAD_DETACH;
>  	ropts.head_msg = buf.buf;
>  	if (reset_head(the_repository, &ropts) < 0)
>  		ret = error(_("could not switch to %s"), options->switch_to);
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 6dc8df8be7..cf55b017ff 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -389,6 +389,15 @@ test_expect_success 'switch to branch not checked out' '
>  	git rebase main other
>  '
>
> +test_expect_success 'switch to non-branch detaches HEAD' '
> +	git checkout main &&
> +	old_main=$(git rev-parse HEAD) &&
> +	git rebase First Second^0 &&
> +	test_cmp_rev HEAD Second &&
> +	test_cmp_rev main $old_main &&
> +	test_must_fail git symbolic-ref HEAD
> +'
> +
>  test_expect_success 'refuse to switch to branch checked out elsewhere' '
>  	git checkout main &&
>  	git worktree add wt &&
> --
> 2.35.1-757-g4266a5c05c

Thanks
John
