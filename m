From: Linus Torvalds <torvalds@osdl.org>
Subject: "checkout-cache" update
Date: Thu, 21 Apr 2005 10:40:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504211027500.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Apr 21 19:35:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOfZP-0007Zz-VN
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 19:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVDURit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 13:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVDURit
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 13:38:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:55761 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261574AbVDURie (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 13:38:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3LHcWs4010259
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 10:38:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3LHcVmh013527
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 10:38:31 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I just pushed out this very useful thing to "checkout-cache", which is 
best just described by its commit log:

  Add the ability to prefix something to the pathname to "checkout-cache.c"
  
  This basically makes it trivial to use checkout-cache as a "export as
  tree" function. Just read the desired tree into the index, and do a
  
        checkout-cache --prefix=export-dir/ -a
  
  and checkout-cache will "export" the cache into the specified directory.
  
  NOTE! The final "/" is important. The exported name is literally just
  prefixed with the specified string, so you can also do something like
  
        checkout-cache --prefix=.merged- Makefile
  
  to check out the currently cached copy of "Makefile" into the file
  ".merged-Makefile".

Basically, I can do a a "git-0.6" release with a simple

	checkout-cache --prefix=../git-0.6/ -a

which basically says: check out all files, but use the prefix 
"../git-0.6/" before the filename when you do so.

Then I just do

	cd ..
	tar czvf git-0.6.tar.gz git-0.6

and I'm done. Very cool, very simple, and _extremely_ fast.

Doing the tree export (not the tar) for the whole kernel takes two minutes
in the cold-cache case (not so wonderful, but acceptable), and 4.6
_seconds_ in the hot-cache case (pretty damn impressive, I say).

(The compressng tar then takes about 20 seconds for me, and that's
obviously all from the cache, since I just wrote it out).

NOTE! The fact that the '/' at the end of the --prefix= thing is 
meaningful can be very confusing, I freely admit. But it does end up being 
potentially quite useful, and you're likely to script usage of this anyway 
into "git export" or something, so...

		Linus
