From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-bitmaps: plug memory leak, fix allocation size for
 recent_bitmaps
Date: Mon, 18 May 2015 22:23:21 -0400
Message-ID: <20150519022321.GA29026@peff.net>
References: <555A7499.7090900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Vicent Marti <tanoku@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue May 19 04:23:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuXBq-0007Ai-0P
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 04:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbbESCXY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2015 22:23:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:60574 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751560AbbESCXY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 22:23:24 -0400
Received: (qmail 25664 invoked by uid 102); 19 May 2015 02:23:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 May 2015 21:23:24 -0500
Received: (qmail 3317 invoked by uid 107); 19 May 2015 02:23:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 May 2015 22:23:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 May 2015 22:23:21 -0400
Content-Disposition: inline
In-Reply-To: <555A7499.7090900@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269339>

On Tue, May 19, 2015 at 01:24:09AM +0200, Ren=C3=A9 Scharfe wrote:

> Use an automatic variable for recent_bitmaps, an array of pointers.
> This way we don't allocate too much and don't have to free the memory
> at the end.  The old code over-allocated because it reserved enough
> memory to store all of the structs it is only pointing to and never
> freed it.  160 64-bit pointers take up 1280 bytes, which is not too
> much to be placed on the stack.
>=20
> MAX_XOR_OFFSET is turned into a preprocessor constant to make it
> constant enough for use in an non-variable array declaration.
>=20
> Noticed-by: Stefan Beller <stefanbeller@gmail.com>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> This seems to have fallen through the cracks, or did I just miss it?

Thanks, this looks good.

I looked over the function one more time to make sure it is the functio=
n
that is wrong, and not my suggestion. :) The current code seems pretty
obviously wrong.

-Peff
