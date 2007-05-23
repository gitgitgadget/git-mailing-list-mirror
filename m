From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Tue, 22 May 2007 21:58:34 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705222154560.3366@xanadu.home>
References: <46528A48.9050903@gmail.com> <f2uigr$ufj$1@sea.gmane.org>
 <56b7f5510705220959x1b37a4adk537cc0cba1a27530@mail.gmail.com>
 <200705230144.38290.jnareb@gmail.com> <7v3b1o758u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, Dana How <danahow@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 23 03:58:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqg7m-00040Y-Ii
	for gcvg-git@gmane.org; Wed, 23 May 2007 03:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649AbXEWB6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 21:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756273AbXEWB6p
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 21:58:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22948 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649AbXEWB6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 21:58:44 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIH002DR1HOMB20@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 22 May 2007 21:58:37 -0400 (EDT)
In-reply-to: <7v3b1o758u.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48137>

On Tue, 22 May 2007, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > No, I was thinking about separate _kept_ pack (so it would be not 
> > repacked unless -f option is given) containing _only_ the large blobs.
> > The only difference between this and your proposal is that megablobs
> > would be in their mergablobs pack, but not loose.
> 
> I am not sure about the "unless -f option is given" part, but a
> single .kept pack that contains only problematic blobs would be
> an interesting experiment.
> 
>  (0) prepare object names of problematic blobs, in huge.txt, one
>      object name per line;
> 
>  (1) prepare a single pack that has them:
> 
>      $ N=$(git-pack-object --depth=0 --window=0 pack <huge.txt)
>      $ echo 'Huge blobs -- do not repack' >pack-$N.keep
>      $ mv pack-$N.* .git/object/pack/.

If you're going to keep this pack, I think it might be worth attempting 
deltas between those blobs anyway.  If they ever deltify you'll gain in 
disk space.  And if they don't, well, you wasted the CPU cycles only 
once.  Unless you know for sure they're unlikely to deltify well.


Nicolas
