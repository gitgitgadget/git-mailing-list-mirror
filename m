From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Workflow for "rolling out" commits
Date: Mon, 7 Jun 2010 20:42:15 +0200
Message-ID: <AANLkTiklLo6YCOGpMtKQnLa1yZsltd2VCVzuZUlqShvd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 20:42:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLhHV-0004gR-Pt
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 20:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305Ab0FGSmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 14:42:37 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47015 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894Ab0FGSmg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 14:42:36 -0400
Received: by gye5 with SMTP id 5so2471979gye.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:cc:content-type;
        bh=9K+uN6zqs6GRGdi6/PI0CtmsSkJdMFjKHvSaI6EgvvI=;
        b=BBuloqXcY3gfeZZ7XE58P6xZXNDPewyAeRgEmOLAk1P63u4hTqDuc2bx8lvxmY8szP
         Ln/nJsNjCvg98Y4KyRY1JO53N64TBKvNlWQK3eFtctqcvLQBbxrSqiOR1Hc+TDx4Wvx7
         T3zFfgcCJpbTJ5/lUxeFlnryqY/qHRBTBbQPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=NqizASA1TGYVeYe2QItjvfyfzzztA86px5Xn1vsAC6OHUz9iQN4JCAnJYjZb05btic
         xtSDKzTUsCLls7L0w4Xfl1JQAxMbo1tj/Wx/AUgxlFnSNsgVk9i1hwxBdcU5RavCz5Ap
         ymJZbkGlRX7FjkfO9vN4c0IbMBvE+AJbysTPc=
Received: by 10.229.234.3 with SMTP id ka3mr2540338qcb.261.1275936155191; Mon, 
	07 Jun 2010 11:42:35 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 7 Jun 2010 11:42:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148615>

Hi,

I spend a great deal of time preparing patches for the mailing list,
and it's time I asked for help to optimize the process I'm using. I'll
explain what I'm doing in detail, and why I'm doing it- I'd love it if
someone could tell me how to do it better.

I work on two repositories: git.git and svn-fe.git. In svn-fe.git, we
mainly work on `master`, occasionally forking out feature branches and
merging them back. I also work on a certain `git-merge` branch that
only has changes specific to getting svn-fe.git merged into git.git;
it is based on `master` and constantly needs to be rebased everytime
`master` updates. `master`, on the other hand, is intended to maintain
and compile an independent application. To send patches to the mailing
list, I have another branch `rollout` which is basically the
`git-merge` branch stripped of revision history (the `git-merge`
branch has thousands of commits, and I don't want this revision
history to be part of git.git). In `rollout`, I have neatly added
files logically and prepared six commits to send directly to the
mailing list.

In git.git, I have a remote corresponding to svn-fe.git, and use
git-read-tree with a prefix = $GIT_ROOT/vcs_svn to import the
`rollout` branch from svn-fe.git into the vcs-svn/ directory (Thanks
to Sverre I don't cherry-pick, git-mv and amend the commits one by
one). I then use format-patch and send-email to send emails to the
mailing list.

Whenever `master` updates, I first rebase `git-merge` onto `master`,
copy out the new files from the `git-merge` working copy to the
`rollout` working copy, make more commits to squash into the six
existing commits in `git-merge`(*). Then I fetch the objects into
git.git and import the tree again.

(*) I can theoretically automate this on a fresh `rollout` branch by
using a shell script to add the files and make out commits one-by-one
by picking up the commit messages from a text file.

Thanks for reading.

-- Ram
