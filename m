Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22BB20754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761564AbdADSZG (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:25:06 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36729 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbdADSXi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:23:38 -0500
Received: by mail-qk0-f180.google.com with SMTP id n21so409125189qka.3
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pbTT0QBUFep6pQgeodfdgho9ssu4I5agvRIFqJ/NKa0=;
        b=Cvd0+L1dyoQfwISW37ZDS5iW17L1jZhgIazLI5J6fTv3KYn21wGLuqMX6KCIgknNdt
         E51R+YhxqUPZIjMqV+Hu3+2NPVXvCl0tYt/qbAth4UIDbyN9je9MySFqiVtnbBCks0qj
         eqqpVgtFvFQcBMK7n99xmIT4LjH69VZlGjh6CQNSeGUd/eyjehAQTDjrmm3eCnFegziZ
         D54+b9cgv5ns2mvcDqp7hAyZWVm/FoD3dJT6l3z0IkQuXawPhAmPbujNNTAXP/EHPh0A
         WLfhzJawEHvJT+O4LSDdo/+hXew3OA2tXvdn5NFAoebkYO8lMNe4QoTlvieYgFiXAui7
         zLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pbTT0QBUFep6pQgeodfdgho9ssu4I5agvRIFqJ/NKa0=;
        b=rlToSTBlXtyXzRYgehZq4O+FMX3pueQGKVUXO0g9izBpZz2Rx4xDFMclDu5yj2Ljm3
         XQN4+yRrU2NuKqF4YTxvitI+nSgHhRqGNMVVkyB8hInEUOO5sIqsDQIhmqn7A6l0j37t
         RUtPlu9oC2fCBJXaS1gLCXIeOSAxMPiMf2Av97goT0gsVorvo8PsjxmBrg47vKEVIYKt
         EJzeoiBQZedrZI7QYULt2+Lg1iWcqbNfeQdzBdorQuFS/LMQKxWRciaG540EHukV4PV3
         zOCw9cYKKOegXb1FpHkSsy8zvyVZvKvYpQ1q5rRvqsVGcNIdwgMMP3FSerjs7YTCjkD6
         0Dvw==
X-Gm-Message-State: AIkVDXL++IMQjVtjbl9/YGhc+9355Gnfp9WWE4Pd4lbCiYaVJdcV8IEoigVMAkuG1kblRugeqv3tVv7B3kLl28RA
X-Received: by 10.233.216.7 with SMTP id u7mr64803605qkf.220.1483554159245;
 Wed, 04 Jan 2017 10:22:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Wed, 4 Jan 2017 10:22:38 -0800 (PST)
In-Reply-To: <20170104181318.GC69227@google.com>
References: <1481566615-75299-1-git-send-email-bmwill@google.com>
 <20170103190923.11882-1-bmwill@google.com> <20170104004825.3s27dsircdp5lqte@sigill.intra.peff.net>
 <3f9a530c-402f-f276-4721-fa6a8a6fef41@web.de> <20170104070107.huse2a6thz737epv@sigill.intra.peff.net>
 <20170104181318.GC69227@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 4 Jan 2017 10:22:38 -0800
Message-ID: <CAGZ79kbdNuGe038Wb9OR1SKq-XYtsPrLsn6XueO6zsKKGFYiNg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] road to reentrant real_path
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 4, 2017 at 10:13 AM, Brandon Williams <bmwill@google.com> wrote=
:
> On 01/04, Jeff King wrote:
>> On Wed, Jan 04, 2017 at 07:56:02AM +0100, Torsten B=C3=B6gershausen wrot=
e:
>>
>> > On 04.01.17 01:48, Jeff King wrote:
>> > > On Tue, Jan 03, 2017 at 11:09:18AM -0800, Brandon Williams wrote:
>> > >
>> > >> Only change with v4 is in [1/5] renaming the #define MAXSYMLINKS ba=
ck to
>> > >> MAXDEPTH due to a naming conflict brought up by Lars Schneider.
>> > >
>> > > Hmm. Isn't MAXSYMLINKS basically what you want here, though? It what=
's
>> > > what all other similar functions will be using.
>> > >
>> > > The only problem was that we were redefining the macro. So maybe:
>> > >
>> > >   #ifndef MAXSYMLINKS
>> > >   #define MAXSYMLINKS 5
>> > >   #endif
>> > >
>> > > would be a good solution?
>> > Why 5  ? (looking at the  20..30 below)
>> > And why 5 on one system and e.g. on my Mac OS
>> > #define MAXSYMLINKS     32
>>
>> I mentioned "5" because that is the current value of MAXDEPTH. I do
>> think it would be reasonable to bump it to something higher.
>>
>> > Would the same value value for all Git installations on all platforms =
make sense?
>> > #define GITMAXSYMLINKS 20
>>
>> I think it's probably more important to match the rest of the OS, so
>> that open("foo") and realpath("foo") behave similarly on the same
>> system. Though I think even that isn't always possible, as the limit is
>> dynamic on some systems.
>>
>> I think the idea of the 20-30 range is that it's small enough to catch
>> an infinite loop quickly, and large enough that nobody will ever hit it
>> in practice. :)
>
> I agree that we should have similar guarantees as the OS provides,
> especially if the OS already has MAXSYMLINKS defined.  What then, should
> the fall back value be if the OS doesn't have this defined?  5 like we
> have done historically, or something around the 20-30 range as Torsten
> suggests?

As a fallback I'd rather go for a larger number than too small.
The reason for the existence is just to break an infinite loop
(and report an error? which the current code doesn't quite do,
but your series actually does).

If the number is too large, then it takes a bit longer to generate the erro=
r
message, but the error path is no big deal w.r.t. performance, so it's fine
for it taking a bit longer.

If the number is too low, then we may hinder people from getting actual
work done, (i.e. they have to figure out what the problem is and recompile
git), so I'd think a larger number is not harmful. So 32?

>
> --
> Brandon Williams
