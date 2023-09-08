Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9E5EE57ED
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 10:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbjIHKBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 06:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIHKBL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 06:01:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C691FF7
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 03:00:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-402c1407139so21027435e9.1
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 03:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694167148; x=1694771948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5qXZFc0N7U9xJ+e4RGSowHSm7dhj7QMCyvhDPpYtOaA=;
        b=G2woYefpjwNzPj+3HeP33D1G9s85V7LVZ0mKUGwY2tLexTsrdoM1EnLsCfHLgLzzB5
         wFOhYVOLgm2+0TWU58VvfnqJSSzwqYGGF0G3u+Owjw3gjgeBUJKVI/GXUmOjvBP+Nt1x
         PuYfynuJQhNl3QNgY8dLtMfJxQnnJNVwYW5xBdK1fyD5Y7yVFf3JaYQbE6sfUouheRcY
         bL1Iay6wzqu7+J/vK37hfY8RhNoLcUU8zvAiGlIsX7dfi27fAj3n+dwKhEpPPbRvS4FK
         i8LJwwpND3Bxz95y71XEZ6brGIQ8l5Zn04EgGlFs8Ay0xoX2wLq++QmRnPwChWWPUoRo
         M2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694167148; x=1694771948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qXZFc0N7U9xJ+e4RGSowHSm7dhj7QMCyvhDPpYtOaA=;
        b=sIuHNSkWnHQqXvrLdfqr+g1NzAOOD5Hxj3nqWJ/hH/nMXUtxdtg95TfyIIetxZ6Qtq
         g3/DXmhE47S/OHxvT5kb+o6U9SvLwjkoC161mk2cpaxoSyg+NKbj7T2vTTC1tLgeOlcq
         Z/ngUgCEQ5PXvkvxgDD+TyhBizEpAskop2h3EgKf5iKef4R8bbjrWeK3D9PxsJAVxR9k
         7D4Yao/TaYkUUZdEkmluJz3b8dre3UUotiMGiyIhWZIqvswfSwPw715+4lrBTayiA12z
         O8OIC0IVj8SJVzrH2FMmQtkgAksLr0dQBClSE6zFJr/KWWmt5vNCp2EByrWm0RO2e11X
         x6sQ==
X-Gm-Message-State: AOJu0Yxdgk+cdt/55llSJPvRbKUX80rKRP8aEnCsn/mo3NWGy1h57JUJ
        9SpkiSoic8hATHLs5letOWc=
X-Google-Smtp-Source: AGHT+IFXpd86bsOsRK5KImXX/eqHD0nTYcr9NnnCgHYXzV0XlTmatoXZV30mDeWFePp4XbtmZynfxw==
X-Received: by 2002:a1c:7508:0:b0:3fe:d1e9:e6b8 with SMTP id o8-20020a1c7508000000b003fed1e9e6b8mr1746875wmc.12.1694167147675;
        Fri, 08 Sep 2023 02:59:07 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id n3-20020a5d4203000000b0031c3ee933b5sm1632554wrq.108.2023.09.08.02.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 02:59:07 -0700 (PDT)
Message-ID: <9ba22d4b-3cbe-4d4a-8dba-bc3781e82222@gmail.com>
Date:   Fri, 8 Sep 2023 10:59:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>
 <20230907210638.GB941945@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230907210638.GB941945@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

Thanks for your thoughts, I hoped I get a interesting response if I cc'd 
you and I wasn't disappointed!

On 07/09/2023 22:06, Jeff King wrote:
> On Thu, Sep 07, 2023 at 10:03:02AM +0000, Phillip Wood via GitGitGadget wrote:
> 
>>      rebase -i: ignore signals when forking subprocesses
>>      
>>      Having written this I started thinking about what happens when we fork
>>      hooks, merge strategies and merge drivers. I now wonder if it would be
>>      better to change run_command() instead - are there any cases where we
>>      actually want git to be killed when the user interrupts a child process?
> 
> I think that would be quite surprising in most cases, as the user may
> not be aware when or if a sub-program is in use.
> 
> Imagine that you're running a script which runs git-commit in a loop,
> which in turn runs "gc --auto", which in turn runs a pre-auto-gc hook.
> You want to stop it, so you hit ^C, which sends SIGINT to all of the
> processes.
> 
> I think most people would expect the whole process chain to stop
> immediately. But in your proposal, we'd kill the hook only. That kind-of
> propagates up to "gc --auto" (which says "OK, the hook says don't run").
> And then that doesn't really propagate to git-commit, which ignores the
> exit code of gc and continues on, running the post-commit hook and so
> on. And then outer loop of the script continues, invoking the next
> commit, and so on. To actually quit you have to hit ^C several times
> with the right timing (the exact number of which is unknown to you, as
> it depends on the depth of the process chain).

Ah, I hadn't thought about "gc --auto" I was assuming that the calling 
code would see the child had been killed and exit but that's not always 
the case.

> I think this really comes down to: does the user perceive the child
> process as the current "main" process running in the foreground? For
> most run-command invocations, I would say no. For something like running
> an editor, the answer is more clearly yes.
> 
> For something like sequencer "exec" commands, I think it really depends
> on what the command is doing. If it is "git commit --amend", then that
> is going to open an editor and take over the terminal. If it is "make",
> then probably not. But it may be OK to do here, just because we know
> that a signal exit from the child will be immediately read and
> propagated by the sequencer machinery (assuming the child dies; if it
> blocks SIGINT, too, then now you cannot interrupt it at all!).

The child not dying is tricky, if it is in the same process group as git 
then even if git dies the I think the shell will wait for the child to 
exit before showing the prompt again so it is not clear to me that the 
user is disadvantaged by git ignoring SIGINT in that case. Part of the 
motivation for this patch is that I'd like to move the sequencer to a 
model where it only saves its state to disk when it is stopping for the 
user to fix conflicts. To do that safely it cannot die if the user 
interprets a child with SIGINT.

> In the classic Unix world, I think the solution here is setsid(),
> process groups, and controlling terminals. One example in your commit
> message is the sequencer kicking off git-commit, which kicks off an
> editor. The user hits ^C then, and the sequencer is killed. But I think
> your patch is papering over the deeper bug. In 913ef36093
> (launch_editor: ignore terminal signals while editor has control,
> 2012-11-30), we did this same "ignore INT" trick.

Yes, that was the inspiration for this patch

> But I think the right
> solution is actually to start the editor in its own process group, and
> let it be the foreground of the terminal. And then a ^C while the editor
> is running would not only not hit git-commit, but it would not hit any
> sequencer or other intermediate processes above it.
> 
> I've never done it before, but from my reading we basically want to do
> (in the forked process before we exec):
> 
>    setsid();
>    open("/dev/tty");

Do we want a whole new session? As I understand it to launch a 
foreground job shells put the child in its own process group and then 
call tcsetpgrp() to change the foreground process group of the 
controlling terminal to that of the child. I agree that would be a 
better way of doing things on unix.

> But of course none of that probably has any meaning on Windows. I'm not
> sure if there are analogous concepts there we could access with
> alternate code, or if it would need to be a totally different strategy.

Lets see if Johannes has any comments about that.

Best Wishes

Phillip

