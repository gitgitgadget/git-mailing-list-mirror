From: larsxschneider@gmail.com
Subject: [PATCH v6] git-p4: add config git-p4.pathEncoding
Date: Thu,  3 Sep 2015 11:14:07 +0200
Message-ID: <1441271647-67824-2-git-send-email-larsxschneider@gmail.com>
References: <1441271647-67824-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luke@diamand.org, tboegi@web.de, sunshine@sunshineco.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 11:14:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXQbO-0008Pl-8B
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 11:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbbICJOQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 05:14:16 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38809 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbbICJOL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 05:14:11 -0400
Received: by wiclk2 with SMTP id lk2so584475wic.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sOuUIpN7Ryb/5BG3+BSulHQfNNIBELGlUmJ03LdxTMs=;
        b=vKvUVLsFNFfqll+ZEGqWhA00JOrXF88J7GZYD8jIVqoGLwYqAh6aEz1npxXp+NiC3A
         4d85C8pOOIfs83WwSv5+PFfeP99AIDZUf4E5Sboy2FRfTOWMV4l+G9kvTb33rWyitijz
         x6EPZrs++ea7FF0cWuLHrCbIQsO+KCytDvdg5xxyz+RyZQZsgcjRAM5/gFnMs/dU07Io
         J+0AYcCmOcSw7MTqiHgqgJWhdFd5kGl/ktSvFb4MZgJzVqjMYk6Un5L1qbtPCd0fPvhB
         rIvJ9N0dSpjY3kijG/xtDt3VL2WXdmYbNLp34bNt5CSGEfif1IgRysUoOTQASggaR844
         ZVPA==
X-Received: by 10.180.85.164 with SMTP id i4mr12874105wiz.54.1441271650045;
        Thu, 03 Sep 2015 02:14:10 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id h6sm7952474wiy.3.2015.09.03.02.14.09
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Sep 2015 02:14:09 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
In-Reply-To: <1441271647-67824-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277189>

=46rom: Lars Schneider <larsxschneider@gmail.com>

Perforce keeps the encoding of a path as given by the originating OS.
Git expects paths encoded as UTF-8. Add a config to tell git-p4 what
encoding Perforce had used for the paths. This encoding is used to
transcode the paths to UTF-8. As an example, Perforce on Windows often
uses =E2=80=9Ccp1252=E2=80=9D to encode path names.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Acked-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt        |  7 +++++
 git-p4.py                       | 11 ++++++++
 t/t9822-git-p4-path-encoding.sh | 60 +++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 78 insertions(+)
 create mode 100755 t/t9822-git-p4-path-encoding.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 82aa5d6..12a57d4 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -510,6 +510,13 @@ git-p4.useClientSpec::
 	option '--use-client-spec'.  See the "CLIENT SPEC" section above.
 	This variable is a boolean, not the name of a p4 client.
=20
+git-p4.pathEncoding::
+	Perforce keeps the encoding of a path as given by the originating OS.
+	Git expects paths encoded as UTF-8. Use this config to tell git-p4
+	what encoding Perforce had used for the paths. This encoding is used
+	to transcode the paths to UTF-8. As an example, Perforce on Windows
+	often uses =E2=80=9Ccp1252=E2=80=9D to encode path names.
+
 Submit variables
 ~~~~~~~~~~~~~~~~
 git-p4.detectRenames::
diff --git a/git-p4.py b/git-p4.py
index 073f87b..b1ad86d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2213,6 +2213,17 @@ class P4Sync(Command, P4UserMap):
             text =3D regexp.sub(r'$\1$', text)
             contents =3D [ text ]
=20
+        if gitConfig("git-p4.pathEncoding"):
+            relPath =3D relPath.decode(gitConfig("git-p4.pathEncoding"=
)).encode('utf8', 'replace')
+        elif self.verbose:
+            try:
+                relPath.decode('ascii')
+            except:
+                print (
+                    "Path with Non-ASCII characters detected and no pa=
th encoding defined. "
+                    "Please check the encoding: %s" % relPath
+                )
+
         self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
=20
         # total length...
diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-enco=
ding.sh
new file mode 100755
index 0000000..e507ad7
--- /dev/null
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description=3D'Clone repositories with non ASCII paths'
+
+. ./lib-git-p4.sh
+
+UTF8_ESCAPED=3D"a-\303\244_o-\303\266_u-\303\274.txt"
+ISO8859_ESCAPED=3D"a-\344_o-\366_u-\374.txt"
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'Create a repo containing iso8859-1 encoded paths'=
 '
+	(
+		cd "$cli" &&
+		ISO8859=3D"$(printf "$ISO8859_ESCAPED")" &&
+		echo content123 >"$ISO8859" &&
+		p4 add "$ISO8859" &&
+		p4 submit -d "test commit"
+	)
+'
+
+test_expect_success 'Clone repo containing iso8859-1 encoded paths wit=
hout git-p4.pathEncoding' '
+	git p4 clone --destination=3D"$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		UTF8=3D"$(printf "$UTF8_ESCAPED")" &&
+		echo $UTF8 >expect &&
+		git -c core.quotepath=3Dfalse ls-files >actual &&
+		test_must_fail test_cmp expect actual
+	)
+'
+
+test_expect_success 'Clone repo containing iso8859-1 encoded paths wit=
h git-p4.pathEncoding' '
+
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		test_config git-p4.pathEncoding iso8859-1 &&
+		git p4 clone --use-client-spec --destination=3D"$git" //depot &&
+		UTF8=3D"$(printf "$UTF8_ESCAPED")" &&
+		echo $UTF8 >expect &&
+		git -c core.quotepath=3Dfalse ls-files >actual &&
+		test_cmp expect actual &&
+		cat >expect <<-\EOF &&
+		content123
+		EOF
+		cat $UTF8 >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
--=20
1.9.5 (Apple Git-50.3)
