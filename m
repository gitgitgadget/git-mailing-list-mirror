From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH] Don't print unnecessary backtraces when testing
Date: Fri, 17 Aug 2007 13:36:51 +0200
Message-ID: <87sl6ipf3g.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 13:50:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM0Lp-0008L4-80
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 13:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759870AbXHQLuk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 17 Aug 2007 07:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755823AbXHQLuj
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 07:50:39 -0400
Received: from main.gmane.org ([80.91.229.2]:51810 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759714AbXHQLuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 07:50:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IM0Gg-0001HO-Sz
	for git@vger.kernel.org; Fri, 17 Aug 2007 13:45:30 +0200
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 13:45:30 +0200
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 13:45:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:CtKGgTI6zaGgQs+QfDXRmz36qEY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56060>

When stg fails, and handles it properly, no backtrace should be printed=
,
even when running tests with -v.  Getting a backtrace in the output sig=
nals
some kind of bug, but in this case there is no bug.
---

I was running tests with -v and saw python backtraces, and assumed
that there was a bug somewhere.  But apparently this backtrace only
appeared when running tests.

I think it's better if you only get backtraces when something actually
went wrong.  The test driver sets the debug level to -1, so I changed
the check to check for positive instead.

 stgit/main.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/main.py b/stgit/main.py
index 294b703..2390110 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -286,7 +286,7 @@ def main():
             StackException, GitException, GitMergeException,
             EditorException), err:
         print >> sys.stderr, '%s %s: %s' % (prog, cmd, err)
-        if debug_level:
+        if debug_level > 0:
             raise
         else:
             sys.exit(2)
--=20
1.5.3.rc3.119.g1812


--=20
David K=C3=A5gedal
