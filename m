From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 10:41:11 -0400
Message-ID: <20090405144111.GB2076@sigill.intra.peff.net>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org> <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 16:42:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqTYd-0000bM-IU
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 16:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbZDEOlP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 10:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbZDEOlP
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 10:41:15 -0400
Received: from peff.net ([208.65.91.99]:53027 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680AbZDEOlP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 10:41:15 -0400
Received: (qmail 16111 invoked by uid 107); 5 Apr 2009 14:41:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 05 Apr 2009 10:41:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Apr 2009 10:41:11 -0400
Content-Disposition: inline
In-Reply-To: <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115668>

On Sun, Apr 05, 2009 at 12:17:32PM +0200, Sverre Rabbelier wrote:

> On Sat, Apr 4, 2009 at 22:59, Christian Couder <chriscool@tuxfamily.o=
rg> wrote:
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (lo <=3D mi && mi < hi)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("oops");
>=20
> That's going to be an official git error message? Why not make it "Th=
e
> fatal error oops has occured, press ctrl-c to lose all your work, or
> press any other key to do the same"?

=46rom my cursory reading of the code, this is a "cannot happen"
assertion (and there is one a few lines below, too):

+                               die("oops");
+                       }
+               }
+               if (18 <=3D ofs)
+                       die("cannot happen -- lo and hi are identical")=
;
+       }

I don't think we have an established style for such assertions. In
theory, users never see it, but the whole point of it being there is
that they _might_. :) One could use the "assert" macro, though I think
its output is just as cryptic to end users. I usually do

  die("BUG: <something that makes a little bit of sense to the user>");

some examples of which you can see via "git grep BUG:".

Of course, "binary search on fire?" would probably work, too.

-Peff
