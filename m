Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340AFC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 14:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKBOnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKBOnv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 10:43:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542592982B
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 07:43:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b2so45924551eja.6
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+VZYSGf021dazdsImUQXoipEolu0fj6H6yhlsaQ3dQ=;
        b=QD30Di3RjL9NIxhvVIRlDBaQ22NtcF3MlBS39UzuCX6YmaRvJFMDKVcHhxiYc+8QUG
         Rmy5WBUDKndleDwqHY+JmsAva6YD2ytD/EHTMEmSSO3n6x0WH5L1Ur6fl/6HlIRdW1sx
         1zFhuvyUBpFH/y2RGn9IuKzxGT+rBLHsiU9iqqx28vDNW4TMbxD04VKBPZEbqSjfupQb
         uV9/HsMYpejZfxya5C21uefJqjrituuCuZeg2SlBPsF9KsqP9tslv6un/EJf5nL9uF2n
         BdgtWt6wP4lFzSMtWkf5yJqBw8ri1sc9O/qnhlIIIxv2+fXjXW8wHGTboDan7qrM47FK
         u5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+VZYSGf021dazdsImUQXoipEolu0fj6H6yhlsaQ3dQ=;
        b=GfR/NWTBgYswM3OblhX5yFJ5J/2cxQX0FE7Po0t2LX1yZC8kNhHFP4QXEfKV8nvckL
         x5izF6X2l5l39VzI+B251c/jEridOm8AJgwLVVzIXm8XpqfvaYUbTOVpJyK6BJk2s7Fa
         orgqTDvvOY9clEdI5/EwVAH8g6Wca9i/p/VNOIfIsjCQTevTboSETlLZJHtqXlEJZRsD
         AQV+Lukp1xT4NtrY3UJF3/lxJQ36DtTWfXZevQECn2DYfHOvCg63DzMDN0GvHJcYtqIW
         Nu3wn5Gro+Kd11Es4bQvkQupr97fZuSb4CWJwLlGcTr5LAsGur8ODCPc2B9vk3n3PHvn
         wbAQ==
X-Gm-Message-State: ACrzQf3ydAeisRrF0IfYR5gNaKRjRl+G9HE8C64+uDSQn8FkO3JoJseY
        P6VN+IAoUJ70wXgcxZgry1A=
X-Google-Smtp-Source: AMsMyM4icYyLq7AYsCkMU3xqLw5WQ/yrquAdB3xOnZWgeFVAUpI/0YiNJMve2YKxcQ4NGH8AbNMrSg==
X-Received: by 2002:a17:907:980e:b0:78d:b6ea:25b3 with SMTP id ji14-20020a170907980e00b0078db6ea25b3mr23710771ejc.98.1667400227579;
        Wed, 02 Nov 2022 07:43:47 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ce12-20020a170906b24c00b007addcbd402esm3200774ejb.215.2022.11.02.07.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:43:47 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqEy2-00Bocu-1n;
        Wed, 02 Nov 2022 15:43:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Martin Englund <martin@englund.nu>, git@vger.kernel.org
Subject: Re: gigantic commit messages, was Re: Git Bug Report: out of memory
 using git tag
Date:   Wed, 02 Nov 2022 15:26:20 +0100
References: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
 <Y2EPgICMsmzKvCC8@coredump.intra.peff.net>
 <38d50c30-c6a3-5989-6e01-47c5467d9d6b@gmail.com>
 <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
 <CABPp-BGmNqV5H5meMggKYTcTJDxxt5dRT3rZRnRPz496OJn3Vg@mail.gmail.com>
 <Y2I0siBlVOngNUtK@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2I0siBlVOngNUtK@coredump.intra.peff.net>
Message-ID: <221102.86pme52z8d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 02 2022, Jeff King wrote:

> On Wed, Nov 02, 2022 at 01:14:59AM -0700, Elijah Newren wrote:
>
>> On Wed, Nov 2, 2022 at 12:51 AM Jeff King <peff@peff.net> wrote:
>> >
>> > Here are patches which fix them both. I may be setting a new record for
>> > the ratio of commit message lines to changed code
>> 
>> It looks like the first patch is 72 lines of commit message for a
>> one-line fix, and the second patch is 61 lines of commit message for a
>> two line fix.
>> 
>> I don't know what the record ratio is, but it's at least 96[1], so
>> clearly you'll need to figure out how to pad your first commit message
>> with at least another 25 lines before this series can be accepted.
>> ;-)
>
> Well, if we want to start digging things up... ;)
>
> Try this:
>
>   git log --no-merges --no-renames --format='%H %B' -z --numstat '*.c' |
>   perl -0ne '
>     chomp;
>     if (s/^([0-9a-f]{40}) //) {
>       if (defined $commit && $diff) {
>         my $ratio = $body / $diff;
>         print "$ratio $body $diff $commit\n";
>       }
>       $commit = $1;
>       $body = () = /\n/g;
>       $diff = 0;
>     } elsif (/^\s*(\d+)\t/) {
>       # this counts only added lines, under the assumption that
>       # small commits generally remove/add in proportion. Of course
>       # ones that _only_ remove lines have infinite ratios.
>       $diff += $1;
>     } else {
>       die "confusing record: $_\n";
>     }
>   ' |
>   sort -rn |
>   head
>
> which shows there are a few in the 100's. Pipe through:
>
>   awk '{print $4}' |
>   git log --stdin --no-walk=unsorted --stat
>
> for a nicer view. I'm rejecting the top one on the grounds that it's
> mostly cut-and-paste output, and also that #2 is mine. ;)

I think that '*.c' is cheating, if anything I should be getting more
points when you remove that, as I've been over explaining
adding/removing a compiler flag or something. At least your #2 is tricky
C code :)

I haven't bothered to do this, but I think if you --word-diff
--word-diff-regex=. and parse the resulting diff you'd get "better"
results.

Or, for better & similar (but not the same): compute the levenshtein
distance of the pre- and post-image, and compute edit distance to commit
message length.

I haven't done that, but just from eyeballing it I think [1] beats your
[2] by that criteria. Per:
	
	$ perl -MText::Levenshtein=distance -wE 'say distance @ARGV' int unsigned
	6
	$ perl -MText::Levenshtein=distance -wE 'say distance @ARGV' "" _lf
	3

It should get 2x the score v.s. yours, but yours is <2x the
words/characters.

(Edit: But see [4] below)

There's also e.g. my [3] that's fairly high in the running per your
"only added lines". But I think it shows the perils of doing that,
i.e. in general I don't see why you'd omit deletions, that commit
message is certainly spending most of its time talking about why the
deletion of the code at hand is OK.

Once you count deletions it'll get *way* down the list, as it's 11
deleted lines, 1 added.

Hrm, I take some of the above back, I think [4] might be the winner.
That's just an edit distance of 1, so it's around 2x the commit message
length of yours if we adjust for your score of 6. (~2.5 by
characters)[5].

1. 356c4732950 (credential: treat CR/LF as line endings in the
   credential protocol, 2020-10-03)
2. aec0bba106d (config: work around gcc-10 -Wstringop-overflow warning,
   2020-08-04)
3. f97fe358576 (pickaxe -G: don't special-case create/delete,
   2021-04-12)
4. c58bebd4c67 (ci: update Cirrus-CI image to FreeBSD 12.3, 2022-05-25)
5. All measured with "git show --no-notes --no-patch <commit> | wc",
   because I was lazy.
