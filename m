From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Tue, 17 Oct 2006 11:53:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610171141510.3962@g5.osdl.org>
References: <7vvemjmlo2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171005370.3962@g5.osdl.org> <7v64eikdp2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 20:54:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZu4L-0001FO-QW
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 20:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWJQSxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 14:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWJQSxh
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 14:53:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7903 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751425AbWJQSxh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 14:53:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9HIrKaX026032
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Oct 2006 11:53:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9HIrJ3b000497;
	Tue, 17 Oct 2006 11:53:19 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64eikdp2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.475 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29104>



On Tue, 17 Oct 2006, Junio C Hamano wrote:
> 
> Eh, stupid-and-obvious like this perhaps.

I'm not convinced that is enough. You need to make the individual 
xdiff/*.c files depend on the xdiff/*.h files, because otherwise it will 
think that the *.o files are up-to-date and just re-link the archive.

The kernel does automatic dependency generation for all the *.c files, and 
it's _really_ nice. Having to do dependencies by hand is just always going 
to suck. But the kernel can depend on more things (in particular, the 
kernel can depend on gcc, and use things like "-MD,$(depfile)" to generate 
lists of dependencies while building, so that any object file _always_ has 
the things it depended upn explicitly listed).

But in the absense of those kinds of really clever and powerful tricks, it 
might be worthwhile to even just have a "mkdepend" scrupt thing and 
include the end result into the Makefile (we do already depend on GNU 
make).

That would allow us to get the real dependencies (and minimal! right now 
we sometimes compile too _much_ just because some of our dependencies are 
so screwed up and lazy).

			Linus
