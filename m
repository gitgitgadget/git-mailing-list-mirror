From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Multi-head fetches, pulls, and a King Ghidorah
Date: Fri, 19 Aug 2005 11:14:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508191039460.11916@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7vy86y1ibg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 11:15:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E62xr-0001aS-Ba
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 11:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVHSJO4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 05:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVHSJO4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 05:14:56 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:17547 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932555AbVHSJOz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 05:14:55 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AB175136929; Fri, 19 Aug 2005 11:14:54 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8DF71B09AD; Fri, 19 Aug 2005 11:14:54 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 72779B09A2; Fri, 19 Aug 2005 11:14:54 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 564F6136929; Fri, 19 Aug 2005 11:14:54 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy86y1ibg.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

If I understand correctly, the multi-head fetch would not write any ref if 
used like this:

	git fetch remote:repository/ head tail

but it would try a fast-forward when used like this:

	git fetch remote:repository/ head:head tail:tail

Correct? If yes: This is fantastic! It obsoletes my dumb script.

On Fri, 19 Aug 2005, Junio C Hamano wrote:

> However, suppose then I were Joe Random, an individual netdev
> contributor who is interested in these two netdev branches.
> Upon seeing the pull request, I might decide it is a good time
> to get changes from there, my upstream.
> 
>     $ git pull jgarzik/netdev-2.6.git/ sis190:sis190 e100:e100
> 
> Because I am keeping track of copies of these two branches, I
> use "sis190:sis190 e100:e100" to update my local heads.

I propose a "--separate" flag to git pull. This would do exactly the same 
as a plain git pull, but for each fetched branch which could not be 
fast-forwarded

	- try to switch to the branch (dying if it is not the current,
	  and the working tree is dirty)

	- try a merge

	- if the merge fails, reset the branch to original state,
	  write out a temporary head and output a warning

After that, it would switch back to the original branch and check that 
out.

For all failed merges, the user needs to "git resolve" (the exact command 
line could be output by "git pull --separate").

Ciao,
Dscho
