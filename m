From: Nicolas Pitre <nico@cam.org>
Subject: Re: Do not use zlib 1.1.3 with git packs!
Date: Fri, 28 Apr 2006 23:20:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604282316520.18816@localhost.localdomain>
References: <Pine.LNX.4.63.0604290245510.30565@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0604290341380.22696@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 29 05:20:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZg0i-0003jJ-El
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 05:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWD2DUb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 23:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWD2DUa
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 23:20:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27277 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932477AbWD2DUa
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 23:20:30 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYG00BWQRY5SV80@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 28 Apr 2006 23:20:29 -0400 (EDT)
In-reply-to: <Pine.LNX.4.63.0604290341380.22696@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@localhost.localdomain
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19291>

On Sat, 29 Apr 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Sat, 29 Apr 2006, Johannes Schindelin wrote:
> 
> > Upgrading to zlib 1.2.3 helped.
> 
> Apparently I was too enthusiastic to have a working system again.
> 
> The problem showed again, but with a different repository.
> 
> This time, though, I have an idea what could be the culprit.
> 
> In create_delta(), there might be illegal accesses. The function adler32() 
> is called for BLK_SIZE bytes (which is 16 bytes at the moment), starting 
> from data, which is initially trg_buf, and is incremented until it is 
> (trg_buf + trg_size).
> 
> I gather that close to the end, adler32() tries to read 15 bytes after the 
> end of the allocated target buffer.
> 
> Am I wrong?

You're not.  My bad.

(I'm testing a version where adler32 has been replaced with rabin 
 polynomial so that issue will be gone at the same time.
 A patch should be coming in less than an hour.)


Nicolas
