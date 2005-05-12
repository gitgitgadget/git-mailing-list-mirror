From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 14:18:06 -0400 (EDT)
Message-ID: <1234.10.10.10.24.1115921886.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
    <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
    <1115858022.22180.256.camel@tglx>
    <7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
    <1115884637.22180.277.camel@tglx>
    <7vvf5ogxdu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: tglx@linutronix.de, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 20:12:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWI8s-0008RV-J6
	for gcvg-git@gmane.org; Thu, 12 May 2005 20:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVELSSP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 14:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVELSSP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 14:18:15 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:51631 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262086AbVELSSH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 14:18:07 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512181806.WYJB26867.simmts8-srv.bellnexxia.net@linux1>;
          Thu, 12 May 2005 14:18:06 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4CII5T9016756;
	Thu, 12 May 2005 14:18:05 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 12 May 2005 14:18:06 -0400 (EDT)
In-Reply-To: <7vvf5ogxdu.fsf@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 1:35 pm, Junio C Hamano said:

> If that is not needed, then you can record in an auxiliary file
> that is local to each tree the timestamp of when merge happened
> in that tree along with set of foreign commit objects, and teach
> rev-tree or rev-list to read from that auxiliary file and use
> that timestamp for foreign commit objects instead of commit time
> recorded in them when sorting by time is needed.

The time is already recorded.  Ie. the commit object is a separate file
with a modification time which can be used as a "local commit timestamp". 
 If you want to protect those time stamps by also recording them in a
separate file, that's a bonus I guess but shouldn't really be needed.

You can descend the history tree based on the parent position as described
by Jon Seymour.  That is, Cogito lists the "local" parent first, so you
descend that branch marking off visited nodes, then descend the other
branches reporting unvisited nodes only.  Afterward return and list any
unreported nodes in the first branch.

Of course, the problem with that is a fast forward node, where you can't
just blindly pick the first parent listed because it may belong to another
repository.   So the answer is to do away with fast forward nodes, or give
up on using the ordering of the parents to mean anything.   In which case
you have to pick the parent with the oldest local commit time as the first
node to descend.

So it seems, that rather than a repository identifier, we need each
repository to record the time of each local commit.   Either in a separate
file or just using the object file timestamps directly.

Sean


