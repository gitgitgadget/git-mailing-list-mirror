From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: use free()+xcalloc() instead of
 xrealloc()+memset()
Date: Mon, 2 Jun 2014 15:42:46 -0400
Message-ID: <20140602194246.GD2510@sigill.intra.peff.net>
References: <538B0969.9080409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Vicent Marti <tanoku@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 02 21:42:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrY8C-00055o-TA
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 21:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbaFBTmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2014 15:42:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:36115 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751290AbaFBTms (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 15:42:48 -0400
Received: (qmail 5547 invoked by uid 102); 2 Jun 2014 19:42:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Jun 2014 14:42:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jun 2014 15:42:46 -0400
Content-Disposition: inline
In-Reply-To: <538B0969.9080409@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250588>

On Sun, Jun 01, 2014 at 01:07:21PM +0200, Ren=C3=A9 Scharfe wrote:

> Whenever the hash table becomes too small then its size is increased,
> the original part (and the added space) is zerod out using memset(),
> and the table is rebuilt from scratch.
>=20
> Simplify this proceess by returning the old memory using free() and
> allocating the new buffer using xcalloc(), which already clears the
> buffer for us.  That way we avoid copying the old hash table contents
> needlessly inside xrealloc().
>=20
> While at it, use the first array member with sizeof instead of a
> specific type.  The old code used uint32_t and int, while index is
> actually an array of int32_t.  Their sizes are the same basically
> everywhere, so it's not actually a problem, but the new code is
> cleaner and doesn't have to be touched should the type be changed.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

Looks good to me.

BTW, the code does git-blame to Vicent's 2834bc2 (which I also worked
on), but actually originated in 7a979d9 (Thin pack - create packfile
with missing delta base., 2006-02-19). Not that it matters, but I was
just surprised since the code you are changing did not seem familiar to
me. I guess there was just too much refactoring during the code movemen=
t
for git-blame to pass along the blame in this case.

-Peff
