From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: commit a63d7ed3017e312ddc752ac89a7d292a745d5f11 broken on MacOS
Date: Thu, 07 Jun 2012 13:53:50 +0200
Message-ID: <4FD0964E.7040302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 13:59:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScbMh-0001cS-VG
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 13:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746Ab2FGL6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 07:58:55 -0400
Received: from mout.web.de ([212.227.17.12]:51423 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610Ab2FGL6z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 07:58:55 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jun 2012 07:58:54 EDT
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0LuLxD-1RwUMS1Z9r-011MVY; Thu, 07 Jun 2012 13:53:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120601 Thunderbird/13.0
X-Provags-ID: V02:K0:hZC6hOPoo/SSFHEk/+BiE2yu765K84w8zod8EEQMoDg
 jHSnPXiOS9nqGu1l5hCUuEC9B9Gaz5IV8v/oDKQlZ9bhkOguYy
 O+MiOmMBEx9xqrph5LnYUVHclD/4OYvjwYJVYb9XR2pUFcjBf1
 8FZ52F3i6Nx7O1tNshV01CMjix67qwzjUZ0V8cFyjVP3KSEqm5
 MGiptTxGGK/SCziZxyEjg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199393>


commit a63d7ed3017e312ddc752ac89a7d292a745d5f11
Author: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Date:   Wed Jun 6 12:34:16 2012 +0200

    rebase [-i --exec | -ix] <cmd>...
....
    Tests about this new command are also added in t3404-rebase-interactive.sh.
....


This test doesn't pass on my Mac Os box.

I run it with --debug --verbose, and it looks like another sed problem on Mac OS, may be.
(My sed is /usr/bin, Mac OS X 10.6.8)

I haven't been able to dig very deep into this, but the line  
"sed: 1: "/^pick .*/i\t\t\t\texec  gi ...": command i expects \ followed by text"
looks suspicious.

Could the same be achieved by using tail instead of sed?
Anybody else having this problem?


====================

ok 54 - rebase-i history with funny messages

expecting success: 
	git checkout master &&
	git checkout -b execute &&
	test_commit one_exec main.txt one_exec &&
	test_commit two_exec main.txt two_exec &&
	test_commit three_exec main.txt three_exec

Switched to branch 'master'
Switched to a new branch 'execute'
[execute 925b01e] one_exec
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 main.txt
[execute 7f87cbe] two_exec
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
[execute f0f177e] three_exec
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
ok 55 - prepare for rebase -i --exec

expecting success: 
	git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
	(
		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
		export FAKE_LINES &&
		git rebase -i HEAD~2 >expected
	) &&
	sed 1,9d expected >expect &&
	mv expect expected &&
	test_cmp expected actual

sed: 1: "/^pick .*/i\t\t\t\texec  gi ...": command i expects \ followed by text
Successfully rebased and updated refs/heads/execute.
Successfully rebased and updated refs/heads/execute.
--- expected	2012-06-07 11:46:53.000000000 +0000
+++ actual	2012-06-07 11:46:52.000000000 +0000
@@ -1,18 +1,4 @@
-Rebasing (2/4)
Executing: git show HEAD
-commit 8f99a4f1fbbd214b25a070ad34ec5a8f833522cc
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:17:13 2005 -0700
-
-    E
-
-diff --git a/file3 b/file3
-new file mode 100644
-index 0000000..1c50726
---- /dev/null
-+++ b/file3
-@@ -0,0 +1 @@
-+E
-Rebasing (3/4)
Rebasing (4/4)
Executing: git show HEAD
+Rebasing (1/1)
Executing: git show HEAD
 commit 925b01e149bd188d43f972ad86d1e4d6611c8fa0
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 16:10:13 2005 -0700
not ok - 56 running "git rebase -i --exec git show HEAD"
