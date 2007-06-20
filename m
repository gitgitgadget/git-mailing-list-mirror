From: Nicolas Pitre <nico@cam.org>
Subject: Re: Debugging strange "corrupt pack" errors on SuSE 9
Date: Tue, 19 Jun 2007 23:33:24 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706192313290.20596@xanadu.home>
References: <46a038f90706191936m121a94e4x1e59dff4fe217988@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	jonathan.newman@catalyst.net.nz
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 05:33:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0qwh-0004QU-Em
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 05:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355AbXFTDd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 23:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758862AbXFTDd0
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 23:33:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57627 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788AbXFTDdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 23:33:25 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJX004ET0JO9C40@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 19 Jun 2007 23:33:24 -0400 (EDT)
In-reply-to: <46a038f90706191936m121a94e4x1e59dff4fe217988@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50526>

On Wed, 20 Jun 2007, Martin Langhoff wrote:

> A colleage at work is using git to manage code updates to a heavily
> firewalled machine at a client site. In a nutshell, we "push" the
> interesting code to a repo on usb-stick, and we pull from it on the
> client's machine.
> 
> We do some coding and testing on that machine, so ocassionally we
> bring some patches back.
> 
> Now the working repo on the client machine has started to die with
> "corrupt pack" errors. I am trying to get my hands on the literal
> error messages, and exact software versions installed. Right now all I
> know is that it is SuSE 9 x86, git 1.4.x, cogito .17.x . The error
> appears on git-diff, git-fsck-objects --full

The full exact error message would be highly useful indeed.

> We did bring a copy of the working copy with the "corrupt pack" to our
> office, and here git (v1.5.1 and 1.5.2) thinks it's perfectly well.
> 
> So I am a bit puzzled - while we try to get 1.5.x on the client
> machine and see what happens, is there anything that could be causing
> this? Any additional tests that we should run?

Maybe the client machine runs git version < 1.4.2.2, in which case it is 
possible that your push created a pack containing delta objects with 
offset to base which git versions prior 1.4.2.2 do not understand.

If this is the problem you are facing (the error message should confirm 
this) then the easiest solution is to upgrade git on the client.

A quick fix for the client is to set repack.usedeltabaseoffset to 
false on the machine where you have git 1.5 installed, then run "git 
repack -a -d", and finally copy the pack over to the client repository.  
But because you push to a local repository (a mounted USB stick is 
considered a local repo) then you don't get to negociate the pack 
capabilities of the final destination, and therefore more "bad" delta 
objects might sneak in again.


Nicolas
