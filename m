Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EA4C4320E
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 07:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 295B961050
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 07:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhHAHGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 03:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhHAHGy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 03:06:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF7AC0613D3
        for <git@vger.kernel.org>; Sun,  1 Aug 2021 00:06:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i10so16106496pla.3
        for <git@vger.kernel.org>; Sun, 01 Aug 2021 00:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version:content-transfer-encoding;
        bh=sO4RPGU6iRhB7SAH9tm+1R4IsIGVw8x/ORDPZ6NG+cc=;
        b=SC6/uJqhys27DBzy7Fs+f5ScaTlSi2JdpGuzFNQSPJY5JO+uqZRth/SoiJ97uMGUPi
         NfZ+9nNFWHCwT1x5wElzWMsDGPaZ0Ldf6Hs0zE8oTtEyyFujkKZJkKXC80FjE61uT86g
         uVcf1zGAXFuZn9tUcrFpZSF6g3e4NZ9rygOjJ0wA/Z//E0ReAatyv9HymCUrUxv1NPxy
         BsmHPswca+oIYVp5OFUhFdDe0vnIlpUJ3dnO4eiEi5Fh4fDh2yLAbbf0Gt6pn1RMp6U8
         5778ESEYG3o743T35srr1uze9hSWyV0y7ntrN8kdkv5SCKixiY6OvjyI/+dQAyCnr27D
         WZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
        bh=sO4RPGU6iRhB7SAH9tm+1R4IsIGVw8x/ORDPZ6NG+cc=;
        b=nyvid+OnJxL0PSuoU7PiUB1muYXc8gGbORWZ/PfCtP2trGTNMk1DFIJ7vCWyT9xbfc
         JQ0oizzMfvwMkfizLDCTejc9z+KE/wnMr72sld3ekNBIT/2OvvJcQ/zuOlI20viiJuf0
         jl5A8tDDFGk+metc5uyg5S3FK7nrdqm2gN5aAIZ5FtREsM3fXr3XlDNyI6NVb83Cjc/B
         JChDp26Sk+2uRWpRqhse8Wx5MrPhatzLjwL8zXk9P5+lEttbcgDBr5o1gbR+awyTH4Kc
         5J/uSum3bAbPl0AIoiAWC5LxSUWWlBB4FokIvX3V1P6UERy32NovcfenKWjvd7p08AGz
         9pJA==
X-Gm-Message-State: AOAM531TkAHMeybRfx15pPX5kBIMJqG0oBPlzVoQ0h3Fu5Ll2Ezlc0rZ
        8zpyMvKqHKh8uTPuKpfYVKE=
X-Google-Smtp-Source: ABdhPJy9OVjCN9lz5JUY3p+JPWTbtSOGPhTTLCYaKgQEoCwoIO+t4YAa8Mc/jwYgsDh68Z1Ptc+Dng==
X-Received: by 2002:a17:903:2346:b029:12c:841a:f44c with SMTP id c6-20020a1709032346b029012c841af44cmr9525918plh.74.1627801605871;
        Sun, 01 Aug 2021 00:06:45 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id 65sm7686001pgi.12.2021.08.01.00.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 00:06:45 -0700 (PDT)
References: <90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail.com>
 <ee679a57-0851-962d-a63a-6a0bdba35b2e@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        avarab@gmail.com, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [GSoC] A small survey + My Git Blog, week 10
