Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94ADC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349145AbiCKP3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 10:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbiCKP3u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 10:29:50 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62293141FD7
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 07:28:46 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id q194so7221467qke.5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 07:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8GeFaU54PXyB1izTm6OT7ViKB0eN7js0C8LfDivM3Y=;
        b=JimFt6FiyE9WhsvtfxyCRDbLa2uSFGyvqO8wCqIXyp7Bq3cGrTyPF5ESkWD2EnidpM
         FeIvqRdBGxIU4ROfEm6Csh2E6w68HhkXQjnJKEnbFBPRCnNfXv1877hgQrg8nOHqPTCP
         bGhckndd7YMLWbDQsGlKiH3HKd/ofuSGXWAE7gH5EFuNhILuVDTjUgwGobTYQO7xNHPJ
         IhURy8TRSzPeFP0ipKYLzaOzLwi4JZNCHxahfTeUeAdalVhGMEWjjoZDZf/h9HxiGAxy
         O58At/Lx+fMEP369YFtNMEWMoIk7qH09/3z765QZgr8n6QagcKR+42QhhVL1G0Gwn04L
         LzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8GeFaU54PXyB1izTm6OT7ViKB0eN7js0C8LfDivM3Y=;
        b=xe16Se7rYI6m96OEMHjVyXU456wjp1+p42+rIeZlfQseMQwrqNMoOU+i0uwbRlhQ9e
         NdIYW5yDYlN8X3+kG2vdTXNoUF476UKyXMvXRVym1zxDOe5BzuQzeqvI6x0PcKOcyOZY
         f4cVJFqzSvpSiAiG9ZrLWGAX3KDDlPNtOZOfOUwgsMzDIwLT5TZMDtZHbleNFdgCGh4A
         ao+7H0tP0n5W+WJQ4wgGvlKIHuUkqNejeosWY6+opedni0twtGr5nJzGwiASLV1dqZpV
         +sGhE5LZaKFfNdI4iCaShnOCai/p+vt8GM1Woyg0ll5mnfAEeUD3tRXMJ74JT5LYQDwF
         Yljw==
X-Gm-Message-State: AOAM533BzyVBGeDWDFKkWCBZNHwrmsiKVjuJlcyp04/0lc8bXVDHTq7o
        MVrLOYUvva71KRcGFUK+12s=
X-Google-Smtp-Source: ABdhPJxSqadoS4mH6Dvp9nzPVmwzvR1cR85NyIEL9U725BqwEufqC1DXlNeZF4NiZLhB09nJZ1nwYQ==
X-Received: by 2002:ae9:ec0a:0:b0:67d:6c34:de44 with SMTP id h10-20020ae9ec0a000000b0067d6c34de44mr4512630qkg.152.1647012525448;
        Fri, 11 Mar 2022 07:28:45 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id m62-20020a378a41000000b0067d211fc10esm4039299qkd.92.2022.03.11.07.28.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Mar 2022 07:28:45 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
Date:   Fri, 11 Mar 2022 10:28:44 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <6BBE6E16-C4CE-4A66-8A0F-1FDBCA0080D4@gmail.com>
In-Reply-To: <7c1c0b8e-7895-7a0e-6ab0-e45e21ec7329@gmail.com>
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
 <7c1c0b8e-7895-7a0e-6ab0-e45e21ec7329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 11 Mar 2022, at 10:05, Phillip Wood wrote:

> Hi John
>
> Thanks for working on this
>
> On 11/03/2022 05:05, John Cai via GitGitGadget wrote:
>> From: John Cai <johncai86@gmail.com>
>>
>> Fixes a bug whereby rebase updates the deferenced reference HEAD point=
s
>> to instead of HEAD directly.
>>
>> If HEAD is on main and if the following is a fast-forward operation,
>>
>> git rebase $(git rev-parse main) $(git rev-parse topic)
>>
>> Instead of HEAD being set to $(git rev-parse topic), rebase erroneousl=
y
>> dereferences HEAD and sets main to $(git rev-parse topic). This bug wa=
s
>> reported by Michael McClimon. See [1].
>
> Often we just add a Reported-by: trailer unless the liked email has som=
e useful extra info (which arguably should not be the case with a well wr=
itten commit message)

Thanks, will adjust.

>
>> This is happening because on a fast foward with an oid as a <branch>,
>> update_refs() will only call update_ref() with REF_NO_DEREF if
>> RESET_HEAD_DETACH is set. This change was made in 176f5d96 (built-in r=
ebase
>> --autostash: leave the current branch alone if possible,
>> 2018-11-07). In rebase, we are not setting the RESET_HEAD_DETACH flag,=

