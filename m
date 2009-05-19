From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 14:56:54 -0600
Message-ID: <4A131D16.1030001@nortel.com>
References: <4A12DDB9.60608@nortel.com> <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil> <4A12F0ED.4070707@nortel.com> <alpine.LFD.2.01.0905191132490.3301@localhost.localdomain> <4A13030D.8000000@nortel.com> <alpine.LFD.2.01.0905191307320.3301@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 19 22:57:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6WNA-0001UL-Fy
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 22:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbZESU5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 16:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbZESU5H
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 16:57:07 -0400
Received: from zrtps0kp.nortel.com ([47.140.192.56]:42640 "EHLO
	zrtps0kp.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbZESU5H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 16:57:07 -0400
Received: from zcarhxs1.corp.nortel.com (casmtp.ca.nortel.com [47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id n4JKuut11083;
	Tue, 19 May 2009 20:56:56 GMT
Received: from localhost.localdomain ([47.130.81.171] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 19 May 2009 16:56:55 -0400
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
In-Reply-To: <alpine.LFD.2.01.0905191307320.3301@localhost.localdomain>
X-OriginalArrivalTime: 19 May 2009 20:56:55.0648 (UTC) FILETIME=[57E36600:01C9D8C4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119568>

Linus Torvalds wrote:
> On Tue, 19 May 2009, Chris Friesen wrote:

>> The brute-force way to do this would be to manually loop through each branch
>> and create a tag of the form "$branch_$version" to ensure unique tags.  But I was
>> hoping there was a more elegant way.
> 
> Well, I would suggest that you do it fundamentally differently.
> 
> Instead of tagging each build, I would suggest just associating each build 
> with the commit SHA1 of the time. That's what Linux does (if you enable 
> CONFIG_LOCALVERSION_AUTO), and it's _way_ superior to lots of crazy tags.
> 
> So for example, I can do
> 
> 	[torvalds@nehalem ~]$ uname -r
> 	2.6.30-rc6-00302-g72357d5-dirty
> 
> and it tells me exactly what kernel version I'm running (well, the "dirty"
> part means that it's not exact and has some additional patches that 
> weren't committed, but that's as close as you can get). It's very useful.

Agreed.  The project in question actually involves (among other things)
a linux kernel build, so we will be making use of this to work backwards
from the running kernel to the commit used to generate it.

However, we also want to be able to work in the other direction--given a
known-buggy kernel commit, which shipped versions of the product contain
the buggy code?  We do in-the-field upgrades, and different sites may be
running different versions, so it's important to be able to easily
determine which sites are currently running the buggy code so that we
can get them upgraded.  We know which sites are running which versions,
so it is useful to tag the repository branches with that version number.

> Trust me, something like the above is _much_ better than tagging each 
> branchthat you build. Partly because it means that you can do the builds 
> in a distributed manner, and they'll all get the version built in, rather 
> than having to rely on everybody tagging everything and then trying to 
> match up the tag to some random binary.

The tagging would be done only by the "official" build process (which
pulls from an "official" repository), not by each designer.  Typically
the official builds would be done weekly, more frequently if requested.

Chris
