From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 22:28:47 +0200
Message-ID: <20050524202846.GC25606@cip.informatik.uni-erlangen.de>
References: <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <20050524161745.GA9537@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org> <20050524184612.GA23637@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 22:29:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dag0i-00010l-4Q
	for gcvg-git@gmane.org; Tue, 24 May 2005 22:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVEXU3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 16:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVEXU3M
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 16:29:12 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:7073 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262028AbVEXU2x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 16:28:53 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4OKSlS8001195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 May 2005 20:28:47 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4OKSl1Z001194;
	Tue, 24 May 2005 22:28:47 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Almost eight minutes. Still, the final average was 8 changesets per
> second, which sounds pretty damn good to me, actually.

yes, it is. ;-)

> Anyway, I've checked in the fix for the quoting, and I now get the right 
> number of revisions, ie

> 	git-rev-tree $(ls .git/refs/heads/) | wc -l

> returns the same "3757" that cvsps reports. 

Nice! :-)

btw:

For the mutt tree there are a few 'empty commits' eg were the
parent tree is the same as the current. This is because git ignores
.cvsignore and they commited some .cvsignore files without any other
deltas. I don't know if you want to handle this. Just a note.

> However, "git-fsck-cache --unreachable" reports 102 unreachable blobs,
> which worries me. It's really blobs only, which is strange: it implies
> that we did the "git-update-cache" but not a "git-write-tree" (or that the
> git-write-tree failed for some reason, but that sounds even stranger,
> since we did successfully do all the commits)

> The only way I can see the unreachable blobs happening is if one of the
> ChangeSet entries in cvsps mentions the _same_ pathname twice for a single
> ChangeSet. David, is that possible?

Yes, it is, I had that problem before. For example tlr commtis the
changelog seperate with '# changlog' or so log message and cvsps thinks
because of the 'time fuzz which defaults to a way to high value' that
three changelog commits are all one delta. And that it adds three
entries. And what annoys me most in the wrong direction. So if you would
apply them as patches they don't apply because of the wrong ordering.

Reference:
		PatchSet 3005
		Date: 2002/12/07 19:19:42
		Author: roessler
		Branch: HEAD
		Tag: (none)
		Log:
		# changelog commit

		Members:
			ChangeLog:3.7->3.8
			ChangeLog:3.6->3.7
			ChangeLog:3.5->3.6

Just call cvsps with -z "20" for the mutt repository also -z 1 should
work because the timestamps of one 'commit' are all set to the same
value.

	Thomas
