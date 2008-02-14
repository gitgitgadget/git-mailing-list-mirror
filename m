From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Thu, 14 Feb 2008 13:41:31 -0600
Message-ID: <47B4996B.4000900@nrlssc.navy.mil>
References: <200802081828.43849.kendy@suse.cz> <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz> <alpine.LFD.1.00.0802092200350.2732@xanadu.home> <alpine.LSU.1.00.0802101640570.11591@racer.site> <alpine.LFD.1.00.0802101445430.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Holesovsky <kendy@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 20:43:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPjzE-0002Jx-51
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 20:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276AbYBNTmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 14:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbYBNTmh
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 14:42:37 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39037 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbYBNTmg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 14:42:36 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1EJfWPr002643;
	Thu, 14 Feb 2008 13:41:32 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Feb 2008 13:41:31 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LFD.1.00.0802101445430.2732@xanadu.home>
X-OriginalArrivalTime: 14 Feb 2008 19:41:31.0671 (UTC) FILETIME=[995E4A70:01C86F41]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15722001
X-TM-AS-Result: : Yes--6.838700-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAyNzI2LTcwOTEzNy03MDQ0MzUtNzAyNjA5LTcwMTcwOC03?=
	=?us-ascii?B?MDg5MzItNzA2MjQ5LTcwMzM3Mi0xMDU3MDAtNzEwNTcxLTcwMTAw?=
	=?us-ascii?B?NS03MDAyNjQtNzA1NTgxLTcwNDkyNy03MDIwMTYtNzAwOTcxLTcw?=
	=?us-ascii?B?MzQyOC03MDA2MTgtNzA3NzYwLTcwMDU3My03MDMwOTYtNzAzMjg2?=
	=?us-ascii?B?LTcwMjQ3NC03MDQ5ODAtNzA1ODgyLTE0ODAzOS0xNDgwNTEtMjAw?=
	=?us-ascii?B?NDI=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73908>

Nicolas Pitre wrote:
> On Sun, 10 Feb 2008, Johannes Schindelin wrote:
> 
>> I tried that:
>>
>> $ git config pack.deltaCacheLimit 1
>> $ git config pack.deltaCacheSize 1
>> $ git config pack.windowMemory 2g
> 
> This has nothing to do with repacking memory usage, but even tighter 
> packs can be obtained with:
> 
> 	git config repack.usedeltabaseoffset true
> 
> This is not the default yet.

I have successfully repacked this repo a few times on a 2.1GHz system with 16G.

The smallest attained pack was about 1.45G (1556569742B).

This run took about 7 hours 26 min.

I ran: git repack -a -d -f --window=250 --depth=250

Here are the relevent config entries:
[pack]
        threads = 1
        compression = 9
[repack]
        usedeltabaseoffset = true


Other runs:


* Same as above, but with default compression:

	pack size: 1560624388
	time: 7 hours 11 min

	Not much difference in time or size.


* Multi threaded (250m window)
[pack]
        threads = 4
        windowmemory = 250m
        compression = 9
[repack]
        usedeltabaseoffset = true

	pack size: 1767405703
	time: 3 hours

	First >99% took 50min. Last 10000 objects took 2hours.

* Multi threaded (500m window)
[pack]
        threads = 4
        windowmemory = 500m
        compression = 9
[repack]
        usedeltabaseoffset = true

	pack size: 1640820903
	time: forgot to time, but between 3-4 hours based on file time

	I just received Dscho's email, this is interesting to compare
	with his single threaded result of 1638490531. I wonder if he
	used deltabaseoffset? I think his machine is a little faster
	than this one. So using 4 threads finished twice as fast and
	produced a similar pack size. Actually, the difference could
	just be the compression setting.

* Deeper (git repack -a -d -f --window=250 --depth=500)
[pack]
        threads = 1
        compression = 9
[repack]
        usedeltabaseoffset = true

	pack size: 1578263745
	time: 7 hours 58 min

	Larger pack compared to --depth=250.

-brandon
