X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 12:30:41 -0800
Message-ID: <455E1BF1.1030003@midwinter.com>
References: <87k61yt1x2.wl%cworth@cworth.org>	<455A1137.8030301@shadowen.org>	<87hcx1u934.wl%cworth@cworth.org>	<20061114194707.GH7201@pasky.or.cz> <87d57pu4qa.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 20:33:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=jJqvmpXH1qeHX79Us3OJHBhSs+vhbSTis4QxD+IJOsWlzMLGNaKfh3UCOuJ4Zd1V  ;
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <87d57pu4qa.wl%cworth@cworth.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31728>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlAOH-0007J6-JV for gcvg-git@gmane.org; Fri, 17 Nov
 2006 21:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755878AbWKQUap (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 15:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755879AbWKQUap
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 15:30:45 -0500
Received: from tater.midwinter.com ([216.32.86.90]:61868 "HELO
 midwinter.com") by vger.kernel.org with SMTP id S1755878AbWKQUan (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 15:30:43 -0500
Received: (qmail 17731 invoked from network); 17 Nov 2006 20:30:42 -0000
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1) by localhost
 with SMTP; 17 Nov 2006 20:30:42 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jumping into this a day late, but:

Carl Worth wrote:
> I don't see any defining difference that justifies cogito's
> existence ("hide the index" maybe? let's just hide it a tiny bit more
> in git). And I would like to help work to get the remaining good
> stuff that has been proven in cogito---to get it pushed down into git
> itself.
>   

Agreed totally on the second point. It would be great if git natively 
supported everything people use in Cogito.

I find myself using native git commands for the most part, except for 
one Cogito command: "cg-update". It is vastly more convenient than 
git-pull in large part because it automatically merges upstream changes 
with uncommitted working-copy changes. I suppose you could classify this 
as "hide the index" in some sense.

Maybe I should give an example of what I mean. Suppose I have two child 
repositories (owned by different developers, say):

cg-clone repo child1
cg-clone repo child2

Now I go into both of them and make different (hopefull non-conflicting) 
edits to the same file.

echo foo >> child1/testfile
perl -pi -e 's/tree/shrub/' child2/testfile

I push the change from child1 into the integration repo.

cd child1
git-commit -a
git-push

Now I want to incorporate the change into child2, where I'm still doing 
work. With Cogito, I go to child2 and run:

cg-update

and afterwards, the upstream changes are merged into testfile and "git 
diff" still shows my local edits. With Git native commands, updating 
child2 if I'm not ready to commit yet is more like:

git-diff --binary > /tmp/patch
git-reset --hard
git-pull
git-apply /tmp/patch

I might have gotten that slightly wrong, but I think I have the general 
idea right; in any event, it's not nearly as convenient! The alternative 
is to commit then pull, but then when I want to look at my local edits, 
I have to remember to diff my working copy against the correct revision, 
which gets increasingly annoying if I update more than once.

Like others on this list, I'm also trying to sell an existing user base 
(in this case, they're using Subversion) on Git. The lack of a built-in 
equivalent to "svn update" is actually a pretty big UI annoyance for 
people whose workflow doesn't require git's more sophisticated feature 
set at a given point in time. Even a sophisticated user doesn't need the 
full power of the tool 100% of the time, so this isn't just a novice vs. 
expert thing in my opinion.

Absent Cogito, would the lack of a simple "svn update" equivalent be a 
deal-killing "throw your hands up in disgust and give up" thing? Maybe 
not, but it's a daily "ugh, why am I having to type extra commands to do 
something that only took one command in svn?" thing. So it's nice to 
have Cogito to paper over that particular wart.

If there is a native git equivalent to cg-update including the 
working-copy automatic merges, I'll be delighted to stand corrected!

