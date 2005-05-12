From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 15:35:14 -0400 (EDT)
Message-ID: <1510.10.10.10.24.1115926514.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
    <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
    <1115858022.22180.256.camel@tglx>
    <7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
    <1115884637.22180.277.camel@tglx>
    <7vvf5ogxdu.fsf@assigned-by-dhcp.cox.net>
    <1234.10.10.10.24.1115921886.squirrel@linux1>
    <7vy8akfdss.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, tglx@linutronix.de,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 21:29:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWJLh-000545-10
	for gcvg-git@gmane.org; Thu, 12 May 2005 21:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVELTfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 15:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVELTfX
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 15:35:23 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:34704 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261467AbVELTfP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 15:35:15 -0400
Received: from linux1 ([69.156.111.46]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512193514.VEG11606.simmts5-srv.bellnexxia.net@linux1>;
          Thu, 12 May 2005 15:35:14 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4CJZCv4017777;
	Thu, 12 May 2005 15:35:13 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 12 May 2005 15:35:14 -0400 (EDT)
In-Reply-To: <7vy8akfdss.fsf@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 3:24 pm, Junio C Hamano said:

> That would not work if (1) you are using SHA1_FILE_DIRECTORY
> mechanism to share object pool for multiple trees, or (2) you
> git-*-pull'ed but did not merge for some time.  The file
> timestamps are the time of download but we want the time of

Surely you mean "GIT_OBJECT_DIRECTORY" <g> and you're right, if the local
object is shared amongst several trees you'd have to store the timestamp
separately.   However, as for your second case, the merge process could
set the timestamp on the file so that one really isn't a problem.  I for
one, would like the option to use this method when its appropriate,
although I agree you'd need a timestamp-database for other situations.

> merge for this applicaton.  Also, that approach captures only
> half the information necessary.  The other half you missed is
> "which ones are foreign commits from this tree's point of view",
> and as you described that is something you cannot tell just by
> looking at the order of parents in commit objects.

Right, but we're not talking about identifying foreign commits anymore! 
The point is just to list multiple parents in the correct "local" order. 
The timestamp information _is_ enough to identify the proper order for
local viewing.   And this has the very nice feature that it works for
branches made in the same repository, where the repoid proposal would
fail.

> S> So it seems, that rather than a repository identifier, we
> S> need each repository to record the time of each local commit.
> S> Either in a separate file or just using the object file
> S> timestamps directly.
>
> I think we are in agreement here, except that object file
> timestamps is not something you can use.

You can use it, just not in every situation.

Sean


