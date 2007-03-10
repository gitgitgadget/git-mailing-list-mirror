From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Errors cloning large repo
Date: Fri, 9 Mar 2007 21:54:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703092145550.10832@woody.linux-foundation.org>
References: <645002.46177.qm@web52608.mail.yahoo.com> <20070310030718.GA2927@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anton Tropashko <atropashko@yahoo.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 06:54:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPuXM-0002Ls-8b
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 06:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993177AbXCJFyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 00:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993179AbXCJFyV
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 00:54:21 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33495 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993177AbXCJFyV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 00:54:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2A5sIo4030833
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Mar 2007 21:54:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2A5sH6I012868;
	Fri, 9 Mar 2007 21:54:17 -0800
In-Reply-To: <20070310030718.GA2927@spearce.org>
X-Spam-Status: No, hits=-0.49 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41850>



On Fri, 9 Mar 2007, Shawn O. Pearce wrote:
> 
> I'm shocked you were able to repack an 8.5 GiB repository.

Side note - it would be nice to hear just how big the repository *really* 
is.

For example, if "du -sh" says 8.5GB, it doesn't necessarily mean that 
there really is 8.5GB of data there.

With a normal 4kB blocksize filesystem, and ~150.000 filesystem objects, 
you'd have an average of 300MB of just padding (roughly 2kB per file). 
Depending on the file statistics, it could be even more.

And if it's compressible, it's entirely possible that even without 
much delta compression, it could fit in a pack-file smaller than 4GB. At 
which point a 32-bit index file should work fine, just not with a 32-bit 
off_t.

So this really could be a situation where just small tweaks makes it work 
out for now. We'll need the full 64-bit index eventually for sure, but..

		Linus
