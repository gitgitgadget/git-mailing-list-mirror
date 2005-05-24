From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 09:00:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505240849050.2307@ppc970.osdl.org>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>
  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org> 
 <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>
  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>
  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com>
 <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
 <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
 <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 18:09:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dabxb-0007gn-De
	for gcvg-git@gmane.org; Tue, 24 May 2005 18:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVEXQDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 12:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVEXQBl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 12:01:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:43945 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262147AbVEXP7U (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 11:59:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OFwsjA032336
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 08:58:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OFwpqb002476;
	Tue, 24 May 2005 08:58:53 -0700
To: David Mansfield <david@cobite.com>
In-Reply-To: <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Linus Torvalds wrote:
> 
> It has the logic for branches, but it doesn't work, and I'm fed up enough
> with CVS and RCS for the moment that I'm not going to work on it any more
> tonight.

I'm back, and yes, it was a really stupid thing.

However, David, I need more help deciphering "cvsps" output..

Fixing the branch handling shows that cvsps does some really strange
things with the newly added "Ancestor grpah". Here's one example:

	---------------------
	PatchSet 372 
	Date: 2002/02/03 21:37:50
	Author: hpa
	Branch: syslinux-1_6x-1
	Ancestor branch: HEAD
	Tag: syslinux-1_67 
	Log:
	New mailing list information
	
	Members: 
	        syslinux.doc:1.48->1.48.2.1 
	
	---------------------
	PatchSet 373 
	Date: 2002/02/11 23:08:47
	Author: hpa
	Branch: HEAD
	Tag: (none) 
	Log:
	tftpd32 needs version 2.11 or later.
	
	Members: 
	        pxelinux.doc:1.28->1.29 
	
	---------------------
	PatchSet 374 
	Date: 2002/02/18 23:43:43
	Author: hpa
	Branch: syslinux-1_6x-1
	Ancestor branch: HEAD
	Tag: syslinux-1_6x-merge-2 
	Log:
	Actually make the -o option work properly.
	
	Members: 
	        syslinux.c:1.13->1.13.2.1 
	
	---------------------

note how both 372 _and_ 374 claim to have HEAD as their ancestor, and are 
on the "syslinux-1_6x-1" branch. What's up with that? Right now this 
causes my git archive to first create 372 as a branch off HEAD, and then 
overwrite that with 374, resulting in a dangling branch for 372 that 
_exists_, but it's not reachable any more, because the branch name that it 
used has been overwritten by the _new_ branch off HEAD.

Side note: cvs2git is pretty robust since it doesn't rely on patches
anywhere, so the head of the branch likely ends up being correct, if that
"syslinux.doc" file has been modified anywhere else in the branch. So this
_usually_ just results in (a) git-fsck-cache complaining about unreachable
commits and (b) possible history being hard to find.

Maybe this cvs2git behaviour is the right thing to do, and what really
happened was that the changes described by PatchSet 372 aren't really
available any more even in CVS, unless you go back by date or something 
like that.

However, I suspect it's a cvsps bug in the "ancestor branch" thing. I
could work around it by just saying "if I have already seen this branch,
I'll ignore the ancestor information".

So I'd like to know whether this is a cvsps issue or whether I actually
ended up doing the right thing and it really should be a dangling
branch-name that got re-used...

(And if it's a cvsps issue, I'd obviously prefer to get a cvsps patch 
instead of having a questionable workaround in cvs2git).

"Davi-Mansfieldobi, you're our only hope.."

		Linus
