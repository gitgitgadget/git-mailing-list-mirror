From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 13:09:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
 <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
 <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
 <20050524184612.GA23637@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 22:08:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Daffa-0006gJ-58
	for gcvg-git@gmane.org; Tue, 24 May 2005 22:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVEXUIC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 16:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVEXUIC
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 16:08:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:60612 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261995AbVEXUHy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 16:07:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OK7ljA018838
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 13:07:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OK7kjG014518;
	Tue, 24 May 2005 13:07:46 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Linus Torvalds wrote:
> 
> Will fix. This will take another six minutes of testing ;)

Almost eight minutes. Still, the final average was 8 changesets per
second, which sounds pretty damn good to me, actually.

Anyway, I've checked in the fix for the quoting, and I now get the right 
number of revisions, ie

	git-rev-tree $(ls .git/refs/heads/) | wc -l

returns the same "3757" that cvsps reports. 

However, "git-fsck-cache --unreachable" reports 102 unreachable blobs,
which worries me. It's really blobs only, which is strange: it implies
that we did the "git-update-cache" but not a "git-write-tree" (or that the
git-write-tree failed for some reason, but that sounds even stranger,
since we did successfully do all the commits)

The only way I can see the unreachable blobs happening is if one of he
ChangeSet entries in cvsps mentions the _same_ pathname twice for a single
ChangeSet. David, is that possible?

Exactly because it's only blobs, it really does smell like a cvsps issue. 
My scripts always use "git-update-cache --add -- filename", so it never 
creates any blobs _except_ when it adds them to the index (and thus 
write-tree should always pick them up, unless we update the index again 
before the next write-tree happens).

			Linus
