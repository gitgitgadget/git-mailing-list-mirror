From: "David S. Miller" <davem@davemloft.net>
Subject: t6021-merge-criss-cross.sh fails on some systems
Date: Sat, 10 Dec 2005 14:42:35 -0800 (PST)
Message-ID: <20051210.144235.125914760.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Dec 10 23:42:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElDQ1-0000qM-PR
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 23:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVLJWmM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 17:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVLJWmM
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 17:42:12 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9389
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750951AbVLJWmK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2005 17:42:10 -0500
Received: from localhost.localdomain
	([127.0.0.1] helo=localhost ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.54)
	id 1ElDQK-00055x-GG
	for git@vger.kernel.org; Sat, 10 Dec 2005 14:42:36 -0800
To: git@vger.kernel.org
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13475>


This is really weird, so I started to try and get some diagnostics.

It doesn't fail on my sparc64 box running debian-testing
but it does fail on my Ubuntu x86 laptop, a sparc64 box
running debian-unstable, and an Ubuntu sparc64 system as
well.

This is with the current GIT tree.

I ran the test one step at a time to try and get some diagnostics,
here's what fails:

davem@nuts:~/src/GIT/test$ git merge "pre E3 merge" B A
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging B with A
Merging:
1f14398f4c69d09ab1a4d53fe096ddec3ea45207 C3
d1072ae2682fad309c493343c5d77c9897fb6afa B8
found 1 common ancestor(s):
926159b75e3d9b240b1eae36eb1977b095ff2e1a Initial commit
Auto-merging file
Traceback (most recent call last):
  File "/home/davem/bin/git-merge-recursive", line 868, in ?
    firstBranch, secondBranch, graph)
  File "/home/davem/bin/git-merge-recursive", line 87, in merge
    branch1Name, branch2Name)
  File "/home/davem/bin/git-merge-recursive", line 160, in mergeTrees
    if not processEntry(entry, branch1Name, branch2Name):
  File "/home/davem/bin/git-merge-recursive", line 821, in processEntry
    branch1Name, branch2Name)
  File "/home/davem/bin/git-merge-recursive", line 212, in mergeFile
    src1, orig, src2], returnCode=True)
  File "/home/davem/share/git-core/python/gitMergeCommon.py", line 72, in runProgram
    raise ProgramError(progStr, e.strerror)
ProgramError: merge -L B/file -L orig/file -L A/file .merge_file_kDtaE3 .merge_file_K30Hgp .merge_file_frqYIs: No such file or directory
No merge strategy handled the merge.
davem@nuts:~/src/GIT/test$ ls

It looks like maybe some quoting issue?  The call failing above is the
one in git-merge-recursive which looks like this:

    [dummy, clean] = merge(graph.shaMap[h1], graph.shaMap[h2],
                           firstBranch, secondBranch, graph)

Any ideas?
