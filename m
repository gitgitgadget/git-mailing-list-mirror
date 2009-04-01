From: Josef Wolf <jw@raven.inka.de>
Subject: How to sync two svn repositories via git?
Date: Thu, 2 Apr 2009 00:30:52 +0200
Message-ID: <20090401223052.GA28619@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 00:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp93M-0003n7-NZ
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 00:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762151AbZDAWf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 18:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760950AbZDAWf0
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 18:35:26 -0400
Received: from quechua.inka.de ([193.197.184.2]:49894 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760019AbZDAWfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 18:35:25 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1Lp91m-0002dN-IZ; Thu, 02 Apr 2009 00:35:22 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 702162CBE0; Thu,  2 Apr 2009 00:30:52 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115420>

Hello,

I have two subversion repositories which I would like to synchronize via
git-svn.  For this, I have set up a git repository and configured two
branches to track the subversion repositories via git-svn:

    mkdir test-sync
    cd    test-sync
    git svn init --stdlayout file://$REPOSDIR/svn-first

    for repos in svn-first svn-second; do
        git config svn-remote.$repos.url      file://$REPOSDIR/$repos
        git config svn-remote.$repos.fetch    trunk:refs/remotes/$repos/trunk
        git config svn-remote.$repos.branches branches/*:refs/remotes/$repos/*
        git config svn-remote.$repos.tags     tags/*:refs/remotes/$repos/tags/*
        git svn fetch -R $repos
        git checkout -b $repos $repos/trunk
    done
    git gc

This gives me two remote and two local branches:

    master                                                                                    
    svn-first                                                                                 
  * svn-second                                                                                
    svn-first/trunk                                                                           
    svn-second/trunk                                                                          

The first step I'd like to do is to "mirror" the manual merges that were
done between the subversion repositories in the past:

    git checkout svn-first
    git merge -s ours --log commit-of-the-first-merge-in-svn-second

    git checkout svn-second
    git merge -s ours --log commit-of-the-first-merge-in-svn-first

This seems to work, but git-gui shows conflicts.  How can I get conflicts
when I use the "-s ours" merge strategy?
