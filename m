From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 13:33:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704101325580.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <200704101828.37453.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
 <200704102004.08329.andyparkins@gmail.com> <Pine.LNX.4.64.0704101219280.6730@woody.linux-foundation.org>
 <7vwt0kugmy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 06:04:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbN2i-0002vZ-MT
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 22:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbXDJUeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 16:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbXDJUeI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 16:34:08 -0400
Received: from smtp.osdl.org ([65.172.181.24]:44202 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753493AbXDJUeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 16:34:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3AKY0VZ010500
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Apr 2007 13:34:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3AKXxcj016659;
	Tue, 10 Apr 2007 13:34:00 -0700
In-Reply-To: <7vwt0kugmy.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44178>



On Tue, 10 Apr 2007, Junio C Hamano wrote:
> 
> But I do not think the .gitmodules thing needs that.  If we have
> conflicting (or non-conflicting for that matter) submodule
> moves, that's a _MAJOR_ project re-organization, and I do not
> think we would even want to automatically descend into
> submodules for merging or checking-out when we have such a
> situation in the higher level project.

100% agreed. 

Also, note that while the ".gitmodules" (or whatever) file will be 
required to do things like "git pull", the basic tree-level logic that I 
sent out obviously doesn't need/use .gitmodules at all.

So there's a very real issue where a repository with submodules still 
"works", even with a .gitmodules file that is totally scrogged and doesn't 
have the right information (yet), it's just that it may simply not be able 
to do all the operations because it cannot figure out where to pull 
missing subproject data from etc..

So there is no reason to believe that we need to magically and 
automatically resolve conflicts - if conflicts happen, functionality is 
reduced, but it's not reduced so much that you cannot use the tree and try 
to resolve them (which is important, btw, since often before you commit 
your fix for the conflicts you'd want to *test* that fix, so we definitely 
don't want these kinds of files to be so central that it gets hard to get 
normal work done without them).

It really boils down to the same design issue: the way I think submodules 
should work is that they are very loosely coupled with the supermodule. 
The fact that the ".gitmodules" file isn't *that* critical comes largely 
from that loose coupling.

		Linus
