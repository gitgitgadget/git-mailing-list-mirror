From: Steven Grimm <koreth@midwinter.com>
Subject: Re: GIT vs Other: Need argument
Date: Fri, 20 Apr 2007 09:42:22 -0700
Message-ID: <4628ED6E.6060101@midwinter.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>	<200704171818.28256.andyparkins@gmail.com>	<8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com>	<200704181426.29969.andyparkins@gmail.com>	<462650A7.5030404@midwinter.com> <f06d4m$3rs$1@sea.gmane.org>	<4626C4B9.1040707@midwinter.com>	<7vy7kpaz9s.fsf@assigned-by-dhcp.cox.net>	<7vejmg9a1z.fsf@assigned-by-dhcp.cox.net>	<4627B292.6080202@midwinter.com> <7vzm531ly3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 18:42:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HewBf-0003z2-Uj
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 18:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993269AbXDTQmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 12:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993282AbXDTQmQ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 12:42:16 -0400
Received: from tater.midwinter.com ([216.32.86.90]:38027 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2993269AbXDTQmP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 12:42:15 -0400
Received: (qmail 1000 invoked from network); 20 Apr 2007 16:42:15 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.133?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 20 Apr 2007 16:42:15 -0000
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7vzm531ly3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45115>

Junio C Hamano wrote:
> How do you propose to detect that?  We do not record the
> conflicted semi-merged state we leave the user to sort out
> anywhere else, and I do not think we would want to stash away a
> hidden duplicates of all unmerged files somewhere only for this
> application.  That feels too wasteful and messy.  You also need
> to worry about how to garbage collect such copies if you go that
> route.
>   

We wouldn't need to store duplicates. Just the SHA1s of the semi-merged 
files would suffice. Actually, just the modification times would 
probably suffice, but the hashes are cheap to compute and slightly more 
robust. We could put those in a single file (the same place we'd record 
the fact that the user is in the middle of a conflicted pull) which is 
removed by --continue or --abort.

Alternately, we could rerun the merge that produced the semi-merged 
files in the first place; presumably it will produce exactly the same 
results it did the first time and we can compare that against the 
working copy. But I like storing the hashes better since it's cheaper 
and less convoluted.

> By the way, I've been wondering if giving "git add" an ability
> to do "git commit -a" without actual committing.
>
> 	$ edit edit edit
>         $ git add -u
>
> would run "git add" for all modified (and deleted) files.
>   

I'm not sure I'd ever use this, personally. Pretty much the only time I 
find the "add everything" functionality useful is when I'm about to 
commit, and commit -a covers that case fine. But other people might find 
it helpful.

-Steve
