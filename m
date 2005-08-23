From: Junio C Hamano <junkio@cox.net>
Subject: Re: 1dfcfbce2d643b7c7b56dc828f36ced9de2bf9f2
Date: Mon, 22 Aug 2005 18:07:18 -0700
Message-ID: <7v64tx1mwp.fsf@assigned-by-dhcp.cox.net>
References: <7vy86vf7lg.fsf@assigned-by-dhcp.cox.net>
	<43096B50.60605@de.bosch.com>
	<7vpss6bel3.fsf@assigned-by-dhcp.cox.net>
	<430988A7.60906@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 03:07:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7NGA-0006iC-PE
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 03:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbVHWBHX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 21:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVHWBHX
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 21:07:23 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64655 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750997AbVHWBHX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2005 21:07:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050823010721.IEFF17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 Aug 2005 21:07:22 -0400
To: Dirk Behme <dirk.behme@de.bosch.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dirk Behme <dirk.behme@de.bosch.com> writes:

>>>Seems to me that this breaks http update

Let's clarify one thing first.  Did you mean "git rebuilt from
the sources obtained from that seemingly-odd commit, http update
does not work anymore", or did you mean "starting from the state
my repository happened to be in, attempting to pull from the
git.git repository did not work, and the master branch head of
git.git public repository was that commit"?

First we need to make sure your git binary from last week
wednesday or thursday is recent enough.  I think you need at
least this commit:

    Author: Daniel Barkalow <barkalow@iabervon.org>
    Date:   Thu Aug 11 23:17:55 2005 -0400

        [PATCH] Also parse objects we already have

        In the case where we don't know from context what type
        an object is, but we don't have to fetch it, we need to
        parse it to determine the type before processing it.


If your git binary turns out to be recent enough, then the state
of your repository is needed to diagnose this problem.  What do
these command tell you in your git.git repository that cg-pull
from the public repository fails?

    $ git fsck-cache | grep -v '^dangling '
    $ git ls-remote --heads ./.
    $ ls .git/objects/pack

[Note to people who are interested in what I plan to do with the
 output from the above commands.  If fsck-cache reports any
 anomaly other than dangling objects, that means the repository
 before pulling is corrupt and the problem is not in http-pull.

 Otherwise, I can first make a clone of my git.git repository
 while expanding all the packs, overwrite the head references to
 what "git ls-remotes" reports for Dirk's repository, run "git
 prune" to lose objects Dirk would not have, and then try
 running git-http-pull myself.  

 What set of packs Dirk has (and does not have) is there for
 sanity checking --- if he has packs that I do not have myself,
 that means he packed his repository himself.  Which is not an
 illegal thing to do at all, and I do not think that would
 affect the operation of http-pull, it would be a good thing to
 know while digging deeper, hence the request for that
 information. ]
