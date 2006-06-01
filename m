From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (part #2)
Date: Thu, 01 Jun 2006 02:19:45 -0700
Message-ID: <7v64jli66m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 01 11:19:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FljLK-0003dK-5h
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 11:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWFAJTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 05:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWFAJTs
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 05:19:48 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:10670 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932151AbWFAJTr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 05:19:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060601091946.QCUB27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Jun 2006 05:19:46 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21107>

It's been a while since the last feature release, and I
think with the recent "many things built-in" (including the
busybox style integration) we are nearing a good time to do the
next feature release 1.4.0.

Before doing a 1.4.0-rc1, I would like to see the following
topics in the "next" branch graduate to "master":

 - re-add missing flags to format-patch.  I have resurrected
   "--signoff"; if people care about something else we dropped
   when we went built-in, please raise hand and submit patches.

 - tree-parser updates from Linus seems to be fine in the sense
   I haven't seen breakage from it; I'll push it out to "master"
   before the end of the week.  I'd like to do another round of
   update to introduce a unified tree/index/directory walker, so
   settling this down is sort of urgent.

 - http-fetch fixes from Nick, which looked obviously correct.
   I would appreciate test reports from people who saw breakages
   on this one.

 - reflog from Shawn.  Do people find this useful?  I've enabled
   reflog on "next" branch in my development repository to see
   how useful it would be for myself a few days ago, and also in
   a linux-2.6 repository I use for testing (I do not hack on
   kernel myself).  

Other topics in "next" includes:

 - read/write-tree --prefix.  This is remnant of now-vetoed
   subproject support using "bind commit".  I kept both of them
   because they could be useful independent of "bind commit",
   but I do not know how much.  I think read-tree --prefix might
   probably be more useful than write-tree --prefix, since the
   latter can be writing out the whole tree and run rev-parse
   $tree:/path/name to extract that part, but the former does
   not have an easy equivalent (you could pipe ls-tree output to
   sed and pipe that to update-cache --index-info, but that is
   crumsy). 

   I'd like to do "gitlink" based subproject support but most
   likely that needs to come after tree/index/directory walker.

 - fetch-pack client-side hack.  When your repository has more
   roots than the repository you are fetching from, the common
   commit discovery exchange between fetch-pack and upload-pack
   ends up traversing down the ancestry chain of the history the
   other end do not have.  The hack in the "next" branch is to
   give up the common commit discovery early on the client side,
   which Ralf Baechle who originally reported the problem says
   to fix the problem (<20060526154239.GA20839@linux-mips.org>);
   but the proper fix involves a bit smarter upload-pack.

   I've posted a hacky upload-pack patch:
   
	<7vfyiwi4xl.fsf@assigned-by-dhcp.cox.net>

   but I think it should really needs to be cleaned up properly.


Things that we might want to have in 1.4.0 but not even in "next"
yet include:

 - p4 importer (Sean Estabrooks) -- are people interested?

 - letting fetch-pack to ask for an arbitrary commit object the
   user obtained out of band (Eric W Biederman) -- waiting for
   updated patch.  We would need a corresponding one-liner patch
   to upload-pack when we do this.

 - using ~/.gitrc to give a fall-back default when
   $GIT_DIR/config does not have values.

 - command aliases and possibly default arguments via the
   configuration file.
