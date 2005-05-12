From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 12:24:19 -0700
Message-ID: <7vy8akfdss.fsf@assigned-by-dhcp.cox.net>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	<1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
	<1115858022.22180.256.camel@tglx>
	<7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
	<1115884637.22180.277.camel@tglx>
	<7vvf5ogxdu.fsf@assigned-by-dhcp.cox.net>
	<1234.10.10.10.24.1115921886.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, tglx@linutronix.de,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 21:17:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWJBS-00037j-2l
	for gcvg-git@gmane.org; Thu, 12 May 2005 21:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVELTYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 15:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVELTYd
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 15:24:33 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:32465 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261420AbVELTYX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 15:24:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512192420.IMNG8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 15:24:20 -0400
To: "Sean" <seanlkml@sympatico.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "S" == Sean  <seanlkml@sympatico.ca> writes:

S> On Thu, May 12, 2005 1:35 pm, Junio C Hamano said:
>> If that is not needed, then you can record in an auxiliary file
>> that is local to each tree the timestamp of when merge happened
>> in that tree along with set of foreign commit objects, and teach
>> rev-tree or rev-list to read from that auxiliary file and use
>> that timestamp for foreign commit objects instead of commit time
>> recorded in them when sorting by time is needed.

S> The time is already recorded.  Ie. the commit object is a
S> separate file with a modification time which can be used as a
S> "local commit timestamp".  If you want to protect those time
S> stamps by also recording them in a separate file, that's a
S> bonus I guess but shouldn't really be needed.

That would not work if (1) you are using SHA1_FILE_DIRECTORY
mechanism to share object pool for multiple trees, or (2) you
git-*-pull'ed but did not merge for some time.  The file
timestamps are the time of download but we want the time of
merge for this applicaton.  Also, that approach captures only
half the information necessary.  The other half you missed is
"which ones are foreign commits from this tree's point of view",
and as you described that is something you cannot tell just by
looking at the order of parents in commit objects.

S> So it seems, that rather than a repository identifier, we
S> need each repository to record the time of each local commit.
S> Either in a separate file or just using the object file
S> timestamps directly.

I think we are in agreement here, except that object file
timestamps is not something you can use.

