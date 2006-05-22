From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Sun, 21 May 2006 21:50:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
 <20060520203911.GI6535@nowhere.earth> <446F95A2.6040909@gentoo.org>
 <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org> <446FA262.7080900@gentoo.org>
 <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org> <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>
 <44713BE4.9040505@gentoo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 22 06:51:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi2Nv-0001v0-2W
	for gcvg-git@gmane.org; Mon, 22 May 2006 06:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWEVEvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 00:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWEVEvM
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 00:51:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61060 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751181AbWEVEvM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 00:51:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4M4oqtH017692
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 May 2006 21:50:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4M4oo2B016143;
	Sun, 21 May 2006 21:50:50 -0700
To: Donnie Berkholz <spyderous@gentoo.org>
In-Reply-To: <44713BE4.9040505@gentoo.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20481>



On Sun, 21 May 2006, Donnie Berkholz wrote:
> 
> Fortunately the storms haven't been that bad down in Corvallis. cvsps
> also worked fine for me, but git-cvsimport broke in the middle.

Hmm. It's actually possible that it did that for me too - I had put the 
cvsimport in an xterm and forgotten about it, and just assumed that the 
power failure was what broke it. But maybe it had broken down before that 
happened - I just don't have any logs left ;)

> Here's the last bits:
> 
> [ snip snip ]
> Commit ID 7a36de9c4c9b93337ed789ae2341cad3d0991c6d
> Unknown: error  Cannot allocate memory
> Fetching profiles/package.mask   v 1.992
> cat: write error: Broken pipe

Hmm. I don't actually know perl, and my original "cvsimport" script was 
actually this funny C program that generated a shell script to do the 
import. That worked fine, and had no memory leaks, but it was a truly 
hacky thing of horrible beauty. Or rather, it _would_ have been that, if 
it had had any beauty to be horrible about. But at least I would have been 
able to debug it.

But the perl one I can't parse any more. That said, the whole "Unknown:" 
printout seems to come from the subroutine "_line()", which just reads a 
line from the cvs server.

Did you do a "top" at any time just before this all happened? It _sounds_ 
like it might actually be a memory leak on the CVS server side, and the 
problem may (or may not) be due to the optimization that keeps a single 
long-running CVS server instance for the whole process.

I wouldn't be in the least surprised if that ends up triggering a slow 
leak in CVS itself, and then CVS runs out of memory.

That would likely have been obvious in any "top" output just before the 
failure.

Smurf, Martin, Dscho.. Any ideas? My old script just ran RCS directly on 
the files, and had no issues like that. I'll happily admit that my old 
script generator thing was horrible, but it was a lot easier to debug than 
the smarter perl script that uses a CVS server connection..

		Linus
