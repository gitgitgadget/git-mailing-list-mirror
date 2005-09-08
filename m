From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 8 Sep 2005 13:59:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509081357480.3039@g5.osdl.org>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
 <7v1x407min.fsf@assigned-by-dhcp.cox.net> <431F34FF.5050301@citi.umich.edu>
 <7vvf1cz64l.fsf@assigned-by-dhcp.cox.net> <4320536D.2010706@citi.umich.edu>
 <7v7jdrwlih.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509081012540.3208@g5.osdl.org>
 <43207FE6.2030108@citi.umich.edu> <Pine.LNX.4.58.0509081131070.5940@g5.osdl.org>
 <432089D8.4060507@citi.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 23:02:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDTVA-0004d1-7d
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 23:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVIHVAE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 17:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVIHVAE
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 17:00:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56239 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751396AbVIHVAB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 17:00:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j88KxtBo013798
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Sep 2005 13:59:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j88Kxs9b005163;
	Thu, 8 Sep 2005 13:59:55 -0700
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <432089D8.4060507@citi.umich.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8217>



On Thu, 8 Sep 2005, Chuck Lever wrote:
> > 
> > Btw, in the sparse project, we have this really smart "pointer list" data
> > structure, which is extremely space- and time-efficient. It ends up
> > _looking_ like a linked list, but it batches things up in hunks of 29
> > entries (29 pointers plus overhead gives you blocks of 32 longwords, which
> > is the allocation size) and thus gives basically a cache-friendly
> > doubly-linked list. It knows how to do insertions, traversals etc very 
> > efficiently.
> > 
> > Any interest?
> 
> i'm not married to splay trees.  i think we should explore several 
> different data structures before picking one, and this one sounds 
> reasonable to try.

Actually, I just realized that one of the issues is just plain looking up
a name (ie "pos = cache_name_pos(..)", and the sparse list don't make that
very efficient unless you have a good starting point.

So a splay tree is probably more appropriate.

			Linus
