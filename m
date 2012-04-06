From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Fri, 6 Apr 2012 19:52:09 -0400
Message-ID: <20120406235209.GB31750@sigill.intra.peff.net>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
 <20120406201926.GA1677@sigill.intra.peff.net>
 <CAMP44s3-Ji33oG=Os_O9KpxawWzZzmiZ04QMTokQ+K6_x-31MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 01:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGIx9-0003zl-Et
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 01:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661Ab2DFXwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 19:52:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52905
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149Ab2DFXwL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 19:52:11 -0400
Received: (qmail 14026 invoked by uid 107); 6 Apr 2012 23:52:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 19:52:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 19:52:09 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3-Ji33oG=Os_O9KpxawWzZzmiZ04QMTokQ+K6_x-31MA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194926>

On Sat, Apr 07, 2012 at 02:12:22AM +0300, Felipe Contreras wrote:

> On Fri, Apr 6, 2012 at 11:19 PM, Jeff King <peff@peff.net> wrote:
>=20
> > I think you need to start with something like:
> >
> > =C2=A0#!/bin/sh
> >
> > =C2=A0if ! type bash; then
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo '1..0 # SKIP skipping bash t=
ests, bash not available'
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 0
> > =C2=A0fi
>=20
> What about this instead?
>=20
> ---
> #!/bin/sh
>=20
> if type bash >/dev/null 2>&1
> then
> 	# execute inside bash
> 	[ -z "$BASH" ] && exec bash $0
> else
> 	echo '1..0 #SKIP skipping bash completion tests; bash not available'
> 	exit 0
> fi
> ---

Yes, that's fine. It should be functionally equivalent to what I posted=
,
but without having to invoke an extra bash when we are already running
it (and avoiding the giant here-doc, though that is simply ugly and not
a functional problem).

One minor fix. I think it should be:

  exec bash $0 "$@"

to pass arguments (e.g., "-v -i") to the bash sub-process.

-Peff
