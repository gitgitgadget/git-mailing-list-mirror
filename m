From: Linus Torvalds <torvalds@osdl.org>
Subject: "GIT_INDEX_FILE" environment variable
Date: Thu, 21 Apr 2005 11:09:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Apr 21 20:04:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOg1h-0003dr-QX
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVDUSIE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVDUSIE
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:08:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:10211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261585AbVDUSH4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 14:07:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3LI7ss4013137
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:07:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3LI7r88015275
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:07:53 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This checkin goes along with the previous one, and makes it easier to use 
all the normal git operations on temporary index files:

  Add support for a "GIT_INDEX_FILE" environment variable.
  
  We use that to specify alternative index files, which can be useful
  if you want to (for example) generate a temporary index file to do
  some specific operation that you don't want to mess with your main
  one with.
  
  It defaults to the regular ".git/index" if it hasn't been specified.

and it's particularly useful for doing things like "read a tree into a 
temporary index file, and write the result out". For example, say that you 
wanted to know what the Makefile looked like in a particular release, 
you could do

    GIT_INDEX_FILE=.tmp-index read-tree $release
    GIT_INDEX_FILE=.tmp-index checkout-cache --prefix=old- Makefile
    rm .tmp-index

and you're done. Your old Makefile version is now in "old-Makefile" (and
this is also where it's nice that checkout-cache refuses to overwrite
existing files by default: if you forgot or messed up the prefix, it's all
good).

You can also use it to test merges without screwing up your old index file 
in case something goes wrong.

Did I already happen to mention that I think that the git model is the
best model ever, and that I'm just not an incredibly good-looking hunk and
becomingly modest, I'm smart too?

		Linus
