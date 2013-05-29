From: Andre Esser <andre.esser@geneity.co.uk>
Subject: Check out doesn't set x-flag on CIFS
Date: Wed, 29 May 2013 14:16:01 +0000 (UTC)
Message-ID: <loom.20130529T161408-317@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 16:20:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhhEg-0005VG-29
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 16:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966276Ab3E2OUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 10:20:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:59617 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966092Ab3E2OUF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 10:20:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UhhER-0005KN-ST
	for git@vger.kernel.org; Wed, 29 May 2013 16:20:03 +0200
Received: from 83-244-221-232.cust-83.exponential-e.net ([83.244.221.232])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 May 2013 16:20:03 +0200
Received: from andre.esser by 83-244-221-232.cust-83.exponential-e.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 May 2013 16:20:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.244.221.232 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:21.0) Gecko/20100101 Firefox/21.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225833>

Hello,

When on a CIFS filesystem a git checkout does not replicate the executable
flag from the repository:

  $ git clone git://git/abettersqlplus
  Cloning into 'abettersqlplus'...
  remote: Counting objects: 522, done.
  remote: Compressing objects: 100% (342/342), done.
  remote: Total 522 (delta 166), reused 522 (delta 166)
  Receiving objects: 100% (522/522), 82.40 KiB, done.
  Resolving deltas: 100% (166/166), done.
  $ ls -l abettersqlplus/absp.py
  -rw-rw-r-- 1 aesser geneity 45860 May 29 14:46 abettersqlplus/absp.py


Subsequently git status reports the file as changed:

  $ cd abettersqlplus/
  $ git status
  # On branch master
  # Changes not staged for commit:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working
  directory)
  #
  #    modified:   absp.py
  #
  no changes added to commit (use "git add" and/or "git commit -a")


If I set the x-flag manually, all is well:

  $ chmod +x absp.py
  $ git status
  # On branch master
  nothing to commit (working directory clean)


This problem doesn't occur on ext3 or NFS file systems. Client is Ubuntu
12.04 with git version 1.7.9.5. CIFS is exported from Ubuntu 12.04 with
Samba version 3.6.3.

Since git recognises the x-flag on this CIFS file system, shouldn't it also
be able to set it on checkout?


Many thanks,

Andre Esser
