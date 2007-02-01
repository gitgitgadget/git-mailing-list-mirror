From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git repack -a -d is not safe
Date: Thu, 1 Feb 2007 15:59:34 -0500
Message-ID: <20070201205934.GA19057@spearce.org>
References: <20070201112545.GA19855@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 21:59:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCj1w-0003qb-VY
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 21:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423008AbXBAU7i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 15:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423010AbXBAU7i
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 15:59:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43917 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423008AbXBAU7h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 15:59:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCj1k-00061C-5B; Thu, 01 Feb 2007 15:59:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6FF4F20FBAE; Thu,  1 Feb 2007 15:59:34 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070201112545.GA19855@moooo.ath.cx>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38402>

Matthias Lederhofer <matled@gmx.net> wrote:
> First the object is unpacked, start something using read_sha1_file.
> read_sha1_file: try packed object (fails)
> run git repack -a -d
> read_sha1_file: try to read the loose object (fails)
> read_sha1_file: reread list of packs
> run git repack -a -d so it will create a new pack
> read_sha1_file: tries to open the old packs, not the new one, and
>                 fails

My 4 patch series that I just posted should (partially) fix this
problem.  We cannot close it completely however as there always
exists the potential of the OS to starve the reader and allow 2
full repacks between the time the reader notices a .idx file and
the time the reader could open the .pack.

At least now with my additional changes Git will report that a
packfile is not usable, and then that the object cannot be found,
and die.

All I can say is, wait at least a few minutes between repacks?  ;-)

-- 
Shawn.
