From: =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>
Subject: Re: git-send-email and IPv6-only host
Date: Fri, 28 Aug 2015 13:32:59 -0400
Message-ID: <20150828173259.GS301234@dakara>
References: <20150828041119.GP301234@dakara>
 <xmqqbndr2uwi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BkCcXYe/IK2urb/q"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:33:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVNWa-0000m1-81
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 19:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbbH1RdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 13:33:07 -0400
Received: from vorash.stgraber.org ([192.99.34.219]:60244 "EHLO
	smtpout1.stgraber.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbbH1RdF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 13:33:05 -0400
Received: from dakara (unknown [IPv6:2607:f2c0:f00f:2700:b051:27a9:211e:afda])
	by smtpout01.srv.dcmtl.stgraber.net (Postfix) with ESMTPSA id 0745828F14C;
	Fri, 28 Aug 2015 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stgraber.org;
	s=smtpout1; t=1440783181;
	bh=UmDXiSkvqdx8ReX8sMwDTqHnLQIUnWdnod7QvDwXK3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfSmNnX19f6VEGT9+MDKEgvxLkY4JHUxvsVSLuctVaTvPkq2hH37Ootsx9YH+oHyx
	 ANWrT0IEQKBixkjpacpa7ObDS3drsSyVqm6QHiEPHt+/DYruIQ0PqqBMfKyjsBHI7+
	 zBdUV9UpMRCF+TjWm/TwANoxGdiFJhB/LngZQ2XI=
Content-Disposition: inline
In-Reply-To: <xmqqbndr2uwi.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276739>


--BkCcXYe/IK2urb/q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2015 at 10:19:09AM -0700, Junio C Hamano wrote:
> St=E9phane Graber <stgraber@stgraber.org> writes:
>=20
> > Hello,
> >
> > I've recently switched my home network to be IPv6-only, using NAT64 and
> > DNS64 to reach IPv4 hosts. Pretty much everything I use day to day just
> > kept on working fine, but I keep finding some small problems here and
> > there, mostly to do with perl software.
> >
> > One of those is git-send-email which isn't capable of talking to an IPv6
> > SMTP server.
> >
> > I've locally patched my git-send-email to add:
> >
> >     require Net::INET6Glue::INET_is_INET6;
> >
> > This seems to be the magic bullet for all IPv6 problems I've had with
> > perl software, though I'm not sure whether this is an acceptable fix
> > upstream as this does bring an additional dependency to git-send-email.
>=20
> I wonder what happens if you 'require' that Glue on a host that is
> not IPv6-only.
>=20
> What I am trying to get at is if what that Glue thing does is an
> acceptable thing to do in the Net::* Perl modules (e.g. Net::SMTP
> and Net::SMTP::SSL that we use), i.e., what INET6Glue does to work
> around issues in Net::* is a problem Net::* Perl modules should be
> solving for the users of these modules.
>=20
> After all, it is madness to ask all packages that use Net::*
> infrastructure, like git-send-email, to 'require' an extra module.
>=20
> Thanks.

The require is perfectly safe to do on an IPv4-only machine. My
understanding is that it basically replaces any call to gethostbyname
and hardcoded AF_INET sockets to instead using getaddrinfo and iterating
through the results, therefore covering all the socket families.

I indeed find it very weird that perl itself hasn't just done that in
the main networking module, but it's something that's been an issue for
years now (I first experimented with IPv6-only in 2010) and doesn't seem
to be improving at all.

Note that most other languages seem to have resolved that issue by now
so I'm unsure why perl appears to be lagging behind there...

St=E9phane

--BkCcXYe/IK2urb/q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV4JtLAAoJEMY4l01keS1nyiIQALYIfYOfJswzcGW7PoPgtk8y
S4rGzZgITLoaZUIaACj1qV+eDWGonADEFNEQQePhD8inwqZmedzBZip5ezZNYSVn
IXtCJMs1alwxR9h+SCKJmimjdTDfJW8T8BeiGOocSHV75W/xckf4s40blA5NCr7o
LEzsZPknV0SWGzpCHfPv/FZpratJp0ZLDu33ARgc2CZ0khDbYOYdkMGHUWbJTCL0
wInNM4ZYQNUikmgfhvJ84+mD8ld3G85Ken5YSbHLIQ375siJvTO4/mOlaYSzgFdA
CBrPauOcqRU4A7pxKLft4/mnXniWertDmrgbKcZRGMhs//ZqY7uGIxnDqv7Tb21K
2LFA89qA+H51mRN/WOKrNxbN33jLcrBr1SpcAVNwcXdvIz6nqdn0ll5DDSpw5z3O
wPtcvOdWnUoD4rA/DalPTQeIRai9GH/iXUahQ4dJ7QBA5xtOHO/TMDiioGIwV6HX
E2HI+o8oVHPc+si0kQq3YtB0KmdwzMyExVTZj4a6Ow7PM16V7jinE0QrchJPg0eO
1NwE1TaKgSppkKBlVZvoOHO8ayraz1e3a3T/49jvGspo1WV92WIhVPhItD8rZpEm
vrCSgba8Whj7vvZNlUUJc2HvX7lGmVoxGDM3IxqQd1CWsUz1Xh4D2agMbcRVXim5
ePKebTi3M6syIhhTJEv3
=8LJ4
-----END PGP SIGNATURE-----

--BkCcXYe/IK2urb/q--
