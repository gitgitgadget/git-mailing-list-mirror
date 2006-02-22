From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: How to not download objects more than needed?
Date: Tue, 21 Feb 2006 22:11:36 -0500
Message-ID: <20060222031136.GN5000@delft.aura.cs.cmu.edu>
References: <43FB6C42.5000208@gorzow.mm.pl> <BAYC1-PASMTP03A58A4F389365AC85DA68AEFC0@CEZ.ICE> <Pine.LNX.4.64.0602211635450.30245@g5.osdl.org> <20060222011338.GL5000@delft.aura.cs.cmu.edu> <7v3bicupgb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 04:12:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBkPm-0007Qf-HJ
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 04:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWBVDLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 22:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWBVDLk
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 22:11:40 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:32975 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1751262AbWBVDLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 22:11:39 -0500
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1FBkPg-0004yq-00; Tue, 21 Feb 2006 22:11:36 -0500
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3bicupgb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16587>

On Tue, Feb 21, 2006 at 05:55:48PM -0800, Junio C Hamano wrote:
> Jan Harkes <jaharkes@cs.cmu.edu> writes:
> > On Tue, Feb 21, 2006 at 04:42:34PM -0800, Linus Torvalds wrote:
> >> 
> >> 	git pull git://git.kernel.org/....
> >> 
> >> and the automatic tag following kicks in, it will first have fetched the 
> >> objects once, and then when it tries to fetch the tag objects, it will 
> >> fetch the objects it already fetched _again_ (plus the tags), because it 
> >> will do the same object pull, but the temporary branch (to be merged) will 
> >> never have been written as a branch head.
> >
> > Isn't this easily avoided by fetching the tags first?
> 
> I do not think so.
> 
> Notice how the tag following code uses cat-file to determine if
> the main fetch likely has slurped the object they point at.

Neat, it only fetches tags that refer to things we already have. Hadn't
checked what the automatic tag fetcher was doing.

So either introduce temporary local refs that can be removed once the
tags have been fetched, or else fix it in fetch-pack with the following
change that might do the trick for this case as well. However that one
already got shot down because of possible consistency problems.

    http://marc.theaimsgroup.com/?l=git&m=113030081014456&w=2

Jan
