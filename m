Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66C28727D
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965951; cv=none; b=ct4PbktNe+pqp7tCXTC/SWXKX4U6nNWew2Qgu4sFMM6PG0SAyTwDtq6pF509ukRZ7fK1Y7ZksMf8X2+Sv0rlXDW84eZELgvAdBsGmHP/j9HZ1Obqgu+acNDGqW1+RRF1hO2Wm33YCkpjItjtmiFdDR6UmPHC7U88DVvhtqDfw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965951; c=relaxed/simple;
	bh=DRZxJ3ojqTKTYhl3bELa/PJ/D8P+ivkVI1oJfsO6Td0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ATLe2qkcgmS7PD0WCsFBKfz980uwY9iC2D3gaNDZxrr1xrha6DmVK1oaeKnDYdZ8B3vX344aQ9BmoOD/4+F3NYm3F/0BHPbT3Nyof5Bn6vGgQuTnu91A9AUMDEUzVx8Yucn9KHH2yyOc6t/T1k/2ew4nJLqMKSQpyg4ChJVaA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=q9NCqiar; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="q9NCqiar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=LGKoGxX5pFYLBD9FkOTk1YU0s/rrl5DYdkGXdZeXixY=;
  b=q9NCqiar1GQSfW+MRK1VkTtpCJg4PwkTBXGmul55zp7PuK7gxk/m3UvP
   rl/BBckhoEgAQzBYo0J3LQ+oDfTSvBgF18RdY3cZluY/wMMRa2RkR4GaV
   Wa5gtTzAgyGh/lU+z5ymA9svFPol5jz0ljKFjSabP8ndGAfy70Ugxs4hW
   o=;
X-CSE-ConnectionGUID: Y66dTiwDQzKaY0z1T0vsBA==
X-CSE-MsgGUID: 0ZdF5JHyQA+oIvlLCcrtaw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=gabriel.scherer@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.18,267,1751234400"; 
   d="scan'208";a="239198503"
Received: from 91-168-152-151.subs.proxad.net (HELO [192.168.1.16]) ([91.168.152.151])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 21:52:20 +0200
Message-ID: <0dfe3e31-5486-446e-8af5-20669c06ea64@inria.fr>
Date: Mon, 15 Sep 2025 21:52:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gabriel Scherer <gabriel.scherer@inria.fr>
Subject: Re: [PATCH 1/3] checkout: provide hint when failing due to another
 worktree
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
 <20250913141327.2775228-2-gabriel.scherer@inria.fr>
 <be510685-3be1-4f71-806a-6b580bb1cf21@app.fastmail.com>
 <d44109a1-0ff5-49f8-885b-9aae195ec492@inria.fr> <xmqqikhkhzbm.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqikhkhzbm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the detailed comments!

On 15/09/2025 10:53, Junio C Hamano wrote:
> Gabriel Scherer <gabriel.scherer@inria.fr> writes:
> 
>> In my in-progress version of the patch, the reworded advice is as follows:
>>
>> fatal: 'foo' is already used by worktree at '/home/gasche/Prog/foo'
>> hint: If you want to proceed anyway, try again with
>> --ignore-other-worktrees.
>> hint: Changes to the branch will also impact the other worktrees.
>> hint:
>> hint: If you want to detach HEAD at that branch, try again with the
>> --detach option.
> 
> To those who _need_ these hint messages (in other words, those who
> cannot choose the right way to do what they wanted to do without
> getting hints), I suspect think "if you want to proceed anyway",
> "impact" and "if you want to" are not concrete enough to help them
> make the right choices.
> 
> "If you want to proceed anyway"---of course they all do, because
> they do not know what risks they are taking, and this message does
> not tell them about.  So that isn't very helpful message.
> 
> Changes to the branch would not change the index or any files in the
> working tree of other worktree, leading these users to think that
> they safely live in two separte isolated worlds in these two
> separate worktrees.  Is it clear to them that the "impact" you are
> talking about is exactly the fact that these changes are *NOT*
> propagated to other worktree?
> 
> Then you have "if you want to" without telling the readers why they
> should "want to" (or not) detach.  Which is not all that helpful.
> Why should I go into the scary sounding "detached HEAD" mode?  For
> what for?  If a user can answer that question themselves, they do
> not even need that hint.

To my defense, this is the hint wording that is already in the git codebase:

   $ git switch HEAD~3
   fatal: a branch is expected, got commit 'HEAD~3'
   hint: If you want to detach HEAD at the commit, try again with the 
--detach option.

I am happy to improve this wording as well if we can converge to 
concrete recommendations.

