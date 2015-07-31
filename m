From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 6/6] clone: add tests for cloning with empty path
Date: Fri, 31 Jul 2015 10:45:37 +0200
Message-ID: <20150731084537.GA698@pks-xps>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438185076-28870-1-git-send-email-ps@pks.im>
 <1438185076-28870-7-git-send-email-ps@pks.im>
 <CAPig+cQ5wR8xp8erAHBzEMEs62ddULrrML53GNVuuie3kd9EvA@mail.gmail.com>
 <xmqqzj2d5ejn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 10:45:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZL5wt-0001fM-8I
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 10:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbbGaIpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 04:45:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45549 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752696AbbGaIpk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2015 04:45:40 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id D983C207E8
	for <git@vger.kernel.org>; Fri, 31 Jul 2015 04:45:39 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 31 Jul 2015 04:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=tJwhu+v+CBSp3btbSoE4MH+r2Po=; b=gq0Kd
	FBGhuOJJPsbR/JClHYLA2UOr538YAoKqBuu/6kZf2Xpe5KugTXo+Iyw21j2urSUN
	lJB3pmMguvNA2J3XkKr24oHIsjT6sv2CreV6ZU61nY1JPS4p/CyCnW//ebgsmpW1
	3UzD9gDagwf9QjaD9bQNUSTtINZqF14L835RZw=
X-Sasl-enc: ZEj3BIqf+3KLc0CQ+HQJ6YYJ9uDRbN0irqAm8rx7OAmb 1438332339
Received: from localhost (p4fc5c30b.dip0.t-ipconnect.de [79.197.195.11])
	by mail.messagingengine.com (Postfix) with ESMTPA id 477B7C0001C;
	Fri, 31 Jul 2015 04:45:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqqzj2d5ejn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275041>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2015 at 05:58:04PM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
> > On Wed, Jul 29, 2015 at 11:51 AM, Patrick Steinhardt <ps@pks.im> wrote:
> >> Test behavior of `git clone` when working with an empty path
> >> component. This may be the case when cloning a file system's root
> >> directory or from a remote server's root.
> >>
> >> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> >> ---
> >> diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
> >> index 553a3f6..acfa133 100755
> >> --- a/t/t1509-root-worktree.sh
> >> +++ b/t/t1509-root-worktree.sh
> >> @@ -237,6 +237,45 @@ test_foobar_foobar
>=20
> All true, but a more interesting question is why add more to this
> test, which is known to be skipped by everybody?  The issue being
> corrected is that any "<scheme>://<user>@<pass>:<site>/" that says
> "the whole site serves a single repository" is problematic.
>=20
> Surely, file:// and ssh:// may be examples of schemes that require
> the filesystem root to be usable as the trash directory to test,
> requiring a dedicated VM (causing most people to skip t1509), but
> wouldn't "http://<user>@<pass>:<site>/" be easier to arrange to make
> the whole site serve a single repository?

Sure it would be. But unfortunately I haven't been able to get
t/lib-httpd working at my end, so that's why I then chose to
implement the tests with t1509. I agree though that the other
solution would be preferable, but I currently am not able to
provide those.

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVuzWxAAoJEBF8Z7aeq/EsVfkP/0fq26NOX6yKekjVqoaVxwQB
0Wh566G/zvs4iPhMnrheNT0oAmDAPIpIb4STxzxCNNxnxNhEeacdaNOx3RS//GZv
wQOPaAuZgSVsGcMoKa/vizWffoIqAZMVEdW9LYY89upHAwSWKv9XKJwYc5yUF4Hm
BGeTa7txZehhbW7TS9TKSKbfGSvXNv7YoZ7FuTv+n4dUtmqcNdvv7qcYc0HV6Wmk
uzfksoOHVrH08234zuAqGmkoaK7zOtULtXdIzZwjG6UQxNn4MhTQLPyQZPWX09QM
YLg4VaFTck74aCHR68P7aW4ADKVsHb///JHm8mwSy7BGHo7UMVRQlnZZePQuk+pF
PgE6oFIDOZjGb2uHJj0BpOkeQhiMNrIRh2Yd3S0NmIed4732mSfK7Kx0sDiBFg+Q
StWVQhZbOiAw38wV2hQXsCflH4cBYKuwreki08wLbhZ2hsricsSnAlKR8qgUdxHO
WbNf+toreFaxKtuRoCBG64JzhMcluEtJsJ33aH41EZqAwJejh8KUxRQssco/oDcS
khDtZyGB2nA9+Nntm1/6HsV6YGZsNxbb4KS+t02JF4ghb1+K6gWZpsGISiLt7B5P
DqSvsZmR80aMFEvSP3zGE+TbDGAqmKTCn2HfkaJh5EFQWkRVG3RVL94WpNdw91Mz
e5FHo+ywcC6J8orFFdlt
=sn1/
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
