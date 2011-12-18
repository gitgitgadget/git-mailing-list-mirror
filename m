From: Jeff King <peff@peff.net>
Subject: Re: header file at a top
Date: Sun, 18 Dec 2011 00:43:52 -0500
Message-ID: <20111218054352.GB4462@sigill.intra.peff.net>
References: <CACnwZYdSPPhLyu6Oi3k2aNzYqvmD=xDYWvCEd2ofyJSntqKdJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 18 06:44:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc9Xd-0000fv-0j
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 06:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235Ab1LRFnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 00:43:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45238
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab1LRFny (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 00:43:54 -0500
Received: (qmail 18554 invoked by uid 107); 18 Dec 2011 05:50:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 18 Dec 2011 00:50:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Dec 2011 00:43:52 -0500
Content-Disposition: inline
In-Reply-To: <CACnwZYdSPPhLyu6Oi3k2aNzYqvmD=xDYWvCEd2ofyJSntqKdJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187415>

On Sat, Dec 17, 2011 at 07:57:42PM -0200, Thiago Farina wrote:

> I don't understand why in git the .h file is not included as the first
> substantive line of the .c file.
> 
> i.e:
> 
> foo.c
> --------------------------------------------------------------------
> #include "foo.h"
> 
> /* in alphabetical order */
> #include "bar.h"
> #include "tiz.h"
> 
> Any particular reason we include the corresponding header file at some
> random position in the source file?

The first include in any git source file should be either
"git-compat-util.h", or something that includes it (usually "cache.h").
This introduces compatibility wrappers and definitions which may be used
by other headers.

After that, the next one could be "foo.h", and I do tend to like that
style (since it gives a check that foo.h has no surprising header
dependencies). But I think we simply don't bother caring about header
dependencies in git (i.e., we do have recursive includes in some places,
but we don't require them, and in practice the compiler will tell us if
a source file fails to include a depended-upon header).

-Peff
