From: Andrew Morton <akpm@osdl.org>
Subject: git-bisect failure
Date: Fri, 9 Sep 2005 01:10:34 -0700
Message-ID: <20050909011034.12f2bf64.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 09 10:12:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDdyS-0001IH-3W
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 10:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVIIIK7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 04:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbVIIIK7
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 04:10:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20948 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964945AbVIIIK6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2005 04:10:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j898AvBo025058
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Fri, 9 Sep 2005 01:10:58 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j898AvhP003128
	for <git@vger.kernel.org>; Fri, 9 Sep 2005 01:10:57 -0700
To: git@vger.kernel.org
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8234>


Using git-core-0.99.6 I tried to locate a bug using git's bisection
searching.

It gave the wrong answer.   It ended up claiming the bug was in


tree ea7b1763aa0e0d36b52fa245449c79338fe735b3
parent e9f86e351fda5b3c40192fc3990453613f160779
author Zachary Amsden <zach@vmware.com> Sun, 04 Sep 2005 05:56:47 -0700
committer Linus Torvalds <torvalds@evo.osdl.org> Mon, 05 Sep 2005 14:06:13 -0700

[PATCH] x86: introduce a write acessor for updating the current LDT



Whereas the bug was really in


tree 090c471fdb44d8fe88c52e95be0e8e43e31fcd5a
parent d7271b14b2e9e5905aba0fbf5c4dc4f8980c0cb2
author Zwane Mwaikambo <zwane@arm.linux.org.uk> Sun, 04 Sep 2005 05:56:51 -0700
committer Linus Torvalds <torvalds@evo.osdl.org> Mon, 05 Sep 2005 14:06:13 -0700

[PATCH] i386 boottime for_each_cpu broken


Which is off-by-two, iirc.


Exact sequence:

bix:/usr/src/git26> git bisect start
bix:/usr/src/git26> git bisect good 02b3e4e2d71b6058ec11cc01c72ac651eb3ded2b
bix:/usr/src/git26> git bisect bad 4e1491847ef5ca1c5a661601d5f96dcb7d90d2f0
Bisecting:     901 revisions left to test after this
bix:/usr/src/git26> git bisect good
Bisecting:     451 revisions left to test after this
bix:/usr/src/git26> git bisect bad 
Bisecting:     219 revisions left to test after this
bix:/usr/src/git26> git bisect bad
Bisecting:     110 revisions left to test after this
bix:/usr/src/git26> git bisect bad
Bisecting:      55 revisions left to test after this
bix:/usr/src/git26> git bisect bad
Bisecting:      28 revisions left to test after this
bix:/usr/src/git26> git bisect good
Bisecting:      14 revisions left to test after this
bix:/usr/src/git26> git bisect good
Bisecting:       7 revisions left to test after this
bix:/usr/src/git26> git bisect good
Bisecting:       3 revisions left to test after this
bix:/usr/src/git26> git bisect bad 
Bisecting:       2 revisions left to test after this
bix:/usr/src/git26> git bisect good
f2f30ebca6c0c95e987cb9a1fd1495770a75432e is first bad commit
diff-tree f2f30ebca6c0c95e987cb9a1fd1495770a75432e (from e9f86e351fda5b3c40192fc3990453613f160779)
Author: Zachary Amsden <zach@vmware.com>
Date:   Sat Sep 3 15:56:47 2005 -0700

    [PATCH] x86: introduce a write acessor for updating the current LDT
    


I don't think I screwed anything up.
