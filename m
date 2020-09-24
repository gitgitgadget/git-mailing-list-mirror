Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084D7C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 09:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A171523977
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 09:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChEtCWtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgIXJ66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 05:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgIXJ66 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 05:58:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F683C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 02:58:58 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e11so6425502wme.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TK752k549nCt3Wt8+F3icy/Yic62JJ8QI+tu4Js81Hk=;
        b=ChEtCWtF88B9sMVviHMcjU2tSOTsPQa/gFV0FzZ5JIfRqWmHy/TiIUfmKikF5ZOuuY
         0PbouVZPv2+eOHgll+AYAC4VW+rC3Ua0/6wmVUWeDj5FBfQ/8u3T/+jG6vP+MDbz5AzF
         HSt/mlKydusha49gP+T7p9P1tnWSzzSqvKdLatc+mlVeglWih/u67bNup6vEMuj2MiUd
         LnUoovWogvIxWQQa8+hnGPue69OzKJod5kp1k4kMUuiqeX8utWQhrjNkzFrNse6fcHVs
         kt+J2QMyGIcSx4P4Wge9YZ8BcdH3WRQ0aLPrvhyVVut+dIwqI1cumqiXeadGviYKm2Xl
         014w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TK752k549nCt3Wt8+F3icy/Yic62JJ8QI+tu4Js81Hk=;
        b=MHzwOpZbcLHGC7LgeqznrjzxNJH1PYE7mW7ro5ZRxEJsgohuziUj7XmdNPahxRG22N
         GDipN8iZUrr7/XQr/OXY/HTCucKuYqAFChVL4nvlU1xvQm/frLgsnJdWoNzo3+svTR+8
         XKR2XNkGvDHz9ttUwypZDQ/LuzLuYMLmvcuo5Zt63/8FUza8F0gqLHaIo3x6ZU+fjcLJ
         49fJOIHu3eG1ZOSlIYBNcNk8ElhRF9An5c0TqsTFlEd/wMANmT9+NzYFNpbTs2cbNaBy
         fcrskQwqfeh01OR9MibS0ycFYGxXjgwo8GYNo+55imlV9sh9elWS/KEmnLxkB0K51kbq
         SUyQ==
X-Gm-Message-State: AOAM532hi9zmb7Cpf2egxB10IT9+DusUkxU/Ur3Ac0baBzXktHmpeTti
        FwlojcL1Sf8WnDLRBWNzkxw=
X-Google-Smtp-Source: ABdhPJxi4liUTBbaLJ7RP8Ie5/r3V6SjvE9+z6Gbm2IGBnK65APxK/JWmxyJ08rCHWpC26QbbHxkew==
X-Received: by 2002:a1c:dd87:: with SMTP id u129mr3859722wmg.172.1600941536743;
        Thu, 24 Sep 2020 02:58:56 -0700 (PDT)
Received: from [192.168.1.240] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.gmail.com with ESMTPSA id n66sm2819359wmb.35.2020.09.24.02.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 02:58:56 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] commit: add an option the reword HEAD
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
 <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2009231206290.5061@tvgsbejvaqbjf.bet>
 <41dcb8cb-8e43-04ce-2ddd-d69c765ee327@gmail.com>
 <nycvar.QRO.7.76.6.2009232241140.5061@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com>
