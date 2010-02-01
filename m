From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: pack.packSizeLimit, safety checks
Date: Mon, 01 Feb 2010 13:04:35 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002011240510.1681@xanadu.home>
References: <loom.20100201T101056-232@post.gmane.org>
 <alpine.LFD.2.00.1002011100550.1681@xanadu.home>
 <7vvdeg50x4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 19:04:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc0dk-0004Cj-9S
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 19:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592Ab0BASEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 13:04:37 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63938 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab0BASEh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 13:04:37 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX600EMICVO0U00@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 01 Feb 2010 13:04:36 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vvdeg50x4.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138633>

On Mon, 1 Feb 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Grrrrr.  This is a terrible discrepency given that all the other 
> > arguments in Git are always byte based, with the optional k/m/g suffix, 
> > by using git_parse_ulong().  So IMHO I'd just change --max-pack-size to 
> > be in line with all the rest and have it accept bytes instead of MB.  
> > And of course I'd push such a change to be included in v1.7.0 along with 
> > the other incompatible fixes.
> 
> All of the "other incompatible" changes had ample leading time for
> transition with warnings and all.
> 
> I am afraid that doing this "unit change" is way too late for 1.7.0, and
> it makes me somewhat unhappy to hear such a suggestion.  It belittles all
> the careful planning that has been done for these other changes to help
> protect the users from transition pain.
> 
> Introduce --max-pack-megabytes that is a synonym for --max-pack-size for
> now, and warn when --max-pack-size is used; warn that --max-pack-size will
> count in bytes in 1.8.0. Ship 1.7.0 with that change.  --max-pack-bytes
> can also be added if you feel like, while at it.
> 
> But changing the unit --max-pack-size counts in to bytes in 1.7.0 feels
> a bit too irresponsible for the existing users.

Thing is... I don't know if the --max-pack-size argument is really that 
used.  I'd expect people relying on that feature to use the config 
variable instead, given that 'git gc' has no idea about --max-pack-size 
anyway.  People using the --max-pack-size argument directly are probably 
doing so only to experiment with it, and then setting the config 
variable, probably using the wrong unit.  The fact that such a 
discrepancy just came to our attention after all the time this feature 
has existed is certainly a good indicator of its popularity.

I understand the really unfortunate timing for such a change.  OTOH 
there is a big advantage to bundle as much incompatibilities together at 
the same time, as people will be prepared for such things already.

While I share your concern for advance warning and such, I think those 
concerns are worth an effort proportional to the depth of user exposure.  
Like for the THREADED_DELTA_SEARCH case, I'm wondering how much pain if 
at all might be saved with a transition plan vs the cost of maintaining 
that plan and carrying the discrepancy further.


Nicolas
