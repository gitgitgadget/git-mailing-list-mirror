Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316FEC636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 21:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjBGVDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 16:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBGVDE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 16:03:04 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B760225286
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 13:02:10 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so46022217ejc.4
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 13:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xcJRih3n4iw+lfwm/gUoaNmqigSPzLfX+9XOVgHVBvo=;
        b=OowogIq2OawQzJZ1V+gS0r8plTE0g/A5+khaxQpvbsjK2yXUx47sV6eef81hiYGeFB
         6aC3kzz8l/ZexjWf4Mld2+2SJDpfRUrXJp/ZjmTrBZfb98VJlS0xpseVJGb0y/KclBQl
         PB8aktYqkOJuzs3IvmzlTpNvcj0Bb/ldmRXIia5okEdN+MchIHZT/lmhyGYe3xpszeAR
         64pTK6WLzO8SLzeiE2lx0T0B3w7I3pjB8fPQN2If3aJA8qLK/8a5dBjF7x388NEMRJoZ
         7YC3P7ZpJF+pd3GF3ZjemC1rzBnYJTs1yTsBxzOvpwfWpED6ReYwrdg+QiCIUarJQE4M
         XTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcJRih3n4iw+lfwm/gUoaNmqigSPzLfX+9XOVgHVBvo=;
        b=rRdvwxG0Y8J/JGs3i4zhCArMyc4DOBXFQ2NGuL4+XMYced4meZ7Dui4Jkp6/5XKAzV
         47QhPwGvYBBHw16DRkT2hJ/QqMG/eYg5rCGqKtI/Ms8U9hpDgQKlYezXcYohBDtqB/70
         y8+ZW6rwesmMH4rnbU+RSQo9YLMOKvHKdhXjWbJAvqcIFLJu3mYPO0U5XRcpZ9KbHUWC
         2AFU70E+2ZtcSLTAoStOUHeWifbRIzjLc5j3nKPSg/6uB+4jrC5IoqYYYW9rCQ++wYyr
         6hbSQ4ylqoyO0gHL8zmufE+kAdYLlLHMya2EDstSBLfva9zVM1n+hS8vr0Yw1jDBW1CM
         38yw==
X-Gm-Message-State: AO0yUKXoWK2w08JtaVd9ZAL4Blt3hrshiDeiUY+aw5cEEnbLi47rQ5El
        7UgRJa/9QkpPtsSbGfkVIazkPG9JFn9/9aA1
X-Google-Smtp-Source: AK7set8QUiE1A8i/At7/tA2ViCh4K1gsSmqPinzag7KKIcjaLfJId7a5LIvuwKXO2VfIC0tPQ+xjtw==
X-Received: by 2002:a17:906:19b:b0:8a9:ef2f:f349 with SMTP id 27-20020a170906019b00b008a9ef2ff349mr3434532ejb.57.1675803729009;
        Tue, 07 Feb 2023 13:02:09 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id s19-20020a170906a19300b008898c93f086sm7330674ejy.71.2023.02.07.13.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:02:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPV6N-00114H-0q;
        Tue, 07 Feb 2023 22:02:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
        "tunnel"
Date:   Tue, 07 Feb 2023 21:39:48 +0100
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
        <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
        <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
        <Y94866yd3adoC1o9@coredump.intra.peff.net>
        <230205.86ilgf7osb.gmgdl@evledraar.gmail.com>
        <Y+KYwsBjty0aaLes@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y+KYwsBjty0aaLes@coredump.intra.peff.net>
Message-ID: <230207.86fsbh2nqo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Jeff King wrote:

> On Sun, Feb 05, 2023 at 10:51:04PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > Not if they did:
>> >
>> >   [imap]
>> >   host =3D example.com
>> >   tunnel =3D some-command
>>=20
>> Yes, but how would they have ended up doing that? By discarding the
>> documentation and throwing things at the wall & hoping they'd stick?=20
>
> That's what I would have tried without reading the documentation at all,
> based on using other programs that tunnel imap. I'm just one data point,
> of course.
>
>> I just don't get how anyone could have come to rely on this so that we'd
>> care about supporting it.
>>=20
>> Because mutt has a feature that looks similar, users might have
>> configured git-imap-send thinking it might do the same thing, and gotten
>> lucky?
>
> It's less "mutt happens to do it this way" and more "associating a host
> is strictly more useful, because it lets you interact with all the other
> host-like features". It's only imap-send's funky config scheme that
> makes it easy to mis-configure.
>
>> I guess in principle that could be true, but I think it's more likely
>> that nobody's ever had reason to use it that way. I.e. if you use the
>> "tunnel" the way the docs suggest you won't hit the credential helper,
>> as you're authenticating with "ssh", and using "imapd" to directly
>> operate on a Maildir path.

*nod* I'll just note that you elided the part where I noted that I don't
really care, and will submit some re-roll that's compatible with the
current imap.{host,tunnel} interaction.

I think you might be right that people might rely on this after having
discovered this undocumented interaction by accident.

But I also think that the lack of questions about how to get imap-send's
tunnel mode to work with auth helpers (at least I couldn't find any
on-list), which is what you'd run into if you went by the documentation
& were trying to get htat ot work, is a pretty good sign that this may
be either entirely unused by anyone, or at best very obscure.

> As I said, my main use of tunneling is to trigger the imap server's
> preauth mode. But there are other reasons one might want to do so, like
> piercing a firewall. E.g.:
>
>   [imap]
>   host =3D internal.example.com
>   tunnel =3D "ssh bastion-server nc internal.example.com 143"

I'll definitely leave this out of a re-roll of this topic, but I did
come up with an opinionated replacement on top.

That commitdwhich rips out non-PREAUTH (i.e. any authentication)
support, as well as SSL support that isn't using curl from
git-imap-send.c.

Here:
https://github.com/avar/git/commit/8498089f8e5a3d050b44008a7947ef3cefe2a2dd

I.e. if we just say that we're not going to support this use-case
anymore we can get rid of all of the OpenSSL reliance in-tree, except
for the optional (and hardly ever used) OPENSSL_SHA1, and
uses-only-one-API-function "HAVE_OPENSSL_CSPRNG" use.

I.e. we'd support tunneling like this still (from the manpage):

	[imap]
		folder =3D "INBOX.Drafts"
		tunnel =3D "ssh -q -C user@example.com /usr/bin/imapd ./Maildir 2> /dev/n=
ull"

But if your use of imap.tunnel is to essentially use git-imap-send.c for
what you could use another shell (or systemd or whatever) to invoke a
"ssh" or "stunnel" command for you, we'd say too bad, just do that instead.

So your example of:

	[imap]
	host =3D internal.example.com
	tunnel =3D "ssh bastion-server nc internal.example.com 143"

Would instead be:

	1. Arrange for the equivalent of that to run outside of
	   git-imap-send, e.g.:

	    ssh -N -R 1430:internal.example.com:143 bastion-server

	2. Use "imap.host" to connect to that "remote" box with libcurl,
	   but just use "localhost:1430"

Given the obscurity of git-imap-send overall, and how trivial the
workaround is I don't think that's unreasonable, even with an aggressive
transition period.

As that commit shows we have a surprising amount of code required to
support just this one use-case (and I'm not even sure I got all of
it). Or at least:

	7 files changed, 89 insertions(+), 509 deletions(-)

With most being OpenSSL library use, so if we can find a way to not
keeping supporting that...
