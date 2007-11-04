From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] Add more tests for git-clean
Date: Sun,  4 Nov 2007 13:02:20 -0600
Message-ID: <11942029442710-git-send-email-shawn.bohrer@gmail.com>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com>
Cc: gitster@pobox.com, Shawn Bohrer <shawn.bohrer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 20:02:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iokk1-0002N9-9N
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 20:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbXKDTCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 14:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbXKDTCK
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 14:02:10 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:62610 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbXKDTCG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 14:02:06 -0500
Received: by an-out-0708.google.com with SMTP id b36so163247ana
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 11:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ne99q9JkGk7cRH5DdVr9kJ54UaNF4oyG7vEvuHMgzSc=;
        b=O23tPVHlh+0eU6IS1pWaxphk4TfP6UEdPCbIQc/hEIWRBvWtQtvp6UnM6Jc25hvTAejlkQ/HvFjMXMTv5Jnsw6owPNUzxXjYvu/D+RhHp8yXhPEPWsHcp4sQNcBwSndQoknbPqaK38NVVCr5V8Jj/qwG5BWQjH7qHeUuottJN48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tMSswn7nqJ2AhJNmbsA+xZIQ86j0lGD8UUaz/tgTN0k49vYHo9mExlk8LnZ8Dw2K2qap+JcPMzgh0vsVuFdqWXpNbxZNX0wp7+QvdnIvSRxpOu5CoZCRTywcNQSHK1ojyLlDjTPFq4hKYFsY8WWD3ImdC106yzLY2QJEIP/QKFw=
Received: by 10.100.239.12 with SMTP id m12mr5343961anh.1194202925624;
        Sun, 04 Nov 2007 11:02:05 -0800 (PST)
Received: from mediacenter ( [70.112.149.232])
        by mx.google.com with ESMTPS id 8sm3826298wra.2007.11.04.11.02.03
        (version=SSLv3 cipher=OTHER);
        Sun, 04 Nov 2007 11:02:04 -0800 (PST)
Received: by mediacenter (sSMTP sendmail emulation); Sun,  4 Nov 2007 13:02:24 -0600
X-Mailer: git-send-email 1.5.3.GIT
In-Reply-To: <1194202941253-git-send-email-shawn.bohrer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63428>

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 t/t7300-clean.sh |  109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 8697213..d74c11c 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -39,6 +39,97 @@ test_expect_success 'git-clean' '
 
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
+	cd src/ &&
+	git-clean &&
+	cd - &&
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
+	cd src/ &&
+	git-clean -d feature/ &&
+	cd - &&
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
@@ -73,6 +164,24 @@ test_expect_success 'git-clean -d' '
 
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
