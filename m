From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [WIP PATCH 0/3] implement merge strategy for submodule
	links
Date: Sat, 12 Jun 2010 14:06:20 +0200
Message-ID: <20100612120620.GA13910@book.hvoigt.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net> <201006121212.50545.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 12 14:14:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONPba-0000JN-6G
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 14:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab0FLMGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 08:06:24 -0400
Received: from darksea.de ([83.133.111.250]:53265 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752586Ab0FLMGX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 08:06:23 -0400
Received: (qmail 10057 invoked from network); 12 Jun 2010 14:06:21 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 12 Jun 2010 14:06:21 +0200
Content-Disposition: inline
In-Reply-To: <201006121212.50545.johan@herland.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149005>

Hi,

On Sat, Jun 12, 2010 at 12:12:50PM +0200, Johan Herland wrote:
> On Friday 11 June 2010, Heiko Voigt wrote:
> > The following patch series is a work in progress. The idea is whenever
> > you need to merge two SHA1's of a submodule we search for a ref in the
> > submodule which already contains both. If one such ref exists the
> > resulting SHA1 is the one pointed at by that ref.
> 
> I appreciate the effort to improve submodule handling, but I'm not sure I 
> like this approach. Even though you try to apply it as conservatively as 
> possible, it still smells a little like trying to make Git too clever for 
> its own good.
> 
> E.g. say we have the following commit history in the submodule:
> 
>   A---B---C---D  <-- master
> 
> Now, say that your merge conflict comes from one branch updating the 
> submodule from B to C, while the other branch reverts the submodule from B 
> to A. In your proposed scheme, Git would auto-resolve the conflict to D.

You are right. I did forget to mention this in my topic letter: Both
changes need to point forward. This exact case is also tested in the
testcases and results in a merge conflict which needs to be resolved by
hand.

> This whole idea is somewhat similar to branch-tracking submodules (recently 
> discussed in another thread), except that it only applies on _merge_ in the 
> superproject, and you don't get to choose _which_ branch it's tracking. 
> That's _way_ too arbitrary for my tastes.

The difference to branch-tracking submodules is, if I understand it
correctly, that with a merge you get an explicit SHA1 which is recorded.
Whereras with branch-tracking you never know on which revision on the
tracked branch the submodule was.

Thats why I only want to search through stable branches further down. I
mean stable in the git sense that they never get rewound and of course
should contain the most stable part of development. To ease the
configuration we would default to master which we could assume as
stable. But if we want to be on the safe side we could also say that
automatic submodule merging only works when the user has configured some
stable branches.

> > Future Plans:
> > 
> >   * Only search stable branches. E.g. by default only master and
> >     */master. The stable branch list will be configurable.
> 
> What is this "stable" branch of which you speak? "Stable" is a very relative 
> concept, depending on which repo you're working in, and which branch you're 
> working on. In any case, master is often not the most stable branch in a 
> given repo. In git.git for example, maint is more stable than master. Also, 
> I have many repos where master should not be considered "stable" at all...

See above.

cheers Heiko
