From: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: cannot pread pack file
Date: Wed, 09 Dec 2009 13:53:03 -0500
Message-ID: <4B1FF20F.1080609@harris.com>
References: <4B1FCF81.2010807@harris.com> <alpine.LFD.2.00.0912091237330.31174@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Dec 09 19:53:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIRf2-0001pE-3G
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 19:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757250AbZLISxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 13:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757205AbZLISxB
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 13:53:01 -0500
Received: from mlbe2k1.cs.myharris.net ([137.237.90.88]:21411 "EHLO
	mlbe2k1.cs.myharris.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757131AbZLISxA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 13:53:00 -0500
Received: from mail pickup service by mlbe2k1.cs.myharris.net with Microsoft SMTPSVC;
	 Wed, 9 Dec 2009 13:53:06 -0500
Received: from saf.cs.myharris.net ([137.237.94.251]) by mlbe2k1.cs.myharris.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 9 Dec 2009 13:53:04 -0500
User-Agent: Thunderbird 2.0.0.19 (X11/20090107)
In-Reply-To: <alpine.LFD.2.00.0912091237330.31174@xanadu.home>
X-OriginalArrivalTime: 09 Dec 2009 18:53:04.0526 (UTC) FILETIME=[D6DD2AE0:01CA7900]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134992>

Nicolas Pitre wrote:
> On Wed, 9 Dec 2009, Steven A. Falco wrote:
> 
>> We have been using git for a year or two now, and suddenly, one
>> of our users got the error message:
>>
>> fatal: cannot pread pack file: No such file or directory
>> fatal: index-pack failed
>>
>> while doing a git-pull.  We are using git version git-1.6.5.5.
>>
>> I tried doing a "git fsck --full" on his repository and on the
>> one he is trying to pull from, and neither shows any error.
>>
>> If I clone his repository, the clone also gets the error message
>> when trying to pull.
>>
>> I can pull from him, but if he pulls from me, he gets the error
>> message.
>>
>> This is worrying, because the fsck doesn't show an error, but
>> clearly something is wrong.
> 
> A few questions:
> 
>  - What is the OS on which the failing Git is running?
> 

I am running on Centos 5.2.  I believe I've fixed the problem.

I thought we were running 1.6.5.5, but apparently our libexec was
pointing to an older version.  Once I corrected that, the error
went away.

Our repositories are hosted on an NFS file server, and the repo
that had the problem has some large binary fpga images in it.

Looking on the net, it seems that there was a problem with pread
returning part of a file.  I see that the new code does the pread
in a loop to work around this.  So I'm guessing that the old version
we were running didn't have the pread workaround and was therefore
failing.  Anyway, it is behaving now.

	Thanks very much for replying,
	Steve

>  - How long before the error occurs i.e. how many objects are received
>    (and the transfer size) before the error?
> 
> 
> Nicolas
> 


-- 
A: Because it makes the logic of the discussion difficult to follow.
Q: Why shouldn't I top post?
A: No.
Q: Should I top post?
