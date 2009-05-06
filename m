From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Wed, 6 May 2009 20:52:24 +0200
Message-ID: <20090506185224.GM15420@raven.wolf.lan>
References: <32541b130904291113p6f99a82ft824cd3c482447117@mail.gmail.com> <20090429223747.GG15420@raven.wolf.lan> <32541b130904291907q4003ad86v4728c5b2ba0aacb7@mail.gmail.com> <20090430222808.GH15420@raven.wolf.lan> <32541b130904301559w329bdd4bo6f2736a505b7235f@mail.gmail.com> <20090501142811.GI15420@raven.wolf.lan> <32541b130905011217x7f339d41x696fedee7298e3a4@mail.gmail.com> <20090502215852.GJ15420@raven.wolf.lan> <32541b130905040858v2a0b7a6br5b056a365fcb6855@mail.gmail.com> <20090504211423.GK15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 20:57:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1mIi-0000QU-OR
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 20:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327AbZEFS45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 14:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbZEFS44
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 14:56:56 -0400
Received: from quechua.inka.de ([193.197.184.2]:51587 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbZEFS44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 14:56:56 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1M1mIZ-0001cQ-P5; Wed, 06 May 2009 20:56:55 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 360172CCBD; Wed,  6 May 2009 20:52:24 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090504211423.GK15420@raven.wolf.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118372>

On Mon, May 04, 2009 at 11:14:23PM +0200, Josef Wolf wrote:

I am still trying to understand what is going on here, so I tried to
draw the history-graph.  It turns out that after the "getting-started"
commands is not what I would have expected:

>  git tag svn-1-orig svn-1
>  git tag svn-2-orig svn-2
> 
>  # move cherries to svn-2
>  #
>  git svn fetch svn-1
>  git checkout svn-2
>  git cherry-pick c9da
>  [ ... ]
>  git merge --no-ff -s ours svn-1
>  git checkout svn-2/trunk
>  git merge --no-ff svn-2
>  git svn dcommit
> 
>  # move cherries to svn-1
>  #
>  git svn fetch svn-2
>  git checkout svn-1
>  git cherry-pick 05b9
>  [ ... ]
>  git merge --no-ff -s ours svn-2
>  git checkout svn-1/trunk
>  git merge --no-ff svn-1
>  git svn dcommit

Here's what I have at this point:

             ------------------S1TRUNK
            /                 /
   --hs1--O1--c2...c2-------S1
            \              /
             `+++++++.    /
                      \  /
   --hs2--O2--c1...c1--S2
            \            \
             -------------S2TRUNK

   hs1, hs2:         history imported from svn-1 and svn2, respectively
   O1, O2:           the svn-1-orig and svn-2-orig tags
   c1, c2:           cherries picked from hs1 and hs2, respectively
   S1, S2:           svn-1 and svn-2, the local tracking branches
   S1TRUNK, S2TRUNK: the remotes/svn-X/trunk branches

I would have expected a symmetrical diagram.  But it turns out that the
connection marked with plusses is still at O1 instead of S1.  So it takes
no wonder that the c2 cherries get re-applied to the s2 branch on the
next merge.

Is this understanding somewhat plausible?  Any ideas how to get this
this fixed?
