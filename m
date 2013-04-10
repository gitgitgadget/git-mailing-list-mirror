From: Jeff King <peff@peff.net>
Subject: Re: git-http-backend: anonymous read, authenticated write
Date: Wed, 10 Apr 2013 17:47:22 -0400
Message-ID: <20130410214722.GA6215@sigill.intra.peff.net>
References: <20130409054553.GA1537@mteis.lan>
 <20130409171247.GD21972@sigill.intra.peff.net>
 <5165DA13.8010100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Magnus Therning <magnus@therning.org>, git@vger.kernel.org
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:47:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2re-0003W2-8e
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763171Ab3DJVr3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 17:47:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39309 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab3DJVr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:47:29 -0400
Received: (qmail 8366 invoked by uid 107); 10 Apr 2013 21:49:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 17:49:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 17:47:22 -0400
Content-Disposition: inline
In-Reply-To: <5165DA13.8010100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220781>

On Wed, Apr 10, 2013 at 11:30:59PM +0200, Jakub Nar=C4=99bski wrote:

> >   1. GET $repo/info/refs?service=3Dgit-receive-pack
> >=20
> >      This makes initial contact and gets the ref information which =
push
> >      uses to decide what it is going to push. So it is read-only, a=
nd in
> >      an anonymous-read setup, does not need to be protected.
>=20
> Yes, it doesn't need to be protected, but *git-receive-pack* requires
> (or required) valid user even for above GET request for getting refs.

Right. But that is not anything receive-pack is doing; it is up to his
webserver config, which is why I asked to see it.

> >   2. POST $repo/git-receive-pack
> >=20
> >      This actually pushes up the objects and updates the refs, and
> >      must be protected.
> >=20
> > The setup listed above does work with apache; it is tested as part =
of
> > our test suite (you can see the actual config in t/lib-httpd/apache=
=2Econf).
> > So what in lighttpd is giving us the 403? Can you share your whole
> > config?
>=20
> I think I have seen a patch on git mailing list to correct this, but
> I am not sure.
>=20
> Are you sure that we test this correctly?

Perhaps you are thinking of the jk/maint-http-half-auth-push topic from
last August/September. It explicitly tests the setup from the manpage.
The relevant commits are 4c71009 (t: test http access to "half-auth"
repositories, 2012-08-27) which demonstrates the problem, and b81401c
(http: prompt for credentials on failed POST, 2012-08-27).

However, even before the fix, it never got a 403 on the GET of
info/refs. It got a 401 on the later POST, but didn't prompt for
credentials.

-Peff
