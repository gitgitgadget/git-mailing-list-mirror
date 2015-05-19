From: Philippe De Muyter <phdm@macq.eu>
Subject: identical hashes on two branches, but holes in git log
Date: Tue, 19 May 2015 15:29:58 +0200
Message-ID: <20150519132958.GA21130@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 15:38:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuhiq-0007ek-Os
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 15:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbbESNhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 09:37:45 -0400
Received: from smtp2.macqel.be ([109.135.2.61]:53718 "EHLO smtp2.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932154AbbESNhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 09:37:43 -0400
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 May 2015 09:37:43 EDT
Received: from localhost (localhost [127.0.0.1])
	by smtp2.macqel.be (Postfix) with ESMTP id 8C9FA130D26
	for <git@vger.kernel.org>; Tue, 19 May 2015 15:30:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9qSAztgZFVYS for <git@vger.kernel.org>;
	Tue, 19 May 2015 15:29:58 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by smtp2.macqel.be (Postfix) with ESMTP id E799A130CF7
	for <git@vger.kernel.org>; Tue, 19 May 2015 15:29:58 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id CB0EADF06BC; Tue, 19 May 2015 15:29:58 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269355>

Hello,

I work on the linux kernel sources (with origin = linux-stable) and I
have my local branch (the one with my local patches) supposedly based
on v3.14.  But actually if I invoke "git diff v3.14", I get much more
diffs than my own patches.

Trying to understand, I have eventually done "git log" on my branch and
on v3.15 with the following commands :

git log v3.15 --full-history --decorate=short | grep '^commit' > /tmp/3.15.commits
git log --full-history --decorate=short | grep '^commit' > /tmp/mybranch.commits

I compare then the two histories with

diff -u /tmp/3.15.commits /tmp/mybranch.commits

and I get (excerpt) :

--- /tmp/3.15.commits      2015-05-19 13:19:59.665205514 +0200
+++ /tmp/mybranch.commits     2015-05-19 13:19:52.452081328 +0200
@@ -1,3780 +1,84 @@
-commit 1860e379875dfe7271c649058aeddffe5afd9d0d (tag: v3.15)
-commit ...
...
-commit fad01e866afdbe01a1f3ec06a39c3a8b9e197014 (tag: v3.15-rc8)
...
...
-commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5 (tag: v3.15-rc1)
...
-commit 57673c2b0baa900dddae3b9eb3d7748ebf550eb3
+commit a1fb433346cb5733945b5fc243f7334744bae4fd (HEAD, macq_boards-3.14.0)
+commit ...
...
+commit 2be7b20bbb337e0031e0f0d39c9a4845b6bbf3b8
 commit 455c6fdbd219161bd09b1165f11699d6d73de11c (tag: v3.14)	==== identical commit
-commit c32fc9c803f8ed90a7548810de48ca33a3020168		==== commit missing in my branch
 commit fedc1ed0f11be666de066b0c78443254736a942e		==== more identical commits
 commit 01358e562a8b97f50ec04025c009c71508e6d373
 commit 915ac4e26ef9c39a0f831e935509243732abedc0
@@ -3784,4289 +88,252 @@
 commit 0b1b901b5a98bb36943d10820efc796f7cd45ff3
 commit 1d6a32acd70ab18499829c0a9a5dbe2bace72a13
 commit 0818bf27c05b2de56c5b2bd08cfae2a939bd5f52
-commit 877e1f1529a5c4fcc8460c1317c753ff8a6874c5		==== more missing commits
-commit 57918dfadf717acf7d0488d5970c56a282d0aad1
-commit 86ea5e6b793d45fa7d2aa504ac3aefc813f0fd55
-commit a5dde0c72ccbb0f66b3491ee83f4c579aea0651d
-commit c7f6ee264b511d8a35063e9821cf36ad18e4e4fd
...
-commit c99abc8b39d8281dad04d771bb7a2de36fec4d9f
 commit b098d6726bbfb94c06d6e1097466187afddae61f (tag: v3.14-rc8) ==== more identical commits
 commit 822316461b15e0207e50ff661f9cf830af116e9f
 commit 56f1f4b24e8787d7ba794dbe2e949d504c054892
...

How is that possible (to have the same commit, with the same hash but
different ancestors), and how can I recover from that situation ?

I really would like to rebase my branch on v3.14, but it says it is already !

I have also done a 'git fsck'.  It has shown only 

Checking object directories: 100% (256/256), done.                                                                                         
Checking objects: 100% (4566799/4566799), done.                                                                                            
Checking connectivity: 4494119, done
dangling tree ...
dangling commit ...
dangling blob ...

This is with git version 1.7.10.4

TIA

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
