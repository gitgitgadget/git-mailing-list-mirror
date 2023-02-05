Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F9DC636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 22:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBEWDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 17:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEWDw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 17:03:52 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206EE199E8
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 14:03:51 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mf7so29289842ejc.6
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 14:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SG7c5zckeoesNkgX9/CsfUcgRkID63H2uZQ7f7jbJgI=;
        b=ZhZ+QVxk7U06CaztaNMcgxTK4kxYFGKJEyjXrykKNBRsFDHMK3sec1gLe7PUo8I0ej
         bcAYG9DoSsNZwJJZG4sMhzjTx3WTR1AIruHeDXhUUy4NBPQi+5BZReMc/JrAhA09bwCq
         eSBz2RB+ZVsowRQmHC8GSHyLm/nRq2nFrlnJpz0WQqd4wR99r6n+A8u7nsNGxY8PIMrG
         xLEK/+rrFdf1aB6X6HppQvaCn0bOyY94yDxToROMiSJOnRXkqCNAWGwkOtGvWTDQZ7qQ
         q9E3Nw+xbnmc/YaxwPh9o44ELztw4MtqClX45Jl/8pXLePdlJ5eUk+wgT1liQg5ZTSSM
         Nqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SG7c5zckeoesNkgX9/CsfUcgRkID63H2uZQ7f7jbJgI=;
        b=GZGlE+avENC7Hp2l3DUkAHBtQNOvGZFKptuBWItmuifKu32La2dJ0OfldXViOiTmkG
         vyqCyzQWikk+7WY+f6WFBqTcrbe1w3f+TH//KBB6gby0qlqfA5r5zAvITUlXZpWHqRmj
         Z1rEllutGaREZ65XN3R4fWzb0nzSlrcMaU8W2VCVz0/elBjHF+VkuM7S7ygWpgvuXLvq
         u4C22OCqppekMEOggFexcbRMUJJkAwpiYrpHfq5e7Hzpt6baFw6heCvn0ORplRaJhxwR
         LDzwSTAxClX7djWKkAfbLqxhpTxe35A9uonm4A1wSQCtHW800KjR/j6FSKkX1WMvYboN
         LxwA==
X-Gm-Message-State: AO0yUKV6Zdw7Nr9WsZCozJpHI5dHCy/LSdwX4iYwRASQEGHXD57VtQil
        M0QfA3UZikw8LYT2w90d7cjE2KJ2iRgv37tx
X-Google-Smtp-Source: AK7set8U8htc5SnXU82tbabLmZ7shGGvg62Jv4dHpJfHGQXU5L2D2LsIhvEyAQGE+NokP4L64iSRPw==
X-Received: by 2002:a17:906:fe46:b0:88d:ba89:1849 with SMTP id wz6-20020a170906fe4600b0088dba891849mr15448173ejb.26.1675634629498;
        Sun, 05 Feb 2023 14:03:49 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906158700b0088385cd6166sm4605084ejd.195.2023.02.05.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 14:03:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pOn6y-0008Rn-0g;
        Sun, 05 Feb 2023 23:03:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
Date:   Sun, 05 Feb 2023 22:51:04 +0100
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
        <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
        <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
        <Y94866yd3adoC1o9@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y94866yd3adoC1o9@coredump.intra.peff.net>
Message-ID: <230205.86ilgf7osb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 04 2023, Jeff King wrote:

