From: Johan Herland <johan@herland.net>
Subject: Re: error: char103: premature end of data
Date: Fri, 08 Jun 2007 01:47:50 +0200
Message-ID: <200706080147.50207.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706080105.28102.johan@herland.net>
 <Pine.LNX.4.64.0706080023450.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 01:48:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwRhw-0001WM-5P
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 01:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbXFGXrx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 19:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933605AbXFGXrx
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 19:47:53 -0400
Received: from [84.208.20.33] ([84.208.20.33]:65240 "EHLO smtp.getmail.no"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753623AbXFGXrw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 19:47:52 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJA00101I3RND00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 01:47:51 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJA00H7AI3QH210@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 01:47:50 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJA0015OI3QTS60@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 01:47:50 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0706080023450.4046@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49414>

On Friday 08 June 2007, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 8 Jun 2007, Johan Herland wrote:
> 
> > On Friday 08 June 2007, Johannes Schindelin wrote:
> >
> > > I just tried to fetch from one of my repos which was perfectly usable 
> > > (and fetchable) before, and got this error message:
> > > 
> > > 	error: char103: premature end of data
> > 
> > Sorry about that. Do you have an idea of which tag object caused the 
> > failure? If so, could you send the output of "git-cat-file tag <name>" 
> > on it?
> 
> Yes, I know what causes it. A tag with an empty message.

Of course. Although if one uses git-tag -a to create an annotated tag object 
I have a hard time seeing why one wouldn't supply a message. But it's of 
course entirly valid not to supply a message.

> And I even know why it does that. It's easy. Look into git-tag.sh, and you 
> will find that it does a git-stripspace on the final message. If that was 
> empty, then the tag will just be the tag header.

You're right. I'll fix my code to handle this case. I'll also try to split
that first patch in my series into more manageable chunks.

> > git-fsck on the repo should report the same error. If you run with -v 
> > (verbose) you should also get some hints as to which tag object causes 
> > this.
> 
> Yes, it finds the error. And crashes. And costs me time.
> 
> Why do we have to parse _everything_ in the tag to begin with? It's not 
> like I will show the information of the darn thing when I just fetch it 
> from repo A into repo B.

We parse the tag completely in order to detect corruption/invalid tags as 
early as possible. If I'm pulling from a corrupt repo, I'd sure as hell 
want git to tell me when I first fetched, and not a couple of weeks later 
when I'd try to use the corrupt data, or call fsck, or whatever.

Again, I'm sorry for your problems.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
