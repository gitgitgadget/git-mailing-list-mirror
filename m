From: Rogan Dawes <lists@dawes.za.net>
Subject: git-svn and googlecode.com?
Date: Tue, 05 Jun 2007 10:11:25 +0200
Message-ID: <46651AAD.4010705@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 10:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvU8o-0003lV-GK
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 10:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbXFEILn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 04:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756031AbXFEILn
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 04:11:43 -0400
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:46361 "EHLO
	spunkymail-a14.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752338AbXFEILl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2007 04:11:41 -0400
Received: from [192.168.201.100] (dsl-146-26-199.telkomadsl.co.za [165.146.26.199])
	by spunkymail-a14.g.dreamhost.com (Postfix) with ESMTP id 7F558190E34
	for <git@vger.kernel.org>; Tue,  5 Jun 2007 01:11:39 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49168>

Hi,

Thanks to Martin, I got git svnimport working on the Spring Rich Client 
Sourceforge repository. The published SVN checkout command line was:

svn co https://spring-rich-c.svn.sourceforge.net/svnroot/spring-rich-c \
  spring-rich-c

This translated into a git svnimport invocation of:

git-svnimport -i -v -o origin -T trunk/spring-richclient -t tags \
  -b branches \
https://spring-rich-c.svn.sourceforge.net/svnroot/spring-rich-c/

which works very well.

 From this I assume that the usual translation from Sourceforge 
published command lines works something like:

git svnimport -i -v -o origin -T trunk/<first path component> -t tags \
  -b branches <URL>

Using a similar approach for a repo at code.google.com, I tried:

(Original) svn checkout http://webgoat.googlecode.com/svn/trunk/ webgoat

(Funny, the initial path component had a space in it?!)

0 $ git-svn clone -T "trunk/ webgoat" 
https://webgoat.googlecode.com/svn/trunk/
Initialized empty Git repository in .git/
Using higher level of URL: https://webgoat.googlecode.com/svn/trunk => 
https://webgoat.googlecode.com/svn
W: Ignoring error from SVN, path probably does not exist: (175002): RA 
layer request failed: REPORT request failed on '/svn/!svn/bc/100': 
REPORT of '/svn/!svn/bc/100': 200 OK (https://webgoat.googlecode.com)
Path 'trunk/trunk/ webgoat' was probably deleted:
RA layer request failed: REPORT request failed on '/svn/!svn/bc/126': 
REPORT of '/svn/!svn/bc/126': 200 OK (https://webgoat.googlecode.com)
Will attempt to follow revisions r101 .. r126 committed before the deletion
0 $

This didn't actually do anything other than creating the .git directory 
structure, and creating one svn related file, even though it exited with 
a zero status (the prompt above includes the exit status of the previous 
command), and gave no diagnostics or error messages (other than "Using 
higher level . . . ")

1 $ find .git
.git
.git/branches
.git/config
.git/description
.git/HEAD
.git/hooks
.git/hooks/applypatch-msg
.git/hooks/commit-msg
.git/hooks/post-commit
.git/hooks/post-receive
.git/hooks/post-update
.git/hooks/pre-applypatch
.git/hooks/pre-commit
.git/hooks/pre-rebase
.git/hooks/update
.git/info
.git/info/exclude
.git/objects
.git/objects/info
.git/objects/pack
.git/refs
.git/refs/heads
.git/refs/tags
.git/remotes
.git/svn
.git/svn/.metadata
.git/svn/trunk
.git/svn/trunk/.rev_db.4033779f-a91e-0410-96ef-6bf7bf53c507

However, the following command line does seem to work:

git-svn clone -T "trunk/ webgoat" https://webgoat.googlecode.com/svn/

Note that I manually removed the "trunk" component from the URL. This 
suggests that there is something missing in the automatic "Using higher 
level" detection code.

Hope this helps someone diagnose this bug, as well as use git for 
accessing GoogleCode projects in the future.

Rogan
