From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git performance on OS X
Date: Sat, 19 Apr 2008 17:06:52 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804191658430.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <m3od85qxcl.fsf@localhost.localdomain> <alpine.LFD.1.10.0804191547320.2779@woody.linux-foundation.org>
 <alpine.LFD.1.10.0804191551540.2779@woody.linux-foundation.org> <0BE9BBE3-EA9D-4A66-A086-A2A1B289B0DD@ai.rug.nl> <alpine.LFD.1.10.0804191619240.2779@woody.linux-foundation.org> <A07C1A99-084B-4DFC-90CB-B8BDAF7E72EF@sun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Roman Shaposhnik <rvs@sun.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 02:07:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnN5w-0007Ip-EL
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 02:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbYDTAHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 20:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbYDTAHB
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 20:07:01 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43153 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753320AbYDTAHA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2008 20:07:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3K06rom002762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Apr 2008 17:06:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3K06q7u006225;
	Sat, 19 Apr 2008 17:06:52 -0700
In-Reply-To: <A07C1A99-084B-4DFC-90CB-B8BDAF7E72EF@sun.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.435 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79939>



On Sat, 19 Apr 2008, Roman Shaposhnik wrote:
> > 
> > Is there any system-level profiler for OS X to get a clue where that cost
> > is, in case it's not the lstat() at all?
> 
> If it happens on Leopard, DTrace would be a perfect way to query the system:

Well, I'd really like to see a traditional _time_ profile, not system 
call counts.

The system call profile is trivial - it's generally going to be pretty 
similar under OS X and Linux (modulo library differences, but git doesn't 
really use any really complex libraries that would do system calls).

The problem we've had in the past is that Linux is simply an order of 
magnitude faster (sometimes more) at some operations than OS X is, so 
issues that show up on OS X don't even show up on Linux.

This was the case for doing lots of small "mmap()/munmap()" calls, for 
example, where we literally had a load where OS X was two orders of 
magnitude slower. We switched over to reading the files with "pread()" 
instead of mmap(), and that fixed that particular issue.

So a real system profile would be nice.

			Linus
