From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: More 'shortlog' statistics models?
Date: Tue, 14 Jul 2009 19:07:16 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907141852400.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 15 04:07:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQtu7-0000Cg-A8
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 04:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbZGOCHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 22:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbZGOCHT
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 22:07:19 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50958 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751376AbZGOCHS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 22:07:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6F27GiI010459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 14 Jul 2009 19:07:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6F27GcU006782
	for <git@vger.kernel.org>; Tue, 14 Jul 2009 19:07:16 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123284>


So I was just thinking about one of the things I've wondered about for a 
while: when do I (and others) make most of my commits?

I mean literally queries about time-of-day or day-of-week issues. I know 
we have the information, and I can write silly scripts to get it, but I'm 
wondering if somebody would actually be willing to make our current 
'shortlog' statistics gatherer do it automatically.

Right now shortlog groups by name, and I'd like to group by other things.

Here's an example of what I just played around with:

	git log --since=6.months --pretty=format:%cD --author=torvalds |
		cut -d, -f1 |
		sort |
		uniq -c |
		sort -n

gives you the weekdays on which I've done most of my commits in the last 
six months. And I think it's kind of interesting. I really do calm down a 
bit on weekends, and do only about half as many commits on Saturday and 
Sunday as I do during the week.

The same is true across the board, btw. Except while _I_ tend to do most 
of my commits on Mondays, while on average, Linux kernel people seem to do 
most of them on Fridays.

But what about time zones? Change the 'cut' to use "-d' ' -f6" instead, 
and it's clear that -0700 is the top time zone (US West coast), but +0100 
and +0200 (much of Europe) are pretty active.

How about time? "cut -d' ' -f5 | cut -d: -f1": The least productive time 
hour is 05:xxAM (not a big surprise, perhaps), while the most productive 
time is apparently early afternoon. But there I'm odd: most of my commits 
by far are in the morning (ie 8AM to noon).

Anyway, I can do all this with sorting, but it's fun enough that I wonder 
if we should make it easier?

		Linus
