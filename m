From: Jeff King <peff@peff.net>
Subject: Re: Git as a BuildRequires (packaging)
Date: Mon, 1 Dec 2008 22:09:23 -0500
Message-ID: <20081202030922.GC6804@coredump.intra.peff.net>
References: <20081202023004.GA30372@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, skvidal@fedoraproject.org
To: Josh Boyer <jwboyer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 04:10:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Lex-0004Cg-OC
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 04:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbYLBDJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 22:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbYLBDJ0
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 22:09:26 -0500
Received: from peff.net ([208.65.91.99]:4132 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459AbYLBDJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 22:09:25 -0500
Received: (qmail 8524 invoked by uid 111); 2 Dec 2008 03:09:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Dec 2008 22:09:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Dec 2008 22:09:23 -0500
Content-Disposition: inline
In-Reply-To: <20081202023004.GA30372@zod.rchland.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102117>

On Mon, Dec 01, 2008 at 09:30:04PM -0500, Josh Boyer wrote:

> Recently we've hit an issue where a new package being reviewed for
> Fedora (cgit) needs to build against the git headers.  The problem
> is that these headers aren't typically installed with the git
> package itself, and we have no git-devel subpackage either.  This
> is mostly due to the fact that from what I can tell the upstream
> git Makefile doesn't install the headers anywhere.

I don't think Linus, Junio, or anybody involved with git has _ever_
advocated using git source files as a library. The expected method for
interfacing with git is the plumbing API, which is stable and available
via the installed git programs.

That being said, I think linking with libgit.a has been discussed on the
list, and Lars took part in the discussion. So I think he is aware that
what cgit does is not officially supported, that there is no stable
library API, and that he is taking his chances.

> There are a few options here.  The first is to install the git
> headers and create a git-devel subpackage.  That seems like
> overkill, given that the git headers are generically named and
> would have to be installed to something like /usr/include/git/.

I think that is a mistake; the headers are subject to change in ways that
will break calling code, and creating a -devel package creates the
impression that it's OK to link against it.

> The second option is to create a patch file that includes all
> the needed headers and use that in the cgit package.  That is
> [...]
> The third option is to include the entire git tarball as part of
> the sources for the package.  That is pretty easily done with the
> Fedora infrastructure, but isn't exactly clean from a packaging
> standpoint.

I don't know how one is usually expected to build cgit. But yes, you are
always going to have a problem with upgrading git. I would think each
cgit release would be tested based on a particular git version. And you
should rely on cgit upstream to figure that out and just package (either
in whole or as patches, as appropriate) the upstream git headers with
it.

> So, what do the git gurus recommend?  I'm not sure if other
> distros have tackled this problem before, but some kind of
> commonality for the 'how do you package things that need to build
> against git' question would be nice.

AFAIK, cgit is the only program that behaves in this way, and it doesn't
seem to be in Debian at all. So you might be the first to deal with it.
:)

-Peff
