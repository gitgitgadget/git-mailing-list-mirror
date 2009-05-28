From: Jeff King <peff@peff.net>
Subject: Re: Quick way to clone exactly one branch
Date: Thu, 28 May 2009 16:15:03 -0400
Message-ID: <20090528201503.GL13499@coredump.intra.peff.net>
References: <32541b130905201345h6daa84e8hb937e1e46456b3c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 22:15:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9m0X-0003y8-8d
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 22:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757394AbZE1UPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 16:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757086AbZE1UPL
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 16:15:11 -0400
Received: from peff.net ([208.65.91.99]:50213 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbZE1UPL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 16:15:11 -0400
Received: (qmail 22905 invoked by uid 107); 28 May 2009 20:15:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 16:15:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 16:15:03 -0400
Content-Disposition: inline
In-Reply-To: <32541b130905201345h6daa84e8hb937e1e46456b3c5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120222>

On Wed, May 20, 2009 at 04:45:44PM -0400, Avery Pennarun wrote:

> Is there a quick alternative to the following?
> 
>    mkdir myproj
>    cd myproj
>    git init
>    git fetch git://whatever master
>    git checkout -b master FETCH_HEAD
> 
> Basically, the above is a lot like 'git clone' but only clones the
> 'master' branch.  For really big projects with lots of junk in other
> branches, the above can save a lot of bandwidth.

No, AFAIK there isn't a simpler way to do it. But it is something people
have asked about before, so I think it would be a nice addition.

You can't even use "git remote" because it doesn't allow you to tweak
the refspecs you add. To do it "just like clone" I think you would have
to:

  git config remote.origin.url git://whatever
  git config remote.origin.fetch refs/heads/master:refs/remotes/origin/master

It would be nice if that could be:

  git remote add -b master origin git://whatever

and then make it available as:

  git clone -b master git://whatever

Multiple "-b <branch>" options would generate refspecs to pull multiple
branches. You could even allow "git clone --refspec=<whatever>", but I
don't know what you would use that much flexibility for (and at that
point, you are probably comfortable enough to write the config
yourself).

-Peff
