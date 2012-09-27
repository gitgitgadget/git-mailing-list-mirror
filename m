From: Yann Dirson <ydirson@free.fr>
Subject: [BUG] misplaced space in word diff
Date: Thu, 27 Sep 2012 20:15:58 +0200
Message-ID: <20120927181558.GC6493@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 20:16:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THIdp-0003ne-Kb
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 20:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab2I0SQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 14:16:44 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:51633 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868Ab2I0SQn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 14:16:43 -0400
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id C5A5BCA8DB1
	for <git@vger.kernel.org>; Thu, 27 Sep 2012 20:16:37 +0200 (CEST)
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id BCB26D48132
	for <git@vger.kernel.org>; Thu, 27 Sep 2012 20:15:59 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.80)
	(envelope-from <ydirson@free.fr>)
	id 1THIcw-0007qx-8S
	for git@vger.kernel.org; Thu, 27 Sep 2012 20:15:58 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206501>

Here is a quick test case for a word-diff error, using v1.7.10.4
(debian wheezy package).

 Setting up:

tmp$ mkdir foo && cd foo
foo$ git init
Initialized empty Git repository in /tmp/foo/.git/
foo (master)$ echo '*.py    diff=python' > .gitattributes
foo (master)$ echo 'for name in bar.blurb:' > v1.py
foo (master)$ echo 'for name in foo.bar.blurb:' > v2.py

 This looks fine:

foo (master)$ git diff --no-index --word-diff=plain v1.py v2.py
diff --git a/v1.py b/v2.py
index a6a079d..2832331 100644
--- a/v1.py
+++ b/v2.py
@@ -1 +1 @@
for name in {+foo.+}bar.blurb:

 This however is not:

foo (master)$ git diff --no-index --word-diff=plain v2.py v1.py
diff --git a/v2.py b/v1.py
index 2832331..a6a079d 100644
--- a/v2.py
+++ b/v1.py
@@ -1 +1 @@
for name in[-foo.-] bar.blurb:
