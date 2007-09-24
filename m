From: Guillaume Chazarain <guichaz@yahoo.fr>
Subject: Problem importing a subversion repository with git-svnimport
Date: Mon, 24 Sep 2007 18:49:41 +0200
Message-ID: <20070924184941.0d771306@cheypa.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 19:01:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZrIB-0001bI-Ur
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 19:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759019AbXIXQ7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 12:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757561AbXIXQ7j
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 12:59:39 -0400
Received: from mail1-relais-roc.national.inria.fr ([192.134.164.82]:34893 "EHLO
	mail1-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759383AbXIXQ7i (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2007 12:59:38 -0400
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Sep 2007 12:59:38 EDT
X-IronPort-AV: E=Sophos;i="4.20,292,1186351200"; 
   d="scan'208";a="1369028"
Received: from cheypa.inria.fr ([138.96.218.90])
  by mail1-relais-roc.national.inria.fr with ESMTP; 24 Sep 2007 18:49:42 +0200
X-Mailer: Claws Mail 3.0.1cvs20 (GTK+ 2.10.14; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59063>

Hello,

Here is a simple testcase illustrating a conversion problem between
subversion and git. git-svn handles it fine, but git-svnimport keeps
stuff in the checkout that shouldn't be there.

# git --version => git version 1.5.3.2.99.ge4b2
# svn --version | head -n 1 => svn, version 1.4.3 (r23084)

mkdir test-svn
cd test-svn
svnadmin create svn-repo
svn co file://$PWD/svn-repo svn-check-out
cd svn-check-out
mkdir trunk branches tags
svn add *
svn ci -m 'SVN dirs'
cd trunk
mkdir -p a/b/c/d
echo A > a/A
echo B > a/b/B
echo C > a/b/c/C
echo D > a/b/c/d/D
svn add a
svn ci -m 'Add some data'
svn mv a/b .
svn rm b/c
svn ci -m 'Some shuffling around'
ls -R
cd ../..
mkdir git-repo
cd git-repo
git-svnimport file://$PWD/../svn-repo
ls -R

After the subversion manipulations, the svn checkout only contains the
directories a/ b/ with their respective files A and B.

The checkout from git-svnimport contains these elements, but also the
full c/ directory in b/.

Hope the testcase is clear enough ;-)

-- 
Guillaume
