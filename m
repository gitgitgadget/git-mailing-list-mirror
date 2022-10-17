Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5ACC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 16:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJQQbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 12:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJQQbd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 12:31:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABBD2BCA
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 09:31:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y14so26140286ejd.9
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GQw09iMJEanwInwUhJOFYg1dFfd6z2cAjv+5i1cZMC4=;
        b=KynJGOb2sI9LUGA79oLcV89lSOL/EpCBRh6PbjClur/yzDcLw8IsfyMyjhc9Se7bgl
         eKmQZCGM5bngJj4jPbWErhH3TRpjgpNeJWW8U0w1TTm+PB6lTHPGVl1YnFKymvGyRIHW
         qzknnkMw/Ezp3+dVJf8Qsi2OtUz5iQYvfcjbWR/xfUmbZGfoAsmr1fyvzOD6RfCaSoph
         RZme2YJMdHppJ24qYqsfAsgIU4z0Whh9BdWNuRl0OWidrUcgsZyLsD6VdYP/4man9iP0
         Md8ZAQn/9gPkcO8cskTUXoIsiJ9b4v6JNmhadk7xKDDWxvQJsdL4fXM+x+xfYGQYGRBX
         nf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQw09iMJEanwInwUhJOFYg1dFfd6z2cAjv+5i1cZMC4=;
        b=Z0oqrf368/oaIupFlWo0wuLgp7/pr9aX3hVs3y1WxQkze4VAeCUONceIlVuyV+rf4z
         rK5jPHfsIlGxOhs4TggeYn+bo2BFnxdptT+CnjCIXm7cQc6KtbQIQlvT7//PCGJaEhJv
         N2FmrQMxPw1T7JzLyJE5jdEwLewPa9YJLd8wan9ZWNyT0wef2oUAl/F/ckfJLhcritkP
         3MgcJBtbRuwoDpZDnULidVlxzDynse355BtQUaD4qkt4xOa5BwAy4OgcwLzSElKAAeWk
         lKMSvmKnMikA8tCP0thZqUEhoJ067tQNiLgZUQTMuTUvctoASoqlkzpuqTueXahbe73+
         mh+g==
X-Gm-Message-State: ACrzQf2gEN488KiScP4G2zej5oH8A7VMThyDscvskuJkKoug0D2tSmnC
        ec9luVEQs50zVBa5YNtFm1o=
X-Google-Smtp-Source: AMsMyM6gscr1GDOTZDFgelUVxwOIrws7mRrG9jj2Ffy7nv65uOPYMhWkIA/xFXg9WpA9y3yXVCylNA==
X-Received: by 2002:a17:907:6296:b0:787:d066:9fcf with SMTP id nd22-20020a170907629600b00787d0669fcfmr8902017ejc.692.1666024289772;
        Mon, 17 Oct 2022 09:31:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b00731582babcasm6298579ejh.71.2022.10.17.09.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:31:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okT1U-005XVH-05;
        Mon, 17 Oct 2022 18:31:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 5/8] rebase: rename merge_base to branch_base
Date:   Mon, 17 Oct 2022 18:19:52 +0200
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
 <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
 <00f70c9034452bd87c82fb3aea9658aec32f2ec1.1665650564.git.gitgitgadget@gmail.com>
 <221013.86bkqfleh5.gmgdl@evledraar.gmail.com>
 <7b9d2a05-de2e-d0e0-6554-a592fa2349d4@dunelm.org.uk>
 <221017.86pmeqk6yl.gmgdl@evledraar.gmail.com>
 <63c1636e-401d-89d3-9af3-69469dd4a3b0@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <63c1636e-401d-89d3-9af3-69469dd4a3b0@dunelm.org.uk>
Message-ID: <221017.86lepejtsw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 17 2022, Phillip Wood wrote:

> On 17/10/2022 12:27, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Oct 17 2022, Phillip Wood wrote:
>>=20
>>> On 13/10/2022 20:16, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> On Thu, Oct 13 2022, Phillip Wood via GitGitGadget wrote:
>>>>
>>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>>
>>>>> merge_base is not a very descriptive name, the variable always holds
>>>>> the merge-base of 'branch' and 'onto' which is commit at the base of
>>>>> the branch being rebased so rename it to branch_base.
>>>> To me "branch" means or has heavier implications of "named branch"
>>>> than
>>>> just a merge base, and this command is perfectly happy to work on
>>>> commits disconnected from any named branch.
>>>>> But more to the point, the rebase docs for --onto discuss a "merge
>>>> base", so you'd read those, and then encounter this code talking about=
 a
>>>> "branch base", and wonder what the difference was...
>>>
>>> Aren't the docs saying the merge base is the base of the commits
>>> (i.e. branch) being rebased? I don't think merge_base is a
>>> particularly helpful name as it doesn't tell us what it is the merge
>>> base of and branch_base was the best I could come up with. I see what
>>> you mean in the detached HEAD case, but as the command also works with
>>> named branches I hope it is fairly obvious what "branch_base" is in
>>> the detached HEAD case.
>> It *optionally* works with a <branch>, but doesn't require
>> one. E.g. try
>> this on git.git:
>
> Maybe I wasn't clear, I was referring to the fact that if HEAD isn't
> detached then it rebases the current branch not about the optional=20
> <branch> argument. I also think that the docs are for users, they are
> not a guide to the code. With this change if you search for merge_base=20
> in builtin/rebase.c you still find the part where we calculate the
> merge base. This commit was added in response to a review comment from
> Junio on V1, as far as I know he is happy with it and at this stage
> I'm disinclined to change it.

