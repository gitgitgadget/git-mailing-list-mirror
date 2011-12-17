From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] use struct sha1_array in diff_tree_combined()
Date: Sat, 17 Dec 2011 06:19:20 -0500
Message-ID: <20111217111920.GA24917@sigill.intra.peff.net>
References: <4EEC6BD4.4040302@lsrfire.ath.cx>
 <20111217105315.GA23935@sigill.intra.peff.net>
 <4EEC7A10.3080705@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Dec 17 12:19:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbsIb-0003a8-1o
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 12:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab1LQLTZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 06:19:25 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44822
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891Ab1LQLTX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 06:19:23 -0500
Received: (qmail 12565 invoked by uid 107); 17 Dec 2011 11:26:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 Dec 2011 06:26:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Dec 2011 06:19:20 -0500
Content-Disposition: inline
In-Reply-To: <4EEC7A10.3080705@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187379>

On Sat, Dec 17, 2011 at 12:16:32PM +0100, Ren=C3=A9 Scharfe wrote:

> >The original code is slightly more efficient, as it is able to use a
> >single malloc (because it knows the number of entries ahead of time)=
=2E
> >It probably doesn't make a difference, but we could also add a
> >sha1_array_grow() for this case.
> [...]
> We coulddo that, yes.  In the case above we have the number already,
> in the other cases we'd have to count.
>=20
> But I don't think it's worth it here.  ALLOC_GROW gives us 24 entries
> initially, which should be enough in most cases -- I'm not sure I
> want to see combined diff of that many tree.  And 24 times 20 bytes
> is small enough to not cause any memory allocation issues.

You're right.

I was blindly looking at the conversion without thinking about the
context. Of course if you have just a few items, it's going to be
irrelevant (my initial refactoring of sha1_array was to help speed up a
hundreds-of-thousands of sha1s case, so I think that put me in the
mindset of a large list).

Sorry for the noise.

-Peff
