Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3029C211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 18:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfANSee (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 13:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfANSee (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 13:34:34 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926FE20651;
        Mon, 14 Jan 2019 18:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547490872;
        bh=Jgo8vU1k/tbHF4eu6UZWOs1zOKJBSW+9EYUVrtEJg+I=;
        h=Subject:In-Reply-To:References:To:From:Cc:Date:From;
        b=BNRLwFKMBmRkhLZNPNkl3SCGTJkoP1bYsOvF6toLgovo90H/pjHGjewEUrng4mvSn
         QmtkyoGuQok4xz7fLTNrFVYgQa0YtUf4Yjpuz+y+Nt4MENIvpmNpq7ILEVEq0Ywnir
         cyqoN6ur+uHb7x4MwwZ24dRuiJmXoo3jBBJHryP0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] userdiff: Add a builtin pattern for dts files
User-Agent: alot/0.8
In-Reply-To: <16335abe-5e7e-fd7a-25f4-373f94e176e1@gmail.com>
References: <20190111215127.57356-1-sboyd@kernel.org> <16335abe-5e7e-fd7a-25f4-373f94e176e1@gmail.com>
Content-Transfer-Encoding: 8bit
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Message-ID: <154749087173.169631.13885160480779834976@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Adrian Johnson <ajohnson@redneon.com>,
        William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
        Johannes Sixt <j6t@kdbg.org>,
        Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Date:   Mon, 14 Jan 2019 10:34:31 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoting Alban Gruin (2019-01-13 13:26:21)
> Hi Stephen,
>=20
> thank you for your patch.  I left a few comments below.
>=20
> Le 11/01/2019 =C3=A0 22:51, Stephen Boyd a =C3=A9crit=C2=A0:
> > diff --git a/userdiff.c b/userdiff.c
> > index 97007abe5b16..2bc964e11089 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -23,6 +23,15 @@ IPATTERN("ada",
> >        "[a-zA-Z][a-zA-Z0-9_]*"
> >        "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
> >        "|=3D>|\\.\\.|\\*\\*|:=3D|/=3D|>=3D|<=3D|<<|>>|<>"),
> > +PATTERNS("dts",
> > +      /* Node name (with optional label and unit address) */
> > +      "^[ \t]*((([a-zA-Z_][a-zA-Z0-9_]*: )?[a-zA-Z][a-zA-Z0-9,._+-]*(@=
[a-zA-Z0-9,._+-]+)?"
>=20
> From the spec, label and node names =E2=80=9Cshall be [between] 1 to 31
> characters in length=E2=80=9D.  It=E2=80=99s not enforced here, and I gue=
ss it=E2=80=99s not
> really git=E2=80=99s job to check for this kind of rule.  Others may disa=
gree
> with me, though.
>=20
> Should labels end with exactly one space after the colon, or can there
> be more, or none at all?

There can be any number of spaces after the colon. I can fix the regex
here to accept any amount of whitespace after the colon.

>=20
> > +      /* Reference */
> > +      "|&[a-zA-Z_][a-zA-Z0-9_]*[ \t]*)[ \t]*\\{)[ \t]*$",
>=20
> It=E2=80=99s not specified in the spec, but these lines must end with a c=
urly
> brace? =20

That isn't common but it is supported. I can change the regex to look
for a line that ends in '{' or something that isn't ';' with anything
after the node name?

> What if there is a comment after the curly brace?

There can be a comment after the curly brace or before the curly brace.
The spec allows C style /* */ type comments, in addition to C++ style //
comments. I've never really seen that happen in practice though so it's
not very common. Grepping the linux sources shows two hits:

arch/arm/boot/dts/lpc3250-ea3250.dts:&ohci /* &usbd */ {
arch/arm/boot/dts/lpc3250-phy3250.dts:&ohci /* &usbd */ {

>=20
> This pattern does not match the root node, but I guess it=E2=80=99s not
> important as most of the interesting stuff in a dts is not directly in it.

Agreed.

>=20
> > +      /* -- */
> > +      /* Property names and math operators */
> > +      "[a-zA-Z0-9,._+?#-]+"
> > +      "|[-+*/%&^|!~]"),
>=20
> There is a `%' operator here and in your tests, but it=E2=80=99s not ment=
ioned
> in the spec if I=E2=80=99m not mistaken.  Does it actually exists?

The compiler doesn't seem to complain when it's used. I can send a patch
to update the spec for this rather esoteric feature. I can also include
more tests and support for the boolean relational operators which also
seem to be supported but probably never used.

