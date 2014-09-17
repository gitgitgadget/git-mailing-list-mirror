From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] add macro REALLOCARRAY
Date: Wed, 17 Sep 2014 04:17:54 -0400
Message-ID: <20140917081753.GC16200@peff.net>
References: <5415C89C.4090509@web.de>
 <xmqqtx487nej.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 10:18:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUARA-0006qB-Mr
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 10:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbaIQIR6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2014 04:17:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:49387 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751849AbaIQIR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 04:17:56 -0400
Received: (qmail 30633 invoked by uid 102); 17 Sep 2014 08:17:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Sep 2014 03:17:56 -0500
Received: (qmail 10518 invoked by uid 107); 17 Sep 2014 08:18:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Sep 2014 04:18:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Sep 2014 04:17:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtx487nej.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257217>

On Mon, Sep 15, 2014 at 11:24:04AM -0700, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
> > The macro ALLOC_GROW manages several aspects of dynamic memory
> > allocations for arrays: It performs overprovisioning in order to av=
oid
> > reallocations in future calls, updates the allocation size variable=
,
> > multiplies the item size and thus allows users to simply specify th=
e
> > item count, performs the reallocation and updates the array pointer=
=2E
> >
> > Sometimes this is too much.  Add the macro REALLOCARRAY, which only
> > takes care of the latter three points and allows users to specify t=
he
> > number of items an array can store directly.  It can increase and
> > also decrease its size.  Using this macro avoids duplicating the
> > array pointer name and takes care of item sizes automatically.
> >
> > Signed-off-by: Rene Scharfe <l.s.r@web.de>
> > ---
>=20
> Makes sense.  Originally I had two minor gripes against this
>=20
>  #1 a macro that modifies its arguments feels a bit too magical, and
>     we would not want to overuse them.

This is probably getting into the too-magical territory, but I have lon=
g
considered a macro like:

  #define ALLOC(x) (x) =3D xmalloc(sizeof(*x))

to prevent obvious size-mismatch errors.  You could even call the macro
NEW() if you wanted to be really disgusting. :)

I rejected it as probably too cutesy (and non-idiomatic for experienced
C programmers), but I feel like this REALLOC_ARRAY is basically the sam=
e
thing. I dunno. It does make the code a bit more readable, once you
understand what the macro is doing.

-Peff
