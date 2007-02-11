From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to speed up "git log"?
Date: Sun, 11 Feb 2007 17:49:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702111252.28393.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 17:49:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGHsz-0007zV-Vj
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 17:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbXBKQtG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 11:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbXBKQtG
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 11:49:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:40185 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750726AbXBKQtF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 11:49:05 -0500
Received: (qmail invoked by alias); 11 Feb 2007 16:49:04 -0000
X-Provags-ID: V01U2FsdGVkX18uLQd438Qu4TkfcJ3IZ9RAYfgqufXNHY5KHPQk/K
	7snQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702111252.28393.bruno@clisp.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39293>

Hi,

On Sun, 11 Feb 2007, Bruno Haible wrote:

> Are there some known tricks to speed up the operation of "git log"?
> 
> On a file in a local copy of the coreutils git repository,
> "git log tr.c > output" takes
>   - 33 seconds of CPU time (33 user, 0 system) on a Linux/x86 500MHz system,
>   - 24 seconds of CPU time (12 user, 12 system) on a MacOS X PowerPC 1.1 GHz
>     system.
> The result shows only 147 commits and a total of 40 KB textual output.

Yes, because there were only 147 commits which changed the file. But git 
looked at all commits to find that.

Basically, we don't do file versions. File versions do not make sense, 
since they strip away the context. See also

http://news.gmane.org/group/gmane.comp.version-control.git/thread=37838

for a real flamewar revolving around that very subject.

> 1) Why so much user CPU time?

See above.

Plus, you are probably not really interested in _all_ revisions changing 
that file, are you? Usually the output of git-log -- even with pathname 
filtering -- starts almost instantaneous, and is piped to your pager. So, 
your numbers are misleading.

> 2) Why so much system CPU time, but only on MacOS X?

Probably the mmap() problem. Does it go away when you use git 1.5.0-rc4?

Hth,
Dscho
