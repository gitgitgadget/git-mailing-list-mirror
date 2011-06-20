From: Andrew Cameron <andrew@worksmartlabs.com>
Subject: Re: git checkout running very slowly (>12s)
Date: Mon, 20 Jun 2011 20:26:37 +0000 (UTC)
Message-ID: <loom.20110620T221426-685@post.gmane.org>
References: <loom.20110615T213016-856@post.gmane.org> <4DF9363F.6080009@op5.se> <loom.20110616T010709-333@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 20 22:26:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYl3j-0002ND-BR
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 22:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731Ab1FTU0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 16:26:52 -0400
Received: from lo.gmane.org ([80.91.229.12]:44220 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789Ab1FTU0w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 16:26:52 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QYl3a-0002J4-Kl
	for git@vger.kernel.org; Mon, 20 Jun 2011 22:26:50 +0200
Received: from rrcs-184-75-102-164.nyc.biz.rr.com ([184.75.102.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 22:26:50 +0200
Received: from andrew by rrcs-184-75-102-164.nyc.biz.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 22:26:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 184.75.102.164 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.91 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176091>

Andrew Cameron <andrew <at> worksmartlabs.com> writes:

> 
> $ git --version
> git version 1.7.0.4
> 

In the interest of leaving a message of hope in the archives for users 
experiencing this same problem, I will record to the list that I managed to 
solve the problem, if not understand it.  As you can see in the transcript 
above, I had been using an older version of git:

> $ git --version
> git version 1.7.0.4

After running sudo apt-get build-dep git-core and then building git from
source, we see this instead:

> $ git --version
> git version 1.7.5.4

And the success story:

$ time git checkout master
Switched to branch 'master'
git checkout master  0.88s user 0.25s system 99% cpu 1.135 total
$ time git checkout -
Switched to branch 'newbranch'
git checkout -  0.87s user 0.25s system 99% cpu 1.121 total

It might be interesting to note that both before and after upgrading git, 
running "strace -c git checkout master" in an attempt to figure out where all my 
time was spent was *not* particularly helpful.  An excerpt from strace's output 
from before the upgrade:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
100.00    0.003499           0     90884         7 lstat64

And another one from afterwards:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 99.24    0.003276           0     90886         7 lstat64

In other words, it appears that an efficient lstat implementation was not the 
key factor in this problem.  The root cause remains a mystery, but in my case, 
the solution was to upgrade Git.

Thanks for reading.
