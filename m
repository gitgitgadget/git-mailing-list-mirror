From: Linus Torvalds <torvalds@osdl.org>
Subject: "git daemon"
Date: Wed, 13 Jul 2005 19:53:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507131946540.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 04:54:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DstrG-0004KK-9g
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 04:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbVGNCxt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 22:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbVGNCxt
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 22:53:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3009 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262860AbVGNCxs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 22:53:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6E2rljA013781
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Jul 2005 19:53:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6E2rkli021443;
	Wed, 13 Jul 2005 19:53:46 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Guys,
 I've written a really simple TCP git daemon that normally listens on 
port "DEFAULT_GIT_PORT" aka 9418. It waits for a connection, and will just 
execute "git-upload-pack" when it gets one.

It's actually a bit more careful than that, in that there's a magic 
request-line that gives the command and what directory to upload, and it 
verifies that the directory is ok.

In particular, it verifies that the directory has the magic file
"git-daemon-export-ok", and it will refuse to export any git directory 
that hasn't explicitly been marked for export this way.

What I'd ask people to check is how comfortable for example kernel.org 
would be to have one machine that runs this kind of service? I've tried 
very hard to set it up so that it doesn't have any security issues: the 
daemon can be run as "nobody", and it shouldn't ever even write to any 
files, although I guess we should do a full check of that.

In fact, it doesn't even really accept any user input except for the list
of SHA1's that you give the upload which denote the "I have these" list. 
So I really think it should be hard to fool into doing anything bad, and 
the code isn't _that_ complicated, but hey, it's a daemon. They're always 
buggy, and there are always security issues.

Anyway, this would be a _wonderful_ interface for read-only updates, ie 
people pulling from my (and other peoples) git repositories.

		Linus
