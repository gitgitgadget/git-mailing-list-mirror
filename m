From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 09:16:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505240911050.2307@ppc970.osdl.org>
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
 <Pine.LNX.4.58.0505240849050.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 18:17:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dac50-0000VU-U0
	for gcvg-git@gmane.org; Tue, 24 May 2005 18:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVEXQR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 12:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVEXQPm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 12:15:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:14002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262123AbVEXQOf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 12:14:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OGELjA001266
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 09:14:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OGEKgQ003407;
	Tue, 24 May 2005 09:14:20 -0700
To: David Mansfield <david@cobite.com>
In-Reply-To: <Pine.LNX.4.58.0505240849050.2307@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Linus Torvalds wrote:
> 
> Fixing the branch handling shows that cvsps does some really strange
> things with the newly added "Ancestor grpah". Here's one example:

Ahh, looking at cvsps source, I think I see what's going on. 

It's deciding the "previous branch" by looking at what the previous branch 
for the first individual file in the PatchSet was, which fails because in 
this case, PatchSet 372 was changing "syslinux.doc", and Patchset 374 was 
changing "syslinux.c", and thus the previous version of the individual 
_files_ were both in the HEAD branch.

So it does look like I should just ignore the "Ancestor branch" 
information if the new branch already existed.

Of course, some semantics will never be translatable when trying to treat 
CVS as a sane system (ie treating CVS as if it was changeset-based is 
always going to cause strange corner cases since it really is file-based), 
but that should most likely give the best approximation of what a 
conversion should do.

		Linus
