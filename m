From: Yann Dirson <ydirson@altern.org>
Subject: Re: git-svn, tree moves, and --no-stop-on-copy
Date: Wed, 8 Mar 2006 23:15:24 +0100
Message-ID: <20060308221524.GF12638@nowhere.earth>
References: <20060307220837.GB27397@nowhere.earth> <20060308014207.GA31137@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 08 23:08:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH6pn-00085I-D4
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 23:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbWCHWIi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 17:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWCHWIi
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 17:08:38 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:52202 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932601AbWCHWIh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 17:08:37 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 8A4DE72F54;
	Wed,  8 Mar 2006 23:08:30 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FH6wH-0005Pj-2k; Wed, 08 Mar 2006 23:15:25 +0100
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20060308014207.GA31137@localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17386>

On Tue, Mar 07, 2006 at 05:42:07PM -0800, Eric Wong wrote:
> If you want full repository history for reorganized repositories,
> easiest way is to pay the price for full repository and all of its
> history.
> 
> 	git-svn init https://svn.sourceforge.net/svnroot/ufoai
> 	git-svn fetch
> 	# this puts all your branches and tags into one single big git tree.
> 
> However, the following should always work: (after the following patch,
> 
> 	GIT_SVN_ID=git-oldsvn git-svn init \
> 		https://svn.sourceforge.net/svnroot/ufoai/trunk
> 	GIT_SVN_ID=git-oldsvn git-svn fetch -r1:165
> 
> 	GIT_SVN_ID=git-newsvn git-svn init
> 		https://svn.sourceforge.net/svnroot/ufoai/ufoai/trunk
> 	GIT_SVN_ID=git-newsvn git-svn fetch \
> 		166=`git-rev-parse refs/remotes/git-oldsvn`

Thanks much for the hint - it should definitively be a good example
for the doc.

> Unfortunately, it does not, at least with svn 1.2.3...  I have a patch
> coming that should fix things for 1.1.1 (and give better 1.1.x support
> in general).  I'm not sure, but it feels like something is screwed up
> with svn 1.2.3dfsg1-3:
> 
> This works:	svn log -r1 https://svn.sourceforge.net/svnroot/ufoai/trunk

> This doesn't:	svn  co -r1 https://svn.sourceforge.net/svnroot/ufoai/trunk
> 
> But this:	svn  co -r1 https://svn.sourceforge.net/svnroot/ufoai
> will create the following structure:
> 	ufoai/{trunk,branches,tags}
> 
> I'm quite puzzled about it, as I swear I've seen it work on a different
> project recently (of course I cannot remember which :<)

Looks like svn may be looking at the current revision to find out
which path you are requesting, and that path does not exist any more.
Could look like something normal, if "svn log" complained - but the
problem may just be with "svn log".

OTOH, this does work:

 svn co -r1 https://svn.sourceforge.net/svnroot/ufoai/trunk@1


> In the face of repository reorgs, git-svn is happiest tracking partial
> history.  Or tracking the entire repository from the root.

Well, that could be a solution, if I could 1) filter out parts of the
tree I do not care about, and 2) strip the leading /whatever/trunk.
Not sure it's worth it :)


> Hopefully I've been reasonably coherent, having insomnia lately.

At least, my state of insomnia makes it look perferctly coherent :)

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
