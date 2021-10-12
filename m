Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2040C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 08:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB41560E54
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 08:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhJLI71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbhJLI7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 04:59:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4D0C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 01:57:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z20so78185371edc.13
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=uyzABi6KAWptfuK+4sAbE6WgdRO8aRnmfF7tJL1gJ4I=;
        b=afE6R138MEC8KbLfsYGuWsDmYONndIwpElkkYo/ewaGyP1za2uwbS58Ngzav0oeIFv
         7c7n8IjGmG6OskTUP+Qkegsus3yX2VgVYcAlPEnRIW2pqbRRxIwjGfrbHglM/XZ6UQAr
         k4eonU+jkDAd8vH5o7i+V9K5+vRoh6tn/2T3Mi2AOEYtJU/dd9XvXyqIqZYjIImYs7M2
         Kt5T1POAaftckeSkolNewuFnS0CoqAjSWIARiRTar/sAdq2nYjP+FrQl6LWZ/Uw1xhV3
         ashFFzSqBY2BtUCewcfMC46KAFj85riZNn28HjIs25M1R6nCqBbcl1xh3XbEzxF1/Gej
         3ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=uyzABi6KAWptfuK+4sAbE6WgdRO8aRnmfF7tJL1gJ4I=;
        b=AvnoZUmqxn+dS13GlxduawuvuRK25g2BYvTBMR3bz3lkMJLKRRvM8UkN+lY4fBlF03
         BMEJRmOKdi1AD/mzuLd/gUS9WKsRbhaX+0TPD1sAQ+ys9wHNCIb8MRyf+pwZ3tTDLgN2
         kagMtFhmmz7fYrMG6ovso+ifLSkx9znBT5Xs1b3lquTv0kme98bgqahs+AOu80grhqNZ
         FNKPQMIaz5RZYNfWmnm8vPmCPAbjr0yxdPxhHlryxRIVnb71hL4SfcPtf8/gLWWn5G25
         L/eIM72C4NN4KNZUnJRN28yLSUeLQCowaR8wqfzvAGoqB17/6oVZZWtoxmvSg9vRBjpN
         /btw==
X-Gm-Message-State: AOAM530bCU6SkACon8ok9o5jiy54vIzPyE9wSYgZZCDoEStJPpX2+Swl
        ny90mEYeuL+kYnerZxesyLs=
X-Google-Smtp-Source: ABdhPJzaOOq7C6qOl1oXpnI3mcs8xK/7bt3SiMLgRvaCbvjNsxRZKmfmLHl7wVJFj0TwDskbGGnmVg==
X-Received: by 2002:a17:906:3fc8:: with SMTP id k8mr30523076ejj.217.1634029033846;
        Tue, 12 Oct 2021 01:57:13 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lb20sm4578378ejc.40.2021.10.12.01.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 01:57:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 03/11] reset_head(): don't run checkout hook if there is
 an error
Date:   Tue, 12 Oct 2021 10:48:19 +0200
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <28872cbca687b057663a4e3408cb94d69fb60f94.1633082702.git.gitgitgadget@gmail.com>
 <xmqqtui05uxr.fsf@gitster.g>
 <b298f8cb-f55f-86f0-52fc-8d9db0047525@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <b298f8cb-f55f-86f0-52fc-8d9db0047525@gmail.com>
Message-ID: <877deilixj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Phillip Wood wrote:

> Hi Junio
>
> On 01/10/2021 21:52, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> The hook should only be run if the worktree and refs were successfully
>>> updated.
>> OK.  This is a behaviour change visible to end-users, and deserves a
>> mention in the release notes.
>>   - When "git rebase" attempted to check out a branch (or detached
>
> It only affects "git rebase --apply" as the "merge" backend forks "git
> checkout" which does not run the hook if it cannot update the worktree 
> or refs.
>
>>     the HEAD) to work on, we used to always call the "post-checkout"
>>     hook, even if the checkout failed to update the ref.  The hook is
>>     no longer called if the checkout fails.
>> or something.
>> Again, can the bug this step fixes be protected with a new test in
>> t/ please?
>
> I'll try and come up with something - it should be possible to arrange
> an untracked file to make unpack_trees() to fail, I'm not sure how
> we'd make update_ref() fail

If all else fails I think it's perfectly OK to just have that failure be
triggered by a:

    git_env_bool("GIT_TEST_FAIL_UPDATE_REF", 1) or
    git_env_bool("GIT_TEST_FAIL_UPDATE_REF_FOR_POST_CHECKOUT", 1)

*tests it out a bit*

I tried this and it "worked", as in it'll fail :)

diff --git a/refs.c b/refs.c
index 97a9501c06f..25e2b0ab49a 100644
--- a/refs.c
+++ b/refs.c
@@ -2016,6 +2016,9 @@ int refs_create_symref(struct ref_store *refs,
        char *msg;
        int retval;
 
+       if (git_env_bool("GIT_TEST_FAIL_REFS_CREATE_SYMREF", 0))
+               return -1;
+
        msg = normalize_reflog_message(logmsg);
        retval = refs->be->create_symref(refs, ref_target, refs_heads_master,
                                         msg);

That seems to me to also be a worthwhile thing to do/test for other
reasons, i.e. my HEAD won't update, but now my index is in some state
where it points to the new branch, but presumably we'd want to revert
that in case of the failure (probably a much more general issue than
you're poking at here...).

>>>
>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> ---
>>>   reset.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/reset.c b/reset.c
>>> index fc4dae3fd2d..5abb1a5683e 100644
>>> --- a/reset.c
>>> +++ b/reset.c
>>> @@ -125,7 +125,7 @@ reset_head_refs:
>>>   			ret = create_symref("HEAD", switch_to_branch,
>>>   					    reflog_head);
>>>   	}
>>> -	if (run_hook)
>>> +	if (!ret && run_hook)
>>>   		run_hook_le(NULL, "post-checkout",
>>>   			    oid_to_hex(orig ? orig : null_oid()),
>>>   			    oid_to_hex(oid), "1", NULL);