> On Fri, Feb 03, 2023 at 10:12:27PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
> [...]
>> I agree that "give this to the auth helper" might be useful in general,
>> but our current documentation says:
>>=20
>> 	To use the tool, `imap.folder` and either `imap.tunnel` or `imap.host` =
must be set
>> 	to appropriate values.
>>=20
>> And the docs for "imap.tunnel" say "Required when imap.host is not set",
>> and "imap.host" says "Ignored when imap.tunnel is set, but required
>> otherwise".
>>=20
>> Perhaps we should bless this as an accidental feature instead of my
>> proposed patch, but that's why I made this change. It seemed like an
>> unintentional bug that nobody intended.
>
> Yes, I agree that the scenario I'm giving is contrary to what the docs
> say. But IMHO it is worth preferring what the code does now versus what
> the docs say. The current behavior misbehaves if you configure things
> badly (accidentally mix and match imap.host and imap.tunnel). Your new
> behavior misbehaves if you have two correctly-configure imap stanzas
> (both with a host/tunnel combo). Those are both fairly unlikely
> scenarios, and the outcomes are similar (we mix up credentials), but:
>
>   1. In general, all things being equal, I'd rather trust the code as
>      the status quo. People will complain if you break their working
>      setup. They won't if you fix the documentation.
>
>   2. In the current behavior, if it's doing the wrong thing, your next
>      step is to fix your configuration (don't mix and match imap.host
>      and imap.tunnel). In your proposed behavior, there is no fix. You
>      are simply not allowed to use two different imap tunnels with
>      credential helpers, because the helpers don't receive enough
>      context to distinguish them.
>
>      And that is not even "two imap tunnels in the same config". It is
>      really per user. If I have two repositories, each with
>      "imap.tunnel" in their local config, they will still invoke the
>      same credential helpers, and both will just see host=3Dtunnel. The
>      namespace for "host" really is global and should be unique (ideally
>      across the Internet, but at the very least among the hosts that the
>      user contacts).
>
> One fix would be to pass the tunnel command as the hostname. But even
> that has potential problems. Certainly you'd have to tweak it (it's a
> shell command, and hostnames have syntactic restrictions, including
> forbidding newlines). And you'd probably want to swap out protocol=3Dimap
> for something else. But I'm not sure if helpers may complain (e.g., I
> seem to recall that the osxkeychain helper translates protocol strings
> into integer constants that the keychain API understands).
>
>> Especially as you're focusing on the case where it contrary to the docs
>> would do what you mean, but consider (same as the doc examples, but the
>> domains are changed):
>>=20
>> 	[imap]
>> 	    folder =3D "INBOX.Drafts"
>> 	    host =3D imap://imap.bar.com
>> 	    user =3D bob
>> 	    pass =3D p4ssw0rd
>>=20
>> 	[imap]
>> 	    folder =3D "INBOX.Drafts"
>> 	    tunnel =3D "ssh -q -C user@foo.com /usr/bin/imapd ./Maildir 2> /dev=
/null"
>>=20=09
>> I.e. I have a config for "bar.com" I tried earlier, but now I'm trying
>> to connect to "foo.com", because I read the docs and notice it prefers
>> "tunnel" to "host" I think it's going to ignore that "imap.host", but
>> it's going to provide the password for bar.com to foo.com if challenged.
>
> Yes, that's a rather unfortunate effect of the way we do config parsing
> (it looks to the user like stanzas, but we don't parse it that way; the
> second stanza could even be in a different file!).
>
> Though as I said above, I still think this case does not justify making
> the code change, I do think it's the most compelling argument, and would
> make sense to include in the commit message if we did want to do this.
>
>> So I think if we want to keep this it would be better to have a
>> imap.tunnel.credentialHost or something, to avoid conflating the two.
>
> Yes, there are many config schemes that would avoid this problem. If you
> are going to tie the two together, I think it would make sense to use
> real subsections based on the host-name, like:
>
>   # hostname is the subsection key; it also becomes a label when
>   # necessary
>   [imap "example.com"]
>
>   # does not even need to mention a hostname. We'll assume example.com
>   # here.
>   tunnel =3D "any-command"
>
>   # assumes example.com as hostname; not needed if you are using a
>   # tunnel, of course
>   protocol =3D imaps
>
> But I would not bother going to that work myself. IMHO imap-send is
> somewhat of an abomination, and I'd actually be just as happy if it went
> away. But what you are doing seems to go totally in the wrong direction
> to me (keeping it, but breaking a rare but working use case to the
> benefit of a rare but broken misconfiguration).
>
>> > Of course if you don't set imap.host, then we don't have anything usef=
ul
>> > to say. But as you saw, in that case imap-send will default the host
>> > field to the word "tunnel".
>>=20
>> Isn't that more of a suggestion that nobody cares about this? Presumably
>> if we had users trying to get this to work someone would have complained
>> that they wanted a custom string rather than "tunnel", as the auth
>> helper isn't very helpful in that case...
>
> Not if they did:
>
>   [imap]
>   host =3D example.com
>   tunnel =3D some-command

Yes, but how would they have ended up doing that? By discarding the
documentation and throwing things at the wall & hoping they'd stick?=20

I take all your general points above, and generally agree with them. Re
#1 we should generally prefer current behavior over the docs, and re #2:
Yes, I agree this might be useful in princple, and hardcoding
"host=3Dtunnel" doesn't leave a way to pass a custom "host to the auth
helper.

I also don't care enough to argue about it, so I'll leave the first hunk
here out of any re-roll. We'll continue to pass "host" down in that
case, i.e. I'll only adjust the error messages.

I just don't get how anyone could have come to rely on this so that we'd
care about supporting it.

Because mutt has a feature that looks similar, users might have
configured git-imap-send thinking it might do the same thing, and gotten
lucky?

I guess in principle that could be true, but I think it's more likely
that nobody's ever had reason to use it that way. I.e. if you use the
"tunnel" the way the docs suggest you won't hit the credential helper,
as you're authenticating with "ssh", and using "imapd" to directly
operate on a Maildir path.
