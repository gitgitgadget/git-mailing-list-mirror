From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH/RFC 2/2] git-p4: Add complex test case for branch import
Date: Sat, 20 Aug 2011 15:12:03 -0400
Message-ID: <20110820191203.GC7135@arf.padd.com>
References: <1313712590-26876-1-git-send-email-vitor.hda@gmail.com>
 <1313712590-26876-3-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 21:12:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Quqxq-000201-BO
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 21:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842Ab1HTTMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 15:12:10 -0400
Received: from honk.padd.com ([74.3.171.149]:38358 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754532Ab1HTTMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 15:12:08 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id C98E52C27;
	Sat, 20 Aug 2011 12:12:07 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 038FA31447; Sat, 20 Aug 2011 15:12:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1313712590-26876-3-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179778>

vitor.hda@gmail.com wrote on Fri, 19 Aug 2011 01:09 +0100:
> Check if branches created from old changelists are correctly imported.
> 
> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>

Style edits.

		-- Pete



---------------8<-------------------

>From 5d1103a97b60570423782fd3873a2b413ddb1d5b Mon Sep 17 00:00:00 2001
From: Pete Wyckoff <pw@padd.com>
Date: Sat, 20 Aug 2011 14:31:49 -0400
Subject: [PATCH 3/4] git-p4: complex branch test edits

A few simplifications and style edits here too.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4.sh |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 5bcb8b4..cf3a70e 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -489,11 +489,11 @@ test_expect_success 'git-p4 clone simple branches' '
 #   `- file3
 test_expect_success 'add p4 complex branches' '
 	cd "$cli" &&
-	changelist=$(p4 changes -m1 //depot/... | cut -d \  -f 2) &&
-	changelist=$(($changelist - 5)) &&
+	changelist=$(p4 changes -m1 //depot/... | cut -d" " -f2) &&
+	changelist=$((changelist - 5)) &&
 	p4 integrate //depot/branch1/...@$changelist //depot/branch4/... &&
 	p4 submit -d "branch4" &&
-	changelist=$(($changelist + 2)) &&
+	changelist=$((changelist + 2)) &&
 	p4 integrate //depot/branch1/...@$changelist //depot/branch5/... &&
 	p4 submit -d "branch5" &&
 	cd "$TRASH_DIRECTORY"
@@ -503,15 +503,14 @@ test_expect_success 'add p4 complex branches' '
 # to clone the original structure if it is able to detect the origin changelist
 # of each branch.
 test_expect_success 'git-p4 clone complex branches' '
-	git init "$git" &&
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
 	cd "$git" &&
 	git config git-p4.branchList branch1:branch2 &&
 	git config --add git-p4.branchList branch1:branch3 &&
 	git config --add git-p4.branchList branch1:branch4 &&
 	git config --add git-p4.branchList branch1:branch5 &&
-	cd "$TRASH_DIRECTORY" &&
-	"$GITP4" clone --dest="$git" --detect-branches //depot@all &&
-	cd "$git" &&
+	"$GITP4" clone --dest=. --detect-branches //depot@all &&
 	git log --all --graph --decorate --stat &&
 	git reset --hard p4/depot/branch1 &&
 	test -f file1 &&
@@ -521,7 +520,7 @@ test_expect_success 'git-p4 clone complex branches' '
 	git reset --hard p4/depot/branch2 &&
 	test -f file1 &&
 	test -f file2 &&
-	test \! -f file3 &&
+	test ! -f file3 &&
 	! grep -q update file2 &&
 	git reset --hard p4/depot/branch3 &&
 	test -f file1 &&
@@ -531,15 +530,13 @@ test_expect_success 'git-p4 clone complex branches' '
 	git reset --hard p4/depot/branch4 &&
 	test -f file1 &&
 	test -f file2 &&
-	test \! -f file3 &&
+	test ! -f file3 &&
 	! grep -q update file2 &&
 	git reset --hard p4/depot/branch5 &&
 	test -f file1 &&
 	test -f file2 &&
 	test -f file3 &&
-	! grep -q update file2 &&
-	cd "$TRASH_DIRECTORY" &&
-	rm -rf "$git" && mkdir "$git"
+	! grep -q update file2
 '
 
 test_expect_success 'shutdown' '
-- 
1.7.5.4
