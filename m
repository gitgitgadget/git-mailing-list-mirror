X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn bug?
Date: Fri, 17 Nov 2006 00:55:10 -0800
Message-ID: <20061117085509.GA29644@localdomain>
References: <op.ti2svo0ozidtg1@rygel.lnxi.com> <7vejs4jshp.fsf@assigned-by-dhcp.cox.net> <op.ti2xykijzidtg1@rygel.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 08:55:22 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <op.ti2xykijzidtg1@rygel.lnxi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31676>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkzVG-000073-Nj for gcvg-git@gmane.org; Fri, 17 Nov
 2006 09:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755542AbWKQIzO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 03:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755543AbWKQIzO
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 03:55:14 -0500
Received: from hand.yhbt.net ([66.150.188.102]:46755 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1755542AbWKQIzM (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 03:55:12 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 754297DC098; Fri, 17 Nov 2006 00:55:10 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 17 Nov 2006
 00:55:10 -0800
To: Troy Telford <ttelford.groups@gmail.com>
Sender: git-owner@vger.kernel.org

Sorry for the late replies, I've been caught up with other things.

Troy Telford <ttelford.groups@gmail.com> wrote:
> On Wed, 15 Nov 2006 14:43:30 -0700, Junio C Hamano <junkio@cox.net> wrote:
> 
> >"Troy Telford" <ttelford.groups@gmail.com> writes:
> >
> >>(using git 1.4.4, svn 1.3.1 on a SLES 10 box)
> >>fatal: Not a valid object name  
> >>92e2e0c50bbbacb0a3426b2c0f8b3e043eb4830a~1
> >>32768 at /usr/lib/perl5/5.8.8/Memoize.pm line 269
> >>...
> >>I couldn't find an object named
> >>"92e2e0c50bbbacb0a3426b2c0f8b3e043eb4830a~1" in .git/
> >
> >Troy, do you have object 92e2e0c5?  Is it a root commit (i.e. a
> >commit that does not have a parent)?

dcommit expects to be run on a git-svn fetch-ed HEAD that is linear
superset of remotes/git-svn.  That is: remotes/git-svn..HEAD should
(ideally) contain no merges, and no root commits.  git-svn currently
does no checking for root commits, but it should.

> I'll have to admit I'm stabbing in the dark on how to get the correct  
> answer this, but here goes:
> 
> * `git cat-file -t 92e2e0...` returns 'commit'
> * 'git cat-file -p 92e2e0...` returns: (minus the header/footer asterisks)
> *********************************************
> tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> author unknown <unknown> 961088898 +0000
> committer unknown <unknown> 961088898 +0000
> 
> New repository initialized by cvs2svn.
> *********************************************

This commit is missing the git-svn-id: line at the bottom.  If you
simply left it out (private svn repository info), can you check that the
URL in this line is actually for the SVN repository you want to commit
to?

It seems like your usage of dcommit would actually cause the issue
you're experiencing to be triggered on the dummy repository, and not the
real one.  My other guess would be that you somehow merged commits from
your dummy svn repo into your master branch.

-- 
