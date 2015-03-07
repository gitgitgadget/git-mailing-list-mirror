From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: use strbuf for hostname info
Date: Fri, 6 Mar 2015 20:07:02 -0500
Message-ID: <20150307010702.GA8202@peff.net>
References: <54F96BF2.5000504@web.de>
 <20150306210627.GA24267@peff.net>
 <54FA4C34.6080702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 07 02:07:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU3Cw-0002z4-V7
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 02:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbbCGBHG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2015 20:07:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:57568 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756253AbbCGBHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 20:07:05 -0500
Received: (qmail 13224 invoked by uid 102); 7 Mar 2015 01:07:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Mar 2015 19:07:05 -0600
Received: (qmail 23768 invoked by uid 107); 7 Mar 2015 01:07:11 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Mar 2015 20:07:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Mar 2015 20:07:02 -0500
Content-Disposition: inline
In-Reply-To: <54FA4C34.6080702@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264982>

On Sat, Mar 07, 2015 at 01:54:12AM +0100, Ren=C3=A9 Scharfe wrote:

> >These probably want to all be strbuf_release(). Again, I doubt it
> >matters much because this is a forked daemon serving only a single
> >request (so they'll get freed by the OS soon anyway), but I think
> >freeing the memory here follows the original intent.
>=20
> Using a static strbuf means (in my mind) "don't worry about freeing,
> a memory leak won't happen anyway because we reuse allocations".
> The new code adds recycling of allocations, which I somehow expect
> in connection with static allocations where possible.  You're right
> that using strbuf_release() would match the original code more
> strictly.

I don't mind recycling allocations like this. It's just that I think in
this case it makes the code actively more confusing, because we don't
actually expect any of these allocations to be recycled, do we? We
fork+exec for each daemon connection, which should receive exactly one
`host=3D` parameter.

That being said, I don't mind it too much if the recycling stays here.

> But this block is a no-op anyway because it's the first thing we do
> to these (initially empty) variables.  That's not immediately
> obvious and should be addressed in a separate patch.

Ah, yeah, just reading the diff I thought this was cleanup, not
initialization.

-Peff
