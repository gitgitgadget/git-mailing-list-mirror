From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Reduce the number of connects when fetching
Date: Sat, 26 Jan 2008 16:37:34 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801261635230.13593@iabervon.org>
References: <alpine.LNX.1.00.0801251326260.13593@iabervon.org> <alpine.LSU.1.00.0801261734360.23907@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 26 22:38:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIsj1-0005ov-34
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 22:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354AbYAZVhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 16:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754335AbYAZVhg
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 16:37:36 -0500
Received: from iabervon.org ([66.92.72.58]:46629 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853AbYAZVhg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 16:37:36 -0500
Received: (qmail 31547 invoked by uid 1000); 26 Jan 2008 21:37:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Jan 2008 21:37:34 -0000
In-Reply-To: <alpine.LSU.1.00.0801261734360.23907@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71790>

On Sat, 26 Jan 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 25 Jan 2008, Daniel Barkalow wrote:
> 
> > This shares the connection between getting the remote ref list and 
> > getting objects in the first batch. (A second connection is still used 
> > to follow tags)
> 
> I applied this locally, and now I get a few "fatal: The remote end hung up 
> unexpectedly" errors; when I started "git fetch" in a gdb session, it did 
> not stop at die_builtin(), which leads me to believe that the error comes 
> from upload-pack.
> 
> Any ideas?

In fact, it seems to me that quickfetch short-circuits the fetch portion 
of the connection, and, if it takes care of everything (i.e., there's 
nothing to do), the connection gets dropped while the remote is still 
expecting communication. Essentially harmless but wrong, and I'll clean it 
up.

	-Daniel
*This .sig left intentionally blank*