In-reply-to: <ee679a57-0851-962d-a63a-6a0bdba35b2e@gmail.com>
Message-ID: <m2pmuxy77j.fsf@gmail.com>
Date:   Sun, 01 Aug 2021 12:36:40 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Atharva,
>
> Le 2021-07-25 =C3=A0 08:22, Atharva Raykar a =C3=A9crit :
>> Hello all,
>> Week 10 of my Git blog can be found here:
>> https://atharvaraykar.me/gitnotes/week10
>> As for the "survey part", jump to the section here:
>> https://atharvaraykar.me/gitnotes/week10#the-mailing-list-developer-work=
flow
>> ...feel free to reply in this thread.
>>
>
> Quoting your "survey" questions:
>
>> What tools, systems and workflows do you find valuable in your
>> day-to-day work? In particular I=E2=80=99d be happy getting insights=20
>> like:
>> * Any strategy or approach to work, kind of like the example I=20
>> quoted
>>   above
>> * Any scripts and tools that assist you
>> * Opinionated handling of multiple in-flight series and methods=20
>> to
>>   approaching reviews
>> * Atharva, you are overthinking this! I just use a=20
>> straightforward {
>>   editor + MUA + git } stack and go with the flow!
>
> I'm a small-time contributor, but I do read the mailing list=20
> regularly.
>
> As such, I'm not subscribed to the list; I read it on=20
> lore.kernel.org
> or public-inbox.org (nicer colors!). The UI of public-inbox is=20
> very clear
> with respect to threading, and the front page also lists=20
> messages in
> a way that it is easy to quickly see what's new.
>
> When I want to reply to a message that I read on the list, I=20
> import it
> into a "Git mailing list" IMAP folder in my Gmail account so=20
> that I can answer
> using my mail client (Thunderbird for now since Apple Mail has=20
> been reliably
> crashing at launch for the last months) and quote relevant parts=20
> of the message.
>
> To import a thread from the mailing list I use a combination of=20
> the excellent
> 'b4' tool, developed by the kernel community [1], and 'git=20
> imap-send'. It's
> basically this:
>
> $ git config --get alias.ml-imap
> !f() { b4 mbox -o- $1 | git imap-send; }; f
>
> This sometimes does not work if some messages in the thread were=20
> not created
> using  'git format-patch', since 'git imap-send' expects the=20
> "From", "Date"
> and "Subject" headers in a certain order. So I created a small=20
> Python script,
> 'git in', for this case [2].
>
> For small and simple reviews, I also simply import the patches=20
> into Thunderbird
> and reply inline. If I want to do a more in-depth review and=20
> browse the code as
> modified by a series, I fetch the contributor's branch and take=20
> a look locally.
> More often than not though people do not provide a 'git=20
> fetch'-ready link in their
> cover letter. So in that case I use 'b4 am' [1] to fetch the=20
> latest version of a series
> and apply it locally. Before 'b4' was created I used 'git pw'=20
> [3], a command line
> client for Patchwork, and the Git patchwork instance at [4], but=20
> these days I prefer
> 'b4' as it's more closely integrated with public-inbox.
>
> For my own contribution I use Gitgitgdaget [5], it handles=20
> almost everything needed
> for git.git contributions:  keeping track of the CC list for
> me, updating the re-roll count,  adding the In-Reply-To header=20
> such that subsequent
> versions of the series are sent as a response to the cover=20
> letter of the previous version,
> generating a range-diff against the previous version, providing=20
> a 'git fetch'-ready tag,
> commenting on the PR when the series is mentioned in Junio's=20
> "What's cooking", etc.
>
> Some things it does not support are: sending a patch as a=20
> response to some random
> mail on the list, which is sometimes useful, reading the commit=20
> notes to generate
> in-patch commentaries [6], customizing the diff generated by=20
> 'format-patch'.
> Other things are listed at [7].
>
> Recently I've also been using only the terminal with=20
> Gitgitgadget:
> I use 'git branch --edit-description' to write my cover letter,
> and then use the 'gh' GitHub CLI [8] to open my PR:
>
> $ git config --get-regexp alias.desc*
> alias.desc-title !git config branch.$(git branch=20
> --show-current).description | head -1
> alias.desc-body !git config branch.$(git branch=20
> --show-current).description | tail -n+3
> $ gh pr create --title "$(git desc-title)" --body "$(git=20
> desc-body)" --head phil-blain:$(git branch --show-current)
>
> I hope this provides a different perspective!

Thanks for the detailed reply!

I like that it covers a lot about how you retrieve patches and=20
respond
to reviews.

You have convinced me to give Gitgitgadget a try for my next patch=20
:^)

> Cheers,
> Philippe.
>
>
> [1] https://pypi.org/project/b4/
> [2]=20
> https://gist.github.com/phil-blain/d350e91959efa6e7afce60e74bf7e4a8
> [3]=20
> https://patchwork.readthedocs.io/projects/git-pw/en/latest/usage/
> [4] https://patchwork.kernel.org/project/git/list/
> [5] https://gitgitgadget.github.io/
> [6] https://github.com/gitgitgadget/gitgitgadget/issues/173
> [7] https://github.com/gitgitgadget/gitgitgadget/issues
> [8] https://cli.github.com/
