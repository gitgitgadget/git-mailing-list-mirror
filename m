Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393192092F
	for <e@80x24.org>; Tue, 24 Jan 2017 09:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750763AbdAXJx4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 04:53:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbdAXJxz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 04:53:55 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com [10.5.11.28])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7108C04BD21;
        Tue, 24 Jan 2017 09:53:55 +0000 (UTC)
Received: from localhost (ovpn-116-93.ams2.redhat.com [10.36.116.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62F41BF7AC;
        Tue, 24 Jan 2017 09:53:55 +0000 (UTC)
Date:   Mon, 23 Jan 2017 13:15:51 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 1/2] grep: only add delimiter if there isn't one already
Message-ID: <20170123131551.GL29186@stefanha-x1.localdomain>
References: <20170119150347.3484-1-stefanha@redhat.com>
 <20170119150347.3484-2-stefanha@redhat.com>
 <xmqqtw8u28u1.fsf@gitster.mtv.corp.google.com>
 <20170120135612.GB17499@stefanha-x1.localdomain>
 <xmqqlgu5y4u8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/ZYM6PqDyfNytx60"
Content-Disposition: inline
In-Reply-To: <xmqqlgu5y4u8.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.74 on 10.5.11.28
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 24 Jan 2017 09:53:55 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/ZYM6PqDyfNytx60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 10:16:31AM -0800, Junio C Hamano wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > v2.9.3::Makefile may convey that the user originally provided v2.9.3:
> > but is that actually useful information?
>=20
> You are either asking a wrong question, or asking a wrong person
> (i.e. Git) the question.  The real question is why the user added a
> colon at the end, when "v2.9.3" alone would have sufficed.  What did
> the user want to get out of giving an extra colon like "v2.9.3:"?
>=20
> One answer I can think of is that it is a degenerate case of [2/2],
> i.e. if "v2.9.3:t" were an appropriate way to look in the subtree
> "t" of "v2.9.3", "v2.9.3:" would be the appropriate way to look in
> the whole tree of "v2.9.3".
>=20
> I understand, from your response to my comment in the thread for
> [2/2], that the reason why "v2.9.3:t" was used in the example was
> because you felt uncomfortable with using pathspec. =20
>=20
> That's superstition.
>=20
> My only piece of advice to folks who feel that way is to learn Git
> more and get comfortable.  You can do neat things like
>=20
>    $ git grep -e pattern rev -- t ':!t/helper/'
>=20
> that you cannot do with "rev:t", for example ;-)

Neat, thanks for showing the path exclusion syntax.  I wasn't aware of
it.

> All examples we saw so far are the ones that the user used the colon
> syntax when it is more natural to express the command without it.  I
> am hesitant to see the behaviour of the command changed to appease
> such suboptimal use cases if it requires us to discard a bit of
> information, when we haven't established it is OK to lose.
>=20
> There may be a case
>=20
>  (1) where the colon syntax is the most natural thing to use, AND
>      script reading the output that used that syntax is forced to do
>      unnecessary work because "git grep" parrots the colon
>      literally, instread of being more intelligent about it
>      (i.e. omitting or substituting with slash when the input is a
>      tree object, not a tree-ish, as discussed in the thread).
>=20
>  (2) where the colon syntax is the most natural thing, AND script
>      reading the output WANTS to see the distinction in the input
>      (remember, "git grep" can take more than one input tree).
>=20
> We haven't seen either of the above two in the discussion, so the
> discussion so far is not sufficient to support the change being
> proposed in this RFC, which requires that it is safe to assume that
> (1) is the only case where the input is a raw tree (or the input
> contains a colon) and (2) will never happen.
>=20
> So I am still mildly negative on the whole thing.

Avoiding the colon syntax avoids the whole issue for my use case.

I still think git-grep(1)'s output would be more useful if it used valid
git rev:path syntax in all cases.

--/ZYM6PqDyfNytx60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYhgIHAAoJEJykq7OBq3PIu3wH/jHgb1GhwA8dI/UtMc0oHJxV
aw174S5uCgfUuQOGVDjlAeCIdW3r6Qf+1fn1XMabcZDXvaYGgzqhjungEL2cm1Aw
RK5/QKSfVCPts2nQtrkesYJgSZDq1a/GaQ26ErrQeeFvDqIkWmYbpoQLDwCc9O6a
OBJFD271rFaz4OILfy1ApY+C+cNRwP9ljTmmEDXIoFUfSj22ogXoAJVW+A3pOvY/
K7p7FYR06FbaRC3gSWpb6Itdx1cfioUYeSygtj0XhxhTMxjj08qUSldeid6xxum6
ptxydd722N/hg0uCgLzL2SzyVXksj+WtZr0inVN/ZLk359BIJZDdbMsyHYguPoo=
=WYj0
-----END PGP SIGNATURE-----

--/ZYM6PqDyfNytx60--
