From: Johan Herland <johan@herland.net>
Subject: [PATCH] Add testcase for 'git cvsexportcommit -w $cvsdir ...' with
 relative $GIT_DIR
Date: Wed, 13 Feb 2008 04:11:22 +0100
Message-ID: <200802130411.22093.johan@herland.net>
References: <200802110228.05233.johan@herland.net>
 <200802120043.41610.johan@herland.net>
 <200802122141.35594.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 04:13:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP83V-0004tp-2q
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 04:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbYBMDMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 22:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbYBMDMa
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 22:12:30 -0500
Received: from smtp.getmail.no ([84.208.20.33]:36106 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926AbYBMDM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 22:12:29 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JW500A03Q8SZV00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 13 Feb 2008 04:12:28 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JW5006IEQ6YA320@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 13 Feb 2008 04:11:22 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JW500H5GQ6Y5NE0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 13 Feb 2008 04:11:22 +0100 (CET)
In-reply-to: <200802122141.35594.robin.rosenberg.lists@dewire.com>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73739>

The testcase verifies that 'git cvsexportcommit' functions correctly when
the '-w' option is used, and GIT_DIR is set to a relative path (e.g. '.').

Signed-off-by: Johan Herland <johan@herland.net>
---

On Tuesday 12 February 2008, Robin Rosenberg wrote:
> Looks ok. Something for the test suite?

Like this?


Have fun! :)

...Johan


 t/t9200-git-cvsexportcommit.sh |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index a15222c..5dae88c 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -2,7 +2,7 @@
 #
 # Copyright (c) Robin Rosenberg
 #
-test_description='CVS export comit. '
+test_description='Test export of commits to CVS'
 
 . ./test-lib.sh
 
@@ -246,4 +246,20 @@ test_expect_success \
 	;;
 esac
 
+test_expect_success \
+     '-w option should work with relative GIT_DIR' \
+     'mkdir W &&
+      echo foobar >W/file1.txt &&
+      echo bazzle >W/file2.txt &&
+      git add W/file1.txt &&
+      git add W/file2.txt &&
+      git commit -m "More updates" &&
+      id=$(git rev-list --max-count=1 HEAD) &&
+      (cd "$GIT_DIR" &&
+      GIT_DIR=. git cvsexportcommit -w "$CVSWORK" -c $id &&
+      check_entries "$CVSWORK/W" "file1.txt/1.1/|file2.txt/1.1/" &&
+      diff -u "$CVSWORK/W/file1.txt" ../W/file1.txt &&
+      diff -u "$CVSWORK/W/file2.txt" ../W/file2.txt
+      )'
+
 test_done
-- 
1.5.4.2.g41ac4
