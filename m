From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 05 Apr 2009 23:34:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904052326090.6741@xanadu.home>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic>
 <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic>
 <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic>
 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
 <20090405225954.GA18730@vidovic>
 <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Apr 06 05:36:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqfd4-0004Dl-PD
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 05:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbZDFDek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 23:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbZDFDek
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 23:34:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14046 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZDFDej (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 23:34:39 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHN00IPVTXKLNA0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 05 Apr 2009 23:34:32 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115759>

On Sun, 5 Apr 2009, david@lang.hm wrote:

> On Mon, 6 Apr 2009, Nicolas Sebrecht wrote:
> 
> > On Sun, Apr 05, 2009 at 02:28:35PM -0700, david@lang.hm wrote:
> > 
> > > guys, back off a little on telling the gentoo people to change.
> > 
> > Don't blame Git people, please. I currently am the only one here to
> > discuss that way and see a painful work coming at Gentoo.
> > Git people didn't discuss around thoses issues.
> > 
> > >                                                                 the
> > > kernel developers don't split th kernel into 'core' 'drivers' etc pieces
> > > just because some people only work on one area.
> > 
> > And you might notice that they don't provide a CVS access and actually
> > don't work around an unique shared repo. Also, you might notice that
> > keeping the history clean to assure the work on the kernel easier is not
> > an elementary issue.
> 
> these issues are completely seperate from the issue that the initial poster
> asked about, which is that when someone tries to do a clone of the repository
> the system wastes a lot of time creating a new pack.

And this shouldn't be, by design.  Especially if your repo serving clone 
requests is already well packed.

What git-pack-objects does in this case is not a full repack.  It 
instead _reuse_ as much of the existing packs as possible, and only does 
the heavy packing processing for loose objects and/or inter pack 
boundaryes when gluing everything together for streaming over the net.  
If for example you have a single pack because your repo is already fully 
packed, then the "packing operation" involved during a clone should 
merely copy the existing pack over with no further attempt at delta 
compression.

> don't worry about this part of things, worry about why the server wastes so
> many resources.

Indeed.  And since a significant amount of code involved happens to be 
mine, I do wonder.


Nicolas
