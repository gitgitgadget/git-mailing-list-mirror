From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Wed, 6 Feb 2013 19:16:36 -0500
Message-ID: <20130207001635.GA29318@sigill.intra.peff.net>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu>
 <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu>
 <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
 <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 <7vmwvh9e3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 01:17:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3FAk-0001ZT-3H
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 01:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758557Ab3BGAQj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2013 19:16:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37304 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758173Ab3BGAQj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 19:16:39 -0500
Received: (qmail 12717 invoked by uid 107); 7 Feb 2013 00:18:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 19:18:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 19:16:36 -0500
Content-Disposition: inline
In-Reply-To: <7vmwvh9e3p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215669>

On Wed, Feb 06, 2013 at 04:12:10PM -0800, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> > I think there's a simpler way to do this, which is that:
> >
> >  * New clients supporting v2 of the protocol send some piece of dat=
a
> >    that would break old servers.
> >
> >  * If that fails the new client goes "oh jeeze, I guess it's an old
> >    server", and try again with the old protocol.
> >
> >  * The client then saves a date (or the version the server gave us)
> >    indicating that it tried the new protocol on that remote, tries
> >    again sometime later.
>=20
> For that to work, the new server needs to wait for the client to
> speak first.  How would that server handle old clients who expect to
> be spoken first?  Wait with a read timeout (no timeout is the right
> timeout for everybody)?

If the new client can handle the old-style server's response, then the
server can start blasting out refs (optionally after a timeout) and sto=
p
when the client interrupts with "hey, wait, I can speak the new
protocol". The server just has to include "you can interrupt me" in its
capability advertisement (obviously it would have to send out at least
the first ref with the capabilities before the timeout).

-Peff