>> which means that the update_ref() call ends up dereferencing
>> HEAD and updating it to the oid used as <branch>.
>>
>> The correct behavior is that git rebase should update HEAD to $(git
>> rev-parse topic) without dereferencing it.
>>
>> Fix this bug by adding the RESET_HEAD_DETACH flag in checkout_up_to_da=
te
>
> As Junio points out it is confusing that it is always ok to pass that f=
lag, I think we should only set it if we are not checking out a branch, s=
ee below.
>
>> so that once reset_head() calls update_refs(), it calls update_ref() w=
ith
>> REF_NO_DEREF which updates HEAD directly intead of deferencing it and
>> updating the branch that HEAD points to.
>>
>> Also add a test to ensure this behavior.
>>
>> 1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/
>
> Maybe
> Reported-by: Michael McClimon <michael@mcclimon.org>
> ?
>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>      rebase: update HEAD when is an oid
>>          Fixes a bug [1] reported by Michael McClimon where rebase wit=
h oids will
>>      erroneously update the branch HEAD points to.
>>           1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-=
1226%2Fjohn-cai%2Fjc%2Ffix-rebase-oids-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-122=
6/john-cai/jc/fix-rebase-oids-v1
>> Pull-Request: https://github.com/git/git/pull/1226
>>
>>   builtin/rebase.c  |  2 +-
>>   t/t3400-rebase.sh | 21 +++++++++++++++++++++
>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index b29ad2b65e7..52afeffcc2e 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -828,7 +828,7 @@ static int checkout_up_to_date(struct rebase_optio=
ns *options)
>>   		    options->switch_to);
>>   	ropts.oid =3D &options->orig_head;
>>   	ropts.branch =3D options->head_name;
>> -	ropts.flags =3D RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>> +	ropts.flags =3D RESET_HEAD_RUN_POST_CHECKOUT_HOOK | RESET_HEAD_DETAC=
H;
>
> I think it would be clearer if the post image ended up as
>
> 	ropts.flags =3D RESET_HEAD_RUN_POST_CHECKOUT_HOOK
> 	if (options->head_name)
> 		ropts.branch =3D option->head_name
> 	else
> 		ropts.flags |=3D RESET_HEAD_DETACH

Yes, this is what I had in mind as well :).

>
> and we changed reset_head() to BUG() if both branch and RESET_HEAD_DETA=
CH are given.

I didn't consider this though, thanks for the suggestion.

>
>>   	ropts.head_msg =3D buf.buf;
>>   	if (reset_head(the_repository, &ropts) < 0)
>>   		ret =3D error(_("could not switch to %s"), options->switch_to);
>> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> index 71b1735e1dd..0b92e78976c 100755
>> --- a/t/t3400-rebase.sh
>> +++ b/t/t3400-rebase.sh
>> @@ -437,4 +437,25 @@ test_expect_success 'rebase when inside worktree =
subdirectory' '
>>   	)
>>   '
>>  +test_expect_success 'rebase with oids' '
>> +	git init main-wt &&
>> +	(
>> +		cd main-wt &&
>> +		>file &&
>> +		git add file &&
>> +		git commit -m initial &&
>> +		git checkout -b side &&
>> +		echo >>file &&
>> +		git commit -a -m side &&
>> +		git checkout main &&
>> +		git tag hold &&
>> +		git checkout -B main hold &&
>> +		git rev-parse main >pre &&
>> +		git rebase $(git rev-parse main) $(git rev-parse side) &&
>> +		git rev-parse main >post &&
>> +		test "$(git rev-parse side)" =3D "$(cat .git/HEAD)" &&
>> +		test_cmp pre post
>> +	)
>> +'
>
> Using a stand alone test for bisecting makes sense but I think we shoul=
d try and use the existing test setup for the regression test (it certain=
ly does not need to run in its own worktree). The diff below shows how th=
is could be done. Ideally there would be a preparatory commit that modern=
ized the whole of the setup test rather than just the two commits we're u=
sing in the new test but that's not essential.

sounds good to me, might as well clean things up while we're at it.

>
> Best Wishes
>
> Phillip
>
> ---- >8 ----
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 71b1735e1d..d5a8ee39fc 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -18,10 +18,7 @@ GIT_AUTHOR_EMAIL=3Dbogus@email@address
>  export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
>
>  test_expect_success 'prepare repository with topic branches' '
> -       git config core.logAllRefUpdates true &&
> -       echo First >A &&
> -       git update-index --add A &&
> -       git commit -m "Add A." &&
> +       test_commit "Add A." A First First &&
>         git checkout -b force-3way &&
>         echo Dummy >Y &&
>         git update-index --add Y &&
> @@ -32,9 +29,7 @@ test_expect_success 'prepare repository with topic br=
anches' '
>         git mv A D/A &&
>         git commit -m "Move A." &&
>         git checkout -b my-topic-branch main &&
> -       echo Second >B &&
> -       git update-index --add B &&
> -       git commit -m "Add B." &&
> +       test_commit "Add B." B Second Second &&
>         git checkout -f main &&
>         echo Third >>A &&
>         git update-index A &&
> @@ -399,6 +394,15 @@ test_expect_success 'switch to branch not checked =
out' '
>         git rebase main other
>  '
>
> +test_expect_success 'switch to non-branch detaches HEAD' '
> +       git checkout main &&
> +       old_main=3D$(git rev-parse HEAD) &&
> +       git rebase First Second^0 &&
> +       test_cmp_rev HEAD Second &&
> +       test_cmp_rev main $old_main &&
> +       test_must_fail git symbolic-ref HEAD
> +'
> +
>  test_expect_success 'refuse to switch to branch checked out elsewhere'=
 '
>         git checkout main &&
>         git worktree add wt &&
