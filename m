Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013A3C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D2223B16
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbhAVWDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:03:48 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:34278 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730757AbhAVWDR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 17:03:17 -0500
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10MM2TG1022502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jan 2021 17:02:29 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10MM2TG1022502
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611352949; bh=qoAVdm+5qm+8VBGIB+cY1xf3p9Qoqsx/L9JEPZfB/Kk=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=SgwsS5J103HOGmFG06+kxwJiQzT15n0YlBAj0vuOeiC4NWZFvmnX8mA6UdxIPSq3+
         4dwNCtygFXYDymN22fuAwbK7/q8R8H+uOJypQaQJvncuPhJpbQgnOUJh8bL7FRxcnY
         n/9XHVASQCAAwK8Y3GyU6DFnYeYgoTQpzCg2k94ZvEd2keKqnkK9rgl2WaCJglznOq
         bElsOpFjqI8xvMglVeFqLgTUwa9puVeS23PEodynPtNMefHPmRdZcInQWXSSA9ufI+
         tjhA08pAXF/E52378lD3U5ip4jet67nPlccodDEt/O+aUOywsoRYyJmTDOIHIv7VCo
         j6ZQACWV7C9Ng==
Reply-To: <git@vger.kernel.org>,
          "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>,
          =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Konstantin Ryabitsev'" <konstantin@linuxfoundation.org>,
        "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>
References: <043f01d6f0fe$d6ad7660$84086320$@pdinc.us> <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de> <20210122213954.7dlnnpngjoay3oia@chatter.i7.local>
In-Reply-To: <20210122213954.7dlnnpngjoay3oia@chatter.i7.local>
Subject: RE: git archive setting user and group
Date:   Fri, 22 Jan 2021 17:02:39 -0500
Organization: PD Inc
Message-ID: <048e01d6f10a$4d4da730$e7e8f590$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHBx3N2zV0SHJfdC165O07jxI29BQN7dRGLAfXW232qMvqysA==
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Konstantin Ryabitsev
> Sent: Friday, January 22, 2021 4:40 PM
> Subject: Re: git archive setting user and group
>=20
> On Fri, Jan 22, 2021 at 10:00:04PM +0100, Ren=C3=A9 Scharfe wrote:
> > Adding support for using a custom user and group should be easy.  Is
> > this just a cosmetic thing?  Regular users would ignore the user =
info in
> > the archive, and root should not be used for extracting, and on =
systems
> > that don't have a logwatch user this wouldn't make a difference =
anyway,
> > right?
>=20
> Right now, "git archive" operations are bit-for-bit identical across =
all
> versions going back at least 8+ years. In fact, we've been relying on =
this to
> support bundling tarball signatures with git tags themselves (via git =
notes).
> E.g. you can see this in action here:
> =
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tag/?h=3D=
v5.10.9
>=20
> If you click on "(sig)", you will download a signature that can be =
used to
> verify the tarball generated using "git archive".
>=20
> I would argue that adding user/group support to "git archive" =
operation is
> not really solving any problems other than "it's different from when I =
run it
> as a regular user" -- and can introduce potential compatibility =
problems if

Being pedantic here, it is different than when I run it as any user - =
including root.

Don=E2=80=99t confuse tar x with tar c.

tar c captures the current owner of the files, or allows override with a =
single user / map file.

> implemented.
>=20
> So, I would selfishly vote not to implement this.
>=20
> -K

