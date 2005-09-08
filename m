From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 8 Sep 2005 11:35:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509081131070.5940@g5.osdl.org>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
 <7v1x407min.fsf@assigned-by-dhcp.cox.net> <431F34FF.5050301@citi.umich.edu>
 <7vvf1cz64l.fsf@assigned-by-dhcp.cox.net> <4320536D.2010706@citi.umich.edu>
 <7v7jdrwlih.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509081012540.3208@g5.osdl.org>
 <43207FE6.2030108@citi.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 20:37:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDRFq-0007B9-QB
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 20:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVIHSgI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 14:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbVIHSgH
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 14:36:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48612 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964921AbVIHSgG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 14:36:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j88IZxBo003879
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Sep 2005 11:35:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j88IZral030013;
	Thu, 8 Sep 2005 11:35:56 -0700
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <43207FE6.2030108@citi.umich.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8210>



On Thu, 8 Sep 2005, Chuck Lever wrote:
> 
> in my case the merges were taking significantly longer than a half 
> second.  making this change is certainly not worth it if merges are 
> running fast...

Note that in cold-cache cases, all the expense of read-tree is in actually
reading the tree objects themselves (a kernel tree has more than a
thousand subdirectories). Also, a full "git pull" will do the diffstat 
etc, and then the expense ends up being in the actual "git diff" part.

So read-tree itself may be half a second, but a merge ends up having other 
parts.

> they are still read-only with my linked list implementation.

Btw, in the sparse project, we have this really smart "pointer list" data
structure, which is extremely space- and time-efficient. It ends up
_looking_ like a linked list, but it batches things up in hunks of 29
entries (29 pointers plus overhead gives you blocks of 32 longwords, which
is the allocation size) and thus gives basically a cache-friendly
doubly-linked list. It knows how to do insertions, traversals etc very 
efficiently.

Any interest?

		Linus
