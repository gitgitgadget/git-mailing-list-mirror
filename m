Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28350C7EE23
	for <git@archiver.kernel.org>; Tue, 30 May 2023 13:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjE3NCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 09:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjE3NCR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 09:02:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BEE13E
        for <git@vger.kernel.org>; Tue, 30 May 2023 06:01:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30aef0b8837so1303659f8f.1
        for <git@vger.kernel.org>; Tue, 30 May 2023 06:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685451712; x=1688043712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e6h/0v/BB4JrlkzJpy/jXvhark1QWN4SDCaFoB5PKAc=;
        b=NkJ3PRMv4j5R8fwWuzJdvnvDTT55EWPYhSGSqPu8MTF4Xgd6BK0LT4lzOraDo0ddjz
         uh5DAgNF/kd5+1DNAdMGINX2VRiyETn2ZKclewIOOxQgWju3NtKROB3NVuArF7I39gXp
         CBtBzYpU7u93Ou+AUejfawCADCEyN98wMn9y5CHs1CnnwXuwM0JhsEwdWyqxX9YCt0FY
         UTe5rAkMlJmKYsSog5coyRZqNUAxDTT9mqbjf94Id1asmTL2Bd+CgStt1Im5pyk2WJCR
         ihT0JEUpuSTw5pgNsU9nwHp0HoyocEkapwYICsgRsq8hrt+3AKyAqrTMHE1iT0k0IUEB
         H0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451712; x=1688043712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6h/0v/BB4JrlkzJpy/jXvhark1QWN4SDCaFoB5PKAc=;
        b=IgjoV9+Ldxx7g3oftSSqArm9Ds3ZXyxh810LG0Ua9P29YxM5AxERGty0QY0QK7aXm9
         Muskk1rZiAvJ2/3ckeAdQ33U3VlA34Y51zDxfE8Y7Cchga3tGgRxWL5XRnMcXphuzFk6
         zAj0keV2mcwX8pNXMu++u9MCjngCuqrhgPYfC+Ag9XtJ4+Fig1A+kbFaQAT83FS7L8hx
         BW8puazWzn+4GrgSgv645daLCFnWvkPrmrAumsmcGDvfSAVYBrbvuePMWVKBvcAXVpUy
         xMImsTEeCZWuCK1Fp6cH2ZGZ6UGrvpxwuGCsftj8zccuGOHe+Xd//OjuFEFBrqZ8t5Rt
         8dhQ==
X-Gm-Message-State: AC+VfDx741bQvYSgq7nYxT93fyt/SJuzE0pi4x6L8/EQB2F6bDisVzvw
        yA5R//Eot9KV8h7PZL56Kow=
X-Google-Smtp-Source: ACHHUZ6oCgwTCGBL/d3wDl3UztKNU5Ls1MyRrC34I1BrnoraBLEi8j6glvplvPqpxPGnqMORucen4g==
X-Received: by 2002:adf:f607:0:b0:309:32d1:59d5 with SMTP id t7-20020adff607000000b0030932d159d5mr1617634wrp.50.1685451711911;
        Tue, 30 May 2023 06:01:51 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id l9-20020adfe589000000b00307c8d6b4a0sm3267298wrm.26.2023.05.30.06.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:01:50 -0700 (PDT)
Message-ID: <2bd15b46-c6a4-5b97-9d0f-cb605a4627c1@gmail.com>
Date:   Tue, 30 May 2023 14:01:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] cherry-pick: refuse cherry-pick sequence if index is
 dirty
To:     Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1535.git.1684830767336.gitgitgadget@gmail.com>
 <CAPMMpojV1Ts=OKM0FbBHU6=EB5RKNxHucX-8VQmYoQBNefKpqQ@mail.gmail.com>
 <xmqqjzwyh9tp.fsf@gitster.g>
 <CAPMMpoic_+RATwS46=Bd2K4+D_5yEw9RQFGR075Bs4aQJUjtsQ@mail.gmail.com>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPMMpoic_+RATwS46=Bd2K4+D_5yEw9RQFGR075Bs4aQJUjtsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/05/2023 10:33, Tao Klerks wrote:
> On Wed, May 24, 2023 at 2:06 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Tao Klerks <tao@klerks.biz> writes:
>>
>>> The current implementation of this patch is far too restrictive. It
>>> doesn't break any tests (and maybe I should add one now that I know),
>>> but it's doing the wrong thing.
>>
>> I am ambivalent.  What do we want to see in a multi-pick sequence
>> that is different from rebase?
> 
> I would argue there are primarily three things that are different:
> 1. The checkout of the new base (and checkout of the original in an "--abort")
> 2. The support for and/or more-common expectation of "messing" with
> commits as you go, eg squash, edit
> 3. The (partial) support for rebasing/recreating merge commits
> 
> I'm not sure to what extent any of these justify having tighter
> restrictions on when we allow a rebase to start, though.
> 
>> A single-step cherry-pick can fail
>> safely before it touches the index or the working tree files, but if
>> two-step cherry-pick, whose first step succeeds, finds that it
>> cannot safely carry out its second step without clobbering the local
>> changes made to the working tree files, what should happen?  Are we
>> OK if we stopped in the state just after the first step has already
>> been done?
> 
> This is the current behavior: it stops before the specific pick that
> is going to affect local unstaged changes, or if there are *any*
> staged changes (in which case it stops as it's about to do the first
> pick - the first time this check runs). The reasoning for this
> behavior, as I understand it, is that the "--abort" strategy,
> intending to "undo whatever I started doing here, including a conflict
> resolution", resets the index. So as long as there is nothing you want
> to keep in the index, and as long as we know that any previous picks
> haven't impacted any files with unstaged changes, we're good.

