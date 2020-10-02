Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97E0C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 11:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B64206E3
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 11:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="M+trmeLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbgJBLhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 07:37:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:39101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBLhd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 07:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601638645;
        bh=sd4UgSr+pxPQLaRVyNZUbBLcMcM4lnO60XrMZUJ6a3M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=M+trmeLefeMOBYJJzE+Vaw7N70IOPc9RIbZE8fMMAKQGBE7ID8gAsx+fRseFM0J2D
         04jtUXq9xZ95obgiBrTnA8W34d6qQYcshuF2HY1oiiq4xKgAGgfRXpqTJu1xk4qz8P
         obq7BnW9B9NLCM/3RdkV8RnHYsCsA1gFVOVA5oic=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.8]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1kcXP60GAn-00yyxg; Fri, 02
 Oct 2020 13:37:25 +0200
Date:   Fri, 2 Oct 2020 13:37:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 1/3] credential.c: fix credential reading with regards
 to CR/LF
In-Reply-To: <20200929004220.GC898702@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2010021011540.50@tvgsbejvaqbjf.bet>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com> <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com> <27f6400a21412d762b290a34a78ebe7296d36bf3.1601293224.git.gitgitgadget@gmail.com> <20200929004220.GC898702@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:poHg3wo/st2C7MqWtnhI8uOSaoSG++mM8Q4nPgHbRP5yttBdd2D
 YKfDSs6BCU+9+cm5NWAUjT+07DCbtvUt1x0/K5VaAK6QPRuVDFY2/uW8cAkx64zpilywxS+
 CvQBo4jldmbiZxcPIaTSlsRa/2jAcHzXPK2ORJjsRmm7NfUOFOWt6LoR4HY44zD/fL7KwOI
 rjF38No2XeAZMtc8UArRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/GQMECIObPo=:eHUHuSB8Rq1PbczooDRVxC
 Ia1hCU8+h0ATGSfdbPopXkrcdJ6BtyMy16XUgGR6B4qA6p7dmDyeeRG/SRrCNYKYwtm6hpfr/
 DXUntvoRJLOf8JN4vqxdKLgWzvTAJbxSFGVyIlTGsJKhLZzYMor5alpmW0PEFjWskCzZf3gkK
 +d+IUu++VdfM3fJ5+QEH1kGx+GsgkZpyLCtjpr17HO/RM4mEYJbbBt//+t+VT6dD+XzZwxVd1
 B3QGSLIJqU+qEOJlOaKc/rkqXxhPIE/pnGWucMsPcM6wDvs/GHzJE1AQXcbzp9KWEFydTWx+v
 XyFha89g8L3LKmjmM/G//7yy1ZwsMupxekLkNuQUo5JIbLy0++4JkW4Du+6ByBIkY0scBLeQ2
 f1hQDMD/ZtNJvyzMd6EPX7PibLNGv7+pG6SLR2RaUH3LhSFAvVUCrelr9LsR4H9/jhJk0oNX3
 Oh8qKqrecXYsAaPxVrZMSEj37Gvht0LVAbJHovX3S2QYdNopoI4E4TeGjdKMhCpAorUPl9NKP
 1svbnJejkYvPl5Y7tVWIRYlzSaUgVQ0G14+0vIebZDVhD0dWxDQmQiYTbEJZDkfvMd+3SWx/D
 KE5bDGYThWTZ2j2+QQhyIzL5ltDArRxdlBjcBg8RNfu+173bienIJLwxPS2mny+B/C67xZcEd
 eiWmqFvsIImyaZYTMaIfLKBLRQZdcynNGXeE5QMvdLU6NGld5x23CIbw6ChcTj2gxTM3TCkfe
 g9dvzNXbGqpcxTFv4mlGzT1HfGd4lhOJtIKYo1jxpw4JBNozQrH7+Kz9+mwbW/r4zQaqViff6
 O3U2r9P1vCmoSfTL22vffWFIQefp4faL8sasFNOz7HBy5JtY39PdXTuplDC0MUy3Dsp5eyVwD
 smXsrqx78vnTGe0b9upimgLy4C/eJRxrfkR9OQkRAQ3smqGIj3RIZy+H8CfHaGU8/FglNmzAB
 8dZ238uIk7509Fjbom/amvkg6+fdxuBkxKv36ZH2trSmZJ3lzFHlRxZyFMCUXzdyAyr9LVsY3
 BF+55+wiUVSC85Tfezw5s9V+r/wBeo4MyVKL6Qb1w/XcyDbLwlXeHknzG2a/DJWqZ7qZgN+W+
 bQq9wGii2RNDHeeoGLd/EZGGYWBUShkJfNPKHaZoto+dj6ZAoj2fGiEtabctfU37rS/eGYArL
 RzTVh44lCiitIAUPrMN40R6iUFL8YL9jHye5yKdxcNldJ736h7KkP26/2ZLZHgdzhEsNjqvcH
 19iscZYDg+aVxMZcVJZ554tXE6vAPry/XMSfeHg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 28 Sep 2020, Jeff King wrote:

