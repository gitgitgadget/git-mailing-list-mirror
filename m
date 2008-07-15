From: Yves Orton <yves.orton@booking.com>
Subject: Re: [PATCH] git rev-parse: Fix --show-cdup inside symlinked  
	directory
Date: Tue, 15 Jul 2008 22:26:27 +0200
Message-ID: <1216153587.19334.204.camel@gemini>
References: <1216131208.19334.171.camel@gemini>
	 <20080715145920.13529.25603.stgit@localhost>
	 <alpine.DEB.1.00.0807151614510.8950@racer>
	 <20080715154036.GR10151@machine.or.cz> <1216140100.19334.189.camel@gemini>
	 <1216141099.19334.196.camel@gemini> <487CF5A4.2070700@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Tue Jul 15 22:28:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIr7h-0004WK-P7
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 22:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762781AbYGOU0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 16:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758821AbYGOU0g
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 16:26:36 -0400
Received: from msx2.activehotels.net ([62.190.24.12]:39581 "EHLO
	mx2.activehotels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762703AbYGOU0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 16:26:34 -0400
Received: from p5098d9db.dip0.t-ipconnect.de ([80.152.217.219] helo=[192.168.250.20])
	by mx2.activehotels.net with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.50)
	id 1KIr6S-0000nw-Km; Tue, 15 Jul 2008 21:26:28 +0100
In-Reply-To: <487CF5A4.2070700@dawes.za.net>
X-Mailer: Evolution 2.22.3.1 
X-AH-Spam-Helo: [192.168.250.20]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88593>

On Tue, 2008-07-15 at 21:08 +0200, Rogan Dawes wrote:
> Yves Orton wrote:
> 
> > Hmm, realizing that was the workdir it wanted i tried it like so:
> > 
> > [dmq@somewhere apps]$ git --work-tree="$(git-rev-parse --git-dir)/.."
> > pull --rebase
> > /usr/bin/git-sh-setup: line 139: cd: /home/dmq/git_tree/main/apps/.git:
> > No such file or directory
> > Unable to determine absolute path of git directory
> > 
> > Yet:
> > 
> > [dmq@somewhere apps]$ git-rev-parse --git-dir
> > /home/dmq/git_tree/main/.git
> > 
> > is correct.
> > 
> 
> Are you sure you don't want to specify the --git-dir rather than the 
> work dir?
> 
> i.e.
> 
> git --git-dir="$(git-rev-parse --git-dir)" pull --rebase

That doesnt seem to work correctly either. If i do it from the symlinked
directory i get a notice about each file needing an update. While it
works as expected from the real repo directory.

I think this shows what i mean:

demerphq@gemini:~/git_test/bar$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   bar
#
no changes added to commit (use "git add" and/or "git commit -a")
demerphq@gemini:~/git_test/bar$ git commit -a -m'changed bar'
Created commit 7cbbdc9: changed bar
 1 files changed, 1 insertions(+), 0 deletions(-)
demerphq@gemini:~/git_test/bar$ git --git-dir="$(git-rev-parse
--git-dir)" pull --rebase
bar/bar: needs update
refusing to pull with rebase: your working tree is not up-to-date
demerphq@gemini:~/git_test/bar$ cd ../foo2
demerphq@gemini:~/git_test/foo2$ git --git-dir="$(git-rev-parse
--git-dir)" pull --rebase
Current branch master is up to date.
demerphq@gemini:~/git_test/foo2$ cd ..
demerphq@gemini:~/git_test$ ls -lart
total 24
drwxr-xr-x   4 demerphq demerphq  4096 2008-07-15 22:17 foo
drwxr-xr-x 116 demerphq demerphq 12288 2008-07-15 22:18 ..
lrwxrwxrwx   1 demerphq demerphq     8 2008-07-15 22:20 bar -> foo2/bar
drwxr-xr-x   4 demerphq demerphq  4096 2008-07-15 22:20 .
drwxr-xr-x   4 demerphq demerphq  4096 2008-07-15 22:21 foo2



Yves
