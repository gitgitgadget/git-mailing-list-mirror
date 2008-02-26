From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] pack-objects: Print a message describing the number of
 threads for packing
Date: Tue, 26 Feb 2008 09:53:00 -0600
Message-ID: <47C435DC.2070508@nrlssc.navy.mil>
References: <47B1BEC6.6080906@nrlssc.navy.mil> <1203732369-30314-1-git-send-email-casey@nrlssc.navy.mil> <47BF812A.4020205@nrlssc.navy.mil> <20080226074933.GA3485@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 20:08:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU59e-00011R-By
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 20:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbYBZTHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 14:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbYBZTHQ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 14:07:16 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34564 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbYBZTHP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 14:07:15 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1QFr1fm017372;
	Tue, 26 Feb 2008 09:53:01 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Feb 2008 09:53:00 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20080226074933.GA3485@coredump.intra.peff.net>
X-OriginalArrivalTime: 26 Feb 2008 15:53:00.0868 (UTC) FILETIME=[AA0CC840:01C8788F]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15750001
X-TM-AS-Result: : Yes--16.978300-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMTE4Mi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcxMDU3MS03MDM5NjUtNzAyMzc5LTcwMDQ3Ni03?=
	=?us-ascii?B?MDM2MjAtNzEwOTcwLTcwMjE5MC03MDE4MTctNzA1NTgxLTcwMTU5?=
	=?us-ascii?B?NC03MDIxNTctNzAyMTEzLTcwODQ0MC03MDE0MzMtNzAxODM3LTcw?=
	=?us-ascii?B?MDc1Ni03MDMyODMtNzAzNzg4LTcwMzcxMi03MDUxMDItNzA0Njg5?=
	=?us-ascii?B?LTcwNDYwNS03MDY5MTktNzAwNzI2LTcwMjA0Mi0xMDY0MjAtNzAy?=
	=?us-ascii?B?MDEwLTcwMjM1OC03MDYwNDEtMTQ4MDM5LTIwMDQy?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75161>

Jeff King wrote:
> On Fri, Feb 22, 2008 at 08:12:58PM -0600, Brandon Casey wrote:
> 
>> +	if (progress)
>> +		fprintf(stderr, "Using %d pack threads.\n",
>> +			delta_search_threads);
> 
> I just noticed that this was in next. Do we really need to display this
> message? A considerable amount of discussion went into reducing git's
> chattiness and clutter during push and fetch, and I feel like this is a
> step backwards (yes, I know most people won't see it if they don't build
> with THREADED_DELTA_SEARCH).
> 
> Can we show it only if threads != 1? Only if we auto-detected the number
> of threads and it wasn't 1?

I like the message and thought it was useful especially for non-developers.

Even if the number of threads was not auto-detected, it is a confirmation
that the number of threads used is the number of threads configured.

For example, it seems easy to do this:

	git config pack.thread 4
	git repack

The user would immediately know something was wrong when they saw the
message "Using 1 pack threads" instead of the "4" they thought they
configured. Also, since it's only printed in the THREADED_DELTA_SEARCH
case, it's also a confirmation that this option was indeed used for a
particular build of git.

Mainly, I thought it was a harmless message that other users would "enjoy"
seeing, but if others disagree, I won't argue. Notice I quoted "enjoy" to
emphasize it.

I'd also say that if the message is too noisy in the "user explicitly
assigned number of threads" case, then it's just as noisy in the "auto assign"
case, so just remove the message completely.

We're saying:

If I set pack.threads to 4, I know git is using 4 threads to repack since
I told it to use 4 threads. I don't need to see a noisy message telling
me so.

If I set pack.threads to 0, I know git is using 4 threads to repack since
I have 4 cpus. I don't need to see a noisy message telling me so.

-brandon
