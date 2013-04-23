From: Sadystio Ilmatunt <urkpostenardr@gmail.com>
Subject: Re: Help with git-svn and SVN symlinks
Date: Tue, 23 Apr 2013 22:54:50 +0000 (UTC)
Message-ID: <loom.20130424T005059-787@post.gmane.org>
References: <CAELx_2MamBzFZ3ZfA_08RTC56QHdCjNNsz0w0yYv4iCSZQNbPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 24 01:00:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUmC9-0001tB-67
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 01:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab3DWXAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 19:00:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:41152 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695Ab3DWXAG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 19:00:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UUmBv-0001ef-L5
	for git@vger.kernel.org; Wed, 24 Apr 2013 01:00:03 +0200
Received: from nat10.teradata.com ([153.65.16.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 01:00:03 +0200
Received: from urkpostenardr by nat10.teradata.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 01:00:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 153.65.16.10 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:20.0) Gecko/20100101 Firefox/20.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222215>

Any update about this:

I created this simple bug test to reproduce my problem.
I tried on latest GIT, It fails.
It is really preventing me from using GitSvn.
Any help will be highly appreciated.

Let me know if you have any questions.

[GITSVN] $git --version
git version 1.8.2.GIT
[GITSVN] $git svn --version
git-svn version 1.8.2.GIT (svn 1.5.7)



#Create svn repo
cd /tmp;
mkdir git-svn-prob;
cd /tmp/git-svn-prob;
/usr/bin/svnadmin create SVNTest-repo
svn co file:///tmp/git-svn-prob/SVNTest-repo SVNTest
cd SVNTest
echo "stuff in h" > h
echo -n  "link h" > hl
svn add h hl
svn commit -m "Adding two files";

#Create GIT-svn repo
cd ..;
mkdir GITSVN
cd  GITSVN
git svn init  file:///tmp/git-svn-prob/SVNTest-repo;
git svn fetch

# In SVN Repo, Modify hl to be link from file
cd ..
cd SVNTest;
svn ps svn:special '*' hl
rm hl
ln -s h hl
svn ci -m "Exisitng file modified to be link";
cat hl; 

# Fetch latest SVN rev and see problem
cd ..
cd GITSVN;
git svn fetch;
git co git-svn -f
cat hl; 
diff hl ../SVNTest/hl  # Fails, Should succeed
