From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 06 Apr 2009 09:29:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904060912530.6741@xanadu.home>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic>
 <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic>
 <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic>
 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
 <20090405225954.GA18730@vidovic>
 <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
 <alpine.LFD.2.00.0904052326090.6741@xanadu.home>
 <vpq3acm6n7p.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: david@lang.hm, Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 06 15:32:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqovZ-0007Yk-8C
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbZDFN3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 09:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754906AbZDFN3N
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:29:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11843 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbZDFN3M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:29:12 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHO00MIKLGG15B0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Apr 2009 09:29:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpq3acm6n7p.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115823>

On Mon, 6 Apr 2009, Matthieu Moy wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > If for example you have a single pack because your repo is already fully 
> > packed, then the "packing operation" involved during a clone should 
> > merely copy the existing pack over with no further attempt at delta 
> > compression.
> 
> There's still the question if your repository has too many objects
> (for example, a branch that you deleted without garbage-collecting
> it). Then, sending the whole pack sends data that one may have
> considered as "secret".

I said "merely copy", which is not a straight copy.  In this case, only 
the relevant objects from the existing pack will be copied into the 
streamed pack, and objects from the unused branch will be left behind.  
In that case, deltas which base object is left behind will automatically 
be considered for alternative delta matching of course, but that is 
normally a relatively small set of objects.  And if that set gets really 
big, that means that an even bigger set of objects was left behind, 
making the actual repacking smaller in scope.

> To me, this is a non-issue (if the content of these objects are
> secret, then why are they here at all on a public server?), but I
> think there were discussions here about it (can't find the right
> keywords to dig the archives though), and other people may think
> differently.

Guess who was involved in that discussion...

I may allow you to pull certain branches directly from my own PC through 
the git native protocol.  That doesn't mean you have direct access to 
the whole of any of the packs I have on my disk.


Nicolas
