From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Some index-base bug in "next" branch ("git-applymbox"-related?)..
Date: Thu, 12 Apr 2007 15:43:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 00:43:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc813-0006ws-FE
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 00:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbXDLWna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 18:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbXDLWna
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 18:43:30 -0400
Received: from smtp.osdl.org ([65.172.181.24]:35365 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750700AbXDLWn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 18:43:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3CMhNIs026828
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Apr 2007 15:43:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3CMhNJm018601;
	Thu, 12 Apr 2007 15:43:23 -0700
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44360>


Junio, I've been running "next", because of working on the submodule 
stuff.

I  just did some trivial kernel stuff: applied seven patches, and tried to 
do a "pull". And whoa, that failed. I get this:

	[torvalds@woody linux]$ dotest ~/doit
	7 patch(es) to process.

	.. all apply fine ..

	[torvalds@woody linux]$ git pull master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for_linus
	remote: Generating pack...
	...
	Unpacking 22 objects
	 100% (22/22) done
	Your index is based on '80584ff3b99c36ead7e130e453b3a48b18072d18' commit, but the branch tip you are on is at '6a04de6dbe1772d98fddf5099738d6f508e86e21'

That "80584ff.." commit is the commit *before* the "dotest", and HEAD is 
(correctly) 6a04de.. that is the end result of the "dotest". That "dotest" 
thing is just because "git-applymbox" isn't in my brain stem:

	[torvalds@woody linux]$ alias dotest
	alias dotest='git-applymbox -u'

so it's not actually anything strange.

Doing a "git reset" obviously fixed it, but if I didn't know that you had 
been working on that "index BASE" thing, I would have been very worried.

That index base thing is definitely *not* ready for merging into master 
yet!

		Linus
