From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/5] autoconf: Preliminary check for working mmap
Date: Tue, 5 Sep 2006 02:25:31 -0400
Message-ID: <20060905062531.GA30496@spearce.org>
References: <200609050054.24279.jnareb@gmail.com> <200609050056.52590.jnareb@gmail.com> <7vy7szjjal.fsf@assigned-by-dhcp.cox.net> <edidlp$d3d$1@sea.gmane.org> <20060905030929.GA29865@spearce.org> <7vu03mkiei.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 09:28:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKVMI-0004HH-Sb
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 09:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWIEH2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 03:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWIEH2b
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 03:28:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:21955 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751449AbWIEH2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 03:28:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GKVMB-0007Kn-CH; Tue, 05 Sep 2006 03:28:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D5E7020E42C; Tue,  5 Sep 2006 02:25:31 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu03mkiei.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26462>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > I'm maybe only 1/3 of the way through the sliding window mmap
> > implementation.  I've got a good chunk of sha1_file.c converted but I
> > still have to deal with the copying in pack-objects.c and the verify
> > code in verify-pack.c.  I'm hoping I can send a preliminary patch
> > series tomorrow as I'm going to work on it more tonight and tomorrow.
> 
> Thanks -- I was tempted to do this myself after finishing the
> index_64 change in "pu" branch, but have resisted the temptation
> myself so far.  Being lazy, the less I have to code the better,
> naturally ;-).

I thought that might be the case.  I should be able to finish it
up tomorrow.  :-)

I don't know if I've made this more complex than I really need to
but I've permitted multiple windows per pack.  There is just one
LRU of all windows across all packs and a maximum amount of address
space to use for pack mappings.  Least recently used window gets
tossed when we need a different window.  This permits us to keep
say a window active on the front of a pack (near the commits) and
another different active window closer to the back (near the blobs).

That multiple window feature made it a slightly non-trivial copy
and paste from fast-import but I think its worth it for tree walking
type applications.

-- 
Shawn.
