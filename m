From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 13:09:17 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701301300490.20138@iabervon.org>
References: <200701292320.43888.johannes.sixt@telecom.at>
 <Pine.LNX.4.64.0701291944290.20138@iabervon.org> <45BF0098.8FF978CE@eudaptics.com>
 <Pine.LNX.4.64.0701301204400.20138@iabervon.org>
 <Pine.LNX.4.63.0701301835340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 30 19:09:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBxQE-000236-3i
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 19:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965674AbXA3SJV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 13:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965679AbXA3SJV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 13:09:21 -0500
Received: from iabervon.org ([66.92.72.58]:2083 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965674AbXA3SJU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 13:09:20 -0500
Received: (qmail 28776 invoked by uid 1000); 30 Jan 2007 13:09:18 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jan 2007 13:09:18 -0500
In-Reply-To: <Pine.LNX.4.63.0701301835340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38177>

On Tue, 30 Jan 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 30 Jan 2007, Daniel Barkalow wrote:
> 
> > On Tue, 30 Jan 2007, Johannes Sixt wrote:
> > 
> > > Daniel Barkalow wrote:
> > > > 
> > > > On Mon, 29 Jan 2007, Johannes Sixt wrote:
> > > > 
> > > > > (*) The reason is that on Windows read() and write() cannot operate on
> > > > > descriptors created by socket(). A work-around is to implement a (threaded)
> > > > > proxy, but that's almost the same as if netcat were used as
> > > > > GIT_PROXY_COMMAND.
> > > > 
> > > > Can you do
> > > > 
> > > > #define read(fd, buffer, len) recv(fd, buffer, len, 0)
> > > > #define write(fd, buffer, len) send(fd, buffer, len, 0)
> > > > 
> > > > in the appropriate file?
> > > 
> > > I doubt that recv and send can operate on regular file descriptors, as
> > > opened by _pipe(), open(), can they?
> > 
> > I don't think so, but I think it should be possible to make 
> > packet_write/packet_read always get a socket, by calling receive-pack and 
> > upload-pack with a socket pair instead of a pair of pipes.
> 
> As I already mentioned in this thread, that would break inetd support.

I was actually thinking of only using recv/send on mingw. So the rule 
could be: if git sets up the connection to a pkt_line-user itself, the 
connection is a socket; otherwise it might be a pair of pipes; if you're 
on mingw, pkt_line uses recv/send. Then everything should work except for 
inetd on mingw, and I don't think that's a plausible combination anyway.

	-Daniel
*This .sig left intentionally blank*
