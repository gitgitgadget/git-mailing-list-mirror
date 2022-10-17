Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2926C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 11:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJQLrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 07:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJQLr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 07:47:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0F4564D9
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 04:47:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ot12so24330995ejb.1
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 04:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jfLfhF9tlQgjCPIzbXTipvJfa73OmOLbZKdaWAxcIbA=;
        b=jzWa1irh2y+QEWwvJ6GmYPQauAT1EF/mcn2as0lXmhKJgRJDZpDbtpJeKc1IL51Di0
         m/VYhQtBD7nn2LUS3qsU3Z0CDJKhxDzoK8yHe1xp9mOvkHm/pECslMRxkpM9hsdJrIFa
         CIu3Wp7yezQDVX3phOncQ7qi2xWMT9pSZnf4YrhuOXCVRLex9idKjnzhr2P2t8bD2Rdo
         zPM7IUkpzQssPNakrIQKPl4YR9ah0r92K3OLgD7frkeqIGdQYt/5LgDvmVPT782/y/hb
         sVOXgUOaJHxDFSkHP90f2JjcTdGh0N6PENXazpid6Qrs6DFl3F5A/M4u4UE1HT896xw2
         VLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jfLfhF9tlQgjCPIzbXTipvJfa73OmOLbZKdaWAxcIbA=;
        b=1qAeuGGy2KVd0v6sswrhmf1cnq6Izu/jXY/erJ2X0sJqN3UFDot5jJRzP/JmDD0F1a
         gxW3AzScgTs0w02oy+frML6KrimJD1p7DxOLOW3ysVuQWAlH4lpl5K61LO5ALc1xf09S
         hK594fgBqmu4yDNkZ3IeYw5iWLTxmKcGVY4aAY1mER9VXvLLIg9ut77ed2+/0xjtai/d
         +1AwhwEOO2wG3WsTy+UpBaHqkgIqtoqHfuTi5ygA57OsvWNnubvFrlNhZS8Fd6GCjBvA
         nikX8AfViQsB7NTh9X51e5a9vT6QaRMBEHMFtCu+MTSmoisDrRbwFOtuB6ItUKhaBOPj
         8waA==
X-Gm-Message-State: ACrzQf3t/UxokBs9mRb1V/i5ANAxR6sY79emRcOozCrEpxTF7fvlhiMW
        Bl+LoH1c/Yts/m3BnuuMo0mDdf7mKp4=
X-Google-Smtp-Source: AMsMyM412Gy/oAFzVJnlQvOQE+RcECivrKU0sGUgM3H/PbhChe+i4m1U1e+Yjsl4KCu8f87P5yXXHg==
X-Received: by 2002:a17:907:7f8b:b0:78d:eed2:acc3 with SMTP id qk11-20020a1709077f8b00b0078deed2acc3mr8389688ejc.105.1666007236345;
        Mon, 17 Oct 2022 04:47:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402020400b0045754cd5e08sm7221905edv.39.2022.10.17.04.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 04:47:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okOaQ-005RBt-2e;
        Mon, 17 Oct 2022 13:47:14 +0200
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
Date:   Mon, 17 Oct 2022 13:27:25 +0200
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
 <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
 <00f70c9034452bd87c82fb3aea9658aec32f2ec1.1665650564.git.gitgitgadget@gmail.com>
 <221013.86bkqfleh5.gmgdl@evledraar.gmail.com>
 <7b9d2a05-de2e-d0e0-6554-a592fa2349d4@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <7b9d2a05-de2e-d0e0-6554-a592fa2349d4@dunelm.org.uk>
Message-ID: <221017.86pmeqk6yl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 17 2022, Phillip Wood wrote:

