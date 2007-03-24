From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git / Subversion Interoperability
Date: Sat, 24 Mar 2007 13:37:40 -0700
Message-ID: <7vfy7ufkdn.fsf@assigned-by-dhcp.cox.net>
References: <20070322224829.GA7048@c3sl.ufpr.br>
	<20070323004335.GA17773@spearce.org>
	<Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk>
	<20070323012422.GC17773@spearce.org>
	<Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk>
	<20070323103426.GA15923@diana.vm.bytemark.co.uk>
	<20070324064130.GC25863@spearce.org>
	<20070324185517.GA10876@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.64.0703241258560.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 24 21:37:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVCzh-0004Ga-3E
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 21:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbXCXUhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 16:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933078AbXCXUhm
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 16:37:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52231 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932716AbXCXUhl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 16:37:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070324203741.XQRV748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 24 Mar 2007 16:37:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ekdg1W0041kojtg0000000; Sat, 24 Mar 2007 16:37:41 -0400
In-Reply-To: <Pine.LNX.4.64.0703241258560.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 24 Mar 2007 13:13:06 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43018>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So if your .gitignore looks like
>
> 	*.o
>
> it means that it recursively ignores all *.o files starting at that level.
>
> HOWEVER, if you write it as
>
> 	/*.o
>
> it means that it ignores *.o files only *within* that level (so it's 
> "absolute" wrt the particular .gitignore file, not globally).
>
> So you can have both behaviours.
>
> [ I think the exact behaviour is: if there is a '/' anywhere in the name, 
>   it's not a recursive match and has to match the file exactly, but 
>   somebody like Junio should probably back me up on that ]
> 		Linus

Yes, that is what dir.c::excluded_1() says.  If it does not have
'/' then fnmatch the basename, otherwise fnmatch with
FNM_PATHNAME.  So I think if you write

               /obj/*.o

you can ignore *.o files in obj/ directory (but won't ignore a/obj/b.o).
