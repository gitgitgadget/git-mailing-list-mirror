From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Bad git status performance
Date: Fri, 21 Nov 2008 01:28:14 +0100
Message-ID: <4926009E.4040203@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 21 01:30:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3JuS-0002xY-P5
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 01:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007AbYKUA2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 19:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754937AbYKUA2S
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 19:28:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:40923 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753308AbYKUA2R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 19:28:17 -0500
Received: (qmail invoked by alias); 21 Nov 2008 00:28:14 -0000
Received: from 93-61.78-83.cust.bluewin.ch (EHLO [192.168.123.204]) [83.78.61.93]
  by mail.gmx.net (mp050) with SMTP; 21 Nov 2008 01:28:14 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX198NCMZlZ98lKDrt/k610OGyC9H8gCAdSeuVA9OE2
	V9Q2BUtuPN/4zz
User-Agent: Thunderbird 2.0.0.17 (X11/20080928)
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101483>

Hi list!

I'm getting bad performance on 'git status' when I have staged
many changes to big files.  For example, consider this:

$ git init
Initialized empty Git repository in $HOME/test/.git/

$ for X in $(seq 100); do dd if=/dev/zero of=$X bs=1M count=1 2> /dev/null; done

$ git add .

$ git commit -m 'Lots of zeroes'
Created initial commit ed54346: Lots of zeroes
 100 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 1
 create mode 100644 10
...
 create mode 100644 98
 create mode 100644 99

$ for X in $(seq 100); do echo > $X; done

$ time git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   1
#       modified:   10
...
#       modified:   98
#       modified:   99
#
no changes added to commit (use "git add" and/or "git commit -a")

real    0m0.003s
user    0m0.001s
sys     0m0.002s

$ git add -u

$ time git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   1
#       modified:   10
...
#       modified:   98
#       modified:   99
#

real    0m16.291s
user    0m16.054s
sys     0m0.221s

The first 'git status' shows the same difference as the second,
just the second time it's staged instead of unstaged.  Why does it
take 16 seconds the second time when it's instant the first time?

(Side note: There once was a discussion about adding natural order
of branch names, but seems it never made it into git.  The same
would make sense for 'git status' too.)

Cheers,
jlh
