From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 6/8] cogito: Don't ever assume object type in cg-object-id
Date: Thu, 22 Sep 2005 17:50:25 +0200
Message-ID: <20050922155025.GK21019@pasky.or.cz>
References: <1127183120.31115.34.camel@dv> <20050921100040.GE24902@pasky.or.cz> <1127359625.8074.18.camel@dv> <20050922094643.GC21019@pasky.or.cz> <1127403479.14856.13.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 22 17:52:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EITLI-00042c-3y
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 17:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbVIVPud (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 11:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbVIVPud
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 11:50:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63209 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030415AbVIVPud (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 11:50:33 -0400
Received: (qmail 18108 invoked by uid 2001); 22 Sep 2005 17:50:25 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1127403479.14856.13.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9129>

Dear diary, on Thu, Sep 22, 2005 at 05:37:59PM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hi, Petr!

Hi,

> On Thu, 2005-09-22 at 11:46 +0200, Petr Baudis wrote:
> > $ git-fsck-objects
> > error: b3e9704ecdf48869f635f0aa99ddfb513f885aff: object not found
> > 
> > and some dangling stuff, that's all I get. This seems to be caused by
> > the mere existence of that (empty) file, so I just removed it from the
> > objects database and all is fine now.
> 
> Maybe kernel.org site is not in sync yet, but anyway, here's what I
> found.

root      4036  2.7  2.8 106756 104080 ?     SN   00:04  14:32 rsync

:/

> I ran this script:
> 
> [proski@dv cogito]$ for i in .git/refs/tags/*; do git-tar-tree `cat $i` >/dev/null || echo $i; done
> fatal: not a reference to a tag, commit or tree object: 463d05c7c4fe7f24da29749f4c7f25893fc20b8c
> .git/refs/tags/git-pasky-0.1
> fatal: not a reference to a tag, commit or tree object: 2c70421be7d88fbee49986d7a5584d1f010a25de
> .git/refs/tags/git-pasky-0.2
> fatal: not a reference to a tag, commit or tree object: d14925c87cdb6ca6345bcb3c8e34a2d659c79451
> .git/refs/tags/git-pasky-0.3

Huh. Huh?

xpasky@machine[1:0]~/git-devel$ git-cat-file -t $(cg-object-id git-pasky-0.1)
commit
xpasky@machine[1:0]~/git-devel$ git-cat-file -t $(cg-object-id git-pasky-0.2)
commit
xpasky@machine[1:0]~/git-devel$ git-cat-file -t $(cg-object-id git-pasky-0.3)
commit

Same on master.kernel.org.

> I can run "git-prune origin", but then cg-fetch would refetch objects
> for more tags:
> 
> Missing object of tag cogito-0.12... retrieved
> Missing object of tag cogito-0.12.1... retrieved
> Missing object of tag cogito-0.13... retrieved
> Missing object of tag cogito-0.14... retrieved
> Missing object of tag cogito-0.14.1... retrieved
> Missing object of tag cogito-0.14.2... retrieved
> Missing object of tag cogito-0.15... retrieved
> Missing object of tag git-pasky-0.1... retrieved
> Missing object of tag git-pasky-0.2... retrieved
> Missing object of tag git-pasky-0.3... retrieved
> 
> How come that cogito-0.12 - cogito-0.15 are not on the origin tree, but
> older cogito tags are?

That's because the older tags tag commits directly, not tag objects.
git-prune removed the tag objects because they were unreferenced by its
perspective. Anyway, git-prune without any arguments should get it
right.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
