From: Johan Herland <johan@herland.net>
Subject: Re: way to automatically add untracked files?
Date: Sun, 05 Aug 2007 14:11:24 +0200
Message-ID: <200708051411.25238.johan@herland.net>
References: <873ayymzc1.fsf@catnip.gol.com>
 <fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
 <20070805041320.GH9527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Miles Bader <miles@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 14:11:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHexN-00032H-Ib
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 14:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442AbXHEMLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 08:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756282AbXHEMLe
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 08:11:34 -0400
Received: from smtp.getmail.no ([84.208.20.33]:54892 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756053AbXHEMLc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 08:11:32 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JMA00805V77VK00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 05 Aug 2007 14:11:31 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JMA004ULV73RV00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 05 Aug 2007 14:11:27 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JMA00IAPV72FQ50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 05 Aug 2007 14:11:27 +0200 (CEST)
In-reply-to: <20070805041320.GH9527@spearce.org>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55002>

On Sunday 05 August 2007, Shawn O. Pearce wrote:
> Miles Bader <miles@gnu.org> wrote:
> > I previously wrote
> > > One thing I often want to do is git-add all untracked files, and also
> > > automatically git-rm all "disappeared" files
> > ...
> > > One way to do this seems to be just "git add ."
> > 
> > Oh, also, "git add ." doesn't seem to do the right thing with
> > "dissapeared" files:  If I do:
> > 
> >     mv foo.cc bar.cc
> >     git add .
> 
> Right.  Who wants "add" to actually mean "add and delete"?
> Shouldn't that be then called "git-add-and-rm"?
> 
> We recently talked about this on the mailing list and decided that
> git-add shouldn't remove files that have disappeared, as doing so
> might break most user's expections of what git-add does.

So different users seem to have two different (almost incompatible) 
expectations to git-add:

1. git-add adds new files into the index. git-add has _no_ business removing 
deleted files from the index.

2. git-add updates the index according to the state of the working tree. 
This includes adding new files and removing deleted files.


Both interpretations are useful and worth supporting, but git-add currently 
seems focused on #1 (and rightly so, IMHO).

Even though #2 can be achieved by using a couple of git-add commmands (or a 
longer series of more obscure plumbing-level commands), it might be worth 
considering the more user-friendly alternative of adding a dedicated 
command for supporting #2. Such a command already exists in a similar RCS:

---
$ hg addremove --help
hg addremove [OPTION]... [FILE]...

add all new files, delete all missing files

    Add all new files and remove all missing files from the repository.

    New files are ignored if they match any of the patterns in .hgignore. As
    with add, these changes take effect at the next commit.

[...]
---

Adding a git-addremove command should not be much work, and it would be a 
lot friendlier to people whose workflow is more aligned with #2 than #1.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
