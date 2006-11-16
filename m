X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 09:30:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611160924250.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <200611151858.51833.andyparkins@gmail.com>
 <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
 <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
 <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org> <20061116042639.GA23026@thunk.org>
 <455C5079.3010701@op5.se> <Pine.LNX.4.64.0611160824040.3349@woody.osdl.org>
 <87ejs3s4vn.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 17:31:25 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, Theodore Tso <tytso@mit.edu>,
	Nicolas Pitre <nico@cam.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87ejs3s4vn.wl%cworth@cworth.org>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31603>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkl4s-0001Qb-Bj for gcvg-git@gmane.org; Thu, 16 Nov
 2006 18:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161828AbWKPRbB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 12:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161829AbWKPRbB
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 12:31:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58327 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1161828AbWKPRbA (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 12:31:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAGHUnoZ015369
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 09:30:49 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAGHUlDi031525; Thu, 16 Nov
 2006 09:30:48 -0800
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org



On Thu, 16 Nov 2006, Carl Worth wrote:
>
> On Thu, 16 Nov 2006 08:30:55 -0800 (PST), Linus Torvalds wrote:
> > The form I use is actually a lot simpler (conceptually) than the "short"
> > form.
> >
> > When you do
> >
> > 	git pull <reponame> <branchname>
> 
> Yes, that's what the user almost always wants. The UI problem here is
> that the conceptually simpler form is syntactically longer, (which
> means users aren't likely to find it).

Yeah. 

And this is something I absolutely agree with. Our default branches for 
"pull" are horrible. You can "fix" it, but you can only fix it by adding 
_explicit_ branches to your .git/config file by hand, so I don't think 
that's actually a real fix at all. We should just fix the default (where 
even a "I don't know what branch you want" _error_ would be preferable 
over the current situation).

Along with the "git checkout <tag>" thing, I think these two things are 
definitely worth just fixing.

> The behavior is sane, but having to always type the branch name
> specifically because it never changes... that's a user-interface bug.

Yeah. Each branch should

 (a) have a "default source" initialized on the initial "clone"

 (b) have a way to set the source afterwards

 (c) error out if you do just a "git pull" or "git pull remotename" if 
     there is no default branch for the current local branch for that 
     remote.

We actually have (b) in a weak form right now ("weak" because it requires 
you to manually edit the config file: we've got the mechanism, but not a 
nice UI for it), but (a) and (c) are just broken.

And yeah, we should allow pulling into a branch that hasn't been 
initialized.

