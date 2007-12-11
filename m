From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Wed, 12 Dec 2007 00:08:57 +0100
Message-ID: <F7561A3C-06F1-413B-96E2-F9707C193FB2@zib.de>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com> <20071211223742.GB19857@steel.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: David <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 00:08:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ED3-0007xC-F0
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 00:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbXLKXH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 18:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753034AbXLKXH4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 18:07:56 -0500
Received: from mailer.zib.de ([130.73.108.11]:37945 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948AbXLKXHy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 18:07:54 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lBBN7po8015241;
	Wed, 12 Dec 2007 00:07:51 +0100 (CET)
Received: from [192.168.178.21] (brln-4db824ef.pool.einsundeins.de [77.184.36.239])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lBBN7oAM015947
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 12 Dec 2007 00:07:50 +0100 (MET)
In-Reply-To: <20071211223742.GB19857@steel.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67964>


On Dec 11, 2007, at 11:37 PM, Alex Riesen wrote:

> David, Tue, Dec 11, 2007 14:48:32 +0100:
>> Though there's still a few things remaining to be implemented, the
>> bulk of the initial groundwork is already done.  All you need to
>> build/run it is python and pyqt4 (pyuic4).  I've deliberately  
>> tried to
>> keep the interface similar to git-gui for now since it is obviously
>> based on it, but that's not a requirement.
>
> Interesting. I had to start it like this:
>
> 	$ export PYTHONPATH=$(pwd)/build/default:$(pwd)/build/default/ui
> 	$ python ./build/default/bin/ugit.pyc
>
> It has some problem with merges in "Git Commit Browser": takes a lot
> of CPU and very slowly generates a very big diff.
>
> The diff view is very ... dark. Out of place, when the rest of the
> interface corresponds to system theme (mine is rather light).


Yeah, it's dark here (Mac OS X), too -- doesn't look very
friendly.

It took me some time to get the full Qt, SIP, PyQT toolchain
running ... below's my first (tiny) fix that makes
"Branch > Create ..." work if you don't select track.

	Steffen

diff --git a/py/cmds.py b/py/cmds.py
index 5abf930..4a35ead 100644
--- a/py/cmds.py
+++ b/py/cmds.py
@@ -119,8 +119,8 @@ def git_create_branch (name, base, track=False):
         '''Creates a branch starting from base.  Pass track=True
         to create a remote tracking branch.'''
         cmd = 'git branch'
-       if track: cmd += ' --track '
-       cmd += '%s %s' % ( utils.shell_quote (name),
+       if track: cmd += ' --track'
+       cmd += ' %s %s' % ( utils.shell_quote (name),
                         utils.shell_quote (base))
         return commands.getoutput (cmd)
