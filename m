From: Jeff King <peff@peff.net>
Subject: Re: error 'cannot create thread' doing clone or fetch
Date: Tue, 17 May 2011 07:47:54 -0400
Message-ID: <20110517114754.GA13176@sigill.intra.peff.net>
References: <BANLkTi=p3CbQD_EzJATenGsxz5m3=KLtMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jesse Reynolds <jessedreynolds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 13:48:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMIku-00021Y-4o
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 13:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab1EQLr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 07:47:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39550
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664Ab1EQLr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 07:47:59 -0400
Received: (qmail 25507 invoked by uid 107); 17 May 2011 11:49:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 May 2011 07:49:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2011 07:47:54 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=p3CbQD_EzJATenGsxz5m3=KLtMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173795>

On Tue, May 17, 2011 at 05:52:44PM +0930, Jesse Reynolds wrote:

> I have just installed git 1.7.5 on Solaris 9, SPARC, using a package
> from sunfreeware.com. I've created a new repository with 'git init'
> and done a commit. Now I'm trying to set up a shared repository but it
> seems there is some issue preventing git from creating a thread for
> the 'sideband demultiplexer'.
> 
> First trying to do a git fetch --bare locally to create the shared
> repository fails:
> 
> $ git --bare init --shared
> Initialized empty shared Git repository in /pub/lots.git/
> $ git --bare fetch /home/jesse/src/lots master:master
> error: cannot create thread: Unknown error
> fatal: fetch-pack: unable to fork off sideband demultiplexer
> $ Broken Pipe

Weird. The only way that can happen is if pthread_create returned error,
and the value it stuffed in errno is not useful ("unknown error"). 
Offhand, I'd guess maybe something in the package build does not match
your environment very well. Can you try building git from source? If the
error persists, you could certainly get around it by defining
NO_PTHREADS then.

You could also try running it under "truss", though I doubt it is going
to turn up anything more useful than "unknown error".

> I've searched the mailing list and online and can't seem to find
> anyone else having this issue. Then again my search skills don't seem
> to be what they once used to be!

I think this is the first we've ever seen this particular issue.

-Peff
