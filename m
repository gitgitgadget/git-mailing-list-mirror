From: Nicolas Pitre <nico@cam.org>
Subject: Re: Debugging corrupt object generation
Date: Thu, 01 Nov 2007 19:57:00 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0711011947220.21255@xanadu.home>
References: <Pine.LNX.4.64.0711012256080.17812@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Nov 02 00:57:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InjuW-0004jR-6V
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 00:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993AbXKAX5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 19:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753678AbXKAX5E
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 19:57:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31665 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759315AbXKAX5D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 19:57:03 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQU00KS8QJ06P80@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Nov 2007 19:57:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.LNX.4.64.0711012256080.17812@beast.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63037>

On Thu, 1 Nov 2007, Julian Phillips wrote:

> I have been trying to import a repository using fast-import, and as part of
> this I have extended fast-import to support copying a path from any arbitrary
> commit.  This works fine on my small test repository.
> 
> However, when I run against my (vastly more complicated) real work repository
> things don't go so well.  I get a few thousand commits in, and then it breaks.
> It appears that I have somehow managed to create a corrupt object or
> something.
> 
> After a certain commit, and attempt to use that commit generates a "fatal:
> unable to apply delta".  This appears to be coming from unpack_delta_entry
> in sha1_file.c.

I suppose you mean "fatal: failed to apply delta", because "unable to 
apply delta" doesn't appear anywhere in the current source tree.

> Can anyone give me any hints as to how I find out what is causing the
> problem?  I'm not even sure what it is that isn't working ... and all
> attempts to replicate the problem with my test repository have failed.

Well, something is screwed for sure.  Some object you're requesting is 
made of a delta, and that delta is bad, therefore patch_delta() returns 
NULL (you could instrument it to determine exactly why).

Maybe fast-import hasn't flushed the needed data to the pack yet?


Nicolas
