Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2992FC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF10A613BC
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345843AbhDMM6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:58:35 -0400
Received: from mail.pdinc.us ([67.90.184.27]:47734 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240296AbhDMM6c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 08:58:32 -0400
X-Greylist: delayed 2057 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Apr 2021 08:58:31 EDT
Received: from lovegrove (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id 13DCNr28031153
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Apr 2021 08:23:53 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us 13DCNr28031153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1618316634; bh=qKdhHa1yHTk1aUI0w/nvKcz72dFiofc5My0grZmCGyE=;
        h=Reply-To:From:To:References:In-Reply-To:Subject:Date:From;
        b=r7GTMaqB1Ue+4yjXfPtcwXbbry47RvXB9Hwy+ahkX/HlozBAiFqdSAwJiVCoJ+lOh
         9KMwD4kGg3fTvp6jHt/KBT2l5HzzoGIOPs5ueIQO5ioWPGoYcrB80fnR03Gu2Ke5KU
         cp35SxKv/cxdAjrI7CKFmjqvraZ5Y5tEzDmKZmS8r4vsXjaGal5jLu2A6EPzqd43nZ
         TwpNsnjLUPXScCLXThhuSHttblGhM6BOl73zpGFjbjEXw92ZKrAUhb+Nnd+nSwXuin
         WzaixKs/HRazLaLDKHwmwDOTibtch7BWSsubmlhi6X07d34hagaxYmC+B9m63pO0WN
         3OMe5diqQPjng==
Reply-To: <git@vger.kernel.org>, "Vitaly VS" <strikervitaly@gmail.com>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>, "'Vitaly VS'" <strikervitaly@gmail.com>
References: <CAEaE=iyUGiPK-HX850mEgC=X6atEhbjJ0dCK0dci0nOCahPhgQ@mail.gmail.com>
In-Reply-To: <CAEaE=iyUGiPK-HX850mEgC=X6atEhbjJ0dCK0dci0nOCahPhgQ@mail.gmail.com>
Subject: RE: Git via MITM transparent proxy with HTTPS Interception
Date:   Tue, 13 Apr 2021 08:24:04 -0400
Message-ID: <01d301d7305f$e4acdf80$ae069e80$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQDlxBwNP23Ku96GJAPzlDR02d0dDqyVNZTw
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Vitaly VS
> Sent: Tuesday, April 13, 2021 8:08 AM
>=20
> Hello! Can a Git client work properly through a MITM transparent proxy
> with HTTPS interception?

Yes, we do it all the time.

>=20
> Is there any documentation or recommendations on how to configure a
> MITM proxy with HTTPS interception for the Git work?
>=20

Not that I am aware of. It is not a Git issue per se. The WAF or Proxy =
should not (appear) to alter any of the contents of the stream (when =
allowed).

> Getting a bunch of errors when trying to "git clone =
https://SOME_REPO.git"
> On small REPOs (about 1-5 MB) there is a chance that the clone will be
> successful, but mostly I get these errors:
>=20

It is likely off-topic, but what is your proxy configuration? I have =
personally used Git through Apache and F5 MITM proxies.

> git clone https://github.com/aaptel/wireshark.git
> Cloning into 'wireshark'...
> remote: Enumerating objects: 524729, done.
> fatal: protocol error: bad line length character: ??:s00 KiB/s
> error: inflate: data stream error (invalid literal/lengths set)
> fatal: pack has bad object at offset 2093488: inflate returned -3
> fatal: index-pack failed

Enable git and curl tracing, contact your proxy team and ask for packet =
capture with decryption.

>=20
> git clone https://github.com/aaptel/wireshark.git
> Cloning into 'wireshark'...
> remote: Enumerating objects: 524729, done.
> fatal: protocol error: bad line length character: ????06 MiB/s
> error: inflate: data stream error (incorrect data check)
> fatal: pack has bad object at offset 17119052: inflate returned -3
> fatal: index-pack failed
>=20
>=20
> git clone https://github.com/aaptel/wireshark.git
> Cloning into 'wireshark'...
> remote: Enumerating objects: 524729, done.
> error: RPC failed; curl 56 Malformed encoding found in =
chunked-encoding
> fatal: the remote end hung up unexpectedly
> fatal: early EOF
> fatal: index-pack failed
>=20
> git clone https://github.com/Homebrew/brew.git
> Cloning into 'brew'...
> remote: Enumerating objects: 148, done.
> remote: Counting objects: 100% (148/148), done.
> remote: Compressing objects: 100% (80/80), done.
> Receiving objects:   3% (6247/180213), 2.64 MiB | 1005.00 KiB/s
> Receiving objects:   4% (8247/180213), 3.75 MiB | 1.00 MiB/s
> Receiving objects:   5% (9011/180213), 4.47 MiB | 1.05 MiB/s
> fatal: protocol error: bad line length character: ?V?V7 MiB/s
> error: inflate: data stream error (incorrect data check)
> fatal: pack has bad object at offset 6558416: inflate returned -3
> fatal: index-pack failed
> error: RPC failed; curl 56 Malformed encoding found in =
chunked-encoding
>=20
> git clone https://github.com/Homebrew/brew.git
> Cloning into 'brew'...
> remote: Enumerating objects: 148, done.
> remote: Counting objects: 100% (148/148), done.
> remote: Compressing objects: 100% (80/80), done.
> Receiving objects:   0% (1/180213)
> Receiving objects:   0% (687/180213), 436.01 KiB | 397.00 KiB/s
> Receiving objects:   0% (1029/180213), 548.01 KiB | 338.00 KiB/s
> Receiving objects:   1% (1803/180213), 972.01 KiB | 309.00 KiB/s
> Receiving objects:   1% (2091/180213), 1.11 MiB | 309.00 KiB/s
> Receiving objects:   2% (3605/180213), 1.82 MiB | 214.00 KiB/s
> fatal: protocol error: bad line length character: O20000 KiB/s
> fatal: pack has bad object at offset 2776352: inflate returned -5
> fatal: index-pack failed
> error: RPC failed; curl 56 Malformed encoding found in =
chunked-encoding
>=20
> P.S. We trust proxy root certificate in the system, also tried to add
> in config but no luck

That is assumed, otherwise you would not have started transferring any =
data.

[I set the reply to header, don=E2=80=99t email me directly I am on the =
list]

--
Jason Pyeron  | Architect
Contractor    |
PD Inc        |
10 w 24th St  |
Baltimore, MD |

.mil: jason.j.pyeron.ctr@mail.mil
.com: jpyeron@pdinc.us
tel : 202-741-9397



