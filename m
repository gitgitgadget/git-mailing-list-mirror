Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0161F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 23:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdBDXeq (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 18:34:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57816 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751239AbdBDXeq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 18:34:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 793AC65696;
        Sat,  4 Feb 2017 18:34:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=ILJxfh7P7ztjAlSvvD4PlbTyCTE=; b=qtXoCv
        6AtN18SfyyGGAZc3z6XQi2FjhYAtGlX5tsp1tswfryyLZdmDzSLAKTgJZe2gUCal
        /NPfLKXuPts9DNiwCJi4/IHjCSSlhUe4KhiwmNXWsF1IgboJr6ofpqzOOmhs0vzn
        GN2ibVIG7Z8d0Lp4PjjB9ICA94HZFXj8Qjoy8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70FF865695;
        Sat,  4 Feb 2017 18:34:44 -0500 (EST)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E17AF65694;
        Sat,  4 Feb 2017 18:34:43 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: init --separate-git-dir does not set core.worktree
In-Reply-To: <CACsJy8C=owNPpND4Ab7bFE24kpWBr5fQdob21DEDCckCXu0Mng@mail.gmail.com>
References: <87h94d8cwi.fsf@kyleam.com> <CACsJy8AZUBt76ZocS2JEr9FP_8Obv8L911AvZxE_sww3qXB7qw@mail.gmail.com> <87efzg7oq3.fsf@kyleam.com> <CACsJy8C=owNPpND4Ab7bFE24kpWBr5fQdob21DEDCckCXu0Mng@mail.gmail.com>
Date:   Sat, 04 Feb 2017 18:34:43 -0500
Message-ID: <877f55r0mk.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81C41094-EB32-11E6-A3C1-A7617B1B28F4-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=ILJxfh7P7ztjAlSvvD4PlbTyCTE=; b=SGoYyYw+srgRMzwIK575bSt//koqompoGd8U6cQcXpLgZ8xBwQIbH7fieBeOkjhyngtGswnuPM2ACHbt+qe2328+QQJf9l12PJ847/RIi/c7fjMPXQ39Sd4LO1CbPUqGNPk12EZogIt71R0k/RGB+mphzDqZMczj5mauBBlJzrI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Feb 2, 2017 at 7:37 PM, Kyle Meyer <kyle@kyleam.com> wrote:

[...]

>>  * COMMIT_EDITMSG in .git/modules/<module>/: set working tree to the
>>    output of "git rev-parse --show-toplevel"
>>
>>  * COMMIT_EDITMSG in .git/worktrees/<wtree>/: set working tree to the
>>    path in .git/worktrees/<wtree>/gitdir, minus the trailing "/.git"
>>
>>  * COMMIT_EDITMSG in .git: set working tree to the parent directory
>>
>> This fails for a repo set up with --separate-git-dir [*2*], where the
>> last step will go out into an unrelated repo.  If core.worktree was set
>> and "git rev-parse --show-toplevel" returned the working tree like it
>> did for submodules, things would work.
>
> OK. If I read this right, given a path of any text file somewhere
> within ".git" directory. you are tasked to find out where the
> associated worktree is?

Right

> I.e. this is not an emacsclient executed as part of "git commit",
> correct?

... but it is from a "git commit" call.  I think you're asking because,
if we know where "git commit" was called from, we know what the working
tree is.  This is true, but with the current Magit design, the function
for determining the top-level of the working tree, magit-toplevel,
doesn't have access to this information.  From Emacs, Magit calls "git
commit", setting GIT_EDITOR for that process so that git invokes the
current Emacs instance for editing the commit message.  From
COMMIT_EDITMSG, we want the magit-toplevel to be able to determine the
working tree location so that commands can use magit-toplevel to set
their pwd.

The only Magit command that currently relies on magit-toplevel to
determine the working tree from ".git/COMMIT_EDITMSG" is a command that
shows a diff with the staged changes in a separate buffer.  (Even though
"git diff --cached" would work from within ".git/", some functionality
in this buffer depends on its pwd being set top-level of the working
tree.)

So, whatever solution we come up with on the Magit end will likely
involve recording where "git commit" was called so that the diff command
can figure out the working tree.

> So you need some sort of back-link to ".git" location. And
> unfortunately there's no such thing for .git file (unless it points to
> .git/worktrees/...). I'm hesitant to set core.worktree unless it's
> absolutely needed since it may have unexpected interaction with
> $GIT_WORK_TREE and others (not sure if it has any interaction with
> submodules too). I think adding a new file "gitdir" would be a safer
> option.
>
> I'm not entirely sure if enforcing "one worktree - one repository" is
> safe though. The first two bullet points are very specific and we can
> assume that, but ".git" files alone can be used for anything. In
> theory you can always create a secondary worktree (that's not managed
> by "git worktree") by setting GIT_WORK_TREE and "git checkout -f"
> somewhere. But I guess those would be temporary and nobody would want
> magic to point back to them.

Right, makes sense.

Unfortunately, magit-toplevel was designed thinking that the
--separate-git-dir / core.worktree behavior in Git 2.8.4 and lower was
intentional [*].  We'll need to rework this on our end.

Thanks for your input and for confirming that "git init
--separate-git-dir" does not set core.worktree by design.

[*] https://github.com/magit/magit/issues/460#issuecomment-36035787.

-- 
Kyle