Date:   Thu, 24 Sep 2020 10:58:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2009232241140.5061@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 23/09/2020 21:42, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 23 Sep 2020, Phillip Wood wrote:
> 
>> On 23/09/2020 11:22, Johannes Schindelin wrote:
>>>
>>> On Mon, 21 Sep 2020, Phillip Wood via GitGitGadget wrote:
>>>
>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>
>>>> If one notices a typo in the last commit after starting to stage
>>>> changes for the next commit it is useful to be able to reword the last
>>>> commit without changing its contents. Currently the way to do that is
>>>> by specifying --amend --only with no pathspec which is not that
>>>> obvious to new users (so much so that before beb635ca9c ("commit:
>>>> remove 'Clever' message for --only --amend", 2016-12-09) commit
>>>> printed a message to congratulate the user on figuring out how to do
>>>> it). If the last commit is empty one has to pass --allow-empty as well
>>>> even though the contents are not being changed. This commits adds a
>>>> --reword option for commit that rewords the last commit without
>>>> changing its contents.
>>>
>>> I would like to explain the idea I tried to get across when I proposed to
>>> implement support for `reword!` (and `--reword`) because I feel that it
>>> will change the design of this patch in a rather big way.
>>>
>>> First of all, let me explain the scenario in which I long for the
>>> `--reword` option: I maintain several patch thickets, the most obvious one
>>> being Git for Windows' patch thicket that is merge-rebased [*1*] onto
>>> every new Git version.
>>>
>>> At times, I need to adjust a commit message in that patch thicket. It
>>> would be quite wasteful to perform a full merge-rebase, therefore I
>>> typically call `git commit --squash <commit> -c <commit>`, copy the
>>> oneline, paste it after the `squash!` line (surrounded by empty lines), and
>>> then reword the commit message. When the next Git version comes out, I do
>>> a merging-rebase, and when the editor pops up because of that `squash!`
>>> oneline, I remove the now-obsolete version(s) of the commit message.
>>>
>>> Obviously, I have to be careful to either also pass `--only` (which I
>>> somehow managed to learn about only today) or I have to make sure that I
>>> have no staged changes. In practice, I actually specify a bogus path,
>>> which has the same effect as `--only`.
>>>
>>> What I would actually rather have is the `--reword` option: `git commit
>>> --reword <commit>`. In my mind, this would _add_ a new, "empty" commit,
>>> letting me edit the commit message of the specified commit, and using that
>>> as commit message, prefixed with the line `reword! <oneline>`.
>>>
>>> This, in turn, would need to be accompanied by support in the interactive
>>> rebase, to perform the desired reword (which is admittedly quite a bit
>>> different from what the way the todo command `reword` works).
>>>
>>> With that in mind, I would like to caution against the design of your
>>> current patch, because it would slam the door shut on the way I would like
>>> `--reword` to work.
>>
>> I'm keen to have an easy way to reword HEAD and a way to implement your
>> reword! idea.
>>
>> I posted a comment on your gitgitgadget issue about reword! and drop![1]
>> pointing to some patches[2] that implement the reword! idea as amend!. I think
>> we want to be able to  fixup a commit and reword it at the same time which is
>> way I chose the name amend! rather than reword! The implementation currently
>> changes `git commit --amend` to take an optional commit which isn't ideal. I
>> wonder if calling it revise! would be better then we could have `git commit
>> --reword` to reword HEAD and `git commit --revise <commit>` to create a commit
>> that will reword and fixup <commit> when the user runs `git rebase -i
>> --autostash`. fold! is another possibility.
>>
>> I don't think this patch series stops us implementing something for rebase but
>> it would mean we couldn't use the name reword! unless we allow `git commit
>> --reword` to take an optional commit which I'm not that keen on.
>>
>> What do you think to an alternative name?
> 
> I am really worried that the proliferation of confusingly similar options
> will increase Git's reputation for being awfully hard to use.

That is certainly a consideration, but not having a way to easily reword 
the last commit without changing its contents does not to improve Git's 
user friendliness. If you only just discovered using --only for 
rewording it's a fair bet a lot of regular users are unaware of it.

The reason I'm not keen on having --amend or --reword take an optional 
commit is that I think it is confusing as it means sometimes that option 
creates a new commit and sometimes it modifies the last commit 
furthermore passing --reword=HEAD would not reword HEAD but creates a 
reword! commit.

Rewording the last commit and creating a reword! commit are two 
different operations so I'm not sure having different options for them 
is that bad. To me the real confusion is that we end up with 3 options 
that create different flavors of fixup commits. It would be much nicer 
if there was a single fixup type that reworded the message as well as 
fixing up the contents and users just passed `--no-edit` to avoid 
changing the message. I'd really like to somehow change the semantics of 
`git commit --fixup/--squash` and the rebase `fixup`/`squash` commands 
to actually reword the commit. I guess that would mean an opt-in config 
setting which isn't ideal.

As an aside I'd like to see a new `rewrite` command that wraps the 
functionality of `rebase -i` so the user does not have to deal with 
fixups and editing a todo list. `git rewrite amend <commit>` would be 
equivalent to starting a rebase and marking <commit> as `edit`, the user 
can then make their changes and run `git rewrite continue` which would 
finish the rebase or `git rewrite amend <another-commit>` which would 
either alter the todo list to mark <another-commit> as `edit` or create 
new entries to rewind the rebase if <another-commit> is not in the todo 
list and then run `git rebase --continue`. Additionally there would be 
`reword` and `drop` commands and support for blame so that the user can 
do all this from an editor which would run `git rewrite amend -L 
<current-line> <current-file>` to amend the commit that introduced the 
current line. I've got a nasty scheme prototype of this and I've found 
it really useful. For an individual developer developing a patch series 
it is much more convenient to just edit the history directly rather than 
creating fixup! commits (which often seem to have conflicts when they 
are applied). It would not address your use where you don't want to be 
rebasing all the time though.

Best Wishes

Phillip

> Ciao,
> Dscho
> 
