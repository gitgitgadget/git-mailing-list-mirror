From: tboegi@web.de
Subject: [PATCH v2 3/7] Allow core.autocrlf=input and core.eol=crlf
Date: Fri,  1 Apr 2016 18:08:26 +0200
Message-ID: <1459526906-19868-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 18:05:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am1Zm-0006Ma-4A
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 18:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbcDAQF1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2016 12:05:27 -0400
Received: from mout.web.de ([212.227.17.12]:50959 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbcDAQF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 12:05:26 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MRCrb-1aI91w2PGx-00Ueub; Fri, 01 Apr 2016 18:05:23
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:2oYWipInE+XPY4oy42+5XVjwDAZLM8nStu2phqZLQgWrZ7fok/s
 NH0T1OCxoNuCZOUWotMGtxy1YGOKb1324UHooru9AN962IdthyHUcl/Y4hB2ZbYJDXz7d4D
 lCa7E/a8S/Qe4aQJQ9mjnllon/CCMAKZt42DcMe0fnHVLsdcLe5NGLKsEoHDn/2s+6hWrrF
 zALiY+5mDkhkT6pOlVNPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4spB4Q8IwiI=:gf4ICZ38EmWuqVvK8wcpVc
 ttw4B7izA7ZlpgKIRTEFLIXOQNblzkfG2sd+tQLAkAcKiX3CIRLOsHwMnJhQhlnKOEjJwacZP
 lndE25ACneGwjY+/c4y3n31f1v0Ju1BafYG+IfscqriNkvt4aqN3tB7zdtfdiMrdftVzHbOU/
 /L65fQz6HJKJItNJhsvVkg8R93DgPIXjUOzUKPiMqoncbcNajSIELocniXHvdLHYpyannVRUU
 mE7wlyg1XlD5+uG8FcuQghlRxKbEvVjoiVZlpR6NsynF/X9rHrhNJoSFSsx28qNP4v1NTzrpS
 j4B+G3Q4Ec3lSRZZbWsDIajzHLIavnGTsWtgvNYYJQqxSegj0njmiOsAcFa7VHDmF0vQk9gHj
 g+Lot3FqFxuISBp4bUcx5pKblFdHq7EnCGqiJ5HfrxZ99rhlIPE5eIskx4g+lMW4wHeFTVck+
 MxGnGFCY5omo42zozG1GEb3RZZgn0DhBsuYXToL2zZKx3ZGIabt72WzUKNdzuS2ss0AoeOzY1
 tt/SQghc1vh8MQ07rWqgZgFnky2tfTv+8ZB6tA5W+S/2BSOJQWvNaivCg5jvbtsXogPAfD2/Y
 A6KkITK1OrCFzlfPK8rt54yGPFyR452Sb9Lstk5sNHG+O8ujt6P8vkj9igj8Q5Caksux2Kl/b
 bnyi9ViXa2hJLLUcMv3aqzQLrVfG9alinnBHKFl7wUDGB2EqRcBmxahsCP96A1SYLDs7whrbi
 PrvjexHHzZlORNgdVDIDSknsv9IpdKnaZLa48tUFbm7PupeOh1Z9YhObCyfyeg9o1+9D0Knr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290550>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Commit  942e77 "Add "core.eol" config variable" adds a condition to
the config parser: core.autocrlf=3Dinput is not allowed together with
core.eol=3Dcrlf.

This may lead to unnecessary problems, when config files are parsed:
A global config file sets core.autocrlf=3Dinput,
the repo local config file sets is own configuration: core.eol=3Dcrlf

There is no need to prevent combinations in config.c, in any case
core.autocrlf overrides core.eol.
Allow all combinations of core.crlf and core.eol and document
that core.autocrlf overrides core.eol.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Documentation/config.txt | 6 +++---
 config.c                 | 4 ----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..4a27ad4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -337,9 +337,9 @@ core.quotePath::
=20
 core.eol::
 	Sets the line ending type to use in the working directory for
-	files that have the `text` property set.  Alternatives are
-	'lf', 'crlf' and 'native', which uses the platform's native
-	line ending.  The default value is `native`.  See
+	files that have the `text` property set when core.autocrlf is false.
+	Alternatives are 'lf', 'crlf' and 'native', which uses the platform's
+	native line ending.  The default value is `native`.  See
 	linkgit:gitattributes[5] for more information on end-of-line
 	conversion.
=20
diff --git a/config.c b/config.c
index 9ba40bc..a6adc8b 100644
--- a/config.c
+++ b/config.c
@@ -803,8 +803,6 @@ static int git_default_core_config(const char *var,=
 const char *value)
=20
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
-			if (core_eol =3D=3D EOL_CRLF)
-				return error("core.autocrlf=3Dinput conflicts with core.eol=3Dcrlf=
");
 			auto_crlf =3D AUTO_CRLF_INPUT;
 			return 0;
 		}
@@ -830,8 +828,6 @@ static int git_default_core_config(const char *var,=
 const char *value)
 			core_eol =3D EOL_NATIVE;
 		else
 			core_eol =3D EOL_UNSET;
-		if (core_eol =3D=3D EOL_CRLF && auto_crlf =3D=3D AUTO_CRLF_INPUT)
-			return error("core.autocrlf=3Dinput conflicts with core.eol=3Dcrlf"=
);
 		return 0;
 	}
=20
--=20
2.8.0.rc2.2.g1a4d45a.dirty
