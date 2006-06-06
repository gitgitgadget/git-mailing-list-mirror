From: Junio C Hamano <junkio@cox.net>
Subject: New release?
Date: Mon, 05 Jun 2006 23:02:21 -0700
Message-ID: <7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 08:02:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnUe1-0005nb-St
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 08:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWFFGCX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 02:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWFFGCX
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 02:02:23 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:9614 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932120AbWFFGCW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 02:02:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606060222.RHWS27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 02:02:22 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21364>

The "next" queue has been shrinking, and nothing is going to
"maint" branch, which can mean only one thing ;-).

The last issue of "What's in" talked about 1.4.0-rc1 but somehow
vger threw it on the bitbucket.  The message started like this:

        Subject: What's in git.git
        To: git@vger.kernel.org
	Date: Wed, 31 May 2006 23:40:26 -0700

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

All of the above have been cleared with the recent fixes to
miscellaneous minor breakages around the tree-parser updates, so
I think what we have on the "master" branch tonight is worthy of
1.4.0-rc1 status.

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

I am inclined to drop "read/write-tree --prefix" even from
"next"; we can resurrect it later if it proves to be useful in
order to do something else, such as "gitlink".

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

I think this can happen after 1.4.0.

        Things that we might want to have in 1.4.0 but not even in "next"
        yet include:

         - p4 importer (Sean Estabrooks) -- are people interested?

I am in favour of doing this before 1.4.0 (not in contrib/ but
as an importer next to other git-*import).

         - letting fetch-pack ask for an arbitrary commit object the
           user obtained out of band (Eric W Biederman) -- waiting for
           updated patch.  We would need a corresponding one-liner patch
           to upload-pack when we do this.

This can wait.

         - using ~/.gitrc to give a fall-back default when
           $GIT_DIR/config does not have values.

I suspect this would be more involved than Pasky's initial
patch; but it can wait.

         - command aliases and possibly default arguments via the
           configuration file.

This we have in "next" tonight and we should be able to have it
in "master" by the end of the week.  I took what Johannes did,
but I think that is pretty much the same as what Pasky did
initially, but forgot to mention that in the commit log.

I am expected to be mostly offline next week (among other
things, http://osdl.jp/seminar0613/ if you can read Japanese),
so I am planning to do 1.4.0-rc1 by my next git day (Wednesday
7th), and perhaps the real 1.4.0 on Saturday 10th if things go
smoothly.

Now v1.4.0-rc1 seems to have mirrored out.  Please have fun.
