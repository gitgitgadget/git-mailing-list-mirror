Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22780C433E4
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 17:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0945C619F0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 17:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhC3Rn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:43:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51648 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhC3Rng (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 13:43:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83B7EADF3B;
        Tue, 30 Mar 2021 13:43:35 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=MoBx8nZapQFHT
        69Dcawna0FUm3U=; b=VkHxiXspxOQvU/ICJK0PBDftR1adkSrsW5whg55Ke6min
        VmCYCFq3aD4YBRqqzJh1C0CYCLNoAFxke10hp7+G6RJK/EX0kVIZJKc6XMyoPh4M
        /mUY6u+AQe2q9RCC/d3PBdxh14WiaLDRsr/mXqo2JdfWFbXMGS5YIvkGk5gFp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=tTh0J2J
        4pgZuWGf9cY/pgtOjY+h1nlDcDMOa4iNCfySqZyl+RlgWv6NLM0ANp/I04JejkD1
        wIvfkQmsGV04jS8m5rNuNwB5oP5qtqZpoDMqX6tp/P2wcEisqaLh3sIV26e0V2Ac
        fD+YT86C4nJaHXKEe2+xuD2Ft6+coE5JovSA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C2FEADF39;
        Tue, 30 Mar 2021 13:43:35 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.178.181])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8644ADF38;
        Tue, 30 Mar 2021 13:43:34 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Tue, 30 Mar 2021 13:43:33 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Kevin Daudt <me@ikke.info>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] maintenance: specify explicit stdin for crontab
Message-ID: <20210330174333.GJ15354@pobox.com>
References: <20210329210928.561586-1-me@ikke.info>
 <CAN0heSrSNJhy33Wi9Yq8kfnkJEyvQoadyj8joLqHtV+SYPs1sw@mail.gmail.com>
 <25ea6f26-c829-f63f-77a1-11a28bbe7fc0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <25ea6f26-c829-f63f-77a1-11a28bbe7fc0@gmail.com>
X-Pobox-Relay-ID: 7385ED98-917F-11EB-8452-D152C8D8090B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:
> On 3/30/2021 1:41 AM, Martin =C5gren wrote:
>> On Mon, 29 Mar 2021 at 23:23, Kevin Daudt <me@ikke.info> wrote:
>>>
>>> There are multiple crontab implementations that require stdin for
>>> editing a crontab to be explicitly specified as '-'.

Amusingly, I wrote the exact same patch 2 weeks ago
(including not dropping the `argc =3D=3D 2` which Martin
mentioned).  That was in response to a report in the Fedora
bugzilla:

    https://bugzilla.redhat.com/1939930

I thought cronie might be rather rare with it's non-POSIX
handling of crontab without arguments.

In the end, the cronie folks upstream adjusted things so
that crontab behaves as defined by POSIX if stdin is not a
TTY:

    https://github.com/cronie-crond/cronie/commit/8b0241f

That allows cronie to behave more sensibly for interactive
use without breaking tools like git maintenance.  And it let
me sidestep proposing a patch to git (or worse, maintaining
it in the Fedora packages).

But I didn't dig in to find out whether or how many other
crontab implemntations had also eschewed the (rather poor)
POSIX-confirming behavior.  Knowing there are several among
popular OS's makes it easy to see something like this patch
being generally useful.

Though, as Derrick notes below, we would break systems which
implement crontab strictly per the POSIX spec.  I don't know
how many crontab's don't accept `-`.

At the time, I checked on an older OmniOS system I had
access to (based on Illumos/OpenSolaris) and it did not
accept `-`.  So my quick sample size of 3 (Fedora, CentOS,
and OmniOS) I had a 1/3 failure rate.

> Thank you for reporting this, especially with a patch!
>=20
> However, I'm not sure about this adding of '-' being something that
> crontab ignores so commonly. My Ubuntu machine reports this:
>=20
> $ crontab -e -
> crontab: usage error: no arguments permitted after this option
> usage:  crontab [-u user] file
>         crontab [ -u user ] [ -i ] { -e | -l | -r }
>                 (default operation is replace, per 1003.2)
>         -e      (edit user's crontab)
>         -l      (list user's crontab)
>         -r      (delete user's crontab)
>         -i      (prompt before deleting user's crontab)
>=20
> Is there a way we could attempt writing over stdin, notice the
> failure, then retry with the '-' option?

You'd skip the `-e` there, no?  Running `crontab -` in a
current ubuntu container with the cron package installed
(what looks like vixie-cron-3.0pl1) works as expected.

Perhaps a Makefile knob to allow systems with such a crontab
to adjust the behavior would be an alternative to detecting
and retrying?

NEEDS_CRONTAB_STDIN_OPT or something like that, with
config.mak.uname to override whichever default is chosen.
Whether that's a better option really depends on how much
effort it is to add and maintain the detection in the code
weighed against how many systems would need to have the
default changed.

Mildy related, I wonder whether we'll eventually see a patch
to use systemd timers instead of cron (optionally, of
course).  Fedora, for example, doesn't install crond by
default anymore.  (Though, warts and all, I still prefer
crond myself.)

>> [...]
>>=20
>>> --- a/t/helper/test-crontab.c
>>> +++ b/t/helper/test-crontab.c
>>> @@ -17,7 +17,7 @@ int cmd__crontab(int argc, const char **argv)
>>>                 if (!from)
>>>                         return 0;
>>>                 to =3D stdout;
>>> -       } else if (argc =3D=3D 2) {
>>> +       } else if ((argc =3D=3D 3 && !strcmp(argv[2], "-")) || argc =3D=
=3D 2) {
>>>                 from =3D stdin;
>>>                 to =3D fopen(argv[1], "w");
>>=20
>> Would it make sense to make this
>>=20
>>   } else if (argc =3D=3D 3 && !strcmp(argv[2], "-")) {
>>=20
>> in order to make this test-tool as picky as possible and to only accep=
t
>> the kind of usage we want to (well, need to) use? The tests as they
>> stand would still pass, which I think argues for us not really needing
>> that "argc =3D=3D 2".
>>=20
>> This would be followed by
>>=20
>>   } else
>>           return error("unknown arguments");
>>=20
>> which wouldn't be super helpful if you forgot the "-", but helpful
>> enough for an internal test-tool, I guess.
>>
>> Speaking of usage and hints, there's "Usage: ..." in a comment at the
>> top of this file. It should probably be updated either way.
>=20
> I agree with Martin's review here, too.

--=20
Todd
