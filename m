From: "Art Haas" <ahaas@airmail.net>
Subject: Re: Odd behavior with git and cairo-devel repo
Date: Wed, 21 Jun 2006 07:06:18 -0500
Message-ID: <20060621120618.GR2820@artsapartment.org>
References: <20060621010030.GP2820@artsapartment.org> <20060621024605.GO11245@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 14:07:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft1U2-0004Oc-K3
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 14:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWFUMG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 08:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWFUMGz
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 08:06:55 -0400
Received: from covert.brown-ring.iadfw.net ([209.196.123.143]:40209 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S1751509AbWFUMGz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 08:06:55 -0400
Received: from cpe-24-28-121-3.houston.res.rr.com ([24.28.121.3] helo=pcdebian)
	by covert.iadfw.net with esmtp (Exim 4.24)
	id 1Ft1Z6-0004bL-MN
	for git@vger.kernel.org; Wed, 21 Jun 2006 07:12:12 -0500
Received: (qmail 25299 invoked by uid 1000); 21 Jun 2006 12:06:19 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060621024605.GO11245@skl-net.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22264>

On Wed, Jun 21, 2006 at 04:46:05AM +0200, Andre Noll wrote:
> On 20:00, Art Haas wrote:
> 
> > $ git clone git://git.cairographics.org/git/cairo cairo
> > [ ... git clones the repo without problem ... ]
> > $ cd cairo
> > $ git fsck-objects
> > Floating point exception
> 
> This is due to refs_hash_size being zero in mark_reachable().
> Both "git fsck-objects --full" and "git repack -a -d" seem to work
> fine with the patch below (tested by cloning your repo).
> 
> [ ... snip ... ]

Hi.

I see this patch has made it into git now, and it fixes the problem
described above. Thanks!

However, I'm still seeing the problem where 'git prune' leaves the
repo in an invalid state. In the case above, running 'git prune' on a
freshly checked-out repo works without problems; when the repo has a
number of unpacked objects, however, things go bad. On the FC4 machine
I have, I updated my git repo, rebuilt, and installed the build with
the patch above, then updated my cairo repo. The 'git pull' retrieved
a handful of objects, and 'git fsck-objects' ran without problem.
Then 'git prune' was run, seemingly without problem, and when I tried
'git repack -a -d' things went boom. A subsequent 'git fsck-object'
run indicated the repo was missing tree and commit objects.

Is anyone else seeing a similar problem with 'git prune'?

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
