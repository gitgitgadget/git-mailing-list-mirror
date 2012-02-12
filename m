From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC] Auto detection in Makefile if msgfmt is not available
Date: Sun, 12 Feb 2012 13:42:24 +0100
Message-ID: <201202121342.25113.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: avarab@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 13:42:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwYlG-0007FC-NG
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 13:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab2BLMma convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Feb 2012 07:42:30 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:44117 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab2BLMm3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2012 07:42:29 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id 3B8071B112A15
	for <git@vger.kernel.org>; Sun, 12 Feb 2012 13:42:28 +0100 (CET)
Received: from maxi.localnet ([194.22.188.61]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MLP5m-1Rw0Wn3RqM-000HSt; Sun, 12 Feb 2012 13:42:27 +0100
X-Provags-ID: V02:K0:KGUjqPtysJ3sCXq4vj4VGHC3VmW69r0VqT6of24V7yy
 cghm+ty2CjkZmPNj5FLLRwlM+6FCT7Kqpx9PRSn8LLKsiv3/tc
 z5LtSBqNwyAPoJDmZFZus3rsiUtiopw2qID8PegC/oFPMpmpkq
 XyokbwegUYRQP0C9Qjs+62b5yZOAGpQCu6n/hFkSbzq7vkGqrr
 sjF0R44E1SMbW/NR6nIwg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190568>

Since commit 5e9637c629702e3d41ad01d95956d1835d7338e0
"i18n: add infrastructure for translating Git with gettext"
the Makefile demands the existance of msgfmt, unless NO_GETTEXT is defi=
ned.

This breaks the build on systems where msgfmt is not installed.

Added a simple auto-detection and switch to NO_GETTEXT when
msgfmt could not be found on the system

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 87fb30a..23e1e77 100644
--- a/Makefile
+++ b/Makefile
@@ -353,7 +353,11 @@ RPMBUILD =3D rpmbuild
 TCL_PATH =3D tclsh
 TCLTK_PATH =3D wish
 XGETTEXT =3D xgettext
-MSGFMT =3D msgfmt
+ifeq ($(shell msgfmt --help 2>/dev/null && echo y),y)
+	MSGFMT =3D msgfmt
+else
+	NO_GETTEXT=3DUnfortunatelyYes
+endif
 PTHREAD_LIBS =3D -lpthread
 PTHREAD_CFLAGS =3D
 GCOV =3D gcov
--=20
1.7.8.3.1.g75d1cf.dirty
