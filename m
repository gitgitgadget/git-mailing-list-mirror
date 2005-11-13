From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/2] Add expat and expat-devel dependencies (for http-push)
 to RPM spec.
Date: Sun, 13 Nov 2005 11:49:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511131137470.3263@g5.osdl.org>
References: <4376C797.3050600@matysik.co.nz> <Pine.LNX.4.64.0511130942490.3263@g5.osdl.org>
 <437788A0.6030103@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 20:50:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbNqu-0003C9-A4
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 20:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbVKMTtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 14:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbVKMTtO
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 14:49:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750780AbVKMTtN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 14:49:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jADJn8nO006350
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 13 Nov 2005 11:49:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jADJn7wo014156;
	Sun, 13 Nov 2005 11:49:08 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437788A0.6030103@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11747>



On Sun, 13 Nov 2005, Andreas Ericsson wrote:
> 
> This would get rid of expat and curl dependencies. ssh, rsync and git
> protocols use external programs so they aren't exactly required (from the rpm
> point of view anyways, they'll just fail if rsync or ssh isn't installed).

Actually, the "git://" protocol (and local filesystem ones) doesn't need 
any external programs. So if you just want to follow another repository, 
you can do so even without ssh or rsync installed.

But yes, the nice thing about ssh(+git):// and rsync:// is that since we 
don't link against them or depend on them in general, you can certainly 
install git without having them, and don't need to make a dependency of 
it.

If there's some way to "suggest" ssh when installing git, that would be 
good, but I don't think rpm has that. And if somebody doesn't have ssh 
installed, they probably don't have a network, so maybe even that is 
unnecessary.

So depending on the curl _program_ would fall under the same harmless case 
as depending on ssh and rsync, but the thing is, we depend on it as a 
library, which is why we should split things up.

> Moving out the {cvs,arch,svn}-import scripts made sense because they 
> were only faintly related to git day-to-day operations and forced some 
> really ridiculous dependencies down users throats (git requiring 
> subversion was a funny one...).

Yes. 

NOTE! Git does actually require the "merge" program, which sometimes comes 
with the diff3 package, and more often comes with rcs.  As with ssh and 
rsync, it's an external program and only really required if you do 
development (you can fast-forward something that you're only tracking 
read-only without it), so in theory you don't absolutely need it, but we 
do have a dependency on RCS right now due to that.

Which is a bit strange, and sometimes wrong (the same machine that doesn't 
have curl installed also doesn't have rcs installed, but I compile git on 
it anyway, and it works fine, since I use that machine only as a backup 
thing to receive git packs - in case kernel.org goes down _and_ all my 
home machines magically turn into pumpkins, I'll still have another site 
I can get my git repos from).

> While we're on the subject of confusing; How about not naming non-core
> packages git-core? It feels wrong to have git-core-http, git-core-cvs and
> git-core-svn since they, strictly speaking, aren't required for core
> operations.

Yeah, that "git-core-xxx" thing is a bit strange, but on the other hand, 
it does make it clear that they all come from the same SRPM (the 
"git-core" SRPM) so in the end I think it's actually a good idea.

			Linus
