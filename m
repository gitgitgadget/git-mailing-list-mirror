From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: git-svnimport
Date: Fri, 03 Feb 2006 18:47:43 -0800
Message-ID: <16255.1139021263@lotus.CS.Berkeley.EDU>
References: <200602031429.07894.jharrison@linuxbs.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 03:48:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5DSy-0001mn-Pr
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 03:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946269AbWBDCrw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 21:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946270AbWBDCrw
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 21:47:52 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:45723 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1946269AbWBDCrw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 21:47:52 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id k142lixV016257;
	Fri, 3 Feb 2006 18:47:44 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k142ligZ016256;
	Fri, 3 Feb 2006 18:47:44 -0800 (PST)
To: Jason Harrison <jharrison@linuxbs.org>
In-reply-to: <200602031429.07894.jharrison@linuxbs.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15566>

And Jason Harrison writes:
 - I am trying to import from an svn repository into a git repository using 
 - git-svnimport.  So far my attempts have failed.  Here is what I have done so 
 - far.
 - 
 - git-svnimport svn://svn.debian.org/demi/
[...]
 - git-svnimport -T demi svn://svn.debian.org/demi/
[...]

It seems git-svnimport requires one level of directory 
structure.  Running 
  git-svnimport -T bin svn://svn.debian.org/demi/
gives me the contents of the bin directory while (noisily)
ignoring everything else.  I think svn repositories
usually have a structure with branches in one directory,
tags in another, and its version of HEAD in yet another.

Looking through the git-svnimport source makes it appear
difficult to just snarf just one directory (maybe /) out 
of a svn repository.  Actually, it makes everything svn-
related appear difficult.  Why should I worry about
memory management by default in Perl?!?  It'd be nice if 
there were an git-svnimport-trivial that just snarfed a 
single URL without tags or branches.

I have to deal with a few repos with bizarre directory 
structures but _no_ branches or tags, and I found a work-
around that may be good enough.  Mirroring the repos using
svm (or svn-mirror, from SVN::Mirror) then importing the
mirrors works, but it gives an extraneous first commit.
Example derived from the svn-mirror/svm man page:
  env SVMREPOS=${HOME}/svm svn-mirror init mirror/demi \
        svn://svn.debian.org/demi
  env SVMREPOS=${HOME}/svm svn-mirror sync mirror/demi
  git-svnimport -v -T mirror/demi file://${HOME}/svm

That may spew messages about unrecognized paths if you 
mirror a few repos, but it should work.  Syncing and re-
running git-svnimport appears to keep things up-to-date, 
but I haven't had much opportunity to test that.

SVK (same author as SVN::Mirror) might work for creating
a mirror, possibly without the extraneous first commit, 
but I couldn't figure out the right -T and URL options 
for git-svnimport.

Jason
