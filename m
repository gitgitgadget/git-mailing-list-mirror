From: Nicolas Pitre <nico@cam.org>
Subject: Re: git gc expanding packed data?
Date: Tue, 11 Aug 2009 17:33:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908111718490.10633@xanadu.home>
References: <3ace41890908041325v24ed9e2eh95ecc148305f7775@mail.gmail.com>
 <alpine.LFD.2.00.0908042203380.16073@xanadu.home>
 <3ace41890908110317k6e6ada07jc39ea446f9fa246e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Hin-Tak Leung <hintak.leung@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 23:34:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MayzE-0006cZ-HZ
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 23:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbZHKVeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 17:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbZHKVeQ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 17:34:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50023 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbZHKVeP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 17:34:15 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KO800J2PEKF0YD0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Aug 2009 17:33:51 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <3ace41890908110317k6e6ada07jc39ea446f9fa246e@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125603>

On Tue, 11 Aug 2009, Hin-Tak Leung wrote:

> On Wed, Aug 5, 2009 at 11:39 PM, Nicolas Pitre<nico@cam.org> wrote:
> > Anyway... To solve your problem, you simply need to run 'git gc' with
> > the --prune=now argument to disable that grace period and get rid of
> > those unreferenced objects right away (safe only if no other git
> > activities are taking place at the same time which should be easy to
> > ensure on a workstation).  The resulting .git/objects directory size
> > will shrink to about 441 MB.  If the gcc.gnu.org git server was doing
> > its job properly, the size of the clone transfer would also be
> > significantly smaller, meaning around 414 MB instead of the current 600+
> > MB.
> >
> > And BTW, using 'git gc --aggressive' with a later git version (or
> > 'git repack -a -f -d --window=250 --depth=250') gives me a .git/objects
> > directory size of 310 MB, meaning that the actual repository with all
> > the trunk history is _smaller_ than the actual source checkout.  If that
> > repository was properly repacked on the server, the clone data transfer
> > would be 283 MB.  This is less than half the current clone transfer
> > size.
> >
> >
> > Nicolas
> >
> 
> 'git gc --prune=now' does work, but 'git gc --prune=now --aggressive'
> (before) and 'git gc --aggressive' (after) both create very large
> (>2GB; I stopped it) packs from the ~400MB-600MB packed objects. I
> noted that you specifically wrote 'with a later git version' -
> presumably there is a some sort of a known and fixed issue there? Just
> curious.

>From git v1.6.3 the --aggressive switch makes for 'git repack' to be 
called with --window=250 --depth=250, meaning the equivalent of:

	git repack -a -d -f --window=250 --depth=250

Do you still get a huge pack with the above?

> I guess --aggressive doesn't always save space...

If so that is (and was) a bug.


Nicolas
