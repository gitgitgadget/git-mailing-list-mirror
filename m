From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t5537: move http tests out to t5539
Date: Thu, 13 Feb 2014 20:21:14 +0700
Message-ID: <1392297674-4291-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8Do0CRhhC+YvXSmihczOMDT9UpA4a4mEQ1z5MbR3TSXRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 13 14:21:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDwEG-0002xF-DE
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 14:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbaBMNVU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Feb 2014 08:21:20 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56065 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbaBMNVT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 08:21:19 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so10809702pad.0
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 05:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eha8cHjr2TbWflfYLSau1kKPN4eQ8ChDucPKwy60NGI=;
        b=pRTw6JdXStUt8nc1bd6PUgwVAeD3eH7wqBLMC5horC0bpkCwCMnYX3jqZ0OZMhMTg/
         1u3U6JzJPEqxAVfrws4YqoFXtauiGpdV/PpidI0sKA/cwJ05JlYg8JhC6PXZnJfXjNIV
         kVamVvUbUUqVrnWXvScQRerGfokd877J0daRfsPd+ub+CzVq9zUTV3wBUnhNb5YfKPKC
         DWLQUsIHmflpeivaPUWGn2FRLZHxWJnX4bgly+7KfldaDS+XgxwHKqoj53vQ+PFpCReK
         zveU7zj/NMhwNm7wmmbc1Yv+wPm/hzJV8Zx9/nlFFsmN9ozRqhHP+rjpdFHSJZV620a7
         KfeA==
X-Received: by 10.69.1.2 with SMTP id bc2mr1753184pbd.102.1392297678519;
        Thu, 13 Feb 2014 05:21:18 -0800 (PST)
Received: from lanh ([115.73.215.60])
        by mx.google.com with ESMTPSA id pp5sm6514825pbb.33.2014.02.13.05.21.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Feb 2014 05:21:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 13 Feb 2014 20:21:24 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <CACsJy8Do0CRhhC+YvXSmihczOMDT9UpA4a4mEQ1z5MbR3TSXRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242060>

start_httpd is supposed to be at the beginning of the test file, not
the middle of it. The "test_seq" line in "no shallow lines.." test is
updated to compensate missing refs that are there in t5537, but not in
the new t5539.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Thu, Feb 13, 2014 at 8:22 AM, Duy Nguyen <pclouds@gmail.com> wrote:
 > On Thu, Feb 13, 2014 at 5:12 AM, Jeff King <peff@peff.net> wrote:
 >> lib-httpd was never designed to be included from anywhere except th=
e
 >> beginning of the file. But that wouldn't be right for t5537, becaus=
e it
 >> wants to run some of the tests, even if apache setup fails. The rig=
ht
 >> way to do it is probably to have lib-httpd do all of its work in a =
lazy
 >> prereq. I don't know how clunky that will end up, though; it might =
be
 >> simpler to just move the shallow http test into one of the http-fet=
ch
 >> scripts.
 >
 > I'll move it out later.
=20
 Here it is, on top of nd/http-fetch-shallow-fix because the new test
 in t5537 is picky and a simple merge resolution wouldn't do it.

 t/t5537-fetch-shallow.sh               | 57 -----------------------
 t/t5539-fetch-http-shallow.sh (new +x) | 82 ++++++++++++++++++++++++++=
++++++++
 2 files changed, 82 insertions(+), 57 deletions(-)

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 098f220..3ae9092 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -173,61 +173,4 @@ EOF
 	)
 '
=20
-if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
-	say 'skipping remaining tests, git built without http support'
-	test_done
-fi
-
-. "$TEST_DIRECTORY"/lib-httpd.sh
-start_httpd
-
-test_expect_success 'clone http repository' '
-	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.g=
it" &&
-	git clone $HTTPD_URL/smart/repo.git clone &&
-	(
-	cd clone &&
-	git fsck &&
-	git log --format=3D%s origin/master >actual &&
-	cat <<EOF >expect &&
-7
-6
-5
-4
-3
-EOF
-	test_cmp expect actual
-	)
-'
-
-# This test is tricky. We need large enough "have"s that fetch-pack
-# will put pkt-flush in between. Then we need a "have" the server
-# does not have, it'll send "ACK %s ready"
-test_expect_success 'no shallow lines after receiving ACK ready' '
-	(
-		cd shallow &&
-		for i in $(test_seq 10)
-		do
-			git checkout --orphan unrelated$i &&
-			test_commit unrelated$i &&
-			git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
-				refs/heads/unrelated$i:refs/heads/unrelated$i &&
-			git push -q ../clone/.git \
-				refs/heads/unrelated$i:refs/heads/unrelated$i ||
-			exit 1
-		done &&
-		git checkout master &&
-		test_commit new &&
-		git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
-	) &&
-	(
-		cd clone &&
-		git checkout --orphan newnew &&
-		test_commit new-too &&
-		GIT_TRACE_PACKET=3D"$TRASH_DIRECTORY/trace" git fetch --depth=3D2 &&
-		grep "fetch-pack< ACK .* ready" ../trace &&
-		! grep "fetch-pack> done" ../trace
-	)
-'
-
-stop_httpd
 test_done
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow=
=2Esh
new file mode 100755
index 0000000..94553e1
--- /dev/null
+++ b/t/t5539-fetch-http-shallow.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description=3D'fetch/clone from a shallow clone over http'
+
+. ./test-lib.sh
+
+if test -n "$NO_CURL"; then
+	skip_all=3D'skipping test, git built without http support'
+	test_done
+fi
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+commit() {
+	echo "$1" >tracked &&
+	git add tracked &&
+	git commit -m "$1"
+}
+
+test_expect_success 'setup shallow clone' '
+	commit 1 &&
+	commit 2 &&
+	commit 3 &&
+	commit 4 &&
+	commit 5 &&
+	commit 6 &&
+	commit 7 &&
+	git clone --no-local --depth=3D5 .git shallow &&
+	git config --global transfer.fsckObjects true
+'
+
+test_expect_success 'clone http repository' '
+	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.g=
it" &&
+	git clone $HTTPD_URL/smart/repo.git clone &&
+	(
+	cd clone &&
+	git fsck &&
+	git log --format=3D%s origin/master >actual &&
+	cat <<EOF >expect &&
+7
+6
+5
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
+# This test is tricky. We need large enough "have"s that fetch-pack
+# will put pkt-flush in between. Then we need a "have" the server
+# does not have, it'll send "ACK %s ready"
+test_expect_success 'no shallow lines after receiving ACK ready' '
+	(
+		cd shallow &&
+		for i in $(test_seq 15)
+		do
+			git checkout --orphan unrelated$i &&
+			test_commit unrelated$i &&
+			git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+				refs/heads/unrelated$i:refs/heads/unrelated$i &&
+			git push -q ../clone/.git \
+				refs/heads/unrelated$i:refs/heads/unrelated$i ||
+			exit 1
+		done &&
+		git checkout master &&
+		test_commit new &&
+		git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
+	) &&
+	(
+		cd clone &&
+		git checkout --orphan newnew &&
+		test_commit new-too &&
+		GIT_TRACE_PACKET=3D"$TRASH_DIRECTORY/trace" git fetch --depth=3D2 &&
+		grep "fetch-pack< ACK .* ready" ../trace &&
+		! grep "fetch-pack> done" ../trace
+	)
+'
+
+stop_httpd
+test_done
--=20
1.8.5.2.240.g8478abd
