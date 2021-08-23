Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63CDC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 01:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54B061262
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 01:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhHWBId (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 21:08:33 -0400
Received: from w1.tutanota.de ([81.3.6.162]:51298 "EHLO w1.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231807AbhHWBIc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 21:08:32 -0400
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w1.tutanota.de (Postfix) with ESMTP id 0504EFBF5CB;
        Mon, 23 Aug 2021 01:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1629680869;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=X2JMCyR6yAP6ppZDsebjgz2KIcTkQkd+6Oe0EDbO5a0=;
        b=Rzcicd1P0Ja4+FyQPuLBM1t1J4TbVrQdolD7qa7C61hW1IusHMtf3miuHadgAnUD
        NR6KUKiTakAergmZFDocMtIzfaCla5uyYvf+MKlCdkGQKwW//v0oO1zEHubpjaSO8yJ
        8C6aVBtaO8S/XTQH3wJyffbH6KZ7RkZ9N+P2tm1Jjvi3BL8aaD/kRb7VWMRFt6XkzRM
        Ju+BPQyGQC5mwFe7/Fbk+noH+qVqlrwhQTBxCjxecxPEOpwn0U1rW5cRoh4fL4Ft/KN
        Xa5NX04znTbOeuiA/ESocZkBUNxsQ1L790JX9CE951ana9zXWTyi8QC67fVlX8slBFP
        QBTTScFaeA==
Date:   Mon, 23 Aug 2021 03:07:49 +0200 (CEST)
From:   Rafael Santiago <voidbrainvoid@tutanota.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Rafael Santiago via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Message-ID: <MhkY8ud--3-2@tutanota.com>
In-Reply-To: <YSLKrX/QTZtxBGDz@camp.crustytoothpaste.net>
References: <pull.1069.git.git.1629576007891.gitgitgadget@gmail.com> <YSF1GfpHXRrXebsB@camp.crustytoothpaste.net> <Mheyv1D--3-2@tutanota.com> <YSLKrX/QTZtxBGDz@camp.crustytoothpaste.net>
Subject: Re: [PATCH] Give support for hooks based on platform
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Well, you are taking into consideration that every git user that needs to
automate some stuff during a scm event will do it from a shell
(I meant true shell or a mocked up one such as cygwin, msys, etc)
and it is true, by design.

However, not all git users (out unix) uses git from "bash-like"
environments. I know people that prefers using it from a well-cooked
IDE by clicking and dragging things or even from command prompt when
on Windows. Those people are not able to handle some scm event
automation as unix users because git hook in its essence presupposes
the existence/necessity of a powerful shell (okay, it is possible to
put a shebang and call a batch file on windows, maybe, but it is a
little clumsy, in my opinion). On Windows, users can do a bunch of stuff
just by using the ready to go powershell, but open an if/else on a bash
script to run a cygwin instance by calling powershell from there is not a
good and clean solution for this type of user. Presupposing shell for git,
limitates the idea behind the scm event handling with hooks, because
currently it is strongly dependent from shell to work on every git
supported platform.

The idea of having hooks being executed by platform would be the first
step to give support to execute commands on scm events without
obligating users out of a unix have a shell interpreter to access
native stuff. Currently, this commit does not implement it but would be
possible to do and in a=C2=A0 less noisy way for all unix-like stuff. I am =
not sure
but currently a _windows hook out from cygwin would result on a spawn
error, would not?

Git hooks are useful features but would be more useful if it breaked up
the shell jail. It could make git much more integrated with the current
platform.=C2=A0 Being possible to make it powerful as it is on a unix even =
on
a total different platform as Windows, let's say.

For sure, this commit are not a "panacea" but intends to start making
git-hooks more independent from 3rd party software to work on as expected,
on every platform that a git-repo is expected to be handled.

I hope I was clearer from this time.

Rafael Santiago
--
22 de ago. de 2021 19:07 por sandals@crustytoothpaste.net:

> On 2021-08-21 at 23:11:27, Rafael Santiago wrote:
>
>> In my opinion "binary hooks" (hooks that execute specific binaries not
>> present in the system as a default tool) should be versioned and built
>> as a support tool into the repository or in the worst case downloaded
>> from somewhere, even because versioning binaries into git repos is
>> considered a bad practice that could make bloated repos.
>>
>
> Yes, I agree binary hooks should not be checked into the repository.
>
>> The point is that in many cases a dependency with a script language is
>> created only to make the hook actions portable from a platform to
>> other, but what this script in its essence does is a thing that could
>> be done with basic tools delivered with the current operating system.
>>
>
> Then, in general, it can be done in a shell script containing an if-then
> statement per platform using the native tools, so I'm not seeing the
> particular reason that this series is necessary if the hooks being
> executed aren't binaries.  All systems on which Git runs must contain a
> POSIX-compatible shell.
>
> Can you explain the rationale for your proposal in more detail so that
> we can understand why this change is necessary?  Typically this is done
> in the commit message, but I don't think I understand why you want to do
> this.
>
>> There is no problem on using cygwin on windows, you should use
>> standard hook and do all the effort to make it unique for cygwin
>> environments and true unix boxes (in other words: you would continue
>> doing what you are doing, because it attends yours requirements).
>> Notice that everything that have been working will stay working as
>> before. Anyway, if cygwin becomes a point of incompatibility at some
>> point, you could use the "_windows" version by coding your "cygwin
>> script" there.
>>
>
> Right, my point is that your commit message proposes using "windows" for
> Cygwin.  The patch doesn't, but your commit message says that every
> version of Windows is considered "windows".
> --=20
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
>

