From: Parag Warudkar <parag.warudkar@gmail.com>
Subject: Problem with git-clone
Date: Sat, 21 Apr 2007 17:15:46 +0000 (UTC)
Message-ID: <loom.20070421T190848-931@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 21 19:20:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfJG1-0005xv-8e
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 19:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbXDURUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 13:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbXDURUR
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 13:20:17 -0400
Received: from main.gmane.org ([80.91.229.2]:56087 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907AbXDURUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 13:20:15 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HfJFi-0008F2-Kl
	for git@vger.kernel.org; Sat, 21 Apr 2007 19:20:03 +0200
Received: from c-68-60-176-179.hsd1.mi.comcast.net ([68.60.176.179])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 19:20:02 +0200
Received: from parag.warudkar by c-68-60-176-179.hsd1.mi.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 19:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 68.60.176.179 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20061201 Firefox/2.0.0.3 (Ubuntu-feisty))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45184>

I have a reproducible problem with git-index-pack getting stuck. 
Is this a known problem fixed in one of the later releases? 

git --version
git version 1.4.4.2

git-clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
linux-2.6-wk
remote: Generating pack...
remote: Done counting 445435 objects.
remote: Deltifying 445435 objects.
remote:  100% (445435/445435) done
Indexing 445435 objects.
   0% (194/445435) done

It stays there for ever. If I attach to all the git-* processes using strace
here is what it shows -

 strace -p 9055  # This is git-index-pack
Process 9055 attached - interrupt to quit
read(0, 0x8063ba0, 4096)                = ? ERESTARTSYS (To be restarted)
--- SIGALRM (Alarm clock) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
read(0, 0x8063ba0, 4096)                = ? ERESTARTSYS (To be restarted)
--- SIGALRM (Alarm clock) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
read(0,  <unfinished ...>
Process 9055 detached

 strace -p 9054 # This is git-fetch-pack
Process 9054 attached - interrupt to quit
read(3,  <unfinished ...>
Process 9054 detached
paragw@paragw-desktop:~$ strace -p 9053 #git-fetch-pack
Process 9053 attached - interrupt to quit
waitpid(9055,  <unfinished ...>
Process 9053 detached
paragw@paragw-desktop:~$ strace -p 9046 # This is git-clone
Process 9046 attached - interrupt to quit
wait4(-1,  <unfinished ...>
Process 9046 detached
