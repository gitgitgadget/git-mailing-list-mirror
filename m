X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 10:03:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 18:04:44 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31455>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkP7i-0000Kg-K1 for gcvg-git@gmane.org; Wed, 15 Nov
 2006 19:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030779AbWKOSEa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 13:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030792AbWKOSEa
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 13:04:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34720 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1030779AbWKOSE3 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 13:04:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAFI3MoZ014778
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 15
 Nov 2006 10:03:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAFI3I3V023167; Wed, 15 Nov
 2006 10:03:20 -0800
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org



On Tue, 14 Nov 2006, Nicolas Pitre wrote:
> 
> But the fact is that HG (which has a growing crowd of happy campers, 
> maybe even larger than the BK crowd now) did work with and got used to a 
> sensible definition of what a "pull" is.

Guys, before you start thinking this way, the fact is, there's a lot of 
happy git users. 

So the reason for using "git pull" is

 - bk did it that way, and like it or not, bk was the first usable 
   distributed system. hg is totally uninteresting.

 - git itself has now done it that way for the last 18 months, and the 
   fact is, the people _complaining_ are a small subset of the people who 
   actually use git on a daily basis and don't complain.

So don't fall for the classic "second system syndrome". The classic reason 
for getting the second system wrong is because you focus on the issues 
people complain about, and not on the issues that work well (because the 
issues that work fine are obviously not getting a lot of attention).

If you think "pull" is confusing, I can guarantee you that _changing_ the 
name is a hell of a lot more confusing. In fact, I think a lot of the 
confusion comes from cogito, not from git - the fact that cogito used 
different names and different syntax was a mistake, I think.

And that '#' for branch naming in particular was (and is) total 
braindamage. The native git branch naming convention is just fundamentally 
much better, and allows you to very naturally fetch multiple branches at 
once, in a way that cogito's syntax does not.

So when I see suggestions of using that brain-damaged cogito syntax as an 
"improvement", I know for a fact that somebody hasn't thought things 
through, and only thinks it's a better syntax beause of totally bogus 
reasons.

I do agree that we probably could/should re-use the "git merge" name. The 
current "git merge" is an esoteric internal routine, and I doubt a lot of 
people use it as-is. I don't think it would be a mistake to make "git 
merge" basically be an alias for "git pull", for example, and I doubt many 
people would really even notice.

But the fact is, git isn't really that hard to work out, and the commands 
aren't that complicated. There's no reason to rename them. We do have 
other problems:

 - default branch selection for merging is broken (it should definitely 
   take the current branch into account). When I do "git pull" with no 
   branch specification, and I happen to be on a branch that is associated 
   with something else than "master" in the remote, I shouldn't merge with 
   master.

 - I agree that having to create temporary branches to just look at a tag 
   that you don't want to actually develop on is just unnecessarily 
   bothersome.

But trying to rename "pull" (or the "git" name itself) is just going to 
cause more confusion than you fix.

