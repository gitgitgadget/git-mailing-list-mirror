Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A931C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhK3LLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbhK3LLC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:11:02 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40F0C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:07:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a9so43530423wrr.8
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8bCiguQ/JNHugEnWADZ/F49En1dRuM2CqNLBvkcTVs4=;
        b=kFvMuPczqh4yJ/HWBC9OL+p2KHuRLMu5L8IshNfaHLgx9Q1VAyAAmiKkFdTwjhbNSf
         dX1kvBdRjj5KUITM/LGZvyzJ2zWpwQWaUzAxHDeZe84CkC2oYqSwIW4NekedpbQ7Z+fQ
         MEBcId8SyCZz+dKbtfI0WlqiY2vF3NpxQOEEV+9A5x6WgUjTVvQTObRCnmPHX4zvpxLS
         Ah7cY9e6Q2FScucbnR+XylyyVnP9OJwkyjfk1ET88wyRnHPQ81J3kkGM3Nup676pIHq8
         wMbOkUWqGsJHCGzlOgdHWjycLgGaQnmdAxr+2aKNsQTYlLu6GNj08XKnGojZL8lh29us
         I5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8bCiguQ/JNHugEnWADZ/F49En1dRuM2CqNLBvkcTVs4=;
        b=GvIYXQqQwA481tpCpjQF1mIDttdGbnEcThSaMKibSijTLcuygg29S6Pf/t0C9zMGYM
         Vd0GdIoqC0QxzMoOHQOtsMqVE6snhRg0EiFKtSA84PxKvNz930IZ65qv2B5tyhsOtode
         ITFjv5j81ncoqOigSacgtY2nzinR2PvT7XQ5OVwxcQgfWP8nkGCDpfKRDu0i7o4iMr/v
         VqZUyvj7HGqAQ1m+qo034q697akoJlWWJI87WAfI5g1gN4nHbSY23qmEncB2e3WK17Kb
         9Gx/gxhUaeG613GH2NLLCJC+8TsAC3PK7Tcrj+2X2n4cJIz4dZUVTWcymBJNRHEFEWA2
         bA9g==
X-Gm-Message-State: AOAM532ACshKMnAB6fjorrVOMO8Xh4UvEuKWkmqmiJtlBuFl4Bh7pmIV
        IW/0Q+Gql+995aVHePgXqrZ2CitUqhcmvw==
X-Google-Smtp-Source: ABdhPJwucER19w002HbN4hlMSHLAheoDLrqPIWZDvNssnqRvl5jBWa1uz2GcIdBuyl9SCyNpy2UZjQ==
X-Received: by 2002:a5d:4143:: with SMTP id c3mr39949435wrq.254.1638270462361;
        Tue, 30 Nov 2021 03:07:42 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id l11sm15632253wrp.61.2021.11.30.03.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 03:07:41 -0800 (PST)
Message-ID: <7138fa14-02b2-b123-4d8d-df73763f8431@gmail.com>
Date:   Tue, 30 Nov 2021 11:07:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a
 tty
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, thomas.wolf@paranor.ch,
        Alexander Veit <alexander.veit@gmx.net>,
        Junio C Hamano <gitster@pobox.com>
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
 <20211122222850.674-1-carenas@gmail.com>
 <b1f2257a-044c-17bb-2737-42b8026421eb@gmail.com>
 <CAPUEsphP2GRaHJa0Qnvf22WUnNB+GnnfG8TgHqwJvSGdYfUQGA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPUEsphP2GRaHJa0Qnvf22WUnNB+GnnfG8TgHqwJvSGdYfUQGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/11/2021 17:31, Carlo Arenas wrote:
> On Tue, Nov 23, 2021 at 3:05 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> I think a combination of isatty() and tcgetpgrp() is probably the best solution.
> 
> Definitely agree the long term fix needs to include tcgetpgrp() as
> shown by this initial draft[1] (which I apologize, just noticed is
> missing your "Helped-by")
> 
> That of course introduces a regression on the other direction though;
> before this change, git compiled to use our getpass() replacement
> (HAVE_DEV_TTY=1) function, the following will be normally stopped by a
> SIGTTOU just like getpass() if running in the background (need to also
> not have GIT_ASKPASS or SSH_ASKPASS defined in the environment)  :
> 
>    $ echo "https://user@example.com/" | git credential fill
> 
> I suspect that is probably fine though, as when that happens our
> getpass() function still misbehaves if put back in the foreground
> (unlike getpass())

Yes, I tried it out and I couldn't get it to work or figure out why. So 
long as we don't start echoing the password to the screen we should be 
fine. It would be nice to know what the problem is that stops it working 
properly but that is not really related to this patch.

> and this "feature" might be undesired anyway as the
> equivalent C code also runs sometimes in daemon-like processes, and
> could even explain some of the workarounds put in place to disable
> password prompts (ex: GIT_TERMINAL_PROMPT=0), but luckily we have all
> the 2.35 dev cycle to figure out.
> 
> Restricting this feature further, maybe through a configuration
> property or even special casing the EDITOR is also IMHO a good idea.

I think just doing this when we run the editor may be the way to go as I 
think it is only that case that can mess up the terminal.

Best Wishes

Phillip

> Carlo
> 
> [1] https://github.com/carenas/git/commit/64d15b2a74206f31e04cf0200f7be83a54a00517
> 

