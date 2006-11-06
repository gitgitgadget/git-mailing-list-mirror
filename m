X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: If merging that is really fast forwarding creates new commit
 [Was: Re: how to show log for only one branch]
Date: Mon, 6 Nov 2006 09:48:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611060928180.3667@g5.osdl.org>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net>
 <454F31D7.1030202@gmail.com> <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 6 Nov 2006 18:19:01 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31020>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh8aJ-0007GF-V4 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 18:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753603AbWKFRsb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 12:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753620AbWKFRsb
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 12:48:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33431 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1753600AbWKFRsa (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 12:48:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA6HmOoZ029728
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 6
 Nov 2006 09:48:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA6HmOh9026577; Mon, 6 Nov
 2006 09:48:24 -0800
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org



On Mon, 6 Nov 2006, Linus Torvalds wrote:
> 
> Besides, doing an empty commit like that ("I fast forwarded") literally 
> doesn't add any true history information. It literally views history not 
> as history of the _project_, but as the history of just one of the 
> repositories. And that's wrong.
> 
> So just get used to it. You MUST NOT do what you want to do. It's stupid.

Btw, absolutely the _only_ reason people seem to want to do this is 
because they want to "pee in the snow" and put their mark on things. They 
seem to want to show "_I_ did this", even if the "doing" was a total 
no-op and they didn't actually generate any real value.

That's absolutely the last thing you want to encourage, especially when 
the end result is a history that is totally unreadable and contains more 
"junk" than actual real work. 

I'll be the first to say that "merging code" is often as important as 
actually writing the code in the first place, and that it is important to 
show who actually did real work to make a patch appear in a project.

In the kernel, for example, we have "sign-off" lines to show what route a 
patch took before it was accepted, and it's very instructive to see (for 
example) how man patches give credit to somebody like Andrew Morton for 
passing it on versus actually writing the code himself (he has a lot of 
authorship credit too, but it's absolutely _dwarfed_ by his importance as 
a maintainer - and if you were to ask any random kernel developer why 
Andrew is so important, I can pretty much guarantee that his importance is 
very much about those "sign-offs", and not about the patches he authors).

But at the same time, when it comes to merging, because it actually 
clutters up history a lot, we actively try to _avoid_ it. Many subsystem 
maintainers purposefully re-generate a linear history, rebased on top of 
my current kernel, exactly because it makes the history less "branchy", 
and because that makes things easier to see.

So we have actually done work to _encourage_ fast-forwarding over "merge 
with a commit", because the fast-forwarding ends up generating a much more 
readable and understandable history. Generating a _fake_ "merge commit" 
would be absolutely and utterly horrible. It gives fake credit for work 
that wasn't real work, and it makes history uglier and harder to read. 

So it's a real NEGATIVE thing to have, and you should run away from it as 
fast as humanly possible.

Now, the kernel actually ends up being fairly branchy anyway, but that's 
simply because we actually have a lot of real parallel development (I bet 
more than almost any other project out there - we simply have more commits 
done by more people than most projects). I tend to do multiple merges a 
day, so even though people linearize their history individually, you end 
up seeing a fair amount of merges. But we'd have a lot _more_ of them if 
people didn't try to keep history clean.

Btw, in the absense of a merge, you can still tell who committed 
something, exactly because git keeps track of "committer" information in 
addition to "authorship" information. I don't understand why other 
distributed environments don't seem to do this - because separating out 
who committed something (and when) from who authored it (and when) is 
actually really really important.

And that's not just because we use patches and other SCM's than just git 
to track things (so authorship and committing really are totally separate 
issues), but because even if the author and committer is the same person, 
it's very instructive to realize that it might have been moved around in 
history, so it might actually have been cherry-picked later, and the 
committer date differs from the author date even if the actual author and 
committer are the same person (but you might also have had somebody _else_ 
re-linearize or otherwise cherry-pick the history: again, it's important 
to show the committer _separately_ both as a person and as a date).

And because there is a committer field, if you actually want to linearize 
or log things by who _committed_ stuff, you can. Just do

	git log --committer=torvalds

on the kernel, and you can see the log as it pertains for what _I_ 
committed, for example. You can even show it graphically, although it 
won't be a connected graph any more, so it will tend to be very ugly 
(but you'll see the "linear stretches" when somebody did some work). Just 
do "gitk --committer=myname" to see in your own project.

