From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Optimized cvsexportcommit: calling 'cvs status' only once instead of once per changed file.
Date: Wed, 9 May 2007 22:30:15 +0200
Organization: Dewire
Message-ID: <200705092230.16027.robin.rosenberg.lists@dewire.com>
References: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed May 09 22:30:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlsnj-0008A5-Nz
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbXEIUaO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754642AbXEIUaO
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:30:14 -0400
Received: from [83.140.172.130] ([83.140.172.130]:10822 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753995AbXEIUaM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:30:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 30B86802802;
	Wed,  9 May 2007 22:24:04 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19816-01; Wed,  9 May 2007 22:24:03 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id BD50D8027E7;
	Wed,  9 May 2007 22:24:03 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46784>

onsdag 09 maj 2007 skrev Steffen Prohaska:
> The old implementation executed 'cvs status' for each file touched by  
> the patch
> to be applied. The new code calls 'cvs status' only once and parses  
> cvs's
> output to collect status information of all files contained in the  
> cvs working
> copy.
> 
> Runtime is now independent of the number of modified files. A  
> drawback is that
> the new code retrieves status information for all files even if only  
> a few are
> touched. The old implementation may be noticeably faster for small  
> patches to

Ouch, lets see now. My working cvs checkout contains ~25k files and
my typical commit touches 5-20 files. 

A quick (well....) test says cvs status on my checkout takes about
five minutes to execute. Compare this with my typical exportcommit
time of about ten seconds. 

If you really need this, make a switch to select it.

Still we're missing a check for the case that new files/directories have been
added on the server, but are missing from the checkout, or why not run
an update first. If you are commit this number of large files you'll need that
check, or it's hurt a lot when things fail.

> large workingcopies. However, the old implementation doesn't scale if  
> more
> files are touched, especially in remotely located cvs repositories.

How come your commit are so large you'd prefer this behaviour?

-- robin
