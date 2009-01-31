From: Josef Wolf <jw@raven.inka.de>
Subject: How to move subdirectories from one svn repos to another.
Date: Sat, 31 Jan 2009 13:33:36 +0100
Message-ID: <20090131123336.GA1702@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 14:04:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTFWG-0003lN-F8
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 14:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbZAaNCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 08:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbZAaNCz
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 08:02:55 -0500
Received: from quechua.inka.de ([193.197.184.2]:33233 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbZAaNCy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 08:02:54 -0500
X-Greylist: delayed 1362 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Jan 2009 08:02:54 EST
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LTF8r-0002hl-I0; Sat, 31 Jan 2009 13:40:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id E98252C8C9; Sat, 31 Jan 2009 13:33:36 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107919>

Hello,

I would like to move a complete subdirectory with all its history from
one svn repository to another.

For this, I have created a git repository with the two subversion
repositories as remotes:


  REPOSROOT=https://foo.bar.com/repos

  mkdir -p migrate
  cd migrate
  git svn init --stdlayout $REPOSROOT/my-repos
  
  for i in my-repos their-repos; do
    git config svn-remote.$i.url                   $REPOSROOT/$i
    git config svn-remote.$i.fetch         trunk:refs/remotes/$i/trunk
    git config svn-remote.$i.branches branches/*:refs/remotes/$i/*
    git config svn-remote.$i.tags         tags/*:refs/remotes/$i/tags/*
    git svn fetch -R $i
    git checkout -b $i $i/trunk
  done
  
  git gc


Now I would like to move one directory (call it bar) from my-repos
to their-repos.  Problem is: there are thousands of changesets in
this directory.  So I got somewhat stuck (I am new to git).  Do I
have to cherry-pick every changeset separately?  Or is there some
way to merge all the changesets touching this specific directory?

Any hints?
