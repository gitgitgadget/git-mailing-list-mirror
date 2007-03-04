From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Memory overrun in http-push.c
Date: Sun, 4 Mar 2007 03:17:31 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0703040234510.6485@iabervon.org>
References: <20070228151516.GC57456@codelabs.ru> <200703011931.32170.andyparkins@gmail.com>
 <Pine.LNX.4.63.0703012140370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200703021005.13620.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eygene Ryabinkin <rea-git@codelabs.ru>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 09:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNluT-00039b-3j
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 09:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbXCDIRe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 03:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbXCDIRe
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 03:17:34 -0500
Received: from iabervon.org ([66.92.72.58]:2471 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbXCDIRd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 03:17:33 -0500
Received: (qmail 31125 invoked by uid 1000); 4 Mar 2007 03:17:31 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Mar 2007 03:17:31 -0500
In-Reply-To: <200703021005.13620.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41349>

On Fri, 2 Mar 2007, Andy Parkins wrote:

> What about this though:
>  * Tag a release
>  * Export the working tree into a fresh directory
>  * Edit each source file to put the hash of the tagged revision into
>    every file.
>  * Edit the makefile to include the tag hash in the released version
>  * tar it up
>  * Release
> It's such a mundane, useless waste of time to edit the hash in by hand - why 
> can't the version control system do it?

Actually, how about doing keyword expansion just like the new CRLF
handling? Have the text filter replace $Id...$ with $Id$ going into the 
database, and $Id$ with $Id <info>$ coming out of the database. The info 
could even include the commit (although that might be confusing for files 
that you haven't changed since you checked them out, and when you checked 
them out, they weren't changed in that commit; the commit would be a sort 
of arbitrary choice among commits that have that file).

It seems to me like keywords fit the pattern we now have (with 
CRLF-conversion) of data which isn't tracked, but is present in working 
directory files. In the CRLF case, it's a constant character (CR), but 
there's no reason we couldn't have the non-canonical form depend on more 
information. (And we'd beat CVS/SVN for accuracy: if keyword substitution 
isn't on, nothing appears in $Id$ tags, rather than being left with 
something inaccurate).

	-Daniel
*This .sig left intentionally blank*
