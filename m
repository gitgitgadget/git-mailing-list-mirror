From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Optimized cvsexportcommit: calling 'cvs status' only once instead of once per changed file.
Date: Thu, 10 May 2007 00:45:10 +0200
Message-ID: <380B28A3-5CD0-4371-A717-1D2629E6302D@zib.de>
References: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de> <200705092230.16027.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 10 00:45:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HluuZ-0006Dn-77
	for gcvg-git@gmane.org; Thu, 10 May 2007 00:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbXEIWpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 18:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759338AbXEIWpI
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 18:45:08 -0400
Received: from mailer.zib.de ([130.73.108.11]:57629 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757530AbXEIWpG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 18:45:06 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l49MixC2001957;
	Thu, 10 May 2007 00:44:59 +0200 (CEST)
Received: from [192.168.178.32] (p54BF2F28.dip0.t-ipconnect.de [84.191.47.40])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l49Mix53019194
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 10 May 2007 00:44:59 +0200 (MEST)
In-Reply-To: <200705092230.16027.robin.rosenberg.lists@dewire.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46806>


On May 9, 2007, at 10:30 PM, Robin Rosenberg wrote:

> onsdag 09 maj 2007 skrev Steffen Prohaska:
>> The old implementation executed 'cvs status' for each file touched by
>> the patch
>> to be applied. The new code calls 'cvs status' only once and parses
>> cvs's
>> output to collect status information of all files contained in the
>> cvs working
>> copy.
>>
>> Runtime is now independent of the number of modified files. A
>> drawback is that
>> the new code retrieves status information for all files even if only
>> a few are
>> touched. The old implementation may be noticeably faster for small
>> patches to
>
> Ouch, lets see now. My working cvs checkout contains ~25k files and
> my typical commit touches 5-20 files.
>
> A quick (well....) test says cvs status on my checkout takes about
> five minutes to execute. Compare this with my typical exportcommit
> time of about ten seconds.

I tested with ~7k files using ssh to connect. Maybe something's wrong
with the server I'm connecting to but it takes some time for each  
connect.
This alone kills the performance for a couple of files.

'cvs -z6 status' on the other hand took only 10 seconds.

> If you really need this, make a switch to select it.

I'll post a patch soon that takes the best of both: Call cvs status
once with the list of touched files and parse the output. Only one
connection is needed and only the minimal amount of status data is
transferred.

- Steffen
