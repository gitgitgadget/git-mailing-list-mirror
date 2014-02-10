From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/13] Makefile: teach scripts to include make variables
Date: Sun, 9 Feb 2014 20:15:14 -0500
Message-ID: <20140210011511.GA12773@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
 <20140205180547.GL15218@sigill.intra.peff.net>
 <87a9e1l1jv.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Feb 10 02:15:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCfT3-0004pg-TY
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 02:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbaBJBPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 20:15:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:47701 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751996AbaBJBPR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 20:15:17 -0500
Received: (qmail 26083 invoked by uid 102); 10 Feb 2014 01:15:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (107.224.177.31)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Feb 2014 19:15:17 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Feb 2014 20:15:14 -0500
Content-Disposition: inline
In-Reply-To: <87a9e1l1jv.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241896>

On Sat, Feb 08, 2014 at 10:47:16PM +0100, Thomas Rast wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The current scheme for getting build-time variables into a
> > shell script is to munge the script with sed, and stick the
> > munged variable into a special sentinel file so that "make"
> > knows about the dependency.
> >
> > Instead, we can combine both functions by generating a shell
> > snippet with our value, and then "building" shell scripts by
> > concatenating their snippets. "make" then handles the
> > dependency automatically, and it's easy to generate tighter
> > dependencies.
> >
> > We demonstrate here by moving the "DIFF" substitution into
> > its own snippet, which lets us rebuild only the single
> > affected file when it changes.
> 
> I can't look right now *why* this happens, but this breaks
> ./t2300-cd-to-toplevel.sh --valgrind with messages like

I think it's the bug that Junio already pointed out; git-sh-setup gets
the DIFF=... snippet instead of the initial #!-line. I didn't look at
the details, but that probably screws up valgrind's symlinking, since we
no longer realize it's a shell script.

Once that bug is fixed, I'll double-check that the problem goes away.

-Peff
