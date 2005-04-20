From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 18:09:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191804180.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <200504191708.23536.mason@suse.com>
 <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org> <200504192049.21947.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 03:03:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO3cS-0004Fq-Ie
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 03:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVDTBHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 21:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVDTBHQ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 21:07:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:1258 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261207AbVDTBHK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 21:07:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3K176s4004496
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 18:07:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3K175wY010813;
	Tue, 19 Apr 2005 18:07:05 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504192049.21947.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Chris Mason wrote:
> 
> 5) right before exiting, write-tree updates the index if it made any changes.

This part won't work. It needs to do the proper locking, which means that 
it needs to create "index.lock" _before_ it reads the index file, and 
write everything to that one and then do a rename.

If it doesn't need to do the write, it can just remove index.lock without 
writing to it, obviously.

> The downside to this setup is that I've got to change other index users to 
> deal with directory entries that are there sometimes and missing other times.  
> The nice part is that I don't have to "invalidate" the directory entry, if it 
> is present, it is valid.

To me, the biggest downside is actually the complexity part, and worrying
about the directory index ever getting stale. How big do the changes end
up being?

		Linus