> On 13/10/2022 20:16, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Oct 13 2022, Phillip Wood via GitGitGadget wrote:
>>=20
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> merge_base is not a very descriptive name, the variable always holds
>>> the merge-base of 'branch' and 'onto' which is commit at the base of
>>> the branch being rebased so rename it to branch_base.
>> To me "branch" means or has heavier implications of "named branch"
>> than
>> just a merge base, and this command is perfectly happy to work on
>> commits disconnected from any named branch.
>> > But more to the point, the rebase docs for --onto discuss a "merge
>> base", so you'd read those, and then encounter this code talking about a
>> "branch base", and wonder what the difference was...
>
> Aren't the docs saying the merge base is the base of the commits
> (i.e. branch) being rebased? I don't think merge_base is a
> particularly helpful name as it doesn't tell us what it is the merge
> base of and branch_base was the best I could come up with. I see what
> you mean in the detached HEAD case, but as the command also works with
> named branches I hope it is fairly obvious what "branch_base" is in
> the detached HEAD case.

It *optionally* works with a <branch>, but doesn't require one. E.g. try
this on git.git:

	git checkout origin/next
	touch f && git add f && git commit -m"file"
	git rebase --onto origin/master^{} HEAD~

Here we transplant a commit on top of "next" to "master", without either
of those *names* being involved, or their branches, just the
corresponding OIDs/tips.

That will go through e.g. can_fast_forward() which you're modifying
here, and now populate a "branch_base" variable, instead of a
"merge_base".

I know that we conflate the meaning of "branch" somewhat, even in our
own docs. E.g. we sometimes use "branch" and "named branch", but usually
by "branch" we mean "named branch", and otherwise talk about a detached
HEAD, <commit> or "tip".

But in this case it's especially confusing in the post-image, because
"git rebase --onto" explicitly uses an optional "<branch>" to
distinguish the "named branch" case from the case where we're operating
on detached a HEAD, or otherwise don't care about the "<branch>" (except
as generic "restore us to where we were" behavior).

So, if anything I'd think that we'd want something like this in various
places in git-rebase.txt to make the distinction clearer:
=09
	diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
	index 9cb8931c7ac..e4700a6e777 100644
	--- a/Documentation/git-rebase.txt
	+++ b/Documentation/git-rebase.txt
	@@ -18,7 +18,7 @@ DESCRIPTION
	 -----------
	 If `<branch>` is specified, `git rebase` will perform an automatic
	 `git switch <branch>` before doing anything else.  Otherwise
	-it remains on the current branch.
	+it remains on the current tip or named branch.
=09=20
	 If `<upstream>` is not specified, the upstream configured in
	 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see

But your post-image seems to be to make this sort of thing explicitly
more confusing, and e.g. these parts:

	@@ -206,8 +206,8 @@ OPTIONS
	 --onto <newbase>::
	 	Starting point at which to create the new commits. If the
	 	`--onto` option is not specified, the starting point is
	-	`<upstream>`.  May be any valid commit, and not just an
	-	existing branch name.
	+	`<upstream>`.  May be any valid commit, and not just an <-- this
	+	existing branch name. <--- this
	 +
	 As a special case, you may use "A\...B" as a shortcut for the
	 merge base of A and B if there is exactly one merge base. You can

To sum up why I find this confusing: Reading this from the docs onwards
I'd think (as is the case) that "<branch>" is optional. Then when I read
the code I'd think a "branch_base" is something that *only* had to do
with the "<branch>" case.

But that's not the case, it's just a generic "merge base" in the same
sense that "git merge-base" accepts all of these

	$ git merge-base origin/master origin/next
	d420dda0576340909c3faff364cfbd1485f70376

(These two are equivalent, just demo'ing that we don't need the peel
syntax):

	$ git merge-base $(git rev-parse origin/master) $(git rev-parse origin/nex=
t)
	d420dda0576340909c3faff364cfbd1485f70376
	$ git merge-base origin/master^{} origin/next^{}
	d420dda0576340909c3faff364cfbd1485f70376

What *would* make things much clearer is e.g. calling a variable
"branch_merge_base" *if* there is a case where that's a merge base only
for named branches, but I don't know (and didn't look carefully enough)
if you've got such a case or cases here. It just seems like a generic
"merge-base".


