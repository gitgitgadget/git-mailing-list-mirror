Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE53C05027
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 17:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjBTRGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 12:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjBTRGS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 12:06:18 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09277206BE
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 09:06:12 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1720ea61e29so1855790fac.12
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 09:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yeiytoRwhbsy9UN+B/YXoTz9weTndscXEEI+XC5nfjY=;
        b=jVbIOeiIqqiTL+9Qo+ySVzj7I+37vQ12pKlRrdx1qNoW26buH57I+2G11eieaP57Zg
         wITwOn7iTOtTaatQpnq31NaKcg7M+41uccbMbPTnXGFCmlIwnMjUAFBeNgImiVpXliEJ
         Hdt3VGbljTq3Hp/2ZB9I77Pu+xSq+TBWfJR5Vfe/fMRIOtcZluLbjn4PRrTZ3xr3Bdev
         Z+SZDGhnHNrosRWRzqg2ZOnvX+rz7Dhxae5NzHiHwHdId7kB0hTa2c3YlzL7cQGckjxb
         Dmg76uwz/otpjAwsUACVzb7Jz1CrCb4hBTJ0c+xhxmSIsEd2t9jxyMo0In4lYHp4M/1Q
         00hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeiytoRwhbsy9UN+B/YXoTz9weTndscXEEI+XC5nfjY=;
        b=5rFTbK8vSFzxnjBkrFoJ5ZpgRpgvnab8nUxkQTBZ18QJtHYP5LDvCkiIZ8dqi4eJEZ
         REhIE7m1xPRiAKq6rbueijm6fSp4w3QaB0PFDGaYLn3Pjqtq7Xee16l4UgY4yv88+h79
         AnZdJEP1MsQihCZPappIwJFxk5rriRhtBMr0x25xi8MzR09FvYDHOkXJ2eGLulUoaMK+
         d0gWmrbfYUH0B3pkumjlUTUWqfgRhA5TB6+IDnzRQzgVbeOsauIdg4puxO3ZuPwox2q4
         rJkqUYG2SIBqE68cFSdHw78ZtaEszXyyKxSPblX+rB5iUv9q2tHXC03TLsG6J/dIBI77
         qccA==
X-Gm-Message-State: AO0yUKVavVnll34MzTCT7Q0ajaWe5XZuIRJEYHzDwhOQ2nbeWNShEQy2
        cTTw3Fw4ZiCDUMTGTKNtUav/SljsrK0jh4MoJDU=
X-Google-Smtp-Source: AK7set/1TiuZSWosvxJbaZ3emvqCt3zAz9WY8irb1XO/4rZkjJTBHn+e+FpTPfWCUeuGMdCKt78iaUMsnMYOlNGEI44=
X-Received: by 2002:a05:6870:1d06:b0:16e:902e:39df with SMTP id
 pa6-20020a0568701d0600b0016e902e39dfmr758921oab.154.1676912771348; Mon, 20
 Feb 2023 09:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20230220033224.10400-1-alexhenrie24@gmail.com>
 <20230220033224.10400-2-alexhenrie24@gmail.com> <fe9a3c86-0169-588f-2b12-e124d9d138d9@dunelm.org.uk>
In-Reply-To: <fe9a3c86-0169-588f-2b12-e124d9d138d9@dunelm.org.uk>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 20 Feb 2023 10:06:00 -0700
Message-ID: <CAMMLpeQ8_Wz7sEE9M1t6oLF_BA7T_BT9TNfkKwgGOvf9fiio2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] rebase: add a config option for --rebase-merges
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2023 at 2:38 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 20/02/2023 03:32, Alex Henrie wrote:
>
> I think the commit message could benefit from some justification for why
> this config option is useful. I don't object to it being added but you
> need to make the case for why it is a good idea.

The purpose of the new option is to accommodate users who would like
--rebase-merges to be on by default and to facilitate possibly turning
on --rebase-merges by default without configuration in a future
version of Git. I'll add a note about that to the config message.

> > At the same time, stop accepting --rebase-merges="" as a synonym of
> > --rebase-merges=no-rebase-cousins.
>
> Please try to avoid combining unrelated changes in the same patch. I
> agree that accepting an empty argument to mean "no-rebase-cousins" is
> slightly odd but as that is the default I'm not sure it is doing any harm.

I wrote the code so that `git config rebase.merges ""` has the same
effect on `git rebase` as `git config --unset rebase.merges`, because
I think that's what most people are going to expect. I'd like to get
rid of the odd syntax --rebase-merges="" because a user might
reasonably expect it to do the same thing as `git config rebase.merges
""`, but it doesn't. On top of that, the config option uses the same
helper function as the command-line option. So I consider removing
--rebase-merges="" to be intertwined with adding the config option,
but I'll split them into separate patches anyway.

Thanks for the feedback,

-Alex
