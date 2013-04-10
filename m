From: Magnus Therning <magnus@therning.org>
Subject: Re: git-http-backend: anonymous read, authenticated write
Date: Wed, 10 Apr 2013 22:53:59 +0200
Message-ID: <20130410205359.GB2472@mteis.lan>
References: <20130409054553.GA1537@mteis.lan>
 <5164087A.3030007@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Cc: git@vger.kernel.org
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:54:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ22F-0003go-Qo
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935153Ab3DJUyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:54:23 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:37892 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760011Ab3DJUyW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:54:22 -0400
Received: by mail-la0-f52.google.com with SMTP id ej20so853888lab.25
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 13:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=fndivoJ/Oc/6fUBWs7Vk9g96UnirZaX2daGVxhe2ibs=;
        b=U8FO5IaWScIX4tVfH0QGZMlrrsPlslUS9URhKQudgNRtPVWKuwls5eFIOO8DTETa5r
         lb763xn7MHjbyKLxPSfyuP9HOJv2GnUFH1WUH+TD0H7R5VTt1Vk82Ri+yKmvX7WodJ/D
         xdyFrUMN5l4PA9dvxerBbO/JckeH1jV2pddoy6Gn6keCRf7mHUsDCc75A8TqeoZ9Wkgq
         ygMs4x0vYkxpSRn+S/aLWEziWgcX5oBw1p9DjF/Iv+kpnNNbB4fNe/fHofK+hnzlRhsj
         8TAp9UvNe5kvALuxVe+Lo/0s0rPFrQtp4PuPbE7p1pyAaKv70SVycLXKOvh2CP59iAEr
         5Whw==
X-Received: by 10.112.170.7 with SMTP id ai7mr2004018lbc.42.1365627260517;
        Wed, 10 Apr 2013 13:54:20 -0700 (PDT)
Received: from mteis.lan (92-32-222-34.tn.glocalnet.net. [92.32.222.34])
        by mx.google.com with ESMTPS id op1sm731613lbb.2.2013.04.10.13.54.18
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 13:54:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5164087A.3030007@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQn21I7XYAWkUsNQi7RNWbZpi870iqiNCND0vZjWD0qp84q3MsDGcu6aM7uwQzBF7MDVnNXJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220759>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2013 at 02:24:26PM +0200, Jakub Nar=C4=99bski wrote:
> On 09.04.2013, Magnus Therning wrote:
>=20
> > I've been trying to set up git-http-backend+lighttpd.  I've managed to
> > set up anonymous read-only access, and I then successfully configured
> > authentication for both read and write.  Then I get stuck.  The
> > man-page for git-http-backend says that the following snippet can be
> > used for Apache 2.x:
> >=20
> >     <LocationMatch "^/git/.*/git-receive-pack$">
> >         AuthType Basic
> >         AuthName "Git Access"
> >         Require group committers
> >         ...
> >     </LocationMatch>
> >=20
> > However, when I put in this match on location in my lighty config and
> > try to push I'm not asked for a password, instead I'm greeted with
> >=20
> >     % git push=20
> >     error: The requested URL returned error: 403 Forbidden while=20
> >      accessing
> http://magnus@tracsrv.local/git/foo.git/info/refs?service=3Dgit-receive-p=
ack
> >=20
> > AFAICS this means the man-page is wrong, and that I instead ought to
> > match on the "service=3Dgit-receive-pack" part.  Is that a correct
> > conclusion?
>=20
> Yes, it is.
>=20
> I have tried to do the same anonymous read and authenticated write
> in "smart HTTP" access in Apache.  There are some proposals[1],
> all I think which use mod_rewrite (as LocationMatch doesn't take
> query string into account, unfortunately), but I haven't been able
> to make it work.
>=20
> The problem is that both POST *and GET* (to get refs) must be authethicat=
ed.
>=20
> Nb. I thought that it was corrected... which git version do you use?

1.8.2 on the server, though 1.8.2.1 is available for the distro I'm
using.  The discussion you refer to took place in 2010, I doubt any
improvement has been made to this in that point release, or am I
wrong?

> [1]: http://paperlined.org/apps/git/SmartHTTP_Ubuntu.html
>=20
>=20
> In the end I have worked around this by allowing all registered users to
> read with "require valid-user" (which in my situation might be even more
> correct solution; the case being repositories for Computer Science class
> lab work), and restricting write via pre-receive hook which checks
> REMOTE_USER.

I *really* want anonymous RO access so the CI server doesn't need any
credentials.  I could of course set up git-http-backend to be served
on two different URLs, but that's just ugly ;)

Luckily I did find a working configuration, which I posted in another
email in this thread.

/M

--=20
Magnus Therning                      OpenPGP: 0xAB4DFBA4=20
email: magnus@therning.org   jabber: magnus@therning.org
twitter: magthe               http://therning.org/magnus


Perl is another example of filling a tiny, short-term need, and then
being a real problem in the longer term.
     -- Alan Kay

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iF4EAREIAAYFAlFl0WcACgkQxZ8oagHN9cGPUQD/Xncdik16kOuOh288F6V6qs4x
1QndUKSl8BdZEuhB/oIBAIm30hxaPiHJ7icyS9vZ7KlNqnLU5DE3pykDGs6KypwJ
=THt/
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
