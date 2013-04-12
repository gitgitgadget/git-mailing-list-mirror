From: "W. Trevor King" <wking@tremily.us>
Subject: Re: regression:
 "96b9e0e3 config: treat user and xdg config permission problems as errors"
 busted git-daemon
Date: Thu, 11 Apr 2013 20:57:48 -0400
Message-ID: <20130412005748.GA17116@odin.tremily.us>
References: <1365651583.19620.8.camel@marge.simpson.net>
 <20130411054207.GE27795@sigill.intra.peff.net>
 <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
 <20130411172424.GC1255@sigill.intra.peff.net>
 <20130411181103.GJ27070@google.com>
 <20130411181439.GA2820@sigill.intra.peff.net>
 <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
 <20130411200330.GA15667@odin.tremily.us>
 <7vip3shfpd.fsf@alter.siamese.dyndns.org>
 <20130411222301.GA11283@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=wRRV7LY7NUeQGEoC
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 03:58:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQTG0-00067c-Jp
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 03:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376Ab3DLB6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 21:58:24 -0400
Received: from vms173003pub.verizon.net ([206.46.173.3]:62191 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab3DLB6X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 21:58:23 -0400
X-Greylist: delayed 3604 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2013 21:58:23 EDT
Received: from odin.tremily.us ([unknown] [72.68.100.81])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ML4007YAAOC1K40@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 11 Apr 2013 19:57:55 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id B738595D9B4; Thu,
 11 Apr 2013 20:57:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1365728268; bh=ULdECg+OerelWeScv8kUouCz1mdnDllD3ogw9fzCN4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZvUFKJe8lCZBpEn0TCbj2Y4U64fuLgzHmXIPCiaovsLjUkKE9Z7H59V/cvtep0h0+
 Y5T+rJ3Y8a8QLdpAMBCps9EY9eB77vKl86EEmot16mhFlFszTYT8Of6o/OU9pWArqB
 KUooD645KqPLUxekPuDGGqhAdPEB9D/nEK+XJlr8=
Content-disposition: inline
In-reply-to: <20130411222301.GA11283@sigill.intra.peff.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220943>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2013 at 06:23:01PM -0400, Jeff King wrote:
> On Thu, Apr 11, 2013 at 03:20:46PM -0700, Junio C Hamano wrote:
> > "W. Trevor King" <wking@tremily.us> writes:
> > > The difficulty was figuring out why the daemon was dying in
> > > the first place (which involved bisection for me as well).  Maybe
> > > there could be an additional note about HOME to flesh out:
> > >
> > >   fatal: unable to access '/root/.config/git/config': Permission deni=
ed
> > >
> > > when there's an EACCES error for the per-user config?
> >=20
> > Doesn't access_or_die() say
> >=20
> >     die_errno(_("unable to access '%s'"), path);
> >=20
> > already?  I am puzzled...
>=20
> I think the point is that it could add
>=20
>   ...and I was looking in /root, because that is where your HOME points.
>   Shouldn't you be able to read your own HOME directory?
>=20
> which should make it painfully obvious to the user what is going on.

That's more or less what I had in mind.  The 1.8.1.1 release notes
just say:

 * When attempting to read the XDG-style $HOME/.config/git/config and
   finding that $HOME/.config/git is a file, we gave a wrong error
   message, instead of treating the case as "a custom config file does
   not exist there" and moving on.

without saying anything about permission problems becoming errors, or
noting that oddball HOME configurations might cause problems.  Since
the release notes are already out, a notice like this should probably
go somewhere else.  However, this is a lot of hand holding to be
printed along side the error message=E2=80=A6 Since git-daemon (or gitweb) =
is
the most likely place for this problem to crop up, maybe a note in its
(their) man pages would be a good idea?  This thread may also be
sufficient documentation, assuming good enough search engines ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRZ1wLAAoJEEUbTsx0l5OMTW0QAJKdqYx9P43e0MQIpnm8gClJ
jn6KpjQtAnDas9fAfY644GOQ7WM1jEg4cAa/1fzJoqNjk5BD/ytNW57rgVSsEKc4
Y/iVWrEX4NyqrIoCxiZH1Pw0Fk9OCB2WITZffxS1fTn0LVu1KICF0mCCykaLUF8c
p2/GfxepdNNfbCQ5XQuOKo9ArwhJQTZ0eG/MeIgWQRJg9Y27f+yefbjh+fJWj4fG
+Uv37J57y/f0BCh0bqvwhditU05MYZ3+7xv14EgidSbbNJJfRz/Ka6KvLgNnnd2v
FHk/Tw5m6gjJy0XAHy1DCYh5q9Vk6qiijhUSSX+b5+RGtpaB+Z8XuVP4PvUoeWWu
1aBvuWE/D9zaW1K8siYtd4oTLijBvFKUh7RVEoM0zyTxgppfJQQhsWFM7kTTnLFt
wh8AjsL86E7GXFWdlDjLtbWYxnneckyef1oWSB6enPtWUTpj98GfofUWSZa4AtO1
Hc8oQrQJE+x5NEol4TXiH6/AoT51tylRgsqKtJNeNzhFoSDXPCs3bltDHtHOzQqu
WSWFz4XLbNFv1OCvg2Wo1L7geh9QFOFd78S3cJxMfhEuDkM9kUhxbvwIimsGOP9l
EITbAJzXZrvNoLJ3mY8Nut5G8YDVULVT71GZn8Nti8vxZClh6UkY0klHKY/cOnSI
M+YiynpW2A8GPdD5FBc7
=9Zmp
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
