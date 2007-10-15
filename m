From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 02:22:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710150217120.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
  <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
  <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> 
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> 
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eli Zaretskii <eliz@gnu.org>, Alex Riesen <raa.lkml@gmail.com>,
	ae@op5.se, tsuna@lrde.epita.fr, make-w32@gnu.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 03:23:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhEfl-0004WV-I0
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 03:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbXJOBW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 21:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbXJOBW7
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 21:22:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:58138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753994AbXJOBW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 21:22:58 -0400
Received: (qmail invoked by alias); 15 Oct 2007 01:22:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 15 Oct 2007 03:22:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+kgrRSRI6kYqrhFq4FhN4SV271xblXGlLfSIA/8p
	SvL7a1/IUiL0ZM
X-X-Sender: gene099@racer.site
In-Reply-To: <4712B616.165BBF8D@dessent.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60933>

Hi,

On Sun, 14 Oct 2007, Brian Dessent wrote:

> Johannes Schindelin wrote:
> 
> > The problem is that on Windows, you cannot keep a file open and delete 
> > it at the same time.  This is an issue in Windows' equivalent of VFS.
> > 
> > A neat trick to work with temporary files without permission issues is 
> > to open the file and delete it right after that.  This does not work 
> > on Windows.
> 
> You can achieve the same thing on Windows with CreateFile() by setting 
> the dwShareMode parameter to zero and setting the 
> FILE_FLAG_DELETE_ON_CLOSE attribute on dwFlagsAndAttributes.  This 
> results in a file that cannot be opened or read by any other process and 
> that will be automatically deleted when all open handles are closed.

Aha.  So to support Windows, we have to wrap all sites that use that 
trick, and special case that #ifdef __MINGW32__. 

> > I think Alex means this: you can have C:\a\b\c and D:\a\b\c.  So 
> > depending on which drive you are, you mean one or the other.  Just 
> > comparing the paths is not enough.
> 
> This just means that you have to consider the drive letter as part of 
> the filename.

So to support Windows, we have to special case having a ":" as second 
character in the filename.

> > > > - no real "mmap" (which kills perfomance and complicates code)
> > >
> > > You only need mmap because you are accustomed to use it on GNU/Linux.
> > 
> > Yes.  And we rely on the performance very much.
> 
> Windows may not call it mmap() but it most certainly has memory-mapped
> file IO:
> <http://msdn2.microsoft.com/en-us/library/aa366781.aspx#file_mapping_functions>.

Yes, but there are still incompatibilities with POSIX.  Again, when you 
did not close the file, you cannot delete (or rename) it.  So, to support 
Windows, ...

All this supporting Windows business is certainly possible, if tedious.

Ciao,
Dscho
