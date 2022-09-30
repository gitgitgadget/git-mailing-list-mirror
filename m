Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F79C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 16:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiI3Qwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 12:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiI3Qw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 12:52:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C475D1D8488
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 09:52:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u21so2552911edi.9
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=4998eCOubTAmDsC0gPJGoAbDaF/6HaO+twfgG27ByQM=;
        b=LRWZKcDRQFUJyOWF7/usqinYakqrmdDrUAIifHEuCBZvm4rqg+FoUqAYq5gim+6tkj
         7yn30hlZyMd9jEJwc3BGBeJwt/1voKum2+1lbRa6Tv1eEuCK+90ORBU4+ZQw2ukpLHuQ
         xkb1LU17Q4PBC6uXLsbIKXkKPfwuWH0Rhu8lQxkJyMaMtWR5rwsmRtC9TBfXn7/ng01b
         pMNUSGcr2W8XaXgj/mzX8tiV86DtgSdQpKgQ65hsvZ7tqjh1593z4AZVJYUSKNrzyi/5
         tpIBII94cLS/KdwNix0/QrwqXFIV+Kn4GjjHx72WTsQewEcIaiukP7Zd+KYH61MBx9kc
         HhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=4998eCOubTAmDsC0gPJGoAbDaF/6HaO+twfgG27ByQM=;
        b=25OwoblMa7/lG9pkAJ4w/YRaaKlK0vAWEs/oxsJqxQ1T/XZHJC2cLVd8gxTA1vUC+7
         5sP52EVM4Zl0PEo5aL0TIje5pc7x/6Z7/rIiCfTN7/4N9uUwwPsjuTmW9vZAebTC2iuO
         Y63g3b3/vS1nCpLrdqGXLHnp8jJUFUcA4zXbMb7z5PqtkEiT+ETTiYKHdCufGivldf2d
         puBlCQVDmIFtpY6w8s2v6By4r4yIB58VbjVs8YLNSzPBYIj93RH+q3OExRMa8bwBmLd5
         3LkHlIXTucLdguafZhtxm3QuLutJuNPUyZ+j9mEbXzvIobHdZK/iNftAVcPXW7BVnek4
         7heQ==
X-Gm-Message-State: ACrzQf28h9jyN5vuYzysqv9Yk+RMy6UnLmuOtwvabEhGD6g04fRb0Jvo
        S/tQTGY1oqG0rPj5I6MURrg=
X-Google-Smtp-Source: AMsMyM4ulo12IlFIgfk/R2svT4pYPb8B0CQMw8uNchsQD4OovzlaKjDVE3qUR3eVFJlO2qFqMt8zaQ==
X-Received: by 2002:a05:6402:368:b0:458:9b5e:fd35 with SMTP id s8-20020a056402036800b004589b5efd35mr1265825edw.141.1664556747171;
        Fri, 30 Sep 2022 09:52:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b4-20020a056402138400b0044e937ddcabsm1185556edv.77.2022.09.30.09.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:52:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oeJFR-001lsr-1I;
        Fri, 30 Sep 2022 18:52:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] sequencer: duplicate the result of
 resolve_ref_unsafe()
Date:   Fri, 30 Sep 2022 18:51:04 +0200
References: <20220930140948.80367-1-szeder.dev@gmail.com>
 <20220930140948.80367-6-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20220930140948.80367-6-szeder.dev@gmail.com>
Message-ID: <220930.86edvsvm7q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 30 2022, SZEDER G=C3=A1bor wrote:

> When 'git rebase -i --update-refs' generates the todo list for the
> rebased commit range, an 'update-ref' instruction is inserted for each
> ref that points to one of those commits, except for the rebased branch
> (because at the end of the rebase it will be updated anyway) and any
> refs that are checked out in a worktree; for the latter a "Ref <ref>
> checked out at '<worktree>'" comment is added.  One of these comments
> can be missing under some circumstances: if the oldest commit with a
> ref pointing to it has multiple refs pointing to it, and at least one
> of those refs is checked out in a worktree, and one of them (but not
> the first) is checked out in the worktree associated with the last
> directory entry in '.git/worktrees'.
>
> The culprit is the add_decorations_to_list() function, which calls
> resolve_ref_unsafe() to figure out the refname of the rebased branch.
> However, resolve_ref_unsafe() can (and in this case does) return a
> pointer to a static buffer.  Alas, add_decorations_to_list() holds on
> that static buffer until the end of the function, using its contents
> to compare refnames with the rebased branch, while it also calls a
> function that invokes refs_resolve_ref_unsafe() internally [1], and
> which overwrites the content of that static buffer, and messes up
> subsequent refname comparisons.
>
> Use xstrdup_or_null() to keep a copy of resolve_ref_unsafe()'s return
> value for the duration of add_decorations_to_list().
>
> [1] #0  refs_resolve_ref_unsafe (refs=3D0x555555a23d00,
>         refname=3D0x555555928523 "HEAD", resolve_flags=3D0, oid=3D0x55555=
5a23c78,
>         flags=3D0x7fffffffc0cc) at refs.c:1781
>     #1  0x000055555587a1d9 in add_head_info (wt=3D0x555555a23c50) at work=
tree.c:33
>     #2  0x000055555587a446 in get_linked_worktree (id=3D0x555555a19c43 "W=
orkTree")
>         at worktree.c:91
>     #3  0x000055555587a628 in get_worktrees () at worktree.c:135
>     #4  0x00005555556a7676 in prepare_checked_out_branches () at branch.c=
:385
>     #5  0x00005555556a7a76 in branch_checked_out (
>         refname=3D0x555555a12e9c "refs/heads/branch2") at branch.c:446
>     #6  0x0000555555824f55 in add_decorations_to_list (commit=3D0x5555559=
efd08,
>         ctx=3D0x7fffffffc3e0) at sequencer.c:5946
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  sequencer.c                   |  5 +++--
>  t/t3404-rebase-interactive.sh | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index fba92c90b1..f1732f88f3 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5917,10 +5917,10 @@ static int add_decorations_to_list(const struct c=
ommit *commit,
>  				   struct todo_add_branch_context *ctx)
>  {
>  	const struct name_decoration *decoration =3D get_name_decoration(&commi=
t->object);
> -	const char *head_ref =3D resolve_ref_unsafe("HEAD",
> +	const char *head_ref =3D xstrdup_or_null(resolve_ref_unsafe("HEAD",
>  						  RESOLVE_REF_READING,
>  						  NULL,
> -						  NULL);
> +						  NULL));
>=20=20
>  	while (decoration) {
>  		struct todo_item *item;
> @@ -5965,6 +5965,7 @@ static int add_decorations_to_list(const struct com=
mit *commit,
>  		decoration =3D decoration->next;
>  	}
>=20=20
> +	free((char *)head_ref);
>  	return 0;
>  }
>=20=20
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 7f0df58628..2e081b3914 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -2016,6 +2016,40 @@ test_expect_success REFFILES '--update-refs: check=
 failed ref update' '
>  	test_cmp expect err.trimmed
>  '
>=20=20
> +test_expect_success 'what should I call this?!' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit_bulk --message=3D"%s" 4 &&
> +		git branch branch1 HEAD^ &&
> +		git branch branch2 HEAD^ &&
> +		git branch branch3 HEAD^ &&
> +
> +		git worktree add WorkTree branch2 &&
> +		git worktree list --porcelain >out &&
> +		wtpath=3D$(sed -n -e "s%^worktree \(.*/WorkTree\)%\1%p" out) &&
> +
> +		cat >expect <<-EOF &&
> +		pick $(git log -1 --format=3D%h HEAD^^) 2
> +		pick $(git log -1 --format=3D%h HEAD^) 3
> +		update-ref refs/heads/branch3
> +		# Ref refs/heads/branch2 checked out at $SQ$wtpath$SQ
> +		update-ref refs/heads/branch1
> +		pick $(git log -1 --format=3D%h HEAD) 4

We can let this pass, but FWIW these are all cases where we'll lose "git
log"'s exit code. So:

	first=3D$(git log ...) &&
        [...]
        cat [...]
        pick $first
        [...]

If we want to catch that.
