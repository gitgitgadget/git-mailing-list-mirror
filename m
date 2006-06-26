From: fork0@t-online.de (Alex Riesen)
Subject: CFT: merge-recursive in C (test updates)
Date: Tue, 27 Jun 2006 01:42:42 +0200
Message-ID: <20060626234242.GB3121@steel.home>
References: <20060626233838.GA3121@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 01:44:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv0kf-0006nc-Uo
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 01:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933125AbWFZXnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 19:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933286AbWFZXnO
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 19:43:14 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:5795 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S933125AbWFZXm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 19:42:56 -0400
Received: from fwd34.aul.t-online.de 
	by mailout04.sul.t-online.com with smtp 
	id 1Fv0jE-0003FL-02; Tue, 27 Jun 2006 01:42:52 +0200
Received: from tigra.home (Jr8fZuZGQeN8QSwE4dVFBRw5fAFS7+n89rYPqf6nXE8klr8Bcm4IYq@[84.160.112.192]) by fwd34.sul.t-online.de
	with esmtp id 1Fv0j5-0vn1GK0; Tue, 27 Jun 2006 01:42:43 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 18DEA277B5;
	Tue, 27 Jun 2006 01:42:43 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Fv0j4-0000pS-Vw; Tue, 27 Jun 2006 01:42:43 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060626233838.GA3121@steel.home>
User-Agent: Mutt/1.5.6i
X-ID: Jr8fZuZGQeN8QSwE4dVFBRw5fAFS7+n89rYPqf6nXE8klr8Bcm4IYq
X-TOI-MSGID: d0ff024f-75a6-4da4-85cb-d49fa4ac510c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22697>

I had to change the tests a little, to avoid skipping test on systems
without python and to force t3402-rebase-merge.sh test the converted
program (this one shouldn't be merged at all of course. I think we'd
still want have git-merge-recursive.py around and test it too. It is
reference implementation, to say the least).

---

diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index d34c6cf..c13d154 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -7,12 +7,6 @@ test_description='git rebase --merge tes
 
 . ./test-lib.sh
 
-if test "$no_python"; then
-	echo "Skipping: no python => no recursive merge"
-	test_done
-	exit 0
-fi
-
 T="A quick brown fox
 jumps over the lazy dog."
 for i in 1 2 3 4 5 6 7 8 9 10
@@ -51,7 +45,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'reference merge' '
-	git merge -s recursive "reference merge" HEAD master
+	git merge -s recur "reference merge" HEAD master
 '
 
 test_expect_success rebase '
diff --git a/t/t6021-merge-criss-cross.sh b/t/t6021-merge-criss-cross.sh
index 2623813..e8606c7 100755
--- a/t/t6021-merge-criss-cross.sh
+++ b/t/t6021-merge-criss-cross.sh
@@ -10,12 +10,6 @@ # nice decription of what this is about.
 test_description='Test criss-cross merge'
 . ./test-lib.sh
 
-if test "$no_python"; then
-	echo "Skipping: no python => no recursive merge"
-	test_done
-	exit 0
-fi
-
 test_expect_success 'prepare repository' \
 'echo "1
 2
