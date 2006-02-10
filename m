From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Fri, 10 Feb 2006 16:38:18 -0500
Message-ID: <20060210213818.GB1604@spearce.org>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Feb 11 00:29:20 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7fyN-0004hs-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 22:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWBJVid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 16:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWBJVid
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 16:38:33 -0500
Received: from [64.38.20.226] ([64.38.20.226]:52434 "EHLO corvette.plexpod.net")
	by vger.kernel.org with ESMTP id S932206AbWBJVic (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 16:38:32 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1F7fy9-0006S0-0P
	for git@vger.kernel.org; Fri, 10 Feb 2006 16:38:21 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id 9BF0520FBA1; Fri, 10 Feb 2006 16:38:18 -0500 (EST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060210211740.GO31278@pasky.or.cz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15900>

Petr Baudis <pasky@suse.cz> wrote:
>   One thing I dislike on both StGIT and pg is that they both try to
> build a full-fledged porcelain on top of GIT, instead of just focusing
> on the patch management, doing it well and providing a convenient user
> interface (well, can't say about pg's interface, didn't try it yet).
> Instead of having pg-add, pg-log, or pg-status it might be more fruitful
> to contribute the features you are missing to git-core or Cogito.

Very valid points.  Before writing pg I used Cogito exclusively
and found git-core too cumbersome to use directly.  When I started
writing pg I didn't intend on replacing everything GIT and Cogito
offers; I was trying to only create the patch stack but still use
the Cogito tools for everything else.

But two things happened:

  1) Cogito didn't run well on a Solaris box I wanted to try and
     use it in; apparently we don't have enough GNU shell commands
     available and Cogito fell over.  (But right now I'd bet pg
     will behave the same if not worse. I haven't had time to try
     it. *sigh*)

  2) I found myself suddenly typing 'pg-log' and 'pg-diff' rather
     than 'git-log' and 'git-diff'.  Call it future muscle memory?
     I hadn't written either of these scripts so I was getting a lot
     of '-bash: pg-log: command not found' errors from my shell.
     So they both became 1 line wrappers around the git-core
     versions, just to save my sanity.

I would agree with trying to integrate some of the workflow idealogy
presented by StGIT and pg into something more mainstream such as
git-core or Cogito.  Right now I'm using pg as a proving ground to
feel out how some of that might work in one particular environment:

  A development team I work with is stuck using PVCS Version
  Manager 6.  Moving source code from a developer to a tester is a
  huge nightmare; not only must the developer check the code into
  the version control system but he/she must also write a bug report
  in a bug database to tell someone else to get the source file
  and give it to the tester.  Its a horrible workflow.  GIT + pg +
  additional custom scripts seems to be easing the pain somewhat;
  but sadly we can't just rip out PVCS Version Manager and use GIT.


> > And for those so inclined:
> > 
> >   Homepage:       http://www.spearce.org/projects/scm/pg/
> >   GIT Repository: http://www.spearce.org/projects/scm/pg.git
> 
> But while it claims to be compatible with all the porcelains, it at
> least cannot be clone by them. ;) The GIT repository is not quite a
> valid GIT repository since it is missing the HEAD and Cogito clones
> based on this file instead of just assuming that your head is on the
> master branch.

Fixed.  That's my fault - my hosting provider doesn't have GIT
installed and thus I had to publish my repository over rsync+ssh.
But git-push doesn't support that protocol type anymore.  :-| So
I packed everything into pack files, pruned the object directory,
and rsync'd it up.  I guess my rsync script didn't copy HEAD.

> Also, when cloning it gives me a little unnerving errors like
> 
> error: File 6427c0154400f578d9cdff178e01e946db6f714f
> (http://www.spearce.org/projects/scm/pg.git/objects/64/27c0154400f578d9cdff178e01e946db6f714f)
> corrupt

I've seen the same.  I think it is either a bug in my rsync script
or a bug in the GIT http clone code; because that is the current
tip commit of the master branch.  And I've only seen that error for
the tip commit, and only if the object doesn't exist in the object
directory because I've done git-pack && git-prune-packed.

-- 
Shawn.
