From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git does the wrong thing with ambiguous names
Date: Thu, 07 Jun 2007 09:54:46 -0500
Message-ID: <46681C36.4060305@nrlssc.navy.mil>
References: <4667319C.9070302@nrlssc.navy.mil> <20070606225826.GC3969@steel.home> <20070606233327.GD3969@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 16:55:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwJOE-0002wZ-5s
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 16:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbXFGOyw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 10:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759481AbXFGOyw
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 10:54:52 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51060 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbXFGOyv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 10:54:51 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l57EqgS3017273;
	Thu, 7 Jun 2007 09:52:44 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 Jun 2007 09:54:46 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <20070606233327.GD3969@steel.home>
X-OriginalArrivalTime: 07 Jun 2007 14:54:46.0376 (UTC) FILETIME=[CA1D9E80:01C7A913]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15222001
X-TM-AS-Result: : Yes--5.776900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE0NzAxOC03MDQ3?=
	=?us-ascii?B?MDktNzAwMDc1LTEzOTAxMC03MDA0MTItNzAzNzg4LTcwMTU3Ni03?=
	=?us-ascii?B?MDMxNzYtNzA0MTc5LTcwNTUwOC03MDI5MDAtMTIxNDcwLTcwNDQy?=
	=?us-ascii?B?MS03MDQ0MjUtNzA0OTgwLTcwMDM3My03MDMxNzktNzA2NzI1LTcx?=
	=?us-ascii?B?MDA3OC03MDUxNzgtNzAxNzQ2LTcwMDE5Ni0xMjE2MjQtNzAxMjkx?=
	=?us-ascii?B?LTE0ODA1MS0yMDA0Mw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49371>

Alex Riesen wrote:
> Alex Riesen, Thu, Jun 07, 2007 00:58:26 +0200:
>> Brandon Casey, Thu, Jun 07, 2007 00:13:48 +0200:
>>> When a branch and tag have the same name, a git-checkout using that name 
>>> succeeds (exits zero without complaining), switches to the _branch_, but 
>>> updates the working directory contents to that specified by the _tag_. 
>>> git-status show modified files.
>> Bad. To reproduce:
>>
>> mkdir a && cd a && git init && :> a && git add . && git commit -m1 &&
>> :>b && git add . && git commit -m2 && git tag master HEAD^ &&
>> find .git/refs/ && gco -b new && gco master && git status
>>
> 
> git-rev-parse actually warns about ambguities:
> 
>     $ git-rev-parse --verify master
>     warning: refname 'master' is ambiguous.
>     dd5cdc387f2160bf04d02ac08dfdaf952f769357
> 
> It's just that the warning is thrown away in git-checkout.sh
> 
> A quick and _very_ messy fix could like like that:

[snip patch]

This one suffers from what Junio described previously on the mailing 
list, when get_sha1_basic() fails, get_sha1_1() continues trying 
alternatives. The risk is that one of those alternatives could match, 
for example if the ambiguous branch and tag name is 'dead'.

-brandon
