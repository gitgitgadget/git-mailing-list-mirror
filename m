From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 10:37:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702281031490.12485@woody.linux-foundation.org>
References: <17892.64236.443170.43061@lisa.zopyra.com> <20070228035713.GC5597@spearce.org>
 <20070228044719.GA6068@spearce.org> <17893.40847.313519.283218@lisa.zopyra.com>
 <17893.42063.186763.291346@lisa.zopyra.com> <20070228155412.GC5479@spearce.org>
 <17893.43522.511785.121778@lisa.zopyra.com>
 <Pine.LNX.4.64.0702280830030.12485@woody.linux-foundation.org>
 <17893.44936.525606.74693@lisa.zopyra.com> <Pine.LNX.4.64.0702280843030.12485@woody.linux-foundation.org>
 <17893.45903.748382.298137@lisa.zopyra.com>
 <Pine.LNX.4.64.0702280910330.12485@woody.linux-foundation.org>
 <alpine.LRH.0.82.0702281315480.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Chuck Lever <chuck.lever@oracle.com>,
	Neil Brown <neilb@suse.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 19:39:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMThw-0000Nu-3h
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 19:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbXB1Sit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 13:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbXB1Sis
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 13:38:48 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38545 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932242AbXB1Sir (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 13:38:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1SIbUhB023964
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Feb 2007 10:37:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1SIbSJ2023090;
	Wed, 28 Feb 2007 10:37:29 -0800
In-Reply-To: <alpine.LRH.0.82.0702281315480.29426@xanadu.home>
X-Spam-Status: No, hits=-0.44 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40986>



On Wed, 28 Feb 2007, Nicolas Pitre wrote:
>
> On Wed, 28 Feb 2007, Linus Torvalds wrote:
> 
> > Well, if the return value was 0, it wasn't as odd any more, and the reason 
> > seems to be a file truncate error. Shawn seems to be on that one.
> > 
> > (The "return 305 when asked for 207" seemed like a kernel bug, which was 
> > why I got really interested ;)
> 
> I wouldn't dismiss a kernel bug just yet.
> 
> Bill already said the same operation, when not performed over NFS, works 
> just fine.
> 
> He also mentioned that version 1.4.4, which uses mmap() instead of 
> pread(), works also fine even over NFS.

Hmm.. Good point. 

I'm addign Trond, Chuck and Neil to the list, just in case there might be 
some known problem where NFS might use f_pos instead of the passed-in 
position, causing problems with pread(). Not that I can imagine how that 
could even happen or not be noticed..

Guys, this is a oldish 2.6.x kernel: "2.6.9-34.0.2.ELsmp #1 SMP Fri Jul 
7", and for some reason we have a file that appears truncated to pread() 
(returns 0) but worked with mmap and the same test-case apparently works 
on non-NFS filesystems. Any ideas? Some known bug that got fixed since?

Bill, can you make the whole strace available somewhere?

			Linus
