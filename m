From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3/GSoC 3/5] git-credential-cache: put socket to
 xdg-compatible path
Date: Fri, 25 Mar 2016 13:56:35 -0400
Message-ID: <20160325175635.GB10563@sigill.intra.peff.net>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
 <1458728005-22555-3-git-send-email-huiyiqun@gmail.com>
 <20160325100041.GC8880@sigill.intra.peff.net>
 <CAKqreuzwa+ztwsF3CRb++J-iqW=_evfBQ7Q7veyYU2ydJXnpcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Your friend <pickfire@riseup.net>
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:56:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajVyU-0007lx-VL
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 18:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbcCYR4j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 13:56:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:38418 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753313AbcCYR4i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 13:56:38 -0400
Received: (qmail 4364 invoked by uid 102); 25 Mar 2016 17:56:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 13:56:38 -0400
Received: (qmail 26114 invoked by uid 107); 25 Mar 2016 17:56:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 13:56:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2016 13:56:35 -0400
Content-Disposition: inline
In-Reply-To: <CAKqreuzwa+ztwsF3CRb++J-iqW=_evfBQ7Q7veyYU2ydJXnpcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289917>

On Fri, Mar 25, 2016 at 10:28:55PM +0800, =E6=83=A0=E8=BD=B6=E7=BE=A4 w=
rote:

> >> diff --git a/credential-cache.c b/credential-cache.c
> >> index f4afdc6..40d838b 100644
> >> --- a/credential-cache.c
> >> +++ b/credential-cache.c
> >> @@ -105,7 +105,7 @@ int main(int argc, const char **argv)
> >>       op =3D argv[0];
> >>
> >>       if (!socket_path)
> >> -             socket_path =3D expand_user_path("~/.git-credential-=
cache/socket");
> >> +             socket_path =3D xdg_runtime_dir("credential-cache.so=
ck");
> >>       if (!socket_path)
> >>               die("unable to find a suitable socket path; use --so=
cket");
> >
> > We do our own mkdir and chmod in credential-cache; this should be
> > redundant with what xdg_runtime_dir() does, and can be removed, rig=
ht?
>=20
> But user may specify another path via --socket <path>, this path may =
have
> wrong permission. I'm considering how to handle this situation.

Good point, we do need to cover that case.

Perhaps the work done by xdg_runtime_dir() needs to be split into two
fucntions: one to just provide the path, and the second to securely
create a given path.

-Peff
