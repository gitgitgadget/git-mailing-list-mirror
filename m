From: Jeff King <peff@peff.net>
Subject: [PATCH/RFCv2 0/2] compiling git with gcc -O3 -Wuninitialized
Date: Sat, 15 Dec 2012 12:36:21 -0500
Message-ID: <20121215173621.GA21011@sigill.intra.peff.net>
References: <20121214220903.GA18418@sigill.intra.peff.net>
 <50CC55B5.8000205@kdbg.org>
 <20121215110930.GA23727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Dec 15 18:36:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjvfG-0001zZ-66
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 18:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505Ab2LORgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 12:36:23 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55521 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057Ab2LORgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 12:36:23 -0500
Received: (qmail 22401 invoked by uid 107); 15 Dec 2012 17:37:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 15 Dec 2012 12:37:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2012 12:36:21 -0500
Content-Disposition: inline
In-Reply-To: <20121215110930.GA23727@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211536>

On Sat, Dec 15, 2012 at 06:09:30AM -0500, Jeff King wrote:

> > Does
> > 
> >   #define error(fmt, ...) (error_impl(fmt, __VA_ARGS__), -1)
> > 
> > cause problems when not used in a return statement?
> 
> Thanks, that was the cleverness I was missing.

Here it is as patches. One problem with this method is that if the
function implementation ever changes to _not_ return -1, then we get no
warning that our macro and the function implementation have diverged in
meaning.

  [1/2]: make error()'s constant return value more visible
  [2/2]: silence some -Wuninitialized false positives

These would go on top of 1/3 from the original series to make -Wall -O3
clean (I'll repost the series as a whole when it is more obvious what we
want to do).

-Peff
