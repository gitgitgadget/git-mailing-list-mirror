Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9E62021E
	for <e@80x24.org>; Tue, 15 Nov 2016 19:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935147AbcKOTM5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 14:12:57 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:36254 "EHLO
        homiemail-a62.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932280AbcKOTM5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Nov 2016 14:12:57 -0500
Received: from homiemail-a62.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a62.g.dreamhost.com (Postfix) with ESMTP id 59AF0634085;
        Tue, 15 Nov 2016 11:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=SKo847T0xzB0RiLXD3iQUWCFUTo=; b=Umi6qckYtU
        D4w3cqngPNvu0g6BFgEOW5CXEDxtijkidyLYqCJ/DfOdwTfwAMK1i+9wOXFHUu3L
        BZKfn3LOtMNDvLRzFSFRq8AsWf7BqE5/FO+x6zsW28pJH2rOrKfSW7Py0Tr46rqH
        X57/BnGKVa3EYhsUF+TGd9SCiHMI3ddtc=
Received: from main (30-10-119.wireless.csail.mit.edu [128.30.10.119])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a62.g.dreamhost.com (Postfix) with ESMTPSA id ED53963407C;
        Tue, 15 Nov 2016 11:12:55 -0800 (PST)
Message-ID: <1479237172.2406.91.camel@mattmccutchen.net>
Subject: Re: Protecting old temporary objects being reused from concurrent
 "git gc"?
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Date:   Tue, 15 Nov 2016 14:12:52 -0500
In-Reply-To: <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net>
References: <1479219194.2406.73.camel@mattmccutchen.net>
         <20161115170634.ichqrqbhmpv2dsiw@sigill.intra.peff.net>
         <1479231184.2406.88.camel@mattmccutchen.net>
         <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2016-11-15 at 12:40 -0500, Jeff King wrote:
> On Tue, Nov 15, 2016 at 12:33:04PM -0500, Matt McCutchen wrote:
>=20
> >=20
> > On Tue, 2016-11-15 at 12:06 -0500, Jeff King wrote:
> > >=20
> > > =C2=A0- when an object write is optimized out because we already ha=
ve the
> > > =C2=A0=C2=A0=C2=A0object, git will update the mtime on the file (lo=
ose object or
> > > =C2=A0=C2=A0=C2=A0packfile) to freshen it
> >=20
> > FWIW, I am not seeing this happen when I do "git read-tree --prefix"
> > followed by "git write-tree" using the current master (3ab2281). =C2=A0=
See
> > the attached test script.
>=20
> The optimization I'm thinking about is the one from write_sha1_file(),
> which learned to freshen in 33d4221c7 (write_sha1_file: freshen existin=
g
> objects, 2014-10-15).
>=20
> I suspect the issue is that read-tree populates the cache-tree index
> extension, and then write-tree omits the object write before it even
> gets to write_sha1_file(). The solution is that it should probably be
> calling one of the freshen() functions (possibly just replacing
> has_sha1_file() with check_and_freshen(), but I haven't looked).
>=20
> I'd definitely welcome patches in this area.

Cool, it's nice to have an idea of what's going on. =C2=A0I don't think I=
'm
going to try to fix it myself though.

By the way, thanks for the fast response to my original question!

Matt
