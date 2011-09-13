From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated
 submodules
Date: Tue, 13 Sep 2011 13:15:06 -0400
Message-ID: <20110913171506.GA32251@sigill.intra.peff.net>
References: <20110912195652.GA27850@sigill.intra.peff.net>
 <CAP8UFD3ULs9YLCaaJYGo-_A=KqO4yFy3WHJmO5b_hyRSPzA-Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-dev@github.com
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 19:15:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3WZn-0007b7-Gu
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 19:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678Ab1IMRPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Sep 2011 13:15:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45049
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997Ab1IMRPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 13:15:09 -0400
Received: (qmail 30748 invoked by uid 107); 13 Sep 2011 17:16:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 13:16:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 13:15:06 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD3ULs9YLCaaJYGo-_A=KqO4yFy3WHJmO5b_hyRSPzA-Vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181294>

On Tue, Sep 13, 2011 at 06:40:07PM +0200, Christian Couder wrote:

> > +struct argv_array {
> > + =C2=A0 =C2=A0 =C2=A0 const char **argv;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned int argc;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned int alloc;
> > +};
>=20
> But there is already such a struct in bisect.c!

Heh. I completely missed that. As I was writing it, I realized it would
be a good thing to factor out, but most of the argv builders I checked
weren't dynamic at all (they knew up front how big argv would need to b=
e
because they were copying).

As it turns out, our implementations are remarkably similar considering
I hadn't read yours. It must mean they're both obviously correct. :)

> So it would be nice if you could refactor this and the argv_array
> functions in bisect.c in the same way you refactored sha1-array.

Will do. Junio, do you want me to re-roll the quadratic fix, or just
build the refactoring on top?

-Peff
