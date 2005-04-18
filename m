From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix bug in read-cache.c which loses files when merging
 a tree
Date: Mon, 18 Apr 2005 14:19:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181330450.15725@ppc970.osdl.org>
References: <1113848239.4998.45.camel@mulgrave>  <Pine.LNX.4.58.0504181219480.15725@ppc970.osdl.org>
 <1113854941.4998.61.camel@mulgrave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:14:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNdZA-0000II-VN
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 23:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVDRVR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 17:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVDRVR6
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 17:17:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:22418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261187AbVDRVRy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 17:17:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3ILHms4031122
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 14:17:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3ILHm4W004821;
	Mon, 18 Apr 2005 14:17:48 -0700
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1113854941.4998.61.camel@mulgrave>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, James Bottomley wrote:
> 
> I had a problem with the SCSI tree in that there's a file removal in one
> branch.  Your git-merge-one-file-script wouldn't have handled this
> correctly: It seems to think that the file must be removed in both
> branches, which is wrong.

Yes, I agree. My current "merge-one-file-script" doesn't actually look at 
what the original file was in this situation, and clearly it should. I 
think I'll leave it for the user to decide what happens when somebody has 
modified the deleted file, but clearly we should delete it if the other 
branch has not touched it.

I suspect that I should just pass in the SHA1 of the files to the
"merge-one-file-script" from "merge-cache", rather than unpacking it.  
After all, the merging script can do the unpacking itself with a simple
"cat-file blob $sha1".

And the fact is, many of the trivial merges should be handled by just
looking at the content, and doing a "cmp" on the files seems to be a
stupid way to do that when we had the sha1 earlier.

Done, and pushed out. Does the new merge infrastructure work for you?

		Linus
