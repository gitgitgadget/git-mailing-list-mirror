From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 08/13] credential: make relevance of http path
 configurable
Date: Sat, 10 Dec 2011 14:50:33 -0500
Message-ID: <20111210195033.GB17999@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
 <20111210103133.GH16529@sigill.intra.peff.net>
 <m3mxb0hcjs.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:50:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZSwR-000707-Sw
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 20:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585Ab1LJTug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 14:50:36 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47228
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab1LJTuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 14:50:35 -0500
Received: (qmail 17828 invoked by uid 107); 10 Dec 2011 19:57:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 14:57:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 14:50:33 -0500
Content-Disposition: inline
In-Reply-To: <m3mxb0hcjs.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186790>

On Sat, Dec 10, 2011 at 03:50:11AM -0800, Jakub Narebski wrote:

> > This is nothing you couldn't do with a clever credential
> > helper at the start of your stack, like:
> > 
> >   [credential "http://"]
> > 	helper = "!f() { grep -v ^path= ; }; f"
> > 	helper = your_real_helper
> > 
> > But doing this:
> > 
> >   [credential]
> > 	useHttpPath = false
> 
> Shouldn't this be 'usePath' or 'usePathComponent' or 'useRepositoryPath',
> etc.?  Because if^W when remote helper for Subversion is complete, you
> could have svn://svnserve.example.com/path/to/repo as an URL... which
> would be not HTTP(S).

It must be per-protocol, because paths will be relevant for some
protocols (e.g., unlocking certificates in the local filesystem).
So if anything, it would be "useNetworkPath" or something, if we wanted
to unify svn and http. But it would also be OK to have a separate flag
for http and svn, which is more flexible (and most users aren't going to
set it at all, so they won't notice).

-Peff