> On Mon, Sep 28, 2020 at 11:40:22AM +0000, Nikita Leonov via GitGitGadget=
 wrote:
>
> > From: Nikita Leonov <nykyta.leonov@gmail.com>
> >
> > This fix makes using Git credentials more friendly to Windows users. I=
n
> > previous version it was unable to finish input correctly without
> > configuration changes (tested in PowerShell, CMD, Cygwin).
> >
> > We know credential filling should be finished by empty input, but the
> > current implementation does not take into account CR/LF ending, and
> > hence instead of the empty string we get '\r', which is interpreted as
> > an incorrect string.
> >
> > So this commit changes default reading function to a more Windows
> > compatible reading function.
>
> Unlike the credential-store file case, where we expect the data to be
> URL-encoded anyway (and so any true "\r" in the data would not be found
> in raw form), this means that the credential protocol can no longer
> represent "\r" at the end of a value.

Indeed.

> And we'd match "example.com\r" and "example.com" as the same (unlikely,
> since carriage returns aren't allowed in hostnames, and curl will
> complain about this). We'd also match "cert://some/path\r" and
> "cert://some/path". Or "https://example.com/path\r" and its match, if
> you have credential.useHTTPPath set.

True. It's a problem with all of those URLs that end in Carriage Returns
;-)

> That may be acceptable if it makes things more convenient. Those are all
> pretty obscure cases, and I find it hard to believe an attacker could
> hijack credentials using this (it implies that the only difference
> between their malicious url and a known-good one is a trailing CR).

Indeed.

> This part of the commit message confused me a little:
>
> > We know credential filling should be finished by empty input, but the
> > current implementation does not take into account CR/LF ending, and
> > hence instead of the empty string we get '\r', which is interpreted as
> > an incorrect string.
>
> If all we care about is the empty line, and not data lines, then we
> could do this:
>
> diff --git a/credential.c b/credential.c
> index efc29dc5e1..73143c5ed0 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -206,7 +206,7 @@ int credential_read(struct credential *c, FILE *fp)
>  		char *key =3D line.buf;
>  		char *value =3D strchr(key, '=3D');
>
> -		if (!line.len)
> +		if (!line.len || (line.len =3D=3D 1 && line.buf[0] =3D=3D '\r'))
>  			break;
>
>  		if (!value) {
>
> without impacting the ability to send raw CR in the lines with actual
> data. But I imagine that a trailing CR in all of the data would also
> cause problems.

I checked again with github.com/git-for-windows/git/pull/2516, where the
patch originally entered the public eye, but could not find any background
information.

But I would highly doubt that the empty lines were the biggest problem:
Sure, we would fail to recognize an empty line with CR/LF line endings
when reading with `strbuf_getline_lf()`, but we would totally
misunderstand the entire rest of the lines, too. For example, we would
mistake `quit\r` for an unknown command, and hence simply ignore it.

I do agree, however, that your confusion validly points out a flaw in the
commit message: the "empty line" comment is a red herring.

Therefore, I spent some time pouring over the commit message. This is my
current version:

    credential: treat CR/LF as line endings in the credential protocol

    This fix makes using Git credentials more friendly to Windows users: i=
t
    allows a credential helper to communicate using CR/LF line endings ("D=
OS
    line endings" commonly found on Windows) instead of LF-only line endin=
gs
    ("Unix line endings").

    Note that this changes the behavior a bit: if a credential helper
    produces, say, a password with a trailing Carriage Return character,
    that will now be culled even when the rest of the lines end only in Li=
ne
    Feed characters, indicating that the Carriage Return was not meant to =
be
    part of the line ending.

    In practice, it seems _very_ unlikely that something like this happens=
.
    Passwords usually need to consist of non-control characters, URLs need
    to have special characters URL-encoded, and user names, well, are name=
s.

    So let's change the credential machinery to accept both CR/LF and LF
    line endings.

    While we do this for the credential helper protocol, we do _not_ do
    adjust `git credential-cache--daemon` (which won't work on Windows,
    anyway, because it requires Unix sockets) nor `git credential-store`
    (which writes the file `~/.git-credentials` which we consider an
    implementation detail that should be opaque to the user, read: we do
    expect users _not_ to edit this file manually).

What do you think?

Ciao,
Dscho
