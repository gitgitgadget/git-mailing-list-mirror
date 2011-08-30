From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: Overriding ~/.gitconfig using GIT_CONFIG
Date: Tue, 30 Aug 2011 13:13:01 +0100
Message-ID: <1314706381.5939.348.camel@rex>
References: <1313163498.14274.505.camel@rex>
	 <7vr54qmodf.fsf@alter.siamese.dyndns.org>
	 <7vmxfemnc4.fsf@alter.siamese.dyndns.org> <1313181853.14274.535.camel@rex>
	 <20110828130555.GA56765@gmail.com> <1314620166.5939.282.camel@rex>
	 <20110830031022.GA64106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Nguy?? n =?UTF-8?Q?Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, GIT Mailing-list <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 14:13:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyNCE-0003UQ-1M
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 14:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635Ab1H3MNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 08:13:32 -0400
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:52554 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485Ab1H3MNb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 08:13:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7UCDLfZ018487;
	Tue, 30 Aug 2011 13:13:21 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 15482-09; Tue, 30 Aug 2011 13:13:17 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7UCDBqh018481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Aug 2011 13:13:11 +0100
In-Reply-To: <20110830031022.GA64106@gmail.com>
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180404>

On Mon, 2011-08-29 at 20:10 -0700, David Aguilar wrote:
> On Mon, Aug 29, 2011 at 01:16:06PM +0100, Richard Purdie wrote:
> > On Sun, 2011-08-28 at 06:05 -0700, David Aguilar wrote:
> > > On Fri, Aug 12, 2011 at 09:44:13PM +0100, Richard Purdie wrote:
> > > > My problem isn't that I want to specify a specific .gitconfig file, I
> > > > just need it to ignore the one in $HOME. I'm happy for the .git/config
> > > > file to be used, in fact I need it to be.
> > > 
> > > If you're writing a tool then it should restrict itself to
> > > git's plumbing commands.  You should be able to do just about
> > > anything without needing to worry about differences in
> > > configuraiton.  Git commands almost always provide a way to
> > > override configuration through the use of flags.
> > > 
> > > The plumbing commands are listed in the main git manpage.
> > > See "Low-level commands (plumbing)" here:
> > > http://www.kernel.org/pub/software/scm/git/docs/
> > > 
> > > What is the specific problem solved by overriding the
> > > configuration?  It may be possible to solve it without needing
> > > to get too complicated.
> > 
> > I'm not sure writing my own porcelain makes sense in this case.
> 
> True...  luckily we don't have to go that far.
> 
> > The tool in question is a build system which is primarily interested in
> > building software. Sometimes the software we want to build is "bleeding
> > edge" and hence rather than download tarballs, we want to interact
> > directly with SCMs like git to obtain it.
> > 
> > The commands I'm using are the likes of "git clone" and "git fetch"
> > although we do use commands listed under the plumbing section too such
> > as ls-remote and read-tree. We do "cache" checkouts and support
> > automatically noticing changes and updating/building.
> > 
> > What I do want to be able to say is "ignore whatever the user might have
> > put in their ~/.gitconfig file" since I've open bug reports about people
> > putting things in there that break builds.
> > 
> > The fetch/clone commands do what I need, apart from being influenced by
> > userconfig so reimplementing them myself doesn't seem like a good
> > approach.
> 
> This is what we're interested in.
> 
> Do you have the specifics of exactly what in the user
> ~/.gitconfig file broke the build?
> 
> What I'm suggesting is that there's probably a way to avoid
> the user-dependent behavior by being explicit on
> the command-line.
> 
> Specifically regarding fetch -- if you're doing "git fetch"
> and relying on the configuration then we can probably come
> up with a more explicit fetch command that has an explicit
> and predictable behavior independent of the user's
> configuraiton.
> 
> Using the explicit form of the command can make the build system
> more robust.
> 
> Let us know what you're cooking, it sounds interesting.

We've gone through several iterations of this but as things stand now,
to initially clone things we're doing:

git clone --bare --mirror <url> <dir>

but if we already have some existing clone we'd update with:

git remote prune origin
git remote rm origin
git remote add --mirror origin <url>
git fetch --all -t

I have a strong suspicion that the fetch --all doesn't do us any favours
since if the user defines other remotes in their local config it will
also fetch them. We could probably change this to be "git fetch origin
-t" which would be safer however the .gitconfig file that someone
reported causing problems actually defined an origin remote. I don't
want to debate whether that is sane or not, I just want to be 100% sure
we work regardless of what the user may have defined.

For reference, the reasons for the remote commands above is to be 100%
sure that we fetch the right thing if <url> has changed, or if upstream
has deleted any branches in incompatible ways. We've tried not using any
remotes at all but that seems to bring its own set of problems as we
have seen issues with fetch not downloading everything from the upstream
repo (which is what we need since this is a cache/mirror copy). We ended
up needing to be very precise about what we wanted.

When we actually come to build something we make a referenced clone that
contains an actual checkout with the commands:

git clone -s -n <dir> <dir>
git checkout <revision>

which has the nice effect of being kind on disk space and fast :).

Or in some cases where we only want a specific subdirectory:

git read-tree <revision>:<subdir>
git checkout-index -q -f -a

which is fairly evil and leaves the tree in a nasty state but its what
some people need.

In case you're interested, the code in question is part of a tool called
bitbake and is one of several different fetcher modules:

http://git.openembedded.org/cgit.cgi/bitbake/tree/lib/bb/fetch2/git.py

So if a user has an origin remote in their .gitconfig, can we ignore it?

Cheers,

Richard

-- 
Linux Foundation
http://www.yoctoproject.org/
