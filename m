Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4F5C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 13:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74BF461002
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 13:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbhHZNCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 09:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbhHZNCj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 09:02:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74CCC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 06:01:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id x11so6242374ejv.0
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 06:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RkeZIhZDnUFwIgPTNjYMVu9eeKYDw92iTD9MLoMExCg=;
        b=t0ZMOUPNTKf7x+0n4e3SLbjRn2RTSbrhtpHk7Hjf+GB2Zc335z7kE1VDm241ShQS8O
         bEpYgUJpNLXpZ/xmrW65OyCY3OpJH9KYprY9J1NnUdVpdH+HF+A+4m+q7QwRfYafoVSH
         xAn5y4FZWw5wfZEuSW84VyJ1yzvCnfSQV2mtQLqgvRfrshIewsYumHvYZEpWgM4vpyJV
         oUkP9aBlTKaAuldIZv0YaHtvrMGgLw/D9PNl15NONG3bpiGQL+OJzieOVsCGgg0vNg/m
         c29IgOtUE7+px0Ek4hFgup3od4eUOet0ltcuvFjydyMj2DcmcaU3z2O6G8gs7elO4HRw
         7Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RkeZIhZDnUFwIgPTNjYMVu9eeKYDw92iTD9MLoMExCg=;
        b=B29UiqU44DhLWTOZuQjYaNK9Rsxo9uHNOmsEpOngV7RcFupH/Y9zZbbrwjXgGntXvJ
         PzxamFcbvJwr6I18VfYziJJWIEAy2n3qpez8VAO2JFU/PuVQ5C0NoKGbob4HiRS5D+Vs
         W/ZpPAH4n8vZq9OPSs5RSgo2c+NZtXIJ+/ZKLIz5GR8JpTIRuDZVbcC+9atd8XKU5fDc
         DTebVjyJr18GepfxhjedSMIImakxQrg5GxDTcipzTKONiEMD9JQqQKvuoiaOf2kDH05Y
         veQv3Oewy1Cn6rHlz6i4ub57aXuJ+HHpizU+bC2xkacXVVTuC7F5UYjZY/5Mi/htuVYH
         AgRg==
X-Gm-Message-State: AOAM530KzNJDdxu42Tf9UJJKrZYXjxcp+jyG4bKwBqQ2vpFuY3EaYB9A
        0FqhLjKkU+owjPFj6oXdXk2mN7EpZ1bjnQ==
X-Google-Smtp-Source: ABdhPJyZfjmI0wMQQ1Lm4kFa3gvkSe0A6Fs461AwWtsdDjaTXFUDxcwANiQvM5V1EBtCSmD8fSCnpw==
X-Received: by 2002:a17:906:4cc1:: with SMTP id q1mr4350973ejt.415.1629982910134;
        Thu, 26 Aug 2021 06:01:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q6sm1789304edd.26.2021.08.26.06.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:01:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: "I don't know what the author meant by that..." (was "Re: [PATCH 6/6]
        tr2: log N parent process names on Linux")
Date:   Thu, 26 Aug 2021 14:24:10 +0200
References: <87o8agp29o.fsf@evledraar.gmail.com>
 <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
 <patch-6.6-da003330800-20210825T231400Z-avarab@gmail.com>
 <YScTaDcPTs1nrP2Y@nand.local>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YScTaDcPTs1nrP2Y@nand.local>
Message-ID: <87k0k8z7er.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 26 2021, Taylor Blau wrote:

> On Thu, Aug 26, 2021 at 01:19:24AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> In 2f732bf15e6 (tr2: log parent process name, 2021-07-21) we started
>> logging parent process names, but only logged all parents on Windows.
>> on Linux only the name of the immediate parent process was logged.
>>
>> Extend the functionality added there to also log full parent chain on
>> Linux. In 2f732bf15e6 it was claimed that "further ancestry info can
>> be gathered with procfs, but it's unwieldy to do so.".
>>
>> I don't know what the author meant by that, but I think it probably
>> referred to needing to slurp this up from the FS, as opposed to having
>> an API.
>
> I don't think that this (specifically, "I don't know what the author
> meant by that") is necessary information to include in a patch message.
>
> If you're looking for a replacement (and you may not be, but just my
> $.02) I would suggest:
>
>     "2f732bf15e6 does not log the full parent chain on Linux; implement
>     that functionality here."

I hope Taylor doesn't mind me quoting it, but he sent me this follow-up
off-list:

    For what it's worth, I really struggled to write this. What I was trying
    to say was something along the lines of "let's give Emily a little more
    credit for not doing this right off the bat", but I didn't want to write
    that exactly, since I don't think it was your original intention.
=20=20=20=20
    At the very least, saying something to the effect of "I don't know what
    the original author thought was so tough, here's a patch to implement
    it" isn't helping anybody, so I tried to focus on that.
=20=20=20=20
    Anyway, just writing to you off-list to say that I do think you had good
    intentions, but that what you wrote may be read differently by others in
    a way that you didn't intend it to be.

First, thanks to Taylor for pointing this out, and second I'd like to
apologize for that comment.

More than some "sorry someone read it that way", this really does read
even to me, its author, shortly after having written it like something
that's way more on the side of sneakiness than a charitable comment.

I.e. like some snipe-y paraphrasing of "maybe they found this problem
too complex, but look how easy it is!" than something charitable that's
meant to barely pass under the radar.

Hopefully it helps that I'm honestly just being a bit of an
inconsiderate idiot here than actively malicious.

What I meant to accomplish here was to guide a reader of these patches
through the same mental states I went through when reading the original
patch.

I.e. I took it from its description that there were some unstated
special-cases in reading procfs that made it harder to deal with than
not. I think those comments were rather just a way to say that scraping
procfs was a bit of a pain, and the MVP in 2f732bf15e6 was good enough
for now, which is fair enough.

I rephrased those comments in v2 of this patch[1]. The summary starting
at the 4th paragraph ("It's possible given the semantics[...]") is an
edge case I hadn't considered when I wrote v1. I in turn copied that
"unweildy" comment from an even older version[2], where the difficulties
of parsing the "comm" field out of "/proc/*/stat" weren't apparent to
me.

I.e. I think if I had to describe that interface now I would describe it
as unwieldy, but wouldn't when I wrote v1[1] or that v0[2]. I.e. I think
there's no convenient way to get full atomic snapshot of the process
tree, so "give me the names of all my parents as an array" is definitely
somewhere between brittle and unwieldy, in particular considering the
hassle of parsing "/proc/*/stat" properly.

But I digress, which is also a problem I have with being overly verbose
sometimes and weaving enough rope to hang myself with.

The point isn't the difficulties of the procfs(5) interface, but that
particularly with a medium like the text-based communication we mainly
use in this project it behooves the sender to think not only about what
they're saying, but how what they're saying is going to be interpreted
by the recipient and bystanders alike.

I think this is a case where I clearly failed at that, sorry Emily, and
thanks Taylor for pointing this out to me.

1. https://lore.kernel.org/git/cover-v2-0.6-00000000000-20210826T121820Z-av=
arab@gmail.com/
2. https://lore.kernel.org/git/87o8agp29o.fsf@evledraar.gmail.com/
