From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3 5/6] grep: Add basic tests
Date: Mon,  9 May 2011 23:52:07 +0200
Message-ID: <1304977928-7142-6-git-send-email-michal.kiedrowicz@gmail.com>
References: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 23:53:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYO8-0000Ry-Eb
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 23:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab1EIVwu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 17:52:50 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:50230 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab1EIVwr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 17:52:47 -0400
Received: by wwk4 with SMTP id 4so2807024wwk.1
        for <git@vger.kernel.org>; Mon, 09 May 2011 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=SgIKkvztRTun25522c0ENNYibnkS/ia7cBtttIJJ9NY=;
        b=QIMePBRhr1eIiQrA+w1ESM+9IkFS6etrjHcoIQ81I+IH/qhYVZwkFDkt5K/pjcxqhI
         v9Op/UNRWqr935BAV6qRmaT/4A4ZpKALjA9QojS+yhLcc4Oh8hn/KRrvd/WbV6QyQFCW
         qCdEDg8WN7RsTKF23xHAtRLL4OqpTLmurK/9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=N3kH80MuaJ1jmnIKlrwijsypvFvcuHiGcTCOGxN3tLITXhrTXiIUTrjQ4rEw/GDj8C
         fWtOaRNj/rQynrFMxnGn98Fz8oBd7l69B0z0TiFIB73w1CSUK+q83RW+gQMmYKkjEN5w
         C0qiUcbk1a/ZFQUtQdDwmowgELjVYEtnwv6Ys=
Received: by 10.227.128.141 with SMTP id k13mr7705950wbs.81.1304977966118;
        Mon, 09 May 2011 14:52:46 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id bd8sm4020424wbb.14.2011.05.09.14.52.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 14:52:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173260>

This modest patch adds simple tests for git grep -P/--perl-regexp and
its interoperation with -i and -w.

Tests are only enabled when prerequisite LIBPCRE is defined (it's
automatically set based on USE_LIBPCRE in test-lib.sh).

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 t/README        |    5 +++++
 t/t7810-grep.sh |   38 ++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh   |    1 +
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 428ee05..238729c 100644
--- a/t/README
+++ b/t/README
@@ -587,6 +587,11 @@ use these, and "test_set_prereq" for how to define=
 your own.
    Test is not run by root user, and an attempt to write to an
    unwritable file is expected to fail correctly.
=20
+ - LIBPCRE
+
+   Git was compiled with USE_LIBPCRE=3DYesPlease. Wrap any tests
+   that use git-grep --perl-regexp or git-grep -P in these.
+
 Tips for Writing Tests
 ----------------------
=20
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 8184c26..e845218 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -26,6 +26,12 @@ test_expect_success setup '
 		echo foo mmap bar_mmap
 		echo foo_mmap bar mmap baz
 	} >file &&
+	{
+		echo Hello world
+		echo HeLLo world
+		echo Hello_world
+		echo HeLLo_world
+	} >hello_world &&
 	echo vvv >v &&
 	echo ww w >w &&
 	echo x x xx x >x &&
@@ -599,4 +605,36 @@ test_expect_success 'grep -e -- -- path' '
 	test_cmp expected actual
 '
=20
+cat >expected <<EOF
+hello.c:int main(int argc, const char **argv)
+hello.c:	printf("Hello world.\n");
+EOF
+
+test_expect_success LIBPCRE 'grep --perl-regexp pattern' '
+	git grep --perl-regexp "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success LIBPCRE 'grep -P pattern' '
+	git grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success LIBPCRE 'grep -P -i pattern' '
+	{
+		echo "hello.c:	printf(\"Hello world.\n\");"
+	} >expected &&
+	git grep -P -i "PRINTF\([^\d]+\)" hello.c >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success LIBPCRE 'grep -P -w pattern' '
+	{
+		echo "hello_world:Hello world"
+		echo "hello_world:HeLLo world"
+	} >expected &&
+	git grep -P -w "He((?i)ll)o" hello_world >actual &&
+	test_cmp expected actual
+'
+
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c5b18e2..368f7ae 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1069,6 +1069,7 @@ esac
=20
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
+test -n "$USE_LIBPCRE" && test_set_prereq LIBPCRE
=20
 # Can we rely on git's output in the C locale?
 if test -n "$GETTEXT_POISON"
--=20
1.7.3.4
