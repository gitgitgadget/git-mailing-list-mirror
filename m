From: Aaron Laws <dartme18@gmail.com>
Subject: git-svn Rewrites Some Commits, but not All
Date: Mon, 28 Apr 2014 15:26:20 -0400
Message-ID: <CADu-kvcXWXAd2iBt+oQOVt5znxLmU0fmJ-tgOaogyfGjS5R0vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:27:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerD2-0001HQ-3A
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbaD1T0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:26:42 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:51604 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932862AbaD1T0l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:26:41 -0400
Received: by mail-qg0-f45.google.com with SMTP id a108so7477246qge.32
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=9id6WFPSNN1ii1660DqTwxWC6n8UDsmEoFl9wAn+HnM=;
        b=HLH/Y/Nid4YYTmNkoay4w3EU4Ip4Gp3K3P9uw0W5vOQRy+wjNObTdLxHuCxKu1Ph/w
         xbBZuJZrEgBp6GnCvfKWiFn9daFFWssdhNhG/YsgTZPeIF9GveNLd08Gw3nG8tNqk0tj
         lplhWZkCpyEl5oK7VkqLGw36jTOPs6mMJR69WGrC2D0Kvb5aC4rAR1uTs5xXWP4Re9T+
         uzEZDsCcWlClY5Ol5wu6OzZJPgQhFbeCMG2+MO7dR2Zmg1VZMKQesV6/LCDfYhOKQsvb
         7pFSzg67eM8fbT+J79bxLd/P+W7xuzEKQjWfEcFCifjv3e64n7qeJOlYfVJ5fRYi2Y4N
         I24g==
X-Received: by 10.224.163.73 with SMTP id z9mr6971260qax.90.1398713200489;
 Mon, 28 Apr 2014 12:26:40 -0700 (PDT)
Received: by 10.140.95.151 with HTTP; Mon, 28 Apr 2014 12:26:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247405>

Hello.

I've been using git-svn for some time now, and I'm very happy with it.
There is one thing that I'm wondering about, however.

The way I understand it, when `git svn dcommit` is run, new commits
are created (A' is created from A adding SVN information), then the
current branch is moved to point to A'. Why don't we move any other
refs that were pointing to A over to A' ? What would be the point of
continuing to point to A? I'm interested in looking into coding this
change to git-svn, but I would like to hear some feedback first.

If you understand what I'm saying, feel free to stop now, otherwise, a
more verbose explanation follows:

Consider the following workflow:

Create a local branch tracking a SVN branch (I'll call it "master")
On that branch, git checkout -b topic;
Do some work, and git commit;
git checkout master; git merge topic;
git log --oneline --decorate --graph topic master
Note that topic and master point to the same commit (it was a fast-forward)
git svn dcommit;
git log --oneline --decorate --graph topic master

Now we see that topic and master now point to different commits. git
svn rewrote the master commits to add information about where those
commits went in SVN (their rev number, the url, etc.).

I'm proposing that both master and topic should now be pointing to A'.
This would allow numerous things to happen automatically that are
pleasing, for instance:  git branch -d topic; should succeed rather
than warn about unmerged changes.

Thanks for listening; I look forward to hearing your thoughts.

In Christ,
Aaron Laws
