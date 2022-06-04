Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBC2C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 12:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiFDMvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 08:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiFDMvK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 08:51:10 -0400
Received: from smtp-out-5.talktalk.net (smtp-out-5.talktalk.net [62.24.135.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA98366A7
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 05:51:09 -0700 (PDT)
Received: from app-12.app.tt.ham.xion.oxcs.net ([185.74.64.161])
        by smtp.talktalk.net with SMTP
        id xTFDnA0pXoOuUxTFDnmwMa; Sat, 04 Jun 2022 13:51:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1654347068;
        bh=6tV9IJzJPAsORKqIxdb10fPkR8GNL5wB0kJ8lsXcdc0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject;
        b=RQEQfFLrxYKPquGg9GgKjPqS3FECRAeXU0n7o9AJELNbMo8+N1vahIwAwHG86x9QB
         9MHbuegRM+ZR3jmbAV2+dwlNrMUXXhMIMQKRETRzkVnQL4NxtN2Kc4o4jnh/Z2bOQ/
         4YceM6M0GLz7czmmIb4sKam8xuXG5+MfjaHBIw48=
Date:   Sat, 4 Jun 2022 13:51:07 +0100 (BST)
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Message-ID: <2064938784.539963.1654347067250@apps.talktalk.co.uk>
In-Reply-To: <0c296c0e-bbd4-57a6-1cab-3b98c3bc8927@web.de>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-01.15-b3a678d934a-20220603T183608Z-avarab@gmail.com>
 <0c296c0e-bbd4-57a6-1cab-3b98c3bc8927@web.de>
Subject: Re: [RFC PATCH 01/15] remote.c: don't dereference NULL in freeing
 loop
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev79
X-Originating-IP: 31.185.185.192
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4wfN5EB1gtDFonIWHL4fLhyJwGiPvSAAwWCw/sJ5UpCAYNg0zP+IE2oEQnHaWGbnTNwpsBsBWj0GfJ0np32rjr4B/YvWhiYqTprEDyf6qklaee0AJ1Ru0z
 Xc/bUusnlbBopI8XznvDOwRYV4XBCeiXDRi1T170Wf8G/DsK67f90rB2eMGitp5igGJoeM2BgyCqNVQC8NY8bb1+TXeZ+1nCqQQHpcpqEA31r8nvJ24Xzp+U
 HSKr/JRgHb8f+7yQ4zZvt2TnVFx4suaRBgLRrnYdmlJDIGaluo3HDOMnT6Sn9/+SKjYJx5dR2lbXoCmbYaIdIREda1ORj6YyyUgqfntXrrKQcs2U+cv6b0CJ
 YklhrKtgmCQXeFHRbUG3uIZrcnvb1avKToC4dIBQYGD+PgkteXP5Ya5ApTF492z68ACu2p8to9Z05gM0PxqvbVhjAtjJcwmuxonUGAmoBVntfRUzt1VAssUV
 x7S+BW33mJ0ixxS0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 03 June 2022 at 22:07 Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>=20
>=20
> Am 03.06.22 um 20:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> > Fix a bug in fd3cb0501e1 (remote: move static variables into
> > per-repository struct, 2021-11-17) where we'd free(remote->pushurl[i])
> > after having NULL'd out remote->pushurl. itself.
> >
> > While we're at it let's get rid of the redundant braces per the
> > CodingGuidelines, which also serves to show in the diff context that
> > we were doing a FREE_AND_NULL(remote->pushurl) afterwards too, let's
> > keep that one.
>=20
> The extended context is helping, but the brace removal makes this change
> harder to read.

Indeed, a small style fix in a larger change is one thing but here at least=
 80% of the changed lines are unrelated to the bugfix. I'm afraid my heart =
has started to sink when I see the phrase "while we're at it" in a commit m=
essage.

> [...]
> >  =09FREE_AND_NULL(remote->pushurl);
>=20
> Why set pushurl to NULL after release?  This results in an invalid state
> unless pushurl_nr und pushurl_alloc are reset to zero.  Same goes for
> the url array above -- either a simple free(3) call suffices or url_nr
> and url_alloc need to be cleared as well.

That's a good point

Best Wishes

Phillip
