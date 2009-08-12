From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Problems with filters and git status - reproduction steps
Date: Wed, 12 Aug 2009 10:55:04 +0200
Message-ID: <4A828368.5010206@drmicha.warpmail.net>
References: <alpine.DEB.2.00.0908092127420.17141@perkele.intern.softwolves.pp.se> <200908092252.58363.j6t@kdbg.org> <alpine.DEB.2.00.0908120751500.30907@ds9.cixit.se> <alpine.DEB.2.00.0908120856110.30907@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Aug 12 10:55:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb9cY-0007z5-F9
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 10:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbZHLIzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 04:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754146AbZHLIzW
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 04:55:22 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36907 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753900AbZHLIzV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2009 04:55:21 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7954915F13;
	Wed, 12 Aug 2009 04:55:19 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 12 Aug 2009 04:55:19 -0400
X-Sasl-enc: oWHPT6UqUtgeP62YQAJBqUYDdCrXe+ZMWqNCxwMNZ8Jf 1250067318
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 98A771F785;
	Wed, 12 Aug 2009 04:55:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090811 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <alpine.DEB.2.00.0908120856110.30907@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125684>

Peter Krefting venit, vidit, dixit 12.08.2009 10:36:
> ORIGINREPO=git://git.debian.org/users/peterk/gitfilterproblem.git
> DESTINATIONREPO=gitfilterproblem-testrepo
> 
> # Set up repository
> echo -- Cloning
> git clone ${ORIGINREPO} ${DESTINATIONREPO}
> cd ${DESTINATIONREPO}
> 
> # Status should be clean
> echo -- After cloning, status should be clean
> git status
> 
> # Set up filter
> echo -- Set up filter, status should be clean
> ./reposetup.sh 
> git status

I get "Changed but not updated" already here!

Also, what's your git version? There have been some fix-ups recently
regarding the interaction between filters/textconv and assumptions of
the code about dirtiness of the worktree.

> 
> # Create tracking branch
> echo -- Create tracking branch for changed file, status should be clean
> git branch --track changed-text-files origin/changed-text-files 
> git status
> 
> # Merge the branch
> echo -- Merge the changes from the branch, now status gets unclean
> git merge changed-text-files
> echo
> git status
> git diff

Do you really want the date in the checked-in version of the file? I
would assume otherwise. Then your clean filter should really be the
smudge filter, and you would need a clean filter to go with it (remove
the date and restore the keyword).

Michael
