From: Nicolas Pitre <nico@cam.org>
Subject: Re: Debugging strange "corrupt pack" errors on SuSE 9
Date: Wed, 20 Jun 2007 01:01:54 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706200053520.20596@xanadu.home>
References: <46a038f90706191936m121a94e4x1e59dff4fe217988@mail.gmail.com>
 <alpine.LFD.0.99.0706192313290.20596@xanadu.home>
 <46a038f90706192117x53420c04o27f05e8fa6c338a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	jonathan.newman@catalyst.net.nz
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 07:02:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0sL1-0006kx-1D
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 07:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758853AbXFTFB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 01:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755905AbXFTFB4
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 01:01:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27317 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762079AbXFTFBz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 01:01:55 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJX008EL4N6DL80@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 20 Jun 2007 01:01:55 -0400 (EDT)
In-reply-to: <46a038f90706192117x53420c04o27f05e8fa6c338a5@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50530>

On Wed, 20 Jun 2007, Martin Langhoff wrote:

> On 6/20/07, Nicolas Pitre <nico@cam.org> wrote:
> > Maybe the client machine runs git version < 1.4.2.2, in which case it is
> > possible that your push created a pack containing delta objects with
> > offset to base which git versions prior 1.4.2.2 do not understand.
> 
> Ouch. We weren't supposed to have non-backwards compatible changes...

Well... to be fair, we should say that your setup is a bit non 
conventional.

> > If this is the problem you are facing (the error message should confirm
> > this) then the easiest solution is to upgrade git on the client.
> 
> Ha ha. Not particularly easy, unfortunately.
> 
> > A quick fix for the client is to set repack.usedeltabaseoffset to
> > false on the machine where you have git 1.5 installed, then run "git
> > repack -a -d", and finally copy the pack over to the client repository.
> 
> That'll be a bit easier -- it's a fix we can do on the transfer repo
> ourselves.
> 
> Thanks! I do wonder though -- isn't a backwards-incompatible change
> like this worthy of don't we bump core.repositoryformatversion?

The repository hasn't really changed, and even such a version bump 
wouldn't help you anyway.

I also note that you're using cogito.  And from what I can deduce, it 
seems that cogito is simply copying the pack(s) over without further 
sanity checks.  This only serves to muddy things even further.

If your client machine is so important then you should consider 
upgrading to a later git version, and stop using cogito.  It will solve 
this pack problem, and you'll get added pack sanity checks as a bonus.


Nicolas
