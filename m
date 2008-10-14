From: "Marcel M. Cary" <marcel@earth.care2.com>
Subject: from symlinked directory: unable to chdir or not a git archive
Date: Tue, 14 Oct 2008 15:58:13 -0700
Message-ID: <48F52405.6010406@earth.care2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 01:04:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpswR-0004Q6-CL
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 01:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbYJNXD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 19:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752157AbYJNXD2
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 19:03:28 -0400
Received: from exchange01.care2.com ([38.99.18.107]:47594 "EHLO
	exchange01.earth.care2.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752092AbYJNXD1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2008 19:03:27 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Oct 2008 19:03:27 EDT
Received: from [127.0.0.1] (63.146.170.73) by exchange01.earth.care2.com
 (38.99.18.107) with Microsoft SMTP Server id 8.0.813.0; Tue, 14 Oct 2008
 16:02:19 -0700
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
X-PureMessage: [Scanned]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98223>

I'm getting an error:

  fatal: 'origin': unable to chdir or not a git archive

when trying to pull even though pushing works just fine.  So I don't
think the problem is that the remote repository doesn't exist.  (I see
the entry in GitFaq for this error message, but I don't think that
answer quite explains this situation.)

I think it's important that, when pulling, I'm in a directory that is a
symlink into the Git working copy.  Having git operate correctly in that
environment is important to me because Git doesn't support checking out
a subdirectory of my project.

A shell transcript follows that illustrates a simplified problem
scenario using Git 1.6.0.1.  I see the same error message with 1.6.0.2
and 1.6.0.2.530.g67faa (master branch today).

Is there an easy way around this?  Right now I have to cd to the target
of the symlink to do the pull, which is annoying.

Thanks,
Marcel

~/git$ mkdir tmp-repo
~/git$ cd tmp-repo/
~/git/tmp-repo$ git init
Initialized empty Git repository in /home/marcel/git/tmp-repo/.git/
~/git/tmp-repo$ mkdir foo
~/git/tmp-repo$ touch foo/bar
~/git/tmp-repo$ git add foo/bar
~/git/tmp-repo$ git commit -m 'Add empty file'
Created initial commit 651b80a: Add empty file
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo/bar
~/git/tmp-repo$ cd ..
~/git$ git clone tmp-repo clone-repo
Initialized empty Git repository in /home/marcel/git/clone-repo/.git/
~/git$ ln -s clone-repo/foo/ foo-link
~/git$ cd foo-link/
~/git/foo-link$ echo hello >> bar
~/git/foo-link$ git commit -a -m 'Say hi'
Created commit 0a92c49: Say hi
 1 files changed, 1 insertions(+), 0 deletions(-)
~/git/foo-link$ git push origin master
Counting objects: 7, done.
Writing objects: 100% (4/4), 281 bytes, done.
Total 4 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (4/4), done.
To /home/marcel/git/tmp-repo/.git
   651b80a..0a92c49  master -> master
~/git/foo-link$ git pull
fatal: 'origin': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly
~/git/foo-link$ cd ~/git/clone-repo/foo
~/git/clone-repo/foo$ git pull
Already up-to-date.
~/git/clone-repo/foo$

on Linux 2.6.18-4-486, ext3
