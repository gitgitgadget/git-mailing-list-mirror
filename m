From: Linus Torvalds <torvalds@osdl.org>
Subject: The merge from hell...
Date: Wed, 1 Feb 2006 22:28:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Feb 02 07:30:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Xyz-0000QT-Ky
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 07:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422959AbWBBG32 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 01:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423014AbWBBG32
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 01:29:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57574 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422959AbWBBG31 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 01:29:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k126SxDZ018804
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 22:28:59 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k126SulN004969;
	Wed, 1 Feb 2006 22:28:56 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15486>


Ok,
 I've been holding off on having octopus merges in the kernel tree, but I 
just merged an ACPI update that had used one of them, and I didn't really 
see any real reason not to take it.

That octopus commit has got _twelve_ parents.

It's commit 9fdb62af92c741addbea15545f214a6e89460865, and passing it to 
git-diff-tree with the "--cc" option seems to do the largely the right 
thing (although arguably, since one of the parents always matches the end 
result in all the files, it shouldn't have shown anything at all, so I 
think it could do with some tweaking).

git-diff-tree takes almost three seconds to get its result, though.

However, if git-diff-tree is a bit slow, then gitk gets _really_ upset 
when you click on it. Apparently the colorized multi-way diff just breaks 
down into some O(2**n) hell.

I'm sure it's making progress, it's just very slow, and gitk is 
essentially unusable on that commit (gitk also gets visually confused by 
the fact that it forces a wider set of history than gitk expects, since it 
can't prune it down with the arrow notation).

[ Ahh. gitk just came back. After a _loong_ time thinking, and having run
  out of different colors, but looking otherwise fairly nice ;]

So think of it as a correctness/scalability test.

I haven't tried qgit or gitview on it, but am cc'ing Marco and Aneesh in 
case they want to hone their octopus skills on it.

Btw, I think you're better off parsing the "git-diff-tree --cc" output 
than doing it yourself like gitk does, now that core git has support for 
things like that.

			Linus
