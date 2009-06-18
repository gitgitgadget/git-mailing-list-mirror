From: Eric Raible <raible@gmail.com>
Subject: Bug: "LF will be replaced by CRLF" warning duplicated two (or three) times
Date: Thu, 18 Jun 2009 09:17:14 +0000 (UTC)
Message-ID: <loom.20090618T084545-442@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 11:17:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHDkW-00071K-5y
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 11:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252AbZFRJR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 05:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbZFRJR0
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 05:17:26 -0400
Received: from main.gmane.org ([80.91.229.2]:36384 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560AbZFRJRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 05:17:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MHDkN-0001d9-2w
	for git@vger.kernel.org; Thu, 18 Jun 2009 09:17:27 +0000
Received: from adsl-64-175-41-77.dsl.pltn13.pacbell.net ([64.175.41.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 09:17:27 +0000
Received: from raible by adsl-64-175-41-77.dsl.pltn13.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 09:17:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 64.175.41.77 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.31 Safari/530.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121822>

A single "LF will be replaced by CRLF" message is expected in certain cases.
But two warnings per file are produced with git-diff --patch-with-stat.
Posted here rather than to the msysgit list b.c. I'm guessing it's not
msysgit-specific.

$ git --version
git version 1.6.3.msysgit.0
$ mkdir auto-crlf-bug
$ cd auto-crlf-bug/
$ git init
Initialized empty Git repository in d:/auto-crlf-bug/.git/
$ git config core.autocrlf
true
$ touch file42
$ git add file42
$ git commit -m initial
[master (root-commit) 6c22784] initial
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file42
$ echo something > file42
$ git diff
diff --git a/file42 b/file42
index e69de29..deba01f 100644
--- a/file42
+++ b/file42
@@ -0,0 +1 @@
+something
warning: LF will be replaced by CRLF in file42
$ git diff --patch-with-stat
 file42 |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/file42 b/file42
index e69de29..deba01f 100644
--- a/file42
+++ b/file42
@@ -0,0 +1 @@
+something
warning: LF will be replaced by CRLF in file42
warning: LF will be replaced by CRLF in file42
$


It's even possible to trigger three identical warnings:
$ git add -p
warning: LF will be replaced by CRLF in file42
warning: LF will be replaced by CRLF in file42
warning: LF will be replaced by CRLF in file42
diff --git a/file42 b/file42
index e69de29..deba01f 100644
--- a/file42
+++ b/file42
@@ -0,0 +1 @@
+something
Stage this hunk [y,n,q,a,d,/,e,?]? q
$

This is obviously not a show-stopper, but I thought it worth reporting anyway.

- Eric
