From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 5 Jan 2007 15:17:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701051515000.3661@woody.osdl.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
 <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
 <7v1wmalez6.fsf@assigned-by-dhcp.cox.net> <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
 <7vbqldfg56.fsf@assigned-by-dhcp.cox.net> <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
 <20070105193958.GE8753@spearce.org> <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
 <204011cb0701051503m3a431e07qc12662eecc08884f@mail.gmail.com>
 <7v64bldqas.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Lee <chris133@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 00:17:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2yJi-0004s8-N6
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 00:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbXAEXRk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 18:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbXAEXRk
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 18:17:40 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41412 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbXAEXRj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 18:17:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l05NHVWi013016
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 Jan 2007 15:17:32 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l05NHUAv007447;
	Fri, 5 Jan 2007 15:17:31 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64bldqas.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.67 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36045>



On Fri, 5 Jan 2007, Junio C Hamano wrote:
> 
> The problem Linus pointed out was that your SHA1_Update()
> implementations may not be prepared to hash the whole 2.3GB in
> one go.  The one in "master" (and "maint", although I haven't
> done a v1.4.4.4 maintenance release yet) calls SHA1_Update()
> in chunks to work around that potential issue.

Well, I think Chris is worried about having it all mapped at the same 
time.

It does actually end up forcing the kernel to do more work (it's harder to 
re-use a mapped page than it is to reuse one that isn't), and in that 
sense, if you have less than <n> GB of RAM and can't just keep it all in 
memory at the same time, doing one large mmap is possibly more expensive 
than chunking things up.

That said, I doubt it's a huge problem. If you can't fit the whole file in 
memory, your real performance issue is going to be the IO, not the fact 
that the kernel has to work a bit harder at unmapping pages ;)

		Linus
