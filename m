From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Support projects including other projects
Date: Wed, 11 May 2005 23:28:46 -0700
Message-ID: <7v8y2lj6u9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505120147100.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 08:21:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW74M-0002QD-C5
	for gcvg-git@gmane.org; Thu, 12 May 2005 08:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVELG2w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 02:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVELG2w
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 02:28:52 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:65505 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261197AbVELG2t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 02:28:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512062847.RKPD550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 02:28:47 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505120147100.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Thu, 12 May 2005 02:04:43 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> My reasons for having it in the core are as follows:

DB>  - All of the porcelain layers have to, at least, agree as
DB>  to how this is represented in order for repositories to be
DB>  portable; since the representation is common, it might as
DB>  well be core.

That is weak.  .git/refs/heads/master is not core, but something
Porcelain need to agree on [*1*].

DB>  - There are currently no special files which are tracked for cogito (et 
DB>    al) to put the information in.

I am somewhat sympathetic to this, but then there are probably
lot other things that are more relevant than this "required
version" thing.  One thing that immediately comes to mind is the
dontdiff list.  Also, if you consider Cogito and GIT independent
projects as you said, you would probably need to have "require
{project-name} {commit-id}", not "include {commit-id}".  Things
start smelling much more like the traditional package version
matching issue which is outside of SCM (let alone core GIT).

DB>  - Ideally, the dependancy would only be per-commit, not
DB>  per-tree; if Petr releases a new cogito which only merges a
DB>  new mainline with the git-pb, the cogito tree object should
DB>  be the same (since the cogito content didn't change). This
DB>  means that it can't be anywhere other than the commit.

As I already said, I consider the current "overlayed" directory
structure broken and not worth considering the toolset support
[*2*].

DB>  - If the solution to the issue of finding the necessary
DB>  git-pb is to store it with cogito, then the programs that
DB>  pull from this repository need to know that they need to
DB>  pull the git-pb portion, and fsck-cache needs to know that
DB>  the cogito references the git-pb.

I do not think this is necessary for the same reason as I
dismissed the third point above.

[Footnotes]

*1* I consider git-pull-script one example of Porcelain, JIT
knows about it as well.

*2* "Broken" is probably a too strong word here.  I know Petr
did it that way because it was the simplest way to start, and I
started the same way when I started JIT, until I realized
separating the core and treating the core as something I can
borrow from the neighbouring directory is much easier to manage.
I think Petr knows this, and I further think that is why he
started git-pb.

