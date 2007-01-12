From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 16:42:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701111452340.3594@woody.osdl.org>
References: <Pine.LNX.4.64.0701111410420.3594@woody.osdl.org>
 <20070111223905.GP17999@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Fri Jan 12 01:42:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5AV9-0007m2-Nq
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 01:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbXALAmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 19:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbXALAmd
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 19:42:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:47853 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbXALAmc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 19:42:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0C0g5Wi012261
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 16:42:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0C0g5xm008124;
	Thu, 11 Jan 2007 16:42:05 -0800
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20070111223905.GP17999@mellanox.co.il>
X-Spam-Status: No, hits=-0.663 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36644>



On Fri, 12 Jan 2007, Michael S. Tsirkin wrote:
> 
> Weird. I think the system where the tree got corrupted had git 1.4.4.4.

Ok, you had an email with "git version" that said 1.5.0-rc0-g<something>, 
but that may have been after you already upgraded for other reasons.

It would definitely be good to reproduce this - there are multiple places 
where we could screw up in the presense of a short write. It's also 
entirely possible that the core code doesn't screw up, but if some of the 
higher-level scripts don't always check the error code, an error at 
unpacking time (or some other time) could just go unnoticed.

That said, even though I complain about the "write_in_full()" bug, I think 
that with the "return error even for partial writes" change it actually 
_does_ end up being a safer way to do things, so it's entirely possible 
that while it introduced one bug, it could have fixed another one. The 
call chain I looked at was just one particular one (it's the most 
fundamental one for writing out individual objects, so in that sense it's 
the most likely one, but it's certainly possible that something else 
happened)

		Linus
