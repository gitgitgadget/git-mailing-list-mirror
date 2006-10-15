From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git-svn and u-boot broken.
Date: Mon, 16 Oct 2006 00:09:49 +0200
Message-ID: <012b01c6f0a6$a1a636e0$1267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 00:12:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZEDJ-0005pz-44
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 00:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWJOWL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 18:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWJOWL7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 18:11:59 -0400
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:1673
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1750987AbWJOWL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 18:11:59 -0400
Received: from Jocke ([84.217.9.178]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 16 Oct 2006 00:11:54 +0200
To: "'Eric Wong'" <normalperson@yhbt.net>
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: Acbv+/c2UJaGBiLZT1q22CdlteAlrwAAOlaAACpcqFA=
In-Reply-To: 
X-OriginalArrivalTime: 15 Oct 2006 22:11:55.0022 (UTC) FILETIME=[EC8822E0:01C6F0A6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28935>

> > > Any chance you can update it with more examples?
> > > Especially one that show how one can do one big initial
> > > commit then merge your own changes on top of that?
> > 
> > Hmm.. large imports from git to svn can get confusing, and generally
> > aren't very useful on the svn side since history gets flattened.
> > So I generally don't recommend importing complete git histories into
> > svn.
> 
> Yes, that's what I am trying to avoid below. Basically I want 
> to commit to SVN the
> whole u-boot tree as one commit up to the point where I 
> started to do my changes.
> Then I want my changes per commit on top of that. However I 
> don't want to loose the
> ability to merge/pull in future updates from denx u-boot tree.
> 
> I just don't know how to do it, the script below fails when 
> it tries to 
> pull the rest of the tree. Any ideas?

I really need some advice here, if you can share some ideas that would be great.

> 
> > 
> > > Something like this
> > > REPO="file:///tmp/SVNuboot"
> > > REPO_PATH="/tmp/SVNuboot"
> > > GIT_REPO="/tmp/mygituboot"
> > > ORG_REPO="/usr/local/src/u-boot"
> > > rm -rf "$REPO_PATH"
> > > rm -rf "$GIT_REPO"
> > > svnadmin create "$REPO_PATH"
> > > svn mkdir -m "initial repo layout" "$REPO"/trunk 
> > "$REPO"/branches "$REPO"/tags
> > > mkdir -p "$GIT_REPO"
> > > cd "$GIT_REPO"
> > > git-svn init "$REPO"/trunk
> > > echo  [user] >> .git/config
> > > echo  name="jocke" >> .git/config
> > > echo  email="Joakim.Tjernlund@transmode.se" >> .git/config
> > > git-svn fetch
> > > git checkout -b svn-branch remotes/git-svn
> > > git-fetch "$ORG_REPO" tmcu2:tmcu
> > > git-branch initial-uboot f5e0d03970409feb3c77ab0107d5dece6b7d45c9
> > > git pull . initial-uboot
> > > # --squash makes one large commit.
> > > git pull --squash . initial-uboot
> > > cg-commit -m "merge up to 
> f5e0d03970409feb3c77ab0107d5dece6b7d45c9"
> > > git-svn commit -q remotes/git-svn..svn-branch
> > > git pull . tmcu # This doesn't work, I get merge conflicts
> > > git-svn commit -q remotes/git-svn..svn-branch
> > > 
> > > Anyhow, I am glad to report that after applying your patch all my
> > > problems with went away, no more Too many open file desc,  memory
> > > alloc failed or Inappropriate ioctl for device, Thanks a lot.
> > 
> > Cool, good to know.  It seems like the apply_textdelta 
> returning undef
> > was a result of memory allocation failures, then.
> 
> Or possibly the older subversion I used(1.3.2), now I am on 1.4.0 
> 
