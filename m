Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABA8C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 20:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbiFIUCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 16:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiFIUC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 16:02:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703D3DA0
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 13:02:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id fd25so32628890edb.3
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CZymDlpRavnIXlHwOnAsMeCtwmN+xOViUUN0mhBbaFA=;
        b=AEn370zoy16g4ro6AQMWZk5/bQYePXM9vAtu4DehpNIhV2bQPpu01ood4MteYMAC1v
         1IviGcRXlklZFtlN7vARRDHq9dc+g7zAB6NHn7ajsWmQ5e75SfdsrQfPKOjnyDY78FS/
         vQP6fKRn+8nlcX1vy6CIqJlE08eQGVYf+qZy0TGjCbWm59cdjwBc8jzFvpHktX0mI98t
         R/xscm0Kme8d7reo5xc7Y36YBX2p1sRfXJR2Tu5M4l1moLXUE0hq4dO0LY4K8n+x/DiA
         Zin2pj8g7Vud7095ZVajU6KDBPvq9iAkWRTiKIJUB0pG6i90liWijUXBOGyRG6fzlG4B
         UKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CZymDlpRavnIXlHwOnAsMeCtwmN+xOViUUN0mhBbaFA=;
        b=KcAZmzirhtLQ3jPTNcTkG78RfXQnYQzmSyPUnEnqNiM/ygWlj7xR0y3jVjhnVzlNpi
         hBQrB53bQnuWpuBHjs1o71LfcssUmx8oRostvSXhLd+sYRTC4ZfOoIcijDvcIcIqWLag
         M65PZx5D2uJsit3kn3Zx6KsdEWLCY0RHU+egPCEZQaYs1fQdoa+Ukw8U6mRyxnE6dLWQ
         k2IDEEORxmbIgyouIe49U9ym0s+6MHg7p79iTZjVTxQnsothO7p5RvzYgA12vlJvYvPc
         M3aZT4RSYIcTDBeEa+nXjlj0+QcPs+AwgxbtpluIFwGHEzqdn+rOoXXkPO06Ss15U2In
         qOrQ==
X-Gm-Message-State: AOAM533klETHsgUTgnWe8ET/qTN+wLraPNQkSEQ9wfVs2faicJKxvfHw
        I8xYr2FB3mL9WoWbm2afuQU=
X-Google-Smtp-Source: ABdhPJwBMqklfO5BWoMf5XBHHyXhTWysH76DLKrrkEaQ0HqjMVIfDZIrbR9y2bR9cpU1H9zf930fug==
X-Received: by 2002:a05:6402:50f:b0:433:48e6:ef78 with SMTP id m15-20020a056402050f00b0043348e6ef78mr2764442edv.217.1654804944668;
        Thu, 09 Jun 2022 13:02:24 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090685c700b007104b37aab7sm8240364ejy.106.2022.06.09.13.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:02:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nzOMJ-0034uY-8w;
        Thu, 09 Jun 2022 22:02:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>, congdanhqx@gmail.com,
        dyroneteng@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: js/ci-github-workflow-markup output regression
Date:   Thu, 09 Jun 2022 21:43:45 +0200
References: <xmqqee28spni.fsf@gitster.g>
        <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2206021703110.349@tvgsbejvaqbjf.bet>
        <220603.86fskmxd43.gmgdl@evledraar.gmail.com>
        <xmqqpmjpeedq.fsf@gitster.g>
        <220604.86y1ydwcq1.gmgdl@evledraar.gmail.com>
        <xmqqo7z4wcsw.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2206080922470.349@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <nycvar.QRO.7.76.6.2206080922470.349@tvgsbejvaqbjf.bet>
Message-ID: <220609.86r13xsj00.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 08 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Tue, 7 Jun 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> > On Fri, Jun 03 2022, Junio C Hamano wrote:
>> >
>> >> Indeed it makes it impossible to figure it out things like this case.
>> >> But ...
>> >>
>> >>> But this does look easy to "solve" with a quicker fix, just bringing
>> >>> back the "ci/print-test-failures.sh" step so you can at least expand
>> >>> it, and not have to go to the "summary" and download the *.zip of
>> >>> the log itself.
>
> I agree that re-adding the `ci/print-test-failures.sh` step makes sense,
> given the recent experience.
>
>> >>> As that shows we still have the raw log there, it just didn't make
>> >>> it to the new GitHub Markdown formatting mechanism.
>> >>
>> >> ... it seems a solution is possible?  Care to send in a patch (or
>> >> perhaps Dscho already has a counter-proposal)?
>
> I will work on this.
>
>> > The only thing I have at the moment is:
>> >
>> >     1. git revert -m 1 bd37e9e41f5
>> >     2. merge: https://lore.kernel.org/git/cover-v6-00.29-00000000000-2=
0220525T094123Z-avarab@gmail.com/
>> >     3. merge: https://lore.kernel.org/git/cover-v6-00.14-00000000000-2=
0220525T100743Z-avarab@gmail.com/
>> >
>> > I.e. to pick this in the sequence I'd proposed doing & have tested
>> > thoroughly.
>>
>> I know you two have difference in opinions, but throwing away everything
>> the other party did and forcing your stuff in is not a very effective
>> way to work together.
>
> I had already pointed out a rather terrible issue in that 29-strong patch
> series: Dropping Azure Pipelines support makes it unnecessarily harder to
> work on Git security issues. And it's not like we have an armada of people
> working on those. I, for one, am pretty worn out from the recent work.
>
> It might not be the intention of that patch series to make my life harder,
> but it sure would be its impact. And intent does not excuse impact.
>
> I therefore had to conclude that the patch series in this form cannot be
> merged.

You raised the same concern in February, and I made some practical
suggestions for how to proceed with that in:

    https://lore.kernel.org/git/220222.86y2236ndp.gmgdl@evledraar.gmail.com/

You didn't reply, and here was a reminder in late March:

    https://lore.kernel.org/git/cover-v2-00.25-00000000000-20220325T182534Z=
-avarab@gmail.com/

You then had a similar concern, and I replied again in early April
saying I'd be happy to acomodate you, if you could reply to that
original E-Mail and clarify what you'd like exactly:

    https://lore.kernel.org/git/220406.86bkxeecoi.gmgdl@evledraar.gmail.com/

And here's a mention of it again in late April:

    https://lore.kernel.org/git/220421.86fsm66zmz.gmgdl@evledraar.gmail.com/

Then a few weeks ago you brought up the same point, and I replied again
you to please reply to that E-mail from back in February:

    https://lore.kernel.org/git/220524.86y1yrwaw0.gmgdl@evledraar.gmail.com/

So really Johannes, I'm completely fine with accommodating you.

But when you suggest that some ad-hoc combination of out-of-tree code
and not-used-in-tree code you have must not be touched *and* you're
seemingly unwilling to figure out some way forward you're not being very
helpful.

Instead you just keep repeating that something must not be changed, and
when it's pointed out to you that that would block someone else's
patches, but would you be OK with X, Y or Z you seemingly just blackhole
the replies you get.

So can you reply to that this time? Thanks.

> I recall that other reviews reached the same consensus, that this
> 29-strong patch series is too unfocused on any particular goal. So maybe
> calling this "my opinion" is not exactly fair.

Yes, that's something others brought up, but it's unrelated to the Azure
issue you're raising here. That change was contained within the first 6
or so patches of that series.
