From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: restore getpeername(0,...) use
Date: Mon, 10 Sep 2012 10:21:00 -0400
Message-ID: <20120910142100.GB7906@sigill.intra.peff.net>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de>
 <1347124173-14460-2-git-send-email-jengelh@inai.de>
 <7v1uicuyqi.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.01.1209082119320.18369@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jan Engelhardt <jengelh@inai.de>
X-From: git-owner@vger.kernel.org Mon Sep 10 16:21:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB4rQ-0001bj-MH
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 16:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab2IJOVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 10:21:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39603 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981Ab2IJOVE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 10:21:04 -0400
Received: (qmail 28066 invoked by uid 107); 10 Sep 2012 14:21:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 10:21:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 10:21:00 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.01.1209082119320.18369@frira.zrqbmnf.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205128>

On Sat, Sep 08, 2012 at 09:20:48PM +0200, Jan Engelhardt wrote:

> On Saturday 2012-09-08 20:59, Junio C Hamano wrote:
> >> diff --git a/daemon.c b/daemon.c
> >> index 4602b46..eaf08c2 100644
> >> --- a/daemon.c
> >> +++ b/daemon.c
> >> @@ -1,3 +1,4 @@
> >> +#include <stdbool.h>
> >>  #include "cache.h"
> >>  #include "pkt-line.h"
> >>  #include "exec_cmd.h"
> >
> >Platform agnostic parts of the code that use "git-compat-util.h"
> >(users of "cache.h" are indirectly users of it) are not allowed to
> >do platform specific include like this at their beginning.
> >
> >This is the first use of stdbool.h; what do you need it for?
> 
> For the use in setenv(,,true). It was not entirely obvious in which .h 
> to add it; the most reasonable place was daemon.c itself, since the 
> other .c files do not seem to need it.

It would go in git-compat-util.h. However, it really is not needed; you
can simply pass "1" to setenv, as every other callsite in git does.

More importantly, though, is it actually portable? I thought it was
added in C99, and we try to stick to C89 to support older compilers and
systems. My copy of C99 is vague (it says only that the "bool" macro was
added via stdbool.h in C99, but nothing about the "true" and "false"
macros), and I don't have a copy of C89 handy.  Wikipedia does claim the
header wasn't standardized at all until C99:

  https://en.wikipedia.org/wiki/C_standard_library

-Peff
