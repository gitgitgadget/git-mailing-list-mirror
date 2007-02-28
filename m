From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 09:13:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702280910330.12485@woody.linux-foundation.org>
References: <17892.64236.443170.43061@lisa.zopyra.com> <20070228035713.GC5597@spearce.org>
 <20070228044719.GA6068@spearce.org> <17893.40847.313519.283218@lisa.zopyra.com>
 <17893.42063.186763.291346@lisa.zopyra.com> <20070228155412.GC5479@spearce.org>
 <17893.43522.511785.121778@lisa.zopyra.com>
 <Pine.LNX.4.64.0702280830030.12485@woody.linux-foundation.org>
 <17893.44936.525606.74693@lisa.zopyra.com> <Pine.LNX.4.64.0702280843030.12485@woody.linux-foundation.org>
 <17893.45903.748382.298137@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 18:14:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMSNQ-0008Rm-Ri
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 18:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933188AbXB1RNl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 12:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933205AbXB1RNl
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 12:13:41 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34513 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933188AbXB1RNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 12:13:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1SHDchB021378
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Feb 2007 09:13:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1SHDbxg021042;
	Wed, 28 Feb 2007 09:13:37 -0800
In-Reply-To: <17893.45903.748382.298137@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.388 required=5 tests=AWL,OSDL_NIGERIAN_ADMISSION
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40971>



On Wed, 28 Feb 2007, Bill Lear wrote:
> >
> >Getting 305 bytes back when you asked for 207 is a bad bad bad thing. It's 
> >also really really odd and unexpected. 
> 
> You may have missed my admission that I screwed up the print: n is 0, obj->size
> was 305.

Ahh, ok. 

That means you got 0 back. That in turn means that the file seems to be 
truncated for some reason - the only valid reason to get 0 back is if the 
length of the file is smaller than the offset you're asking for data from.

> >What filesystem? And could you strace this and actually see the pread() 
> >system call?
> 
> How can I tell which filesystem?  It's Linux all around, as far as I
> know.  Here is what mount tells me about this filesystem:
> 
> storage:/storage/disk1 on /austin type nfs (rw,addr=192.168.2.192)

Yes, that's how you get the filesystem type ;)

> >(use "strace -f -o tracefile" to follow all forks and to put the end 
> >result in a trace file)
> 
> Will do ...

Well, if the return value was 0, it wasn't as odd any more, and the reason 
seems to be a file truncate error. Shawn seems to be on that one.

(The "return 305 when asked for 207" seemed like a kernel bug, which was 
why I got really interested ;)

		Linus
