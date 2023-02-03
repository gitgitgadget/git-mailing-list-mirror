Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8A9C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 21:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjBCVdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjBCVdB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 16:33:01 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2D97682
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 13:32:59 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gr7so18954330ejb.5
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 13:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d0T3DqxUNYZahbbqLrOmjmS7J0AGGfNRqVpqn3mw9Yw=;
        b=EZdZctWUA93W707JQf03kdAL5IGFxVGBa3laN6bZ6Bujxg3vCPfzhJ0Vvj5GQS6xEf
         8pl1OBPIE65apkT+jy2eWyuYDFfRHolW1nUqLo7cO1IHHDc9E5LczeIrSCsZ4uA1jA2G
         +K1fv13fEYUAypXoUwKj4Ybu1DwjQ69m31aHNbncTdn/R6O7GBQJwU0VT5qYlNg0qo6V
         0xG3XZGyOm/mqYx9ukC3J6inP1xjMcuK08LnzWJIcxq0jHxlG1iPwGcn4nO/M2sgB0ri
         np84bLjocnMXVOSO2KAcumX3QyX6Wx1K7EGywKBxEpe3qjN6p/3O1U0gPLV3Hnoos9Gy
         HeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0T3DqxUNYZahbbqLrOmjmS7J0AGGfNRqVpqn3mw9Yw=;
        b=HGgGpEiUvGWhhZ20U+EOt2s/pUpRBqqNMT5ahm91/aJWXEriDKLuo7yUlEKf6eY4xU
         kXnn/3ErkQ5S/MqfDPP3JW2YJbi5jBpuIyUyzFnJiDFm3aZCIit5IXide7Gv9VGVPSnp
         zrVOcjcE+3gRsi9sclh0O4lJNY9dN8hP8ZqtnnO9A+OEabBGGnaAX/56ebdQbGl2PD/K
         yp7b/hev+FHCd2DEPVwK5cNVeN0zJAR2pGkPaQkNFEiwsrSBLTaVGwVLO/cFReIvdgyM
         /AchDBs/ET2sDBMx8XjunLFvPc9LFzkISlwfTK/PqaV8O1G5ZD86nVJQfY/J9BFdl0oe
         WoSw==
X-Gm-Message-State: AO0yUKXbNKGsET4uVyCO58CYK1+ap17sv2QSOqYEY1g0AOaGyYXXwOv+
        p82Oi6JoKAry48qihCMwYt1cN7SaqgnLoJ6R
X-Google-Smtp-Source: AK7set8UZAos/gpjOST1XhzE9N7RHvduCY5WIC6CBErYBtM64R/ytMmTUa2dcGiocmCagP57Vj5+4Q==
X-Received: by 2002:a17:906:ee86:b0:88f:79e7:8305 with SMTP id wt6-20020a170906ee8600b0088f79e78305mr10925588ejb.63.1675459977574;
        Fri, 03 Feb 2023 13:32:57 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id bl3-20020a170906c24300b007bff9fb211fsm1926531ejb.57.2023.02.03.13.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:32:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pO3g0-000SYy-0o;
        Fri, 03 Feb 2023 22:32:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
Date:   Fri, 03 Feb 2023 22:12:27 +0100
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
        <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
Message-ID: <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 03 2023, Jeff King wrote:

> On Thu, Feb 02, 2023 at 10:44:17AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Before [1] we'd force the "imap.host" to be set, even if the
>> "imap.tunnel" was set, and then proceed to not use the "host" for
>> establishing a connection, as we'd use the tunneling command.
>>=20
>> However, we'd still use the "imap.host" if it was set as the "host"
>> field given to the credential helper, and in messages that were shared
>> with the non-tunnel mode, until a preceding commit made these OpenSSL
>> codepaths tunnel-only.
>>=20
>> Let's always give "host=3Dtunnel" to the credential helper when in the
>> "imap.tunnel" mode, and rephrase the relevant messages to indicate
>> that we're tunneling. This changes the existing behavior, but that
>> behavior was emergent and didn't make much sense. If we were using
>> "imap.tunnel" the value in "imap.host" might be entirely unrelated to
>> the host we're tunneling to. Let's not pretend to know more than we do
>> in that case.
>
> If you tunnel to two different hosts, how is the credential system
> supposed to know which is which?
>
> If you really want to distinguish connecting to $host versus tunneling
> to $host, I think you'd have to invent some new URL scheme
> (imap-tunnel:// or something).
>
> But IMHO it is not really worth it. Your statement of "the value in
> imap.host might be entirely unrelated" does not match my experience.  I
> don't use imap-send, but I've been doing imap-tunneling with various
> programs for two decades, and it's pretty normal to configure both, and
> to consider the tunnel command as an implementation detail for getting
> to the host. For example, my mutt config is like[1]:
>
>   set folder =3D imap://example.com/
>   set tunnel =3D "ssh example.com /etc/rimapd"
>
> and I expect to be able to refer to folders as imap://example.com/foo,
> etc (well, in mutt you'd use the shorthand "=3Dfoo", but the idea is the
> same). So if we see:
>
>   [imap]
>   host =3D example.com
>   tunnel =3D ssh example.com /etc/rimapd
>
> we should likewise think of it as example.com, but with an
> implementation detail of how to contact the server.

Except that mutt config is different than the imap-send case in that it
would presumably break if you changed:

	set folder =3D imap://example.com/
	set tunnel =3D "ssh example.com /etc/rimapd"

So that one of the two was example.org instead of example.com (or
whatever).

I agree that "give this to the auth helper" might be useful in general,
but our current documentation says:

	To use the tool, `imap.folder` and either `imap.tunnel` or `imap.host` mus=
t be set
	to appropriate values.

And the docs for "imap.tunnel" say "Required when imap.host is not set",
and "imap.host" says "Ignored when imap.tunnel is set, but required
otherwise".

Perhaps we should bless this as an accidental feature instead of my
proposed patch, but that's why I made this change. It seemed like an
unintentional bug that nobody intended.

Especially as you're focusing on the case where it contrary to the docs
would do what you mean, but consider (same as the doc examples, but the
domains are changed):

	[imap]
	    folder =3D "INBOX.Drafts"
	    host =3D imap://imap.bar.com
	    user =3D bob
	    pass =3D p4ssw0rd

	[imap]
	    folder =3D "INBOX.Drafts"
	    tunnel =3D "ssh -q -C user@foo.com /usr/bin/imapd ./Maildir 2> /dev/nu=
ll"
=09
I.e. I have a config for "bar.com" I tried earlier, but now I'm trying
to connect to "foo.com", because I read the docs and notice it prefers
"tunnel" to "host" I think it's going to ignore that "imap.host", but
it's going to provide the password for bar.com to foo.com if challenged.

So I think if we want to keep this it would be better to have a
imap.tunnel.credentialHost or something, to avoid conflating the two.

But I think it's okey to just remove this until someone has this
explicit use-case. I doubt that we have any users relying on this, as
it's not only undocumented, but the documentation explicitly states that
it doesn't work like this.

> Of course if you don't set imap.host, then we don't have anything useful
> to say. But as you saw, in that case imap-send will default the host
> field to the word "tunnel".

Isn't that more of a suggestion that nobody cares about this? Presumably
if we had users trying to get this to work someone would have complained
that they wanted a custom string rather than "tunnel", as the auth
helper isn't very helpful in that case...
