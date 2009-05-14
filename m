From: Nicolas Pitre <nico@cam.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 14 May 2009 14:13:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905141353040.6741@xanadu.home>
References: <200905122329.15379.jnareb@gmail.com>
 <20090512233450.GY30527@spearce.org> <200905141024.17525.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 20:13:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4fRD-0001ZK-AW
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 20:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbZENSNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 14:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbZENSNd
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 14:13:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57694 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbZENSNc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 14:13:32 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KJN00LH0BY92V61@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 May 2009 14:13:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200905141024.17525.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119207>

On Thu, 14 May 2009, Jakub Narebski wrote:

> I was afraid of this: that the people who know pack protocol good
> enough to be able to write it down are otherwise busy. But we get
> detailed / updated packfile and pack index format descriptions some
> time ago (thanks all that contributed to it!). I hope that the same
> would happen with pack _protocol_ description.

If someone with the wish for such a document volunteers to work on it 
then I'm sure people with fuller knowledge will review and comment on 
the result as appropriate.

> I was hoping of document in RFC format; dreaming about having it
> submitted to IETF as (at least) unofficial RFC like Atom Publication
> Protocol (or is it proper RFC these days?), and then accepted like
> HTTP protocol.

I think we'd have to move to a new version of the protocol for that.  
The current protocol, even if it does the job, is not particularly 
elegant.

> > And lets not even start to mention Dulwich not completing a thin
> > pack before storing it on disk.  Those sorts of on disk things
> > matter to other more popular Git implementations (c git, jgit).
> 
> Ugh! Errr... aren't thin packs send only if other side has the
> capability for it? What is then Dulwich doing announcing such 
> capability when not supporting it correctly...

They probably don't bother because in theory you don't need to complete 
a thin pack for the system to still work.  We require that any pack 
never contain a delta which base object is in a different pack because 
that makes for better performances when accessing the pack and when 
repacking.  And not doing so makes pack validation (think verify-pack) 
impossible without the dependent objects, and that makes incremental 
repacking much much harder wrt prevention of delta cycles.

Those validation tools from C git (fsck, verify-pack, etc.) should be 
quite useful for people wishing to implement their own git.


Nicolas
