From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 14:35:10 +0200
Message-ID: <20070603123510.GC6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070603114843.GA14336@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 14:35:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HupIm-0003S0-4R
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 14:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758779AbXFCMfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 08:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758403AbXFCMfN
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 08:35:13 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:38701 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758779AbXFCMfL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 08:35:11 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4E6165A21A
	for <git@vger.kernel.org>; Sun,  3 Jun 2007 14:35:10 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id D5C581F01B; Sun,  3 Jun 2007 14:35:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070603114843.GA14336@artemis>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48984>

On Sun, Jun 03, 2007 at 01:48:44PM +0200, Pierre Habouzit wrote:
>   Hi, I'm currently trying to think about a bug tracking system that
> would be tightly integrated with git, meaning that it would have to be
> somehow decentralized.

You may want to look at existing solutions, such as Bugs
Everywhere[1], which has is modular wrt the backend SCM (supports Arch
and Bazaar for now).

I'm not sure its storage format is extensible enough, but it at least
shows some interesting ideas.


>   I mean, the immediate idea is to have some .bugs/ directories (or
> alike). This has many good properties, e.g. for projects like the linux
> kernel with its many subsystems or driver, it would make sense to have
> per driver/subsystems/... bug packs, and move bugs from one pack to
> another would be the way of assigning bugs to different modules.

What about a requirement that .bugs/ is at the project toplevel ?  We
could then enforce that such an "assign to submodule" operation only
assigns a bug to a real git submodule.


>   The other problem I see is that at the time a bug gets reported, the
> user knows it's found at a commit say 'X'. But it could in fact have
> been generated at a commit Y, with this pattern:
> 
>   --o---o---Y---o---o---o---o---X---o---o--> master
>                      \
>                       o---o---o---o---o---o--> branch B
> 
> 
>   Sadly, the bug report has been commited at 'X', hence it does taints
> branch B. As "inserting" or "moving" 'X' commit before the branch is not
> an option as it would rewrite history, that becomes also a major no-go
> for in-tree collecting of bugs.

Maybe "commit annotations" would help here ?  I have noticed a thread
about a git-note tool, though did not open it yet - so I may be
off-track here.


> PS: What I left over, is why I wanted such a tool. Programmers tends (or
>     say I tend to, maybe I'm over-generalizing, but I seem to remember a
>     thread on the lkml where Linus was basically saying the same) to
>     hate bugzillas and such out-of-tree tool because they suck, and do
>     not really fit in the programming cycle. I'd rather see a
>     bugtracking system where the backend is in-tree, basically mboxes so
>     that you can read them easily with your favourite MUA, as well as
>     adding new comments in it the same way. It also accommodates with
>     linux-like workflows where bugs usually are sent on the lkml, a bit
>     like patches and pull requests are handled. That's the reasons why I
>     came with this idea.

I still have mixed feelings towards the idea of implementing a brand
new defect-tracking system, when there are already so many of them,
with many features already.  Eg., my initial opinion about Bugs
Everywhere was that it was not complete enough to be used in many
projects.

I tend to think it would be more productive to do any necessary
changes in widely-used bug trackers (bugzilla, mantis, rt...), and
work on glue tools, like scmbug[2].

[1] http://www.panoramicfeedback.com/opensource/
[2] http://www.mkgnu.net/?q=scmbug

(both projects listed in the wiki already -
http://git.or.cz/gitwiki/InterfacesFrontendsAndToolsWishlist)

best regards,
--
Yann.
