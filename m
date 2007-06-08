From: Nicolas Pitre <nico@cam.org>
Subject: Re: fatal: serious inflate inconsistency
Date: Fri, 08 Jun 2007 09:48:42 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706080931330.12885@xanadu.home>
References: <20070608110536.GD2335@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 15:48:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hweph-000640-LO
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 15:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937359AbXFHNsu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 09:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936973AbXFHNsu
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 09:48:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25888 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbXFHNst (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 09:48:49 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJB006ZUL16MHC0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 08 Jun 2007 09:48:42 -0400 (EDT)
In-reply-to: <20070608110536.GD2335@cip.informatik.uni-erlangen.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49475>

On Fri, 8 Jun 2007, Thomas Glanzmann wrote:

> Hello,
> and here is another one I guess: ;-(
> 
>         (tomcat-05) [/usr/src] git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>         Initialized empty Git repository in /usr/src/linux-2.6/.git/
>         remote: Generating pack...
>         remote: Done counting 496911 objects.
>         remote: Deltifying 496911 objects...
>         remote:  100% (496911/496911) done
>         Indexing 496911 objects...
>         remote: Total 496911 (delta 401539), reused 493712 (delta 398653)
>         100% (496911/496911) done
>         Resolving 401539 deltas...
>         fatal: serious inflate inconsistency
>         fatal: index-pack died with error code 128
>         fetch-pack from
>         'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed.
>         (tomcat-05) [/usr/src] git version
>         git version 1.5.2.1

This is bad.

index-pack works like this:

1) it receives data over the network:
   1a) it writes a copy of that data to disk to create a pack
   1b) it deflates that data in parallel to compute its SHA1

2) when done, it resolves deltas and to do so:
   2a) it deflates the base object data from 1a
   2b) it applies the delta over the base object data then compute its 
       SHA1

In your case it seems that 1B and 2A don't produce the same deflated 
data somehow.

Is it reproducible?
Are you using Linux?  What kernel version?
Are you using NFS?

If it isn't reproducible then you might possibly have been the victim of 
faulty hardware.


Nicolas
