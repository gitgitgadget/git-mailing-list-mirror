From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 5/7] t/t4016-diff-quote: change from skip_all=* to prereq skip
Date: Tue, 10 Aug 2010 19:52:46 +0000
Message-ID: <1281469968-25670-6-git-send-email-avarab@gmail.com>
References: <1281469968-25670-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 21:54:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiutn-00009t-AO
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 21:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782Ab0HJTxo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 15:53:44 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58890 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796Ab0HJTxa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 15:53:30 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so13310538wwj.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 12:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=AyNp2KqDVQMfGgfgD+GZ7NiBhT2DuoD50F+U5twjVjo=;
        b=hxHaCZ8WSh3MQrD8VNFApoqSQ3JRVPyXac5OQkFsVY9I3gPs3Uh4xcj1UCFLeGseRO
         Leitb9f3rJICf15A418Pn3TZinzACffSuEbvoaMIp6roxEtJY/0hvg3wDTOhoyDUfMaZ
         jGFzbanL/n29pJ00fcZqmQ7OS5tyx62F4N3ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FmFs5hYLzTpfYnVZJZ9uPkEZ5hG2nNt3F+1spMiB/1tOXmerx+0pz7PnfA7b41sE6U
         qSL1LJw8Zxvm80UXHB0pG/jhuceBsr5J+M9C5Q5ovVoHpZyHHadOEsYj8fvBPxxJ6LZZ
         YrMfNsoGQ5eExClDxfIB8A5EeSRGBy1/FA81Y=
Received: by 10.227.142.201 with SMTP id r9mr15849576wbu.38.1281470010071;
        Tue, 10 Aug 2010 12:53:30 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p45sm3602981weq.21.2010.08.10.12.53.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 12:53:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gd03d
In-Reply-To: <1281469968-25670-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153149>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t4016-diff-quote.sh |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 34e5144..10e2db3 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -11,14 +11,16 @@ test_description=3D'Quoting paths in diff output.
 P0=3D'pathname'
 P1=3D'pathname	with HT'
 P2=3D'pathname with SP'
-P3=3D'pathname
+if P3=3D'pathname
 with LF'
-: 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1" || {
-	skip_all=3D'Your filesystem does not allow tabs in filenames, test sk=
ipped.'
-	test_done
-}
+: 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1"
+then
+	test_set_prereq TABS_IN_FILENAMES
+else
+	say 'Your filesystem does not allow tabs in filenames'
+fi
=20
-test_expect_success setup '
+test_expect_success TABS_IN_FILENAMES setup '
 	echo P0.0 >"$P0.0" &&
 	echo P0.1 >"$P0.1" &&
 	echo P0.2 >"$P0.2" &&
@@ -38,6 +40,7 @@ test_expect_success setup '
 	:
 '
=20
+test_expect_success TABS_IN_FILENAMES 'setup expected files' '
 cat >expect <<\EOF
  rename pathname.1 =3D> "Rpathname\twith HT.0" (100%)
  rename pathname.3 =3D> "Rpathname\nwith LF.0" (100%)
@@ -47,11 +50,14 @@ cat >expect <<\EOF
  rename pathname.0 =3D> Rpathname.0 (100%)
  rename "pathname\twith HT.0" =3D> Rpathname.1 (100%)
 EOF
-test_expect_success 'git diff --summary -M HEAD' '
+'
+
+test_expect_success TABS_IN_FILENAMES 'git diff --summary -M HEAD' '
 	git diff --summary -M HEAD >actual &&
 	test_cmp expect actual
 '
=20
+test_expect_success TABS_IN_FILENAMES 'setup expected files' '
 cat >expect <<\EOF
  pathname.1 =3D> "Rpathname\twith HT.0"            |    0
  pathname.3 =3D> "Rpathname\nwith LF.0"            |    0
@@ -62,7 +68,9 @@ cat >expect <<\EOF
  "pathname\twith HT.0" =3D> Rpathname.1            |    0
  7 files changed, 0 insertions(+), 0 deletions(-)
 EOF
-test_expect_success 'git diff --stat -M HEAD' '
+'
+
+test_expect_success TABS_IN_FILENAMES 'git diff --stat -M HEAD' '
 	git diff --stat -M HEAD >actual &&
 	test_cmp expect actual
 '
--=20
1.7.2.1.295.gd03d
