From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git versus CVS (versus bk)
Date: Sun, 30 Oct 2005 18:35:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 03:38:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWPW7-0007W6-F8
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 03:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVJaCfP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 21:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVJaCfP
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 21:35:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38788 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751276AbVJaCfO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2005 21:35:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9V2axFR017626
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 30 Oct 2005 18:37:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9V2Z9MU017138;
	Sun, 30 Oct 2005 18:35:10 -0800
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10847>



On Sun, 30 Oct 2005, walt wrote:
>
> My memory is playing tricks on me.  I seem to remember running linux
> in the 1980's, but the earliest kernel I can find on kernel.org is
> dated 1994.  Maybe I'm remembering xenix...dunno.

-91 was the first version. It was usable (depending on your definition of 
"usable" ;) in early -92.

> Could someone explain to me the shortcomings of CVS which prompted
> the development of bk (and then git) -- in a way that a non-developer
> like me can understand?

It's really not very easy to explain why CVS sucks. After all, sometimes 
people who have used it for decades have a hard time understanding the 
suckiness.

I've used CVS for "real work" at Transmeta, and hey, it worked well 
enough. When you have groups of just a couple of tens of people max, and 
very strict rules on how to do things, and you trust everybody, CVS works 
fine. It starts to really show its problems whenever you need to work 
remotely, but there are things you can do to make the pain less.

A lot of CVS people will tell you that it sucks because it can't do 
renames, and because certain operations take forever (tagging etc). That's 
only superficially true, and it is really a suckiness that comes from some 
implementation issues.

SVN fixes (supposedly) those "implementation suckiness" issues. It does so 
largely by doing a much better database, which allows it to do certain 
things much more efficiently. Personally that part scares me, since I 
think it's also a much more fragile setup and there's apparently been 
people who lost their entire database to corruption (something that is 
very hard to do with CVS, since the "database" is so weak), but that's a 
different issue.

But the things that SVN fixes are not the things that really matter in the 
end. SVN i sa better CVS, but it still has all the basic fundamental 
problems. Namely the fact that it's centralized.

The problem with a centralized model is that there's one point of contact: 
you can replicate the central database endlessly, but you can only really 
modify it in one place. Which means that anybody who wants to modify 
anything at all needs to have write access to that one repository.

Now, you can limit write access in various ways ("user xyz can only write 
to these files"), but it still requires an a-priori trust network rather 
than a dynamic one. So every single CVS project (and SVN does zero in this 
regard) always ends up having politics around the question of who gets 
commit privileges, and what the rules for them are.

So one of the worst downsides of CVS is _politics_. People, not 
technology.

The other implication of centralization is the fact that it means that you 
can't do any off-line work. You need to be able to access the central 
database in order to do real work. You can replicate the repository and 
try to take it with you and then back-port whatever changes you did when 
you come back, but more commonly it means that when you go off with a 
laptop, you're either in read-only mode, or you need to have an internet 
connection whenever you want to do development. That's just nasty.

The upside of centralization is that a lot of things are easier. Easier to 
think about, easier to get a stupid and straightforward idea working. 

But if you have hundreds of developers, and you have a dynamic trust 
network (I trust some people, they trust others, and we all tend to trust 
people more or less depending on what they work on), the CVS model is 
absolutely HORRID. It just doesn't work.

Git does all of that right. So did BK, for that matter. There's no 
a-priori "these people can commit", because there's no central database. 
There's no problem with off-line work, because every repository is totally 
self-contained and independent of every other one.

			Linus
