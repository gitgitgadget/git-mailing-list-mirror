From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Fri, 10 Apr 2009 21:58:11 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904102147590.6741@xanadu.home>
References: <alpine.LFD.2.00.0904052315210.6741@xanadu.home>
 <20090407081019.GK20356@atjola.homenet> <m3tz5023rq.fsf@localhost.localdomain>
 <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
 <20090407142147.GA4413@atjola.homenet>
 <alpine.LFD.2.00.0904071321520.6741@xanadu.home>
 <20090407181259.GB4413@atjola.homenet>
 <alpine.LFD.2.00.0904071454250.6741@xanadu.home>
 <20090407202725.GC4413@atjola.homenet>
 <alpine.LFD.2.00.0904080041240.6741@xanadu.home>
 <20090410T203405Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sat Apr 11 03:59:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsSVd-0002jp-5A
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 03:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbZDKB6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 21:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbZDKB6S
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 21:58:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39554 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbZDKB6R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 21:58:17 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHW00FL3YSZ36F0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 10 Apr 2009 21:58:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090410T203405Z@curie.orbis-terrarum.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116289>

On Fri, 10 Apr 2009, Robin H. Johnson wrote:

> On Wed, Apr 08, 2009 at 12:52:54AM -0400, Nicolas Pitre wrote:
> > > http://git.overlays.gentoo.org/gitweb/?p=exp/gentoo-x86.git;a=summary
> > > At least that's what I cloned ;-) I hope it's the right one, but it fits
> > > the description...
> > OK.  FWIW, I repacked it with --window=250 --depth=250 and obtained a 
> > 725MB pack file.  So that's about half the originally reported size.
> The one problem with having the single large packfile is that Git
> doesn't have a trivial way to resume downloading it when the git://
> protocol is used.

Having multiple packs won't help the git:// protocol at all in that 
regard.  In fact it'll just make it a bit harder on the server for all 
cases, which has to generate a single pack for streaming anyway by using 
multiple source ones and perform extra work in attempting delta 
compression across pack boundaries.

> For our developers cursed with bad internet connections (a fair number
> of firewalls that don't seem to respect keepalive properly), I suppose
> I can probably just maintain a separate repo for their initial clones,
> which leaves a large overall download, but more chances to resume.

I don't know much about git's http protocol implementation, but I guess 
it should be able to resume the transfer of a pack file which might have 
been interrupted in the middle?  If no then this should be considered.

> PS #1: B.Steinbrink's memory improvement patch seems to work nicely too,
> but more memory improvements in that realm are still needed.

Good.

> PS #2: We finally got some newer hardware to run the large repo, I'm
> working on the install now, but until the memory issue is better
> resolved, I'm still worried we might run short if there are too many
> concurrent clones.

Right.


Nicolas (who wishes he could dedicate more time to git hacking)
