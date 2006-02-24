From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] New git-seek command with documentation and test.
Date: Fri, 24 Feb 2006 11:00:29 +0100
Message-ID: <43FED93D.1000601@op5.se>
References: <43F20532.5000609@iaglans.de>	<Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>	<87k6bxvmj6.wl%cworth@cworth.org>	<Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>	<87fymlvgzv.wl%cworth@cworth.org>	<Pine.LNX.4.64.0602141224110.3691@g5.osdl.org>	<87d5hpvc8p.wl%cworth@cworth.org>	<7vu0b1pntl.fsf@assigned-by-dhcp.cox.net> <87zmkhrf4y.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 11:00:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCZkY-0005YT-Lv
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 11:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWBXKAb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 05:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWBXKAb
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 05:00:31 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:54930 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932171AbWBXKAb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 05:00:31 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id A7FCB6BCBE; Fri, 24 Feb 2006 11:00:29 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87zmkhrf4y.wl%cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16690>

Carl Worth wrote:
> Add git-seek which allows for temporary excursions through the
> revision history. With "git seek <revision>" one gets a working tree
> corresponding to <revision>. When done with the excursion "git seek"
> returns back to the original branch from where the first seek began.
> 

I've said it before, and I'll say it again. This tool provides less 
flexibility and much less power than "git checkout -b branch 
<commit-ish>" (although it would be nice to have '-o' for 'overwrite 
existing branch' as an argument to git checkout)

> Signed-off-by: Carl Worth <cworth@cworth.org>
> 
> ---
>  
>  I had planned to just let this drop as my original need was some
>  historical exploration that I've already finished. But now I've found
>  a common use case in my everyday workflow that could benefit from
>  git-seek. Here it is:
>  
>  I receive a bug-fix patch that updates a test case to demonstrate the
>  bug. I can apply both the fix and the test case and see it succeed.
>  But what I really want to do is first commit the test case, see it
>  fail, and only then commit the fix and see the test now succeed.  I'd
>  also like the history to reflect that order. So what I do is:
>  
>  	$ git-am
>  	$ git update-index test.c ; git commit -m "Update test"
>  	$ git update-index buggy.c ; git commit -m "Fix bug"
>  
>  At that point, without git-seek I can get by with:
>  
>  	$ git checkout -b tmp HEAD^
>  	$ make check # to see failure
>  	$ git checkout <branch_I_was_on_to_begin_with>
>  	$ git branch -d tmp # easy to forget, but breaks the next time otherwise
>  	$ make check # to see success
>  
>  But what I'd really like to do, (and can with the attached patch), is:
>  
>  	$ git seek HEAD^
>  	$ make check # to see failure
>  	$ git seek
>  	$ make check # to see success
>  
>  This avoids me having to:
> 1) invent a throwaway name,

All programmers have at least five throwaway names that are only ever 
used as such (mine are, in order of precedence, foo, bar, tmp, fnurg, 
sdf and asd).

> 2) remember the branch I started on,

With topic branches, you need to pick more careful topic names. Without 
topic branches you're always on "master". Surely you know what the 
patches touch, so you know what branch they should be in.

> 3) remember to actually throwaway the temporary branch.
> 

This isn't always a bad thing, since you after applying some patch or 
other decide you want to go back to this point in history, or want to 
keep the point so you can show the author some problem or other with the 
patch. With git-seek you'll then have to remember the hard-to-learn 
SHA1, or how far below HEAD or some other easily remembered point in 
history it is. In that case, you need to remember to add the 
branch/tag/whatever to where you seeked rather than just go on with the 
work. Removing a branch later is simple. Finding the right spot to 
create it later can be trouble-some.

If I had a vote, I'd say no to this patch, and to this tool entirely.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
