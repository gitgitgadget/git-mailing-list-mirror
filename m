From: Jeff King <peff@peff.net>
Subject: Re: cvsimport: trying to convert freebsd cvs to git
Date: Sun, 23 Dec 2007 22:05:51 -0500
Message-ID: <20071224030551.GA12495@sigill.intra.peff.net>
References: <20071222171801.GE15286@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Sperling <stsp@stsp.name>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Dec 24 04:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6deV-00056q-OD
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 04:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbXLXDFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 22:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbXLXDFx
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 22:05:53 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1457 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbXLXDFw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 22:05:52 -0500
Received: (qmail 19488 invoked by uid 111); 24 Dec 2007 03:05:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 23 Dec 2007 22:05:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Dec 2007 22:05:51 -0500
Content-Disposition: inline
In-Reply-To: <20071222171801.GE15286@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69201>

On Sat, Dec 22, 2007 at 06:18:01PM +0100, Miklos Vajna wrote:

> $ time git cvsimport -d `pwd`/cvs -C src.git src
> Initialized empty Git repository in /home/vmiklos/git/freebsd/src.git/.git/
> malformed revision
> fatal: refs/heads/origin: not a valid SHA1
> fatal: master: not a valid SHA1
> warning: You appear to be on a branch yet to be born.
> warning: Forcing checkout of HEAD.
> fatal: just how do you expect me to merge 0 trees?
> checkout failed: 256

I looked into this a bit more. The error is definitely coming from
cvsps. I can't even get a reasonable cvsps output for this repo
(presumably because of behind-the-scenes hackery on the RCS files).
E.g., try making a module with _just_
"src/release/Attic/MIRROR.SITES,v"; I can't even get a reasonable cvsps
output on that.

You might have better results with one of the other importers that have
been suggested, most of which are more robust in the face of CVS
oddities.

That being said, it's awful that git-cvsimport doesn't stop when cvsps
exits with an error, producing all of those meaningless errors. Patch
will follow.

-Peff