I was mainly fishing for whether *you* grokked that it wasn't always a
"merge base of a branch" in suggesting the rename. If you do & would
like to keep this it's fine by me.

Having said that.

I hadn't read the original discussion (or maybe I did, and
forgot). Re-reading you're referring to the discussion ending at[1].

I think using "base commit" in this case (your other suggestion) would
be better than either "merge base" or "branch base", just my 0.02.

In that case we could also use it consistently in our docs, and mention
that (in some cases) it's the "merge base", and in others something we
manually provide.

I agree that the docs are "not a guide to the code", and should not be
required to keep the two in sync at all times.

But just do be clear I do think it's a strong signal that the code is
being made more confusing if the variable that holds the "merge base"
now (as discussed in those terms in the docs) is named "branch base",
and we're seemingly unable (or at least I wasn't) to come up with a
corresponding doc change that doesn't start sounding self-contradictory.

I.e. given that the whole point of 5/8 is to come up with a more
descriptive name:

	merge_base is not a very descriptive name, the variable always holds
	the merge-base of 'branch' and 'onto' which is commit at the base of
	the branch being rebased so rename it to branch_base.

Cheers.

1. https://lore.kernel.org/git/c5b01472-7da9-6051-b127-1a8b8ddd2944@gmail.c=
om/

>> 	git checkout origin/next
>> 	touch f && git add f && git commit -m"file"
>> 	git rebase --onto origin/master^{} HEAD~
>> Here we transplant a commit on top of "next" to "master", without
>> either
>> of those *names* being involved, or their branches, just the
>> corresponding OIDs/tips.
>> That will go through e.g. can_fast_forward() which you're modifying
>> here, and now populate a "branch_base" variable, instead of a
>> "merge_base".
>> I know that we conflate the meaning of "branch" somewhat, even in
>> our
>> own docs. E.g. we sometimes use "branch" and "named branch", but usually
>> by "branch" we mean "named branch", and otherwise talk about a detached
>> HEAD, <commit> or "tip".
>> But in this case it's especially confusing in the post-image,
>> because
>> "git rebase --onto" explicitly uses an optional "<branch>" to
>> distinguish the "named branch" case from the case where we're operating
>> on detached a HEAD, or otherwise don't care about the "<branch>" (except
>> as generic "restore us to where we were" behavior).
>> So, if anything I'd think that we'd want something like this in
>> various
>> places in git-rebase.txt to make the distinction clearer:
>>=20=09
>> 	diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> 	index 9cb8931c7ac..e4700a6e777 100644
>> 	--- a/Documentation/git-rebase.txt
>> 	+++ b/Documentation/git-rebase.txt
>> 	@@ -18,7 +18,7 @@ DESCRIPTION
>> 	 -----------
>> 	 If `<branch>` is specified, `git rebase` will perform an automatic
>> 	 `git switch <branch>` before doing anything else.  Otherwise
>> 	-it remains on the current branch.
>> 	+it remains on the current tip or named branch.
>>=20=09
>> 	 If `<upstream>` is not specified, the upstream configured in
>> 	 `branch.<name>.remote` and `branch.<name>.merge` options will be used =
(see
>> But your post-image seems to be to make this sort of thing
>> explicitly
>> more confusing, and e.g. these parts:
>> 	@@ -206,8 +206,8 @@ OPTIONS
>> 	 --onto <newbase>::
>> 	 	Starting point at which to create the new commits. If the
>> 	 	`--onto` option is not specified, the starting point is
>> 	-	`<upstream>`.  May be any valid commit, and not just an
>> 	-	existing branch name.
>> 	+	`<upstream>`.  May be any valid commit, and not just an <-- this
>> 	+	existing branch name. <--- this
>> 	 +
>> 	 As a special case, you may use "A\...B" as a shortcut for the
>> 	 merge base of A and B if there is exactly one merge base. You can
>> To sum up why I find this confusing: Reading this from the docs
>> onwards
>> I'd think (as is the case) that "<branch>" is optional. Then when I read
>> the code I'd think a "branch_base" is something that *only* had to do
>> with the "<branch>" case.
>> But that's not the case, it's just a generic "merge base" in the
>> same
>> sense that "git merge-base" accepts all of these
>> 	$ git merge-base origin/master origin/next
>> 	d420dda0576340909c3faff364cfbd1485f70376
>> (These two are equivalent, just demo'ing that we don't need the peel
>> syntax):
>> 	$ git merge-base $(git rev-parse origin/master) $(git
>> rev-parse origin/next)
>> 	d420dda0576340909c3faff364cfbd1485f70376
>> 	$ git merge-base origin/master^{} origin/next^{}
>> 	d420dda0576340909c3faff364cfbd1485f70376
>> What *would* make things much clearer is e.g. calling a variable
>> "branch_merge_base" *if* there is a case where that's a merge base only
>> for named branches, but I don't know (and didn't look carefully enough)
>> if you've got such a case or cases here. It just seems like a generic
>> "merge-base".
>>=20

