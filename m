From: apw@us.ibm.com (Amos Waterland)
Subject: Subproject clones
Date: Fri, 11 May 2007 21:16:00 -0400
Message-ID: <20070512011600.GA24354@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 03:24:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmgL2-0000rh-VJ
	for gcvg-git@gmane.org; Sat, 12 May 2007 03:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279AbXELBXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 21:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755424AbXELBXz
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 21:23:55 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:33392 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015AbXELBXy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 21:23:54 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4C1NrMq027783
	for <git@vger.kernel.org>; Fri, 11 May 2007 21:23:53 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4C1Nr8Z525006
	for <git@vger.kernel.org>; Fri, 11 May 2007 21:23:53 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4C1NrFJ016934
	for <git@vger.kernel.org>; Fri, 11 May 2007 21:23:53 -0400
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l4C1Nr4Z016931
	for <git@vger.kernel.org>; Fri, 11 May 2007 21:23:53 -0400
Received: by kvasir.watson.ibm.com (Postfix, from userid 1000)
	id 0E546B151F1; Fri, 11 May 2007 21:16:00 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47009>

The logic in t3040-subprojects-basic.sh assumes that comparing the
output of 'git-ls-files -s' when run in the original superproject and
when run in the cloned superproject is a good test that cloning worked.

However, the output of git-ls-files does not include the files in
subprojects, so this test passes, even though the clone contains only
the directories of the subprojects and none of their containing files 
or .git subdirectories.

In other words, given this:

 superproject
  sub1
   Makefile
  sub2
   Makefile

when somebody does `git-clone superproject', I believe they expect to
get the same tree.  Instead, they get this:

 superproject
  sub1
  sub2

Note that `git-clone superproject/sub1` works as expected, but this
sequence fails:

 git-clone superproject foo 
 cd foo
 git-clone ../superproject/sub1

As does this sequence:

 git-clone superproject foo 
 cd foo/sub1
 git-pull ../superproject/sub1

So there is no way that I can see to actually clone a project that has
subprojects.

Is this intentional?  Shouldn't clone get the entire superproject?
