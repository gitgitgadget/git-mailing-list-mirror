Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B61F1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 20:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437105AbfJPUYY (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 16:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388251AbfJPUYY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 16:24:24 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B5FF21835;
        Wed, 16 Oct 2019 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571257463;
        bh=654k4bM86cMPVbhxD+IMxc4Z4DAQA6mCjJMdgRCfKwk=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=xKlgv2aIYZ2rSMV2vshSW0PI7TjlcA8FrFs50XNIfy3Jzy08Vuk4oxt84OOnXk8kS
         soz0lBlZl1HaeSVzadyUNpMK7n18PUVVLE/6HyZ2xqxfTZ6qRLmK/BVVJ3xUDC3NjT
         doRa/y7B6bSHLRSpQUKY8a+WdJ6sf99nQHM3MuWM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ab9b0dba-5c5b-5a97-07c5-ce8344cd74cd@kdbg.org>
References: <20191004213029.145027-1-sboyd@kernel.org> <c3a054d9-2646-e440-40c5-b0aecf21e690@kdbg.org> <20191008144306.B2B0820659@mail.kernel.org> <ab9b0dba-5c5b-5a97-07c5-ce8344cd74cd@kdbg.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Adrian Johnson <ajohnson@redneon.com>,
        William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
        Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
        Junio C Hamano <gitster@pobox.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] userdiff: Fix some corner cases in dts regex
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 13:24:22 -0700
Message-Id: <20191016202423.3B5FF21835@mail.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoting Johannes Sixt (2019-10-12 05:54:00)
> Am 08.10.19 um 16:43 schrieb Stephen Boyd:
> > Quoting Johannes Sixt (2019-10-05 07:09:11)
> >> Am 04.10.19 um 23:30 schrieb Stephen Boyd:
> >>> --- /dev/null
> >>> +++ b/t/t4018/dts-nodes-multiline-prop
> >>> @@ -0,0 +1,12 @@
> >>> +/ {
> >>> +     label_1: node1@ff00 {
> >>> +             RIGHT@deadf00,4000 {
> >>> +                     multilineprop =3D <3>,
> >>> +                                     <4>;
> >>
> >> You could insert more lines to demonstrate that "<x>," on a line by
> >> itself is not picked up.
> >=20
> > Maybe I should add another test?
>=20
> This is is the _multi_line test case, right? ;) Just add one or two
> lines between the <3> and the <4> that look like common real-world cases
> to show that those lines won't be picked up. I don't think that another
> test file is required.

Ok got it!

>=20
> >>> +/ { RIGHT /* Technically just supposed to be a slash and brace */
> >>
> >> Devil's advocate here: insert ';' or '=3D' in the comment, and the line
> >> would not be picked up. Does that hurt in practice?
> >=20
> > I don't think it hurts in practice so I'd like to ignore it.
>=20
> Sure, no problem.
>=20
> >>>  PATTERNS("dts",
> >>>        "!;\n"
> >>> +      "!.*=3D.*\n"
> >>
> >> This behaves the same way as just
> >>
> >>         "!=3D\n"
> >>
> >> no?
> >>
> >=20
> > Not exactly. Properties don't always get assigned.
>=20
> I was just refering to the added line, not the combination of the two lin=
es.

Ah ok. I'll reduce the line as you suggest then. Thanks.

>=20
> But while you are speaking of it:
>=20
> > There are boolean
> > properties that can be tested for by the presence of some string with an
> > ending semi-colon, like 'this-is-true;'. If we just check for not equal
> > to a line with a semicolon and newline then we'll see boolean
> > properties. Should I add that as another test?
>=20
> I agree that a test case with a Boolean property would be great.
>=20

Alright I'll work on that and resend.

