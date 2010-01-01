From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 8/6] t4030, t4031: work around bogus MSYS bash path conversion
Date: Fri, 01 Jan 2010 23:15:18 +0100
Message-ID: <4B3E73F6.3040402@kdbg.org>
References: <20091230095634.GA16349@coredump.intra.peff.net> <20091230110335.GF22959@coredump.intra.peff.net> <4B3E73AE.6050003@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 01 23:17:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQpoK-0000lJ-Kg
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 23:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149Ab0AAWRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 17:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038Ab0AAWRX
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 17:17:23 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:53117 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751949Ab0AAWRV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 17:17:21 -0500
Received: from [77.117.209.219] (77.117.209.219.wireless.dyn.drei.com [77.117.209.219])
	by bsmtp.bon.at (Postfix) with ESMTP id 39AA610014;
	Fri,  1 Jan 2010 23:17:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B3E73AE.6050003@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136013>

Recall that MSYS bash converts POSIX style absolute paths to Windows style
absolute paths. Unfortunately, it converts a program argument that begins
with a double-quote and otherwise looks like an absolute POSIX path, but
in doing so, it strips everything past the second double-quote[*]. This
case is triggered in the two test scripts. The work-around is to place the
Windows style path between the quotes to avoid the path conversion.

[*] It is already bogus that a conversion is even considered when a program
argument begins with a double-quote because it cannot be an absolute POSIX
path.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  t/t4030-diff-textconv.sh       |    2 +-
  t/t4031-diff-rewrite-binary.sh |    2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 3cb7e63..9b94647 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -50,7 +50,7 @@ test_expect_success 'file is considered binary by plumbing' '

  test_expect_success 'setup textconv filters' '
  	echo file diff=foo >.gitattributes &&
-	git config diff.foo.textconv "\"$PWD\""/hexdump &&
+	git config diff.foo.textconv "\"$(pwd)\""/hexdump &&
  	git config diff.fail.textconv false
  '

diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index 27fb31b..7e7b307 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -54,7 +54,7 @@ chmod +x dump

  test_expect_success 'setup textconv' '
  	echo file diff=foo >.gitattributes &&
-	git config diff.foo.textconv "\"$PWD\""/dump
+	git config diff.foo.textconv "\"$(pwd)\""/dump
  '

  test_expect_success 'rewrite diff respects textconv' '
-- 
1.6.6.1073.gd853b.dirty
