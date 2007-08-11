From: "Wincent Colaiuta" <win@wincent.com>
Subject: --exit-code (and --quiet) broken in git-diff?
Date: Sat, 11 Aug 2007 18:12:40 -0500 (CDT)
Message-ID: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 12 01:12:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK08T-0001uq-8I
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 01:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076AbXHKXMl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 19:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754987AbXHKXMl
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 19:12:41 -0400
Received: from wincent.com ([72.3.236.74]:57497 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304AbXHKXMk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 19:12:40 -0400
Received: from s69819.wincent.com (localhost [127.0.0.1])
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l7BNCehd017617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 11 Aug 2007 18:12:40 -0500
Received: (from apache@localhost)
	by s69819.wincent.com (8.12.11.20060308/8.12.11/Submit) id l7BNCe6Q017615;
	Sat, 11 Aug 2007 18:12:40 -0500
Received: from 88.10.191.55
        (SquirrelMail authenticated user win%wincent.org)
        by secure.wincent.com with HTTP;
        Sat, 11 Aug 2007 18:12:40 -0500 (CDT)
User-Agent: SquirrelMail/1.4.8-6.el3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55646>

The git-diff man page documents an "--exit-code" option, as well as a
"--quiet" option which automatically implies the former.

In my tests on Mac OS X and Bash 3, however, "git diff" always return an
exit code of 0, never of 1, regardless of how I use the "--quiet" and
"--exit-code" options. I see that there are tests in t/t4017-quiet.sh for
the lower-level git-diff-files, git-diff-index, git-diff-tree commands,
but none for the porcelain git-diff.

Is this a bug with a missing test case? Or am I using this incorrectly? In
the example below I'm looking for differences between the working tree and
the last commit, so I'm using "git diff HEAD", but as you can see, the
exit code is always 0 for "git diff" and "git diff --cached" as well:

$ git --version
git version 1.5.2.4
$ mkdir example
$ cd example
$ git init
Initialized empty Git repository in .git/
$ echo "start" > foo
$ git add foo
$ git commit -m "Add foo"
Created initial commit 85954f6: Add foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo
$ git diff --quiet HEAD; echo $?
0
$ echo "more" >> foo
$ git diff --quiet HEAD; echo $?
0
$ git add foo
$ git diff --quiet HEAD; echo $?
0
$ git diff --quiet; echo $?
0
$ git diff --exit-code; echo $?
0
$ git diff --cached --quiet; echo $?
0

Cheers,
Wincent