> I think the message should help the readers eventually realize the
> following things to make intelligent decisions.  Making them short
> to fit in the "hint:" messages is left as an exercise ;-)

Hints make advanced features self-discoverable -- otherwise we find them 
out by reading the entire doc of a command when we are stuck After 
reading the hint, users can read the documentation in a more targeted 
way to understand the implications.

Would referring the user to the documentation be acceptable?

For 'detach' hints, there is a detailed section DETACHED HEAD in the 
'checkout' documentation, which the hint could refer to. For example 
(imaginary output):

   $ git checkout HEAD~3fatal: a branch is expected, got commit 'HEAD~3'
   hint: If you want to detach HEAD at the commit, try again with the 
--detach option.
   hint: See the "DETACHED HEAD" section in the 'git checkout' 
documentation.

On the other hand for --ignore-other-worktrees there is no user-friendly 
documentation of these questions currently (I looked at the 'worktree' 
documentation, in particular for the --force option, and at the 
--ignore-other-worktrees documentation for 'checkout').

If you agree in principle, I can update my patchset with a documentation 
commit that explains the justification for the worktree restriction, 
what happens if we ignore this restriction, and what is the recommended 
way to respect it.

>   - 'foo' is already in use and in which worktree.  Your message
>     "fatal:" is very clear and is good.
> 
>   - if you checkout 'foo' here and start growing or otherwise
>     updating the history of 'foo' in this worktree, the index and the
>     working tree files of other worktree(s) will go out of sync with
>     the tip of 'foo'.  if they 'git commit' from that state, for
>     example, it is very likely that they will record a change that
>     reverts your changes from the history of 'foo', and you do not
>     want that.

(This gets me to wonder if a desirable behavior could be to 'detach' the 
other worktrees that had the same branch checked out, instead of failing 
on checkout. Users starting to use the other worktree again would 
possibly notice more quickly that something is amiss.)

For me this situation is not a big deal: if they commit the removal of 
'foo', presumably they will notice that the diff/changes in their commit 
is not what they expect, and they can come back to the previous state.

I agree that this is surprising and I understand why the project decided 
to discourage this by default ('fatal error' is plenty discouraging), 
but there is no data loss or anything of the sort, only recoverable 
surprises.

>   - if you want to grow history of 'foo' in potentially different
>     direction from what the other worktree with 'foo' is working on,
>     you are better off creating a separte branch 'foo2', with
>     anticipation that you'll eventually merge them together.

Use-case examples:

1. my colleague has a long-lived feature branch called 'super-feature'
2. last year I did a lot of review work on their branch in a separate 
worktree which is still somewhere on my filesystem, but which I am not 
actively working on anymore (and maybe never will)
3. I am in the middle of a bugfix session in another worktree, and 
suddenly I want to check if the bug also occurs in 'super-feature'; I 
stash my current stuff, checkout 'super-feature', and run 'git pull' to 
update it to match my colleague's remote to get the most recent version 
and test it against this bug.

In this scenario, I don't want my current work in (3) to be interrupted 
by the fact that an old worktree (2) exists that also tracks 
super-feature, and in fact I do want to update my local 'super-feature' 
branch to the most recent version.
Maybe later on I will come back to my old super-feature worktree (but 
maybe in another year), and I will start with a 'git pull' or some other 
command, and I will quickly realize that its index is out of date and 
fix it.

>   - if you only want to browse the files or build but have no
>     intention to change the files or make commits, then you can have
>     the HEAD of this working tree detached at the commit at the tip
>     of 'foo'.  An advantage of this approach is that it will keep you
>     honest, if you know that you are *not* on 'foo', but not on any
>     branch, it would discourage you from making commits and
>     disturbing the other working tree.  Another advantage is that
>     when you do need to make commits (perhaps while you are browsing
>     the files, you may find small typos you want to fix), you can at
>     that time run "git checkout -b foo-typofix" to create a new
>     branch and commit, without disturbing the other worktree that
>     have 'foo' checked out.

I agree that detached-head is a reasonable point in the design space in 
some cases, so I think that it is reasonable to hint about both options. 
I am happy to put the detach advice first if this has your preference.

(Note: In the earlier mailing-list thread I discarded detached HEAD 
because its default rendering in the git bash prompt is unpleasant, it 
shows the commit and does not mention the detached branch name anymore, 
which is disorienting. I have since realized that there is a non-default 
setting GIT_PS1_DESCRIBE_STYLE=branch that can be used to see say 
"((trunk))" in that case (when we are detached on top of a "trunk" 
branch, which makes it much more pleasant to use.)

