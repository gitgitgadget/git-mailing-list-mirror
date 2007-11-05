From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] Add more tests for git-clean
Date: Sun,  4 Nov 2007 22:28:12 -0600
Message-ID: <11942368921792-git-send-email-shawn.bohrer@gmail.com>
Cc: madcoder@debian.org, git@vger.kernel.org,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 05 05:28:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IotZK-0005DU-Qz
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 05:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbXKEE14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 23:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753196AbXKEE1z
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 23:27:55 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:9958 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbXKEE1y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 23:27:54 -0500
Received: by an-out-0708.google.com with SMTP id b36so170495ana
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 20:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7ZuGcdoTCThyOAtjiPTu8crYfnneLDT4dXCeO6u+zTk=;
        b=sZ5I9xHXReubZXkjCCUl524hCTb19hgl7YZ+9T7Uqz3c2HrY1qTzr8F0S9LBraBuH3gPZc4FEc4yNqff4exOPpnzjjOelWYHssSpr6sRuLjFUEiqke2gNH6kwNUsHeBB1U1IwEk57lk9ph89hDvS8Ls5fXxs7pYJhKXFQ0grws0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KEnUQRQ0oxo4E3/bnl/wTpyrilGlrtBsUS4xMpbCp7Ra30hf4GyyMASB3TnMfPd9Hbo7dcOp/C1nIs8mRM3uXYVJnsp+uQtva2dV6ejUUMS5LmPCZlokAkcoIFtT3Lbpm+8Y3h5/W59j0+TkxnmegWJzib9HNFLTMLyJhfefSGE=
Received: by 10.100.201.16 with SMTP id y16mr5581713anf.1194236873945;
        Sun, 04 Nov 2007 20:27:53 -0800 (PST)
Received: from mediacenter ( [70.112.149.232])
        by mx.google.com with ESMTPS id q30sm4273902wrq.2007.11.04.20.27.51
        (version=SSLv3 cipher=OTHER);
        Sun, 04 Nov 2007 20:27:52 -0800 (PST)
Received: by mediacenter (sSMTP sendmail emulation); Sun,  4 Nov 2007 22:28:12 -0600
X-Mailer: git-send-email 1.5.3.GIT
In-Reply-To: 7vr6j5r1ec.fsf@gitster.siamese.dyndns.org
References: 7vr6j5r1ec.fsf@gitster.siamese.dyndns.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63482>

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 t/t7300-clean.sh |  105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)

On Sun, Nov 04, 2007 at 04:17:47PM -0800, Junio C Hamano wrote:
>       ...
>       ( cd src && git-clean ) &&
>       ...
>
> would be the best way to write this.

Agreed here is an updated patch that does this.

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 8697213..25d3102 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -39,6 +39,93 @@ test_expect_success 'git-clean' '
 
 '
 
+test_expect_success 'git-clean src/' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	git-clean src/ &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test ! -f src/part3.c &&
+	test -f docs/manual.txt &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git-clean src/ src/' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	git-clean src/ src/ &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test ! -f src/part3.c &&
+	test -f docs/manual.txt &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git-clean with prefix' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	(cd src/ && git-clean) &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test ! -f src/part3.c &&
+	test -f docs/manual.txt &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+test_expect_success 'git-clean -d with prefix and path' '
+
+	mkdir -p build docs src/feature &&
+	touch a.out src/part3.c src/feature/file.c docs/manual.txt obj.o build/lib.so &&
+	(cd src/ && git-clean -d feature/) &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f src/part3.c &&
+	test ! -f src/feature/file.c &&
+	test -f docs/manual.txt &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git-clean symbolic link' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	ln -s docs/manual.txt src/part4.c
+	git-clean &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test ! -f src/part3.c &&
+	test ! -f src/part4.c &&
+	test -f docs/manual.txt &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
 test_expect_success 'git-clean -n' '
 
 	mkdir -p build docs &&
@@ -73,6 +160,24 @@ test_expect_success 'git-clean -d' '
 
 '
 
+test_expect_success 'git-clean -d src/ examples/' '
+
+	mkdir -p build docs examples &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so examples/1.c &&
+	git-clean -d src/ examples/ &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test ! -f src/part3.c &&
+	test ! -f examples/1.c &&
+	test -f docs/manual.txt &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
 test_expect_success 'git-clean -x' '
 
 	mkdir -p build docs &&
-- 
1.5.3.GIT
