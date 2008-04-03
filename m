From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git-clone.txt: Adjust note to --shared for new pruning
 behavior of git-gc
Date: Thu, 03 Apr 2008 15:51:14 -0500
Message-ID: <47F54342.1040901@nrlssc.navy.mil>
References: <47F52145.306@nrlssc.navy.mil> <alpine.LSU.1.00.0804032113280.4008@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 22:52:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhWQR-0007eX-3B
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 22:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbYDCUwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 16:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755404AbYDCUwD
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 16:52:03 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52586 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbYDCUwC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 16:52:02 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m33KpEfJ031181;
	Thu, 3 Apr 2008 15:51:15 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 3 Apr 2008 15:51:14 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0804032113280.4008@racer.site>
X-OriginalArrivalTime: 03 Apr 2008 20:51:14.0941 (UTC) FILETIME=[750862D0:01C895CC]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15820001
X-TM-AS-Result: : Yes--14.024000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY2OC03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwNDQxMC03MDcxMTktMTg4MDE5LTE4ODE5OC03?=
	=?us-ascii?B?MDA4NDktNzAyMzU4LTcwMTQ1NS03MTE0MzItNzAyMDIwLTcxMTk1?=
	=?us-ascii?B?My03MDUxMDItNzA0NDk2LTcwNjI0OS0xMDY0MjAtNzA0OTI3LTcw?=
	=?us-ascii?B?NjE1MC03MDgzMjgtNzAwNjkzLTcwNzMyNS0xMDYyMzAtNzAwOTQy?=
	=?us-ascii?B?LTcwODU1OC03MDQxNzEtNzAzNzg4LTcwNDQyNS03MDA3ODItNzA1?=
	=?us-ascii?B?ODYxLTcwMTE2My03MDE3MTktNzAwNzMzLTcwNTkwMS0xNDgwMzkt?=
	=?us-ascii?B?MTQ4MDUxLTIwMDQz?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78775>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 3 Apr 2008, Brandon Casey wrote:
> 
>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
>> index 9758243..d3ab00b 100644
>> --- a/Documentation/git-clone.txt
>> +++ b/Documentation/git-clone.txt
>> @@ -65,10 +65,12 @@ OPTIONS
>>  +
>>  *NOTE*: this is a possibly dangerous operation; do *not* use
>>  it unless you understand what it does. If you clone your
>> -repository using this option, then delete branches in the
>> -source repository and then run linkgit:git-gc[1] using the
>> -'--prune' option in the source repository, it may remove
>> -objects which are referenced by the cloned repository.
>> +repository using this option and then delete branches in the
>> +source repository, some objects may become unreferenced (or dangling).
>> +These objects may be removed by normal git operations (such as git-commit[1])
>> +which automatically call git-gc[1]. If these objects are removed and
>> +were referenced by the cloned repository, then the cloned repository
>> +will become corrupt.
> 
> Please note that if you delete a branch _after_ running git-gc, the next 
> git-gc would remove those objects anyway, since the first git-gc packed 
> the objects, and they were therefore no longer dangling.

I thought they would be retained unless --prune was used. git-gc uses the
-A option to repack when --prune is not used and -a when --prune is used.

I think even with the new prune behavior they would still be retained as
long as they were packed since the prune only affects loose objects.

> So it was an issue before the new git-gc behaviour anyway.

Well, I thought that git-gc had become "safe" with respect to --shared
repositories ever since the call to repack started using -A when --prune
was not used.

Now it is unsafe again. But what I was really trying to point out in the
documentation changes was that now _other_ commands such as git-commit are
also unsafe since they call 'git-gc --auto' and could cause loose
unreferenced objects to be deleted. So it is not enough to just avoid calling
git-gc when dealing with a --shared repository.

-brandon
