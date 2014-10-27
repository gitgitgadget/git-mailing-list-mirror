From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] compat/bswap.h: Detect endianness from XL C compiler
 macros
Date: Sun, 26 Oct 2014 22:12:25 -0700
Message-ID: <20141027051225.GB2996@peff.net>
References: <87k33mag65.fsf@gmail.com>
 <20141026183815.GB18144@peff.net>
 <CAEvUa7mcJhYwivQjbWnVEXj_+fhCS+2edCFWjmEotOXKahQdww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 06:12:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xicbg-0007WT-41
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 06:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbaJ0FM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 01:12:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:33960 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751461AbaJ0FM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 01:12:28 -0400
Received: (qmail 564 invoked by uid 102); 27 Oct 2014 05:12:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Oct 2014 00:12:28 -0500
Received: (qmail 2844 invoked by uid 107); 27 Oct 2014 05:12:31 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Oct 2014 01:12:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2014 22:12:25 -0700
Content-Disposition: inline
In-Reply-To: <CAEvUa7mcJhYwivQjbWnVEXj_+fhCS+2edCFWjmEotOXKahQdww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 26, 2014 at 04:04:01PM -0400, David Michael wrote:

> I'm not 100% sure if __THW_LITTLE_ENDIAN__ will ever be defined, so
> I'd be okay with dropping those references completely.  There is a
> recent version of the compiler for little endian Linux distributions,
> but I haven't found the documentation for it.  (The product
> documentation still seems to only refer to the big endian Linux
> version.)  The compiler's macro may be redundant in this case anyway,
> since Linux systems should have <bits/endian.h> supplying that
> information.
> 
> I only used both macros for completeness; the __THW_BIG_ENDIAN__ macro
> (defined to 1 on z/OS and AIX) is what I actually needed here.  z/OS
> doesn't seem to have any other compile-time byte order indicator,
> short of testing for the OS itself.

Thanks for the explanation.

> Would you prefer the two-line patch to only test for the big endian
> macro,

I think that's OK, as long as the #else case barfs as it does now (i.e.,
doesn't silently choose little-endian).

> or maybe just test for __MVS__ to look at the OS?

If the OS's you're testing on all provide a big-endian marker like
__THW_BIG_ENDIAN__, that seems preferable to me to use, as it's more
explicit. We can deal with similar little-endian systems if and when
somebody sees one in the wild (and your explanation that it would
probably hit the Linux <bits/endian.h> check first makes sense to me).

-Peff
