Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F418BC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF9621D47
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFIEdeXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465692AbgJWPSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 11:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461910AbgJWPSL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 11:18:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5EAC0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 08:18:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g12so2301458wrp.10
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rGvgI9Luf2EiGiBsEC0gEYiLdfZxTNPw89WPa2StEEY=;
        b=ZFIEdeXzEsIHDtzfigoQ92IWivwEFYDv6JdAyIAMatrIMbBf7O3Psgvpi4EvA+MKOS
         AOrYvImoW/+WfU7YRvhEfWGYycKG3mxv/O0IY08qqD0gZG3F3PJNQQ6TUW3piYjCBXAD
         WegQUuyvCb2XqWE/A+tfGeCIrp7MPeAv8lYxUYfOqq8F24RvtLjyGFreSDUSxVKBvHeE
         atDWBHck65TijP0m6KxcIx2+rZJQ8+WHtSla1UZNCHFlz/Mp7AWt6j5z8CKMy4MG0ycF
         YIDWyjwE4y0pCuxCG4KVDuoiocTVzYf60y6Bg3g6FuSlXCDTuGXTbBR/nhwrBJ3Q7tVW
         MtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rGvgI9Luf2EiGiBsEC0gEYiLdfZxTNPw89WPa2StEEY=;
        b=GsQPCMfB0CB3qJ0gLREMpqVQ1vfN5OLnRl1LFnuBRglbgWQuDRbkDU7Npca0D2n8Js
         g7e2aOIfYybyEm19uTe5ssrixZwO9xb9hwEFOeNND2Xk52dgha9eXbJyKSFoLaBjCr2X
         hLmdEX4KZr409ezAaEhX1z/yZDu8fz1ogdQCXpYSDx5f8n20JRfw+jHDLrSnq9tkfc24
         Q+7FB0bxf8M61KedK2MeWtHNs3E2r2COfJM85cR9HAKOoh0ja4JEp38VimQT0UqIniqH
         WaWA0EqF/yVoeLn0dcmmvFJFZQ3/fKnGANHd3orW44chWuYpxtIMGphcDY1KrfR7wAzr
         5OsA==
X-Gm-Message-State: AOAM530EW7AUs2jGjf7P9JhgJ7llLFY2mulUx4JVvBy1GyakFHGr5zkK
        I20cqFD1luV2igj5wCHNCBGojMDYJdo=
X-Google-Smtp-Source: ABdhPJzWV5ChZ0k/ApCtAyQwwcmjS2w5RJU7jgAy3aGDUq7g35DQapx5DYF9GbPR7gP/ScuYqj9D9w==
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr3050649wrx.133.1603466289732;
        Fri, 23 Oct 2020 08:18:09 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id w11sm3784651wrs.26.2020.10.23.08.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 08:18:09 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH][OUTREACHY] bisect: allow `git bisect` to run from
 subdirectory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk,
        Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sangeeta <sangunb09@gmail.com>
References: <pull.765.git.1603271344522.gitgitgadget@gmail.com>
 <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com>
 <20201021162044.GB111581@nand.local>
 <xmqqr1pr73ve.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2010221047550.56@tvgsbejvaqbjf.bet>
 <cfe33eef-974d-8ff9-ebb4-d1153abd497c@gmail.com>
 <xmqq7drinqxv.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <10d10f36-0bb6-614f-2602-c122bab42b7c@gmail.com>
Date:   Fri, 23 Oct 2020 16:18:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq7drinqxv.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 22/10/2020 17:52, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I think both bisect and rebase should be documented as running
>> commands from the repository root as this is what rebase does and it
>> gets around the missing directory problem.
>>
>> I'm not sure rebase is doing the right thing with a relative path
>> though. My feeling is it would be less suprising to resolve relative
>> paths to the directory where the bisect/rebase is started and store
>> the absolute path. The script may disappear while rebasing but that
>> can happen now if the user points us to a script in a directory that
>> disappears while we're rebasing
> 
> If a step in the rebase sequence makes a directory disappear (or
> turns a directory into a file), and the command given by -x is in
> the directory (it is immaterial if it is given as relative or full
> pathname from the command line), hopefully the step of the rebase
> sequence that would lose the directory would error out, in order to
> prevent an untracked but not ignored file from getting clobbered.
> 
> Even before speculating such an "advanced" mode of operation, do we
> know that rebasing a history that makes a directory disappear and
> reappear work?
> 
> For example, if there is a history like this:
> 
>      - commit #0: an empty tree
>      - commit #1: adds a file D/F
>      - commit #2: moves the file D/F to F (i.e. the toplevel)
>      - commit #3: moves the file F to D (i.e. D becomes a file)
>      - commit #4: moves the file D to E
>      - commit #5: moves the file E to D/E (i.e. D becomes a directory again)
> 
> does it do what expect it to do if we replay the history c0..c5 on
> top of a comit that records an empty tree if we start the rebase
> in an empty directory D?
> 
> Here is what I tried in an empty directory, and the last "ls -la"
> shows an empty directory, even if you try "ls -la D" from a separate
> shell after everything is done, you'd see a file D/E there.  If a
> platform exists that does not allow removing a directory that is the
> $cwd of any process, I would not be surprised if the whole thing
> failed in a mysterious (to the end user) way.

Thanks for the demonstration. There are several other commands 
(checkout, merge, cherry-pick, reset --hard, revert and maybe apply and 
am?) that can remove the current working directory of the shell that 
they are run from when they are invoked from a subdirectory. Rebase and 
cherry-pick/revert differ from checkout and merge in that they can 
potentially delete and then recreate the directory they are invoked from 
which adds another layer of confusion but having a checkout remove the 
directory it is invoked from isn't great.

One way to avoid it would be to stop all of these commands from being 
run from a subdirectory and also object if they are run as anything like 
`git -C .. <cmd>` but that would be very restrictive.

Thinking out loud maybe another possibility would be to error out if the 
command would remove the directory git was invoked from. I've not looked 
into it but wonder if these cases could be covered by a checks in 
unpack_trees() and apply.c but I don't know how realistic that is. (I've 
a feeling Elijah mentioned his ort plans don't use unpack_trees() which 
would complicate things)

All in all I'm not sure rebase is that much worse than checkout or merge 
when it comes to removing the directory it is invoked from. If this is 
something we care about a general solution might be better than just 
stopping rebase and bisect from being run from a subdirectory.

Best Wishes

Phillip

> #!/bin/sh
> test -d .git && exit ;# safety
> rm -fr D E F
> git init
> 
> git commit --allow-empty -m 'an empty tree'
> git tag commit0
> 
> mkdir D && >D/F && git add D/F
> git commit -m 'add a file D/F'
> 
> git mv D/F F && git commit -m 'move D/F to F'
> rm -rf D
> 
> git mv F D && git commit -m 'move F to D'
> 
> git mv D E && git commit -m 'move D to E'
> 
> mkdir D && git mv E D/E && git commit -m 'move E to D/E'
> 
> git tag commit5
> 
> echo history made
> 
> git checkout --orphan rebuilt
> git rm -r -f .
> git commit --allow-empty -m 'another empty tree'
> 
> mkdir D
> cd D
> 
> git rebase --onto HEAD commit0 commit5^0
> ls -la
> 
