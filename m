From: larsxschneider@gmail.com
Subject: [PATCH v5] git-p4: add config git-p4.pathEncoding
Date: Wed,  2 Sep 2015 22:39:15 +0200
Message-ID: <1441226355-61103-2-git-send-email-larsxschneider@gmail.com>
References: <1441226355-61103-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luke@diamand.org, gitster@pobox.com, tboegi@web.de,
	sunshine@sunshineco.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 02 22:39:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXEoX-0004c2-TL
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 22:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbbIBUjW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2015 16:39:22 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34472 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017AbbIBUjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 16:39:21 -0400
Received: by wicfx3 with SMTP id fx3so29750000wic.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZmBeoCvDJLzNpVXi+Mnco5BG9KkNRasGNXlRxQWIKms=;
        b=EXqPdCt5PrjoqTy9o9itMR5ZQbgOGS6OkOLuAcOrc4cU9Svh5rDmfYfCsPHOmU3DU3
         pSGxqjMypOOZ+66zlFzz/D1HjkC9WXw+huYJljwtXBX/WXlViI/djb52azK78ZTN1PAW
         sxaKbhNSZDAQwoBhyJbhs4x6w0RNEq4FcxxBbS1gfGp17oE23E0Yl42FN6r4jnRRhXyR
         dP4LJF2JwpY43/TenWvQi/kDZiJVOdLLX+RiYGTdBNkF2tTK1Si3plPwIoMLY34bFvik
         0APEA0lt+FWmsaHD63DZRhy09TQlpYrpgg3af5n8/fhiSkaAJVo1S9DQCaoP1RwsLJyL
         m3lQ==
X-Received: by 10.194.86.72 with SMTP id n8mr46180964wjz.119.1441226359778;
        Wed, 02 Sep 2015 13:39:19 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-188-106-110-072.188.106.pools.vodafone-ip.de. [188.106.110.72])
        by smtp.gmail.com with ESMTPSA id ny7sm5363001wic.11.2015.09.02.13.39.18
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 13:39:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
In-Reply-To: <1441226355-61103-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277123>

=46rom: Lars Schneider <larsxschneider@gmail.com>

Perforce keeps the encoding of a path as given by the originating OS.
Git expects paths encoded as UTF-8. Add a config to tell git-p4 what
encoding Perforce had used for the paths. This encoding is used to
transcode the paths to UTF-8. As an example, Perforce on Windows often
uses =E2=80=9Ccp1252=E2=80=9D to encode path names.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt        |  7 +++++
 git-p4.py                       | 11 ++++++++
 t/t9822-git-p4-path-encoding.sh | 60 +++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 78 insertions(+)
 create mode 100755 t/t9822-git-p4-path-encoding.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 82aa5d6..7b7a57d 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -510,6 +510,13 @@ git-p4.useClientSpec::
 	option '--use-client-spec'.  See the "CLIENT SPEC" section above.
 	This variable is a boolean, not the name of a p4 client.
=20
+git-p4.pathEncoding::
+	Perforce keeps the encoding of a path as given by the originating OS.
+	Git expects paths encoded as UTF-8. Use this config to tell git-p4=20
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
index 0000000..3646580
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
+		git config git-p4.pathEncoding iso8859-1 &&
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
