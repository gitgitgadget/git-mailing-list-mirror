Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A670A20756
	for <e@80x24.org>; Fri, 20 Jan 2017 13:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbdATN4P (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 08:56:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752040AbdATN4O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 08:56:14 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51E0A3B470;
        Fri, 20 Jan 2017 13:56:15 +0000 (UTC)
Received: from localhost (ovpn-117-185.ams2.redhat.com [10.36.117.185])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0KDuEMt032013;
        Fri, 20 Jan 2017 08:56:14 -0500
Date:   Fri, 20 Jan 2017 13:56:12 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 1/2] grep: only add delimiter if there isn't one already
Message-ID: <20170120135612.GB17499@stefanha-x1.localdomain>
References: <20170119150347.3484-1-stefanha@redhat.com>
 <20170119150347.3484-2-stefanha@redhat.com>
 <xmqqtw8u28u1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <xmqqtw8u28u1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 20 Jan 2017 13:56:15 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 10:39:02AM -0800, Junio C Hamano wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > git-grep(1) output does not follow git's own syntax:
> >
> >   $ git grep malloc v2.9.3:
> >   v2.9.3::Makefile:       COMPAT_CFLAGS +=3D -Icompat/nedmalloc
> >   $ git show v2.9.3::Makefile
> >   fatal: Path ':Makefile' does not exist in 'v2.9.3'
> >
> > This patch avoids emitting the unnecessary ':' delimiter if the name
> > already ends with ':' or '/':
> >
> >   $ git grep malloc v2.9.3:
> >   v2.9.3:Makefile:       COMPAT_CFLAGS +=3D -Icompat/nedmalloc
> >   $ git show v2.9.3:Makefile
> >   (succeeds)
>=20
> I am mildly negative on this one.  I suspect that the above example
> is a made-up one and you might have a more compelling real-world use
> case in mind, but at least the above does not convince me.

Another trailing delimiter example:

  $ git grep malloc v2.9.3:t/
  v2.9.3:t/:test-lib.sh:  setup_malloc_check () {

After Patch 1/2:

  v2.9.3:t/test-lib.sh:  setup_malloc_check () {

> The end-user explicitly gave the extra ':' because she wanted to
> feed the tree object, not a tag that leads to the tree, for some
> reason.  I think the output should respect that and show how she
> spelled the starting point.  IOW, it is not "':' added unnecessarily
> by Git".  It is ':' added by the end-user for whatever reason.

v2.9.3::Makefile may convey that the user originally provided v2.9.3:
but is that actually useful information?  I don't see what the user will
do with this information (and they should already know since they
provided the command-line).

v2.9.3:Makefile can be copy-pasted or extracted by scripts for further
git commands.  That is useful.

Stefan

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYghb8AAoJEJykq7OBq3PI97oH/1jrGY2+PJk0/aQLh3QZBY1y
eAIFFRoqhw2Rfu/t2y6pzNegBbw28CirOng5lSldB046bo1wcwatncLJzGPMyNpE
UObUWUioavbrTCtSHfP1guBR81GrFULo9mfm2piYzXirJaxPhyVDdWmhc92EZ/Td
zSGxAQkLWYhhklcyBDa1EiDlO5jGMFK2Jpjz9lL/4ZHOycDdeWWrLKkRdhZsUlr3
6TKBlwfU6QaadYZ2RL7wmH6UELLwHcCJRJA0nyuIwDOSYf0Yyzr9BMh4/z1/uzxQ
dAV6EM25+VrAJldbWSWgARkw1Zkwck23L7PTgOLZDdFvTjH6+7HOcnwGetNf0vA=
=Dcwv
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
