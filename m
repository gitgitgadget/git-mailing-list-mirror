X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 04:53:38 +0100
Message-ID: <20061116035338.GS7201@pasky.or.cz>
References: <87k61yt1x2.wl%cworth@cworth.org> <7virhhy76h.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142048350.2591@xanadu.home> <200611150917.23756.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 03:53:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611150917.23756.andyparkins@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31555>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkYJs-0007YT-M5 for gcvg-git@gmane.org; Thu, 16 Nov
 2006 04:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031102AbWKPDxl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 22:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031103AbWKPDxl
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 22:53:41 -0500
Received: from w241.dkm.cz ([62.24.88.241]:5272 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1031102AbWKPDxk (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 22:53:40 -0500
Received: (qmail 12429 invoked by uid 2001); 16 Nov 2006 04:53:38 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 10:17:22AM CET, Andy Parkins wrote:
> On Wednesday 2006 November 15 04:32, Nicolas Pitre wrote:
> 
> > 3) remote branch handling should become more straight forward.
> 
> I was completely confused by this origin/master/clone stuff when I started 
> with git.  In hindsight, now I understand git a bit more, this is what I 
> would have liked:
> 
>  * Don't use the name "origin" twice.  In fact, don't use it at all.  In a 
> distributed system there is no such thing as a true origin.
> 
>  * .git/remotes/origin should be ".git/remotes/default".   "origin" is only 
> special because it is the default to push and pull - it's very nice to have a 
> default, but it should therefore be /called/ "default".

  But "default" is way too generic a name, it's much more confusing I
think. As the one guilty of inventing master and origin, I agree that
they are somewhat silly, but if I would have to pick which one to
replace with something "better", I'd much rather pick master.

  Yes, Git can operate in a completely distributed manner. People do use
it as it. And there are also people that have no origin branch in their
repository. But the vast (overwhelming!) majority of people _does_ work
in some kind of hierarchical setup, and for them origin does have a
meaning. And origin URL can even change over time!

>  * git-clone should really just be a small wrapper around
>     - git-init-db
>     - create .git/remotes/default
>     - maybe create specific .git/config
>     - git-fetch default
>    If git-clone does anything that can't be done with settings in the config 
> and the remotes/default file then it's wrong.  The reason I say this is that 
> as soon as git-clone has special capabilities (like --shared, --local 
> and --reference) then you are prevented from doing magic with existing 
> repositories.  For example; how do you create a repository that contains 
> branches from two other local repositories that have the objects hard linked?

  Here I think that modulo the lack of remotes support (which is not a
fundamental thing here), the general setup of how Cogito does stuff is
much more saner than the current Git mess. It does basically exactly
what you've said above, and even the fetching itself is IMHO written
much more cleanly than in Git. In an ideal world, Git would just take
Cogito's code here. :-)

> While I'm writing wishes, I'd like to jump on Junio's integration with other 
> fetch-backends wish.  I use git-svn, and it would be fantastic if I could 
> replace:
> 
> git-svn init --id upstream/trunk svn://host/path/trunk
> git-svn fetch --id upstream/trunk
> git-svn init --id upstream/stable svn://host/path/branches/stable
> git-svn fetch --id upstream/stable
> 
> With a .git/remotes/svn
>  SVN-URL: svn://host/path
>  Pull: trunk:refs/remotes/upstream/trunk
>  Pull: branches/stable:refs/remotes/upstream/stable
> and
>  git fetch svn
> 
> Obviously, the syntax is just made up; but you get the idea.  Even better, 
> would be if it could cope with my "*" syntax suggested above:
>  SVN-URL: svn://host/path
>  Pull: trunk:refs/remotes/upstream/trunk
>  Pull: branches/*:refs/remotes/upstream/*

  It shouldn't be hard to do at all. Have the porcelain call "protocol
drivers" based on protocol in some generic way, like
/usr/lib/git/protocol/$proto.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
