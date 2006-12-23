From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 11/17] Fully activate the sliding window pack access.
Date: Sat, 23 Dec 2006 12:10:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612231207400.3671@woody.osdl.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
 <20061223073428.GL9837@spearce.org> <Pine.LNX.4.64.0612231038410.3671@woody.osdl.org>
 <7vodpuqtuf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 23 21:10:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyDCp-0008A1-UG
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 21:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbWLWUKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 15:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753745AbWLWUKY
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 15:10:24 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59215 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742AbWLWUKX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 15:10:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBNKAG2J018303
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Dec 2006 12:10:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBNKAFal021028;
	Sat, 23 Dec 2006 12:10:15 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodpuqtuf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-1.151 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.165 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35330>



On Sat, 23 Dec 2006, Junio C Hamano wrote:
> 
> I have been thinking that we should perhaps change Cygwin
> default to NO_MMAP.  Safer but slower would be better than not
> working correctly for people on FAT32.

The thing is, with a smaller pack access window, it might not even be 
slower. I don't know just _how_ many hoops cygwin jumps through for mmap, 
and maybe mmap under cygwin is actually perfectly fine, but at the same 
time I do suspect that UNIX mmap semantics are a lot harder to emulate 
than just a regular "pread()", so it's quite possible that by avoiding 
mmap you could avoid a lot of complex cygwin code.

And yes, making it all work on FAT32 would obviously be a good thing.

Only testing (or somebody who knows cygwin well) can tell.

			Linus