"cherry-pick --abort" uses "reset --merge" so is slightly more 
complicated than just resetting the index.

> The bug that I want to fix is that we only end up checking whether
> there are changes in the index *after* we've already committed to
> resetting the index upon later "--abort". It's a kind of catch-22:
> we've detected that aborting would destroy your work, so we leave you
> in a state where the most obvious thing to do is abort, so we destroy
> your work... Of course, if you understand what's going on you can
> choose to "--quit" and *not* lose your work... but this is completely
> antithetical to the general intent of "--abort".
> 
> There's another, smaller flaw here I think, common to Merge,
> Single-Cherry-Pick, and Sequence-Cherry-Pick, which is that *if* you
> start with unstaged changes, and you end up in a conflict resolution
> or "--no-commit" pause, and you then "git add" your unstaged changes
> during that pause/resolution, and you *then* later "--abort"... then
> your originally-unstaged changes are destroyed by the "--abort" - so
> it has *not* taken you back to where you were before the operation
> started. This is, to me as a user, non-obvious, and could potentially
> lead to data loss. The only way I see to fix that, is to have *all* of
> these operations refuse to operate on dirty worktrees altogether -
> like rebase already does.
> 
> I suspect this level of "strictness" would be welcome to newcomers,
> and less welcome to existing experienced users.

Indeed, being able to cherry-pick when the worktree is dirty is 
occasionally useful but it is confusing when "cherry-pick --abort" does 
not restore the pre-cherry-pick state (and as Junio says below it would 
be complicated to preserve the initial changes when aborting).

>> My (tentative) answer to that question is "yes", but the recovery
>> options of "cherry-pick" may want to work differently from what we
>> have seen them traditionally do.  Namely, the user accepts that the
>> first step is already done, and stopping "cherry-pick", be it called
>> "--abort" or something else, should just remove the sequencer state
>> and behave as if the single-pick cherry-pick on the first step only
>> has just finished and leave such a state in the index and the
>> working tree.
> 
> This behavior exists, and is called "--quit", right?

I think so though I'm not sure what what "--quit" does to CHERRY_PICK_HEAD.

> The semantics as I understand it are:
> --quit: I know what I'm doing, just remove any "ongoing operation"
> metadata and let me work with the current index and worktree.
> --abort: This was a bad idea, please take me back to where I was
> before I started this operation (without losing any work I had
> ongoing, pls!)
> 
>>   If that is what we are going to do, then it would
>> make sense to adopt the same safety semantics we use for "git merge"
>> and "git checkout" to ensure only that the index is clean, relying
>> on the unpack-trees machinery that stops before clobbering a locally
>> modified working tree files.
> 
> Yep
> 
>> But if we are to aim for "all-or-none"
>> semantics people expect from aborting "git rebase", I suspect that
>> it would be way too complicated to allow random changes in the
>> working tree files that we may only discover to be problems after
>> starting the sequence of replaying commits one-by-one, and "too
>> restrictive" check may be justified.
 >
> I don't think I understand this argument. If we want to support both
> sets of semantics, then that's exactly what "--quit" and "--abort"
> achieve, right? (as long as we check for the dirty index *before*
> committing to destroying the index in case of "--abort")
> 
>>   To put it differently, if it
>> is too restrictive for multi-pick, then we would want to loosen it
>> for "git rebase" as well, as the issues are likely to be the same.
> 
> My argument for only changing "sequence-cherry-pick" here, and having
> it (continue to) use the index-safety-only semantics of
> single-cherry-pick and merge, is that *this is not a change in
> cabability* - it is only a bugfix. Switching to the worktree-safety
> semantics of rebase would be a substantial change in behavior beyond
> the bugfix.
> 
> I, personally, would prefer to see the worktree-safety semantics of
> rebase be used in *all* these operations, so I could no longer shoot
> myself in the foot by starting a merge, accidentally staging some
> previously-unstaged changes during conflict resolution, and then
> losing those changes by "--abort"ing. But I expect that this kind of
> change would need to be behind a config option of some sort, trading
> off safety against low friction.
> 
> I could imagine a setting like "core.OperationWorktreeSafety", with
> settings "default" (current behavior - rebase disallows dirty
> worktrees, the others disallow dirty index), "strict" (all behave like
> current rebase) and "lax" (all behave like merge).
> 
> As discussed elsewhere, I would also like to (have an option to) treat
> untracked files as "worktree dirtiness"/unstaged changes in exactly
> the same way as changes to tracked files - but that's another topic :)
> 
> I'll prepare a v2 with index-safety-only for sequence-cherry-pick for
> now, please let me know if a (better-named)
> "core.OperationWorktreeSafety" option is something that you'd be
> interested in / that would make sense to you.

I think it's worth considering a config option. One problem though is 
that if the user has to actively enable it to get greater safety it wont 
be much help to new users who don't know about it and if it is on by 
default we'll be breaking someone's existing workflow.

Best Wishes

Phillip
> Thanks!

