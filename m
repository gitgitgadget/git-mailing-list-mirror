From: Jeff King <peff@peff.net>
Subject: Re: Possible bug in git-completion.sh
Date: Fri, 8 Jan 2010 11:41:32 -0500
Message-ID: <20100108164132.GA6171@coredump.intra.peff.net>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:41:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTHuJ-00040k-Av
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 17:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943Ab0AHQln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 11:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753932Ab0AHQln
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 11:41:43 -0500
Received: from peff.net ([208.65.91.99]:47578 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924Ab0AHQlm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 11:41:42 -0500
Received: (qmail 17558 invoked by uid 107); 8 Jan 2010 16:46:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 08 Jan 2010 11:46:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jan 2010 11:41:32 -0500
Content-Disposition: inline
In-Reply-To: <7vr5q05z74.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136456>

On Fri, Jan 08, 2010 at 08:38:39AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Try this:
> >
> >   git init
> >   touch base-cruft
> >   mkdir subdir
> >   touch subdir/cruft
> >   echo subdir >.gitignore
> >   git status ;# shows gitignore and base-cruft
> >   git ls-files -o --exclude-standard ;# ditto
> >   cd subdir
> >   git status . ;# shows nothing, since everything in subdir is ignored
> >   git ls-files -o --exclude-standard ;# BUG: shows cruft
> >
> > Yes, ls-files operates in the subdirectory, which means it should not
> > show cruft from the root (and it does not). But it should respect
> > .gitignore directives going all the way back to the root, and it
> > doesn't.
> 
> Shouldn't the ls-files be run from the root with subdir/ as pathspec, if
> you wanted to do apples-to-apples comparison between it and status?

Well, yes, if you wanted to compare apples to apples. But actually, my
point in showing "status" at all was to note that Michael's statement
that they would be the same is wrong.

But just looking at the ls-files output, do you not agree that there is
a bug? Respecting gitignore means respecting _all_ gitignore files in
the repository, not just the subset that you happen to be in.

-Peff
