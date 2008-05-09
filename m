From: Nicolas Pitre <nico@cam.org>
Subject: Re: git gc & deleted branches
Date: Fri, 09 May 2008 12:12:22 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805091205580.23581@xanadu.home>
References: <20080508210125.GC32762@sigill.intra.peff.net>
 <alpine.LFD.1.10.0805081712270.23581@xanadu.home>
 <20080508211734.GA819@sigill.intra.peff.net>
 <48236F69.2060900@nrlssc.navy.mil>
 <20080508213107.GA1016@sigill.intra.peff.net>
 <48237344.6070405@nrlssc.navy.mil>
 <20080508214454.GA1939@sigill.intra.peff.net>
 <48237650.5060008@nrlssc.navy.mil>
 <20080508224827.GA2938@sigill.intra.peff.net>
 <loom.20080509T011318-478@post.gmane.org>
 <20080509041921.GA14773@sigill.intra.peff.net>
 <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com>
 <48246A44.7020303@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Geert Bosch <bosch@adacore.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri May 09 18:14:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuVDr-00013u-F9
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 18:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbYEIQMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 12:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbYEIQMh
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 12:12:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33111 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbYEIQMg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 12:12:36 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0L00FP2ZO5H1A0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 May 2008 12:12:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <48246A44.7020303@nrlssc.navy.mil>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81620>

On Fri, 9 May 2008, Brandon Casey wrote:

> Geert Bosch wrote:
> > 
> > On May 9, 2008, at 00:19, Jeff King wrote:
> > 
> >> I like it. It makes an easy rule to say "packed objects _never_ get
> >> pruned, they only get demoted to loose objects." And then of course
> >> we have sane rules for pruning loose objects.
> > 
> > Isn't there an issue with the "git gc" triggering because there
> > may be too many loose unreferenced objects?
> > Still, I do like the approach.
> 
> This would be an argument for going the extra mile and having the loose
> objects adopt the timestamp of their pack file. In the normal case they
> would probably be pruned immediately during the same git-gc run.

Well, not necessarily.  If you created a large branch yesterday and you 
are deleting it today, then if you repacked in between means that those 
loose objects won't be more than one day old.  Yet there could be enough 
of them to trigger auto gc.  But that auto gc won't pack those objects 
since they are unreferenced.  Hence auto gc will trigger all the time 
without making any progress.

> > Maybe unreferenced objects and old refs should go to a .git/lost+found
> > directory and be expired from there. This has a couple of benefits:
> 
> >   -  Objects will not be accessible by ordinary git commands for a while,
> >      before they are really removed, avoiding surprises
> 
> Unreferenced objects are sometimes used by other repositories which have
> this repository listed as an alternate. So it may not be a good idea to
> make the unreferenced objects inaccessible.

Nah.  If this is really the case then you shouldn't be running gc at all 
in the first place.


Nicolas
