From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 14 Apr 2009 17:02:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904141648370.6741@xanadu.home>
References: <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
 <20090407142147.GA4413@atjola.homenet>
 <alpine.LFD.2.00.0904071321520.6741@xanadu.home>
 <20090407181259.GB4413@atjola.homenet>
 <alpine.LFD.2.00.0904071454250.6741@xanadu.home>
 <20090407202725.GC4413@atjola.homenet>
 <alpine.LFD.2.00.0904080041240.6741@xanadu.home>
 <20090410T203405Z@curie.orbis-terrarum.net>
 <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904141542161.6741@xanadu.home>
 <20090414T202206Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Apr 14 23:04:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtpnW-0006cB-NX
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 23:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683AbZDNVCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 17:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754435AbZDNVCb
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 17:02:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14547 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbZDNVCa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 17:02:30 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KI3003HUZQ96BO2@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 14 Apr 2009 17:01:21 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090414T202206Z@curie.orbis-terrarum.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116571>

On Tue, 14 Apr 2009, Robin H. Johnson wrote:

> More recent discussions raised the possibility of using git-bundle to
> provide a more ideal initial download that they CAN resume easily, as
> well as being able to move on from it.
> 
> So, from the Gentoo side right now, we're looking at this:
> 1. Setup git-bundle for initial downloads.
> 2. Disallow initial clones over git:// (allow updates ONLY)
> 3. Disallow git-over-http, git-over-rsync.
> 
> This also avoids the wait time with the initial clone. Just grab the
> bundle with your choice of rsync or http, check it's integrity, throw it
> into your repo, and update to the latest tree.

This certainly makes lots of sense until we overcome the current clone 
bothleneck.  You should tightly repack your repository first, like with
"git repack -a -f -d --depth=100 --window=500".  Use a fast machine with 
enough ram of course.  Then you'll have a nice and small bundle.

Of course any git pack/bundle has full self-integrity built in.  So you 
should not need to do a separate check.

And don't forget to delete the bundle once it has been fetched into a 
full repository, otherwise it'll only wastes disk space.


Nicolas
