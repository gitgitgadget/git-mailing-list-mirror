From: Eric Wong <normalperson@yhbt.net>
Subject: [RFH] - git-svn auth bug (possibly SVN 1.5.0-related)
Date: Sun, 3 Aug 2008 15:02:51 -0700
Message-ID: <20080803220251.GB3006@untitled>
References: <20080725060037.GB14756@untitled> <4889F215.9020804@kitware.com> <20080726054547.GA20494@untitled> <488B2FC5.4080801@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 00:03:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPlgA-0004cc-Jp
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 00:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377AbYHCWCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 18:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757363AbYHCWCx
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 18:02:53 -0400
Received: from hand.yhbt.net ([66.150.188.102]:49969 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757315AbYHCWCw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 18:02:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 39E7D2DC01B;
	Sun,  3 Aug 2008 15:02:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <488B2FC5.4080801@kitware.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91280>

Brad King <brad.king@kitware.com> wrote:
> Eric Wong wrote:
> > Brad King <brad.king@kitware.com> wrote:
> >> Eric Wong wrote:
> >>> I haven't had the chance to look at this.   Can anybody else shed more
> >>> light on that bug?  It's really strange that the tests won't run because
> >>> of it.  Are you unable to run some git-svn tests or all of them?
> >> Just that one fails.  All others (including the one in the patch below) pass.
> > 
> > Exactly which test fails for you?  Perhaps it's some setting in your
> > ~/.subversion/config that's causing it to fail.  Maybe we should set
> > $HOME and use a clean ~/.subversion/config for git-svn tests regardless
> > if that turns out to be the case...
> 
> $ cd $gitsrc/t
> $ export SVNSERVE_PORT=5432
> $ ./t9113-git-svn-dcommit-new-file.sh
> *   ok 1: start tracking an empty repo
> * FAIL 2: create files in new directory with dcommit
> 
>                 mkdir git-new-dir &&
>                 echo hello > git-new-dir/world &&
>                 git update-index --add git-new-dir/world &&
>                 git commit -m hello &&
>                 start_svnserve &&
>                 git svn dcommit
> 
> * failed 1 among 2 test(s)
> 
> I hacked the test script to log the dcommit output to a file, and I see
> this:
> 
> Committing to svn://127.0.0.1:5432 ...
> Use of uninitialized value in concatenation (.) or string at
> /usr/lib/perl5/SVN/Core.pm line 584.
> Authorization failed:  at $gitsrc/t/../git-svn line 3329
> 
> (I replaced my git source dir full path with $gitsrc).
> 
> The version of libsvn-perl is:  1.5.0dfsg1-4

It could be another incompatibility introduced in SVN 1.5.0.

I'll try to dist-upgrade a machine to Lenny sometime in the next two
weeks so I can test; I'm pretty busy these days but if anybody else
wants to figure this out in the meantime, please do :)

> Please let me know if you need more info.
> 
> I tried moving my ~/.subversion/config out of the way but it makes no
> difference.  However, I agree we should block the user's home svn config
> when running other dcommit tests now that we have auto-props.  Perhaps
> just using the --config-dir option with an empty directory would be enough.

Thanks for the additional info!

-- 
Eric Wong
