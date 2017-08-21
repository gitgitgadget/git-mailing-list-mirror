Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F57E1F667
	for <e@80x24.org>; Mon, 21 Aug 2017 07:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdHUHeW (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 03:34:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:38906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751131AbdHUHeW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 03:34:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92D18AB9B;
        Mon, 21 Aug 2017 07:34:20 +0000 (UTC)
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
To:     Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     git@vger.kernel.org
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
 <20170816083432.rgurgckch6phcul3@sigill.intra.peff.net>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <0beb0a6c-acb3-ae24-5c52-95747f74c07f@suse.de>
Date:   Mon, 21 Aug 2017 09:34:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <20170816083432.rgurgckch6phcul3@sigill.intra.peff.net>
Content-Type: multipart/mixed;
 boundary="------------9972AB0D35A1D979B14C4D01"
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------9972AB0D35A1D979B14C4D01
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



Le 16/08/2017 =C3=A0 10:34, Jeff King a =C3=A9crit=C2=A0:
> On Wed, Aug 09, 2017 at 04:43:26PM +0200, Nicolas Morey-Chaisemartin wr=
ote:
>
>> I have a few doubt on patch #2:
>> - is socketpair working on all git supported system (windows ?)
> I'm pretty sure the answer is no, after searching a bit for mingw and
> socketpair. The big question is whether we could come up with a suitabl=
e
> replacement. And that would depend on how libcurl works on Windows, I
> think (because it's going to feed whatever we give it to other syscall
> wrappers).

That's what I feared.
I'm not sure there is a portable "anonymous socket" API out there that'll=
 work...

>> - should socketpair always be used or limited to the curl over tunnel =
case ?
>>   I don't think there is too much different between an unname pipe and=
 a socketpair but I'm not sure either :)
> There's not much difference in practice. The obvious one is that
> half-duplex shutdowns require shutdown() on a socket and just close() o=
n
> the write half of a pipe. I don't know if we do that or not.
>
> I'd be inclined to leave the existing code alone, though, just because
> of the risk of regression (and because I don't think the curl and
> non-curl versions actually share that much code). But I haven't looked
> deeply, so I may be wrong.
>
It's easy enough to keep the legacy working without socketpair.

>> It appears curl do not support the PREAUTH tag.
> Too bad. IMHO preauth is the main reason to use a tunnel in the first
> place.

It shouldn't be too hard to add support for this in curl.
If it's the main usecase, it'll simply means the curl tunnelling should b=
e disabled by default for older curl (in this case, meaning every version=
 until it gets supported) versions.

Nicolas

--------------9972AB0D35A1D979B14C4D01
Content-Type: application/pgp-keys;
 name="0x801BDDB825988F64.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x801BDDB825988F64.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
I7PVDxzmX2XkkvEz9bMtStoMpse9qAsmHQ=3D=3D
=3DndjX
-----END PGP PUBLIC KEY BLOCK-----

--------------9972AB0D35A1D979B14C4D01--
