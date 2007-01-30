From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 12:09:22 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701301204400.20138@iabervon.org>
References: <200701292320.43888.johannes.sixt@telecom.at>
 <Pine.LNX.4.64.0701291944290.20138@iabervon.org> <45BF0098.8FF978CE@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 18:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBwU7-00079V-3I
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 18:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965615AbXA3RJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 12:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965631AbXA3RJ2
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 12:09:28 -0500
Received: from iabervon.org ([66.92.72.58]:3483 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965615AbXA3RJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 12:09:27 -0500
Received: (qmail 23664 invoked by uid 1000); 30 Jan 2007 12:09:23 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jan 2007 12:09:23 -0500
In-Reply-To: <45BF0098.8FF978CE@eudaptics.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38172>

On Tue, 30 Jan 2007, Johannes Sixt wrote:

> Daniel Barkalow wrote:
> > 
> > On Mon, 29 Jan 2007, Johannes Sixt wrote:
> > 
> > > (*) The reason is that on Windows read() and write() cannot operate on
> > > descriptors created by socket(). A work-around is to implement a (threaded)
> > > proxy, but that's almost the same as if netcat were used as
> > > GIT_PROXY_COMMAND.
> > 
> > Can you do
> > 
> > #define read(fd, buffer, len) recv(fd, buffer, len, 0)
> > #define write(fd, buffer, len) send(fd, buffer, len, 0)
> > 
> > in the appropriate file?
> 
> I doubt that recv and send can operate on regular file descriptors, as
> opened by _pipe(), open(), can they?

I don't think so, but I think it should be possible to make 
packet_write/packet_read always get a socket, by calling receive-pack and 
upload-pack with a socket pair instead of a pair of pipes. Actually, IIRC, 
this would be beneficial for making programs not leak file descriptors or 
double-close them, because there's already the issue on *nix that it isn't 
consistant whether both directions are the same file descriptor.

	-Daniel
*This .sig left intentionally blank*
