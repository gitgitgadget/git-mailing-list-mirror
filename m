From: Petr Baudis <pasky@suse.cz>
Subject: git-http-pull broken in latest git
Date: Fri, 12 Aug 2005 00:33:49 +0200
Message-ID: <20050811223349.GI25280@pasky.ji.cz>
References: <42F8D472.3080404@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 00:34:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3Lcv-0003bR-4f
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 00:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbVHKWdw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 18:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVHKWdv
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 18:33:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35082 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932508AbVHKWdu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 18:33:50 -0400
Received: (qmail 23251 invoked by uid 2001); 11 Aug 2005 22:33:49 -0000
To: Dirk Behme <dirk.behme@de.bosch.com>
Content-Disposition: inline
In-Reply-To: <42F8D472.3080404@de.bosch.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Aug 09, 2005 at 06:06:10PM CEST, I got a letter
where Dirk Behme <dirk.behme@de.bosch.com> told me that...
> Hello,

Hello,

> >cg-clone http://www.kernel.org/pub/scm/git/git.git 
> defaulting to local storage area
> warning: templates not found /home/user/share/git-core/templates/
> 16:29:03 URL:http://www.kernel.org/pub/scm/git/git.git/refs/heads/master
> [41/41] -> "refs/heads/origin" [1]
> progress: 3 objects, 5158 bytes
> Getting pack list
> error: Unable to get pack index
> http://www.kernel.org/pub/scm/git/git.git//objects/info/packs
> error: Tried
> http://www.kernel.org/pub/scm/git/git.git/objects/6f/f87c4664981e4397625791c8ea3bbb5f2279a3
> Cannot obtain needed blob 6ff87c4664981e4397625791c8ea3bbb5f2279a3
> while processing commit adee7bdf504120055b0f36b4918bdd3e6156912b.
> cg-pull: objects pull failed
> cg-clone: pull failed
> 
> Is this a tool or repository issue?

it appears that git-http-pull is broken. It gives me a different error
now and with the latest git, though. When using just core git:

$ wget http://www.kernel.org/pub/scm/git/git.git/refs/heads/master
$ mv master .git/refs/heads/
$ cat .git/refs/heads/master
bf570303153902ec3d85570ed24515bcf8948848
$ git-http-pull -a -v $(cat .git/refs/heads/master) \
	http://www.kernel.org/pub/scm/git/git.git/
Getting pack list
Getting index for pack 3c5133604508466855453f3e609428f4bbba9131
Getting index for pack 37cba29d3df65b160afabe769470f7857f98d729
Getting pack 37cba29d3df65b160afabe769470f7857f98d729
 which contains bf570303153902ec3d85570ed24515bcf8948848
$ git-cat-file commit bf570303153902ec3d85570ed24515bcf8948848 | grep tree
tree 41f10531f1799bbb31a1e0f7652363154ce96f45
$ git-read-tree 41f10531f1799bbb31a1e0f7652363154ce96f45
fatal: failed to unpack tree object 41f10531f1799bbb31a1e0f7652363154ce96f45

Kaboom. I think the issue might be that the reference dependency tree
building is broken and it should've pulled the other pack as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
