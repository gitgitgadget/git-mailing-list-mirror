From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 12:34:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241212190.2307@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
 <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
 <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
 <20050524184612.GA23637@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 21:33:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Daf7Y-0001lZ-Es
	for gcvg-git@gmane.org; Tue, 24 May 2005 21:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVEXTcx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 15:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVEXTcx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 15:32:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:3247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261963AbVEXTcg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 15:32:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OJWRjA016213
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 12:32:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OJWPmE012996;
	Tue, 24 May 2005 12:32:26 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050524184612.GA23637@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Thomas Glanzmann wrote:
> 
> I have the following issues all seem easy to fix:
> 
> 	- PatchSet 1 depends on PatchSet 2 (but cvsps gets the ordering wrong;
> 	  should be easy fixable) (I just swichted the two before
> 	  running cvs2git)

Ok, this seems to be a cvsps bug, and I'll treat it as such. David, any 
ideas? It seems to be because of how cvsps sorts things by date, which is 
obviously bogus.

The cvs2git thing wouldn't normally even _care_ (ie would happily re-order
the thing), but for the fact that it causes problems with branches that
are used before they are created in this case.

cvsps really should do some kind of topo-sort. Probably doesn't need a lot
(ie it probably doesn't even need to be topological, but the "order"  
should be based on trivial dependencies first, and time second. For
example, once David does the per-commit branch handling, I suspect enough
of an ordering to keep git happy falls out of that).

> 	- Some Shell escapes (I didn't looked into them yet)

Ok, I'll check it out. I didn't figure out what characters are 
shell-expanded by "<<EOF" handling, and only did '$' because that showed 
up in the syslinux archives.

> (faui02new) [/var/tmp/sithglan/mutt-cvs] git parent ~/work/mutt/git/mutt-cvs
> (faui02new) [/var/tmp/sithglan/mutt-cvs] git parentdiff
> (faui02new) [/var/tmp/sithglan/mutt-cvs]
> 
> I think I will run my 'import patch by patch script again' and check the
> changesets against the cvs2git tree, but it looks fine for me.

In theory, they should give the exact same results, no? At least if there 
are no binary objects. Of course, you'd have to update your import script 
to do the times the same way.

		Linus
