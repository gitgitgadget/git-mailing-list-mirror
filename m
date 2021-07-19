Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A38DC07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 14:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339B96113C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 14:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbhGSNdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 09:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239523AbhGSNdo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 09:33:44 -0400
Received: from mail.aixigo.de (mail.aixigo.de [IPv6:2001:67c:13b0:ffff::60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94705C061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 06:39:31 -0700 (PDT)
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
        by mail.aixigo.de (OpenSMTPD) with ESMTPS id 6cda04ef (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 19 Jul 2021 16:14:20 +0200 (CEST)
Received: from vmdpcl078.ac.aixigo.de ([172.19.100.218])
        by mailhost.ac.aixigo.de (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTPS id 16JEEJb32770431
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Mon, 19 Jul 2021 16:14:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aixigo.com;
        s=default; t=1626704059;
        bh=FnPedr2xbsN4rn1bssyRms/TZfjFwzAk7nr8K4Qkv18=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=a+DgaCPsSukqCotxAee5NZVVpUypfLK05UfXOE4/H4qHAnx8MD3c4aek56+xyVVmk
         J+LM5j/kFxc80Gcf1aagS3NAOGiF8OI8qY/WzWk5TfMvkMvPzxRvP9wJY10Gga3N6H
         Aqf8aRvoRIPMz54FgxIa/Cf3/K8/sPf4yxj0vzOw=
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
References: <60f1daa896f69_330208b1@natae.notmuch>
 <c54fa084-75f4-b775-8ac2-6df3c7a36571@aixigo.com>
 <xmqqwnpooctj.fsf@gitster.g>
From:   Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Subject: Re: When are you going to stop ignoring pull.mode?
Message-ID: <948ef19f-5588-62e9-6fc7-aa6d82f21a1b@aixigo.com>
Date:   Mon, 19 Jul 2021 16:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqwnpooctj.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/17/21 11:22 PM, Junio C Hamano wrote:
> Matthias Baumgarten <matthias.baumgarten@aixigo.com> writes:
> 
>>>>      pull.ff  pull.rebase  commandline            action
>>>> ...
>>>>        *          *        --ff-only              fast-forward only[1]
>>>> ...
>> What about
>>
>>           *       !false      --ff-only              ???
> 
> This is covered by an earlier entry ("*" stands for "any value"), I
> think; it should fast-forward or fail.  The reasoning goes like
> this:
Ah, I just misunderstood *, nevermind!
> 
> The user configures pull.rebase to some kind of rebase; it could be
> just true (the traditional flattening rebase), or the one that
> preserves the shape of the history, or even the interactive one.
> With the configuration, what the user declares is:
> 
>      I may have my own development on top of the result of my last
>      integration with the upstream I did when I ran "git pull" the
>      last time, and when the upstream has more commits, the way I
>      want my local work to integrate with their work is to replay my
>      work on top of theirs (as opposed to "merging their work into my
>      history").
> 
> But by passing "--ff-only" from the command line, the user tells us
> this:
> 
>      This time only, I want fast-forward update and nothing else.  I
>      do not remember doing any of my own development on top of their
>      history, and I expect that this update from the upstream would
>      fast-forward.  If that is not the case, please error out, as I
>      need to inspect the situation further and I do not want to see
>      conflicts in unexpected commits I thought I did not have.
> 
> So the "action" would be
> 
>   - If their history is a descendant of ours, that means that on top
>     of their history previously observed by us, we haven't added any
>     development of our own.  We just move to the tip of their history
>     and we are done.
> 
>     This is not so surprising anyway.  If we are doing any kind of
>     rebasing, what happens is to start from the tip of their history
>     and then commits from our own development are replayed on top of
>     that.  When their history is a descendant of ours, we end up
>     doing just fast-forward, as there is nothing to replay on top.
> 
>   - Otherwise, because the user expects the command to fail if their
>     history is not a descendant of ours, we fail.
> 
> And "fast-forward only" in Elijah's table is a concise way to say
> that.

Agree.
> 
> I concentrated on "if the configuration is set to do some kind of
> rebase" case, as that was your question, but the above reasoning
> applies equally to the case where pull.rebase is not specified or
> set to false, i.e. the user tells us to merge.
> 

Perfectly valid reasoning.

Initially I came from the situation where I (as maintainer of a 
repository) proposed to do a `git pull --ff-only <remote-git-url> 
<branch-name>` for the others to integrate the newest changes safely 
(i.e. failing if they had errouneously worked on that branch, which it 
is not intended for). I thought I could reach that safety with the 
`--ff-only` part, but it seems one of the devs had pull.rebase set for 
him locally and thus managed to bypass my "safety". Mr. Elijah Newren 
called this a bug, see [1].

Another way for the others to integrate my changes would be to propose a 
`git reset --hard ...` but that seems very... hard. It would overwrite 
all local changes (only recoverable by the reflog then, and you would 
even need to know that you had local changes in the first place).

[1] 
https://lore.kernel.org/git/CABPp-BEHZcfZNL+PG1vmqXGf4Qs3eoULb4NDDgbmOB30HzJu_Q@mail.gmail.com/

-- 
aixigo AG
Karl-Friedrich-Str. 68, 52072 Aachen, Germany
phone: +49 (0)241 559709-390, fax: +49 (0)241 559709-99
email: matthias.baumgarten@aixigo.com
web: https://www.aixigo.com
District Court Aachen – HRB 8057
Board: Christian Friedrich, Tobias Haustein
Chairman of the Supervisory Board: Dr. Roland Schlager
