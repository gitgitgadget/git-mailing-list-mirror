From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 11/17] gettext tests: test message re-encoding under Shell
Date: Mon, 30 Aug 2010 21:28:17 +0000
Message-ID: <1283203703-26923-12-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBvf-0000N5-Uv
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039Ab0H3V37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:29:59 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46105 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698Ab0H3V34 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:29:56 -0400
Received: by wwb28 with SMTP id 28so137203wwb.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=89KCEKpN6LABPBqLLRuZblyQ3vWu8b5AQe8CD6ChYBU=;
        b=O/L6NeY832nKvCq0ClZ9Kh0joMDWKF6j4SakQNMgVTVriAKMmOS2vsoBSNjG0iGtPm
         nnZr0CGQEjzQHWKT6pa82+ujgdJUudLAWG3xca/OUNWml2JwJ4JWs80H5AQ4Eiwr2rqY
         etc5wXo7nXN+5+tCUbGMRXqJE63K++hgxt/XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fPte+6YgwKy68odnrBkQAVXGgCBg2w9oq/8DS+wIuRox1j6Pti7Ape+WATg2NKLtQz
         6VTTo1oEbQUYWRQP9qd6cKRhrsEFP+8FXiRTtrKyXNNttgcCad/tU3+hYDGgNDGPjWVy
         Y6EWxAW+asobTAx6sdHTqY5SQs1crCO9jGvq0=
Received: by 10.227.134.210 with SMTP id k18mr5475207wbt.160.1283203747570;
        Mon, 30 Aug 2010 14:29:07 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.29.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:29:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154865>

Our PO files are written in UTF-8, but We're not using
setlocale(LC_CTYPE, "") so it's not a given that someone with e.g. a
ISO-8859-1 locale will get messages in ISO-8859-1, and not UTF-8.

Introduce a new test to test for this, it uses the recently added
GETTEXT_ISO_LOCALE prerequisite.

This patch only tests the shellscript portion of our gettext
interface. I can't get any of these tests to fail on any of the
gettext implementations I have around, even without the previous patch
to gettext.c. But having exhaustive tests in this area is good
regardless.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/is.po                           |   12 ++++++++++
 t/t0200/test.c                     |    6 +++++
 t/t0204-gettext-reencode-sanity.sh |   43 ++++++++++++++++++++++++++++=
++++++++
 3 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100755 t/t0204-gettext-reencode-sanity.sh

diff --git a/po/is.po b/po/is.po
index 2f3a220..39b63b9 100644
--- a/po/is.po
+++ b/po/is.po
@@ -25,6 +25,18 @@ msgid "TEST: A C test string %s"
 msgstr "TILRAUN: C tilraunastrengur %s"
=20
 #. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:15
+#, c-format
+msgid "TEST: Hello World!"
+msgstr "TILRAUN: Hall=C3=B3 Heimur!"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:18
+#, c-format
+msgid "TEST: Old English Runes"
+msgstr "TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=9A=A6=
 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=E1=9B=
=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=9A=E1=
=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=A6=E1=
=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=B9=E1=
=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=9A=AB=
"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
 #: t/t0200/test.sh:8
 msgid "TEST: A Shell test string"
 msgstr "TILRAUN: Skeljartilraunastrengur"
diff --git a/t/t0200/test.c b/t/t0200/test.c
index 93373b3..82682dc 100644
--- a/t/t0200/test.c
+++ b/t/t0200/test.c
@@ -10,4 +10,10 @@ int main(void)
=20
 	/* TRANSLATORS: This is a test. You don't need to translate it. */
 	printf(_("TEST: A C test string %s"), "variable");
+
+	/* TRANSLATORS: This is a test. You don't need to translate it. */
+	printf(_("TEST: Hello World!"));
+
+	/* TRANSLATORS: This is a test. You don't need to translate it. */
+	printf(_("TEST: Old English Runes"));
 }
diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reenc=
ode-sanity.sh
new file mode 100755
index 0000000..3222e37
--- /dev/null
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+test_description=3D"Gettext reencoding of our *.po/*.mo files works"
+
+. ./lib-gettext.sh
+
+
+test_expect_success GETTEXT_LOCALE 'gettext: Emitting UTF-8 from our U=
TF-8 *.mo files / Icelandic' '
+    printf "TILRAUN: Hall=C3=B3 Heimur!" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: Hello World!=
" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success GETTEXT_LOCALE 'gettext: Emitting UTF-8 from our U=
TF-8 *.mo files / Runes' '
+    printf "TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=
=9A=A6 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=
=E1=9B=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=
=9A=E1=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=
=A6=E1=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=
=B9=E1=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=
=9A=AB" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: Old English =
Runes" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859-1 f=
rom our UTF-8 *.mo files / Icelandic' '
+    printf "TILRAUN: Hall=C3=B3 Heimur!" | iconv -f UTF-8 -t ISO8859-1=
 >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Hello Wo=
rld!" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859-1 f=
rom our UTF-8 *.mo files / Runes' '
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Old Engl=
ish Runes" >runes &&
+
+	if grep "^TEST: Old English Runes$" runes
+	then
+		say "Your system can not handle this complexity and returns the stri=
ng as-is"
+	else
+		# Both Solaris and GNU libintl will return this stream of
+		# question marks, so it is s probably portable enough
+		printf "TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? ??=
 ????" >runes-expect &&
+		test_cmp runes-expect runes
+	fi
+'
+
+test_done
--=20
1.7.2.2.536.g3f548
