From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Mon, 3 Apr 2006 17:12:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604031710440.9360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
 <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kees-Jan Dijkzeul <k.j.dijkzeul@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 17:13:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQQjv-0007P6-9V
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 17:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWDCPNG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 11:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbWDCPNG
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 11:13:06 -0400
Received: from mail.gmx.de ([213.165.64.20]:42718 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751659AbWDCPNF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 11:13:05 -0400
Received: (qmail invoked by alias); 03 Apr 2006 15:13:03 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp035) with SMTP; 03 Apr 2006 17:13:03 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18337>

Hi,

On Mon, 3 Apr 2006, Linus Torvalds wrote:

> On Mon, 3 Apr 2006, Johannes Schindelin wrote:
> > 
> > The problem is not mmap() on cygwin, but that a fork() has to jump through 
> > loops to reinstall the open file descriptors on cygwin. If the 
> > corresponding file was deleted, that fails. Therefore, we work around that 
> > on cygwin by actually reading the file into memory, *not* mmap()ing it.
> 
> Well, we could actually do a _real_ mmap on pack-files. The pack-files are 
> much better mmap'ed - there we don't _want_ them to be removed while we're 
> using them. It was the index file etc that was problematic.
> 
> Maybe the cygwin fake mmap should be triggered only for the index (and 
> possibly the individual objects - if only because there doing a 
> malloc+read may actually be faster).

I hit the problem *only* with "git-whatchanged -p". Which means that the 
upcoming we-no-longer-write-temp-files-for-diff version should make that 
gitfakemmap() hack obsolete. (I have not checked whether there are other 
places where a file is mmap()ed and then used by a fork()ed process.)

Ciao,
Dscho
